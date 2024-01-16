Return-Path: <linux-btrfs+bounces-1491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8BE82FC07
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 23:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFF28D850
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049759148;
	Tue, 16 Jan 2024 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lPJWDGGV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76E21376
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436038; cv=none; b=t57JBNzXveNOWr/lYdf+g9E9eXLodI+qAM8lX2k7W8ZtATflBczmPC3Z3oKUJ/KO7GyXnE2Hyayf39hyfhVJLp9TqIRk2qSZ5dNMIseTi/fm31psUavlmXPJqItTNkc2rYF8rqiI4vcOQnNZ3hxnuj6EOOsIPBRDraOiRbyWamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436038; c=relaxed/simple;
	bh=3Ge4P1QRc09QOMXvCCXTFxKTzSNSBmJZrFdwd3txpwQ=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=HMwcSPe57Amr1xuPCJ8hBE7I6dCuu12KVb+8deUfGLD6vEltwumYPquQZaQbU5cZ9mHGAvT+W1Bbpb4r6WIujLywmU6AlfrCSh+XFfA7f0nhYfSIeb/Cyr8vGnkznBDEtoR2OkhCsbYcs3C/u1pcV/kTFPZAbomzFYn9/KaiMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lPJWDGGV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705436033; x=1706040833; i=quwenruo.btrfs@gmx.com;
	bh=3Ge4P1QRc09QOMXvCCXTFxKTzSNSBmJZrFdwd3txpwQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=lPJWDGGV1LkeUl1/STXI6TNMzALRQoRR37GF3TYD19OHgR73VkOBVeVytPy7+qgz
	 7RAfwII8HeMi8ti3K8/s94FmxhuAg31Z+dopMkoR8uKyY7wuE2kS3CMz/Tfc62HxN
	 fO2EJ7nh7xnZR8PWmX1Pi3dIe5BvO9/8OgDn49krr7XgmpFEHqcR40g4dLLwVgHqh
	 xUpwUdKrcLcSVYCaxoSSGCvpC2wY/av/XUQ52l+ci7HgIlFR+zOojmKASBT3/qr6G
	 E5okJT884Vof1tQLq+YzmITYszeM0YPTEDi7ZJMgX96lUJw32oD7b8bhKH8HTm/k5
	 UYWCWkCJJ1YkZ0TWYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1rWBLe13s3-007XUp; Tue, 16
 Jan 2024 21:13:53 +0100
Message-ID: <fec2ca19-2b17-476f-9ba1-55f85e622ea3@gmx.com>
Date: Wed, 17 Jan 2024 06:43:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: convert-ext2: insert a dummy inode item
 before inode ref
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <6e1e07ad53a9e716be28e4d505042a50c1676254.1705134953.git.wqu@suse.com>
 <20240116184738.GE31555@twin.jikos.cz>
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
In-Reply-To: <20240116184738.GE31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J9G3amxis+3PLK6uRaNedX3icprUyJ1n+pn6m+kkgJp02zMdP0g
 Xaqn3eGmGabqa18sM0awHNwhtHzRdtSM2Lpa4HTk+L4FzdX5/BFn8iDeUHzGXRG6rf5aSPO
 JT/mWZni2sEy70XcDb/zvwwkF/GvPuzVgcAHnxsxJ+kJXllJ2wDUbWznY7JlZnxh1T8cZf5
 roRI444rp0Sn2heUO7GaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qjZuYS8/rmM=;bTqvo0qSKtJ4zCqLSXHzE2h2lvs
 F6JjnWUyrsTMX+hOw6F97qoLPxuP1O3F7vPcVoFLvVZxZ/bbQsUAToWr3eXFFhTIIgIIs1xkI
 iUXoeZSRX9eBJYM8zuxHrL3fhG5N13JKpN+5oMAUH5WSVNL+6NLkZreWrEWmvdLWQYtgv3T4L
 CBsesX3zfwG0LSCQmanmr/MVKuNuJGdNxqDApAegChc+dlqapnATWNwMEWXALW/g+GhEPCfq7
 r+RLVrws6X/IQ3uvwsjWgS9oJd1Czj1RLeXOktfiQ6brGOMfl2omMGpTKuzSSuGkYLlsH1ULY
 s8OaOQOUHEoUYVE3+3V3h8w8VHBu/HV8+VJcLeoH/BDpVMy83aD5alp4k5onlihNtYr1vfha5
 lDyfJVLH2dy1N8+JXio7iz4IquStXp1QuTbkg/9//kDjXox1P1hU5vGFKBhl3tHjKVySYsY2D
 8+5gCmPt/1QAB5JDz38yrzOavag9fcHFTLIWjC2e8U1CbadIiu3BuHKgKTgROHRoBUnU30+JV
 6rUQiXiEx5WopqpLy5FF3xuc5k8PKLWiNWLtH2jVDRJRVW96HbdM9HLaBsI8TekwwDyPnyIh7
 7Mu8j3GPXM6shWTlVErxnwNLlTRA+jOkcWKPSa8NTNLduCPKXnvDmhPM8TJmb62J5Tl1BkKnR
 yxBSD3d6e71Azwy71pgDdW71Io97/RahAgoBdnXikQBr80CSeM3vYpqUHILx1R1HajqvsU5dW
 HCD9jyFuytWr1MezbWhc8rc3GkLS+61sSOeNHsOroBvh7hQ0+968ESRpPa8eyBydJ8iMq3UQh
 IMXU20weY5yN3zwsgZHSEU/lFdckOOR9DPvoT34R+XbuWqtqPa1Ox/QQ/rhQjpX19mDE0v7cU
 YmO1sw4gCm8H32jQ9AzbMhK/PyxlZhKxvyOeqvXTh+9BBs6w36oddSXChXqZdPINLi9sSgRJJ
 AEjD6ypB5Ouo1OAk+KAK9XbYHCk=



On 2024/1/17 05:17, David Sterba wrote:
> On Sat, Jan 13, 2024 at 07:07:06PM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is a report about failed btrfs-convert, which shows the following
>> error:
>>
>>    Create btrfs metadata
>>    corrupt leaf: root=3D5 block=3D5001931145216 slot=3D1 ino=3D89911763=
, invalid previous key objectid, have 89911762 expect 89911763
>>    leaf 5001931145216 items 336 free space 7 generation 90 owner FS_TRE=
E
>>    leaf 5001931145216 flags 0x1(WRITTEN) backref revision 1
>>    fs uuid 8b69f018-37c3-4b30-b859-42ccfcbe2449
>>    chunk uuid 448ce78c-ea41-49f6-99dc-46ad80b93da9
>>            item 0 key (89911762 INODE_REF 3858733) itemoff 16222 itemsi=
ze 61
>>                    index 171 namelen 51 name: [FILENAME1]
>>            item 1 key (89911763 INODE_REF 3858733) itemoff 16161 itemsi=
ze 61
>>                    index 103 namelen 51 name: [FILENAME2]
>>
>> [CAUSE]
>> When iterating a directory, btrfs-convert would insert the DIR_ITEMs,
>> along with the INODE_REF of that inode.
>>
>> This leads to above stray INODE_REFs, and trigger the tree-checker.
>>
>> This can only happen for large fs, as for most cases we have all these
>> modified tree blocks cached, thus tree-checker won't be triggered.
>> But when the tree block cache is not hit, and we have to read from disk=
,
>> then such behavior can lead to above tree-checker error.
>>
>> [FIX]
>> Insert a dummy INODE_ITEM for the INODE_REF first, the inode items woul=
d
>> be updated when iterating the child inode of the directory.
>>
>> Issue: #731
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Thanks, the cached data are uncovering some bugs, I wonder if
> https://github.com/kdave/btrfs-progs/issues/349 could be also caused by
> that.

Unfortunately the csum is not the same problem at all.

I don't have any clue yet, but can take sometime to look into it since
there is a reproducer.

>
>> ---
>>   check/mode-common.h   | 15 ---------------
>>   common/utils.h        | 16 ++++++++++++++++
>>   convert/source-ext2.c | 30 ++++++++++++++++++++----------
>>   convert/source-fs.c   | 20 ++++++++++++++++++++
>>   4 files changed, 56 insertions(+), 25 deletions(-)
>>
>> ---
>> Changelog:
>> v2:
>> - Initialized dummy inodes' mode/generation/transid
>>    As the mode can still trigger tree-checker warnings.
>>
>> diff --git a/check/mode-common.h b/check/mode-common.h
>> index 894bbbb8141b..80672e51e870 100644
>> --- a/check/mode-common.h
>> +++ b/check/mode-common.h
>> @@ -167,21 +167,6 @@ static inline bool is_valid_imode(u32 imode)
>>
>>   int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer=
 *eb);
>>
>> -static inline u32 btrfs_type_to_imode(u8 type)
>> -{
>> -	static u32 imode_by_btrfs_type[] =3D {
>> -		[BTRFS_FT_REG_FILE]	=3D S_IFREG,
>> -		[BTRFS_FT_DIR]		=3D S_IFDIR,
>> -		[BTRFS_FT_CHRDEV]	=3D S_IFCHR,
>> -		[BTRFS_FT_BLKDEV]	=3D S_IFBLK,
>> -		[BTRFS_FT_FIFO]		=3D S_IFIFO,
>> -		[BTRFS_FT_SOCK]		=3D S_IFSOCK,
>> -		[BTRFS_FT_SYMLINK]	=3D S_IFLNK,
>> -	};
>> -
>> -	return imode_by_btrfs_type[(type)];
>> -}
>
> Why did you move this helper to utils.h? Here it's available for
> anything that needs it. Mkfs and convert share some code, no style
> problem to cross include from each other. Also moving it to utils.h is
> going the opposite way, it's a header that's a default if there's no
> better place. Lot of code has been factored out of it.

OK, my initial problem is about including headers from check/, but since
it's not a problem then I'm totally fine.

Would update the patch and reflect that.

Thanks,
Qu
>

