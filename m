Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203E95B559B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiILH6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiILH6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 03:58:43 -0400
Received: from out20-219.mail.aliyun.com (out20-219.mail.aliyun.com [115.124.20.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE102C128
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 00:58:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04652883|-1;BR=01201311R191S84rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.000883908-4.96713e-05-0.999066;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PDdX3Ax_1662969518;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PDdX3Ax_1662969518)
          by smtp.aliyun-inc.com;
          Mon, 12 Sep 2022 15:58:38 +0800
Date:   Mon, 12 Sep 2022 15:58:47 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fi resize: fix return value check_resize_args()
Cc:     Sidong Yang <realwakka@gmail.com>
In-Reply-To: <20220811152239.2845-1-realwakka@gmail.com>
References: <20220811152239.2845-1-realwakka@gmail.com>
Message-Id: <20220912155843.F86F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> check_resize_args() function checks user argument amount and should
> returns it's validity. But now the code returns only zero. This patch
> make it correct to return ret.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  cmds/filesystem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 7cd08fcd..9eff5680 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1203,7 +1203,7 @@ static int check_resize_args(const char *amount, const char *path) {
>  
>  out:
>  	free(di_args);
> -	return 0;
> +	return ret;
>  }
>  
>  static int cmd_filesystem_resize(const struct cmd_struct *cmd,

This patch will make 'btrfs filesystem resize' always fail, and then break
fstests btrfs/177.

# df -h /mnt/scratch/
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb2       1.0G  3.4M  927M   1% /mnt/scratch

# btrfs filesystem resize 3G /mnt/scratch/
Resize device id 1 (/dev/sdb2) from 3.00GiB to 3.00GiB
# echo $?
1

# df -h /mnt/scratch/
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb2       1.0G  3.4M  927M   1% /mnt/scratch


'ret' is set to 2 here.
    ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
    if (strlen(amount) != ret) {
        error("newsize argument is too long");
        ret = 1;
        goto out;
    }

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/12


