Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E277A569E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 02:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjISAhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 20:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISAhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 20:37:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AD98E;
        Mon, 18 Sep 2023 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695083826; x=1695688626; i=quwenruo.btrfs@gmx.com;
 bh=Vsshq0J5dMVAnGNx93Po1CDB8savgZn4lYGAa8RnC3M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TfEO55ZudSqHvAlSCHo1iDTpq+Us6R53lArvR9/btjK7Mr5emwC4VWPSp1XHhwDc+An3Us5UtTC
 ROFMh1eIDWkFPT8srN6kicG9F4+KgvgGudRM30wio2J8QRyWwBOCDg5YMhvRDjL7fg6zO33szAMEU
 XRlig5u2bL6RjBzNEau8jWNBhqFFjeg6Fv0g4SMs95AoMJevHOOJRJAL6HsehtDsSmgwZSskfhtl0
 rtfdSLcFzb6VtgV1ueek1hEBvM4l64VW3OAchCoSd6mgs6unx3jf4t3OBv0D6G+vrq0Gd6qFM0jCV
 fZydILUDs9LRW/JHC36TfTtCSd7cyOsmfO0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRk3-1rFWZ63laj-00btlu; Tue, 19
 Sep 2023 02:37:06 +0200
Message-ID: <a0a5c7a3-4e55-4490-a2f9-fae2b0247829@gmx.com>
Date:   Tue, 19 Sep 2023 10:07:00 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
Content-Language: en-US
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
 <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
 <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
 <20230918162448.GI2747@suse.cz>
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
In-Reply-To: <20230918162448.GI2747@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g6wU1E3eS03p7ukyt5DQ8Th6LKa0MjsAkw+cckrqx+z84LW+Cf9
 W2sqJ1phYSxbJgtjD69fX4/mTxE9fgGUHVEPCaj3bMh+JOWCbFXgl9GhFMpmBiNMVmvGnRV
 D70/OIA6FTHRMyM3BZrHHLWNgNB+QSWwYB3ysYpMkQ84MOkYPwuE5iIhm7oPY2YXOekHUt1
 oKaxaMua3aceD+i6+m1MA==
UI-OutboundReport: notjunk:1;M01:P0:K3fp69p0tcc=;Xmdc9S+tM46YMzT2cyKrbc0vB3E
 0eLjhZpNqcoi/nCWNmFT3aqvfblCSBCfYc3KK/DK8iGDSPRd7eA7Dcsc8ufAzBu0tpvU0tY79
 UtI7MHWn7lWQCfL1fkQm/nGubWYwGgpWrtlhqD9WJcVgBee/jyd6a0COHHYjMBW2TXUeH06mn
 2AlINejkLfWP/zZ+V6KYsrcIDXqKVK7HbV5Zc3UQseGRWkxk/S4rJDiep1QB63vttUfKjbPkp
 BsTFOlnQQ3+rO+GQC3+NTm2P2gDX0JIaFefJTPvdCvDMBrF00wCxmgmSNDa2I+g75X5IGby/2
 LKsGYHXzUoFWPwMpvjgvARgc9oTVqVIyDkj/BMyz2JpbgL4RFUHLPof1asFt9Rr0zvDFqvJDJ
 83ah2ZxEO/bqYievVp2Emus6nnnH1c+oOTXuH+hqKihlZeoplzfk7rRp7xSyvoWn9PhrADl1n
 4RObNPaf5YXWwKmYgJ1kVqbUQFosB+B1PMb2aOk7Y2iy/s7wM+v0KVxIWzaav2C+sIL56ln8c
 3WsDqOsq2hsW/1J5oLEyPugHaYfkwAT7IP9HkHxoR+aXYVxw6Gy33GCCPLIrc4CgEdLz8NYhE
 XyirNGLuRKZbY/9mUinjJ1S3eoQXk4x50f+lhrgziL0gwvOk7q/PJ3ZygwzCQVTDq+ZrtPhJS
 aWCzoGiSnqLCx+u1RCh+TqxFRt/XrZRzAgIrIgoyo2dW1G4C2nJFla7RDDTmhy+g/54OeHmVZ
 mv0ecA1lc9ZAXrjn8Jm97B8ZaCxcpJmvPYyNh4+h/RURvkwKS+InEY/Opj/4oJh8BgfKJ5hqe
 8AphwxZlWX2WtWLHWGEwbSviIz6V3WjQ4EqlWYd4+21DaH2ST7ZVgHStFeqKcEdFUc6weaqIj
 QSOkQohTi5bXa0wChD4nd3WVJjxOegXOp/eDRc1GXtg1k9xeaOFXFC0elOSqbqAHDh6sviyOU
 KbV12jbH98qiiyP9j988i0GlgC8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/19 01:54, David Sterba wrote:
> On Mon, Sep 18, 2023 at 03:03:10PM +0000, Johannes Thumshirn wrote:
>> On 18.09.23 16:19, Geert Uytterhoeven wrote:
>>> Hi Johannes,
>>>
>>> On Mon, Sep 18, 2023 at 4:14=E2=80=AFPM Johannes Thumshirn
>>> <johannes.thumshirn@wdc.com> wrote:
>>>> Fix modpost error due to 64bit division on 32bit systems in
>>>> btrfs_insert_striped_mirrored_raid_extents.
>>>>
>>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/fs/btrfs/raid-stripe-tree.c
>>>> +++ b/fs/btrfs/raid-stripe-tree.c
>>>> @@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid_e=
xtents(
>>>>    {
>>>>           struct btrfs_io_context *bioc;
>>>>           struct btrfs_io_context *rbioc;
>>>> -       const int nstripes =3D list_count_nodes(&ordered->bioc_list);
>>>> -       const int index =3D btrfs_bg_flags_to_raid_index(map_type);
>>>> -       const int substripes =3D btrfs_raid_array[index].sub_stripes;
>>>> -       const int max_stripes =3D trans->fs_info->fs_devices->rw_devi=
ces / substripes;
>>>> +       const size_t nstripes =3D list_count_nodes(&ordered->bioc_lis=
t);
>>>> +       const enum btrfs_raid_types index =3D btrfs_bg_flags_to_raid_=
index(map_type);
>>>> +       const u8 substripes =3D btrfs_raid_array[index].sub_stripes;
>>>> +       const int max_stripes =3D div_u64(trans->fs_info->fs_devices-=
>rw_devices, substripes);
>>>
>>> What if the quotient does not fit in a signed 32-bit value?
>>
>> Then you've bought a lot of HDDs ;-)
>>
>> Jokes aside, yes this is theoretically correct. Dave can you fix
>> max_stripes up to be u64 when applying?
>
> I think we can keep it int, or unsigned int if needed, we can't hit such
> huge values for rw_devices. The 'theoretically' would fit for a machine
> with infinite resources, otherwise the maximum number of devices I'd
> expect is a few thousand.

In fact, we already have an check in btrfs_validate_super(), if the
num_devices is over 1<<31, we would reject the fs.

I think we should be safe to further reduce the threshold.

U16_MAX sounds a valid and sane value to me.
If no rejection I can send out a patch for this.

And later change internal rw_devices/num_devices to u16.

Thanks,
Qu
