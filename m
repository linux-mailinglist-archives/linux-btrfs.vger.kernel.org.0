Return-Path: <linux-btrfs+bounces-6565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE8A9371EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 03:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF371F219F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 01:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB5184D;
	Fri, 19 Jul 2024 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rSNp7wke"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9A10F1
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351979; cv=none; b=ks5nDwQZjzf3+QXGktdP4nn5iBipv/ooqdsIvbDaCWD5IVf7OqEjNfjCJqb4/s1iLGjfniHOUjRTCtv8K0IAy+h3m95plXWMoVBafk+m7LfyYhoRAVZSEegfGwnepm7nSgkYPwqtK3KXnuknj8EROR2RzymGKjIPhCdBbzMnY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351979; c=relaxed/simple;
	bh=53w/0usRgMg3sTWkdEgYI7Rbe3EsDbcJC/vyy527pYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQZG988HScLHFVFUJgw5kV2TWqQrcx4TIRM9nUKEgKQqMCVkIh0D95GEW0tz8LX/IJZ4liuZiJZVltzfPVBZn7efiRuj6GWI0dTUt0DqrqavZBl44tlyIEPkIxVRHVLIMP3lgR/+ONHEyNQ7TJdiT6UgjZJ8HJ22UVlrib0xG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rSNp7wke; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721351953; x=1721956753; i=quwenruo.btrfs@gmx.com;
	bh=tzVpGXiMKQT0StjlfiVLLeV/rKCMfCQqQyX8qcaoC78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rSNp7wkeHEq76SLzsg9DZpgXmlxpQKKC9iXYeSv5Mg4sPFanuZL11dCDSMP1XTa2
	 kOhlw5K0hAx3cl9PBhrv5BaZghSloj/DBkdL0umfRIHiuB1OA358UdHIcxo8KwDlm
	 QNfP6YUevRVLwKznTm+rZGLhRw/gPu4LrAHFCqil0ZGjEUgEDzscQ/9Pu16WY8Fey
	 ABco0KC4l9J50i3sVEZiVc1Q1wMgG/DTe3suJ8HOu5UUp8Ru6bgsDqmh5n/urJUHP
	 jD1B1W3/SzyUt9yJqgCJAv+ucbD56EmSxcccKJwhv83Ai7qkmZS04fNR47JGfX0nY
	 64b6CGBzXcojy6x0ZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTAFh-1suCz92iv1-00I7s1; Fri, 19
 Jul 2024 03:19:13 +0200
Message-ID: <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>
Date: Fri, 19 Jul 2024 10:49:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
To: Alejandro Colomar <alx@kernel.org>, Sam James <sam@gentoo.org>
Cc: linux-btrfs@vger.kernel.org
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
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
In-Reply-To: <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FvUvEHjC8pB0SouLYHz1KEXd/qsfvGWI7tLQUVCvefrkq82mQm4
 mZXTdAdLZNDwtOURxiOjDrzpSM59Nr/fzdMU7nDfds82Dr6qHspkvbh3ZF+Q8GoiwHl8pl7
 zbCy2ETCPrBT8ZWI3+Dw0FlqwP5btI3Vl9AKcpz6DRrtdT6RTjKb5fsFGJAJjF9K1HKiy7h
 Fn/FWIaKfel4V8++v/nlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lHPRQh6Q/ko=;Kma+XKgpDYqFlN9NlbGgIPfKJAB
 UJSIT9oppJ1JBjVF8H75ImxBdwUZfjFxtp/P1Ks/K3GeG3HPcSCz5rFgvSFeos72XFrDS9Y97
 FPMyHh7TOq+jyuTVF6NSJMFWbjhCdbc3yNRE1xftwCm1d6T8bz7rDIk3QOyr1druZTjgwLkgb
 m6g2F4u3LVqL4FTP2xLoIrnnr+WWJsNiYb4hrsedHtbajZwlWClLJPvbeWEdM0gNDGDQbLgZW
 SVhwy98KbsxnexcAdjUbRwvyVmBTDKAM9ric7a45WH0eSFI26KROSfN3JbSY+w4MB/NDMRWK8
 WYpA42E1Ne0Z2FaiaHLB3b9nxFaqof6WBn5hHVk8VXLHukC/dmRzHhhVRQ+vUoDFdo5ng9oS+
 3ig4q53UG7+F87Nqvcun8CjQy+MvckMfdqoAMxLJpuUIENLD4GGd/9N3C9f/o2GUmRcPZ4f3F
 REEcQTfWD0Tv3V9yAPdfQsHmz94TRY147NkHHwVXqpEl453Hw5K0YFtfMk8+WRCkoaSQOJ4eU
 wszk+VJaM7Impyqb6LLPxuKsEZRC+kkFm44s3hpbAO5DRuA/sqfOl4Txlcmeztf1zr6ZEH3GW
 yQcXeBqI+1oGSDJTAVvtk/BrmqHjKVLwR1VRfxvVLmJwU5wyFKF9Ws66cjQSZ+dyghaJpXtdz
 V63CCAmHYhBv+OBB8PErEcffvvfNwmRi+vEfKMJp9tiFzO6QOIzhfARy8PiTBoI+SF6+rN/t+
 5xnW7hT9uII+uOalNJLWkOhzYbM8Tf72n3qQ2eGC5QHWigUgC18AaiG53tVWQKDdypiD2bMG5
 f+B+C4w20ZLjNmFSvZYl0uhA==



=E5=9C=A8 2024/7/19 07:56, Alejandro Colomar =E5=86=99=E9=81=93:
> Hi Sam!
>
> On Thu, Jul 18, 2024 at 10:54:40PM GMT, Sam James wrote:
>> GCC 15 introduces a new warning -Wunterminated-string-initialization
>> which causes, with the kernel's -Werror=3D..., the following:
>> ```
>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.41/work/linux-6.6/fs/btrf=
s/print-tree.c:29:49: error: initializer-string for array of =E2=80=98char=
=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
>>     29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_T=
REE"      },
>>        |
>>        ^~~~~~~~~~~~~~~~~~
>> ```

Great new GCC feature!

And it's indeed too long, not only for the block group tree, but also
for the future RAID_STRIPE_TREE too.

I believe we can just enlarge the string to 32 bytes for now.
I'll send out a fix soon.


On the other hand, it's better to do build time verification on those
string length.

Any good advice to craft some build time macro/functions to find the max
string length of a const array?
Or at least check against the array size.

Thank you guys!
Qu
>>
>> It was introduced in https://gcc.gnu.org/PR115185. I don't have time
>> today to check the case to see what the best fix is, but CCing Alex who
>> wrote the warning implementation in case he has a chance.
>
> Thanks for forwarding the report.  It looks like a legit diagnostic.  It
> seems like a bug.
>
> 	$ sed -n 15,34p fs/btrfs/print-tree.c;
> 	struct root_name_map {
> 		u64 id;
> 		char name[16];
> 	};
>
> 	static const struct root_name_map root_map[] =3D {
> 		{ BTRFS_ROOT_TREE_OBJECTID,		"ROOT_TREE"		},
> 		{ BTRFS_EXTENT_TREE_OBJECTID,		"EXTENT_TREE"		},
> 		{ BTRFS_CHUNK_TREE_OBJECTID,		"CHUNK_TREE"		},
> 		{ BTRFS_DEV_TREE_OBJECTID,		"DEV_TREE"		},
> 		{ BTRFS_FS_TREE_OBJECTID,		"FS_TREE"		},
> 		{ BTRFS_CSUM_TREE_OBJECTID,		"CSUM_TREE"		},
> 		{ BTRFS_TREE_LOG_OBJECTID,		"TREE_LOG"		},
> 		{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
> 		{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
> 		{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
> 		{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
> 		{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
> 		{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
> 	};
>
> The non-string is stored in 'root_map'.  It seems only used in one
> function:
>
> 	$ grepc -tu root_map fs/btrfs/print-tree.c;
> 	fs/btrfs/print-tree.c:const char *btrfs_root_name(const struct btrfs_ke=
y *key, char *buf)
> 	{
> 		int i;
>
> 		if (key->objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID) {
> 			snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN,
> 				 "TREE_RELOC offset=3D%llu", key->offset);
> 			return buf;
> 		}
>
> 		for (i =3D 0; i < ARRAY_SIZE(root_map); i++) {
> 			if (root_map[i].id =3D=3D key->objectid)
> 				return root_map[i].name;
> 		}
>
> 		snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", key->objectid);
> 		return buf;
> 	}
>
> That function returns the non-string, and also seems to be used exactly
> in one place:
>
> 	$ find * -type f \
> 	| grep '\.[hc]$' \
> 	| xargs grepc -tu btrfs_root_name;
> 	fs/btrfs/disk-io.c:void btrfs_check_leaked_roots(struct btrfs_fs_info *=
fs_info)
> 	{
> 	#ifdef CONFIG_BTRFS_DEBUG
> 		struct btrfs_root *root;
>
> 		while (!list_empty(&fs_info->allocated_roots)) {
> 			char buf[BTRFS_ROOT_NAME_BUF_LEN];
>
> 			root =3D list_first_entry(&fs_info->allocated_roots,
> 						struct btrfs_root, leak_list);
> 			btrfs_err(fs_info, "leaked root %s refcount %d",
> 				  btrfs_root_name(&root->root_key, buf),
> 				  refcount_read(&root->refs));
> 			WARN_ON_ONCE(1);
> 			while (refcount_read(&root->refs) > 1)
> 				btrfs_put_root(root);
> 			btrfs_put_root(root);
> 		}
> 	#endif
> 	}
>
> This caller is using the non-string in a "%s" in btrfs_err(), which
> itself is a wrapper around btrfs_printk(), which I won't follow too
> much, but I expect to treat "%s" the same as printf(3) does.
>
> The fix would be to add at least one byte to that array size.  Possibly
> make it 32 for alignment.  But I don't know if that array size is fixed
> by any ABI, so the maintainer will be better placed to find the suitable
> fix.
>
> The only alternatives I see are
>
> -  Use a larger number of elements for that array (1 would be enough).
> -  Use a shorter string so that it fits the 16 bytes.
>
> Have a lovely night!
> Alex
>

