Return-Path: <linux-btrfs+bounces-15681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3FB1283D
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 02:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC26179EF8
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 00:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA28713790B;
	Sat, 26 Jul 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZsljwgHM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96545129E6E
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490646; cv=none; b=PJW9Mys4E/PDwqeFp+K2cBfLUQTFhPs58h8mgcf8FeoXCo7OLC2g9KCQrCIwuwZMLqn6K5eT1K7i7Fu5IwE9hpI6LsYsFhOfInZnK2baAxUgj+TdcDasg1wBqnQGdu/z0oiMQwcGaBZc1Kb0rgqQahCfERKE2OeJZw6Mwk0ASdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490646; c=relaxed/simple;
	bh=541VolBDoGGWn84OLYCOriBpiHFnm55R8Np0TOyjG2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCERpaoXu1ASAorRpGIUGQiqgM4HqwMX/UqXUNAOtCyuJ1xjXZe+c2aGbf46PEURkgv1D7xkCJaWw0FgXOio5GMkqfCbwstbW4WQuoGW3LER6Zhwo9tW/ScNhgN58hZuk0+ZaIdra97CG4okbNpb0y0k+qD49i/qRvF7DOttwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZsljwgHM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b77901b4d2so347762f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 17:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753490642; x=1754095442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Eop92hyjcxhXH1ZXZ4WRjmeTJodVGhy2C3rCIEcfrlo=;
        b=ZsljwgHMdQ8wixaeVEEwtPvtsQ0Q47BxyQ+yZOnrWMkkLkKWT8CwN0bSALBYCW58Fd
         I7hb0LVBevy0ZZDbPosnNVgVyFhIynODAhfzTfHhGi4UgmV3uY8LDWOgvJAGLEbVPMpd
         cR884W5ub7b5ynZrl0rY6eOnJdM/51FMWYfLnJj0dJsDmsMD1oBuMJ0MqonV3QKtsLyM
         vxliJcL1ENieIXwecfxOrEgKusQB83/4GqHRIuh+LXSu5KMsGHHrEFwAnYZRl6FZy8sF
         4CktzrWqPmHerjreTNt3X/m+vfZBh7NHjSurr51Rq7dCc1uVYFAixi0j4ufs9QEHe7pg
         YBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490642; x=1754095442;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eop92hyjcxhXH1ZXZ4WRjmeTJodVGhy2C3rCIEcfrlo=;
        b=ZaGEFcoS+O/QjTEtaEWPt7x3eBebdZOZGy8cBeRxSDKzoxU8o822Lb85HRQr0IYK5q
         MpQwBH2tciMuKqdAqplGdnQMUFqMIBZyM0A3lh3vDHcdGCiudImZfv4Udd/2fPYqEkBQ
         hrjcGhTYhNnoh5uXec+KlCBkDbxMIlW4it7DG6Ci+PU+V58GdvTqmU0VNGRmGZb3cNNy
         tUvzijnT40HKJqiPGFjQTJO8ula+giB8QyL2QhFCo8L0gQdLPAZp6v/yt/jBfsFUbuK9
         Zj02Y0XWyedVnXwcUU+Q8Lsudl+uYIYzBedmhFaOlOm99qeC8dtRDKLcJzJsm3ysqcT/
         APSw==
X-Gm-Message-State: AOJu0YzpPfuc2vzuzBkfXHnQtqwsWalMNtnDAaReYX7A7oSscnYwV8JK
	kBodzlofaU6oYQBA93KiORSLM6/07UmVU8zUlsBHDdoLATrCK2umASsf1D+Rl1lDGy0=
X-Gm-Gg: ASbGncuU2yzTyX4tv/J6nS28hCFZjH3iglDg4O/S7Hog8fTAA1nMTpDrmxv8YHSBope
	bh2MsI6w6ZZ3QIxu9j4RPTha6JHAmADwcg48roWMQqkwQdYOPznYVKJkYw7Iy6JljiVacrsbg2f
	332PKCuzy9xqsM01m3Z0w1vmOYqf7wXuNfBy5nbok3hEqjVQEsSNzavZr2GD2zx0DXywKPBgnmx
	H7iwwAdAX1pwnpkhVCls4iBqnxyqFapWJRPmgxLJZcvGUX1O0it1EZAXCmmoupPWSrTHfbOmVP1
	bvfV5EgOHb62e6u1o0g2j0VG6MgC9/9QRyOV/9lWlzWuon7sRjujzKvtBsg7bvyulEx7p7ESBiy
	sdUlTudrt+ijjY7tjGvAaoHIDIjiqmoClhoBh/Mtdc+9u2esNyg==
X-Google-Smtp-Source: AGHT+IEcu21rRq5CwSz1razndosjvgEbMlDjAkRGPfoGzP96D0ogPl1qdBxwQ9ZuN98Rzum9GRNeNQ==
X-Received: by 2002:a05:6000:4282:b0:3b7:61cb:3cc0 with SMTP id ffacd0b85a97d-3b776737529mr3163129f8f.25.1753490641569;
        Fri, 25 Jul 2025 17:44:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe586045sm5852515ad.213.2025.07.25.17.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 17:44:00 -0700 (PDT)
Message-ID: <89264798-229b-4432-b403-25dd708e3068@suse.com>
Date: Sat, 26 Jul 2025 10:13:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs-progs: check/original: detect missing orphan
 items correctly
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1753414100.git.wqu@suse.com>
 <24cda813cf05892afb67f62f5c68cd28b478ec09.1753414100.git.wqu@suse.com>
 <20250725180950.GA1649496@zen.localdomain>
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
In-Reply-To: <20250725180950.GA1649496@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/26 03:39, Boris Burkov 写道:
> On Fri, Jul 25, 2025 at 01:10:41PM +0930, Qu Wenruo wrote:
>> [BUG]
>> If we have a filesystem with a subvolume that has 0 refs but without an
>> orphan item, btrfs check won't report any error on it.
>>
>>    $ btrfs ins dump-tree -t root /dev/test/scratch1
>>    btrfs-progs v6.15
>>    root tree
>>    node 5242880 level 1 items 2 free space 119 generation 11 owner ROOT_TREE
>>    node 5242880 flags 0x1(WRITTEN) backref revision 1
>>    fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>>    chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
>>    	key (EXTENT_TREE ROOT_ITEM 0) block 5267456 gen 11
>>    	key (ROOT_TREE_DIR DIR_ITEM 2378154706) block 5246976 gen 11
>>    leaf 5267456 items 6 free space 2339 generation 11 owner ROOT_TREE
>>    leaf 5267456 flags 0x1(WRITTEN) backref revision 1
>>    fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>>    	[...]
>>    leaf 5246976 items 6 free space 1613 generation 11 owner ROOT_TREE
>>    leaf 5246976 flags 0x1(WRITTEN) backref revision 1
>>    checksum stored 47620783
>>    checksum calced 47620783
>>    fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>>    chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
>>    	[...]
>>    	item 4 key (256 ROOT_ITEM 0) itemoff 2202 itemsize 439
>>    		generation 9 root_dirid 256 bytenr 5898240 byte_limit 0 bytes_used 581632
>>    		last_snapshot 0 flags 0x1000000000000(none) refs 0 <<<
>>    		drop_progress key (0 UNKNOWN.0 0) drop_level 0
>>    		level 2 generation_v2 9
>>    	item 5 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1763 itemsize 439
>>    		generation 5 root_dirid 256 bytenr 5287936 byte_limit 0 bytes_used 4096
>>    		last_snapshot 0 flags 0x0(none) refs 1
>>    		drop_progress key (0 UNKNOWN.0 0) drop_level 0
>>    		level 0 generation_v2 5
>>    	^^^ No orphan item for subvolume 256.
>>
>> Then "btrfs check" will not report anything wrong with it:
>>
>>    Opening filesystem to check...
>>    Checking filesystem on /dev/test/scratch1
>>    UUID: ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>>    [1/8] checking log skipped (none written)
>>    [2/8] checking root items
>>    [3/8] checking extents
>>    [4/8] checking free space tree
>>    [5/8] checking fs roots
>>    [6/8] checking only csums items (without verifying data)
>>    [7/8] checking root refs
>>    [8/8] checking quota groups skipped (not enabled on this FS)
>>    found 638976 bytes used, no error found <<<
>>    total csum bytes: 0
>>    total tree bytes: 638976
>>    total fs tree bytes: 589824
>>    total extent tree bytes: 16384
>>    btree space waste bytes: 289501
>>    file data blocks allocated: 0
>>     referenced 0
>>
>> [CAUSE]
>> Although we have check_orphan_item() call inside check_root_refs(), it
>> relies the root record to have its 'found_root_item' member set.
>> Otherwise it will not report this as an error.
>>
>> But that 'found_root_item' is always set to 0, if the subvolume has zero
>> ref, this means any subvolume with 0 refs will not have its orphan item
>> checked.
>>
>> [FIX]
>> Set root_record::found_root_item to 1 inside check_fs_root().
>>
>> As check_fs_root() is called after we found a root item, we should set
>> root_record::found_root_item to indicate this fact, and allows proper
>> orphan item check to be done.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   check/main.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/check/main.c b/check/main.c
>> index b78eb59d0c50..1536c1bbbccd 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -3728,8 +3728,7 @@ static int check_fs_root(struct btrfs_root *root,
>>   	if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
>>   		rec = get_root_rec(root_cache, root->root_key.objectid);
>>   		BUG_ON(IS_ERR(rec));
>> -		if (btrfs_root_refs(root_item) > 0)
>> -			rec->found_root_item = 1;
>> +		rec->found_root_item = 1;
> 
> This change feels like an improvement to me, but it does seem to
> implicitly reduce the fidelity of the root ref checking. Like if the
> root refs was 0 but a ref existed, then we would suddenly miss that,
> where before it was an error. I think it would be best to check that
> refs is correct (i.e., store the found refs and add up the refs we see
> and make sure they match), separate from the "found_root_item" logic.

That sounds great.

We indeed need to record the actually found root refs (the current 
found_ref) and the expected root refs in root item.

This looks easy enough, and I'll add that first.

Thanks,
Qu

> 
>>   	}
>>   
>>   	memset(&root_node, 0, sizeof(root_node));
>> -- 
>> 2.50.0
>>


