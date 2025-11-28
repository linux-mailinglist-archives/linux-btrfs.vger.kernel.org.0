Return-Path: <linux-btrfs+bounces-19391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C142C90F7B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 07:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7AD434A357
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 06:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F72D24B6;
	Fri, 28 Nov 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T5hhBrCQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D412C375A
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764311619; cv=none; b=HlhibAI0+/Y2Il8pi9Ce5EBqdypuW5eNhNB5CwfCelPLBy5c2/dwOPaHnmXZnCZ1/9cDkxJTd2aTXg8rFjPRAqRn1aNskZ/KNJqNSebE83xMDqtiwYvA69JIyUadMhzl3N+B1/WPjZp/lVHbQmc5Vnl6AzuPXzvf5kSwsE8bfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764311619; c=relaxed/simple;
	bh=Lc3gfdT9Lu3f9QngPtKzGJJW/U9dAokhGDGyNQ4lk7c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BjDJfruiCH7oPlEgdGZNdYM88QQXlnnTFEQrW+xu6qUhSGkkTIeGMTHluahtW6Attyt4SmY/p0cpWUBe6gtil+EiCfzxw0J7pACoKLTBBUFS0BbZ+Zmv3MdGJXch+GnUiB4nyp7dWl3Xkau59OVk6G8rbpwr2eJjUXwbazZWNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T5hhBrCQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477770019e4so11715185e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 22:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764311613; x=1764916413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsrT5ubHZ3F8UgMeNxac4MyuI9ebaQK0E+RbSUM7t6Q=;
        b=T5hhBrCQN99nquOCX3p9vYIEnOo1S+9gBxo+VeOoM1CRGOkgMn2Qif8AqvKFRJ/YWv
         f5yF5XDyAnn9x6REEwgFu0EXfqXhNG4WSnY3BR6D16oJNvZ57bKzjwOP3HCiM/WCJPBh
         E9SvCq6KafYvs3MG+CctKztRMuZf11n+QCXncnsfPCuaNcTiBl3ysJsUP4Nx+tZn/oou
         3WcGsWb18LfDXdrrPctCpjyLE/S+Xv+EgYyO8bL6MLq2D95V7+HnYeRZclZbXn9im0cH
         s3hd8nbn6szpQlhMn9XtGsrjoSL+x+WF3aVty8YFLANVxYr2KJZGWY2oOViuiaw0WIv2
         vflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764311613; x=1764916413;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsrT5ubHZ3F8UgMeNxac4MyuI9ebaQK0E+RbSUM7t6Q=;
        b=UOaUGme9tDetmUaMNp0jpEl9LiZOOBDd5hx54BzDeuZ0L5CwhBZ60xhkVUg6uZ++3y
         c+k/ogTfP6GKkIpv/9QiT3GPig9XuWNwW9dnd8uAeiXX+ip6JWddBzfNx2HqxHwxITs1
         RR+r/QuNk854zOWZLGEzbwpt11VQNBA/WYJnTzuiiO0G2/RhJ8x4W42qYhZhP2hmz6Bc
         Dm4Q3QcmEghM/9HQS2iu/F29ZY6/BmWb5BEqd9OqQSI0b6OaM1/oKbI/ZvUPBlaStTS1
         +7xlxlh0b273j8N1oQnGkc8lZ25cv8FMRG+P8I3+Tf6053wxEn4y9zkKMmqxweRbLVND
         tFjQ==
X-Gm-Message-State: AOJu0YxWWprdNG+/bf4ArDdRwMFIwbacOUoGlvjnaGfFOQHO602OGDDx
	r6UhcY85+UNgFHY/qQqaNJTfpcrZARxSjU7ZP7RBjj06uaUqljWrPp8LPCQ4bvkxoI7x7DQi66n
	hlxLS
X-Gm-Gg: ASbGncsZ9l2+9Tcf02Z+aPm5aZa14sJNjY1hTnPBggp+Uk2/crL6Qy5UCLeO+KukoKS
	hZ8TVj9+LEfFN1+9CB4yG97u9swqbvklNbCKd/oKyhz41rFbBy5Pd20wetvNtnkRzRppshOD5aK
	YqBk+2yNhggRe/2ptrcdSVKidp3K9jecErl0QWJ/WPhC3ITZjExkhvHztNsv4RWyuslrQRwxBIJ
	vGED5bZmmaadCnR5HEu2QVXXRFHsskNWqrSNyZnc5W9xQU1Cxrxqi5xcCESIiQaepkTLwwfdhUf
	DDA+mmW3LyRKyCVbSXtNnfIB87QxSrv6UuBT/2EFqxhDybUQV4NnQuAlIRHyy5p+pzaage38ei9
	EYJSeHsiU4106kWsfXWVOoJZzTWZV9qPCZWOPamH8e0QAOKd0bN+X+W5z5OH1MaAalnrouEDk7c
	gwgns+jZzXrhug3HW1w6JbmciSmFAPDuUDBwADjVc=
X-Google-Smtp-Source: AGHT+IHrH03q69tJ1aiiqC/INhAGdxhwl1iNrSCnQ+5tzWd4jNxsY72apgKPvuGNtPa57mLRntcWEg==
X-Received: by 2002:a05:600c:4f49:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47904b24957mr128951965e9.28.1764311613430;
        Thu, 27 Nov 2025 22:33:33 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad102dd77sm12508247b3.47.2025.11.27.22.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 22:33:32 -0800 (PST)
Message-ID: <cc1b5cda-2ef5-4c8d-9591-5723185666a9@suse.com>
Date: Fri, 28 Nov 2025 17:03:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic/746: skip if btrfs' new
 block-group-tree is involved
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <f89dd72abd7040e4373d2655a7f2625f7c96c3b7.1764280576.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <f89dd72abd7040e4373d2655a7f2625f7c96c3b7.1764280576.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This is replaced by this newer patch:

  https://lore.kernel.org/linux-btrfs/20251128063137.67274-1-wqu@suse.com/

The newer patch adds proper block-group-tree support by a new python 
based script, that accepts an extra block group tree dump to properly 
handle the block group boundary case.

Thanks,
Qu

在 2025/11/28 08:26, Qu Wenruo 写道:
> [FALSE ALERT]
> The test case will fail on btrfs if the new block-group-tree feature is
> enabled:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-rc6-custom+ #321 SMP PREEMPT_DYNAMIC Sun Nov 23 16:34:33 ACDT 2025
> MKFS_OPTIONS  -- -O block-group-tree /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> generic/746 44s ... [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/746.out.bad)
>      --- tests/generic/746.out	2024-06-27 13:55:51.286338519 +0930
>      +++ xfstests-dev/results//generic/746.out.bad	2025-11-28 07:47:17.039827837 +1030
>      @@ -2,4 +2,4 @@
>       Generating garbage on loop...done.
>       Running fstrim...done.
>       Detecting interesting holes in image...done.
>      -Comparing holes to the reported space from FS...done.
>      +Comparing holes to the reported space from FS...Sectors 256-2111 are not marked as free!
>      ...
>      (Run 'diff -u xfstests-dev/tests/generic/746.out xfstests-dev/results//generic/746.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Sectors [256, 2048) are the reserved 1M free space.
> Sectors [2048, 2112) are the leading free space in the chunk tree.
> Sectors [2112, 2144) is the first tree block in the chunk tree.
> 
> However the reported free sectors from get_free_sectors() looks like this:
> 
>    2144 10566
>    10688 11711
>    ...
> 
> Note that there should be a free sector range in [2048, 2112) but it's
> not reported in get_free_sectors().
> 
> The get_free_sectors() call is fs dependent, and for btrfs it's using
> parse-extent-tree.awk script to handle the extent tree dump.
> 
> The script uses BLOCK_GROUP_ITEM items to detect the beginning of a
> block group so that it can calculate the hole between the bginning of a
> block group and the first data/metadata item.
> 
> However block-group-tree feature moves BLOCK_GROUP_ITEM items to a
> dedicated tree, making the existing script unable to parse the free
> space at the beginning of a block group.
> 
> [FIX]
> For block-group-tree feature, we need to parse both block group tree and
> extent tree and do cross-reference.
> It is not that simple to do in a single awk script, so unfortunately
> skip the test if the btrfs has block-group-tree feature enabled.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog
> v2:
> - Fix several typos in the commit message
>    Mostly related to the sequence between 1 and 2, have all kinds of typos
>    like: 2122 (should be 2112) 1244 (should be 2144)
> ---
>   tests/generic/746 | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tests/generic/746 b/tests/generic/746
> index 6f02b1cc3547..c62fdbc9de20 100755
> --- a/tests/generic/746
> +++ b/tests/generic/746
> @@ -162,6 +162,18 @@ mkdir $loop_mnt
>   _mkfs_dev $loop_dev
>   _mount $loop_dev $loop_mnt
>   
> +# The new block-group-tree will feature screw up the extent tree parsing, as
> +# there is no more block group item in that tree to mark the start
> +# of a block group, causing the free space between the beginning of bg
> +# and the first data/metadata block not counted as free space.
> +# So reject fs with block-group-tree feature for now.
> +if [ $FSTYP = "btrfs" ]; then
> +	if $BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev |\
> +		grep -q BLOCK_GROUP_TREE; then
> +		_notrun "No support for block-group-tree extent tree parsing yet"
> +	fi
> +fi
> +
>   echo -n "Generating garbage on loop..."
>   # Goal is to fill it up, ignore any errors.
>   for i in `seq 1 10`; do


