Return-Path: <linux-btrfs+bounces-17321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820E4BB1DA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAEA17E1D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C37311C01;
	Wed,  1 Oct 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NVro/7VM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5881279918
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354221; cv=none; b=YDB4yd4zg4qNRZ3sYWhto58+Gm2UQKu812roicXOChaAyft548im7MdNLorSOSR861kUqn3FKFmStlf5Ri2pgEzJfKk/GO6w+IkxAXq/0KFm3bsVP/7UoqGgd/0LtAUlK3xqHOto4MRFhowXdakNyUoaRK7G9AuWH1E70anQzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354221; c=relaxed/simple;
	bh=onYzDiLmyZJPFBMt1VF/BEr/CpJ6ubRumFANJp6Fh6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fmWNfJDvGsyckDw6Ep9/QS8v1pfaZVGSwb5MEpxcKmCcARE8QuxnKFgzQz5PZ6ELnKBonrfa60/Bt9dqHSxZSm0xfnEv4ioe852rBV3rQlw0X2Y9lrvs1dZeuTLANdSz88ROXzJHqNlBgHwVFq9c38xjDcEpgeI124UTYpO6mHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NVro/7VM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e317bc647so1906785e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759354216; x=1759959016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=trLG3vyvJhm78WQBGrkMLGx+MJJuQtwT8qdx78dkpYc=;
        b=NVro/7VMCdG36an5ozkYcBpIMjj7EoGO2zDMqVaR7NXKFPkRIaUjvWypIo2W3SAJhO
         OtB66m8dCb01VdOwv95CBDYUdloAm2KvvzxNJx53E3o6WMeuaIDzDh9WbB//ZmN0eGyI
         2bqJiadVuJJlgkOiBD5bHf0WtUS4ssFdsOj6hNz+o5W1s4cPfLwF6RMofrU/6526s3BS
         /eiskJlS/vPmEk2LDupIO9xusYhkxn6pkeGzOQCWUXbkEJNLEVQq5PgrNYoxT4wRLx59
         aNer9KeBIYqMCLXKbJxQP/i69LGezmPOA2uwdzri8ENiqwf6+ZhPJJ/sY+kvfLVLC2U2
         +54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354216; x=1759959016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trLG3vyvJhm78WQBGrkMLGx+MJJuQtwT8qdx78dkpYc=;
        b=OOY7f2z9C62JLTDEnDffefPb/w+1DpbLlcjX1V9V6Qy7zwiB1J+TqU85zWRxsuavv9
         A0rCWYieqZpcWKnAr9i69zlekonfWGefasOP+JWtWcsorK3+J5S/PYdwmP0kXSbl6wxK
         YiYdkDFrlvSi04tveY5h+m//s+cE85h8z2k4m2u940zmHxsQ9w7U7zcIL7zQ7bKaKq+E
         qSJcGF6lW1IavEGKSyLWKKE+/KuzLllM+wI0Q7LtqlzYPUYyrP1UFDc2qgEfOMpIQ3tO
         YLDsqtvaLVioS1mTwZbaBdIc91uBj/E12Yn4ug/vIqklfPrgnq0b3JuhLKYb0ZHWt5OE
         uvbA==
X-Forwarded-Encrypted: i=1; AJvYcCUZvIk0QMJZPXlGwf/DquQxoRYoys4MmYA/+cHoYSymaefM0cso2gM0GHSfFiIDlXN3tWJJiBadGMFPmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FbFIWV1vQzdFzwdgzjHgzNJIjcf8Vzsl6BhAgmhZoa9D/J62
	KAFDXlMDW2oqZB7LlMynnCuBuQcMdYlO8MaKLysXGTRN5xps8vCpdxn2DKEnGvMXyDGR0n4aBKk
	jvx8s
X-Gm-Gg: ASbGncs0EO6iFhqk4BrwPc135GngsP8Qn44qtuIR5gsGUTdILbKIvgSKZ9SyWJXoIV0
	MM5NKjCWtWjeUYlcvIZyitxdwS68fipO9XA1n+vJhT3yJUvMR/VMlffuERZCvi7X5UtO2UWKXw3
	U6S6DyiImz58NKeOW9Ydd6FZEVCn07A/kVEfKSNdsA1/8iExD8dpM7DU0U/xFVMbj6RaDqiCbuC
	Wu7RpFKQj1GPw7zqjFaLMPYmRBMMQPyozZMvIQMyW5zKOXJHuZKAyGYo1Ok0nGYUQaWy5c+ckXR
	IJ5aqdk4c2Ug4Wv46H8L9y11VQt53EW+B4xYsH1vS3RQ2NZqJERd9+I0csIO5vTOPHzj53HWvWU
	J5e/J0vl4cmpIlwNCiAv+4GNQ5+PI/aboJfzj+NoCBQFUCbkl0LBsWB1fjeqQlVrdENUYdRINdk
	Q=
X-Google-Smtp-Source: AGHT+IEbgEFp8uYJff5d3Kv0KmJDHMfQqBijCAKp5aa3SKAKotrwjpldogWoVsXYFfxuqXUuDXExzQ==
X-Received: by 2002:a5d:64e6:0:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-4255780b1admr4088910f8f.38.1759354215973;
        Wed, 01 Oct 2025 14:30:15 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9daccsm610892b3a.16.2025.10.01.14.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 14:30:15 -0700 (PDT)
Message-ID: <1c64a0d5-d25b-48a6-9c5d-d3f562567599@suse.com>
Date: Thu, 2 Oct 2025 07:00:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not assert we found block group item when
 creating free space tree
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b9e4f03c7e13d29156da0b2cbe7c55840e526fa0.1759318478.git.fdmanana@suse.com>
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
In-Reply-To: <b9e4f03c7e13d29156da0b2cbe7c55840e526fa0.1759318478.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/1 21:07, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently, when building a free space tree at populate_free_space_tree(),
> if we are not using the block group tree feature, we always expect to find
> block group items (either extent items or a block group item with key type
> BTRFS_BLOCK_GROUP_ITEM_KEY) when we search the extent tree with
> btrfs_search_slot_for_read(), so we assert that we found an item. However
> this expectation is wrong since we can have a new block group created in
> the current transaction which is still empty and for which we still have
> not added the block group's item to the extent tree, in which case we do
> not have any items in the extent tree associated to the block group.
> 
> The insertion of a new block group's block group item in the extent tree
> happens at btrfs_create_pending_block_groups() when it calls the helper
> insert_block_group_item(). This typically is done when a transaction
> handle is released, committed or when running delayed refs (either as
> part of a transaction commit or when serving tickets for space reservation
> if we are low on free space).
> 
> So remove the assertion at populate_free_space_tree() even when the block
> group tree feature is not enabled and update the comment to mention this
> case.
> 
> Syzbot reported this with the following stack trace:
> 
>    BTRFS info (device loop3 state M): rebuilding free space tree
>    assertion failed: ret == 0 :: 0, in fs/btrfs/free-space-tree.c:1115
>    ------------[ cut here ]------------
>    kernel BUG at fs/btrfs/free-space-tree.c:1115!
>    Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
>    CPU: 1 UID: 0 PID: 6352 Comm: syz.3.25 Not tainted syzkaller #0 PREEMPT(full)
>    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>    RIP: 0010:populate_free_space_tree+0x700/0x710 fs/btrfs/free-space-tree.c:1115
>    Code: ff ff e8 d3 (...)
>    RSP: 0018:ffffc9000430f780 EFLAGS: 00010246
>    RAX: 0000000000000043 RBX: ffff88805b709630 RCX: fea61d0e2e79d000
>    RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
>    RBP: ffffc9000430f8b0 R08: ffffc9000430f4a7 R09: 1ffff92000861e94
>    R10: dffffc0000000000 R11: fffff52000861e95 R12: 0000000000000001
>    R13: 1ffff92000861f00 R14: dffffc0000000000 R15: 0000000000000000
>    FS:  00007f424d9fe6c0(0000) GS:ffff888125afc000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007fd78ad212c0 CR3: 0000000076d68000 CR4: 00000000003526f0
>    Call Trace:
>     <TASK>
>     btrfs_rebuild_free_space_tree+0x1ba/0x6d0 fs/btrfs/free-space-tree.c:1364
>     btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3062
>     btrfs_remount_rw fs/btrfs/super.c:1334 [inline]
>     btrfs_reconfigure+0xaed/0x2160 fs/btrfs/super.c:1559
>     reconfigure_super+0x227/0x890 fs/super.c:1076
>     do_remount fs/namespace.c:3279 [inline]
>     path_mount+0xd1a/0xfe0 fs/namespace.c:4027
>     do_mount fs/namespace.c:4048 [inline]
>     __do_sys_mount fs/namespace.c:4236 [inline]
>     __se_sys_mount+0x313/0x410 fs/namespace.c:4213
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7f424e39066a
>    Code: d8 64 89 02 (...)
>    RSP: 002b:00007f424d9fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
>    RAX: ffffffffffffffda RBX: 00007f424d9fdef0 RCX: 00007f424e39066a
>    RDX: 0000200000000180 RSI: 0000200000000380 RDI: 0000000000000000
>    RBP: 0000200000000180 R08: 00007f424d9fdef0 R09: 0000000000000020
>    R10: 0000000000000020 R11: 0000000000000246 R12: 0000200000000380
>    R13: 00007f424d9fdeb0 R14: 0000000000000000 R15: 00002000000002c0
>     </TASK>
>    Modules linked in:
>    ---[ end trace 0000000000000000 ]---
> 
> Reported-by: syzbot+884dc4621377ba579a6f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/68dc3dab.a00a0220.102ee.004e.GAE@google.com/
> Fixes: a5ed91828518 ("Btrfs: implement the free space B-tree")

Since the ASSERT() is only introduced in 1961d20f6fa8: btrfs: fix 
assertion when building free space tree, I think the fixed tag should 
also use that commit.
> Cc: <stable@vger.kernel.org> # 6.1.x: 1961d20f6fa8: btrfs: fix assertion when building free space tree
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/free-space-tree.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index b44e8a736cea..26e23c5b9d0c 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1100,14 +1100,15 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
>   	 * If ret is 1 (no key found), it means this is an empty block group,
>   	 * without any extents allocated from it and there's no block group
>   	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
> -	 * because we are using the block group tree feature, so block group
> -	 * items are stored in the block group tree. It also means there are no
> -	 * extents allocated for block groups with a start offset beyond this
> -	 * block group's end offset (this is the last, highest, block group).
> +	 * because we are using the block group tree feature (so block group
> +	 * items are stored in the in the block group tree) or this is a new
> +	 * block group created in the current transaction and its block group
> +	 * item was not yet inserted in the extent tree (that happens in
> +	 * btrfs_create_pending_block_groups() -> insert_block_group_item()).
> +	 * It also means there are no extents allocated for block groups with a
> +	 * start offset beyond this block group's end offset (this is the last,
> +	 * highest, block group).

I'm also wondering if the last 3 lines are still true.

We can have multiple pending block groups, thus the assumption of "no 
extents allocated for block groups with a start offset beyond this bg's 
end" doesn't sound correct to me.

>   	 */
> -	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
> -		ASSERT(ret == 0);
> -
>   	start = block_group->start;
>   	end = block_group->start + block_group->length;
>   	while (ret == 0) {

And we just skip adding free space items for pending block groups, is 
this the expected behavior?

Thanks,
Qu


