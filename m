Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83D49ABC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 06:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358789AbiAYFX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 00:23:57 -0500
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:60769 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391271AbiAYFE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 00:04:28 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0501935|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.000906865-0.000123243-0.99897;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Mi.KBBo_1643087066;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Mi.KBBo_1643087066)
          by smtp.aliyun-inc.com(10.147.44.118);
          Tue, 25 Jan 2022 13:04:26 +0800
Date:   Tue, 25 Jan 2022 13:04:30 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     trix@redhat.com
Subject: Re: [PATCH] btrfs: initialize variable cancel
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20220121134522.832207-1-trix@redhat.com>
References: <20220121134522.832207-1-trix@redhat.com>
Message-Id: <20220125130429.75C1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Mabye we should enable '-Wmaybe-uninitialized' for btrfs 'make W=1'.

There is another warning  reproted by '-Wmaybe-uninitialized' 
in btrfs misc-next.

fs/btrfs/zoned.c:273:28: warning: ¡®zno¡¯ may be used uninitialized in this function [-Wmaybe-uninitialized]
   memcpy(zinfo->zone_cache + zno, zones,
                            ^

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index cec88a6..f1052ce 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -2,6 +2,7 @@
 
 # Subset of W=1 warnings
 subdir-ccflags-y += -Wextra -Wunused -Wno-unused-parameter
+subdir-ccflags-y += -Wmaybe-uninitialized
 subdir-ccflags-y += -Wmissing-declarations
 subdir-ccflags-y += -Wmissing-format-attribute
 subdir-ccflags-y += -Wmissing-prototypes

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/01/25

> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this problem
> ioctl.c:3333:8: warning: 3rd function call argument is an
>   uninitialized value
>     ret = exclop_start_or_cancel_reloc(fs_info,
> 
> cancel is only set in one branch of an if-check and is
> always used.  So initialize to false.
> 
> Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  fs/btrfs/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 190ad8af4f45a..26e82379747f8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3308,7 +3308,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>  	struct block_device *bdev = NULL;
>  	fmode_t mode;
>  	int ret;
> -	bool cancel;
> +	bool cancel = false;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> -- 
> 2.26.3


