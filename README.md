
/* 目的: 让 self.helperObserver 与 self 产生关联, 从而达到释放self
objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
id object: 表示关联者，是一个对象，变量名理所当然也是object
const void *key :获取被关联者的索引key
id value: 被关联者，这里是一个block
objc_AssociationPolicy policy: 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
*/
