Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150056C5C8
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 03:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiGIBtR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 21:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGIBtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 21:49:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FA709BA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657331343;
        bh=JrEiVUoqL9+lyNfSSR4I8HKnkWQWoslZRKs/URy2MTY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=DUwXTZQaS1td9lhePBuaA3ccjo2n5O+qo5OInAWYWt+U9Njo8y4Kq+UQwvIED0Xus
         Wz/WGoW3KDq14y1OZEuPO0H8R1DnO5kpSN3QaCi47ZBEQrYrfxFSBjHP2b+g66JkFk
         jaO/zrC80JzAz2/OOlL6uop3I9iDEwARIsGzRWWY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wKq-1o8sap0bQi-003QoG; Sat, 09
 Jul 2022 03:49:03 +0200
Message-ID: <39218256-628f-dd47-57cc-65ae6ece1fec@gmx.com>
Date:   Sat, 9 Jul 2022 09:48:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Denis Roy <denisjroy@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1d43c273-5af3-6968-de18-d70a346b51aa@suse.com>
 <BD6F70A8-17FB-40E3-87DE-E185049DEA2E@gmail.com>
 <c7c50f16-92de-c9d2-d665-40f9556c6c80@gmx.com>
 <d7276c15-37d5-d4e5-cab5-0e2703216a95@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
In-Reply-To: <d7276c15-37d5-d4e5-cab5-0e2703216a95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UAzcbuRaSIGDclhtNyq3To6fjpCuRxB7PFtLraLCCqTLdR1laGK
 gDVMfYsVeCRm5mQ462zw4N9VWCrNLOYez4PwjEUTUff+0Vvj2AVJJxlaXPBIsksAT+LUnaU
 Ty86Bk2oXyFFFiKNqP6L/RvIj+0JJJy16aVVYlWN5UC3086olfkCvoYn1dwqE9juAR//BCJ
 B/fAhYjl2UKD6xjPqlh1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K/XBtrFa3tk=:roZb3jf3CCut/XW4kowPfq
 yebJGm6ehiawblzcifyBPr8S9Kgx2DVVEaYYBhDH2W5NX1jz+ER+66FysEmlL8NHE9QMl2cu7
 alRAMe5Q12gXZ9+OckdIRuKaEq6gIiqT+ujs5Co0Aitgmp1QFanLxYBbhcVztLJHpWV5lcxXf
 PUowyRi+U+gy8uOjHuIlVJwCRQKVtHPgwKC2+KvDJPPvNCh5kzns4g1Ik4J3fxtnrXcfC8/Z2
 glkZzVa/BIJ/WajrnZtPyUX0iCjIxZh/5I2YGFw0ch4u6t28LhvSFbnwenEn/7ISUlxSgIVLg
 cJnFOOSXjfolMRM0SmNyWWGPWaWrdO6u6F0DljUnBumH/CvlUM3WcILWj4iSFqlD8pvMrfBwT
 43TAnrfUfnOCRQo77onLGaKV79W2c0thEwuU7jqsS7EtG+Kycoev35vaCA+j2inbr1hZD2dJr
 Jub+YfKvccapuEbaYJ/Q4v4helFbegJG+72jJDIlPls6TnYqVRgwnVXNmO0mSEg3TO2Ts8yuZ
 vFNB3+F+bf0mrpl1GyOJu8AUePotE0A/kA++6YJtcKVBWlTb/E1v4zvGORrUvMvX1tD4pAYUi
 elyweGYMMJfHVLc0hfdrbPHW/rFqtQ4GpMMBGBF6jHUZxs8ueeOdJuQu0n7FSLkH1PX7756Vo
 ryLXIYd/IP/KuuEJlif9XmXMO+xqMyI5pLIG8RRdK2U295kr10ngQ7Y/y+5SOEJqtAlrLkGsF
 tq9F6vJBUYW648/nROJAu06DvgkBSBhRKH1WK6xwbac8quur5XZKlVnTVIdKi2Mno2yMN1doB
 hPPd1j5ZTIG0gWAMMLmfHj1lbB84GWiU2y7mARmXkLWIQXHY+rxJYedPassv5gAiJQkZWgHYn
 b1uwg35EbvLmGeV+ijS0jDPsGTQYAPs/nLkZh8ZueLuNVGSwSRw7OAdH9ESD/IaVbqv0tCNB5
 h+0OVjdX/pdS23v7tt84Eumo00cZl9lWq3y0TTuHjRywIP+674YJHvRgKlUx9HWJMGH2bIzg5
 DWAlFfmgs2NkAG2EyFH4evFUvlq29wMQcw4JyaYkGjTRosUW4sHc1ceIqLPQTdnGm8lD1GQ3H
 OPkKACvZqaYOO9hkLOeVLvqQu0pWUA5+W1L8A18ZxUNOIw+aapfGwEPGg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/9 09:34, Denis Roy wrote:
> Love to comply to run the latest version, but I past from my
> experiences. Maybe you could help me on update/upgrading so I can do the
> check. I trying to learn here, need some help

This can vary from very complex or even impossible (if your NAS has a
very rare setup, like using some rare archtecture/boot sequence) to as
simple as installing a distro (like debian or ubuntu).

If your NAS is an x86/x86_64 based system, then it may be much easier,
just try to find how to go into the BIOS, change the boot sequence and
try boot from LiveCD of your choice.


Otherwise, it will be a long long journey to find out a distro
supporting your device.

Thanks,
Qu
>
> On 2022-07-08 3:04 a.m., Qu Wenruo wrote:
>>
>>
>> On 2022/7/8 14:20, Denis Roy wrote:
>>> Ok, great. How do I do that?
>>
>> Considering you're using a vendor specific firmware/hardware, I don't
>> have any good suggestion, other than upgrade to the latest version the
>> vendor provides, and hope they upgraded the kernel.
>>
>> Or you may want to jump into the rabbit hole of running a common distro
>> on the NAS hardware so that you have full control of the system, but
>> lose all the out-of-box experience provided by those NAS vendors.
>>
>>
>> For the corrupted fs, you may want to run btrfs check (latest version
>> recommended) and post it.
>> Then we may be able to decide if the fs can be repaired properly.
>>
>> Thanks,
>> Qu
>>>
>>> Sent from my iPhone
>>>
>>>> On Jul 8, 2022, at 2:01 AM, Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> =EF=BB=BF
>>>>
>>>>> On 2022/7/8 13:50, Denis Roy wrote:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 key (7652251795456 EXTENT_ITEM 720575940630=
93760) block
>>>>> 12567101254720864896 (383517494345729) gen 72340209471334675
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 key (2959901138859622420 EXTENT_CSUM 366467=
6558733568) block
>>>>> 2234066886193184768 (68178310735876) gen 18374696375462128179
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 key (1153765929541501184 EXTENT_CSUM 0) blo=
ck 0 (0) gen 0
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 key (0 UNKNOWN.0 0) block 0 (0) gen 0
>>>>
>>>> The above dump shows the tree node is completely corrupted by some
>>>> weird data.
>>>>
>>>> The offending slot is not aligned, and its offset (extent size for
>>>> EXTENT_ITEM) is definitely not correct.
>>>>
>>>> But the offset looks like a bitflip:
>>>>
>>>> hex(72057594063093760) =3D '0x100000001800000'
>>>>
>>>> Ignoring the high bit, 0x1800000 is completely sane for the size of
>>>> an data extent.
>>>>
>>>> The next slot even has incorrect type, (EXTENT_CSUM) should not
>>>> occur in
>>>> extent tree, but this time I can not find a pattern in the corrupted
>>>> type.
>>>>
>>>> The offset, 3664676558733568, is also not aligned but without a
>>>> solid corruption pattern.
>>>>
>>>> And finally we have an UNKNOWN key, which should not occur there at
>>>> all.
>>>>
>>>>
>>>> So this looks like that tree node is by somehow screwed up in the
>>>> middle.
>>>> I don't have any clue how this could happen, but considering the
>>>> checksum still passed, it must happen at runtime.
>>>>
>>>>
>>>> For now, I can only recommend to go kernel newer than 5.11 which
>>>> introduced mandatory write-time tree block sanity check, and should
>>>> reject such bad tree block before it can be written to disk.
>>>>
>>>> Thanks,
>>>> Qu
