Return-Path: <linux-btrfs+bounces-3939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ADE898FEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 23:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FDB1F222C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109BE13B298;
	Thu,  4 Apr 2024 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rhJvPpL9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609E13AA51
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265102; cv=none; b=PPFczR+SS5jbvB9McW/XBs2KC78RiQwny3HW9MuobM9t7ea4CdHYw9fzOywtzNmKyveWWOL65zD9EwMR6JckVFWHdENX9UL7vxLPy5a3aBPbK+HtCZsvvXvaNwgKSxUQM3eXjY0o6BIG3GqSLEzVeNHgjBcY/tTW1FmFLYEAmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265102; c=relaxed/simple;
	bh=sVCBgr3+FajwrzFUuJ9NAXf+och6PUPcQR8YlVVs5F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0pHPuUBCyBjxCK0MVa4Z2Q4iMP6lZEZuARhJZhklzlUtCpYpePZa23gE16kJu6nSfJBfPJUzspO4JKdicXL5cKqNXw4XnJG33My9Gkxm725POyFzo3UMEMAHlWf9Jgm3RuYc1SFiaisoaI+1saZFswO3spDP+tSRmSf7NSr938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rhJvPpL9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712265093; x=1712869893; i=quwenruo.btrfs@gmx.com;
	bh=2M63ydNBJpT6PJDNeESUEWtEgVFG2NkrJHqoNxe4z78=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rhJvPpL9dAmLengod1BNAoXqAU7f4aqm/FUXmsnGBenATfFjuMps8QG2seh0r3+Q
	 ovqdLdqMQq8Wm+JMrkLFoAfiTL8cjgeQdGNA72UOYTjAfG9EvH+4vG17eZY2Bs6Jm
	 qoZjtvCHauiJnDKW4aPOh+F/7M7nn68uqz28siGhzl+7FRAjPtCFlQdqRVrryp09T
	 dp/dsL1VZeoPbI8V2S1Rsknifl4ybpNiKhIqHidNOQ4TqauPAJmYr78yWNQEvWw9w
	 Po0YXk7pfBy+iitzsrnCXxBQ/11xfoK8KARWNFQQYnt7NJA5iFGGZypQl7qvKa9Zu
	 kQollAnmmvT/YoMCxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1s5hnI2EKm-00DJc8; Thu, 04
 Apr 2024 23:11:33 +0200
Message-ID: <9a9ce07b-d9ab-4200-b242-0f63daf96c48@gmx.com>
Date: Fri, 5 Apr 2024 07:41:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] btrfs: add extra comments on extent_map members
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712187452.git.wqu@suse.com>
 <98da90ba55445f69030a7664ae5029d710e4efbd.1712187452.git.wqu@suse.com>
 <CAL3q7H5bCtoPR09vK0LJhPqw1qv8Jz4T5nRT5dSznajzz1+yqg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5bCtoPR09vK0LJhPqw1qv8Jz4T5nRT5dSznajzz1+yqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ggrXvW4eyd78FEcmdJWeWx/xqUi5dQkeg5Ps85AG+sPiGzhCbCX
 pj7ocHiFWFBY6G1zP6+/cwv8vS3wzSh0tvyCvtkrnnwBWO5/HNKK0sEh/KdU58CXfrknemM
 42fUhRKaJBrS/VQRyQaDa94TvSUpCn55TofnuVKScwPFHjgKrLD8aRlxUuHwYnGwMCMykAa
 NchGymyYNgVtVYxDFIqkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WAUi1N63gOc=;21oXiU7SVamcEM5upXAjnDdJmGc
 VnOG+6v3SNaTGbSL8aDU8ApZ0n+6i4cjTj0y4j0uVvr1+hJzLkN3Eat/QJncebmZ+Ti/p/7ap
 paXtW8uKDZ5uoREWJp30qce/4QNCHbu74k+fWb5Abu5YvRQsf4NZoxyu76I3LcHnvjtW1Ons2
 uQrdFBDs643A5MYmWHhkqAFxlT9Ux4l7k22roCGgJlI+Saodo8iDAIxmgBwLUt2Pa0C8PKori
 Py7mgZlfsSc29wlgndRegaVKpHASooKh4IeB5+kE77bg1AJg5HT07wkpXbeMfKdtJvkenY8UI
 saEFyrcL/sQJGay50Ho6AN4iHo0vCXg3krBsLf62Mk2EQzZYxLwUMZ8VgvOQnD3V4dPFx9bzb
 YSGfsMO+rHzx1ULcx3v9Ix5qvBMUAjHxR4Pazk+fJXEpTBZlhEjVb5vHJBbCxcEX+t5/Et4uQ
 sQKjj+9yo6GZhUZeFpLaTDgjF4/GVxSRWmZn2Xlj7BbNk9rUtfCy+CQP76Kt6iPZBsmqoT/qG
 WJUxxHasWchElzNmHUJp8gO76/NUNES7hAfjWrKDZ70v6g9s71R1eDpw/Y/Flp7mjYz5jk8z5
 r/N1SemmtOkauWZbze54SPM5HKh+i/5dvV6NfTXWvJozngCkndwTcStZVajIrw2He6L0yGUcW
 zJCIbnOSrmu8/SO3eGoDJ1v/TR9K+l1pa5OHw6VXApvcbLYpuUW+AuZuwwjtj5ay2CZTKz/3M
 111m5E5wbbUpuZFuxkn0NRyuDLVaFcfvDFb7/HMd+7gAzPW+LFYJTFL4I5P1ZXTHEK7odX/L2
 djKKrB710yjPnFqd8KY/J4tlnFzuJmfumXMyXrJ0DAtBs=



=E5=9C=A8 2024/4/4 21:03, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Apr 4, 2024 at 12:47=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The extent_map structure is very critical to btrfs, as it is involved
>> for both read and write paths.
>>
>> Unfortunately the structure is not properly explained, making it pretty
>> hard to understand nor to do further improvement.
>>
>> This patch adds extra comments explaining the major members based on
>> my code reading.
>> Hopefully we can find more members to cleanup in the future.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_map.h | 54 ++++++++++++++++++++++++++++++++++++++++++=
-
>>   1 file changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>> index 10e9491865c9..82768288c6da 100644
>> --- a/fs/btrfs/extent_map.h
>> +++ b/fs/btrfs/extent_map.h
>> @@ -35,19 +35,71 @@ enum {
>>   };
>>
>>   /*
>> + * This structure represents file extents and holes.
>> + *
>>    * Keep this structure as compact as possible, as we can have really =
large
>>    * amounts of allocated extent maps at any time.
>>    */
>>   struct extent_map {
>>          struct rb_node rb_node;
>>
>> -       /* all of these are in bytes */
>> +       /* All of these are in bytes. */
>> +
>> +       /* File offset matching the offset of a BTRFS_EXTENT_ITEM_KEY k=
ey. */
>>          u64 start;
>> +
>> +       /*
>> +        * Length of the file extent.
>> +        *
>> +        * For non-inlined file extents it's btrfs_file_extent_item::nu=
m_bytes.
>> +        * For inline extents it's sectorsize, since inline data starts=
 at
>> +        * offsetof(struct , disk_bytenr) thus
>
> Missing the structure's name (btrfs_file_extent_item).
>
>> +        * btrfs_file_extent_item::num_bytes is not valid.
>> +        */
>>          u64 len;
>> +
>> +       /*
>> +        * The file offset of the original file extent before splitting=
.
>> +        *
>> +        * This is an in-memory only member, matching
>> +        * extent_map::start - btrfs_file_extent_item::offset for
>> +        * regular/preallocated extents. EXTENT_MAP_HOLE otherwise.
>> +        */
>>          u64 orig_start;
>> +
>> +       /*
>> +        * The full on-disk extent length, matching
>> +        * btrfs_file_extent_item::disk_num_bytes.
>> +        */
>>          u64 orig_block_len;
>> +
>> +       /*
>> +        * The decompressed size of the whole on-disk extent, matching
>> +        * btrfs_file_extent_item::ram_bytes.
>> +        *
>> +        * For non-compressed extents, this matches orig_block_len.
>
> It always matches btrfs_file_extent_item::ram_bytes, regardless of compr=
ession.

It always matches btrfs_file_extent_item::ram_bytes, but for
non-compressed extents it also matches em::orig_block_len.

Or should I just remove it as it doesn't provide extra info?

Thanks,
Qu
>
> Thanks.
>
>> +        */
>>          u64 ram_bytes;
>> +
>> +       /*
>> +        * The on-disk logical bytenr for the file extent.
>> +        *
>> +        * For compressed extents it matches btrfs_file_extent_item::di=
sk_bytenr.
>> +        * For uncompressed extents it matches
>> +        * btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item=
::offset
>> +        *
>> +        * For holes it is EXTENT_MAP_HOLE and for inline extents it is
>> +        * EXTENT_MAP_INLINE.
>> +        */
>>          u64 block_start;
>> +
>> +       /*
>> +        * The on-disk length for the file extent.
>> +        *
>> +        * For compressed extents it matches btrfs_file_extent_item::di=
sk_num_bytes.
>> +        * For uncompressed extents it matches extent_map::len.
>> +        * For holes and inline extents it's -1 and shouldn't be used.
>> +        */
>>          u64 block_len;
>>
>>          /*
>> --
>> 2.44.0
>>
>>
>

