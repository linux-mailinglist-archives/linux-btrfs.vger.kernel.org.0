Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE33FA3BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Aug 2021 06:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhH1EmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 00:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhH1EmQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 00:42:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0553C0613D9
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 21:41:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oa17so5991436pjb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0P50Ke7vmb4GI+rs245tXOucRQ58N6FLviR/38RbTUg=;
        b=HFie+kbTLmb+HCmulgVQA+4qvlJzIolslZHH4xOe9KOVZfyyjZcHUMa4pohnUJ3nKj
         yUTrpbPibgzfCB1m9Jm/yRKIJZ3UIm4eo1pxfVbM/DHN1/LfQEoqT1PPqOSQIsYT+As3
         iQAhMiREZHhInu8B0C6IyrcNdkmg9eKL+ahO8jjrwIPeZESoUH+tq881jk6HVapo3TwY
         xRkVPI3hHjOR8arHf1bFa3gLnreROwW1HMfWlbgzxH8ALz9WdNv+AT20q+LHNe6ePPqQ
         Ct08R8dBHvBBs7Fm5jqrrb6Gac2ED0G/1zc8UrbPQ+hY4Jn092LpYZFAe5s0SelTwFZ5
         HVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0P50Ke7vmb4GI+rs245tXOucRQ58N6FLviR/38RbTUg=;
        b=q4BeZF7K/tJ2wzaeKjmdgVelDizZbUchYBXx6WXM/KYhRz26kPYWOz5YhMNjEUSe0s
         sW2n1lV1TcB9OtZI8F5ZSzsFHHXdRz4DeKlwHV8vJ3uBIFp1oVbjuik6be7wsA4sZSBO
         p/hJxRRQ9I0PrKpgR/5EhJMsW+T4V6TRpUy9fpgbvhH6O+sbyGiEMje1pizEevhnJZYw
         Lhx6YonnNM0CzOGaptTYbwOjNapR9fb0o40BGhyt5UwTBGPW48UG76bu3uUIvdj14H3L
         VYhpiUEETIUQT/9jiirvhVeR5VR8T1VjVsdvSylN/IwElxWcbmDTYTJbe+shNUoR/mna
         SNOQ==
X-Gm-Message-State: AOAM530Ycrb6R2EaNjlwJTb1enLlh1HWZZRE1kzT10i/WHFlTjI8hwqj
        IjKlhx1ROD38IHDOYpPGV5U=
X-Google-Smtp-Source: ABdhPJzxLw7GsSLjxlh7zcn2fJApBHNzYw2GoRuDts7oybt1SJnFQyo61qBmgU81HrmpcUKB9ikPmg==
X-Received: by 2002:a17:90a:8e:: with SMTP id a14mr14717908pja.66.1630125685248;
        Fri, 27 Aug 2021 21:41:25 -0700 (PDT)
Received: from localhost.localdomain ([219.137.143.41])
        by smtp.gmail.com with ESMTPSA id y21sm7593536pfm.52.2021.08.27.21.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 21:41:24 -0700 (PDT)
Date:   Sat, 28 Aug 2021 12:41:19 +0800
From:   li zhang <zhanglikernel@gmail.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Fix the issues btrfs-convert don't
 recognition ext4  i_{a,c,a}time_extra
Message-ID: <20210828044117.GA29273@localhost.localdomain>
References: <1629824687-21014-1-git-send-email-zhanglikernel@gmail.com>
 <20210826183406.GQ3379@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826183406.GQ3379@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 08:34:06PM +0200, David Sterba wrote:
> On Wed, Aug 25, 2021 at 01:04:47AM +0800, Li Zhang wrote:
> > Hi, I ran convert-tests.sh, and it reported that the
> > 019-ext4-copy-timestamps test failed. The log  is as
> > follows
> > 
> > ...
> > mount -o loop -t ext4 btrfs-progs/tests/test.img btrfs-progs/tests/mnt
> > ====== RUN CHECK touch btrfs-progs/tests/mnt/file
> > ====== RUN CHECK stat btrfs-progs/tests/mnt/file
> > File: 'btrfs-progs/tests/mnt/file'
> > Size: 0           Blocks: 0          IO Block: 4096   regular empty file
> > Device: 700h/1792d  Inode: 13          Links: 1
> > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> > Context: unconfined_u:object_r:unlabeled_t:s0
> > Access: 2021-08-24 22:10:21.999209679 +0800
> > Modify: 2021-08-24 22:10:21.999209679 +0800
> > Change: 2021-08-24 22:10:21.999209679 +0800
> > ...
> > btrfs-progs/btrfs-convert btrfs-progs/tests/test.img
> > ...
> > ====== RUN CHECK mount -t btrfs -o loop btrfs-progs/tests/test.img btrfs-progs/tests/mnt
> > ====== RUN CHECK stat btrfs-progs/tests/mnt/file
> > File: 'btrfs-progs/tests/mnt/file'
> > Size: 0           Blocks: 0          IO Block: 4096   regular empty file
> > Device: 2ch/44d Inode: 267         Links: 1
> > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> > Context: unconfined_u:object_r:unlabeled_t:s0
> > Access: 2021-08-24 22:10:21.000000000 +0800
> > Modify: 2021-08-24 22:10:21.000000000 +0800
> > Change: 2021-08-24 22:10:21.000000000 +0800
> > ...
> > atime on converted inode does not match
> > test failed for case 019-ext4-copy-timestamps
> > 
> > Obviously, the log says that btrfs-convert does not
> > support nanoseconds. I looked at the source code and
> > found that only if ext2_fs.h defines EXT4_EPOCH_MASK
> > btrfs-convert to support nanoseconds. But in e2fsprogs,
> > EXT4_EPOCH_MASK was introduced in v1.43, but in some
> > older versions, such as v1.40, e2fsprogs actually
> > supports nanoseconds. It seems that if struct ext2_inode_large
> > contains the i_atime_extra member, ext4 is supports
> > nanoseconds, so I updated the logic to determine whether the
> > current ext4 file system supports nanosecond precision.
> > In addition, I imported some definitions to encode and
> > decode tv_nsec (copied from e2fsprogs source code).
> 
> So it's supportable even up to the old versions (1.40 was released in
> 2007) with the updated detection, nice.
> 
> > ---
> >  configure.ac | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index c4fa461..20297c5 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -253,7 +253,21 @@ AX_CHECK_DEFINE([linux/fiemap.h], [FIEMAP_EXTENT_SHARED], [],
> >  AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
> >  		[AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
> >  			   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
> > -		[AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, no 64bit time precision of converted images])])
> > +        [have_ext4_epoch_mask_define=no])
> > +
> > +AS_IF([test "x$have_ext4_epoch_mask_define" = xno], [
> > +    AC_CHECK_MEMBERS([struct ext2_inode_large.i_atime_extra],
> > +        [
> > +            AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1], [Define to 1 if ext2_inode_large includes i_atime_extra]),
> > +            AC_DEFINE([EXT4_EPOCH_BITS], [2],[for encode and decode tv_nsec in ext2 inode]),
> > +            AC_DEFINE([EXT4_EPOCH_MASK], [((1 << EXT4_EPOCH_BITS) - 1)], [For encode and decode tv_nsec info in ext2 inode]),
> > +            AC_DEFINE([EXT4_NSEC_MASK],  [(~0UL << EXT4_EPOCH_BITS)], [For encode and decode tv_nsec info in ext2 inode]),
> > +            AC_DEFINE([inode_includes(size, field)],[m4_normalize[(size >= (sizeof(((struct ext2_inode_large *)0)->field) + offsetof(struct ext2_inode_large, field)))]],
> 
> The "," can't be at the end of the AC_DEFINE lines, this does not
> produce valid ./configure and fails with
> 
> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes                                        
> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes                                           
> checking for struct ext2_inode_large.i_atime_extra... yes     
> ./configure: line 6487: ,: command not found         
> ./configure: line 6490: ,: command not found        
> ./configure: line 6493: ,: command not found                                                              
> ./configure: line 6496: ,: command not found
> 
> because the "," appear in the final file as separate commands. Removing them
> produces valid script and the detection works.
> 
> Added to devel, thanks.

Cool, thanks!

Is there any possibility that the version of the GNU build system caused
the ./configure error
to be generated? On my machine, I produced a valid ./configure, and my
compilation
environment is as follows:
aclocal:    aclocal (GNU automake) 1.13.4
autoconf:   autoconf (GNU Autoconf) 2.69
autoheader: autoheader (GNU Autoconf) 2.69
automake:   automake (GNU automake) 1.13.4
OS: centos 7.6
