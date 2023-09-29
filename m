Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F097B2A0F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 03:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjI2BCL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 21:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2BCK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 21:02:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A6B4
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 18:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695949322; x=1696554122; i=quwenruo.btrfs@gmx.com;
 bh=g+SVo/aiZGnwpyByA/uml5uuZ076nH2FrysY/fvwnXM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=STNMNEDiAvtFccVHyupqQlQUT6n6+WXJw2LUwBgBkhr1XJzUP0CcYJBRyGl4DYrBtyUjmAOev6g
 bo7zGTOOwKYPrBl32o1WpeNpTG7xz3LXPQwoPmUTL1NzEM//gHb8bqnzZhM8/Ngin2ptKnMa5HaLW
 rkZo01hAJcDzUGDJ6rRvZki9J6NUp6kp21MZdx2Tcci20OojKdEUiAvrMs2Nhi+kvW+A1cH6upSCm
 lkSL3USxonhOwothtyLEj2g8+gAApeaLI0kMUDkBuhYCuMdizFT6Tne2Hgd+/MkdG+lOOgBfCCrky
 /ydDgpmGdJRUIV5/+5puYt0dbofJ+PzJte/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY6Cb-1r9T8h0gSD-00YNsn; Fri, 29
 Sep 2023 03:02:02 +0200
Message-ID: <d6fb2fd0-8c59-449c-a342-84eb908de969@gmx.com>
Date:   Fri, 29 Sep 2023 10:31:58 +0930
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
 <NfT7gZI--3-9@tutanota.com>
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
In-Reply-To: <NfT7gZI--3-9@tutanota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nw33WxsEVtp2BhHRp75XiaIjii+wdn851ZklNZddZrgnvPlpmsA
 QOrStLJvsT7GxsD5sDM8ADShxlQ2zLHPFmL0WBjHmBblw+zUDbgAlpshPNCgU7JEfJF5A2Q
 joE2fn5meo3W1OrehCQsGHUplneXnL8oYncxInaotaSabKBu97/XnnwGQGXKzqSJMVKvp/4
 f6BooLaE9l9sRngFdVoAA==
UI-OutboundReport: notjunk:1;M01:P0:IJ66wHwXc8g=;2iM+AVvnlPjqgkO4EVoKFpW63uU
 df80kwmHS+uGrxV6qmQhOjvR0z5W6/4hspXyH9IfSIv2698nGtR9SXz0Vrsz1IwNglHXUDY2l
 lUsHr+w8mB9Vm0sMbr95BNQZClYR3bHtKZYozB2HgMLzrs2QczNr1zmVcxOpRpMnms0x8zADZ
 WiqMPrKhgT7P2Air81geMXbuVG7E2J5Q07VaFcrFfdPez5vTxAbQtMf9QaYZ0WPfRlS4ErZ6M
 a7wyjtfd+n+kZWxhJ7VnWqrReobJugtDA6ApI7pCvot16PSUNLwRDNEQKmcSijpFBvqIvjGjJ
 /I1X7KZRKfLF1olIMOKJF39RcoC0bHXdLaD7N0YK30oXpcUuYRSA3fD87OXAPqs0iPylqdEU5
 5BpEgw1wFkMEUE4BJi9V+slTOtahDrZ0au02JTPS3kviYcOWojKovNzc+YvcVSVJElXu1T0C+
 wWRpww6zLuuJxSDA+3CXpDRxYLWfsvqFmqz7cFK50tUC2VpSrowjAzgTu6VaHqbkfVW6xpfC4
 dvnEv+gswxXiAcoa9RNgffGbU2gKbDnoJJlCyoMCKgBIS4QzyQehLzmBWaOUuMJ4grYjjxIrM
 MW+gj+xnnY80E3YbkXg4oM7qpBypUYdaoMM/A7N4KlBfBNaDu7c0lCxl9PYYiK0PqiPYQhcFv
 Ey5dsyW4Be7Ez47UvdmhsEBEEzB97CEh9z3SBFIiKfoWe7CzIHgm1urVA2TinhGZhLpZP8+4q
 +ilJGmvwU3zeA055iNBWJx6OpJFaSdIRgk3+p2Rat+OI/C6mNxmvuwsFToQ6NlTKmsyiBi3mG
 bY+EyV2AGjol+rUtnrwO/KiQ6OKd7W9eEPBY17LtyGGmgrNkL30xoBi6TM4W7OQVRUu0ejdPH
 U6h64/LXv/1pNpNyXxwPGp8GZFtVS49ZNa7GiiVDRVulhq2JLbDCi4vrcAPnwWyNzNwrOFRuu
 bcGhEJXl5Jo9GM1RVlJIWPW1Ms0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/29 09:02, fdavidl073rnovn@tutanota.com wrote:
>
>
> Sep 27, 2023, 04:53 by quwenruo.btrfs@gmx.com:
>
>>
>> The compression is the easily way to create tons of small file extents
>> (the limit of a compressed extent is only 128K).
>>
>> Furthermore, each file extent would need an in-memory structure (struct
>> extent_map, for a debug kernel, it's 122 bytes) to cache the contents.
>>
>> Thus for a 8TiB file with all compressed file extents at their max size
>> (pretty common if it's only for backup).
>> Then we still have 512M file extents.
>>
>> Just multiple that by 122, you can see how this go crazy.
>>
>> But still, if you're only deleting the file, the result shouldn't go
>> this crazy, as deleting itself won't try to read the file extents thus
>> no such cache.
>>
>> However as long as we start doing read/write, the cache can go very
>> large, especially if you use compress, and only get released when the
>> whole inode get released from kernel.
>>
>> On the other hand, if you go uncompressed data, the maximum file extent
>> size is enlarged to 128M (a 1024x increase), thus a huge reduce in the
>> number of extents.
>>
>> In the long run I guess we need some way to release the extent_map when
>> low on memory.
>> But for now, I'm afraid I don't have better suggestion other than
>> turning off compression and defrag the compressed files using newer
>> kernel (v6.2 and newer).
>>
>> In v6.2, there is a patch to prevent defrag from populating the extent
>> map cache, thus it won't take all the memory just by defrag.
>> And with all those files converted from compression, I believe the
>> situation would be greatly improved.
>>
>> Thanks,
>> Qu
>>
> The backup itself is gone and will need to be re-sent. If I'm understand=
ing things properly then by mounting the btrfs device for the backup witho=
ut compression and enforcing send protocol one it should be written uncomp=
ressed which will avoid the issue correct?

IIRC yes.

The send stream only contains the decompressed content, thus as long as
it's mounted without compression, the received data on-disk would not be
compressed either.

>
> I was also looking at the source code and it seems relatively straight f=
orward to change BTRFS_MAX_COMPRESSED and BTRFS_MAX_UNCOMPRESSED to SZ_128=
M or somewhere in between like SZ_8M. Do you have any thoughts on how well=
 that might work?

The size is a trade-off between space wasted by COW and memory needed to
decompress an extent.

Remember even if we only need part of the compressed extent, we still
need to decompress the whole extent.
Image if we have to read 8 compressed extents in the same time, and the
BTRFS_MAX_COMPRESSED is 128M.

So I'm afraid we can not got super large on the value.
>
> Do you have any idea on how complicated the long term fix is or when it =
might added? v6.8 maybe?

At least not near term, I'm not aware of any ongoing project related to
this.

Thanks,
Qu
>
> Thank you for your prompt responses. Sending the backup again will take =
some days but I will email you to tell you if disabling compression fixes =
the issue.
>
> Sincerely,
> David
