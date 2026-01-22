Return-Path: <linux-btrfs+bounces-20930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIQSGYK3cmlKowAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20930-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 00:49:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B455C6E979
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 00:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CA2F3013799
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 23:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B053DC969;
	Thu, 22 Jan 2026 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TQkfAPeT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A703D667F
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125750; cv=none; b=GrrYCu+JN+7nWbd2vWKEto5ekwdN+XUMfx9cuRwKEazqbRFIntTe5ZilIZrX+nCFYVy52MNKfFsUE4VIlYpAqmLhWZUS4eRSrLMZs4wMdEOmqS+zDyKpP6TqQKWDbbYzHd4HMWLPGi6UC4c5V3twwuuPH5ubiQAZtSfXw1UCWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125750; c=relaxed/simple;
	bh=qSCHXnNBLEVqhRx3sky3d2Mj4dsVTouoZkz/Y61Z+b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=th8+GY1fa2T7444WtjbTjzJlSMWC9JgzZrKjnz5lUcu0/GGc6tbjV0oGHJcfwqczN45zwUDihhxHibzU50ySs2tnB/Nm0KUfs2VrBeEGU/r0/315SNo2JEOX63HIZLuvjSk3vUGDRt8RCr0vEQOLAycczu0d/PTAPIAA5TbWeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TQkfAPeT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee0291921so13802235e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 15:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769125740; x=1769730540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i5+xLP28prZ/2yOgx1ZA76KP1nJ3pBLWLq6u9DqqBv4=;
        b=TQkfAPeTC2qD+Bh4GUCALxkeZwkijpvHeXtBuugYW5sVlnVzW+yETXO395Nc85knyJ
         7wpRp1LTwRj8qRPdWwDIONW/1y/leBDdvOFflEBTMWAzcZsAVis7y20LsbwLx8v7276G
         bYj+t5WzOokbztwAxHbHjgBQ5uruBPlInqdMTq5Xno2UxC33PvclKJNpT+KBT+z71Ku/
         SZHgLjx52AcqRkbMsXQAqeUIJpczUZj5QXQhMOpZgrP3k+6RJgyvo8FPIQTnnO/0JYH+
         hgZrbjJqsNd4whqsRqlKTxm9YZcgCMO6M/HP/vcsA0zNNx4oJfe4QKhvCJpsJZqeDwyL
         OOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125740; x=1769730540;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5+xLP28prZ/2yOgx1ZA76KP1nJ3pBLWLq6u9DqqBv4=;
        b=RejnVdnooKDGlooVw46pQlL58HLBpPhzkWintwUA+/gfueF7CI/QcJuWAhvob1QLQZ
         Wh1iIZMyu2/mW90ukZZvL79/XwE7WVvSJFtDW3+t6+MuxbsrdwXAbbcMbw5DkZxcA2t6
         8aeuyp9ZoupOyuYUEpYV9phWfFg85VeUTX+G5Ay8K5hPU0ypAFt8Yg3nsK/2uLcCO4Sw
         ZqApH+hol1xwfkVI+hSIgXFo7869z+A4hyc3Ys9Xl+ijVttliJ7jj2CW/g/MSpbPEFpJ
         p9QI0b9McQXaqB85+GcbdNVYDpWqBtoNwNpmOTF2+Z8gfgLoup9udewcnx6O8K5yix3m
         RvJA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLWYf4m9foc1ZkQ4UfzuVM/lSRCCKft6TBkzOd4JNqlX4/YBLLCk6CIFuU1wgf8JRrqt5vmExnKrJGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrs6f024IdTFSx6iRZMDR6TefFZ3qceScYc05q4Cnu5dd8fSMS
	Wl91CmZlun38BWY5frcJCtZ/WGbpEX5cTEYQpfJLfKEQiLqv1jOtGt8f4NGPAfvfDVr5u0Oo7gJ
	lCMlX
X-Gm-Gg: AZuq6aK8AgyI1v8yCpMcX906vHvAfonR7zaCZAWKqiZl/5yYK2HDvDWc/KHdCuZikVW
	YWdDs6L82Uti6ZNhcAdnKsTMHgT8U8+rZMnptvoIvIWrIGQ6Z80YvK++wrnhyqUn9+eeVA4ReId
	bzl8U6+VQ+BKkus2xNbJE+IhJ9LyrOZXEjlq902G1Sa9eJOud5mMCrZ6GDrqxfqEOQetkxZbVey
	aDA5QTktGM8XZLHuG97XVMLc9k8KUmXnHTQQNFyrNd0EtAPy9rEX4z9XWXNGU0KjJ9dMiArQAhD
	GPDcSi9VwDHGMg7e2K4DY2kXVZ5MxU922lEBgBSF42UQk6dSJ1KbIJxlFrg/bHVYziKKH57oznP
	fH4vj+0eKdMxBjChRVZNPpOuXSgdNYLRDnPRszUjXxvVtYf1QWTmQL1riFut/Wn4ckzk1eSWC68
	G2khu9TnqV8Z6sO87UpgeMxrTfc8LSLgm4o+p6cx0=
X-Received: by 2002:a05:600c:3b18:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-4804c94c4c4mr18583155e9.11.1769125740159;
        Thu, 22 Jan 2026 15:49:00 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fdd4e8sm2977435ad.99.2026.01.22.15.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 15:48:59 -0800 (PST)
Message-ID: <424c4694-c89d-43bd-a78e-910b6d0db3ba@suse.com>
Date: Fri, 23 Jan 2026 10:18:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix EEXIST abort due to non-consecutive gaps in
 chunk allocation
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <ce8537968dd7228cc7cbde394b854fde6bb78e3c.1769119556.git.boris@bur.io>
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
In-Reply-To: <ce8537968dd7228cc7cbde394b854fde6bb78e3c.1769119556.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20930-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B455C6E979
X-Rspamd-Action: no action



在 2026/1/23 08:37, Boris Burkov 写道:
> I have been observing a number of systems aborting at
> insert_dev_extents() in btrfs_create_pending_block_groups(). The
> following is a sample stack trace of such an abort coming form forced
> chunk allocation (typically behind CONFIG_BTRFS_EXPERIMENTAL) but this
> can theoretically happen to any DUP chunk allocation.
> 
> [   81.801251] ------------[ cut here ]------------
> [   81.801587] BTRFS: Transaction aborted (error -17)
> [   81.801924] WARNING: fs/btrfs/block-group.c:2876 at btrfs_create_pending_block_groups+0x721/0x770 [btrfs], CPU#1: bash/319
> [   81.802764] Modules linked in: virtio_net btrfs xor zstd_compress raid6_pq null_blk
> [   81.803310] CPU: 1 UID: 0 PID: 319 Comm: bash Kdump: loaded Not tainted 6.19.0-rc6+ #319 NONE
> [   81.803916] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
> [   81.804552] RIP: 0010:btrfs_create_pending_block_groups+0x723/0x770 [btrfs]
> [   81.805074] Code: 0b 00 00 4c 89 ff 4c 89 54 24 10 48 c7 c6 00 30 6a c0 e8 c0 14 02 00 4c 8b 54 24 10 e9 4c fa ff ff 48 8d 3d ef c6 08 00 89 ee <67> 48 0f b9 3a 4c 8b 54 24 10 41 b8 01 00 00 00 e9 f4 5e 03 00 48
> [   81.806305] RSP: 0018:ffffa36241a6bce8 EFLAGS: 00010282
> [   81.806673] RAX: 000000000000000d RBX: ffff8e699921e400 RCX: 0000000000000000
> [   81.807154] RDX: 0000000002040001 RSI: 00000000ffffffef RDI: ffffffffc0608bf0
> [   81.807658] RBP: 00000000ffffffef R08: ffff8e69830f6000 R09: 0000000000000007
> [   81.808145] R10: ffff8e699921e5e8 R11: 0000000000000000 R12: ffff8e6999228000
> [   81.808676] R13: ffff8e6984d82000 R14: ffff8e69966a69c0 R15: ffff8e69aa47b000
> [   81.809162] FS:  00007fec6bdd9740(0000) GS:ffff8e6b1b379000(0000) knlGS:0000000000000000
> [   81.809725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   81.810114] CR2: 00005604833670f0 CR3: 0000000116679000 CR4: 00000000000006f0
> [   81.810631] Call Trace:
> [   81.810821]  <TASK>
> [   81.810978]  __btrfs_end_transaction+0x3e/0x2b0 [btrfs]
> [   81.811368]  btrfs_force_chunk_alloc_store+0xcd/0x140 [btrfs]
> [   81.811823]  kernfs_fop_write_iter+0x15f/0x240
> [   81.812128]  vfs_write+0x264/0x500
> [   81.812365]  ksys_write+0x6c/0xe0
> [   81.812640]  do_syscall_64+0x66/0x770
> [   81.812909]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   81.813246] RIP: 0033:0x7fec6be66197
> [   81.813521] Code: 48 89 fa 4c 89 df e8 98 af 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [   81.814798] RSP: 002b:00007fffb159dd30 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [   81.815292] RAX: ffffffffffffffda RBX: 00007fec6bdd9740 RCX: 00007fec6be66197
> [   81.815822] RDX: 0000000000000002 RSI: 0000560483374f80 RDI: 0000000000000001
> [   81.816289] RBP: 0000560483374f80 R08: 0000000000000000 R09: 0000000000000000
> [   81.816861] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> [   81.817327] R13: 00007fec6bfb85c0 R14: 00007fec6bfb5ee0 R15: 00005604833729c0
> [   81.817837]  </TASK>
> [   81.817993] irq event stamp: 20039
> [   81.818224] hardirqs last  enabled at (20047): [<ffffffff99a68302>] __up_console_sem+0x52/0x60
> [   81.818815] hardirqs last disabled at (20056): [<ffffffff99a682e7>] __up_console_sem+0x37/0x60
> [   81.819375] softirqs last  enabled at (19470): [<ffffffff999d2b46>] __irq_exit_rcu+0x96/0xc0
> [   81.819990] softirqs last disabled at (19463): [<ffffffff999d2b46>] __irq_exit_rcu+0x96/0xc0
> [   81.820611] ---[ end trace 0000000000000000 ]---
> [   81.820949] BTRFS: error (device dm-7 state A) in btrfs_create_pending_block_groups:2876: errno=-17 Object already exists
> 
> Inspecting these aborts with drgn, I observed a pattern of overlapping
> chunk_maps. Note how stripe 1 of the first chunk overlaps in physical
> address with stripe 0 of the second chunk.
> 
> Physical Start     Physical End       Length       Logical            Type                 Stripe
> ----------------------------------------------------------------------------------------------------
> 0x0000000102500000 0x0000000142500000 1.0G         0x0000000641d00000 META|DUP             0/2
> 0x0000000142500000 0x0000000182500000 1.0G         0x0000000641d00000 META|DUP             1/2
> 0x0000000142500000 0x0000000182500000 1.0G         0x0000000601d00000 META|DUP             0/2
> 0x0000000182500000 0x00000001c2500000 1.0G         0x0000000601d00000 META|DUP             1/2
> 
> Now how could this possibly happen? All chunk allocation is protected by
> the chunk_mutex so racing allocations should see a consistent view of
> the CHUNK_ALLOCATED bit in the chunk allocation extent-io-tree
> (device->alloc_state as set by chunk_map_device_set_bits()) The tree
> itself is protected by a spin lock, and clearing/setting the bits is
> always protected by fs_info->mapping_tree_lock, so no race is apparent.
> 
> It turns out that there is a subtle bug in the logic regarding chunk
> allocations that have happened in the current transaction, known as
> "pending extents". The chunk allocation as defined in
> find_free_dev_extent() is a loop which searches the commit root of the
> dev_root and looks for gaps between DEV_EXTENT items. For those gaps, it
> then checks alloc_state bitmap for any pending extents and adjusts the
> hole that it finds accordingly. However, the logic in that adjustment
> assumes that the first pending extent is the only one in that range.
> 
> e.g., given a layout with two non-consecutive pending extents in a hole
> passed to dev_extent_hole_check() via *hole_start and *hole_size:
> 
>    |----pending A----|    real hole     |----pending B----|
>             |           candidate hole        |
>        *hole_start                         *hole_start + *hole_size
> 
> the code incorrectly returns a "hole" from the end of pending extent A
> until the passed in hole end, failing to account for pending B.
> 
> However, it is not entirely obvious that it is actually possible to
> produce such a layout. I was able to reproduce it, but with some
> contortions: I continued to use the force chunk allocation sysfs file
> and I introduced a long delay (10 seconds) into the start of the cleaner
> thread. I also prevented the unused bgs cleaning logic from ever
> deleting metadata bgs. These help make it easier to deterministically
> produce the condition but shouldn't really matter if you imagine the
> conditions happening by race/luck. Allocations/frees can happen
> concurrently with the cleaner thread preparing to process an unused
> extent and both create some used chunks with an unused chunk
> interleaved, all during one transaction. Then btrfs_delete_unused_bgs()
> sees the unused one and clears it, leaving a range with several pending
> chunk allocations and a gap in the middle.
> 
> The basic idea is that the unused_bgs cleanup work happens on a worker
> so if we allocate 3 block groups in one transaction, then the cleaner
> work kicked off by the previous transaction comes through and deletes
> the middle one of the 3, then the commit root shows no dev extents and
> we have the bad pattern in the extent-io-tree.

I'm wondering, can we just stop the unused bg cleaner if there is any 
pending bgs.

The priority should be pretty obvious, correctness of 
dev-extent/bg/chunks are way higher than unused bgs cleanup.

And unused bg cleanups is always triggered from cleaner kthread, which 
is done periodically, so even if we skipped one or two runs, we still 
have a lot of chances to do the cleanup.

Sure there will be some corner cases when there is very limited 
available space left and the data/metadata is very unbalanced, but 
transaction aborting is a much bigger concern now.


Another thing is, I'm not sure if it's really that important/useful to 
delay dev-extent tree update.
Considering new pending block groups will be created at commit 
transaction time, I'm wondering why not just updating dev-extent tree, 
so that the current dev-extent tree will always reflect the real usage, 
without the need to bother the bitmap.

And even if a power loss happened, we will only see the old dev-extent 
tree, no mismatch between chunk/bg trees.

Of course it will slow down chunk allocation, but should also be less 
complex.

Thanks,
Qu

> One final consideration
> is that the code happens to loop to the next hole if there are no more
> extents at all, so we need one more dev extent way past the area we are
> working in. Something like the following demonstrates the technique:
> 
>   # push the BG frontier out to 20G
>   fallocate -l 20G $mnt/foo
>   # allocate one more that will prevent the "no more dev extents" luck
>   fallocate -l 1G $mnt/sticky
>   # sync
>   sync
>   # clear out the allocation area
>   rm $mnt/foo
>   sync
>   _cleaner
>   # let everything quiesce
>   sleep 20
>   sync
> 
>   # dev tree should have one bg 20G out and the rest at the beginning..
>   # sort of like an empty FS but with a random sticky chunk.
> 
>   # kick off the cleaner in the background, remember it will sleep 10s
>   # before doing interesting work
>   _cleaner &
> 
>   sleep 3
> 
>   # create 3 trivial block groups, all empty, all immediately marked as unused.
>   echo 1 > "$(_btrfs_sysfs_space_info $dev metadata)/force_chunk_alloc"
>   echo 1 > "$(_btrfs_sysfs_space_info $dev data)/force_chunk_alloc"
>   echo 1 > "$(_btrfs_sysfs_space_info $dev metadata)/force_chunk_alloc"
> 
>   # let the cleaner thread definitely finish, it will remove the data bg
>   sleep 10
> 
>   # this allocation sees the non-consecutive pending metadata chunks with
>   # data chunk gap of 1G and allocates a 2G extent in that hole. ENOSPC!
>   echo 1 > "$(_btrfs_sysfs_space_info $dev metadata)/force_chunk_alloc"
> 
> As for the fix, it is not that obvious. I could not see a trivial way to
> do it even by adding backup loops into find_free_dev_extent(), so I
> opted to change the semantics of dev_extent_hole_check() to not stop
> looping until it finds a sufficiently big hole. For clarity, this also
> required changing the helper function contains_pending_extent() into two
> new helpers which find the first pending extent and the first suitable
> hole in a range.
> 
> I attempted to clean up the documentation and range calculations to be
> as consistent and clear as possible for the future.
> 
> I also looked at the zoned case and concluded that the loop there is
> different and not to be unified with this one. As far as I can tell, the
> zoned check will only further constrain the hole so looping back to find
> more holes is acceptable. Though given that zoned really only appends, I
> find it highly unlikely that it is susceptible to this bug.
> 
> Fixes: 1b9845081633 ("Btrfs: fix find_free_dev_extent() malfunction in case device tree has hole")
> Reported-by: Dimitrios Apostolou <jimis@gmx.net>
> Closes: https://lore.kernel.org/linux-btrfs/q7760374-q1p4-029o-5149-26p28421s468@tzk.arg/
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/volumes.c | 221 ++++++++++++++++++++++++++++++++-------------
>   1 file changed, 160 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index af0197b242a7..e2d41e9cd84f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1509,30 +1509,139 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
>   }
>   
>   /*
> - * Try to find a chunk that intersects [start, start + len] range and when one
> - * such is found, record the end of it in *start
> + * Find the first pending extent intersecting a range.
> + *
> + * @device: the device to search
> + * @start: start of the range to check
> + * @len: length of the range to check
> + * @pending_start: output pointer for the start of the found pending extent
> + * @pending_end: output pointer for the end of the found pending extent (inclusive)
> + *
> + * Search for a pending chunk allocation that intersects the half-open range
> + * [start, start + len).
> + *
> + * Return: true if a pending extent was found, false otherwise.
> + * If the return value is true, store the first pending extent in
> + * [*pending_start, *pending_end]. Otherwise, the two output variables
> + * may still be modified, to something outside the range and should not
> + * be used.
>    */
> -static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
> -				    u64 len)
> +static bool first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
> +				 u64 *pending_start, u64 *pending_end)
>   {
> -	u64 physical_start, physical_end;
> -
>   	lockdep_assert_held(&device->fs_info->chunk_mutex);
>   
> -	if (btrfs_find_first_extent_bit(&device->alloc_state, *start,
> -					&physical_start, &physical_end,
> +	if (btrfs_find_first_extent_bit(&device->alloc_state, start,
> +					pending_start, pending_end,
>   					CHUNK_ALLOCATED, NULL)) {
>   
> -		if (in_range(physical_start, *start, len) ||
> -		    in_range(*start, physical_start,
> -			     physical_end + 1 - physical_start)) {
> -			*start = physical_end + 1;
> +		if (in_range(*pending_start, start, len) ||
> +		    in_range(start, *pending_start,
> +			     *pending_end + 1 - *pending_start)) {
>   			return true;
>   		}
>   	}
>   	return false;
>   }
>   
> +/*
> + * Find the first real hole accounting for pending extents.
> + *
> + * @device: the device containing the candidate hole
> + * @start: input/output pointer for the hole start position
> + * @len: input/output pointer for the hole length
> + * @min_hole_size: the size of hole we are looking for
> + *
> + * Given a potential hole specified by [*start, *start + *len), check for pending
> + * chunk allocations within that range. If pending extents are found, the hole is
> + * adjusted to represent the first true free space that is large enough when
> + * accounting for pending chunks.
> + *
> + * Note that this function must handle various cases involving non
> + * consecutive pending extents.
> + *
> + * Returns: true if a suitable hole was found, false otherwise.
> + * If the return value is true, then *start and *len are set to represent the hole.
> + * If the return value is false, then *start is set to the end of the range and
> + * *len is set to 0.
> + */
> +static bool find_hole_in_pending_extents(struct btrfs_device *device, u64 *start, u64 *len,
> +					 u64 min_hole_size)
> +{
> +	u64 pending_start, pending_end;
> +	u64 end;
> +	bool success = false;
> +
> +	lockdep_assert_held(&device->fs_info->chunk_mutex);
> +
> +	if (*len == 0)
> +		return false;
> +
> +	end = *start + *len - 1;
> +
> +	while (true) {
> +		if (first_pending_extent(device, *start, *len, &pending_start, &pending_end)) {
> +			/*
> +			 * Case 1: the pending extent overlaps the start of
> +			 * candidate hole. That means the true hole is after the
> +			 * pending extent, but we need to find the next pending
> +			 * extent to properly size the hole. In the next loop,
> +			 * we will reduce to case 2 or 3.
> +			 * e.g.,
> +			 *   |----pending A----|    real hole     |----pending B----|
> +			 *            |           candidate hole        |
> +			 *         *start                              end
> +			 */
> +			if (pending_start <= *start) {
> +				*start = pending_end + 1;
> +				goto next;
> +			}
> +			/*
> +			 * Case 2: The pending extent starts after *start (and overlaps
> +			 * [*start, end), so the first hole just goes up to the start
> +			 * of the pending extent.
> +			 * e.g.,
> +			 *   |    real hole    |----pending A----|
> +			 *   |       candidate hole     |
> +			 * *start                      end
> +			 *
> +			 */
> +			*len = pending_start - *start;
> +			if (*len >= min_hole_size) {
> +				success = true;
> +				break;
> +			}
> +			/*
> +			 * If the hole wasn't big enough, then we advance past
> +			 * the pending extent and keep looking.
> +			 */
> +			*start = pending_end + 1;
> +			goto next;
> +		} else {
> +			/*
> +			 * Case 3: There is no pending extent overlapping the
> +			 * range [*start, *start + *len - 1], so the only remaining
> +			 * hole is the remaining range.
> +			 * e.g.,
> +			 *   |       candidate hole           |
> +			 *   |          real hole             |
> +			 * *start                            end
> +			 */
> +			if (*len >= min_hole_size)
> +				success = true;
> +			break;
> +		}
> +next:
> +		if (*start > end) {
> +			*start = end + 1;
> +			*len = 0;
> +			return false;
> +		}
> +		*len = end - *start + 1;
> +	}
> +	return success;
> +}
> +
>   static u64 dev_extent_search_start(struct btrfs_device *device)
>   {
>   	switch (device->fs_devices->chunk_alloc_policy) {
> @@ -1597,59 +1706,51 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
>   }
>   
>   /*
> - * Check if specified hole is suitable for allocation.
> + * Validate and adjust a hole for chunk allocation
>    *
> - * @device:	the device which we have the hole
> - * @hole_start: starting position of the hole
> - * @hole_size:	the size of the hole
> - * @num_bytes:	the size of the free space that we need
> + * @device: the device containing the candidate hole
> + * @hole_start: input/output pointer for the hole start position
> + * @hole_size: input/output pointer for the hole size
> + * @num_bytes: minimum allocation size required
>    *
> - * This function may modify @hole_start and @hole_size to reflect the suitable
> - * position for allocation. Returns 1 if hole position is updated, 0 otherwise.
> + * Check if the specified hole is suitable for allocation and adjust it if
> + * necessary. The hole may be modified to skip over pending chunk allocations
> + * and to satisfy stricter zoned requirements on zoned fs-es.
> + *
> + * For regular (non-zoned) allocation, if the hole after adjustment is smaller
> + * than @num_bytes, the search continues past additional pending extents until
> + * either a sufficiently large hole is found or no more pending extents exist.
> + *
> + * Return: true if a suitable hole was found and false otherwise.
>    */
>   static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
>   				  u64 *hole_size, u64 num_bytes)
>   {
> -	bool changed = false;
> -	u64 hole_end = *hole_start + *hole_size;
> +	bool found = false;
> +	u64 hole_end = *hole_start + *hole_size - 1;
>   
> -	for (;;) {
> -		/*
> -		 * Check before we set max_hole_start, otherwise we could end up
> -		 * sending back this offset anyway.
> -		 */
> -		if (contains_pending_extent(device, hole_start, *hole_size)) {
> -			if (hole_end >= *hole_start)
> -				*hole_size = hole_end - *hole_start;
> -			else
> -				*hole_size = 0;
> -			changed = true;
> -		}
> +	ASSERT(*hole_size > 0);
>   
> -		switch (device->fs_devices->chunk_alloc_policy) {
> -		default:
> -			btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_alloc_policy);
> -			fallthrough;
> -		case BTRFS_CHUNK_ALLOC_REGULAR:
> -			/* No extra check */
> -			break;
> -		case BTRFS_CHUNK_ALLOC_ZONED:
> -			if (dev_extent_hole_check_zoned(device, hole_start,
> -							hole_size, num_bytes)) {
> -				changed = true;
> -				/*
> -				 * The changed hole can contain pending extent.
> -				 * Loop again to check that.
> -				 */
> -				continue;
> -			}
> -			break;
> -		}
> +again:
> +	*hole_size = hole_end - *hole_start + 1;
> +	found = find_hole_in_pending_extents(device, hole_start, hole_size, num_bytes);
> +	if (!found)
> +		return found;
>   
> -		break;
> +	switch (device->fs_devices->chunk_alloc_policy) {
> +	default:
> +		btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_alloc_policy);
> +		fallthrough;
> +	case BTRFS_CHUNK_ALLOC_REGULAR:
> +		return found;
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		if (dev_extent_hole_check_zoned(device, hole_start,
> +						hole_size, num_bytes)) {
> +			goto again;
> +		}
>   	}
>   
> -	return changed;
> +	return found;
>   }
>   
>   /*
> @@ -1708,7 +1809,7 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> -again:
> +
>   	if (search_start >= search_end ||
>   		test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
>   		ret = -ENOSPC;
> @@ -1795,11 +1896,7 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
>   	 */
>   	if (search_end > search_start) {
>   		hole_size = search_end - search_start;
> -		if (dev_extent_hole_check(device, &search_start, &hole_size,
> -					  num_bytes)) {
> -			btrfs_release_path(path);
> -			goto again;
> -		}
> +		dev_extent_hole_check(device, &search_start, &hole_size, num_bytes);
>   
>   		if (hole_size > max_hole_size) {
>   			max_hole_start = search_start;
> @@ -5023,6 +5120,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>   	u64 diff;
>   	u64 start;
>   	u64 free_diff = 0;
> +	u64 pending_start, pending_end;
>   
>   	new_size = round_down(new_size, fs_info->sectorsize);
>   	start = new_size;
> @@ -5068,7 +5166,8 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>   	 * in-memory chunks are synced to disk so that the loop below sees them
>   	 * and relocates them accordingly.
>   	 */
> -	if (contains_pending_extent(device, &start, diff)) {
> +	if (first_pending_extent(device, start, diff,
> +				 &pending_start, &pending_end)) {
>   		mutex_unlock(&fs_info->chunk_mutex);
>   		ret = btrfs_commit_transaction(trans);
>   		if (ret)


