Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534BD3F8DEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbhHZShn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 14:37:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48022 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhHZShn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 14:37:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AD034201EB;
        Thu, 26 Aug 2021 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630003014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvBYgx2EKfzqnxdORFJp7zw0lpHgY2AIWvTQXA2riJ0=;
        b=pdHsGD4IkF9KzIVAjFpsNt3DPtEtyNSgaxkFiBXdvFqemIljcqEAgNgbZPDYUKflZWpFOu
        g3lkU2ECXvtUWE+MrDOazvfwLuOqq4ETVC0yurL2s4RttHs6Dgo0Ow5BmuqYkpKhQ9LYmz
        Mn+LEDXMOAyWhjGcPjmfDMkpB8aMdns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630003014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvBYgx2EKfzqnxdORFJp7zw0lpHgY2AIWvTQXA2riJ0=;
        b=0Fj5UAuP+nP7WFAXrtbx3ieMZZo8DlaeXGXInuyOp2xi2grP2BGn5vW7DJV6a8U8Q2AkE0
        DYU3KIJS949g4QBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A4449A3B8D;
        Thu, 26 Aug 2021 18:36:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 602EEDA7F3; Thu, 26 Aug 2021 20:34:06 +0200 (CEST)
Date:   Thu, 26 Aug 2021 20:34:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Fix the issues btrfs-convert don't
 recognition ext4  i_{a,c,a}time_extra
Message-ID: <20210826183406.GQ3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <1629824687-21014-1-git-send-email-zhanglikernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629824687-21014-1-git-send-email-zhanglikernel@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 25, 2021 at 01:04:47AM +0800, Li Zhang wrote:
> Hi, I ran convert-tests.sh, and it reported that the
> 019-ext4-copy-timestamps test failed. The log  is as
> follows
> 
> ...
> mount -o loop -t ext4 btrfs-progs/tests/test.img btrfs-progs/tests/mnt
> ====== RUN CHECK touch btrfs-progs/tests/mnt/file
> ====== RUN CHECK stat btrfs-progs/tests/mnt/file
> File: 'btrfs-progs/tests/mnt/file'
> Size: 0           Blocks: 0          IO Block: 4096   regular empty file
> Device: 700h/1792d  Inode: 13          Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: unconfined_u:object_r:unlabeled_t:s0
> Access: 2021-08-24 22:10:21.999209679 +0800
> Modify: 2021-08-24 22:10:21.999209679 +0800
> Change: 2021-08-24 22:10:21.999209679 +0800
> ...
> btrfs-progs/btrfs-convert btrfs-progs/tests/test.img
> ...
> ====== RUN CHECK mount -t btrfs -o loop btrfs-progs/tests/test.img btrfs-progs/tests/mnt
> ====== RUN CHECK stat btrfs-progs/tests/mnt/file
> File: 'btrfs-progs/tests/mnt/file'
> Size: 0           Blocks: 0          IO Block: 4096   regular empty file
> Device: 2ch/44d Inode: 267         Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: unconfined_u:object_r:unlabeled_t:s0
> Access: 2021-08-24 22:10:21.000000000 +0800
> Modify: 2021-08-24 22:10:21.000000000 +0800
> Change: 2021-08-24 22:10:21.000000000 +0800
> ...
> atime on converted inode does not match
> test failed for case 019-ext4-copy-timestamps
> 
> Obviously, the log says that btrfs-convert does not
> support nanoseconds. I looked at the source code and
> found that only if ext2_fs.h defines EXT4_EPOCH_MASK
> btrfs-convert to support nanoseconds. But in e2fsprogs,
> EXT4_EPOCH_MASK was introduced in v1.43, but in some
> older versions, such as v1.40, e2fsprogs actually
> supports nanoseconds. It seems that if struct ext2_inode_large
> contains the i_atime_extra member, ext4 is supports
> nanoseconds, so I updated the logic to determine whether the
> current ext4 file system supports nanosecond precision.
> In addition, I imported some definitions to encode and
> decode tv_nsec (copied from e2fsprogs source code).

So it's supportable even up to the old versions (1.40 was released in
2007) with the updated detection, nice.

> ---
>  configure.ac | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c4fa461..20297c5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -253,7 +253,21 @@ AX_CHECK_DEFINE([linux/fiemap.h], [FIEMAP_EXTENT_SHARED], [],
>  AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
>  		[AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
>  			   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
> -		[AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, no 64bit time precision of converted images])])
> +        [have_ext4_epoch_mask_define=no])
> +
> +AS_IF([test "x$have_ext4_epoch_mask_define" = xno], [
> +    AC_CHECK_MEMBERS([struct ext2_inode_large.i_atime_extra],
> +        [
> +            AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1], [Define to 1 if ext2_inode_large includes i_atime_extra]),
> +            AC_DEFINE([EXT4_EPOCH_BITS], [2],[for encode and decode tv_nsec in ext2 inode]),
> +            AC_DEFINE([EXT4_EPOCH_MASK], [((1 << EXT4_EPOCH_BITS) - 1)], [For encode and decode tv_nsec info in ext2 inode]),
> +            AC_DEFINE([EXT4_NSEC_MASK],  [(~0UL << EXT4_EPOCH_BITS)], [For encode and decode tv_nsec info in ext2 inode]),
> +            AC_DEFINE([inode_includes(size, field)],[m4_normalize[(size >= (sizeof(((struct ext2_inode_large *)0)->field) + offsetof(struct ext2_inode_large, field)))]],

The "," can't be at the end of the AC_DEFINE lines, this does not
produce valid ./configure and fails with

checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes                                        
checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes                                           
checking for struct ext2_inode_large.i_atime_extra... yes     
./configure: line 6487: ,: command not found         
./configure: line 6490: ,: command not found        
./configure: line 6493: ,: command not found                                                              
./configure: line 6496: ,: command not found

because the "," appear in the final file as separate commands. Removing them
produces valid script and the detection works.

Added to devel, thanks.
