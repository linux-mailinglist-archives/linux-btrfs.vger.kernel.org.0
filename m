Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D944606C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 09:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhKEIIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 04:08:22 -0400
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:46882 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhKEIIT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 04:08:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436328|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0029741-2.47094e-05-0.997001;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LnxfOxi_1636099537;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LnxfOxi_1636099537)
          by smtp.aliyun-inc.com(10.147.41.199);
          Fri, 05 Nov 2021 16:05:37 +0800
Date:   Fri, 05 Nov 2021 16:05:41 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Sidong Yang <realwakka@gmail.com>
Subject: Re: [PATCH v2] btrfs-progs: balance: print warn mesg in old command
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <20211031131011.42401-1-realwakka@gmail.com>
References: <20211031131011.42401-1-realwakka@gmail.com>
Message-Id: <20211105160541.ED15.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This patch broken tests/cli-tests/002-balance-full-no-filters.

becasue this
	printf("WARNING:\n\n");
        printf("\tFull balance without filters requested. This operation is very\n");
is put after fork() in this patch when '--backgroud';

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/11/05

> This patch makes old balance command to print warning message same as
> in start command. It makes do_balance() checks flags that needs to
> print warning message. It works in old command because old command also
> uses do_balance().
> 
> Issue: #411
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
>  - Prints warning message in do_balance()
> ---
>  cmds/balance.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/cmds/balance.c b/cmds/balance.c
> index 7abc69d9..2e903b5c 100644
> --- a/cmds/balance.c
> +++ b/cmds/balance.c
> @@ -322,6 +322,24 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
>  		return 1;
>  	}
>  
> +	if (!(flags & BALANCE_START_FILTERS) && !(flags & BALANCE_START_NOWARN)) {
> +		int delay = 10;
> +
> +		printf("WARNING:\n\n");
> +		printf("\tFull balance without filters requested. This operation is very\n");
> +		printf("\tintense and takes potentially very long. It is recommended to\n");
> +		printf("\tuse the balance filters to narrow down the scope of balance.\n");
> +		printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
> +		printf("\twarning. The operation will start in %d seconds.\n", delay);
> +		printf("\tUse Ctrl-C to stop it.\n");
> +		while (delay) {
> +			printf("%2d", delay--);
> +			fflush(stdout);
> +			sleep(1);
> +		}
> +		printf("\nStarting balance without any filters.\n");
> +	}
> +
>  	ret = ioctl(fd, BTRFS_IOC_BALANCE_V2, args);
>  	if (ret < 0) {
>  		/*
> @@ -547,24 +565,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
>  		printf("\nStarting conversion to RAID5/6.\n");
>  	}
>  
> -	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_START_NOWARN)) {
> -		int delay = 10;
> -
> -		printf("WARNING:\n\n");
> -		printf("\tFull balance without filters requested. This operation is very\n");
> -		printf("\tintense and takes potentially very long. It is recommended to\n");
> -		printf("\tuse the balance filters to narrow down the scope of balance.\n");
> -		printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
> -		printf("\twarning. The operation will start in %d seconds.\n", delay);
> -		printf("\tUse Ctrl-C to stop it.\n");
> -		while (delay) {
> -			printf("%2d", delay--);
> -			fflush(stdout);
> -			sleep(1);
> -		}
> -		printf("\nStarting balance without any filters.\n");
> -	}
> -
>  	if (force)
>  		args.flags |= BTRFS_BALANCE_FORCE;
>  	if (bconf.verbose > BTRFS_BCONF_QUIET)
> -- 
> 2.25.1


