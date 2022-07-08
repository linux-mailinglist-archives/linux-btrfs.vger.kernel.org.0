Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1A56BA57
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiGHNKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiGHNKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 09:10:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A12A950
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657285843;
        bh=D7Zc2S/UM5rC0clADnDm6KXcw0lUG3iIoOEBR+Q3vew=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=aK2uQ71VlkGT4DVHU57504QKcomuH1ZlTFMSS/mcOFfiveQiqs9PXFix/dE+ljFTL
         QvFd3KA93RkAVLQudlmgM03xzcP02o1nZkw9KBatDjbsMaTlWUY45HDcrMw0oL1zXu
         VksjsRXQV8sM30+L7+sTpyAVXWV7DKqAXCV0ZPiI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sDg-1oElpQ1chO-005177; Fri, 08
 Jul 2022 15:10:43 +0200
Message-ID: <98714041-d872-081a-b9fb-174aa17d734a@gmx.com>
Date:   Fri, 8 Jul 2022 21:10:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Cannot mount
Content-Language: en-US
To:     =?UTF-8?B?xJDhuqF0IE5ndXnhu4Vu?= <snapeandcandy@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XcN3QoePqRnBnz9keVaV+fdTFMLSURVDN6Jndyeygjv3dwiSgNd
 txGBr/IswZmwW2weEbx7srKVq81pdm1JNzJ3PlYuki0uALxgm0yBHZaj33XOHl1P3Zp7Roz
 4KNCf9hphBgYk8er/If3/GPBVcrty8PuAUfj5K0JL9KiEVV7RvbcRAfNi2/e1o3bSmXhiHn
 GskS4KdtGHvAugqXxVFIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ur0jlUcbMmo=:wdwG/bRfnt4kuTZQ6QYzJX
 QYX0YGPd01D/JfgCWFsbVnHK6/pQYU0qoRVAPPEjGz3B7bHiVibwE1ROd7L8hqa2vstzo0ChJ
 LQhVYIg4wDwCsBaVauDaoFqEaM7vKSXwhZ+ap3Ces09sg52k0qaDpfJBvcU/OP0pTi1Dx0yhn
 7sHiFm3RKMT2KYRn8J/C8tioMeakLMyvY1Df11uFn/FqUJOiM897UebamJjDDNMTVVQydR5b1
 rvPnQwjDnnZ93lG0XoeNN15qNn3Klbd8shx+ODkayQ+1Z499c+L9QsFl1SgFYy9zdZsBKQwF2
 739YsTNvD2WuBwhWrNqjGW7u/1NxMDnNxfbWi2xZDVYch+PRt25BcmHQtiXKum2Pa4bc7Bos+
 0vUqkN+EsHBVtjKOxcvysmqRxg7I4ssv9gQubglgguAcBQBcmxCKO9EmuPEgqGr+HkrbJpmLy
 0xFKu1QFfO713sqcli+Jx0Lz5YOr3OA1Btgiw7o+0CQxjlV8cr/1OIntbiHaiIzhk4fJjcSN6
 BK2Nee9J9y4koErzTIxTbd3bIYCNbNq/k9tnGPryUcVKNzlhYypa9EkO7oWv4iELEQOanj+p4
 y5PELgPx+Cg/1xmZIa1wYQKHmxzI1qrTmSburDtvPAqw0GXyfzSpWlGl0Nqwnr9Iul4uWLJ/8
 QfYH+t4rcdWlMf+EhJ7e/I7fE8kfNzkO3C+25NZS6FTw5y8B7NVMFr+dn6OW0mneudu7d4HPB
 dmowKJ5M/aWcj+ELGnw/pi7OfO6P7WICfiC2CNm0lRj2zoKzPvKy0OdO9PBLvo6UQUaXXA43j
 wnUaNSqSSnQFRaPQbl9GHz9EDT3QkdhHHiHI2wG+rZllTuPd6SxUaiI6mLYbwkbxbqIpf6aZ7
 HG54Ynh7asCE6ymt170rDjK5y0cso5TfXUKTcejc8rHkD7eH2kT70n1BAE+K/cdaSYhAixJZ+
 xbgR00rm57U4dC9K7R6oa9EHZIcdnq4QC0JmB4me/A1r2+ZLGbJEdJgacfXDDXBDLIJGrK04K
 4MkfMO1z6usqAghThLj32GFWiGV+U/FGriUN/f5ekef7zCaku+Rzt9OjVZGFnSeEdForC59vY
 8II6IkTs90j0Dn/EkcPhJUeNo4Azel8gNLOcPlwkTogvJaVAcz/Y+adrg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/8 20:18, =C4=90=E1=BA=A1t Nguy=E1=BB=85n wrote:
> Hi,
>
> I have 2 drives in mirror mode in pc A (ubuntu 18.04 server). A
> mainboard problem occurred in pc A, then I attached those 2 drivers
> into pc B (ubuntu 20.04 desktop) but cannot mount them. Here is the
> information.
>
> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF uname -a
> Linux pc 5.13.0-52-generic #59~20.04.1-Ubuntu SMP Thu Jun 16 21:21:28
> UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF btrfs --version
> btrfs-progs v5.4.1
> ~ =E2=9D=AF=E2=9D=AF=E2=9D=AF sudo btrfs fi show
> Label: 'data'  uuid: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
>      Total devices 2 FS bytes used 656.04GiB
>      devid    1 size 1.82TiB used 701.03GiB path /dev/sdb1
>      devid    2 size 3.62TiB used 701.03GiB path /dev/sda1
>
> The dmesg log is in the attached file. Basically it just tell
>
> [111997.422691] BTRFS info (device sdb1): flagging fs with big metadata =
feature
> [111997.422716] BTRFS error (device sdb1): open_ctree failed

This no error message looks like some unrecognized mount option, mostly
for newer compression method (like zstd?)

Could you please provide the mount command to confirm if that's the case?

Another thing can help debugging is "btrfs check" output.

Thanks,
Qu
>
> Please help me recover my data.
>
> Thanks and regards.
> Dat
