Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC0164384
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBSLhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:37:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:51387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgBSLhW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582112226;
        bh=DHxUnEMxDuvtBG6HG4JjAdy3oeOGrlU3dvmUDrxEJWI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gYsvVH0Caa45zaLi509CqTotmgpho3RvY3FtKNQTory0TjJWQk2t2AV2BHSzJmrnp
         rJ5j5GkuTwkNHBLI5zk0q861DD9JtD6X/kSy+bhH1Mj30xrJ75fcC4bxZcHtTifcZZ
         JOp+bvoBY6dHE43VeellR6I7snOAPJWNjtcAqSao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2mFi-1jRhpm0Im4-01351d; Wed, 19
 Feb 2020 12:37:06 +0100
Subject: Re: [PATCH 1/2] btrfs-progs: check: Detect file extent end overflow
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Samir Benmendil <me@rmz.io>
References: <20200219070443.43189-1-wqu@suse.com>
 <3bc4fa9f-ffbd-9965-bdf7-07606218c526@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <fba00905-f71f-5488-0fd3-ef2458bfcd31@gmx.com>
Date:   Wed, 19 Feb 2020 19:37:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <3bc4fa9f-ffbd-9965-bdf7-07606218c526@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XqGfoMzgTq1DZ50Zt9ZAljlYlRX29pUK4WJfOHBjTndS7t9JSON
 WCfPJHR2zOnku4ypeXZHa7REik9EpHW11F4DHplP69jT/FL18VWWB+hpIZgqmnZyDn0dvUr
 lJII8s8lxWpfPPNP++6lO1NPkIxCiYJsNJCpvKcXOIsV4+wW8CWFfcKH0FWbXh0+3tUeN8/
 ddn2djGkQPsgfs0FeQrtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jt9PzG+Xmqs=:wHzJBZKLcThAw7uiSW/zLV
 Ic07sb7+FnEsxrCisvxaI7SSQIxHL6TAA5eQSuCzsjLOAu9Ufg5S3QNCrEChOs1EPU8Y8JW75
 43GFUmdygf9yinAppdcRiumNKyc6xh+zOL2T/f1g711j9zu5Asfuv7+FeOrK5OOtO2LZAP34b
 x7aRvU5C7NkD6W1UJH9l4y6EqmhHyxyQZcJca/btfYWgXw+5HCBRh36jMf1Ocra5dTUA6G5Rq
 O3m6VgFbQe7DXgkQ3/F0VKVcLOf1I6dMwE91A/nO6WnDtL947EH6PAN3L+cKspy9FZnfC4jBr
 n6haA5wK1DwcD/gV1/tO8I5mALvm2n49NyxWuAqXGBbAFXnetY6rRHboIfWR+T3+NF6jO7jZg
 YnGwSHYzl0CMD1ZyrtopH8OPH1Zh3SU1zzsfXxJWOhGQ8UgKqw+4+mMAXO/9BEEX/AXF673ds
 /tXMommA1smLJ6UE67XBAoKPf4dzzHYrgxaAai1/ZmHzfeOp2X1/jewF0wslgdS/01BQIgequ
 kGYRv+nZ19+Nf1Tf1Utgj1TMlcFV7DMT15pO1XfQFDDKGNz415EUWerOHdoYEeF/ZZqBLgSrC
 +DlYWKBM0zk7fPGgRGHxz7WaEQmeAV5YCDpJOlpNe91fVT6HrT673D86xXIreIm9KTOH03BhS
 UfizCLzTWSK2PcXAB7D0h3epy7Aj/tudoF00f/A5N+Uye5n4NuPkCF6roNbHYW9kbI7gXLtai
 Nm8vHmOqY6o7bq3KA61FzwMrmWlE2UMjZJDhZYtawVU3PFpUfNt6cAepUDjWYi/Yh304iA6lp
 jwfG6xPPYximHws3FOeDyBDlzzFXKnhzRpS2CJahCzbdpZ8RD4QR71C6WSuYw6yszymqG+/Q+
 vxj62sE+pylFSMi49MJRDhR/pyYLU7lbKQpptuxDoEYxcYyZr8bSnXy1CNEOp7ZHjBXwkIFX1
 pi7te32/JXVxsp57U1KHbt9Nd73tLdzweHpF89IpvuGbETJ4JvVTVLZjK89m94jAJiQLAP4Cl
 VYz4yaFVo4vMxDC8J+8jJN65xc5zilcZfJlJ2uxc1I/qAyVQcjnOiVI3aRoMjYka5ryKxQBdB
 MYS/jSxfBwObvUO8YM+FerkiKbm/vxvMMSxNBPD0WcxZJO004aVtQt5w0J67dAypUACMRxN8m
 QcBpyThEQYK8pAPOo2rJomBb010LqIDdl0s/yBbpUbKWbFCslFI5UZQ76/62kilb9LAFvB53p
 qYrouYI8S3NfrLIuJ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/19 =E4=B8=8B=E5=8D=885:19, Nikolay Borisov wrote:
>
>
> On 19.02.20 =D0=B3. 9:04 =D1=87., Qu Wenruo wrote:
>> There is a report about tree-checker rejecting some leaves due to bad
>> EXTENT_DATA.
>>
>> The offending EXTENT_DATA looks like:
>> 	item 72 key (1359622 EXTENT_DATA 475136) itemoff 11140 itemsize 53
>> 		generation 954719 type 1 (regular)
>> 		extent data disk byte 0 nr 0
>> 		extent data offset 0 nr 18446744073709486080 ram 18446744073709486080
>> 		extent compression 0 (none)
>>
>> Add such check to both original and lowmem mode to detect such problem.
>>
>> Reported-by: Samir Benmendil <me@rmz.io>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/main.c          | 4 ++++
>>  check/mode-common.h   | 7 +++++++
>>  check/mode-lowmem.c   | 7 +++++++
>>  check/mode-original.h | 1 +
>>  4 files changed, 19 insertions(+)
>>
>> diff --git a/check/main.c b/check/main.c
>> index d02dd1636852..f71bf4f74129 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -597,6 +597,8 @@ static void print_inode_error(struct btrfs_root *ro=
ot, struct inode_record *rec)
>>  		fprintf(stderr, ", odd file extent");
>>  	if (errors & I_ERR_BAD_FILE_EXTENT)
>>  		fprintf(stderr, ", bad file extent");
>> +	if (errors & I_ERR_FILE_EXTENT_OVERFLOW)
>> +		fprintf(stderr, ", file extent end overflow");
>>  	if (errors & I_ERR_FILE_EXTENT_OVERLAP)
>>  		fprintf(stderr, ", file extent overlap");
>>  	if (errors & I_ERR_FILE_EXTENT_TOO_LARGE)
>> @@ -1595,6 +1597,8 @@ static int process_file_extent(struct btrfs_root =
*root,
>>  		num_bytes =3D btrfs_file_extent_num_bytes(eb, fi);
>>  		disk_bytenr =3D btrfs_file_extent_disk_bytenr(eb, fi);
>>  		extent_offset =3D btrfs_file_extent_offset(eb, fi);
>> +		if (u64_add_overflow(key->offset, num_bytes))
>> +			rec->errors |=3D I_ERR_FILE_EXTENT_OVERFLOW;
>>  		if (num_bytes =3D=3D 0 || (num_bytes & mask))
>>  			rec->errors |=3D I_ERR_BAD_FILE_EXTENT;
>>  		if (num_bytes + extent_offset >
>> diff --git a/check/mode-common.h b/check/mode-common.h
>> index edf9257edaf0..daa5741e1d67 100644
>> --- a/check/mode-common.h
>> +++ b/check/mode-common.h
>> @@ -173,4 +173,11 @@ static inline u32 btrfs_type_to_imode(u8 type)
>>
>>  	return imode_by_btrfs_type[(type)];
>>  }
>> +
>> +static inline bool u64_add_overflow(u64 a, u64 b)
>
> Rename this to check_add_overflow and use the generic version from the
> kernel :

That's also my first idea.

But I'm not a fan of the 3rd parameter, and there is no other type other
than u64, so I hesitate to use the generic one.

However since you mentioned the kernel one, I guess it's time to
backport it to user space.

Thanks,
Qu

>
> #define check_add_overflow(a, b, d) ({          \
>
>         typeof(a) __a =3D (a);                    \
>
>         typeof(b) __b =3D (b);                    \
>
>         typeof(d) __d =3D (d);                    \
>
>         (void) (&__a =3D=3D &__b);                  \
>
>         (void) (&__a =3D=3D __d);                   \
>
>         __builtin_add_overflow(__a, __b, __d);  \
>
> })
>
>> +{
>> +	if (a > (u64)-1 - b)
>> +		return true;
>> +	return false;
>> +}
>>  #endif
>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>> index 630fabf66919..d257a44f3086 100644
>> --- a/check/mode-lowmem.c
>> +++ b/check/mode-lowmem.c
>> @@ -2085,6 +2085,13 @@ static int check_file_extent(struct btrfs_root *=
root, struct btrfs_path *path,
>>  		err |=3D INVALID_GENERATION;
>>  	}
>>
>> +	/* Extent end shouldn't overflow */
>> +	if (u64_add_overflow(fkey.offset, extent_num_bytes)) {
>> +		error(
>> +	"file extent end over flow, file offset %llu extent num bytes %llu",
>> +			fkey.offset, extent_num_bytes);
>> +		err |=3D FILE_EXTENT_ERROR;
>> +	}
>>  	/*
>>  	 * Check EXTENT_DATA csum
>>  	 *
>> diff --git a/check/mode-original.h b/check/mode-original.h
>> index b075a95c9757..07d741f4a1b5 100644
>> --- a/check/mode-original.h
>> +++ b/check/mode-original.h
>> @@ -186,6 +186,7 @@ struct unaligned_extent_rec_t {
>>  #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
>>  #define I_ERR_INVALID_IMODE		(1 << 19)
>>  #define I_ERR_INVALID_GEN		(1 << 20)
>> +#define I_ERR_FILE_EXTENT_OVERFLOW	(1 << 21)
>>
>>  struct inode_record {
>>  	struct list_head backrefs;
>>
