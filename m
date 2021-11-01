Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8CC441ABB
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhKALhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 07:37:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:59109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhKALhr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Nov 2021 07:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635766513;
        bh=6zO7peu04mmgqezBBaJsfEunMPVTC1PRPXQD02LhK/w=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=AK5/zyVZB9x+936lSZJutU9e24MIGXmzLAi1jscNBl9gFqpVDRuH7gxxtSJiukekK
         6ZU0r0MFCN7Tdsjkpk8SnW46hbAlenSD26wPN2gMFfCzACNd+wX6l9RK0Gpg5X6Dis
         sVnMW0UDk3Sx1Mst4lF+aibfWhOem3kr2lovLnas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoRK-1mSgPG12HO-00Eyk7; Mon, 01
 Nov 2021 12:35:12 +0100
Message-ID: <0cdd560e-5a3e-809d-f1c6-bc502ecc7c65@gmx.com>
Date:   Mon, 1 Nov 2021 19:35:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] btrfs-progs: balance: print warn mesg in old command
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211031131011.42401-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211031131011.42401-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U1H2qbtvp4mZ+Eyjrge9WvkH+UJUgI9YU7E1+3Vanndpk1WMZ9W
 IQeet2p63cmkHBo3XDS3lZXu0vZnp1Ndwy6izx1z7XU+eIOdw/7yVmy7lcbQ92k/L94Upn6
 Y2NyLXoXyPCRh9wJK2LP9S8kgUdgnOQvH/qpzTrnKBatoBRDmbSyR/rqJ1KnHSgecoSGWju
 CNAhxlgm8qfPk92lDdzZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s0GSkJUEqds=:R3sQK0Wh/msRdcO4SFei9y
 8wr8WNDa/yJru3LkqgKjmbRnIoD6lXPcla4dfKOOw+nFNe3y36m978v+JAJD2NUuqYjKRFKJN
 eXgfmajyPZ/yo4Uqx6AUH3LzpcfybYuOwTue+zXGld0IXFVcCJdyUgLqnjXgfANIypz+dCXR/
 Z1R0/W+T1N7nDPuG85CyIwHlE34E2x/znlLVsa47MTiqgZ9DlKsDgsXHcWO8q0VxNDfbPoMLn
 3u0VPc1skiphShtBnypmse3JDJlj936NydewgfjqaBxjqAFj0K7B3PnnwD6E0RGROhkKJ9WOD
 yNm70nYHCVSz3LOrrd0BSymrJUxVZ1iJC9s6GuRz+4b8vnSmdVDKLDGk+QWTYwl5ISU/a+A0l
 UKuKnx1CYzRA0rTDZv/R+JGdcU/W5mzcTxFkqc46wErvU+vG9M7F4qVDsW90dUJrfEOhtWKy/
 fcVvf2N4Wy18nYFqVTgorkgc8Pb2d3WZvcFzPlhmUOouHAlrg6Qotg4VZyT9RwpGZC7bMMt38
 +ySvbeaWsp2HP/1Mb1qyq7NZoScR2nIZle4QkQTlOzDE0W0j8RAum8YEgYmsjDCDRAXMzW8sy
 1MINEExHg2QRXY3Rd0E321f1Ym7lLbq08QvubEMghT7BMQqVks/9q7B+SxQWJayOL8VSJcpga
 QqwElHkNvPUafA03svMglVg00c8zJXKePrE6u435ijvkG6Z766WvQuAuT7nVhbGJGLLV0Wzzk
 sziRZ1LlzMRg/zWGJ5EQkCQV8C6+g3r+jGeZjycc05D2mMIS2Sq3lUIACYZH9uZAk3oaA+IOg
 dI6b226xHaNjgBzXXgS1lCtQ0PXZHvO9qsUW1tCiPuKzSoHnbg3rgoM/Eff2XR4w6IkElEVBi
 +jRgRZcqkpB7Eida47VteuWg8fo6mTJb3cyg701kIVDhXh9vsyQGLBUMD5jcYG4rUJqoNQ2mR
 dfw0hHsyhTlYDDw1jgb4ESZlRBZymgxLyr70zRFjvcOzeuBWgX+BrdVVdTvaFc5O+IxXf0uTF
 9qPsGaD5qHfPZ0qhO8VOsM17D/JASKbCcdORCLbdIkBT0bMTUQe4kmaNXKy+DLfagJTDXVq5M
 zISJ5Q1EBfUIsE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/31 21:10, Sidong Yang wrote:
> This patch makes old balance command to print warning message same as
> in start command. It makes do_balance() checks flags that needs to
> print warning message. It works in old command because old command also
> uses do_balance().
>
> Issue: #411
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> v2:
>   - Prints warning message in do_balance()
> ---
>   cmds/balance.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/cmds/balance.c b/cmds/balance.c
> index 7abc69d9..2e903b5c 100644
> --- a/cmds/balance.c
> +++ b/cmds/balance.c
> @@ -322,6 +322,24 @@ static int do_balance(const char *path, struct btrf=
s_ioctl_balance_args *args,
>   		return 1;
>   	}
>
> +	if (!(flags & BALANCE_START_FILTERS) && !(flags & BALANCE_START_NOWARN=
)) { > +		int delay =3D 10;
> +
> +		printf("WARNING:\n\n");
> +		printf("\tFull balance without filters requested. This operation is v=
ery\n");
> +		printf("\tintense and takes potentially very long. It is recommended =
to\n");
> +		printf("\tuse the balance filters to narrow down the scope of balance=
.\n");
> +		printf("\tUse 'btrfs balance start --full-balance' option to skip thi=
s\n");
> +		printf("\twarning. The operation will start in %d seconds.\n", delay)=
;
> +		printf("\tUse Ctrl-C to stop it.\n");
> +		while (delay) {
> +			printf("%2d", delay--);
> +			fflush(stdout);
> +			sleep(1);
> +		}
> +		printf("\nStarting balance without any filters.\n");
> +	}
> +
>   	ret =3D ioctl(fd, BTRFS_IOC_BALANCE_V2, args);
>   	if (ret < 0) {
>   		/*
> @@ -547,24 +565,6 @@ static int cmd_balance_start(const struct cmd_struc=
t *cmd,
>   		printf("\nStarting conversion to RAID5/6.\n");
>   	}
>
> -	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_=
START_NOWARN)) {
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
> -	}
> -
>   	if (force)
>   		args.flags |=3D BTRFS_BALANCE_FORCE;
>   	if (bconf.verbose > BTRFS_BCONF_QUIET)
>
