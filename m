Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162067A1C54
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjIOKef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKee (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 06:34:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC14694;
        Fri, 15 Sep 2023 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694774042; x=1695378842; i=quwenruo.btrfs@gmx.com;
 bh=x/A/6HDRV/DEv2IU2AOAk1jCxExujYKDMAmoocyxG3Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rgHNAN7KmKrvLZ8Mrur/wjbwcw9/Nna3vkFP1t4M7TPZpqbztWR7y/ak2zLqlgNbjHxvGoXW6lI
 pSVCpxd8v+Ar9eUZQHJ0YgqkZtwPjUoAwBkhUDF4j3PD22Te39SBFcksdfIKAR2qoRNKI+/RXKFAM
 7GsJMLnFRmORzZIEp3KPjIV9zQJ+vAWenbIpNOLVO9WMhY2wIAmZZV+bFsjUMRZra2dC+drKAb02+
 hwhpj8X8DBxybBDyVRGP61rTJndDjwfVQPH0wGDpmyT0GOUeHDD82AJAj+ht1klOOwgB7vqzxfYXg
 2+jRf3AxTO0WQnLS/Y/tIMl2Fzk1DHipFlEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fmq-1rj4jp2Ge8-011x5j; Fri, 15
 Sep 2023 12:34:02 +0200
Message-ID: <e2b069ba-deff-4cfc-992e-ad8e1d9b6f02@gmx.com>
Date:   Fri, 15 Sep 2023 20:03:55 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
 <b1330370-3261-4845-8a1b-f639ce7fe6b1@suse.com>
 <3e1ed108-44c5-4616-922e-542524c0657e@suse.com>
 <c85e00e7-e9d6-40b0-8bc9-7d966bbd1026@wdc.com>
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
In-Reply-To: <c85e00e7-e9d6-40b0-8bc9-7d966bbd1026@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PQyKgVL61AGwA7x4odr7CBvbWATSudSElD6aVVzepymjsUq4JnN
 aTjmWi1sUbiPhxGNTivUs8jnYNKIq7+L5611Nb/5S3zoP7xRECSGBu+17VXh6yjkrA5Uo1L
 h1h813vplq2Jr+SrkaLVHR8/UTTI7un0MZC5o4Iic7SeE4dpCJm5ZTk97Mw7CmOFglL94y7
 GBpDAuD+aAISo9Ug0fbjA==
UI-OutboundReport: notjunk:1;M01:P0:BVjIWWxt7h0=;18YlsnrHP61VHSGsC4lytmZi12q
 Qp0lzr6W3sHxPpX6CgePYS6xRY/IWdQI6WjrF2dUbHfQmQcSjl06exdJpvoIUei/OJWMMR81B
 pY+pg8F6stIY2/PrEAttEJsDbHtY+D/vujke1yFcJztW30EVdoPmu5NcmT45ifX4IAbR6VMuh
 g/cthpMOYTbuoyTs8wD1F2SVkMDPT9viT52wU9mXQZT6KheVSWQw8hQHQCxRF9zywh6ob5vnT
 zMYQi9ZV/qjep7HZGYIZWEyHRcBfkr1ip70AxVrSdhEBRrBHQ0c1DYeDKs5OudOOJ8VwhuOmM
 uPQk9E0IVVx0evfCbJQK3thSUpG1iKq4wwAZ9QVetOqGNNa3W/Ktqc5LGudGXqU7Au+N5fJ/j
 lOiZXPRgVpyvZrb/sq0kbQPXE8tZ9wB5nVNirCq0OyDJM/IkyXvplujNBkljdspkEipyJDKRZ
 pwn/J6Eby3oYmp/3LO5e4HFoBpsTrCVEgj6/QGNs+2YelBXKWJBlOOi5brxX4lsCN71ocRkD+
 5HZxVC1pzOP5iLpmj5ywOij4l9xgAuJ8Vot0SvWUsHiY+8vjMjSsGbl6XdXea3VZ3GMgPmgW/
 HEpTBf7xBUA41wDOYgg/i9+sgqRwlr8SFuYUy8i40ccgS1Sg6TzaaHCac3d+yjU8x7HqVKR7k
 yYxAgF3+Rv7bQnLN6qg0blSv+wM3pGZ/JSaQD4IVP5yQGQAQlubrRg5R9sOAQmK5BWzM3CeYt
 NdRux3hlUDurKwodLmel4SVwXMcULjCsQhbeTbu2wGaIBd5AU34ffoPJFmzAjNmk2cSMiYIdX
 MvYcA0gdprqwC7yCQ8uYobpuyweEgRPdcM83bNukwM5sUQCmsI+mdHtoySzTwHV3aCClPeiWj
 MYadBuYLATjkzrgS5n9LirijA6z+2HRTJ9y4axUbFQ5VqYC1t4qeW0bej2KIQO+yOS8GFDK77
 h4NWSbJA9eVASeRC8WLHoPlribw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/15 19:25, Johannes Thumshirn wrote:
> On 15.09.23 02:27, Qu Wenruo wrote:
>>>>   =C2=A0 /*
>>>>   =C2=A0=C2=A0 * Records the overall state of the qgroups.
>>>>   =C2=A0=C2=A0 * There's only one instance of this key present,
>>>> @@ -719,6 +724,32 @@ struct btrfs_free_space_header {
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 num_bitmaps;
>>>>   =C2=A0 } __attribute__ ((__packed__));
>>>> +struct btrfs_raid_stride {
>>>> +=C2=A0=C2=A0=C2=A0 /* The btrfs device-id this raid extent lives on =
*/
>>>> +=C2=A0=C2=A0=C2=A0 __le64 devid;
>>>> +=C2=A0=C2=A0=C2=A0 /* The physical location on disk */
>>>> +=C2=A0=C2=A0=C2=A0 __le64 physical;
>>>> +=C2=A0=C2=A0=C2=A0 /* The length of stride on this disk */
>>>> +=C2=A0=C2=A0=C2=A0 __le64 length;
>>
>> Forgot to mention, for btrfs_stripe_extent structure, its key is
>> (PHYSICAL, RAID_STRIPE_KEY, LENGTH) right?
>>
>> So is the length in the btrfs_raid_stride duplicated and we can save 8
>> bytes?
>
> Nope. The length in the key is the stripe length. The length in the
> stride is the stride length.
>
> Here's an example for why this is needed:
>
> wrote 32768/32768 bytes at offset 0
> XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> wrote 131072/131072 bytes at offset 0
> XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> wrote 8192/8192 bytes at offset 65536
> XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>
> [snip]
>
>           item 0 key (XXXXXX RAID_STRIPE_KEY 32768) itemoff XXXXX itemsi=
ze 32
>                           encoding: RAID0
>                           stripe 0 devid 1 physical XXXXXXXXX length 327=
68
>           item 1 key (XXXXXX RAID_STRIPE_KEY 131072) itemoff XXXXX
> itemsize 80

Maybe you want to put the whole RAID_STRIPE_KEY definition into the header=
s.

In fact my initial assumption of such case would be something like this:

            item 0 key (X+0 RAID_STRIPE 32K)
		stripe 0 devid 1 physical XXXXX len 32K
	   item 1 key (X+32K RAID_STRIPE 32K)
		stripe 0 devid 1 physical XXXXX + 32K len 32K
	   item 2 key (X+64K RAID_STRIPE 64K)
		stripe 0 devid 2 physical YYYYY len 64K
	   item 3 key (X+128K RAID_STRIPE 32K)
		stripe 0 devid 1 physical XXXXX + 64K len 32K
            ...

AKA, each RAID_STRIPE_KEY would only contain a continous physical stripe.
And in above case, item 0 and item 1 can be easily merged, also length
can be removed.

And this explains why the lookup code is more complex than I initially
thought.

BTW, would the above layout make the code a little easier?
Or is there any special reason for the existing one layout?

Thank,
Qu


>                           encoding: RAID0
>                           stripe 0 devid 1 physical XXXXXXXXX length 327=
68
>                           stripe 1 devid 2 physical XXXXXXXXX length 655=
36
>                           stripe 2 devid 1 physical XXXXXXXXX length 327=
68

This current layout has another problem.
For RAID10 the interpretation of the RAID_STRIPE item can be very complex.
While

>           item 2 key (XXXXXX RAID_STRIPE_KEY 8192) itemoff XXXXX itemsiz=
e 32
>                           encoding: RAID0
>                           stripe 0 devid 1 physical XXXXXXXXX length 819=
2
>
> Without the length in the stride, we don't know when to select the next
> stride in item 1 above.
