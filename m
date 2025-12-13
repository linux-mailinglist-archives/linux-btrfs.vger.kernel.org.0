Return-Path: <linux-btrfs+bounces-19713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD91CBB3DC
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 21:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A795300B903
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5522B5A5;
	Sat, 13 Dec 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="INZyHCbl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008319067C
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765658933; cv=none; b=uuKtGLpIRtqFWRcUQ9znSBkn9lL/ByRAg9j7iY4s/1coSORRY5/i0G3RGFpcrQiSuzrGmkMnJH91rELowstJtoariS7oxE9PrusMBQI5ETUhskE/Q1FHSTs8sejDqMmDuTKl1YvK1rZcZQYLlShj7nIh7cd2el5yqCD+iYoidzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765658933; c=relaxed/simple;
	bh=LZVuzRZNkzki5hYTf0o6QTYTVtOJzV9aZ8L1xayFff4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsWY0sOlaHM+fPORuyzuYfXBWqMiXS4Pf+zSMBjp7/pLyVRDJxOSjgzwnb1+maWGGn5BYLGnJl9edG98Q3a06Q0fCkGVpaMFdSAqIH/6vL4TAr2RlGTrpwNpcnq3hN+1d2LDBXwTkCzmOf5DwRNtBB+tQodollZxk4mlYDo73u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=INZyHCbl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so17174295e9.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 12:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765658927; x=1766263727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ByVzl9SpGJyOHc/P3C3qLj4MNXGQ/EFFY14AbXqP9kA=;
        b=INZyHCblGln6KtR0Fc/djuAGHE+dFt5GZCFALMRH4VoqemNcWDeo8fruKXmKAvIRJG
         W0viBSoG+6K3kjYBbuvCZQkyuOyqpOJ9Y2yfKH3uTzT9YnhULhIEYT8GQAscE/4uFrJH
         wPDX5YMnG8EgF+NiZP2CE9VG+genIUPmioPdYfJxW23N1B3DnNknwFbWB+6LtJDEkgJU
         J8qg8Lg0A1PC1i1Kwp1c/e9RY4pJdkVcBRzSDc5uwjN0685xsG/RzcjGdaBScaOLrPsg
         BBJZalKTipn5cJMa7W/X3nUUrWHLQoVUQHrP+7pwXdhh031pWgHbm6IUBGmDrWoMnNBp
         4Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765658927; x=1766263727;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByVzl9SpGJyOHc/P3C3qLj4MNXGQ/EFFY14AbXqP9kA=;
        b=aOjG5RI9LlDXdNPNNzM+kPSn2Ky4bSy1RngPnkqqVWYGjoQHc8HxgFfAvS6O5XAadC
         CRjkY8hqbxx3MhvAn7+hE6EoUQLXVzyA+4TIFUFDHpntSp2VD8Nn+fvZkn5/WkMdE6Z6
         LY/BhDd+pDq/pfCGWX8NoeQm9vWmkeoCd136kAPZguX8ppxqCfqrU65Ia21PlMDC1SBX
         SiqWCtloRehtJF2GHjb3uHZDiQJ8TWPADFloYtSDXBEiPyHBZbaRGz2AtAYoOhnx9Joe
         AwnRX67dwt4z+lvLkXiSp4/BRfSISFtBIdU3PeCOfv7Q15/LzrBQozRYjMa/O4VhqBLc
         +58g==
X-Forwarded-Encrypted: i=1; AJvYcCXl83icrB5Y1N66zl6nh5drng6j2xGv573VgTZFOSq1cjaSSmHM6gRMUBZk83HbPVu3RIhBH8RZ8Dk/zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvzmpYpc2C6AXDa/XHmLTL7c2sfldMvlrP6zuzY/zgylUBiMo
	pheZQVKgnoRxt2EdQq0UkmjpDoowotUzEkcKxtlBTU5uOf6g8yaaMpMbzWYcOIHk4bM=
X-Gm-Gg: AY/fxX4KQs5kSP2zmCg9b5S2YPOFR25OG50OJ1zi6HXc3TCo4jeFzRsFHCwPaQiD1gX
	ygQKyj7bQTphuFh1DIBPQNF7XVElqCqnUn/rp4HY4J8brncaI6NU5guMRxu/+AzvmGbA9VAxgU7
	I4SB1JfZiyuEzf/6R0wkwxUlXbiofTE0bjUxt20jWv49iPH+UmhKLqokpXVPwT+Y50BNpZJS4xs
	P+dzxGNckyRA6jdJkfrorObsuZSmyBVoD7Ws6pTpsfGGiNSpWVMRnXmH9Ryf3y8Gt5xhCe0kupl
	wnJXDDnurrfbgd9oBwwteS1mRZ13aKStOEMXWC7YcvqfGWs78go5A7wpJC8h+sRXbIKzdd6woay
	oYJiAS7wcty9Arw9Ns7kXbLcc/a4KGTb2KF/S4jCjKWfZLhHEI/ylGgW8g/iv4vSdqo2+9o1Zt3
	GnpQp5ENPbux/sQgIGtnPIc8LPr7jPDWUcol90wnPgu5wIbjNXpQ==
X-Google-Smtp-Source: AGHT+IE1zaSAAUFQ6qj7VQVaN8Wc4Qa0LKmMENwxapbB6w2KzWmB0yl6XoJV3a/7mVY7I84mh0ueIw==
X-Received: by 2002:a05:600c:64cf:b0:477:9c73:2680 with SMTP id 5b1f17b1804b1-47a8f907bf9mr48266585e9.23.1765658927267;
        Sat, 13 Dec 2025 12:48:47 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c277693bsm8548466b3a.21.2025.12.13.12.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 12:48:46 -0800 (PST)
Message-ID: <350e9b44-7a16-4c3f-a54f-5b6b3f4931f3@suse.com>
Date: Sun, 14 Dec 2025 07:18:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: harden __reserve_bytes() with space_info==NULL
To: Kai Krakow <kai@kaishome.de>, linux-btrfs@vger.kernel.org
Cc: Eli Venter <eli@genedx.com>
References: <20251213200920.1808679-1-kai@kaishome.de>
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
In-Reply-To: <20251213200920.1808679-1-kai@kaishome.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/14 06:39, Kai Krakow 写道:
> During mount, the global block reserve might not have its space_info
> initialized yet. If we try to reserve bytes in this state (e.g. via
> early sysfs writes), we must not crash.
> 
> This happened while developing patches which allow modification of the
> devinfo.type field via sysfs. If this write access is executed by the
> user before the mount finished, the kernel crashed with a NULL pointer
> dereference:


I'd say the modification through sysfs itself is a dangerous idea, it 
will need to hold the proper locks and if not properly checked can 
easily introduce unexpected races.


Furthermore currently there is no RW support for devinfo related member.

So this means your patch is fixing something that is only affecting your 
out-of-tree development branch, which is not bringing much usefulness to 
upstream.

Thanks,
Qu

> 
>> Noticed an oops with these patches when doing echo 1 >devinfo/2/type
>> while mount is still ongoing. My btrfs is big so the mount takes
>> 20-30 minutes. Reboot and wait until mount is complete and this
>> worked fine.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> PGD 0 P4D 0
> Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> CPU: 4 UID: 0 PID: 3520 Comm: bash Not tainted 6.12.52-dirty #2
> Hardware name: Penguin Computing Relion 1900/MD90-FS0-ZB-XX, BIOS R15 06/25/2018
> RIP: 0010:_raw_spin_lock+0x17/0x30
> Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
> RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
> R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
> R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
> FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0
> Call Trace:
> 
> __reserve_bytes+0x70/0x720 [btrfs]
> ? get_page_from_freelist+0x343/0x1570
> btrfs_reserve_metadata_bytes+0x1d/0xd0 [btrfs]
> btrfs_use_block_rsv+0x153/0x220 [btrfs]
> btrfs_alloc_tree_block+0x83/0x580 [btrfs]
> btrfs_force_cow_block+0x129/0x620 [btrfs]
> btrfs_cow_block+0xcd/0x230 [btrfs]
> btrfs_search_slot+0x566/0xd60 [btrfs]
> ? kmem_cache_alloc_noprof+0x106/0x2f0
> btrfs_update_device+0x91/0x1d0 [btrfs]
> btrfs_devinfo_type_store+0xb8/0x140 [btrfs]
> kernfs_fop_write_iter+0x14c/0x200
> vfs_write+0x289/0x440
> ksys_write+0x6d/0xf0
> trace_clock_x86_tsc+0x20/0x20
> ? do_wp_page+0x838/0xf90
> ? __do_sys_newfstat+0x68/0x70
> ? __pte_offset_map+0x1b/0xf0
> ? __handle_mm_fault+0xa6c/0x10f0
> ? __count_memcg_events+0x53/0xf0
> ? handle_mm_fault+0x1c4/0x2d0
> ? do_user_addr_fault+0x334/0x620
> ? arch_exit_to_user_mode_prepare.isra.0+0x11/0x90
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fd6e27a1687
> Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> RSP: 002b:00007ffecb401260 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fd6e270f740 RCX: 00007fd6e27a1687
> RDX: 0000000000000002 RSI: 0000557a2c38ad20 RDI: 0000000000000001
> RBP: 0000557a2c38ad20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> R13: 00007fd6e28fa5c0 R14: 00007fd6e28f7e80 R15: 0000000000000000
> 
> Modules linked in: rpcsec_gss_krb5 nfsv3 nfsv4 dns_resolver nfs netfs zram lz4hc_compress lz4_compress dm_crypt bonding tls ipmi_ssif intel_rapl_msr nfsd binfmt_misc auth_rpcgss nfs_acl lockd grace intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp rapl intel_cstate s>
> intel_pmc_bxt ixgbe ehci_pci iTCO_vendor_support xfrm_algo gf128mul libata mpt3sas xhci_hcd ehci_hcd watchdog crypto_simd mdio_devres libphy cryptd raid_class usbcore scsi_transport_sas mdio igb scsi_mod wmi usb_common i2c_i801 lpc_ich scsi_common i2c_smbus i2c_algo_bit dca
> CR2: 0000000000000008
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:_raw_spin_lock+0x17/0x30
> Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
> RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
> R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
> R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
> FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0
> 
> Reported-by: Eli Venter <eli@genedx.com>
> Signed-off-by: Kai Krakow <kai@kaishome.de>
> ---
>   fs/btrfs/space-info.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 97452fb5d29b..cbb6c4924850 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1752,6 +1752,14 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>   		ASSERT(flush != BTRFS_RESERVE_FLUSH_EVICT);
>   	}
>   
> +	/*
> +	 * During mount, the global block reserve might not have its space_info
> +	 * initialized yet. If we try to reserve bytes in this state (e.g. via
> +	 * early sysfs writes), we must not crash.
> +	 */
> +	if (unlikely(!space_info))
> +		return -EBUSY;
> +
>   	if (flush == BTRFS_RESERVE_FLUSH_DATA)
>   		async_work = &fs_info->async_data_reclaim_work;
>   	else


