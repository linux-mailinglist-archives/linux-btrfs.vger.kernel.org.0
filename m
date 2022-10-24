Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A2460C04F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 03:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJYBCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 21:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiJYBCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907ADD8A3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666655812;
        bh=x8Zm7MkJGvR3iOYD+e17nrDqVP5mrIpc8N4Jek14NDE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=AHXQdZxSx+KRdAze2NgdpaumxEHcnGL6lg/CrJ6OSMrBfdVgGiTJnqj8cpuntlMnB
         Jh35tzYMVuWedMhBIGTsp9gZKSH2PtnUhQRVMo8s9XyTo5a2L2yG2WeOKJxbt7OcaW
         gg5D0SyNWtn9FXJi5UCTrDtf5q9KlPErUJHZR8nA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKy8-1ogYnL1K0W-00ShOF; Tue, 25
 Oct 2022 01:56:52 +0200
Message-ID: <37b27805-a229-6734-72e0-aa7513145e57@gmx.com>
Date:   Tue, 25 Oct 2022 07:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: btrfs filesystem becomes read only
Content-Language: en-US
To:     Abhimanyu Saurot <saurotabhimanyu89@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CALyjvZsgYXkDXKbNhNYrsbVE8rx3nGwy8fAD6gxredq0_ezNoA@mail.gmail.com>
 <CALyjvZu61NNDokqaHxDvMOwXpsdgkd0SrR4+PPb5Nee5BBtprQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALyjvZu61NNDokqaHxDvMOwXpsdgkd0SrR4+PPb5Nee5BBtprQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VrDVhaQg3fKCntJ2M4rhTb2k07UJj23SCb5iAl5k2lUwxixW6k6
 bVjA/6Kqn/u76d9ivXocsDSHlzGAPKNg7OYmkhc6K8sTP0rB0Z1fcZ9Xixe7Ao7yIaOZFy+
 GFrp97VPGJ6ryeXZSqks5Z9dh5UNgrPKOOfPhyszTtlhVmpR9zy0Y6MCq8LOgHdxyGUCOdg
 LR90+V4htmxifHaoX36FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O5upKEa65W4=:/IC5cAORXpyc/zG9ehRXJ9
 PFlEIsVkDqIJGzBw1JLFk8PmupKO6ZhU5/g9MbqIJT5xJHpLfVrvKzH/GoBeZsMHo4vRntXZK
 uBWUPegTVlXhbGRWIS4QZPDRHQYJgPxs0ncosUL9YpRdE+Da34Kkle1gcQ5UWZQw6Xndt0jEm
 hUXZ9jEEAXl2/ST5v1dGPmsToVrplh87xUN615ISbn80K38ilfaBphYy/w8ufVpQqYdvVmlPJ
 rNHm9aY3MkBQjeOclSe2gSva3cYHB7oM0ikDnE7aj0bObybdfzOPRp495xUlwrcgraR8eoeP6
 rnlTNysBxKZYd7Z4rhyaykzYw00l0rM9kdGcP+WM2djlTVb05gYsPAaCrqE52faz9szECz332
 eAa8keUkm9yJTjHuKot8rKl1lrWMAl2IxftRF/ouLyrHOTK4sVueel9eT1LvaZdLrdANBWGER
 F6Du5vpxtCu+1f/qtCtHUcvvm3tx5V86qNrX7ZU1vzzcV9QckHqVLAftBF58LnBnUaGpgHkbR
 eAZ6/yLdyTohcq2CsFzHfS3ybZURuuc+XBwp7d3Skj4KaLSAl/E/tINTituIX6abE8CZbjY6r
 I8gopFArU5oQ0ZWub3prhZA6FKJ4ON51dvbIsDBerlAYlG4bOrvyp4yxZq2/Ih+GhtrchSRG6
 qnv18WtoyU79KET980sSwu60i8DgGalsuNl+ZXi3fmwiGq8QQhAfvYq+zZj2DSkMZO8Z04n1u
 Us2lh/Llp3F8kBqdY7epsxEXVf8L4JDqGUUSkD6BsNIGAHlpAYRl8jA6Xix0qTAz6PMxcGaCZ
 SQ4VpnKwzQ1qo77kYjbZNjfhwLn1E5+RSOOGvPDDaGSS/wyYMFqDfFdU6i3nPphYaBBVB0EGJ
 ZncDln3faz0fxVtZQNHSgJBYcYTzho1FTgUYvC5BW70jCHcEjJUqJXrmWCT9W+Ny3zULi45Rn
 rdWQf7E1OwmNzcj5qASeFb6FPs077RBuj7OMTzQj/pf1sVERD8bAGZvzLxuGzNZxD+oONE/7u
 Fon8KVATngzB7l79EbGLJnJwJVSmOXslUyWnAt4rHQeqm+dgT5QVFJNNiAyfTf/ABGvr5q9Os
 66X/PQDDEdJkpIcHoO96xhdGQsW0CiwK1IFIshTO0PvJt99GTLi66Fu1YUDQF6ujvLkGGCLZ6
 6DyqHYiT0FaZYHejWqmTi5VKcqT+19daPK8efj+NBWSTrtHNW/7tUw1AXgPrK3E3Iza8Owyeo
 LKfpvX/VPHSRWd8SFCtxzjBGUQm1bh8IVDflPB+VC+9vVk4PeDb7ONxrV0LxZQLw5H2uEONJG
 kZYa04kwaaQKcSo1m8Il03FGQztI6r2bVQkW6V4ECnBIwa5RessgjMcvTtj00McnMXVhfuAdi
 ekmMSbW0AjCYsO8l0sGJqWpdsZwoGhmwnY1KAf4sl1Po9xpWdLhRCN+oLuEI/owNPVwQVgoU8
 dvOUERQXUc15vaeDojSvo+5bsat15diHPbwsnPZ399QrOk4GXTAAsrCbsOKR0PQfkRkkagVXM
 oi4hOgOizDCN1LLPl0WDC96lkAcoFO+hQN2OkFUuQ3VhO
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/24 19:11, Abhimanyu Saurot wrote:
> Hi Team,
>
> We have installed btrfs on our backup server having a 1.2 P partition
> formatted using btrfs.
> This partition stores the  data which is backed up from a different
> folder mounted on the same server.
> However we see that btrfs filesystem become read only quite frequently
> and we can do anything but reboot the server to recover the filesystem
>
> We tried to run balance on the filesystem that gives some breathing
> space however the issue reoccurs.
>
> Would it be possible to help us fix the issue ?
>
> Details of system:
> uname -a
> Linux 3.10.0-1160.el7.x86_64 #1 SMP Tue Aug 18 14:50:17 EDT 2020
> x86_64 x86_64 x86_64 GNU/Linux

Heavily backported kernel for RHEL7, I'd say please consult with your
distro vendor instead.

>
> btrfs --version
> btrfs-progs v4.9.1
>
> btrfs fi show
> Label: none  uuid: b6d915e1-47c6-43ed-9f6e-eed2dc4309f3
>          Total devices 9 FS bytes used 312.06TiB
>          devid    1 size 130.96TiB used 34.74TiB path /dev/sda
>          devid    2 size 130.96TiB used 34.74TiB path /dev/sdb
>          devid    3 size 130.96TiB used 34.74TiB path /dev/sdc
>          devid    4 size 130.96TiB used 34.74TiB path /dev/sdd
>          devid    5 size 130.96TiB used 34.74TiB path /dev/sde
>          devid    6 size 130.96TiB used 34.74TiB path /dev/sdf
>          devid    7 size 130.96TiB used 34.74TiB path /dev/sdg
>          devid    8 size 130.96TiB used 34.74TiB path /dev/sdh
>          devid    9 size 130.96TiB used 34.74TiB path /dev/sdi
>
> btrfs filesystem df -h  /hpc/storage/nlhtc/fs-htc-002
> Data, RAID0: total=3D311.47TiB, used=3D311.46TiB
> System, RAID1: total=3D32.00MiB, used=3D12.59MiB
> Metadata, RAID1: total=3D612.00GiB, used=3D610.29GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D29.00MiB
>
> Regards,
> Abhimanyu Saurot
