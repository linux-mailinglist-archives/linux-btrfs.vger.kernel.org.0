Return-Path: <linux-btrfs+bounces-315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345817F5103
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27EC281273
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 20:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2ED5C8EC;
	Wed, 22 Nov 2023 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="R8f6/uFo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB211BE
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 12:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700683303; x=1701288103; i=quwenruo.btrfs@gmx.com;
	bh=FOtDukj2MhTkJd5kY5uXAFCJHKS755slQR3Zi89Ld0k=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=R8f6/uFoS4c8B6pee4Bam+whIIyd+5IACZzg632tFo+N/00MhwPO2VcrSMHkyPGf
	 /C3xnJgm+UyzK5m/n87qlHFju0ZN7h4cfLTMyO9Nd9HXzKPKwJq/2O/f4xAv2QOkf
	 Ew3Y6FBgVkkbOIKEDiWcrW+azgNGxQO6x6XGOeiZpLtqv4+cyKHLWF3a3zKgesmOx
	 WMV+qUGyh8wUmHTANK9z+mbGDZuI9h3SOfV0hr+WxTDfqw18F3MB6ShAYPWpfiYPB
	 ChnbqXZmvLTyXAXjJ7K6DY9+Kr0hja+ZybccJkgBlJxvTXYJBCP2Vlhtnq1rEGqPP
	 8JDHzR4E4+e4C9Irzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwQT9-1rMjVj33zB-00sJl2; Wed, 22
 Nov 2023 21:01:43 +0100
Message-ID: <c1c0dacb-8db5-4b6b-90f1-a71487fb44dd@gmx.com>
Date: Thu, 23 Nov 2023 06:31:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip cross-page
 handling
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231122134642.GB11264@twin.jikos.cz>
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
In-Reply-To: <20231122134642.GB11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dms0Rlp1yFlyeZbCiZZ2SdbSUYVGu+3ZkWJVXyC5OGU89Gdumlv
 WBxxB017gBuKM6vIobGfo/WwmirOLHmEu7Y0N31NRnT/CjIBzHRZBHHWTOZQ2aLQD61p3Pt
 RfYFhhw8Bmc9p1g43Tk0Tmg9FOwy/2sG6CZBl8WEiJ7w1PLPjB3F4Cp2ytm2xRpKJfupKHx
 gA5MoDgYscRlOr7Qh8JOw==
UI-OutboundReport: notjunk:1;M01:P0:S7U9TvFA4NE=;B+d51bx8AfXYTPX92LCVDwFSG1q
 e+oOFDoosV4Y1TOUQYTyP2Vmcb3EHppy+a88aMfHzIrYqsURTKFd3gbNx+MERwHyv/sO4z34h
 L0SsLIAY4ZtvDd5e4WBidVFWPp97IPSzUTFI2XJPxRzXJSeR1Zrj7bRezgivm4kz2ulIG0C5Q
 NnLz2ntjt7WAKQJs0vtAAUA7pGgLWCD15OtRk0Vm/71FWLG67VDrtd93gwHFu1LV525p/p/cr
 yc0V9gooPRVaPS1vZeiB3Q5gdmCED8cbn1PWic9DNDbIwXcigELXLSzHZpVb9ttyPy+QZmhuB
 Uen78wNwKrAyapTmF6a/Lhe11IJToKOH9DaulI330mlaQsmWG2aNmm8hGoIXY1Y/HiJRWB7pD
 Hg0DmZBBALcOUvYtlfm+Dk2DfA1sarYlB0LKk8voZXzCXu5tVkPXoxzlldFzOpIR8zXfEZdgd
 1baJUISwgRI1n0GDV7YapXs70d2PoKA26rD1M7YXgQF7ZBOI6WC+eKZB+j9h1TEtZv+SOKxQ3
 x2KYeOjRWhDpvD5VPRcrk1Okoes+57jgQDFGKB6Y0H6qJ5uZ7HOlByBzw5k4kDUWT0FYSgWd0
 6HY1ROvAqR7bctP89ZamHMbzyYxwQVvghwNYRBNnnKdslW5i3q/tdfVrksG59q/vT/vWHUq2K
 xaZQvL5jqhAxA+JeFOzxySUh9hYTGWuIipGEyMTwsYwX+AVqWnKiPzGr4jK9SzZVnHVD5Q2xO
 WvcqRPFlKdF0hcEKqqlJCTUAXyhun4CCQ/Vd0RvxfGH6u2pcEoo+7ZQffiKeCUqvDCUbULw4L
 JqPp3ZA4rGImtWHmMfq0w390Ezh5wnGVr0MeAew84Vzpj1Xk5lcozDuf5thYYyl5fhzY+JjIC
 k0uA8MRa5Hnh1s80QaiIX5wb13ReS5T/L34aAxIC7l2YC+Jx/G83ytriRy4p9L57iPZqwOalI
 V9tucJhU/h60yKbZxUowFyIgSRw=



On 2023/11/23 00:16, David Sterba wrote:
> On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer *bu=
f, u8 *result)
>>   	char *kaddr;
>>   	int i;
>>
>> +	memset(result, 0, BTRFS_CSUM_SIZE);
>>   	shash->tfm =3D fs_info->csum_shash;
>>   	crypto_shash_init(shash);
>> +
>> +	if (buf->addr) {
>> +		crypto_shash_digest(shash, buf->addr + offset_in_page(buf->start) + =
BTRFS_CSUM_SIZE,
>> +				    buf->len - BTRFS_CSUM_SIZE, result);
>> +		return;
>> +	}
>
> This duplicates the address and size
>> +
>>   	kaddr =3D page_address(buf->pages[0]) + offset_in_page(buf->start);
>>   	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>>   			    first_page_part - BTRFS_CSUM_SIZE);
>> @@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer *buf=
, u8 *result)
>>   		kaddr =3D page_address(buf->pages[i]);
>>   		crypto_shash_update(shash, kaddr, PAGE_SIZE);
>>   	}
>> -	memset(result, 0, BTRFS_CSUM_SIZE);
>>   	crypto_shash_final(shash, result);
>
> I'd like to have only one code doing the crypto_shash_ calls, so I'm
> suggesting this as the final code (the diff is not clear);

This looks good to me, mind to update it inside your branch?

Thanks,
Qu
>
>   74 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>   75 {
>   76         struct btrfs_fs_info *fs_info =3D buf->fs_info;
>   77         int num_pages;
>   78         u32 first_page_part;
>   79         SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   80         char *kaddr;
>   81         int i;
>   82
>   83         shash->tfm =3D fs_info->csum_shash;
>   84         crypto_shash_init(shash);
>   85
>   86         if (buf->addr) {
>   87                 /* Pages are contiguous, handle it as one big page.=
 */
>   88                 kaddr =3D buf->addr;
>   89                 first_page_part =3D fs_info->nodesize;
>   90                 num_pages =3D 1;
>   91         } else {
>   92                 kaddr =3D page_address(buf->pages[0]);
>   93                 first_page_part =3D min_t(u32, PAGE_SIZE, fs_info->=
nodesize);
>   94                 num_pages =3D num_extent_pages(buf);
>   95         }
>   96         kaddr +=3D offset_in_page(buf->start) + BTRFS_CSUM_SIZE;
>   97         first_page_part -=3D BTRFS_CSUM_SIZE;
>   98
>   99         crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> 100                             first_page_part - BTRFS_CSUM_SIZE);
> 101
> 102         for (i =3D 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > =
1; i++) {
> 103                 kaddr =3D page_address(buf->pages[i]);
> 104                 crypto_shash_update(shash, kaddr, PAGE_SIZE);
> 105         }
> 106         memset(result, 0, BTRFS_CSUM_SIZE);
> 107         crypto_shash_final(shash, result);
> 108 }
>

