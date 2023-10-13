Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A17C904A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Oct 2023 00:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMWcY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 18:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWcX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 18:32:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E736BB
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1697236338; x=1697841138; i=quwenruo.btrfs@gmx.com;
 bh=tgraNp3EqUGF1iWru/y+bubaEKfvfOMqR62wJQxyAcY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Jb0Iqhk3WAEEtq4FdCzsPa2D27IeCYW+ilKL4qW5+XdeEc179HNXL2vg7lh2WuRk1JsbqUJZVc1
 PJwD2++m3rRgf8MqzBL51zUDKupJ1wGnQ9JBdiWCmd7brsAboDVyye8z/QdwHyFJJgcKKThTdgnlt
 KYmlPecjtu6fRvBsgeo6nfB/7D2DFE2NcpJlB/spyqVrk28O7kqvw8fPNHoeDE97KC2GSvdEOFzWY
 rwKp/N9j7HTzc3H5J7T6ATISfaJ9WUBpzxRr42LSyYEd4rVlP/cM4LRcT4d4vylJGA4SWok/T51BW
 488f62LOLRTg23kOjkC5yczzaXJytTwNpwjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNKm0-1rBjlw0UBu-00OpoD; Sat, 14
 Oct 2023 00:32:18 +0200
Message-ID: <7bcaeca0-641a-43e8-8ffb-1f729e5e327d@gmx.com>
Date:   Sat, 14 Oct 2023 09:02:14 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
Content-Language: en-US
To:     fdavidl073rnovn@tutanota.com
Cc:     Qu Wenruo <wqu@suse.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <NeBMdyL--3-9@tutanota.com>
 <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com>
 <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com> <NeKx2tK--3-9@tutanota.com>
 <NfJJCdh--3-9@tutanota.com> <4cb27e5b-2903-4079-8e72-d9db2f19ced7@gmx.com>
 <NfT7gZI--3-9@tutanota.com> <d6fb2fd0-8c59-449c-a342-84eb908de969@gmx.com>
 <Ngf8uVZ--7-9@tutanota.com>
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
In-Reply-To: <Ngf8uVZ--7-9@tutanota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h0E6AIJ560+00aNNc2yRdfDXltmwN3irAtMt+8+gKMAgRo8Rsrl
 Jj3y91YltixGSViI1GFfEz+2Y58YlWFhGrFCsJAuYTNm6KoPxKy/tb1W+sY6TpJwjQ3hw6c
 UsgLcsz2WxUH8c1+7ARWKT4Uz+0hUJbUJ7ByAi0g/NJt75Gkrr8hM7qQeeQ5VBOYzTPeRIy
 ObUsopaYx9PLjvSKuqVqQ==
UI-OutboundReport: notjunk:1;M01:P0:kydPgHmKyQU=;VxiMv8zi/8KxeR2ypUeYtYDkg67
 dWGN5HYVAmCdj9HtmbwW+grO5QfR6epQOtccLWf+hkDyTzR/IkRhhvIe+9Wpwp8SfGtrgJ1Zo
 4U3AUADH7dpFgPynMJlZ1F+Zu9PXPxq+7/MUN2rrkg78NMP0AIyxDhxdE0d5KASvXYDMwCzwH
 BRlMaatcEQGAIazq9C5O0K+RPfdjEIbcOVU+tnb7/L6frhiz7PgVnYTPP05VJ4jRhmCeT2tXt
 RUwvJ27SJMmzgsMy/ufVhfdfwTICM0og1H4GKMnF58oGoQD7cIosVUrX74R52Y4sxbcUe/KSS
 FG09GsC/mjFrkzfwOxD0PPsAea08KW9gu7900Ddg7CRxC/Vou+ezc7k3rV/uPP/km+lka2xIf
 DpDWYKiIP+sO9il/XUihtt7BhT3v8WmoHQUexEUaNPJb5anGvE/memaehxbZsvAuMinK5aSg9
 Bv5BTzapRRL07bvAoTXP5k4ZqeTdQKdTdJbY9BV4aScMlJ6GCl/wvrElrJa/FjPDmIQfiXwjY
 PUSWApHFyIXwJKTkdCjvoNkxc1W68q9n3VhyE20nTy2cEYMRIN0FNffNssF9qoi7JNKnwtt73
 Yrg2PWueHPTyXyINU18pAADPe17IenjZQTHbOvpO7v2sUiCavSsSVFPfOTYXFH1UOPK2rdma2
 HYQIv+rww+TOjX8gqsvAqSyXcBJ7SKb0JQGndMphTcqQCU+ZuR2yMIHQRvyDARSas28LWeaYl
 DzTUu6Y8gGxtk39Ux9k6jLx5TZpAkcPHltDdO9RsYz4lfYxpoSdizgiEJYXDhaCel2wRjkTtQ
 va4Rh+lEd0SXaGE4kTNWSALJrF+IXjkGoWxG3YSmrG/0ilz70mR2/zSuumxzn7pCbLjPNmYR7
 HwYls66fDNikhpFznyYxH4cmS7pFNqbYe5Yqlw3+/c0YfziukUtpZA6oE8p0FAe+JgQkHpXoH
 ifhx2YonQeeaNfPeLwyM9HrfKJk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/14 08:58, fdavidl073rnovn@tutanota.com wrote:
>
> Sep 29, 2023, 01:02 by quwenruo.btrfs@gmx.com:
>
>>
>>
>> On 2023/9/29 09:02, fdavidl073rnovn@tutanota.com wrote:
>>
>>>
>>>
>>> Sep 27, 2023, 04:53 by quwenruo.btrfs@gmx.com:
>>>
>>>>
>>>> The compression is the easily way to create tons of small file extent=
s
>>>> (the limit of a compressed extent is only 128K).
>>>>
>>>> Furthermore, each file extent would need an in-memory structure (stru=
ct
>>>> extent_map, for a debug kernel, it's 122 bytes) to cache the contents=
.
>>>>
>>>> Thus for a 8TiB file with all compressed file extents at their max si=
ze
>>>> (pretty common if it's only for backup).
>>>> Then we still have 512M file extents.
>>>>
>>>> Just multiple that by 122, you can see how this go crazy.
>>>>
>>>> But still, if you're only deleting the file, the result shouldn't go
>>>> this crazy, as deleting itself won't try to read the file extents thu=
s
>>>> no such cache.
>>>>
>>>> However as long as we start doing read/write, the cache can go very
>>>> large, especially if you use compress, and only get released when the
>>>> whole inode get released from kernel.
>>>>
>>>> On the other hand, if you go uncompressed data, the maximum file exte=
nt
>>>> size is enlarged to 128M (a 1024x increase), thus a huge reduce in th=
e
>>>> number of extents.
>>>>
>>>> In the long run I guess we need some way to release the extent_map wh=
en
>>>> low on memory.
>>>> But for now, I'm afraid I don't have better suggestion other than
>>>> turning off compression and defrag the compressed files using newer
>>>> kernel (v6.2 and newer).
>>>>
>>>> In v6.2, there is a patch to prevent defrag from populating the exten=
t
>>>> map cache, thus it won't take all the memory just by defrag.
>>>> And with all those files converted from compression, I believe the
>>>> situation would be greatly improved.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>> The backup itself is gone and will need to be re-sent. If I'm understa=
nding things properly then by mounting the btrfs device for the backup wit=
hout compression and enforcing send protocol one it should be written unco=
mpressed which will avoid the issue correct?
>>>
>>
>> IIRC yes.
>>
>> The send stream only contains the decompressed content, thus as long as
>> it's mounted without compression, the received data on-disk would not b=
e
>> compressed either.
>>
>>>
>>> I was also looking at the source code and it seems relatively straight=
 forward to change BTRFS_MAX_COMPRESSED and BTRFS_MAX_UNCOMPRESSED to SZ_1=
28M or somewhere in between like SZ_8M. Do you have any thoughts on how we=
ll that might work?
>>>
>>
>> The size is a trade-off between space wasted by COW and memory needed t=
o
>> decompress an extent.
>>
>> Remember even if we only need part of the compressed extent, we still
>> need to decompress the whole extent.
>> Image if we have to read 8 compressed extents in the same time, and the
>> BTRFS_MAX_COMPRESSED is 128M.
>>
>> So I'm afraid we can not got super large on the value.
>>
>>>
>>> Do you have any idea on how complicated the long term fix is or when i=
t might added? v6.8 maybe?
>>>
>>
>> At least not near term, I'm not aware of any ongoing project related to
>> this.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thank you for your prompt responses. Sending the backup again will tak=
e some days but I will email you to tell you if disabling compression fixe=
s the issue.
>>>
>>> Sincerely,
>>> David
>>>
> To follow up on this I was successfully able to transfer my backup then =
both make and delete snapshots of it without running out of memory. I will=
 update my ticket on there bug tracker if and I think there should be a wa=
rning about this in the documents.
>
> Is there anything else I can do to make sure this is addressed at some p=
oint? I would like to eventually be able to re-enable compression as it wa=
s saving me several terabytes.

I believe Filipe is working on improving the extent map code recently.
You may want to test his patchset when it comes out.

Otherwise you may need to keep away from compression for now.

Thanks,
Qu
>
> Sincerely,
> David
