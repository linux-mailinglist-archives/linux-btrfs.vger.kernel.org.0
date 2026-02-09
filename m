Return-Path: <linux-btrfs+bounces-21529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJN/BjuriWmXAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21529-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:39:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2DA10DA6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A70F302F7D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55383446BC;
	Mon,  9 Feb 2026 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BUINsQug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58A322C6D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629841; cv=none; b=T6U3Zb7RmW2HCVnWpmgc9v/pWiogoY+t6B3XKdFgGyWObzlD94GmZ2rf6DTj5QmAgTa7vhdlhOiMiSdVR2m4pE1jmB0HyMhnWI8he42vXvtDynKJCl5OiXF18iDCIw3MEUWBannsCpGMaI3KVW9gK6eZhaUrE60phpuKReitoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629841; c=relaxed/simple;
	bh=fjheMVuxJCE60otssonEPeZPH8vh1zBc03+9104sv4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcICm4n73+vaslJWs/WEAXRJodllzhhamjViJSomzk228THASger2nF41I5BBVB5DQ7S384uWiWmI3AWaLtp9qhdjPx8gSF0df5/GM/+IFjSs0EpdZH3ezwHdAgOQExgpSShzN4P+jIU8fh7k3+WBVvyqfuRfumMDy8Ms9U84TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BUINsQug; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so33567915e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770629839; x=1771234639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sxXUrIaumDVqws4DwPgvnYVK1rs+P22idn5IuOP393A=;
        b=BUINsQugKI1mAI1Ovz0ml6UlfDUvxXlG4BqKxlc+xn3i5UjwIWv5np0NOd9cLnw5ON
         ssHcOz1bk0bBvGF4YsTEGHNkUKxg7CUocuB8OHYo4fzkBSYAl7CepyxHILF1w6KeBT6F
         tmY529qzEuzgU9mFihicWBTpJavkwizetxDUSk16bxgrR96IMrTeemO5n73VOISOWMky
         j7/TekJaq/l1Sgjh4ON975I/vDXwon00bpnWkfyto2rBoVVQZokGGpwFvna9+WPPACbE
         GsSZ+HAlDcD01VbLFEe3EP3T8QPzvhEvfJn3EZFRU4euwaQbv6HraZkOSO/g87bWtuHZ
         dUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629839; x=1771234639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxXUrIaumDVqws4DwPgvnYVK1rs+P22idn5IuOP393A=;
        b=szw1ZUJqkbFeyR9NjGgiDnX23Yxwz3QFdUlpy9JgOZqEH2c8fJaiNsGqKKySm92GTj
         LxWDNUlH/pEXpVFYEpsC/7VVCKpQYdKg2MFMw5eGndep23dStKHcP+ehtMc2NJYaIK23
         5HHpBmzW33Y/q5m4J0yk47qXZqAnkeuqEhprmdw3LRK9W88WcV0yn+yx4JUOuN34Tdbq
         FK6pXg0wwMynpDk7N89BTpbNJ98lwleTnjgpXiGW00Z27lhhEP6LKGYhDy0F/DloZAOh
         a/eX+AzSlZVG3lx5ZehwJI+2bd+CTtciEkDSGR7s03YODY+JYZC94rLjLtR+EsFVmpSe
         41bQ==
X-Gm-Message-State: AOJu0YwkOQPx5r0A/7b7U0vRkp8iGKRlnjIflBcHq2w9uP/VFgB12nso
	l4/BF24tNxX7W16zOiiM8JlASFoCnwLrvUsd/aNsMy3kAs42kn9lCQKaXPl/31vQfN0=
X-Gm-Gg: AZuq6aJ/r6sT61wqpkDU3gKhZZU9B7noA8HcKxOplF0h92CdKUxvvkDoo1ncNRkS52a
	1zkjTH6yXqWfYkh/WBBkk5P2KEc82L6Dfs/4cUfHb33Iu02HAEwF+FHHjy9KeccmbSWUyvFUhQv
	PCDp/jnqBqsfRouEvBBGXYHlYdgPJSGi6ICwF0RHg1GuW8sKhRalADEDiUcINI/6Qxfcui1/TPg
	7U7xzBLfEsSXCU7l5erAG9M2iIiAsIU5+WbOaFZ3QBs7uEsXYkplng1TVJt2Ne2hRJ2BXLaVfuk
	bXm91hqP5ROKAVPd/2DGPaoPgyoy+xxhajRgRvd3vb2kav0ze7b/0etELK71qzddvCCZ3CD6mM7
	FZuycCmXhqG6TAELiN4jZD08y26TeucFqU48mQvyTiMqe6fDkWDylJgfHuJVN/ha9UO6C6FBNEh
	wCzzFrN9eIw4mLj3ENpNPWX6Yp0kN4tRBiKvX/vmc=
X-Received: by 2002:a05:600c:19cd:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-483201e270bmr137132345e9.15.1770629838900;
        Mon, 09 Feb 2026 01:37:18 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c50206sm96920765ad.19.2026.02.09.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 01:37:18 -0800 (PST)
Message-ID: <58b91c8e-6728-45f7-9de9-11c1b3e959e5@suse.com>
Date: Mon, 9 Feb 2026 20:07:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix the inline compressed extent check in
 inode_need_compress()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
References: <3cd5a484ffc3d8a499b062cbda89793d560b85d7.1770607799.git.wqu@suse.com>
 <CAL3q7H55JWn1ehjTWHg74hqd7P2pSBptcGO4XoFjkBuhqfBQCQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAL3q7H55JWn1ehjTWHg74hqd7P2pSBptcGO4XoFjkBuhqfBQCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21529-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CA2DA10DA6B
X-Rspamd-Action: no action



在 2026/2/9 19:55, Filipe Manana 写道:
> On Mon, Feb 9, 2026 at 3:30 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Since commit 59615e2c1f63 ("btrfs: reject single block sized compression
>> early"), the following script will result the inode to have NOCOMPRESS
>> flag, meanwhile old kernels don't:
>>
>>          # mkfs.btrfs -f $dev
>>          # mount $dev $mnt -o max_inline=2k,compress=zstd
>>          # truncate -s 8k $mnt/foobar
>>          # xfs_io -f -c "pwrite 0 2k" $mnt/foobar
>>          # sync
>>
>> Before that commit, the inode will not have NOCOMPRESS flag:
>>
>>          item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
>>                  generation 9 transid 9 size 8192 nbytes 4096
>>                  block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>>                  sequence 3 flags 0x0(none)
>>
>> But after that commit, the inode will have NOCOMPRESS flag:
>>
>>          item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
>>                  generation 9 transid 10 size 8192 nbytes 4096
>>                  block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>>                  sequence 3 flags 0x8(NOCOMPRESS)
>>
>> This will make a lot of files no longer to be compressed.
>>
>> [CAUSE]
>> The old compressed inline check looks like this:
>>
>>          if (total_compressed <= blocksize &&
>>             (start > 0 || end + 1 < inode->disk_i_size))
>>                  goto cleanup_and_bail_uncompressed;
>>
>> That inline part check is equal to "!(start == 0 && end + 1 >=
>> inode->disk_i_size)", but the new check no longer has that disk_i_size
>> check.
>>
>> Thus it means any single block sized write at file offset 0 will pass
>> the inline check, which is wrong.
>>
>> Furthermore, since we have merged the old check into
>> inode_need_compress(), there is no disk_i_size based inline check
>> anymore, we will always try compressing that single block at file offset
>> 0, then later find out it's not a net win and go to the
>> mark_incompressible tag.
>>
>> This results the inode to have NOCOMPRESS flag.
>>
>> [FIX]
>> Add back the missing disk_i_size based check into inode_need_compress().
>>
>> Now the same script will no longer cause NOCOMPRESS flag.
>>
>> Fixes: 59615e2c1f63 ("btrfs: reject single block sized compression early")
>> Reported-by: Chris Mason <clm@meta.com>
>> Link: https://lore.kernel.org/linux-btrfs/20260208183840.975975-1-clm@meta.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix a off-by-one bug in the disk_i_size check
>> ---
>>   fs/btrfs/inode.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index b6c763a17406..7b23ae6872fc 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -811,7 +811,8 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>>           * do not even bother try compression, as there will be no space saving
>>           * and will always fallback to regular write later.
>>           */
>> -       if (start != 0 && end + 1 - start <= fs_info->sectorsize)
>> +       if (end + 1 - start <= fs_info->sectorsize &&
>> +           !(start == 0 && end + 1 >= inode->disk_i_size))
> 
> Can we avoid the negated compound expression?
> 
> Instead of
> 
> !(start == 0 && end + 1 >= inode->disk_i_size)
> 
> Do
> 
> (start > 0 || end + 1 < inode->disk_i_size)
> 
> Which is more straightforward to read, and it's what we had originally too.

The problem is, I find the original code very hard to read.
It takes me quite some time to understand it.

The negated one is more straightforward, it shows exactly all necessary 
requirements for an inlined extent:

- File offset 0
- Covers the full file size

I don't know if it will help to introduce a short helper, and make it 
more readable like:

	if (end + 1 - start <= fs_info->sectorsize &&
	    !can_inline_range())


BTW, here we can not use can_cow_file_range_inline() directly, as at 
delalloc time our end + 1 is always block aligned, which will make 
can_cow_file_range_inline() to always return false due to the max_inline 
check.

Thanks,
Qu

> 
> Otherwise:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>>                  return 0;
>>          /* Defrag ioctl takes precedence over mount options and properties. */
>>          if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
>> --
>> 2.52.0
>>
>>


