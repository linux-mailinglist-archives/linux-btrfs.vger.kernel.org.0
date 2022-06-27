Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE555C91E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiF0KKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiF0KKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 06:10:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60563FF
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656324614;
        bh=TSZ7iScH83nevLma4kkmo+M4AVsK5M+yJaw0OCqkqpY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=MzrbbulMJXbhgePlntPXB4M17lI04x2nEywWO9mRthSjKIpGVnURKcI6k9Rxr6c+e
         USpzUbTl1Sntk9qtm+0dl9KA3B2Xy65lNvpO8vbLFAZqv4jL/heoPcLo8iBulEqF0K
         hWZ/J80bSEJjcClsg7eppKWpdzddGd5onpmbvU4s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgeoI-1nQxpp1a0K-00h64N; Mon, 27
 Jun 2022 12:10:14 +0200
Message-ID: <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com>
Date:   Mon, 27 Jun 2022 18:10:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Question about metadata size
Content-Language: en-US
To:     =?UTF-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CI8YICYaVS0+k0xiyNiY18uf0/sdeNJhWlYY5taNRyYGnqgf74K
 2TzER+350yynKo9rb2w1LwusdX5A7/TjPeRWx3cGyOWIUHCmn/Jvyih5BQtEfyzl2VrdfX9
 LhFkyvzGFeEMY9I2jqF4ANquf7lC99GRUmSdKltkTqwZVfeCCD0CVIoCUAYIq2EQjikwSI9
 mENB67l+MR/rXtwZHNO8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LQfnQ4TuHrs=:gotnUbKhWQwSnPGDSr2uJH
 hyfp2Tzq029FI51m+EGaQGNW1+McP2DpgaH46La/qB+HWYD1iaxgaUQTHNXU+7xdX00vbMtUu
 6rKIWPiDv4UxcusDouldjCSWdcwSeCl5cXiX1Cg/RMFounQq2MnkwRoIKS3CuhRxvG193wCk/
 pSuxIKvjOOek+/y4UOx6rTQv9Uk4c+vSH9Z8H8z0bdvZiLcaXC26lWsTDojA/9QLvIRXkP73/
 mT6fYrKar2RS3WvkcoHIBQvaHPMCGdGuk6/+A81a03S3uZULQanSljlolNXl8CQtplkQCusrr
 Oa/IScknHnUcXKepUFkAtm7HOGuS/JL431GmJmdgTzpmVorQnT+sUq9Vb29uPSJPeKrYXW3mb
 dHXMihM3sCWHHKMsX91yOQ5G2MQcKheZh3mb/tfmsR+f/QA01AllPk689UsRDtF+Sra7n9seM
 63k+WnnZqnL5ZngIfZ87kqUWxbQ6wyKXV8fCBj3veR5QmkOo6S9gMFgMwhSyOCT6+VjGlobbz
 DOqDiX/abZlZkuqRaWKA8tO3tZ1M5RBSGOh1FtiMVvC7ikMyqbldW0Fkyv3dhVdohgc9GqZOP
 HVIy/CHk+Ft8iWx1P/67vr5ytvDBYvTrMkAJgz25aoEm8hHrO1Y8nPeRMy6dorr6ecEMtFtyV
 6FmN0uSrzi/Pc1yYYcopzYJDPMdF4jICnwmgJwSd9DLFm4UM6adh3x3KM3a5lu9yDOeCfShoJ
 Ifm9kSJ4HJVZBsf4bGJEWJEBID6wd66HDhMHO0vKwP40VrwgsF8mij5EdOUGqQ8Dxd18HCqCJ
 /qIbfCM2UO34h2yObCSdeglvwLDRsjtFjbRXKn9XPgyXjonge6y+JExMhGHwH5UVXFwiBm7DZ
 wx2oSuSI3gW9GiDULeaFfSxoS9RiXkT1Eh4dj3GsHV/y+D3i9tyW8pZad9Hesm7jFo1FsT5+a
 joyAouMBCboOoizZeZXJVSp2ICdnrbfOyCfYC24SY0hD6gSN/12qn7TGjPgGAkIXoOaUiv8TK
 Eq7bZtooTpRXvDBrl15B6smOTRuV3RQ1XFU9rSf2d5C1GWtCf6hVJbtB1aEhbDF5kxEcKbTJZ
 64Cd/rUxTl4h7nc7n9OwFxkGXh07R+solGJtjE8kST+3g4oojJsWtpwXg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/27 17:02, Libor Klep=C3=A1=C4=8D wrote:
> Hi,
> we have filesystem like this
>
> Overall:
>      Device size:                  30.00TiB
>      Device allocated:             24.93TiB
>      Device unallocated:            5.07TiB
>      Device missing:                  0.00B
>      Used:                         24.92TiB
>      Free (estimated):              5.07TiB      (min: 2.54TiB)
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>
> Data,single: Size:24.85TiB, Used:24.84TiB (99.98%)
>     /dev/sdc       24.85TiB
>
> Metadata,single: Size:88.00GiB, Used:81.54GiB (92.65%)
>     /dev/sdc       88.00GiB
>
> System,DUP: Size:32.00MiB, Used:3.25MiB (10.16%)
>     /dev/sdc       64.00MiB
>
> Unallocated:
>     /dev/sdc        5.07TiB
>
>
> Is it normal to have so much metadata? We have only 119 files with size
> of 2048 bytes or less.

That would only take around 50KiB so no problem.

> There is 885 files in total and 17 directories, we don't use snapshots.

The other files really depends.

Do you use compression, if so metadata usage will be greately increased.

For non-compressed files, the max file extent size is 128M, while for
compressed files, the max file extent size is only 128K.

This means, for a 3TiB file, if you have compress enabled, it will take
24M file extents, and since each file extent takes at least 53 bytes for
metadata, one such 3TiB file can already take over 1 GiB for metadata.

Thanks,
Qu
>
> Most of the files are multi gigabyte, some of them have around 3TB -
> all are snapshots from vmware stored using nakivo.
>
> Working with filesystem - mostly deleting files seems to be very slow -
> it took several hours to delete snapshot of one machine, which
> consisted of four or five of those 3TB files.
>
> We run beesd on those data, but i think, there was this much metadata
> even before we started to do so.
>
> With regards,
> Libor
