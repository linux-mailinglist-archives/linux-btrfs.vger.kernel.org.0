Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20C7A6D59
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjISVvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Sep 2023 17:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISVvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Sep 2023 17:51:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1FBD;
        Tue, 19 Sep 2023 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695160256; x=1695765056; i=quwenruo.btrfs@gmx.com;
 bh=PsCGZ/T8xmLzRdlXzocORqNkiwMoQvmWK8mCJE4vLsI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Cn4ud0uvfoFjXnqOIxSgJJ4o88Wm2TtcMu3i2WsZj2OWvpMUY/Z4Hgt52mJdtWlBYg22dYWzV5V
 5u21dRDWcw7eyI598BKVz2AWfm3IsqClZMzu9/iFqQlkGJ63Jkrk6d8Q5kNkZob7mc3vtMChtrwB0
 khiWTHHiW/jRIORjgEH+EGiYcKyRr5oIWp11cw/oN9koEAZm2TcCckk2e8cfpHZkyIFmWr5xfAVnp
 CAhZD8ySPyCdONV4uBPZs+zYDJLlVfPNugNjLz6/JH9SuxjYwv5qG8GFR21JmMBlFauhQ4AsU0u+q
 KZxYsoxuH3pD23OCiKgjU7PJkT8Hk0ZjH6hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6lpM-1qlSAT3UBK-008LT5; Tue, 19
 Sep 2023 23:50:56 +0200
Message-ID: <a364f344-b718-48ff-9e2a-484c5ded6e7f@gmx.com>
Date:   Wed, 20 Sep 2023 07:20:49 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
To:     dsterba@suse.cz
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
 <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
 <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
 <20230918162448.GI2747@suse.cz>
 <a0a5c7a3-4e55-4490-a2f9-fae2b0247829@gmx.com>
 <20230919135810.GT2747@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <20230919135810.GT2747@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zmGi369qwQvSdVaxP1uO76xVj82gXJKp3l/ubSryUUBREuPsdks
 rrobnypNpnu0o0DBf0SvPUkMtWnKc+1Ntn+UBPNnvbqsFqqRa0KmMRo0A4Kz/uC1gRXU5G9
 N0XzyYeN+rjXUhlGWBgkhDxZwbBZXlKPSec0GbmfYb/DhYlWl5MQOSwdcTdtuZYNcadJqo6
 NQz8PPbpue8DZG2Wq99YA==
UI-OutboundReport: notjunk:1;M01:P0:Xe7D27dGaVg=;P8QDX1wyPkWCu64NBzyHrk64UYY
 xgTAUZKwE76HVmAB8Nx1VHUDRIXHrEcHqeNj6FqZlAClrvdXXsepk0/3lq2BkMaWJvN31y+uS
 iyvQ8nKYnYo4+RvCI+8J0TRwBbDZ+XJuuIhRSkO++dZaLElSwxm4+Rv8R369oY3cnZ2VcRkBo
 3gXwYPROB9sBLaFb1Wtpn2yx1xFBNsC9poXuJDtVqXlQNE6UlbmXOdjksYMxTVIx7e0+S7MLV
 dQRkc1/0vuLtQRvap+1Z/0ELRR43Njb+FQb8aLQD8/4r75hZF20xKYypbkSXs6yGQhPU4TIu5
 w5FMtHukRU0QCYC7qxu6Tv9TFZ5FSXXjpQpkqWUVwtch59setz756YuGS4MtqyMIqcpoW2/kL
 dCugTTM8vIQ4LfJzmOiYb/VUxyHuLH/UrAorS76cPIqHNlcaB/WBukdT5Vhqg3jaRCo57ZPmM
 0l9no6SZcKt1bAkjm1Lh5CU8jNmiTE95L5cSottyBqYxTEq0a/ozFX95Usj3/45LjFx7+FhWL
 GezqgVfvba/rvRuuF7k5hw53PrnmuIQiQUV81eWE5T1EQjEhIsOky+9qlw33cR0aoVCAcqHzL
 RjZv1GW3dfFo5OJg5vtwb2xArx7GwBCmOE06YmoRL/4+JcUunCfSkt5XqksubsriCUJIiGzfi
 yFgnk86FilKzcU8gCNsNIV4qaPqhV8t2crPBc0bvReAjaVAj7xPALSg8z+/Ex5+kmc3oQYCRV
 1DnfJ7ZPw+ay2tPa9K5ArOrl3Zv2/lMvP9qyGubCKU3wHFxSAvWqsWYgQlQ+OxTlvGzn5kuxh
 s1JcID3eZo8RHO6r9k10AUaHdnAgo+W1aRr9p/r22tOwItZB8OYMYm5G0qncKqYvbJQ/R6Jjs
 xyFMEWI1JT5flvXdGt5YCzLRK/Z3qhvvfqQHj+KnoTMq2AHfz0lzDrznciw44HTtVXOgnNI50
 fO7wAA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/19 23:28, David Sterba wrote:
> On Tue, Sep 19, 2023 at 10:07:00AM +0930, Qu Wenruo wrote:
>> On 2023/9/19 01:54, David Sterba wrote:
>>> On Mon, Sep 18, 2023 at 03:03:10PM +0000, Johannes Thumshirn wrote:
>>>> On 18.09.23 16:19, Geert Uytterhoeven wrote:
>>>>> Hi Johannes,
>>>>>
>>>>> On Mon, Sep 18, 2023 at 4:14=E2=80=AFPM Johannes Thumshirn
>>>>> <johannes.thumshirn@wdc.com> wrote:
>>>>>> Fix modpost error due to 64bit division on 32bit systems in
>>>>>> btrfs_insert_striped_mirrored_raid_extents.
>>>>>>
>>>>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/fs/btrfs/raid-stripe-tree.c
>>>>>> +++ b/fs/btrfs/raid-stripe-tree.c
>>>>>> @@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid=
_extents(
>>>>>>     {
>>>>>>            struct btrfs_io_context *bioc;
>>>>>>            struct btrfs_io_context *rbioc;
>>>>>> -       const int nstripes =3D list_count_nodes(&ordered->bioc_list=
);
>>>>>> -       const int index =3D btrfs_bg_flags_to_raid_index(map_type);
>>>>>> -       const int substripes =3D btrfs_raid_array[index].sub_stripe=
s;
>>>>>> -       const int max_stripes =3D trans->fs_info->fs_devices->rw_de=
vices / substripes;
>>>>>> +       const size_t nstripes =3D list_count_nodes(&ordered->bioc_l=
ist);
>>>>>> +       const enum btrfs_raid_types index =3D btrfs_bg_flags_to_rai=
d_index(map_type);
>>>>>> +       const u8 substripes =3D btrfs_raid_array[index].sub_stripes=
;
>>>>>> +       const int max_stripes =3D div_u64(trans->fs_info->fs_device=
s->rw_devices, substripes);
>>>>>
>>>>> What if the quotient does not fit in a signed 32-bit value?
>>>>
>>>> Then you've bought a lot of HDDs ;-)
>>>>
>>>> Jokes aside, yes this is theoretically correct. Dave can you fix
>>>> max_stripes up to be u64 when applying?
>>>
>>> I think we can keep it int, or unsigned int if needed, we can't hit su=
ch
>>> huge values for rw_devices. The 'theoretically' would fit for a machin=
e
>>> with infinite resources, otherwise the maximum number of devices I'd
>>> expect is a few thousand.
>>
>> In fact, we already have an check in btrfs_validate_super(), if the
>> num_devices is over 1<<31, we would reject the fs.
>
> No, it's just a warning in that case.

We can make it a proper reject.

>
>> I think we should be safe to further reduce the threshold.
>>
>> U16_MAX sounds a valid and sane value to me.
>> If no rejection I can send out a patch for this.
>>
>> And later change internal rw_devices/num_devices to u16.
>
> U16 does not make sense here, it's not a native int type on many
> architectures and generates awkward assembly code. We use it in
> justified cases where it's saving space in structures that are allocated
> thousand times. The arbitrary limit 65536 is probably sane but not
> much different than 1<<31, practically not hit and was useful to
> note fuzzed superblocks.

OK, we can make it unsigned int (mostly u32) for fs_info::*_devices, but
still do extra limits on things like device add to limit it to U16_MAX.

Would this be a better solution?
At least it would still half the width while keep it native to most (if
not all) archs.

Thanks,
Qu
