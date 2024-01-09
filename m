Return-Path: <linux-btrfs+bounces-1329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF38828EB9
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 22:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB6B25463
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20753D99A;
	Tue,  9 Jan 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JB1c3GU1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E223D0BF
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704834292; x=1705439092; i=quwenruo.btrfs@gmx.com;
	bh=Oy+pUj6nR6FL7bCDYDH7npLkevuf3tyHH4Rth4HMp1Y=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JB1c3GU128KvFxEB7hhCruBVjU1x7YDCi1+z2lzOSg3bmXaKPi8cr3VLzcwFQV0k
	 YBgPGmqlrubRrmWuTg16a2LuYV9hpjfPF3yuVBEpFFA28kyflKfJqfQS2UWFCaOgu
	 XGqB/yZ7Te0qxjg3+8a3FXbXejCbza/yNofexyz9C0T3Tw9mYdl8Wl/6pl0MFK0S+
	 upl3w6o3Nr2mOhDwqswVlNN0WeNe/hsy9yd0giBHy/WMZflCSLFOFjhbHFF4afZ8C
	 L318zLE8R5RgtdulnrsvLOI95CTyOHrrilR8YNuJtdJj7rsL1gyfQ4Bn//EnQUaja
	 qRxdRGUw8VBZwhXNzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.113.22]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdvmY-1qnQEH0Xvq-00b6w5; Tue, 09
 Jan 2024 22:04:51 +0100
Message-ID: <59615d5b-8802-4218-8b0b-18e3eff47cb3@gmx.com>
Date: Wed, 10 Jan 2024 07:34:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+gsObECX4xKvnqz318R6eFNc0+v2esP1huyNEI+d0NzzAAOjwtP
 ztwczf0k4OLLniwwX9UC1aD6khXxpDNMnh8nzyFtsLRt+HEKRzfGrE/LfE5ZH8Gu/ZsD/+8
 I3XKkftu0JByYB/PBMmSMPuA1E/kK5Eipw1B69Du85orcoVjm5el7DXZaxZecA1EcAb/N0g
 KygN2Pr2gSxb3lPY3Wsag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qRFpdXC8QSk=;IY58RSldbO0wPuA5TGF21WWmJ/s
 TsKSQO5xgKbqvomgmzpPXmhRJ2APtsPCqvF/GhOahIkAWQ0inlS6aHXalbIMtmGjA55H5eMV8
 XTAuBVz2uLTlqWgxZ0hItRiDZFASfYJy3TU3HcS4k62+HKCisjvW2GEhslUpVhIEPhDER5XI2
 E6TquHsMfXhR/nvS3+ghxVqHZzilHBKMeoK0rwnVWh7jWtwW4Uy30Xp3hyflHzJegAXKy/cRD
 DI4Q5Q9ZUQQjdOYjFYnRZ5G5p0huexgZF7XXkgqjf4jaspjp2vSMo9+a4zl4s3YXs40fbgS6h
 B05BgGE1pMkv6duaaFzqQ5/oVha8Rbe0pshV8vSRu6pjXWUnyeRPHAXApRJW8JpPQVfevKlv7
 nge8keN6Dv7kW7pVSPa3J3UzWJwm+vvG7WTpzACQdWQGHy3svN7mJwuVAAvVKD+2J4ICywUpE
 vN/sEjcIaDR0t7oEVOO4YYQCNduLApiumiDgZ87eKVN0i71vzMzYhRIrcDBi+VqyIyel2qfzb
 aYLWgSaE5cbxud3eaPu8Yxa+jJ0Eagm5aNoUYLxRgFIyuXjB++3yb+RtlTRkPLmVCB/No5Gep
 6kpARcOdamhMA4/vb2qcqlcay7d9yS4RyT7EzDt8UfYzJZZpeJhidcQOMv8vx1JNDvCv+T2Oe
 vJBccrk5oEyNb0eqphT4BoA5MBLrUBeDmAwH9B+LJ1UEl7iu75TFPoDh9y2EDhKuiurY0waQp
 VdOIPKlkVGEDSwtOFDZWU/sbokmyKBz/oiQYiP05RdYNsSTOc6l+XT0aG8hjMivIg+Zc9Onh6
 8XfmttnwSXVPxBGOspqCJc+FcemMholB4yW/vCYXBteW1m6+s3Wemw4IK/4svXJamdI2fqwQE
 AeG2lJtgmtZbjw69bJc8pk3Y2ceZwAr8iZAS2RmzchfZIFn3WtuiE4Nht+DKNZJYbmssAovdO
 3fXfxGApE1rgERrUTR3v8lJ82Z8=



On 2024/1/10 01:25, Filipe Manana wrote:
> On Fri, Jan 5, 2024 at 7:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script can lead to a very under utilized extent and we
>> have no way to use defrag to properly reclaim its wasted space:
>>
>>    # mkfs.btrfs -f $dev
>>    # mount $dev $mnt
>>    # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
>>    # sync
>>    # btrfs filesystem defrag $mnt/foobar
>>    # sync
>
> There's a missing truncate in the example.
>
>>
>> After the above operations, the file "foobar" is still utilizing the
>> whole 128M:
>>
>>          item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
>>                  generation 7 transid 8 size 4096 nbytes 4096
>>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>>                  sequence 32770 flags 0x0(none)
>>          item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
>>                  index 2 namelen 4 name: file
>>          item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>>                  generation 7 type 1 (regular)
>>                  extent data disk byte 298844160 nr 134217728 <<<
>>                  extent data offset 0 nr 4096 ram 134217728
>>                  extent compression 0 (none)
>>
>> Meaning the expected defrag way to reclaim the space is not working.
>>
>> [CAUSE]
>> The file extent has no adjacent extent at all, thus all existing defrag
>> code consider it a perfectly good file extent, even if it's only
>> utilizing a very tiny amount of space.
>>
>> [FIX]
>> Add a special handling for under utilized extents, currently the ratio
>> is 6.25% (1/16).
>>
>> This would allow us to add such extent to our defrag target list,
>> resulting it to be properly defragged.
>>
>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/defrag.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
>> index c276b136ab63..cc319190b6fb 100644
>> --- a/fs/btrfs/defrag.c
>> +++ b/fs/btrfs/defrag.c
>> @@ -1070,6 +1070,17 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
>>                  if (!next_mergeable) {
>>                          struct defrag_target_range *last;
>>
>> +                       /*
>> +                        * Special entry point utilization ratio under =
1/16 (only
>> +                        * referring 1/16 of an on-disk extent).
>> +                        * This can happen for a truncated large extent=
.
>> +                        * If we don't add them, then for a truncated f=
ile
>> +                        * (may be the last 4K of a 128M extent) it wil=
l never
>
> may be -> maybe
>
>> +                        * be defraged.
>
> defraged -> defragged
>
>> +                        */
>> +                       if (em->ram_bytes < em->orig_block_len / 16)
>
> Why 1 / 16?
> For a 128M extent for example, even 1 / 2 (64M) is a lot of wasted space=
.
> So I think a better condition is needed, probably to consider the
> absolute value of wasted/unused space too.

The 1/16 is chosen as a trade-off between wasted space and possible
unnecessary defrag.

E.g. the file extent is only referring to 4K of a 32K extent. Doing a
defrag would not save much bytes.

I can definitely go both (ratio and absolute wasted space), but that
also means I need to find a new threshold (for wasted bytes), and I'm
not confident enough to come up another one.

>
> And this should use em->len and not em->ram_bytes. The latter is
> preserved when spitting an extent map.

Oh indeed, would definitely fix it.

Thanks,
Qu


> You can even notice this in the tree dump example from the change log
> - the file extent's items ram bytes is 128M, not 4K.
>
> Thanks.
>
>> +                               goto add;
>> +
>>                          /* Empty target list, no way to merge with las=
t entry */
>>                          if (list_empty(target_list))
>>                                  goto next;
>> --
>> 2.43.0
>>
>>
>

