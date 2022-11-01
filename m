Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E954614295
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 02:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKABFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 21:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKABFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 21:05:19 -0400
Received: from out20-207.mail.aliyun.com (out20-207.mail.aliyun.com [115.124.20.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B611140
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 18:05:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.04436311|-1;BR=01201311R241ec;CH=blue;DM=|CONTINUE|false|;DS=SPAM|spam_ad|0.884714-1.69432e-05-0.115269;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Py7.m9r_1667264691;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Py7.m9r_1667264691)
          by smtp.aliyun-inc.com;
          Tue, 01 Nov 2022 09:04:52 +0800
Date:   Tue, 01 Nov 2022 09:04:53 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: fix lost file sync on direct IO write with nowait and dsync iocb
In-Reply-To: <20221101084953.50DF.409509F4@e16-tech.com>
References: <84cb2eb28538c98cbde50e83a770de476528a4f1.1667215075.git.fdmanana@suse.com> <20221101084953.50DF.409509F4@e16-tech.com>
Message-Id: <20221101090450.50E3.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Hi,
> 
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > When doing a direct IO write using a iocb with nowait and dsync set, we
> > end up not syncing the file once the write completes.
> > 
> > This is because we tell iomap to not call generic_write_sync(), which
> > would result in calling btrfs_sync_file(), in order to avoid a deadlock
> > since iomap can call it while we are holding the inode's lock and
> > btrfs_sync_file() needs to acquire the inode's lock. The deadlock happens
> > only if the write happens synchronously, when iomap_dio_rw() calls
> > iomap_dio_complete() before it returns. Instead we do the sync ourselves
> > at btrfs_do_write_iter().
> > 
> > For a nowait write however we can end up not doing the sync ourselves at
> > at btrfs_do_write_iter() because the write could have been queued, and
> > therefore we get -EIOCBQUEUED returned from iomap in such case. That makes
> > us skip the sync call at btrfs_do_write_iter(), as we don't do it for
> > any error returned from btrfs_direct_write(). We can't simply do the call
> > even if -EIOCBQUEUED is returned, since that would block the task waiting
> > for IO, both for the data since there are bios still in progress as well
> > as potentially blocking when joining a log transaction and when syncing
> > the log (writing log trees, super blocks, etc).
> > 
> > So let iomap do the sync call itself and in order to avoid deadlocks for
> > the case of synchronous writes (without nowait), use __iomap_dio_rw() and
> > have ourselves call iomap_dio_complete() after unlocking the inode.
> > 
> > A test case will later be sent for fstests, after this is fixed in Linus'
> > tree.
> > 
> > Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> > Reported-by: ���ѧ�� �����֧ߧҧ֧�� <socketpair@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com/
> > CC: stable@vger.kernel.org # 6.0+
> 
> The test script provided by ���ѧ�� �����֧ߧҧ֧�� <socketpair@gmail.com>
> show a normal result on 6.1.0-rc3+ with this patch.
> 
> but the test script provided by ���ѧ�� �����֧ߧҧ֧�� show that
> there is a problem in 5.15.y too. we need a different fix for 5.15.y?

a dirty fix will let the test script provided by ���ѧ�� �����֧ߧҧ�
show a normal result on 5.15.y. but I don't know whether this dirty fix
is right.

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bd05a8f..42b2d20 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2109,7 +2109,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,

        btrfs_set_inode_last_sub_trans(inode);

-       if (num_written > 0)
+       if (num_written > 0 || sync)
                num_written = generic_write_sync(iocb, num_written);

        if (sync)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/11/01

> 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/btrfs_inode.h |  5 ++++-
> >  fs/btrfs/file.c        | 22 ++++++++++++++++------
> >  fs/btrfs/inode.c       | 14 +++++++++++---
> >  3 files changed, 31 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index 79a9f06c2434..d21c30bf7053 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -526,7 +526,10 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
> >  ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> >  			       const struct btrfs_ioctl_encoded_io_args *encoded);
> >  
> > -ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_before);
> > +ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
> > +		       size_t done_before);
> > +struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > +				  size_t done_before);
> >  
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >  
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 838b3c0ea329..6e2889bc73d8 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1453,6 +1453,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  	loff_t endbyte;
> >  	ssize_t err;
> >  	unsigned int ilock_flags = 0;
> > +	struct iomap_dio *dio;
> >  
> >  	if (iocb->ki_flags & IOCB_NOWAIT)
> >  		ilock_flags |= BTRFS_ILOCK_TRY;
> > @@ -1513,11 +1514,22 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  	 * So here we disable page faults in the iov_iter and then retry if we
> >  	 * got -EFAULT, faulting in the pages before the retry.
> >  	 */
> > -again:
> >  	from->nofault = true;
> > -	err = btrfs_dio_rw(iocb, from, written);
> > +	dio = btrfs_dio_write(iocb, from, written);
> >  	from->nofault = false;
> >  
> > +	/*
> > +	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
> > +	 * iocb, and that needs to lock the inode. So unlock it before calling
> > +	 * iomap_dio_complete() to avoid a deadlock.
> > +	 */
> > +	btrfs_inode_unlock(inode, ilock_flags);
> > +
> > +	if (IS_ERR_OR_NULL(dio))
> > +		err = PTR_ERR_OR_ZERO(dio);
> > +	else
> > +		err = iomap_dio_complete(dio);
> > +
> >  	/* No increment (+=) because iomap returns a cumulative value. */
> >  	if (err > 0)
> >  		written = err;
> > @@ -1543,12 +1555,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  		} else {
> >  			fault_in_iov_iter_readable(from, left);
> >  			prev_left = left;
> > -			goto again;
> > +			goto relock;
> >  		}
> >  	}
> >  
> > -	btrfs_inode_unlock(inode, ilock_flags);
> > -
> >  	/*
> >  	 * If 'err' is -ENOTBLK or we have not written all data, then it means
> >  	 * we must fallback to buffered IO.
> > @@ -3752,7 +3762,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
> >  	 */
> >  	pagefault_disable();
> >  	to->nofault = true;
> > -	ret = btrfs_dio_rw(iocb, to, read);
> > +	ret = btrfs_dio_read(iocb, to, read);
> >  	to->nofault = false;
> >  	pagefault_enable();
> >  
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index fd26282edace..b1e7bfd5f525 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -8176,13 +8176,21 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
> >  	.bio_set		= &btrfs_dio_bioset,
> >  };
> >  
> > -ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
> > +ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
> >  {
> >  	struct btrfs_dio_data data;
> >  
> >  	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> > -			    IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC,
> > -			    &data, done_before);
> > +			    IOMAP_DIO_PARTIAL, &data, done_before);
> > +}
> > +
> > +struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> > +				  size_t done_before)
> > +{
> > +	struct btrfs_dio_data data;
> > +
> > +	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> > +			    IOMAP_DIO_PARTIAL, &data, done_before);
> >  }
> >  
> >  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > -- 
> > 2.35.1
> 


