Return-Path: <linux-btrfs+bounces-17323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5BBB1E02
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735487A5B79
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 21:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82874311968;
	Wed,  1 Oct 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IMndbE6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576301EB5C2
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355415; cv=none; b=bZ0k0rRh2tZVWM1X5gui9NQbEGXYmMp0+CUkty+tU2mxr6GtLcokQqBKLWLk7ycXUnxTLNt8lrpOSSiH3GfmnI2jxBNkfgWhgE/kkHQKBUc9HYyo/+/qZfY87yD0i1QiwRaSAPbORgUXtzIxosHb/QlbEpnmwEXBpu8bKhcaRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355415; c=relaxed/simple;
	bh=i01I6U+OIOTH2Jfayxy/A3AxvfW9vtRsI3Ot+HbRZ10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7wBNqrJFpnhqG0LiIkS7PC+3avBQB5CT6mSBIX3G/dHyxv2V0azqlRNVHizSnO0NdKAkp+YC9JR2gXQK45wC8svOtuqewHmlZjH1+WXiTdIPKQ0xsMI8Rz+DNE66C42HakSk0o07PVlgYAXOXBkjL5x7y0qhFwvzcjc/CBeIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IMndbE6V; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso190095f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759355412; x=1759960212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+EMrdZ5+HJBJEfeZX4z9bLECzGt3VKaYHK9b+qsEZtw=;
        b=IMndbE6VdsE1Sdi/GDF91xvQmInf8musO+vmfmrii8u8RBE863f6hQcSj0p0cGPZgQ
         Yo84RV69PM6t53ajU7hH4QP469lKGuqOa/7hVoW18+hE7C5uqGrGb5WrOBHCEJxuZTYA
         PMqa2DhWwlzrQeS3NiOvoGpKpsHSjMQGScksxS7mkpiLIKNMuNzzqAt2wWUIgSoxhmPN
         4aAIX+qakuclGeZBbT3n0JyJjoDMj9QsPklEGbLJBKJcI7ZBKV1po8eW+2yhn5Au5c4d
         cx9u2yB6wKszHSPD/YtaHHq5VB9zGcIwH9nxf1ErkrSYv17tku6dgvPkaP28NueFQi7M
         jDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759355412; x=1759960212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EMrdZ5+HJBJEfeZX4z9bLECzGt3VKaYHK9b+qsEZtw=;
        b=DgaDVbrnquiF8dfcyrrJIqNcuiHATtT3SMAkN2W48VsLGLyaqcwNpAXfK3zpvg4LWF
         VQ8gfEz97vxUgQYY5Panrjfy2eDo0Si2VxuCf/zQrgRWvXCcAUn8lVup8U6+pp08gJ6m
         ji4FPE5LRqC0CJELHZ9M1whL+9EMegFyORSOgJUgV5odW83slCoEvRLDbjivf2rogIAI
         ySkNbbkDOlYVjiSrXCENx1aLh/Yhd5HfsZiX2P2xxbjKc5CtKKGwBFC0Q9h4DDe7361F
         g39/kmQgJdv9OM/j2oav7ytKj2/m1O/gH/QbalWXPRIJjyRJcqiugQeyx403N8YL0Lwt
         CL4g==
X-Gm-Message-State: AOJu0YwwcrlPQe8xxgdbhyPlHoSMyzd3jKvoqKlQOplKfiIYyR95njK1
	F87oPbhSb216x5isofh2royryv/pu9AlZk7AYL3wE4Rk5yTHEPZHEuRl+g5oh+d08tNeOfIqlOJ
	xPbqB
X-Gm-Gg: ASbGncu4w+O3gbhLLCMsHxW0IGpxqnr9OLdBLhKc6GhqxAhIC8TyvbcFBELVvNkUTo0
	fiOFfCWXN9TKmoizLZHx9WKEv5qKzjV1r/eM3G9UadwKrJJ/KR1RsHKjmhrcKv+H+cfw/s3kE6T
	nZNdrAuy3O6JLRkDoYxD5rfMHLql0BmV6U0XgziiS6dm+GN0uJh5rrl22cFHvNiMdkHcQ4yGFXl
	ypqtw4SVTIUmkvwMU7omHFR121CxF3w0P4mI0njdD9DQNStF54/xMBAfoQrVxCmDOsAd35iUbJx
	ZiL4c4f7k3dyynbauQmtlm6/sNbzdvQxxdgaPmuA5g4Ig8Wku11fmlNFEUs3jt+YsXvN5XRqy2m
	WlZW671FhoZi4p8JnffNqiyC/28snXS5muUi1WW4B5HXSS2jKXzYzB80D98NWxJbU1A/wp8HokR
	w=
X-Google-Smtp-Source: AGHT+IE7jotTmGCCtdeMM3BwOBfGBupo2fi5NF/PjkheU4ojPFvgjV1orYW88J84VNG/cX08KOj8SQ==
X-Received: by 2002:a05:6000:2890:b0:408:ffb9:9f62 with SMTP id ffacd0b85a97d-4255781477emr3583838f8f.29.1759355411488;
        Wed, 01 Oct 2025 14:50:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d126204sm5938845ad.40.2025.10.01.14.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 14:50:11 -0700 (PDT)
Message-ID: <dc55a6ae-b6c2-4ef6-b85e-d6d72de5a923@suse.com>
Date: Thu, 2 Oct 2025 07:20:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not assert we found block group item when
 creating free space tree
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <b9e4f03c7e13d29156da0b2cbe7c55840e526fa0.1759318478.git.fdmanana@suse.com>
 <1c64a0d5-d25b-48a6-9c5d-d3f562567599@suse.com>
 <CAL3q7H4=Z+KXriOdGbiZPR40KMS+tjR=kzoWkEB0PYG4MA0Dnw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4=Z+KXriOdGbiZPR40KMS+tjR=kzoWkEB0PYG4MA0Dnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/2 07:10, Filipe Manana 写道:
> On Wed, Oct 1, 2025 at 10:30 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2025/10/1 21:07, fdmanana@kernel.org 写道:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Currently, when building a free space tree at populate_free_space_tree(),
>>> if we are not using the block group tree feature, we always expect to find
>>> block group items (either extent items or a block group item with key type
>>> BTRFS_BLOCK_GROUP_ITEM_KEY) when we search the extent tree with
>>> btrfs_search_slot_for_read(), so we assert that we found an item. However
>>> this expectation is wrong since we can have a new block group created in
>>> the current transaction which is still empty and for which we still have
>>> not added the block group's item to the extent tree, in which case we do
>>> not have any items in the extent tree associated to the block group.
>>>
>>> The insertion of a new block group's block group item in the extent tree
>>> happens at btrfs_create_pending_block_groups() when it calls the helper
>>> insert_block_group_item(). This typically is done when a transaction
>>> handle is released, committed or when running delayed refs (either as
>>> part of a transaction commit or when serving tickets for space reservation
>>> if we are low on free space).
>>>
>>> So remove the assertion at populate_free_space_tree() even when the block
>>> group tree feature is not enabled and update the comment to mention this
>>> case.
>>>
>>> Syzbot reported this with the following stack trace:
>>>
>>>     BTRFS info (device loop3 state M): rebuilding free space tree
>>>     assertion failed: ret == 0 :: 0, in fs/btrfs/free-space-tree.c:1115
>>>     ------------[ cut here ]------------
>>>     kernel BUG at fs/btrfs/free-space-tree.c:1115!
>>>     Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
>>>     CPU: 1 UID: 0 PID: 6352 Comm: syz.3.25 Not tainted syzkaller #0 PREEMPT(full)
>>>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>>>     RIP: 0010:populate_free_space_tree+0x700/0x710 fs/btrfs/free-space-tree.c:1115
>>>     Code: ff ff e8 d3 (...)
>>>     RSP: 0018:ffffc9000430f780 EFLAGS: 00010246
>>>     RAX: 0000000000000043 RBX: ffff88805b709630 RCX: fea61d0e2e79d000
>>>     RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
>>>     RBP: ffffc9000430f8b0 R08: ffffc9000430f4a7 R09: 1ffff92000861e94
>>>     R10: dffffc0000000000 R11: fffff52000861e95 R12: 0000000000000001
>>>     R13: 1ffff92000861f00 R14: dffffc0000000000 R15: 0000000000000000
>>>     FS:  00007f424d9fe6c0(0000) GS:ffff888125afc000(0000) knlGS:0000000000000000
>>>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>     CR2: 00007fd78ad212c0 CR3: 0000000076d68000 CR4: 00000000003526f0
>>>     Call Trace:
>>>      <TASK>
>>>      btrfs_rebuild_free_space_tree+0x1ba/0x6d0 fs/btrfs/free-space-tree.c:1364
>>>      btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3062
>>>      btrfs_remount_rw fs/btrfs/super.c:1334 [inline]
>>>      btrfs_reconfigure+0xaed/0x2160 fs/btrfs/super.c:1559
>>>      reconfigure_super+0x227/0x890 fs/super.c:1076
>>>      do_remount fs/namespace.c:3279 [inline]
>>>      path_mount+0xd1a/0xfe0 fs/namespace.c:4027
>>>      do_mount fs/namespace.c:4048 [inline]
>>>      __do_sys_mount fs/namespace.c:4236 [inline]
>>>      __se_sys_mount+0x313/0x410 fs/namespace.c:4213
>>>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>      do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>>>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>      RIP: 0033:0x7f424e39066a
>>>     Code: d8 64 89 02 (...)
>>>     RSP: 002b:00007f424d9fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
>>>     RAX: ffffffffffffffda RBX: 00007f424d9fdef0 RCX: 00007f424e39066a
>>>     RDX: 0000200000000180 RSI: 0000200000000380 RDI: 0000000000000000
>>>     RBP: 0000200000000180 R08: 00007f424d9fdef0 R09: 0000000000000020
>>>     R10: 0000000000000020 R11: 0000000000000246 R12: 0000200000000380
>>>     R13: 00007f424d9fdeb0 R14: 0000000000000000 R15: 00002000000002c0
>>>      </TASK>
>>>     Modules linked in:
>>>     ---[ end trace 0000000000000000 ]---
>>>
>>> Reported-by: syzbot+884dc4621377ba579a6f@syzkaller.appspotmail.com
>>> Link: https://lore.kernel.org/linux-btrfs/68dc3dab.a00a0220.102ee.004e.GAE@google.com/
>>> Fixes: a5ed91828518 ("Btrfs: implement the free space B-tree")
>>
>> Since the ASSERT() is only introduced in 1961d20f6fa8: btrfs: fix
>> assertion when building free space tree, I think the fixed tag should
>> also use that commit.
>>> Cc: <stable@vger.kernel.org> # 6.1.x: 1961d20f6fa8: btrfs: fix assertion when building free space tree
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/free-space-tree.c | 15 ++++++++-------
>>>    1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
>>> index b44e8a736cea..26e23c5b9d0c 100644
>>> --- a/fs/btrfs/free-space-tree.c
>>> +++ b/fs/btrfs/free-space-tree.c
>>> @@ -1100,14 +1100,15 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
>>>         * If ret is 1 (no key found), it means this is an empty block group,
>>>         * without any extents allocated from it and there's no block group
>>>         * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
>>> -      * because we are using the block group tree feature, so block group
>>> -      * items are stored in the block group tree. It also means there are no
>>> -      * extents allocated for block groups with a start offset beyond this
>>> -      * block group's end offset (this is the last, highest, block group).
>>> +      * because we are using the block group tree feature (so block group
>>> +      * items are stored in the in the block group tree) or this is a new
>>> +      * block group created in the current transaction and its block group
>>> +      * item was not yet inserted in the extent tree (that happens in
>>> +      * btrfs_create_pending_block_groups() -> insert_block_group_item()).
>>> +      * It also means there are no extents allocated for block groups with a
>>> +      * start offset beyond this block group's end offset (this is the last,
>>> +      * highest, block group).
>>
>> I'm also wondering if the last 3 lines are still true.
> 
> They are.
> 
>>
>> We can have multiple pending block groups, thus the assumption of "no
>> extents allocated for block groups with a start offset beyond this bg's
>> end" doesn't sound correct to me.
> 
> If there are other pending block groups (with a higher start offset)
> without extents allocated, 1 is returned.
> If they have allocated extents, 0 is returned and then we enter into
> the loop and we just leave since they are for another block group
> (key.objectid >= end).
> 
>>
>>>         */
>>> -     if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
>>> -             ASSERT(ret == 0);
>>> -
>>>        start = block_group->start;
>>>        end = block_group->start + block_group->length;
>>>        while (ret == 0) {
>>
>> And we just skip adding free space items for pending block groups, is
>> this the expected behavior?
> 
> Yes. If there are no extents found for a block group, we don't enter
> the loop and following the loop we add a free space entry for the
> entire range of the block group.

Ah you're right.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu



> 
>>
>> Thanks,
>> Qu
>>


