Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758DB37169F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhECO25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 10:28:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhECO25 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 10:28:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4699CAFCC;
        Mon,  3 May 2021 14:28:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45C20DA7A1; Mon,  3 May 2021 16:25:36 +0200 (CEST)
Date:   Mon, 3 May 2021 16:25:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     dsterba@suse.cz, Tian Tao <tiantao6@hisilicon.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: delete unneeded assignments in btrfs_defrag_file
Message-ID: <20210503142536.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, "tiantao (H)" <tiantao6@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1619488221-29490-1-git-send-email-tiantao6@hisilicon.com>
 <20210428180243.GS7604@twin.jikos.cz>
 <0c116d82-3334-ed4e-fb69-76c1c6c8343a@huawei.com>
 <20210429132233.GV7604@twin.jikos.cz>
 <64eef0c6-4353-7738-124a-8ddfe4edda66@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64eef0c6-4353-7738-124a-8ddfe4edda66@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 09:27:21AM +0800, tiantao (H) wrote:
> 
> 在 2021/4/29 21:22, David Sterba 写道:
> > On Thu, Apr 29, 2021 at 09:16:53AM +0800, tiantao (H) wrote:
> >> 在 2021/4/29 2:02, David Sterba 写道:
> >>> On Tue, Apr 27, 2021 at 09:50:21AM +0800, Tian Tao wrote:
> >>>> ret is assigned -EAGAIN at line 1455 and then reassigned defrag_count
> >>>> at line 1547 after exiting the while loop, but the btrfs_defrag_file
> >>>> function returns a negative number indicating that the execution failed
> >>>> because it does not make sense to reassign defrag_count to ret, so
> >>>> delete it.
> >>> The line references are fragile, so the 1455 is after defrag is
> >>> cancelled.
> >>>
> >>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> >>>> ---
> >>>>    fs/btrfs/ioctl.c | 2 --
> >>>>    1 file changed, 2 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >>>> index ee1dbab..2b3b228 100644
> >>>> --- a/fs/btrfs/ioctl.c
> >>>> +++ b/fs/btrfs/ioctl.c
> >>>> @@ -1544,8 +1544,6 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
> >>>>    		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> >>>>    	}
> >>>>    
> >>>> -	ret = defrag_count;
> >>> But this would change semantics of the whole function, after deleting
> >>> this line any stale value of 'ret' would be returned, it's used for some
> >>> intermediate return values in the whole while loop.
> >>>
> >>> 1597                 if (btrfs_defrag_cancelled(fs_info)) {
> >>> 1598                         btrfs_debug(fs_info, "defrag_file cancelled");
> >>> 1599                         ret = -EAGAIN;
> >>> 1600                         break;
> >>> 1601                 }
> >>>
> >>> Jumping to the 'out_ra' label looks like a candidate fix but that also
> >>> jumps around all the incompat bit setting, so that could in some cases
> >>> miss to set them properly. And actually this is a problem with all the
> >>> other error cases.
> >>>
> >>> I'm not yet sure what's the proper fix, but the errors from within the
> >>> while loop should be returned and incompat bits set.
> >> How does the following change look?
> >>
> >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >> index ee1dbab..b8e496e 100644
> >> --- a/fs/btrfs/ioctl.c
> >> +++ b/fs/btrfs/ioctl.c
> >> @@ -1453,7 +1453,7 @@ int btrfs_defrag_file(struct inode *inode, struct
> >> file *file,
> >>                   if (btrfs_defrag_cancelled(fs_info)) {
> >>                           btrfs_debug(fs_info, "defrag_file cancelled");
> >>                           ret = -EAGAIN;
> >> -                       break;
> >> +                      goto error;
> >>                   }
> >>
> >>                   if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
> >> @@ -1531,6 +1531,9 @@ int btrfs_defrag_file(struct inode *inode, struct
> >> file *file,
> >>                   }
> >>           }
> >>
> >> +       ret = defrag_count;
> >> +
> >> +error:
> >>           if ((range->flags & BTRFS_DEFRAG_RANGE_START_IO)) {
> >>                   filemap_flush(inode->i_mapping);
> >>                   if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> >> @@ -1544,8 +1547,6 @@ int btrfs_defrag_file(struct inode *inode, struct
> >> file *file,
> >>                   btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> >>           }
> >>
> >> -       ret = defrag_count;
> >> -
> >>    out_ra:
> >>           if (do_compress) {
> >>                   btrfs_inode_lock(inode, 0);
> > Yes that looks like covering all the issues. One more thing is the change on
> > the userspace where the cancelled defrag returns non-error, but now it would be
> > EAGAIN. So far I haven't found anything that would go wrong, all errors
> > are reported and the whole defrag loop continues. Pressing ctrl-c should
> > cancel it completely.
> > .
> Would you give ack-by if v2 was sent according to this code above?

Yes, thanks.
