Return-Path: <linux-btrfs+bounces-12080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D0A56130
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 07:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A50189514C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F201A00E7;
	Fri,  7 Mar 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="diCFJmSs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1D1632D9
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330314; cv=none; b=dIs5ePPuWWbxfFaEMSarnclpH9NSB2FlxK/78xzhTllndT0x5U/yZIj87r3/woobiMgtGjJzdFtUNZ+ySs7DovKF/J922TniTJiSUfRlQPtKvobMp5uxBfG2ZNF4Tcjw1EnHQO+KcWTGmt7L5yhzNk7K6Tckp+e+DhqP8SXii/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330314; c=relaxed/simple;
	bh=WBzfZtEzRuNn2qb/ABV5qi29fLKpmJXSi1KVmVI1vNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mRiEXbFQlFWo73Ooyw8ScqNXnuzkBmOSMKAPt7w2r2qBvmfEHpl893jeSp1XyLzoakcd6ZapSJDofHPnZAVFXKKsJ9ZLjeTIS0ywo6xkB9g60biM8VuYS69PVOpdgZ5ycN8oBJoZKVr+QTwjUEQSDXBJTVFHmktJAYbPNftQNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=diCFJmSs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so8317545e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 22:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741330310; x=1741935110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KjDHTKEEllF5R4mrz97WYn5Z9xjvLt3lAzvbaSQXpfc=;
        b=diCFJmSs1HkFVZ1IAIMC61YmwBka4jB8HmIit5NvyGbmqNI1EiGqdgZsPeGaIZvNyR
         DU66a3JMbDFLkqixzEsfzWfathUiFa2FS3V0LsVz/GCcev0ut9RVnapfElYHagkjMmJM
         qf0L++AOJeUl6E6ddYATtgAIsgDQpwNYtXxdyF4sOL1dAO/GnORqFmVXGWPkC16JE8wL
         X0soauRA1QGjewgz8M2YG+QzKJvLsfu8zTZFlp3//UfcxZWPAHeEmHJNa1KkLTQ3mCZk
         PDsNRx6oi6hJgHMuiYegxgik+tiJqjlpuu0FvJpIyk42aB44FJend5TcbYqtHIrVS64A
         UFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741330310; x=1741935110;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjDHTKEEllF5R4mrz97WYn5Z9xjvLt3lAzvbaSQXpfc=;
        b=J4T9WsAWy1fhAPziF45ZObG2Bypt4/y/gIAw0TcKwtg44M5zc+8iAb5B8qmhHAKAG3
         Mvw6KhnrCOXJRjquG4LipskZCekqDTS3B40p/vxWR86AjrGEGKo7/c6P5jhkpqsmGilu
         EjEzFWVxJoQ5tSwsbt9si+NkVVL9dq6wGDHl4FPiBoPHjm+XeYfT0WGpnwl25p8Jbmxq
         rl8e5iA8aRkcC69mWw3eVKqSls2z+GWDWTlyFEZkhtzNzetYU90EGwBuJwc13LnuGfHE
         HoNPIHyat2Yr5474LvViGgBVda2ES6HAZR+zKvP8Uqn5L9YNz/W7ypV9GwkhlCjxF/1B
         tk1g==
X-Forwarded-Encrypted: i=1; AJvYcCXXKLc2ke73LLukM4Q5+WnY8rLXGc+Ro2GQa5pSorIu64okO1wABN0O2VoYT28KY+one4cw6JmYHHshCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97CXI8lMTXzxD3gGtsfX/QoxSZlSHhMayOqzhW5YIFIJ7ZsLy
	yzSTomvVWs4BYafBfsXxYx1cuIuuiOmFUI0zFXIKo3RITF37s2YalHdQt/fHZkw=
X-Gm-Gg: ASbGncvEfShS+7yDYLtuko2rMFe12d7GT08vojQCcKcePxNEyCuiXkboQZiAQyKAbHn
	/Z87hYT/DDwH4a5J2PsEioavqCTPMhCYSCBG9MyOhMvLBSTGtnhK692dtaWoyWO9ZgtNGmg3u6I
	LPTeVD5b3L8uO8/MZz3xN4mMEF+kWL9tQkccZKTt404m3FEfLWu9OmGWWTN5qg78ZT6Y7Bscj/k
	n1jtdfPCtpB7cuW4KTVqWOIyvwGhzKcMQp43YuOV1b6VoWOHzC0x9GU0M/TmsGLpVyN64//SDwR
	jX1+DfEipaofVOmgI8ulYIVZf1sUJjzNZxr4ynBPfL/+xLuot2Wg3wf2qhgXVjFWZwXykqvJ
X-Google-Smtp-Source: AGHT+IE1qMmcly7OSB4afXS42Q5Ic5WV6onY/sTbItGe9EeFWAPdNRobEZ2ZGypoX/ced/LIpgYIXg==
X-Received: by 2002:a05:6000:42c2:b0:391:29ab:c9cb with SMTP id ffacd0b85a97d-39132d8b071mr634113f8f.17.1741330310147;
        Thu, 06 Mar 2025 22:51:50 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e9fbfsm23172825ad.92.2025.03.06.22.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 22:51:49 -0800 (PST)
Message-ID: <e95dcd84-f586-404a-b6ab-dbf4a06baeab@suse.com>
Date: Fri, 7 Mar 2025 17:21:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] btrfs: fix bg refcount race in
 btrfs_create_pending_block_groups
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1741306938.git.boris@bur.io>
 <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
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
In-Reply-To: <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/7 10:59, Boris Burkov 写道:
> To avoid a race where mark_bg_unused spuriously "moved" the block_group
> from one bg_list attachment to another without taking a ref, we mark a
> new block group with the bit BLOCK_GROUP_FLAG_NEW.
> 
> However, this fix is not quite complete. Since it does not use the
> unused_bg_lock, it is possible for the following race to occur:
> 
> create_pending_block_groups                     mark_bg_unused
>                                             if list_empty // false
>          list_del_init
>          clear_bit
>                                             else if (test_bit) // true
>                                                  list_move_tail
> 
> And we get into the exact same broken ref count situation.
> Those look something like:
> [ 1272.943113] ------------[ cut here ]------------
> [ 1272.943527] refcount_t: underflow; use-after-free.
> [ 1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
> [ 1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress raid6_pq null_blk [last unloaded: btrfs]
> [ 1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loaded Tainted: G        W          6.14.0-rc5+ #108
> [ 1272.946368] Tainted: [W]=WARN
> [ 1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [ 1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
> [ 1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
> [ 1272.948180] Code: 01 01 e8 e9 c7 a9 ff 0f 0b c3 cc cc cc cc 80 3d 3f 4a de 01 00 75 85 48 c7 c7 00 9b 9f 8f c6 05 2f 4a de 01 01 e8 c6 c7 a9 ff <0f> 0b c3 cc cc cc cc 80 3d 1d 4a de 01 00 0f 85 5e ff ff ff 48 c7
> [ 1272.949532] RSP: 0018:ffffbf1200247df0 EFLAGS: 00010282
> [ 1272.949901] RAX: 0000000000000000 RBX: ffffa14b00e3f800 RCX: 0000000000000000
> [ 1272.950437] RDX: 0000000000000000 RSI: ffffbf1200247c78 RDI: 00000000ffffdfff
> [ 1272.950986] RBP: ffffa14b00dc2860 R08: 00000000ffffdfff R09: ffffffff90526268
> [ 1272.951512] R10: ffffffff904762c0 R11: 0000000063666572 R12: ffffa14b00dc28c0
> [ 1272.952024] R13: 0000000000000000 R14: ffffa14b00dc2868 R15: 000001285dcd12c0
> [ 1272.952850] FS:  0000000000000000(0000) GS:ffffa14d33c40000(0000) knlGS:0000000000000000
> [ 1272.953458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1272.953931] CR2: 00007f838cbda000 CR3: 000000010104e000 CR4: 00000000000006f0
> [ 1272.954474] Call Trace:
> [ 1272.954655]  <TASK>
> [ 1272.954812]  ? refcount_warn_saturate+0xba/0x110
> [ 1272.955173]  ? __warn.cold+0x93/0xd7
> [ 1272.955487]  ? refcount_warn_saturate+0xba/0x110
> [ 1272.955816]  ? report_bug+0xe7/0x120
> [ 1272.956103]  ? handle_bug+0x53/0x90
> [ 1272.956424]  ? exc_invalid_op+0x13/0x60
> [ 1272.956700]  ? asm_exc_invalid_op+0x16/0x20
> [ 1272.957011]  ? refcount_warn_saturate+0xba/0x110
> [ 1272.957399]  btrfs_discard_cancel_work.cold+0x26/0x2b [btrfs]
> [ 1272.957853]  btrfs_put_block_group.cold+0x5d/0x8e [btrfs]
> [ 1272.958289]  btrfs_discard_workfn+0x194/0x380 [btrfs]
> [ 1272.958729]  process_one_work+0x130/0x290
> [ 1272.959026]  worker_thread+0x2ea/0x420
> [ 1272.959335]  ? __pfx_worker_thread+0x10/0x10
> [ 1272.959644]  kthread+0xd7/0x1c0
> [ 1272.959872]  ? __pfx_kthread+0x10/0x10
> [ 1272.960172]  ret_from_fork+0x30/0x50
> [ 1272.960474]  ? __pfx_kthread+0x10/0x10
> [ 1272.960745]  ret_from_fork_asm+0x1a/0x30
> [ 1272.961035]  </TASK>
> [ 1272.961238] ---[ end trace 0000000000000000 ]---
> 
> Though we have seen them in the async discard workfn as well. It is
> most likely to happen after a relocation finishes which cancels discard,
> tears down the block group, etc.
> 
> Fix this fully by taking the lock around the list_del_init + clear_bit
> so that the two are done atomically.
> 
> Fixes: 0657b20c5a76 ("btrfs: fix use-after-free of new block group that became unused")
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/block-group.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 64f0268dcf02..2db1497b58d9 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2797,8 +2797,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
>   		/* Already aborted the transaction if it failed. */
>   next:
>   		btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> +
> +		spin_lock(&fs_info->unused_bgs_lock);
>   		list_del_init(&block_group->bg_list);
>   		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
> +		spin_unlock(&fs_info->unused_bgs_lock);
>   
>   		/*
>   		 * If the block group is still unused, add it to the list of


