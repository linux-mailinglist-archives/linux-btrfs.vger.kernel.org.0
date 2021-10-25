Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005D0439427
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhJYK4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 06:56:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:60901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232956AbhJYK4N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 06:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635159228;
        bh=authtVD+1SAamVrF9dlq6cBzdjEmAQ3IVePs6bT+AjU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=bqJ+qLrhy7vbkLZ7yBSrLY2HgCdr4kjGhMvmfEFXIvKZ9e8IRicF8lc79g8F3xUXN
         229xtgyBZfAbgZteBBApMYOaEYwN33gU8PzdAWSjl5Kj5FseWtOKn7C0oHqthQcQ/X
         yxRs0d11mMd0qyVNpO01QGw8r5GvKSnOMZMAI9ZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MysRk-1mrYmE0FEo-00vy3D; Mon, 25
 Oct 2021 12:53:48 +0200
Message-ID: <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
Date:   Mon, 25 Oct 2021 18:53:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
To:     Mia <9speysdx24@kr33.de>, linux-btrfs@vger.kernel.org
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0PUshTCVVFxiUamTB3Z2UbvejuNA79XUTYuGHlzOhC62RZPQOHv
 CeM0YfYwMDvdFbxoIks0s4jLr91xsIdjD1kKt+xHx1FGdtaufVBNQvXfvhrMLqorUglMXUh
 4teyVUPlzXJkQUR4MV4kIrNWyeasZOTq1HlPuau3Ps9rzhKFmbvTGVkvQbr/UdIacfIzfup
 rZ+TBkgmFVzt+n2cVNoMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JOyhBKhURyA=:pn8ptMwSjezeptILE8AJHX
 Bp+qH/HQhVCYH3LWwlPjsRIjnUgYvLrj7T39gwZAX/QURfpd70sUWu/y7exh6XA4pJpjr+C6V
 cVF40M5H0Om2KpFGXs767xBxD3j7x2feCLGwSUKPe5Wl0nJKicE51YdHvPJnO4rKItMdWlGx2
 1EiaCdEhVevKfaVGmpn3fjGAsvc8+BlmTWpPWm8aHkiWLPQWOxJ/rfAKWmrRj0dNOfMJoruG5
 L2WFOV1aFyOicncQTwcAf2WsjryCc1W8wlfQ5n/MCXR0/a3ZxJ/qT/zTicN76Zgy+G4FO40Fe
 YH2TJrEL6g0qk8dTVxPcS5AOyq1i45pMqipHRLpGJ8KqotzpFfbqq8umvCcNkFfGITRbN/xRu
 8QisPXGNYm4/hBA74HWUgJ+VbIKcguptAWTRO6UJE5qo+csgIz+/6JFhWZp61WHLmfA9nE+SR
 zHGRJDP8xcz3dR+EZ6JKaFvk4kuF8Z02PQeA26E4uxUzImsiamfZSj2D0DnoRz/XvzlLhSQUb
 +9PrdTciYSF01AnLk/Imb0zSHC1XEbuEHA2dDPxG/ch0HNrhQR077wpfIR2bWgLzQcvn1hRW+
 hJkWbwH3TpAxCTH5yvE3RHgtPqwP6sbO+wcmV/7wMLNqG39uc3HGgelNM2BOIp2eMRegaVD00
 U2vvwnZ6gHhdpz7Y5XDdUd/cAAaWB9bHrcigWO7DQ75gaOXkFB0iP22urkwEd8cguCCG67L9n
 10n+I7sSB8z2sSTL80Dj6Cw8o9EGMLNHdSNpgQcuEGTtA5NwnbKd4P4Qd+EYS+T5Fi+rw2wAi
 LpiwkzYeFPjHo50MsktagIi5XWQ4IZXUUVMwA6Gn/TNjDRZGnlUMzhiMLSgvy3OivzZ+4bWYi
 65LA1GHPabzMAvr/7khiULkjzu1Hlr5w1LczObUiPuvU3H1YV8BMBEcf2IoqhuxWKBQOL13Sk
 H0kgLzAJXaHZgkOmENovQNrLSR2hBJUkidfNfQe/Pt3+T6SgBxqwPLpqFyieRxmD62yVVspky
 mAJr+eKkSU/eyg3xZaG1zIgg5uqShYVAvGYVxtvKULwfsc9FqbKFMDlLe8qDfy5bOEdGbtHs2
 jjQJp24EUSdJ30=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/25 16:46, Mia wrote:
> Hello,
> I need support since my root filesystem just went readonly :(
>
> [641955.981560] BTRFS error (device sda3): tree block 342685007872 owner
> 7 already locked by pid=3D8099, extent tree corruption detected

This line explains itself.

Your extent tree is no corrupted, thus it allocated a new tree block
which is in fact already hold by other tree.

This means your metadata is no longer protected properly by COW.

"btrfs check" is highly recommended to expose the root cause.

>
> root@rx1 ~ # btrfs fi show
> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>  =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 189.12GiB
>  =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00GiB used 199.08=
GiB path /dev/sda3
>
> root@rx1 ~ # btrfs fi df /
> Data, single: total=3D194.89GiB, used=3D187.46GiB
> System, single: total=3D32.00MiB, used=3D48.00KiB
> Metadata, single: total=3D4.16GiB, used=3D1.65GiB
> GlobalReserve, single: total=3D380.45MiB, used=3D0.00B
>
> root@rx1 ~ # btrfs --version
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :(
> btrfs-progs v4.20.1
>
>
> root@rx1 ~ # uname -a
> Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18) x86_64
> GNU/Linux

This is a little old for btrfs, but I don't think that's the cause.

Thanks,
Qu

>
> Hope someone can help.
> Regrads
> Mia
>
