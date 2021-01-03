Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388472E8B38
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 07:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhACGzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 01:55:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:58433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbhACGzB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 3 Jan 2021 01:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609656808;
        bh=nseqMJKtA7DV2pURGn5tB1WXF5H0RvfmK6r3BHib7Yo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=K8EwVxCoGEFlNaGwvUsKGMQpPaFr7YD/Yso0EP8+Dp/TLaxu5RftgeOVZ3d+eAslI
         F2y6e2Pqgb7mYZQFaU1uxMfhlTG+9PsVvCwEvjlfr5RfSVpzwDv0Bt8lG6eXW3/tbX
         3CeLrWbaBwmaJR8qjSJHrP0H4xxoGo3diNt4NYjs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwwZd-1k3JLf0FZb-00yTQm; Sun, 03
 Jan 2021 07:53:28 +0100
Subject: Re: Question about btrfs and XOR offloading
To:     Rosen Penev <rosenp@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <be4e5508-b8dd-148c-33d1-366b73f22d98@gmx.com>
Date:   Sun, 3 Jan 2021 14:53:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PJxbW57i3jMqv5eGCOeKDeutlRdxlJrOWpYcbK3pryhezAjXW8q
 91xRfjbfxfkh2R+TMecjFCoFS2eLso+5/QqPLp5gceRJ2wsyotJcXzyvThZvwl+fFXcpPpm
 /2UCNn4rShuZMRQehfr5mmVnZg4+ZsDA8E8kNaUcdy8/tr/QbsXbIFedwB02U14Q8kigMlr
 4uVWYoT5QXgnv2LyxXNhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0PWn4Jz93RQ=:dBHgz0/224o5sPo/UGMpOU
 3Oq54MOkQ+yY6jEhcQUhYxiGkFS8i/nvgGr4mNIK0ybHx2GW0bzEzkljRT5FxgBuGt/pJDSkl
 0f6H0K2Dz/TR8SvArBvJeyQcB10wYvtDgB0uuRIAnUD+ZqjC8ijt/lOI/CbyAqZ+/ECMNHlNN
 xs2N10eS/eo2vEKe7gMnXGE7g7zTxjTmwWUZbdWdifk4pzCZQ+0fg/G0PM6E/TMjbAQrf7LOX
 W3qV3yhCjHljN4vs7xOs8g09SPntHWOGK7hJE4iyjJiqMNCixNWsF2Da0eh2TpfBd4n7ve6cf
 vpfaxopL1guqrdFhUrHjfNe0aRZ00+lIWC4y7kwEaAIlsJ5FmL+g8n7dK/idWN5GADuRruvDo
 W8/NueBsbwrfPYm8DJpe2d1rnEIC/rN0Fw7rZB8yToH2vQ162U+i6iYTD3tsFQug0RGEUBZLv
 eNxWf8UdolPDN95i+pLWKRelD7WjaM73Y062bMzWyLkFB1CNuLARlLhImyYL4quWxt2fgCoW9
 4irXsz/H1o5+xADivZb5qGG4UQkyXCsJZKKhH24OmKnwBezhSEhae6zQptYmGgf5v07Ej362p
 f0FjnxF8VsF1qt/l6grcnA4ZDcIJHEic3vKDjOoGiOUDMCAhJmiBxHKt0XNuA0c8Fsg2zGl7i
 nWC5dF/BjYxa4VOaByfhP7Yc8tOewhWLF1Gbeg8T7U6SV4PcvyoUe+W2a2OIqFp6M2/iTkH4Y
 7SNFqmN22U72tErVZCTvzO76ssY+c7RD6OPpICk3PkOjPMezPCIJeiqpJLQ/NPTu/Ab7Q+gKK
 Ic+iWQ7QkXfXu/N73Gb6laPmx9OqvpyPe1Qxbn7uS8in2b1ZTlzOiY34RGx2ucd12FStaLP7Q
 9e7mUVElBFEeEev05Lig==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/3 =E4=B8=8A=E5=8D=8811:50, Rosen Penev wrote:
> I've noticed that internally, btrfs' XOR code is CPU only. Does anyone
> know if there is a performance advantage to using a hardware
> accelerated path? I ask as I use BTRFS on a Marvelll ARM platform with
> XOR offload capability.
>
AFAIK XOR is only utilized by RAID56, while RAID56 is not considered
safe due to write-hole, thus I don't believe whether btrfs supports
hardware XOR would make any difference for now.

Thanks,
Qu
