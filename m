Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188B07DFE9C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 06:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKCFCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 01:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCFCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 01:02:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852861A4
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 22:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698987727; x=1699592527; i=quwenruo.btrfs@gmx.com;
        bh=n5aj+6nWMYyTT4cCrUcxvXrfKSVl5+0sa6WA8CtUi8s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=soOqcRgxCEVHE1Hb6fgi6A2MgNQQQb/mcSqVvCItxGYm9WkfdIjdDiF0EkdNMzSN
         /MdBGF2gWyxr7YPZ4V5PqM85gD8eldkIDrpGciiqaALlIJJoHNPVQJyHNhFXjm6CL
         IZPr4plCTIgIbjbJt1YNcsMPILOkgmxe8lK/l/PivZ6f5Is21KZtc0LvJzb3u+VOn
         NrNpTYMa48uLLoY6dLmHG+BnaO4w4to6Rsn5yzW1H8iMbnbKNL0++mwGxv363ttlF
         ZkRaaaCiOM9LCSVZFtO+ofC2hx64IsuCKqjyn1ejtK0rN+oYGy0f7KqchoHRs8aSl
         UaSzHzpKRb2PeEq9wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC30Z-1r8uGo0ehZ-00CUxa; Fri, 03
 Nov 2023 06:02:07 +0100
Message-ID: <f59db755-7aa3-4d13-89fc-78fb335da1de@gmx.com>
Date:   Fri, 3 Nov 2023 15:32:03 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <18fda4f8-8f3c-4dd1-8aca-667726e278df@oracle.com>
 <20231102201818.GI11264@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231102201818.GI11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ecuHnY5R6e2kvZmsIs4nVNyHdllnvGueB2Ni3F5DG6QGLgPLPU
 ZJQjf4iiAOn2snXS8E92awtNS9vrI11bIirCbMyvma8+CZ5wGxPh6uID3kF4UMzMs8YQ0nQ
 QSZqqRxtT1wf5srMQ+ggAGqo0xBT37bIFzrkU2KegZd7PazX1Y8xbPfJk8O6TJofDS6ujaf
 SplHq23owfm+WmzASZzIQ==
UI-OutboundReport: notjunk:1;M01:P0:ks+RWRKQFP8=;lALiZj1uCWKf9MZjYHsYNak6ABP
 pfxMFMi6kwO/p4A5Hw2/3SkpXo2n2tpDRhohWOhuHTfsR6wGg1lkU8KP9e7jIKwlGdSVhqi2Q
 M++E4FPEtHqO1C2lpQIvO1LcOkYTD4rwFkVG5e1pZvzQA3Kjc68Iv5HwcH8LISFAbW7EKntOx
 qMesfD29c92HCXqR92s4hMBVLqzkzTtFRpuK/wzc2Gb4C0PoN36mEC7gUh6x5EDYC4mzWccz2
 CIhohPFuXefPVPNKWLAjkZyErXlcftskezeESqu7JckM8+Y/Ls7ZGJ7rROZDo9VWfV6ePpibb
 jNVJggHr6NrxZk7qdXFtnllNhwmrIhtkcDPyB8OCC8ymBtYUUDsm0Uvcmv/Fi/6ip3VuZ6CU3
 /yp23SIRJR5KU0hqBPNvB9zGbPt7a2fsEM1JdwPcvM2ppdY1+IqrHtc5PEWwGtNwXtzOnaqxf
 Ig/1istPWLZx5WrsMw9YaWzcZZaOH6UqTzNgvwMy091pZ9mlWOjV6q3ZKNQ5SN93mTp8l8j9P
 MrqgUvczN/nnopKrIl/lU07hWKeOlTdPxDa+hzr5ieP61f3iVMCC3B+vLE8x4snfeYyjf7ihk
 a9NJ2BG6I4zg0RY0de74szNkOR+Qtt+62E2mazkqqyFvrKr2/XzupikdPn6zmIvcFL5gsTUl2
 d6ALmxgBEwMXatlUFH4jbUmFSZAylhL5IiPymb8TZW4R3IGx9kOwefPp7qPvrvIpI8q3Y3pPy
 K67LgqcZnBmBwPd7B1AoswQAof8hNzEBkImimCG/YSdIxYBZV5dEbDdcO6nAsIBRWDD+ukk2B
 /zCTjc/QdoZQK9mQVFm7YkavPKsMPU/4KTLWjHSbuLxvyBMKqdBkSW986VJfOaljTcPvF0FkB
 H+F8ZdMQUQwYJlCuniNBF8dydRL5v5wZV7ukwANfiW7BMTI05nbVLBag4jxLDmggpNuEnNhY8
 xLAeCvAbQX39T43Ar9x7xZOCoxQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/3 06:48, David Sterba wrote:
> On Thu, Nov 02, 2023 at 09:16:19AM +0800, Anand Jain wrote:
>> On 11/2/23 05:24, Qu Wenruo wrote:
>>> There is a feature request to add dmesg output when unmounting a btrfs=
.
>>>
>>> There are several alternative methods to do the same thing, but with
>>> their problems:
>>>
>>> - Use eBPF to watch btrfs_put_super()/open_ctree()
>>>     Not end user friendly, they have to dip their head into the source
>>>     code.
>>>
>>> - Watch for /sys/fs/<uuid>/
>>>     This is way more simpler, but still requires some simple device ->=
 uuid
>>>     lookups.
>>>     And a script needs to use inotify to watch /sys/fs/.
>>>
>>
>>
>>> Compared to all these, directly outputting the information into dmesg
>>> would be the most simple one, with both device and UUID included.
>>>
>>
>> Well, I submitted a patch for this in 2017, but I'm not sure why it
>> wasn't integrated or commented.
>>
>> https://lore.kernel.org/linux-btrfs/3352043d-dbb1-0055-f50a-c91ca43aff1=
d@oracle.com/
>
> I think you sent it more than once and that I replied, messages about
> mounting each subvolume (as in your patch) seem to be duplicating what
> eg. audit or some policy layer should do. The same comment is in the
> github issue.
>
> The patch here and the request is to track only the first and last mount
> of the same filesystem with a bit different use case, eg. properly
> waiting until lazy umount finishe, or in container environments to be
> sure that the last mount is gone.
>
> The suggested waiting on /sys/fs/btrfs/UUID could eventually wrapped in
> a subcommand, for conveniencie.

My bad, I didn't realize until I crafted the `btrfs monitor watch` command=
.

Inotify just doesn't work on sysfs....

So I believe for now, the patch is the best way to go, unless we want to
something like checking the sysfs every second...

Thanks,
Qu
