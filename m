Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3614947F51F
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Dec 2021 05:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhLZEge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Dec 2021 23:36:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:34835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhLZEgc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Dec 2021 23:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640493386;
        bh=3xh6aR3Z7ZlaC4/xeU2N/0xytxqggc5VQ7jiw7oPlYU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
        b=ZGIXcjoH23LrmrT76t/0wIwim7pplbWMrtsiyOnpevs/Kc/Qj9cMEpe3Bw4G1NtRX
         +jTz9Ly2GuahUwE4Mmq9hNYy40KhLCVBjHsrOrA8QH+/3f/bimAilNTu+Ik1Agx5XD
         Vrlc5DOCzDcppkTkJtx5sr5El4hpnZKwfkaCEX9k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1mb3sE49F9-00mNAb; Sun, 26
 Dec 2021 05:36:26 +0100
Message-ID: <fe985e53-46ae-9395-d73a-9d819799c680@gmx.com>
Date:   Sun, 26 Dec 2021 12:36:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: unable to remove files because of No space left
Content-Language: en-US
To:     Jingyun He <jingyun.ho@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHQ7scVoovUAd5fd73d1NuOe8hVHV6GMKoXK2vxhXhjm1X9Ofw@mail.gmail.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAHQ7scVoovUAd5fd73d1NuOe8hVHV6GMKoXK2vxhXhjm1X9Ofw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kNFQ/GuepeOvmjl11EwSoVL1vrXJPdhNzGFZPhvmtxYiFXQWqxK
 OxXlsmPbh0EHuTGQHqSR7xa+/h/N3OKwWQ/J/XTSPTvUE17/YTRFRt3HojsCZdS1mbUZWia
 tz2vVETDtQN6KcMeYBHo5O7Bw+ajr96h/VllzBE477egVaTHv6VL5O0PKvpQdjZcHsGSmGj
 PCbadKK2ByHbSoK5EsQ+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n60NZsSYXBA=:PH3H0F/Z1at2Wn/ePuyS+U
 QxI7NgBdzhC7X03gOcMKqB5C2VXxbBjNUD1f3aJMdz7IY6hB8x4n1O/+soait2+zNkoHgYFOY
 QPXRbdKARL4eSb8bIYiassdo/eqb83Pjqjws/lpQe6L1LhftCkhsQQ21XW+j0tZ+DKVvGAe1v
 kcUfiJb1363dZMunDmyBPWj+n2i8aU7P8Cl7N3IaqsE0Pevk7NgJ0N61SVzYljDLN359IX90L
 UEBXB8DwaPjWO0wpv743eZxLNlDeuSre7h3IIDpI4g2sNLI62Zpg0X0SfPZ6zWUXY/x3QPxoX
 dfYlqRPcD5owLt4XSJG4+cwkZXuRe5cdPnjz0HoKBf8b8EUxvjsZEtqHGfp41clJw4GpaqB/4
 DVOU6SIzQVHdNdH/byXNDboadDKzu2rDR+Vq/9oRhjaRkd2Q/Gkj6mf6lo4BazsjFDjfCmBSa
 LI2lckyQy5FhHyYDfZu/rvve1lMFvU7ZWr45JbIRxG4ljj1SmjayGfM48RPxKt2EogOij2EQ0
 Bs8UrxzxvpxCSJclVA2J/W+HI2Dj5UQe+QhhTNsM3bbHBdqO76deaHmmVcDhmDwfm4yr8fx8E
 I1lyxH3j5v5ANgEZbpOHVWwp9B8KNcS4xuR70W07z6kP2YAY3ossJPnLDnax/XHd7s4lLIQog
 co1YVxTUoNOL9r6UTvZAiO/4Bg4t9vy9xZNFGWEfTL8L/edY5HorfUxsmaKf6+tLfayKXzX+U
 YkG9J/pDBMs3Ilazigid7GtVtCQwLh/K2bmB7G+0k2c13Z4CUw+OFUnKZLX9q78bPa/b95lCk
 1t892uzPhSqWOEeRRUTMGkXq3yJjSE6utbVHAbIolq/VcyCYgFw+E8CAa+rTNPYbX0+qscUnf
 RUtgiM0VNUg89zhHv+3sIWUj83gxqvWT54wCrgEnX6v5Z1QNkr3lBuG0/KgqoneiLykVSQIsN
 0mX9cTmUSyAK5vIwe14MAuH/1G9yhqkNQb0ntej2a6tz6k14rgrbyQ/s94cxapHnOahwMqgf7
 c/d5pby/iZl+7uqNmQj6RsxJBNuH9XcY+V+qdJszjGahDrHGjaVDodP1Mpo1vl+DVIuro7eVG
 AEGnIKreAKmBKg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/25 18:14, Jingyun He wrote:
> Hello,
> I have a HM-SMR device, and have fill the disk full.
> the disk went into read-only when I started a balance process,

This is already a big problem.

Although btrfs needs extra space to do metadata COW, we should not going
to read-only half way.

This mostly means, the extent allocation and space reservation are not
doing ENOSPC check correctly for HM zoned devices.

Add Johannes to CC list, as I believe it's zoned code causing the
behavior change.

Any extra info like `btrfs fi df` and `btrfs fi usage`?
Also the dmesg for the readonly failure would also help.

Thanks,
Qu
>
> Now I'm unable to remove any files nor add files.
> Once I mount the device, it will automatically start the balance, and
> go into read only immediately.
> Then I tried the skip_balance option, I can mount the device, and I
> tried to remove some files, but it became read only again.
> I got following error message when I tried to remove file.
> [435609.942923] BTRFS: error (device sdb) in
> __btrfs_update_delayed_inode:995: errno=3D-28 No space left
>
> Any ideas?
> Thanks.
