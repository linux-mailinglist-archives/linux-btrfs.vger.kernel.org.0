Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94F5413EF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 03:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhIVB2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 21:28:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:33867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhIVB2Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 21:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632274014;
        bh=3f9TEqQv8iu/VsQvy7CAxk/WGe7PBMOgIf8aa/QZHuA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=L4hhjfEx74aZaojQ7zx1gAkUlV1AC43MKC81yd6z4tl0ypOqdeyNoHTRp+E8UssTk
         TyH9c+68zdoXccc2IEI6uxVVPXBkUaLsqQBjbNhUAb2zpksv4BiUaocIAFlRBwXogU
         CuqZ3EiEjBM0+lBQrBNzeVwgWL0oFeS/FQJ7qdNc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYqv-1mhuwY0csV-00tyqy; Wed, 22
 Sep 2021 03:26:53 +0200
Message-ID: <e4fcca2f-6515-83ac-e4ba-39e2f0cdf423@gmx.com>
Date:   Wed, 22 Sep 2021 09:26:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Btrfs progs release 5.14.1
Content-Language: en-US
To:     "Garry T. Williams" <gtwilliams@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210920162224.27927-1-dsterba@suse.com> <4680483.31r3eYUQgx@tfr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4680483.31r3eYUQgx@tfr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n12R3UAHAI4UTVzOU+/gMEJwQe+Y9xaT341KnrIHH6EjZXiG8Kj
 cqfbMaRq9hg6OzBCpYP5HzlIoFzO41CGas9DgDYY0Iedzdhtjku+mptoPrNJYHPRty0x6Ms
 YYSRIJ9zuUEw34FHTSb3JugcPfv37PET58BZujSLPU0fsXnbO1quK7k5RmT8nGkihKqerF/
 JVhIqAMyzIWao2a9SOKww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m+pnq+Gnzns=:P4LW8vMpZRa4HxShz2Nvn1
 cyJxhhgM1GMzVKAh9EM5nA91M8gvTVGyYyaYUXmE8bweDMHSnexKsHLGsUYWyNe2OScE8IkMA
 OYjjfFXDza0fnJKlOr9jU+NVlY/QT8YkJ9k6jPZiiTvUHlxnUclxhpR/VQ/525zY2sLSFPoUB
 i5dMg2xIX6+NuvJFUBE+L3uoyysfIizjX8bDeZBJFrpoLWyycv7bHtE3XShUPUHQNcQoE5BmW
 pM8QeHlEXJwigQolJbPJ7EhwHkqRbM/ap/KNUH3S4nwsUZ8VJjfGXKoZk51xbdkfZcxJCBQHo
 abaUxAU/50k3MNK+Y7ZF+pV7uteYtsMMprM67iYqlX0J2tDO9RETMG+xQwo/pNBCaQRmZD5OP
 kJSEsLVZW7XDW4sKO6nqhR085NpsuqKK8VzeVI/Dt+jIq+sIT+8VrfaH0+DF+jGVEuBRFWRTV
 9phaOHy7gmNigdJUmVR9Dmh17aq4co9nC9EVnrKqhSrufH0hkSjFrk7cQNHFznX4P5UVomrSz
 twYO2W+QvODOPHUgY7f8gm+eep21iaChn0pT8HfPaHrZ5wo9nsr8YbTots/Q8XTH3ERCDmaOY
 GlBm2I6X79BG3nPzc/87jmrCNkOBsyjNEbSr3/p1dPNh9wiaUH1T1WxelLMy02DFchINbS2Xd
 pv/f08ifja9/vqg+OEuB0WC42RRJMgbpXU48mU1rKNZ//CirEQNUJxy4/OUU0Uq63jRK4T6tF
 RZUvKBjtHoJs1Bb0SseLq6e2pZAecI/BLxvdJMpeT9w88nK5l2Q4TV7GSeuKRQP1/JG1RF2hP
 PxKAyXr2SjMabZuB1to6Izzw94puORdy0ZLtxAla9bYAp/fNMobBHGctgOhAcAtZCLIG+JklF
 WSFcPdudkttRji7roPLKJa9wVWhyNQ///s4EObPkVu72aQgnPxzo+Ekw3dFIY5iI0fVEqcuFa
 8Nu4s/xE4elcI8FBJhL7YqXFxsmqgtr/6BpYRmHyhYClU3thlOKWSWd8gxTv/VwdcEQQibjvb
 uoc8mTKrai6UpiWSePGWXQlf+H5ZAvhf93XTvrz40CmYvKTUsbklyAuaCtq7012c/M+BFu/kv
 HUT7rVduGCHUuA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/22 09:10, Garry T. Williams wrote:
> On Monday, September 20, 2021 12:22:24 PM EDT David Sterba wrote:
>> Hi,
>>
>> btrfs-progs version 5.14.1 have been released. This is a bugfix release=
.
>
> FYI,
>
>      =3D=3D=3D START TEST /home/garry/src/btrfs-progs/tests/fsck-tests/0=
13-extent-tree-rebuild
>      $TEST_DEV not given, using /home/garry/src/btrfs-progs/tests/test.i=
mg as fallback
>      =3D=3D=3D=3D=3D=3D RUN CHECK root_helper /home/garry/src/btrfs-prog=
s/mkfs.btrfs -f /home/garry/src/btrfs-progs/tests/test.img
>      ERROR: /home/garry/src/btrfs-progs/tests/test.img is mounted

This means your previous run has hit some errors and the test image is
not unmounted.

Thanks,
Qu

>      btrfs-progs v5.13.1
>      See http://btrfs.wiki.kernel.org for more information.
>
>      failed: root_helper /home/garry/src/btrfs-progs/mkfs.btrfs -f /home=
/garry/src/btrfs-progs/tests/test.img
>      test failed for case 013-extent-tree-rebuild
>
