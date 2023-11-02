Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707D97DFC12
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 22:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjKBVj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBVjZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 17:39:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24225184
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698961154; x=1699565954; i=quwenruo.btrfs@gmx.com;
        bh=Rdp8NW5Dk1DaKqaIf+Av+r5XnJ9X1yPQ1Zy6vn2qpx0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=kvDyuBXoSiFEMD5oRzLqhytGzB4oQcqPKPUr3zpsdf4dDU5nYMJ1sF/wxpEQHzVd
         WbtM9+UzvJFCMnYmBhi/WZsPz+FBWZdz4hMT/ZHBFSGg832hWWQSn5VC7PfR3V1Ne
         bL3Pa1Y34yAKkqvYM7insU1zmYvAMxErmGCc2xOvYu4m2OefB6bHCqvk3PPxDjzB6
         pxbO4dpcuOGhPGw1HalmN8ojuUn4KvCQRtBa1tE72rNfDUglN5LMpbtNVRHRefn+L
         93qvMFjK8NE/n9xstqeqjRvgVdefHQqMStFj8mqKNyIroMhlmYurgYiW2xWpC4zMT
         uLgc727YmZ42MMQHbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSt8W-1qrcgp3Bks-00UGep; Thu, 02
 Nov 2023 22:39:14 +0100
Message-ID: <1035a27a-a1a9-492b-8d4d-3634367fece8@gmx.com>
Date:   Fri, 3 Nov 2023 08:09:10 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
 <20231102203529.GA119621@zen.localdomain>
 <12595173-fdc6-4e49-9e37-e97a6b7e8606@gmx.com>
 <20231102213430.GA123227@zen.localdomain>
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
In-Reply-To: <20231102213430.GA123227@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BG1DLF97/v2ENby03i0jkVipw0sksLPVMFbPBm75dUkBRZmBIV+
 XM0Nx0O4LFylRf9IvD2OZTVezpHCg8iexJbb//N7sfSi6D+ZMp/zseL72Lah4SZd7B3KPaa
 cEQv3ZC1we0dCpPEGjztVPE2JU0nD+uUoU2BHoHnOP9Aw3IzvO+BiFFHTXjmux1mV/RAMaW
 eiX/C2wNR2uKb/GHwL0SA==
UI-OutboundReport: notjunk:1;M01:P0:aVb707JUQpE=;Gg5QzZ3VDUqZmU/9OoDolr4tHRd
 ul4+PxYAB1TQUEXt5d1zII75Fpm7PCgHNd6G3svgNX/Sc1NOJNRQN5VtPF5qwSgKrbpB3EoBO
 MNSA5Hw8mOTqa1GgkmslOHw+Pq11S+vEHPmOZoD6cI2xwTpA3rT4TpNOAF33eOdofENnWAH4n
 g3y8hgsse+uGoj0zayHr7aleUU/+iotEjVZXniQM91HCO7pbDKiXOmZGACmkfW1+opFwYRqZw
 sv7AfKJNZQGraTAZDgogkLViirZ3SeyeRKAHaw9Gosk2RArLEsESW2NUWtlieB48VovzVACZw
 OpeEm2bDP/RbFyGAYRxDkEGXzay43MQEGexYONM9+8BvmcJQs2/fFD8lvig6uq8FBkFU8Fl0Y
 dbEoj1LW9zTNtmMPVh9gtR1E/PLK0S7L/p9Cwy6bqG0Kxfm3B1UPQ2whppq52SChFkxJDXqIB
 LcnKNZFWuLa0gGEmR66dcXOM/Vy4AEhaivKgdsWjiKEEN1EZPLcEVuXv1aI9vfXSZ3k1vXXLi
 OFPnGqdRxOsttS9JLHTjQ63eLTlCsGVrgRP5b+JLGCuJbZq1ZZM+I6tYGODllB5FaMhKeWfwg
 i8SLPko4sGjQ4iwI3/23uxuThcM1HPcMpLqXfDtAS0wFMmtgw2cn4yrvwblDA6CcMS/47yqNA
 KFFcXbZDHpCPeYq/yZxkeFOLOGM+ISo3BZ/EN6LzZdIcgqUcX9nnO6nwE9eXW9hh8ze3+/ttS
 2lJcv8rVKV5vaWSx4mbHPx0i2JL6PXI1CL5871qLed79faZqi0Cgcff2OGmr26vKG+ciYnXF+
 ps5o8tDM+gmXMi3O1wuoM+w6YF+XGjdoAgXyT1tkFgHUD4vRSTdxRx1352T7glY0zrDVRMFsC
 Hlnvfr9A7ckgULWq8yjrygxG8lckTBE9EyPyQtawNvhJLOXwnM0Vp2UFCA8dQrkujeoE5tQJY
 qLrvf6EUJU9wcj76Kp5l/V+pheg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/3 08:04, Boris Burkov wrote:
[...]
>>
>>
>> Another thing to mention is, that EXTENT_OWNER_REF seems to be inlined
>> only, has no keyed version.
>>
>> I have already come upon a rare corner case:
>>
>>    What if an EXTENT_ITEM is already so large that it can not add a new
>>    inline ref?
>>
>> I guess this can only be a problem for converting, as for now squota ca=
n
>> only be enabled at mkfs time, thus the new EXTENT_OWNER_REF can always
>> be inlined.
>
> It's a good point, but the answer is slightly subtler. You can enable
> squota on a live fs, it just doesn't/can't do the O(extents)
> conversion for existing extents. The owner ref is created for all *new*
> extent items, but when creating an extent item, you dictate the item
> size which leaves enough room for the inline refs (including the owner
> ref).

Oh, that's way safer.

Although I guess we may want btrfs-progs conversion support for an
unmounted btrfs in the future, in that case we may need to consider the
keyed version of EXTENT_OWNER_REF, to be able to handle an existing
large EXTENT_ITEM.

And of course, for the sake of consistency (since all the existing 4
types all can be inlined or keyed).

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>
>>>
>>> e.g., this works to fix it:
>>>
>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>> index 50fdc69fdddf..62150419c6d4 100644
>>> --- a/fs/btrfs/tree-checker.c
>>> +++ b/fs/btrfs/tree-checker.c
>>> @@ -1496,6 +1496,9 @@ static int check_extent_item(struct extent_buffe=
r *leaf,
>>>    				   inline_type);
>>>    			return -EUCLEAN;
>>>    		}
>>> +
>>> +		if (last_type =3D=3D BTRFS_EXTENT_OWNER_REF_KEY)
>>> +			goto next;
>>>    		if (inline_type < last_type) {
>>>    			extent_err(leaf, slot,
>>>    				   "inline ref out-of-order: has type %u, prev type %u",
>>> @@ -1512,6 +1515,7 @@ static int check_extent_item(struct extent_buffe=
r *leaf,
>>>    				   last_type, last_seq);
>>>    			return -EUCLEAN;
>>>    		}
>>> +next:
>>>    		last_type =3D inline_type;
>>>    		last_seq =3D seq;
>>>    		ptr +=3D btrfs_extent_inline_ref_size(inline_type);
>>>
>>>>
>>>> If so, can we fix it in the kernel first?
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> For a repro, btrfs/301 (available in the master fstests branch) fail=
s
>>>>> with the patch but passes without it.
