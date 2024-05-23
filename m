Return-Path: <linux-btrfs+bounces-5225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68878CCB49
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 06:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED22B1C20C54
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E12142A87;
	Thu, 23 May 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HROu4NPd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479801CFA0
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437048; cv=none; b=mR/Zfa2kLaQ8V2UN6/bVRUMqeCCkjgL7ozeYh2IO1Ms8bZkkfO6RVMSJg5qgEZ702RAjTlEElrmCDdMV8pllS6S1MyVytaiLVYSS+Xj6fvBBXSmWh+oM6UVk4swJorseR/4tnxCLD5kYe2Y8yw1Z83q1Xsm7mldJO95Ad0ApLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437048; c=relaxed/simple;
	bh=eoA/8gQlVTGpQpArofAfZr67/BPzJktEhOjSLxvWjPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Llx1mCkbRvbMwDdf+RMmZtzfIS2AcAIOyN1UlQG6+TH4it8VEGuIt9kVm7Pxpuuk/rPB3ejHeivX0ZfY7JShRklhHJFAlIu5ZNC0+rGL2PB/bNB+fwUz7LEqZzgQBFg4VCk9RsIIHttXalLlL4mzFZ2HAlSzHVHP6OvoDkh5WdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HROu4NPd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716437038; x=1717041838; i=quwenruo.btrfs@gmx.com;
	bh=6Znrw/arToJVpsYDtlMG6FmnslWR6tUGbAasnfdLORU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HROu4NPdnwtxvs8AhXUCPsUPzcYDzKPGEB16Jz5Oezxh6h0v267uS7r24p58eb4k
	 jj/w+N9a54BK+EosQndb0ZRfnUpzIMV6W+Ha9fytZ9/HnO3sUMpzPQTwdfW0QjM96
	 Tq6+kXPNK4yKdHhIaOmXD4WEOmmJCZUrZqtH1SS3rfeXMpeNdA4UDOfmkZuoU2dJJ
	 VGzoS6KIwlQ91LYMcz1HyspIS18c4bcNB44QlZUtLvlcGJxV0QQRtqkmA1N73duYR
	 0eyD75PFLvpxW5AFzBaTVFDLLyHJhELcwvUXVkbsshdHKOP6PFrSUjuld5zm4t8FI
	 mRPM3MUgm4IQff1Q7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1sCDfp2HKC-006f1i; Thu, 23
 May 2024 06:03:58 +0200
Message-ID: <23438f67-ed4e-4c79-8b25-0e015c347bc6@gmx.com>
Date: Thu, 23 May 2024 13:33:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] btrfs: cleanup duplicated parameters related to
 btrfs_create_dio_extent()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1714707707.git.wqu@suse.com>
 <8bdb1c42be16e32919b5e3e80aa6576c3a688d0d.1714707707.git.wqu@suse.com>
 <CAL3q7H4UV7amCcXmxN-=FvW-gLHmm-T51qCnPUNbSDb_h1nF5Q@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAL3q7H4UV7amCcXmxN-=FvW-gLHmm-T51qCnPUNbSDb_h1nF5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oaOMwSbE4Obye82Nj8cRWpWaGasfjwJKPIsbzCP5DCh/y9XiDpO
 ESe1zz5y+wnpalPSXd1t61C0tJXseH1RQ/qxe/uu3bTSiMHb6aDGM/Ztfd6SuLzuUVLEUEL
 6hZ1TWS8Jl/QiibXpSGe1/YZRBFxdHd2ZTGhfMgnSLF3vom/+Gy2rRTKBR0Opxt/PS+D/yX
 zk+E+iwX0vdFVh3q8gmyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OPhoRiAlTRA=;Gxqc+CtUxqT3EZu4N7Ow1aWRrr8
 Qg9NqtnIX7fiqOmS8bzpZcpgsoA9IyycC8IAYct3o4WpGJdQeJmEY3Qtkx6GQk+mM4rkUHcSf
 tReFIOetMVb8Jm5avpja18rHEnc9HxSRzBRWlmKx1sWPqkp+OJ+AMA5s++eE0RalD0AEXtWcd
 vUPHub1ptRj+GrMAGY0B6ImLiTnEwakRP/k7dl9bHtVieh3DS7nVfrETGDSe8AjnftXjtYRDF
 nPyCH53Ubs1DPd2gmJIIawhO2esBiBBKB+mhY1KOMPldPkaHuqXiVwfMmpxOWfriSEXsq4VD0
 n5RWD/bYGBMNl3OT/kgSB0+PhResCX/4F+KrraeaEJ3sJwCKv4iKo3a/N3EH0A/Gzy3cZdzct
 w3L0tqqp5Ah2e4K8vMzGw696CpNvzp68ON2FIxfEVy++vzlVcFEfq7uTsBxuQioK+YoPhQr5c
 zJc9iTXBPQcEEcSSNH0BmdMMO3TPViKMPxXvJ60afuVZUuNDTw4/hNIWm688orMZnf+LkEOPx
 umPSbIztzaxdMhJKgjPG6DYGhxU75NU1G7Nme377GRmIavgEJ0c/M5VKlpTWWV/1l9vXEoJ6e
 eSfyxiW0Va3NHxINaFNWTFNGBVil/6iDIdUfbFefOmHdlfmLj6+icUOcb9Jtx7S0IW6ef64SF
 OiD7IO8dJe5ACX532zJZNXOvKEy1RgN3PnwGQLHNqXhpE6mZ8f6GJfNV0AnM1cwecDpMAeyOz
 Lp8vvKI7VsnR6UvfNlcvjgeMWQTOtbB6JzQQWFcUCG9hL6qkCuQHVw49xf989y5Xf7R23oW5e
 RBtHQ9q41prVnjzjSKuJJqQZXnNCTPK5iVAE5t+v40Bbo=



=E5=9C=A8 2024/5/21 02:18, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, May 3, 2024 at 7:03=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The following 3 parameters can be cleaned up using btrfs_file_extent
>> structure:
>>
>> - len
>>    btrfs_file_extent::num_bytes
>>
>> - orig_block_len
>>    btrfs_file_extent::disk_num_bytes
>>
>> - ram_bytes
>>    btrfs_file_extent::ram_bytes
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 22 ++++++++--------------
>>   1 file changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index a95dc2333972..09974c86d3d1 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -6969,11 +6969,8 @@ struct extent_map *btrfs_get_extent(struct btrfs=
_inode *inode,
>>   static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode =
*inode,
>>                                                    struct btrfs_dio_dat=
a *dio_data,
>>                                                    const u64 start,
>> -                                                 const u64 len,
>> -                                                 const u64 orig_block_=
len,
>> -                                                 const u64 ram_bytes,
>> -                                                 const int type,
>> -                                                 struct btrfs_file_ext=
ent *file_extent)
>> +                                                 struct btrfs_file_ext=
ent *file_extent,
>> +                                                 const int type)
>>   {
>>          struct extent_map *em =3D NULL;
>>          struct btrfs_ordered_extent *ordered;
>> @@ -6991,7 +6988,7 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
>>                  if (em) {
>>                          free_extent_map(em);
>>                          btrfs_drop_extent_map_range(inode, start,
>> -                                                   start + len - 1, fa=
lse);
>> +                                       start + file_extent->num_bytes =
- 1, false);
>>                  }
>>                  em =3D ERR_CAST(ordered);
>>          } else {
>> @@ -7034,10 +7031,9 @@ static struct extent_map *btrfs_new_extent_direc=
t(struct btrfs_inode *inode,
>>          file_extent.ram_bytes =3D ins.offset;
>>          file_extent.offset =3D 0;
>>          file_extent.compression =3D BTRFS_COMPRESS_NONE;
>> -       em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offs=
et,
>> -                                    ins.offset,
>> -                                    ins.offset, BTRFS_ORDERED_REGULAR,
>> -                                    &file_extent);
>> +       em =3D btrfs_create_dio_extent(inode, dio_data, start,
>> +                                    &file_extent,
>> +                                    BTRFS_ORDERED_REGULAR);
>
> As we're changing this, we can leave this in a single line as it fits.
>
>>          btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>>          if (IS_ERR(em))
>>                  btrfs_free_reserved_extent(fs_info, ins.objectid, ins.=
offset,
>> @@ -7404,10 +7400,8 @@ static int btrfs_get_blocks_direct_write(struct =
extent_map **map,
>>                  }
>>                  space_reserved =3D true;
>>
>> -               em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_dat=
a, start, len,
>> -                                             file_extent.disk_num_byte=
s,
>> -                                             file_extent.ram_bytes, ty=
pe,
>> -                                             &file_extent);
>> +               em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_dat=
a, start,
>> +                                             &file_extent, type);
>
> Same here.

Just a small question related to the single line one.

The parameter @start with its tailing ',' is already at 80 chars,
do we still need to follow the old 80 chars width recommendation?

With previous several patches, I re-checked the lines, some can indeed
be improved a little, but some BTRFS_ORDERED_* flags can not be merged
without exceeding the 80 chars limits.

Thanks,
Qu
>
> The rest looks good, thanks.
>
>>                  btrfs_dec_nocow_writers(bg);
>>                  if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
>>                          free_extent_map(em);
>> --
>> 2.45.0
>>
>>
>

