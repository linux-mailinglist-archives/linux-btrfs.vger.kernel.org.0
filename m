Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1943D69EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 01:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhGZWZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 18:25:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:56015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233380AbhGZWZk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 18:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627340765;
        bh=VioI7NqYAgN335cCZu8hri0EblGv0CYujKKQw34Mf8M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NLgWyiyBYwG8Ly3QF4QgYQ8M7lM/M4jlj5lV0tr/EqaD8ZCJmeIZqwof4dYpEM0SN
         0Rc05CwUAhNjtc+uBN/JZXRjf442oIJaLA0SBzsQqBV0aSuZRJ34Kw9DUwyOICJnlA
         TDO8vFDl5XWB7NK3IkTQ9elhmngw/tZaCfjLOYiI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mKJ-1l1HCp35Kd-017CtR; Tue, 27
 Jul 2021 01:06:05 +0200
Subject: Re: [PATCH] btrfs/177: Adjust resize output message
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com
References: <20210726193738.14992-1-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <589a82aa-1a11-f4d2-e9bd-672f1ef21e50@gmx.com>
Date:   Tue, 27 Jul 2021 07:06:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726193738.14992-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KOwe3UKfJbslyGQJiTKxgchnXxU7cymz3urtNPg2EbEPoh1kvW2
 LysezHUoXMIW39d1FghGH0ZhQY8hBQ/ZTCbJQ6S6GRtVT5MBoJ7m7lvpOY92polrfpKfxTF
 7XyozbFQo+OpYdy66RQ3ZKiY2PdJD4XDUUelpD04NEnSQcMVB0dYL3srs2aiU+i3V1Q9zev
 +d6rwNOKjHjqP/GTx1dwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pptC9AalOXo=:987MDMn2DLDWj76obH01I/
 GsgAKkGBaP6mcsiIitFrHYcuCa2Nxj76tk8/RhC8XcNccGJgbtwsKluD1B7ryTJV4VkBKJMDN
 EJX7lH/3YFkrNbebut8PF6grWVTwjTuwzyrpUyak3eGdrqPk/qdacmUhnM3g1/nOqbw2l40y8
 /uEEbuIhEpbbG0lRRqWjaVL93ArQ5sbmfjyldPqTDYEI+uwvVDIHMDhcUdp9WkcDLrXyZHxI7
 ESWtcIrQJHwFHDGxpYBSl/brBKS/uR9UVO+JHqO5mlb9Xk1ohU7oSOWmKZ2zrCb2x4FI4rU4L
 6vFRR9KPzzWfnOueSGMHTAw0cvdbnLKxMb8/8HTZ/BfMbAGMW0zSkuc2rMoR+j+Fu3l0HaXPI
 vlW3/wPFxmpYc5XmUj+NjvzhX+hN90uOTSMCtIsc9URlp4ggHpCjQZL8syTIebW5iwjFkgytK
 OyFNI3Wj4/ISTQhM318PDA8cktFs1HINXzk9FS3JJ0L/JqdRyAvsfqpMzgkxGfqO4aF2oNMIH
 WprPHvr52UieLZPEHEjGedLGNitAlwoZVLjKG0nx1DHcYJAVXmJrrFJnXIf1sloqVcU5uh2xT
 ibiYeU3wJlY0idnB4tkhr3PGROIcdpBURK7Y1yequil8WjIUoCTw6ek2q0dt3rmDsUV5SdIOA
 2fKywJTUd3rAydAKjEe5pw7qJz9lY8i2tmGaNL1y2fo17EcaU/A8lwFqrnqsq03ptCV61Td7r
 NVQ9i5ht4CsNhJmnakkntgWUNwsqyFFxd/juwy1CWLoQHXrYubjPkIngc4I8oZPiSCl5jKSxX
 NJI40NYgZ8f3upOc+wXLrAO/lavAw0F5FxPyfL5OGf3pxDy1GIx84HQoSOJcsiRlT86OkBEeE
 a6Rm6Ryi0qN8hvb2jMMZwfdcoxV8OxG9PqxNz3Cr+nDvQihI+2cl7/pSCf8bjcd1TUprVZ7KV
 AvZJGdBxekSTCUxWyEYgnsRXZBXiIhfw7X2eu5W70w3iWJ4BIjoIl/GWaEFaqu+KBL+IikPjN
 1thb1Fden8Ngrl2AKG43wNjzl8uHCfP+HuEq0A95toHLlJ5fnq9G5fRnOts3EwnQLurrRUDbD
 WSC4nIvDffjaRHKHCGYFh4bSdX2F8RPox+F1R73ZWj26/3Dcwm0x264Vw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8A=E5=8D=883:37, Marcos Paulo de Souza wrote:
> Commit 78aa1d95dd99 ("btrfs-progs: fi resize: make output more
> readable") added the device id of the resized fs along with a pretty
> printed size. Adjust the expected output of the test.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>   tests/btrfs/177.out | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
> index 63aca0e5..b1cc5db0 100644
> --- a/tests/btrfs/177.out
> +++ b/tests/btrfs/177.out
> @@ -1,4 +1,4 @@
>   QA output created by 177
> -Resize 'SCRATCH_MNT' of '3221225472'
> +Resize device id 1 (SCRATCH_DEV) from 1.00GiB to 3.00GiB
>   Text file busy
> -Resize 'SCRATCH_MNT' of '1073741824'
> +Resize device id 1 (SCRATCH_DEV) from 3.00GiB to 1.00GiB

This will make older btrfs-progs fail the test.

IMHO the proper way is to introduce a filter to handle both output format.

Thanks,
Qu
>
