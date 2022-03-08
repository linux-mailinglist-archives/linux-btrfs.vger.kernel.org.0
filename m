Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA24D2527
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 02:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiCIBIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 20:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiCIBIW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 20:08:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA199E9E3
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 16:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646786985;
        bh=Ru3lG1znP5sqT839t0I+J9lBsJBR19ghgx9Ot7hJXYk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F7B6wNDntv+wRmbPp1MWhbhu0WxnvPFzTS9thZPF3JV5GvPKJLTfoEZfwJi9XROBY
         IAv6J77kDTJv13+YqD6aFbexPhVES58mwOO6PRAMcpAmpMw9Fa3tqe1JQCTzAShnic
         OLK9mEb+ceXiO6H9UskmffC+3AXLfA3O7EjzXA7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp5a-1nfwMt2Lwi-00Y6kQ; Wed, 09
 Mar 2022 00:40:24 +0100
Message-ID: <3f286144-d4c4-13f6-67d9-5928a94611af@gmx.com>
Date:   Wed, 9 Mar 2022 07:40:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
 <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nrW0VRGB+nqO/3iuOqsGkZEcK3kVFEKYCAU3t9oNtgy8GGc5cWN
 T9eHTCDw6nV4da3tGFQGLcp141ofwO8+cvPR+Wt9zk0wDcuMujKxUFRkF/rZtKqywYoy/DX
 +9pvDCbaG0PAOkQq/DvMt2JL8NmUpLJFUGTiwkqMYOdGeyvTP+AWrXSi29xmnhde7jsYDGr
 f8eW7uXtirhLcStix/Dwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9VpwUqKjEU=:lTa7XexmPpJHpx8AYwwRhu
 gedg8Cpcrro4mgjC4AuW1Z/J0EXUXntiEg+Y6q0b5KGE0IwgZCEhReeBryHNZt/FezD/qCkSz
 AdiYclZminQgw7Rt9fVGjPUG1NCDe9obdejOFkLcr3haUG5tXmQKdB194RyzicpmWCggv6DPG
 O72H9EehJ4H4wr5fFf0Qex4apR3C7+DUOEdsBvDcIClstAfgn3eG7hnm+fdatt852MlNb2XLC
 3tLeijqwVzYDxEOt0bT7k45vm7krpd19I2T1dGnPiqbUWFBQTwJwA480UvG2L7IT4PwKyt8BL
 luVdDz5t+2qAakmmq/AtvRjCy6AsnARrRGoMigQSsJVdBYn96LwX4Z27qv2LnKkTzy+z/jUmE
 XvrEWHDDtKgeLqomojRqz4n5FTPjbf1dW5Rh8Jzs/geWtm43L/qJjj1FXCKfZkDKCi0gwQLFJ
 UFGr/mZ1z+8GTb9xfN/UtO4OSHDXSDXRhY/X6QV5l5kffFOZxolTgsOZpIlbXbCj4yw1HxZ/6
 ut2q3o3kBt2k8/AfWoc4lObPaOPMQzRKXBoN0ZliGAmDab3r6YlCIxjclbI0P2hkS9hlL9n5Y
 KdR/Udny84UEeW6rp3ryzubsHNIMJ06svJQtKzeMEvmutiiX7Nm7ni6IR1enJZkXjaR1rkMzY
 n84dADBAUpWsNjddMvjg5ebcu8PmHquFmYjMgy3UN9Nro9sY78eILVe7ZldqM6m+gHqi2ZRsw
 1wr94oMdKsQmnlVuT9cpj55MucMRQat3U8KVS0Nff3b16HdutdgiePARkujpGe/i+u+kWtvRo
 e6Op4kTDreXpBb/IknSBapg1pX+yv4HfCNkOqx1n0KSortj4lDxUkNvfD/Uzf/PBufXxloTC4
 VmhQ9/DHUhc/ikuyG8DQTxDXA2ENrynyB91Ogi0I250HN5qHyykSs5aAyqebThFbwN85BUeYR
 hNNHZUvDnNzlY64BXPYF0O7ZHiMBM15FIf5FuQ/VPX4KgG+IlLyYMlIFB7Kmr+g+irJTzLQww
 GOYh0oZggcN9ArN/1rHMzk8kxkjqUqgAL7BeSepKhIfpLhhXIVZe/hocDzJAPq20oOOEnvCu7
 U4WIiUSxR6w9yw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 05:57, Jan Ziak wrote:
> On Mon, Mar 7, 2022 at 3:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> On 2022/3/7 10:23, Jan Ziak wrote:
>>> BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
>>> (uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
>>> file-with-million-extents" doesn't finish even after several minutes
>>> of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
>>> ioctl syscalls per second - and appears to be slowing down as the
>>> value of the "fm_start" ioctl argument grows; e2fsprogs version
>>> 1.46.5). It would be nice if filefrag was faster than just a few
>>> ioctls per second.
>>
>> This is mostly a race with autodefrag.
>>
>> Both are using file extent map, thus if autodefrag is still trying to
>> redirty the file again and again, it would definitely cause problems fo=
r
>> anything also using file extent map.
>
> It isn't caused by a race with autodefrag, but by something else.
> Autodefrag was turned off when I was running "filefrag
> file-with-million-extents".
>
> $ /usr/bin/time filefrag file-with-million-extents.sqlite
> Ctrl+C Command terminated by signal 2
> 0.000000 user, 4.327145 system, 0:04.331167 elapsed, 99% CPU

Too many file extents will slow down the full fiemap call.

If you use ranged fiemap, like:

  xfs_io -c "fiemap -v 0 4k" <file>

It should finish very quick.

BTW, I have send out a new autodefrag patch and CCed you.
Mind to test that patch? (Better with trace events enabled)

Thanks,
Qu

>
> Sincerely
> Jan
