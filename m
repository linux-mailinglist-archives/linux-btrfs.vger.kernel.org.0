Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128EF440DF7
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Oct 2021 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhJaLax (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Oct 2021 07:30:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:57411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJaLax (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Oct 2021 07:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635679700;
        bh=StxYOTpdCHE/iyGWXn0AhawQspGBKBM6tQ0m03BD30I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=bw1YuLYBOz6dyG6Qu5eG2x3tm/fZBq5yhb5CCAQeyXmfjEQQ/N1rzaSBcoxHjyCNm
         hbTvXhnjpBpVwEYbjX1KKXDSyQowl+ho7k2yitQ9ZOwvx/Vldv2VACb7E1oDlNO7ry
         TJL8PLOMeJGU9cGiTTY+8vOryw4wY4adPz2T6H8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkYXm-1n3miz2uFy-00m4aB; Sun, 31
 Oct 2021 12:28:20 +0100
Message-ID: <d084bb90-72e5-0d7f-b89d-7334fc45de28@gmx.com>
Date:   Sun, 31 Oct 2021 19:28:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] btrfs-progs: balance: print warn mesg in old command
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211031022152.41730-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211031022152.41730-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YFhq04yGRFyablJ9fB8X9yTZ+GggiVGes2a+vDdlgEUOqiP3ge7
 cPWz/0LweOURVDGIEzszL0X0XkwGkacn+WN6HaaM5M1ock1qnbnarzXCgAWjSHeV2oGSr4V
 LJzCSiNayHBUrlE1dLbQtJ0RHZcDmuChU8T7eY4wIeK8OfMC5a6q50z9NRHCm9rqkHzamrl
 S49RauHP71lGba9VjytXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sJBOBIRqCy0=:nxuZVQ/k+QTy33hSOWh5aV
 YSZ/d01QZLXerQC19Oj0J9o8rYNzWsyXMVHVgjfAd3w2DHEIiaMYhbf5GncAnKP0UQj7fwuuk
 NsyNutvJAzmgOeRE/BRblmj0u6mj4C2Z2BsKXIwpuCNceWiAC6S5Ziz7iVjRLy4gxpehmNy3F
 lhoqAUkPSwwZNj8dcQBnZ+r960SsqYflSGjx0qtTbfxzksa8kJcCeZqRGIXDsNYzZBZCwiMjn
 RPT24xdX3rh8vAV82ZFEiO7e6feDqNfKacbU4jDCkfQ4vRt8IPZdii8HE9HscaLuwsMzapOkQ
 EmN2kd0HdZ5pYzU1Hcp9EblE4H/qtCfbc7WzjXMRZigrSs88oZtoYTlyaNhYk09oD3qJ6qYQb
 x02u4W5bOhA+ELyxp2EH7hdHG3scL+lnJjB87kxVeyw59J7JmFcOm/OntS1BdQ8MlthmbWSS7
 huSbO+E5lnzpwEEp+zyFwaJmD/s+gWRLAv+29r8RAkuYKt9b3xuy+LSh0mTLdzgURpdZ/lCyq
 iShZIYDqJPqYK8B2cNO2UBgk5PgleFoLh1l1hcqI/46gOz3E+px8SLAwNQoiHqhCm1rQuDgoD
 cBVVFbwWsxz5qIFUeIqkv4TrR9OAAES6qRP2af1YMcOC+3Wlxu4aKtCXHcVZtVZSaF3i1PaeS
 Mu1+kXazoSYzwj4B7NxHcBxDQdTiemKHYOXqyDKMVUp6KkISnFUk0Lka1QODxibKSW9yHMimE
 aqyjNr1mjavd6XahhjCbOzY1r5NZd1rXTu1hnGuNb40/wNrPLTLY5RpdVo7I4uPJHbPDcEInp
 /lXNXwKBJZlfoniqXeBWrdmPtnogBEAJuy0MpzHY5J8GTPApzvPJMoIBA1HYrgNmDl+ErKGC4
 Eep4voYEKo5MrpZ/MwTV1aK/7cNYRWnL1MqbxGpCcpQ90p7EntPrZ4ExRcsbN7YZiXGNzHLOj
 yqwiHKXt6GLeQt9K+EKJUPGVeuACh+PmBS0vEiLPZj14cWz2zMtZGUcALNK3uiLxkQOx0GGcX
 z6jdMG+j3czBXaImuSsaZ+N1QXFRyw/0nw9Y8cEixw+Cp0vvgp81AhmLsO7UdiXzuHvPsr61n
 ZajCjcGq9aH65c=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/31 10:21, Sidong Yang wrote:
> This patch makes old balance command to print warn mesg same as in start
> command. It makes a function that print warn mesg and commands use that
> function.
>
> Issue: #411
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

The patch is indeed solving a problem, so good job.

But I found something weird which may worth some refactor before the fix.

> ---
>   cmds/balance.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/cmds/balance.c b/cmds/balance.c
> index 7abc69d9..8d8db8a2 100644
> --- a/cmds/balance.c
> +++ b/cmds/balance.c
> @@ -303,6 +303,25 @@ enum {
>   	BALANCE_START_NOWARN  =3D 1 << 1

We have such flag for do_balance(), but it only checks START_FILTERS, no
check for START_NOWARN.

So can we handle it better for the warning in do_balance() other than
cmd_balance_full() or cmd_balance_start()?

And fully utilize the START_NOWARN flags?

Thanks,
Qu

>   };
>
> +static void print_start_warn_mesg()
> +{
> +	int delay =3D 10;
> +
> +	printf("WARNING:\n\n");
> +	printf("\tFull balance without filters requested. This operation is ve=
ry\n");
> +	printf("\tintense and takes potentially very long. It is recommended t=
o\n");
> +	printf("\tuse the balance filters to narrow down the scope of balance.=
\n");
> +	printf("\tUse 'btrfs balance start --full-balance' option to skip this=
\n");
> +	printf("\twarning. The operation will start in %d seconds.\n", delay);
> +	printf("\tUse Ctrl-C to stop it.\n");
> +	while (delay) {
> +		printf("%2d", delay--);
> +		fflush(stdout);
> +		sleep(1);
> +	}
> +	printf("\nStarting balance without any filters.\n");
> +}
> +
>   static int do_balance(const char *path, struct btrfs_ioctl_balance_arg=
s *args,
>   		      unsigned flags, bool enqueue)
>   {
> @@ -548,21 +567,7 @@ static int cmd_balance_start(const struct cmd_struc=
t *cmd,
>   	}
>
>   	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE=
_START_NOWARN)) {
> -		int delay =3D 10;
> -
> -		printf("WARNING:\n\n");
> -		printf("\tFull balance without filters requested. This operation is v=
ery\n");
> -		printf("\tintense and takes potentially very long. It is recommended =
to\n");
> -		printf("\tuse the balance filters to narrow down the scope of balance=
.\n");
> -		printf("\tUse 'btrfs balance start --full-balance' option to skip thi=
s\n");
> -		printf("\twarning. The operation will start in %d seconds.\n", delay)=
;
> -		printf("\tUse Ctrl-C to stop it.\n");
> -		while (delay) {
> -			printf("%2d", delay--);
> -			fflush(stdout);
> -			sleep(1);
> -		}
> -		printf("\nStarting balance without any filters.\n");
> +		print_start_warn_mesg();
>   	}
>
>   	if (force)
> @@ -886,6 +891,8 @@ static int cmd_balance(const struct cmd_struct *cmd,=
 int argc, char **argv)
>   		memset(&args, 0, sizeof(args));
>   		args.flags |=3D BTRFS_BALANCE_TYPE_MASK;
>
> +		print_start_warn_mesg();
> +
>   		/* No enqueueing supported for the obsolete syntax */
>   		return do_balance(argv[1], &args, 0, false);
>   	}
>
