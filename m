Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE148291E
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 05:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiABEpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 23:45:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:50489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbiABEpy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Jan 2022 23:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641098752;
        bh=Qyx0OTrtCAVr8MTIEJVoSjimRFSWgFOE4AC9l787p3Q=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=d8L2+WrA2dfBPm5d5Huw871WaM9rqdEcdftTxOfh5miNHE+u5dF+0Kk6aGr73TJUd
         /RGP+sEBOOU9SK9AMMq9EEnq7ektBJ9ZVElIN73PuvFGphTBzM167/d2/C+70ufbPP
         wbvCSxR95U4u3s9v86r4oa+aRVNRohgu3mJGnsig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv31c-1mDI6B2mXI-00qwDk; Sun, 02
 Jan 2022 05:45:52 +0100
Message-ID: <0f76334e-b7c5-3177-a3fc-8de217f75ac1@gmx.com>
Date:   Sun, 2 Jan 2022 12:45:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] btrfs-progs: process_snapshot: don't free ERR
Content-Language: en-US
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20220102015016.48470-1-davispuh@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220102015016.48470-1-davispuh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ClHi6SUoY2scw5qXItaTTcUu6ZYHl4elxq+EWRHOpgvgjbLHPyJ
 OPD9VqXxl0Qwy5/3lX3XrAQard1kemZEf3NfoZnE4JC2jHnSxjuNsBmOSMXp9JjfUMAw78s
 QZ9F0P15yGnss6f80Av8/rD8D0+mRcP02gHRXgemhk0CVSgdOLTSV8E9KVzBQ6wDsEeJKiT
 UyOcoZFXSZ1k7XTsMq5uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nRBqrDyltPE=:2gdUuZ97CUEowaAh1kaxh+
 XpJqmabsL/5v+ScWP+BzVQsH5yH8lBcIqbDDP36nm4oomocvAZpRnOMhffQ9UmDVpx2xuTbMx
 SUGa00pxkG+zXlIsdu+jS3jGITI2OvU94XRe/sjgGm3LQSk9kIOu5wOptojnZ/5a/9tQWmy+w
 cjluVcgt2olohrHZPCCtItXXuMQr5SvdGVjIiYBXwFoZ5/z9oMYESD8nS3G/UivXu3dg5aj26
 tjO2XBmMoIBHuOgTR3kTZupBZs+WA4kszL+9cEVI3uW33dFdm0fhnSQxmqyadkvbmRlYOr/gZ
 vKfGb0D9FYwX0BW5/J/6/LTK9HnXV4A6NmA2yJU2p6zSeu/hA/v9Ldy35EhOXt2hZPE4HKcZz
 Z0GmmenvO7Agx46xIlZyg9Dv6i0uLp5VcLXBMmrBx5yYsq8iYwMmezrEQBAqF3DqGdCp0zrF3
 oY+vuvuRiQWTcOtniVhePtNiIWNoLw8xngBnnGIJeA+FSbbqoEJloOvtlp6U7GJUCKVpyQz1r
 0ve/OJDQ7YTEx/Ksm5GYz45I7NEJ/rZXWZneND0PHZTYmwteM0euwG+aEqYvCxswlBXKONFnL
 p6JlgJ/oNmMvYkowhsbRvUFN0J+m1Rg1vKDV60+kEv2OT1Um9dLOACtCqhW1mIkmBC8vcpTSh
 5KedDiLEOLKKjp6XAM9FzDR11HzlZc7luUYJmen5cLa+fn6Rm4NysM1iRmqgmfukeSGhJqY6Q
 ayXV5lk/0NCUKjcW8L+CIfywYJQ1SuJftjwcx/5kggczwjKqvJ4MKZ28UQ4E0looP/vzDMHLf
 LavVvgIqlHs1+g7QTkyYwz89/Xe3BkOJ4IbRXAqhGVVuduUXmAlmv5eik3kHCAkeJ/nG3M0Ss
 601Yg3Cyy8tb+ztlsYSUnG/UX963bPVw9+4rr5dY6ZwLTO4pWZjsRVbp4eMc5H+K0lWIbuBag
 kdZ2CFiAsC2dOHivWkbiDC7qnIvhFVOEhs/uAyfU+d+UjfSs/7RqUXbRu2v2SNwISbBivLcTk
 DUeJ4jpcnmmiWK5EpUB0dcnbNcYtPRnsN9Ypm/fLOM/ny7CEci/XLCFvEgYtu1bMbNlacvbME
 KQ4KUMSzDeV1rg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/2 09:50, D=C4=81vis Mos=C4=81ns wrote:
> When some error happens when trying to search for parent subvolume
> then parent_subvol will contain errno so don't try to free that
>
> Crash backtrace would look like:
> 0  process_snapshot at cmds/receive.c:358
>      358		free(parent_subvol->path);
> 1  0x00005646898aaa67 in read_and_process_cmd at common/send-stream.c:34=
8
> 2  btrfs_read_and_process_send_stream at common/send-stream.c:525
> 3  0x00005646898c9b8b in do_receive at cmds/receive.c:1113
> 4  cmd_receive at cmds/receive.c:1316
> 5  0x00005646898750b1 in cmd_execute at cmds/commands.h:125
> 6  main at btrfs.c:405
>
> (gdb) p parent_subvol
> $1 =3D (struct subvol_info *) 0xfffffffffffffffe
>
> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>

Good catch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   cmds/receive.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 4d123a1f..d106e554 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -354,7 +354,7 @@ static int process_snapshot(const char *path, const =
u8 *uuid, u64 ctransid,
>   	}
>
>   out:
> -	if (parent_subvol) {
> +	if (!IS_ERR_OR_NULL(parent_subvol)) { >   		free(parent_subvol->path);
>   		free(parent_subvol);
>   	}
