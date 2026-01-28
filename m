Return-Path: <linux-btrfs+bounces-21194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE+IBCiEeml67QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21194-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 22:48:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCCEA9390
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 22:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73F04301983A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A5329C57;
	Wed, 28 Jan 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1QhgN55"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CB2E62D1
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636900; cv=none; b=cMGJLrfgw0odDZhuIiHRUdT9Z28fwaYj+FWOTGNEaTCam1hmJrjkbtTCBVk6upiEk6d3xUI2H/16NJOp929b196tzp0wsgCLV+SGhIUaD11Lwl+cSHMTvgMoo+jq9Ea4wbuRAJWy9pz4QFIZ77OT7mURXKgcaZzpvdr15K14j44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636900; c=relaxed/simple;
	bh=UQg0Cz/3fF06S1sU96oX1wMfTYY92d9uKXnsc4ckdJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tA2z9c99AvKuxVSZj0ZlblRWJRbSpR7hbTC4+9YHIod55p0rffdluX8WxpzkL5VBCtVpD/LsxLZ5rl8ZTkbkps2v+/xkGW/nA2s2ipOSaWFF8uQVRL5tF1foAtZRJmDNWSYOldr9rQKdbI6wPzIlgA9BMJ+wZbOvSxfWjSk1idI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1QhgN55; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee0291921so2293015e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769636897; x=1770241697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xhQGnuGL1fpIiC6Mfe15ZfhCSHEog9xQZecEA3C8AaY=;
        b=Q1QhgN55ECMH9VZ1BDXlJCrxTRqOT6KicQQqiynYVxFyMzA9ojwLzcExVvM48WImIq
         G9V6UVvPVpQk/EtHqGygrt2OA5SmImUDrUPWMTQiLTAwYTrSbEo5yggUh8C225StnT01
         lZN8D2HLPC6RKvdVmEexys2iUMX+4tO5CXYGICbZNIfQYB0sZ7FkjzVbgw16WhXLqyuW
         EY6H7gBVDevH0r56JWZAvGjmYxVqxsSqMTvCLUSkkYpNkiZq1/4OQdpdsggbEa0sOn63
         zfi7RLjAXXrZKLy9UP3vy7nz06JT/61JZ3soJXArcy67PgsWEWOk7npw8F1Mkt5tvkW2
         lbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769636897; x=1770241697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhQGnuGL1fpIiC6Mfe15ZfhCSHEog9xQZecEA3C8AaY=;
        b=GW2hYZhTZP8n8VCcrDx4xRyuKF33OzB1/0vUGvOdOVi4Hos7CMttK1nLsQVkvwKGK6
         0HOMM9QmX/XlbkY7cEjNqX9YMojHLUKkt/Z4/uwHIJu7SrGd83A2mOtkEyHsFd6rhBjW
         9PgPYpksfZfkF8MujKJlF3XKbge0o9Fd5zE6xX5LGDLuXZdILbiyhL8B4F1TLsUf4jaN
         dI0uV0t/pO7CTlWiMO1xbLQb/oRCRuSVbacohJ80BGZaR2O9Brr0PokE75J5tU/utjYi
         nWiekMIG00oSfjWu2J1iU75/2ZVPlXUMEiSdHRKHRpuxPC5QoCZMmi3s3+axJNyEgdBG
         xLkw==
X-Forwarded-Encrypted: i=1; AJvYcCUEB1WoiW0hewEnPZi707uZdiTAt/jQz55lzwjQ8yMIteJ6HSU+S8IRskR++MJyixf80bjVHDKhiA0jVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JHv8JzkbaxASCXbsvlF3dq7uXH8YL7n5YxfmyIqkD1qFKhQx
	TtkuZo1HS6oyeEHXI1e2pmoG1+R8K4t5Xk02EsALxMl9uuOFMprAw82aYrcbP8N5axK3zvk5VJw
	hjJM8
X-Gm-Gg: AZuq6aLYRqjfxO3lDeTaar/x8aVQh43KejkJn0gvkTRmXjdWo+wP7e6xaUm2xYVcUSv
	SePRNEJ2cM3r6xeiVmBDJ4a29sT8vAEognUb2gGnonSeyxlk7mW7cnaD0t3MxIfBjJflVclj426
	gmHnqBcg7VY8jDUn5YktbiHF/Jyjl7e4+esvGCZLBdETGTXB6xbhKrOR3HGfWO2dhs4rUve8Xs8
	uUGl/1JCHoRCiRxFtb8GWNgry2uORXn1jiZWJszxgaDUZNxvvxZ81RRIvmCBo1MsuGLS9ukskCt
	hal+f/rX0I4cS/wMy0XvqvZaDSpbli25MYeU3Lbd/BypepZ4X4DVjyAPYdQyxhidUcgTkBFJ07n
	tL7fouRGD2xlKL74A143lCMDePblPuAn/9sTwiJdaCOE4hrOeyxL50q1xbY1qsyX0rBDYomrYSd
	hP/TauerDOEPKTTYZxurqqz+miiSlSXWz9FD3Wrdk=
X-Received: by 2002:a05:600c:34c6:b0:47e:e71a:e13a with SMTP id 5b1f17b1804b1-48069ca2597mr74459935e9.32.1769636896583;
        Wed, 28 Jan 2026 13:48:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642487f1f5sm3188835a12.0.2026.01.28.13.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 13:48:16 -0800 (PST)
Message-ID: <8e8057fc-58a8-46f1-acd9-7db9036ec572@suse.com>
Date: Thu, 29 Jan 2026 08:18:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <ba53d279b8bb3456f61cb8a4f15d9a4b1e618d0e.1769546089.git.loemra.dev@gmail.com>
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
In-Reply-To: <ba53d279b8bb3456f61cb8a4f15d9a4b1e618d0e.1769546089.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21194-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CCCEA9390
X-Rspamd-Action: no action



在 2026/1/28 07:12, Leo Martins 写道:
> I've been investigating enospcs at Meta and have observed a strange
> pattern where filesystems are enospcing with lots of unallocated space
> (> 100G). Sample dmesg dump at bottom of message.
> 
> btrfs_insert_delayed_dir_index is attempting to migrate some reservation
> from the transaction block reserve and finding it exhausted leading to a
> warning and enospc. This is a bug as the reservations are meant to be
> worst case. It should be impossible to exhaust the transaction block
> reserve.
> 
> Some tracing of affected hosts revealed that there were single
> btrfs_search_slot calls that were COWing 100s of times. I was able to
> reproduce this behavior locally by creating a very constrained cgroup
> and producing a lot of concurrent filesystem operations. Here's the
> pattern:
> 
>   1. btrfs_search_slot() begins tree traversal with cow=1
>   2. Node at level N needs COW (old generation or WRITTEN flag set)
>   3. btrfs_cow_block() allocates new node, updates parent pointer
>   4. Traversal continues, but hits a condition requiring restart (e.g., node
>      not cached, lock contention, need higher write_lock_level)
>   5. btrfs_release_path() releases all locks and references
>   6. Memory pressure triggers writeback on the COW'd node
>   7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
>      BTRFS_HEADER_FLAG_WRITTEN
>   8. goto again - traversal restarts from root
>   9. Traversal reaches the freshly COW'd node
>   10. should_cow_block() sees WRITTEN flag set, returns true
>   11. btrfs_cow_block() allocates another new node - same logical position,
>       new physical location, new reservation consumed
>   12. Steps 4-11 repeat indefinitely under sustained memory pressure
> 
> Note this behavior should be much harder to trigger since Boris's
> AS_KERNEL_FILE changes that make it so that extent_buffer pages aren't
> accounted for in user cgroups. However, I believe it
> would still be an issue under global memory pressure.
> Link: https://lore.kernel.org/linux-btrfs/cover.1755812945.git.boris@bur.io/
> 
> This COW amplification breaks the idea that transaction reservations are
> worst case as any search slot call could find itself in this COW loop and
> exhaust its reservation.
> 
> My proposed solution is to temporarily pin extent buffers for the
> lifetime of btrfs_search_slot. This prevents the massive COW
> amplification that can be seen during high memory pressure.
> 
> The implementation uses a local xarray to track COW'd buffers for the
> duration of the search. The xarray stores extent_buffer pointers without
> taking additional references; this is safe because tracked buffers remain
> dirty (writeback_blockers prevents the dirty bit from being cleared) and
> dirty buffers cannot be reclaimed by memory pressure.
> 
> Synchronization is provided by eb->lock: increments in
> btrfs_search_slot_track_cow() occur while holding the write lock, and
> the check in lock_extent_buffer_for_io() also holds the write lock via
> btrfs_tree_lock(). Decrements don't require eb->lock because
> writeback_blockers is atomic and merely indicates "don't write yet".
> Once we decrement, we're done and don't care if writeback proceeds
> immediately.
> 
> Here is pahole output of extent_buffer showing that the new atomic_t
> member can slot into an existing 6 byte hole.
> 
> Before:
> struct extent_buffer {
>          u64                        start;                /*     0     8 */
>          u32                        len;                  /*     8     4 */
>          u32                        folio_size;           /*    12     4 */
>          unsigned long              bflags;               /*    16     8 */
>          struct btrfs_fs_info *     fs_info;              /*    24     8 */
>          void *                     addr;                 /*    32     8 */
>          spinlock_t                 refs_lock;            /*    40     0 */
>          refcount_t                 refs;                 /*    40     4 */
>          int                        read_mirror;          /*    44     4 */
>          s8                         log_index;            /*    48     1 */
>          u8                         folio_shift;          /*    49     1 */
> 
>          /* XXX 6 bytes hole, try to pack */
> 
>          struct callback_head       callback_head __attribute__((__aligned__(8))); /*    56    16 */
>          /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>          struct rw_semaphore        lock;                 /*    72    32 */
>          struct folio *             folios[16];           /*   104   128 */
> 
>          /* size: 232, cachelines: 4, members: 14 */
>          /* sum members: 226, holes: 1, sum holes: 6 */
>          /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
>          /* last cacheline: 40 bytes */
> };
> 
> After:
> struct extent_buffer {
>          u64                        start;                /*     0     8 */
>          u32                        len;                  /*     8     4 */
>          u32                        folio_size;           /*    12     4 */
>          unsigned long              bflags;               /*    16     8 */
>          struct btrfs_fs_info *     fs_info;              /*    24     8 */
>          void *                     addr;                 /*    32     8 */
>          spinlock_t                 refs_lock;            /*    40     0 */
>          refcount_t                 refs;                 /*    40     4 */
>          int                        read_mirror;          /*    44     4 */
>          s8                         log_index;            /*    48     1 */
>          u8                         folio_shift;          /*    49     1 */
> 
>          /* XXX 2 bytes hole, try to pack */
> 
>          atomic_t                   writeback_blockers;   /*    52     4 */
>          struct callback_head       callback_head __attribute__((__aligned__(8))); /*    56    16 */
>          /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>          struct rw_semaphore        lock;                 /*    72    32 */
>          struct folio *             folios[16];           /*   104   128 */
> 
>          /* size: 232, cachelines: 4, members: 15 */
>          /* sum members: 230, holes: 1, sum holes: 2 */
>          /* forced alignments: 1 */
>          /* last cacheline: 40 bytes */
> };
> 
> ------------[ cut here ]------------
> WARNING: CPU: 28 PID: 930807 at fs/btrfs/delayed-inode.c:1547 btrfs_insert_delayed_dir_index+0x346/0x3a0
> Modules linked in: ip_tables(E) ip6_tables(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) bpf_preload(E) act_gact(E) cls_bpf(E) tcp_diag(E) inet_diag(E) sch_fq(E) tls(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) iTCO_wdt(E) kvm_intel(E) mlx5_ib(E) iTCO_vendor_support(E) xhci_pci(E) mlx5_fwctl(E) i2c_i801(E) kvm(E) xhci_hcd(E) ib_uverbs(E) acpi_cpufreq(E) fwctl(E) i2c_smbus(E) wmi(E) ipmi_si(E) ipmi_devintf(E) evdev(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) raid0(E) efivarfs(E) dm_crypt(E)
> CPU: 28 UID: 34126 PID: 930807 Comm: CPUThreadPool0 Kdump: loaded Tainted: G S          E       6.13.2-0_fbk9_0_gb487e362c3df #1
> Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
> Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1, BIOS Y3DL403 06/20/2025
> RIP: 0010:btrfs_insert_delayed_dir_index+0x346/0x3a0
> Code: 08 48 89 de 48 c7 c2 e8 09 61 82 4d 89 e0 45 31 c9 e8 2e da 73 ff 48 89 df 48 8b 6c 24 08 4c 8b 74 24 10 e9 57 fe ff ff 89 c3 <0f> 0b 4c 89 e7 e8 b0 fb ff ff e9 5a fe ff ff 65 8b 05 50 d9 2b 7e
> RSP: 0000:ffffc900047b79f8 EFLAGS: 00010286
> RAX: 00000000ffffffe4 RBX: 00000000ffffffe4 RCX: 0000000000000000
> RDX: fffffffffffc0000 RSI: ffff8882aaeb7170 RDI: ffff8882aaeb7128
> RBP: ffff888348114d68 R08: 000000006f684265 R09: 5f79636e6574616c
> R10: 5f726f74696e6f6d R11: 617461646174656d R12: ffff8882d49c4180
> R13: ffff8882aaeb7000 R14: 0000000000000045 R15: 0000000000040000
> FS:  00007fb5563fd640(0000) GS:ffff889036600000(0000) knlGS:0000000000000000
> CR2: 000000000ba8bffd CR3: 0000000906d1b002 CR4: 00000000007726f0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? __warn+0xa4/0x140
>   ? btrfs_insert_delayed_dir_index+0x346/0x3a0
>   ? report_bug+0xe1/0x140
>   ? handle_bug+0x5e/0x90
>   ? exc_invalid_op+0x16/0x40
>   ? asm_exc_invalid_op+0x16/0x20
>   ? btrfs_insert_delayed_dir_index+0x346/0x3a0
>   ? btrfs_insert_delayed_dir_index+0x20c/0x3a0
>   btrfs_insert_dir_item+0x1b0/0x210
>   ? setup_items_for_insert+0x250/0x480
>   btrfs_add_link+0x94/0x3e0
>   btrfs_create_new_inode+0x60a/0xb90
>   ? start_transaction.llvm.5573957049853623343+0x2e4/0x7a0
>   btrfs_create_common+0x16c/0x1f0
>   path_openat+0x20ff/0x4140
>   do_filp_open+0xa2/0x130
>   ? _raw_spin_lock+0x10/0x20
>   __x64_sys_openat+0x114/0x1b0
>   do_syscall_64+0x68/0x130
>   ? exc_page_fault+0x69/0x130
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fb55a51b592
> Code: 8b 55 d0 eb b0 0f 1f 00 44 89 55 9c e8 b7 b6 f7 ff 41 89 c0 44 8b 55 9c 44 89 e2 4c 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 46 44 89 c7 89 45 9c e8 eb b6 f7 ff 8b 45 9c
> RSP: 002b:00007fb5563f70a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: f49998db0aa753ff RCX: 00007fb55a51b592
> RDX: 00000000000000c2 RSI: 00007fb557509cc0 RDI: 00000000ffffff9c
> RBP: 00007fb5563f7110 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
> R13: 00007fb557509cc0 R14: 000000000f595b0b R15: 00007fb55a5e0ca0
>   </TASK>
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 28 PID: 930807 at fs/btrfs/inode.c:6606 btrfs_add_link+0x3ae/0x3e0
> Modules linked in: ip_tables(E) ip6_tables(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) bpf_preload(E) act_gact(E) cls_bpf(E) tcp_diag(E) inet_diag(E) sch_fq(E) tls(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) iTCO_wdt(E) kvm_intel(E) mlx5_ib(E) iTCO_vendor_support(E) xhci_pci(E) mlx5_fwctl(E) i2c_i801(E) kvm(E) xhci_hcd(E) ib_uverbs(E) acpi_cpufreq(E) fwctl(E) i2c_smbus(E) wmi(E) ipmi_si(E) ipmi_devintf(E) evdev(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) raid0(E) efivarfs(E) dm_crypt(E)
> CPU: 28 UID: 34126 PID: 930807 Comm: CPUThreadPool0 Kdump: loaded Tainted: G S      W   E       6.13.2-0_fbk9_0_gb487e362c3df #1
> Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [E]=UNSIGNED_MODULE
> Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1, BIOS Y3DL403 06/20/2025
> RIP: 0010:btrfs_add_link+0x3ae/0x3e0
> Code: 00 e9 75 ff ff ff 48 c7 c7 9b 10 6a 82 89 de e8 28 c1 36 ff 0f 0b e9 81 fe ff ff 48 c7 c7 9b 10 6a 82 44 89 e6 e8 12 c1 36 ff <0f> 0b e9 cf fe ff ff 48 c7 c7 9b 10 6a 82 89 de e8 fd c0 36 ff 0f
> RSP: 0000:ffffc900047b7b00 EFLAGS: 00010282
> RAX: 0000000000000026 RBX: 00000000000acc00 RCX: 0000000000000000
> RDX: ffff889036630158 RSI: ffff889036621c60 RDI: ffff889036621c60
> RBP: 00000000001569d0 R08: ffffffff832692a0 R09: 000000000002fffd
> R10: 0000000000000000 R11: ffffffffffffffff R12: 00000000ffffffe4
> R13: 0000000000000000 R14: ffff8882a6707400 R15: ffffc900047b7ca8
> FS:  00007fb5563fd640(0000) GS:ffff889036600000(0000) knlGS:0000000000000000
> CR2: 000000000ba8bffd CR3: 0000000906d1b002 CR4: 00000000007726f0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? __warn+0xa4/0x140
>   ? btrfs_add_link+0x3ae/0x3e0
>   ? report_bug+0xe1/0x140
>   ? btrfs_add_link+0x3ae/0x3e0
>   ? handle_bug+0x5e/0x90
>   ? exc_invalid_op+0x16/0x40
>   ? asm_exc_invalid_op+0x16/0x20
>   ? btrfs_add_link+0x3ae/0x3e0
>   btrfs_create_new_inode+0x60a/0xb90
>   ? start_transaction.llvm.5573957049853623343+0x2e4/0x7a0
>   btrfs_create_common+0x16c/0x1f0
>   path_openat+0x20ff/0x4140
>   do_filp_open+0xa2/0x130
>   ? _raw_spin_lock+0x10/0x20
>   __x64_sys_openat+0x114/0x1b0
>   do_syscall_64+0x68/0x130
>   ? exc_page_fault+0x69/0x130
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fb55a51b592
> Code: 8b 55 d0 eb b0 0f 1f 00 44 89 55 9c e8 b7 b6 f7 ff 41 89 c0 44 8b 55 9c 44 89 e2 4c 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 46 44 89 c7 89 45 9c e8 eb b6 f7 ff 8b 45 9c
> RSP: 002b:00007fb5563f70a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: f49998db0aa753ff RCX: 00007fb55a51b592
> RDX: 00000000000000c2 RSI: 00007fb557509cc0 RDI: 00000000ffffff9c
> RBP: 00007fb5563f7110 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
> R13: 00007fb557509cc0 R14: 000000000f595b0b R15: 00007fb55a5e0ca0
>   </TASK>
> ---[ end trace 0000000000000000 ]---
> BTRFS info (device nvme0n1p2 state A): dumping space info:
> BTRFS info (device nvme0n1p2 state A): space_info DATA has 11715895296 free, is not full
> BTRFS info (device nvme0n1p2 state A): space_info total=92350185472, used=80633892864, pinned=0, reserved=241664, may_use=155648, readonly=0 zone_unusable=0 delalloc=151552 ordered=8192
> BTRFS info (device nvme0n1p2 state A): space_info METADATA has 880836608 free, is not full
> BTRFS info (device nvme0n1p2 state A): space_info total=2181038080, used=912293888, pinned=3784704, reserved=557056, may_use=383500288, readonly=65536 zone_unusable=0 delalloc=151552 ordered=8192
> BTRFS info (device nvme0n1p2 state A): space_info SYSTEM has 8372224 free, is not full
> BTRFS info (device nvme0n1p2 state A): space_info total=8388608, used=16384, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0 delalloc=151552 ordered=8192
> BTRFS info (device nvme0n1p2 state A): global_block_rsv: size 306905088 reserved 306905088
> BTRFS info (device nvme0n1p2 state A): trans_block_rsv: size 1310720 reserved 0
> BTRFS info (device nvme0n1p2 state A): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device nvme0n1p2 state A): delayed_block_rsv: size 4980736 reserved 4980736
> BTRFS info (device nvme0n1p2 state A): delayed_refs_rsv: size 47841280 reserved 46858240
> BTRFS: error (device nvme0n1p2 state A) in btrfs_add_link:6606: errno=-28 No space left
> BTRFS info (device nvme0n1p2 state EA): forced readonly
> 
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Thanks for the detailed explaination, the immature writeback of a 
recently used dirty eb is indeed a problem.

I considered some simpler solution like just marking those ebs as 
DONT_WRITEBACK, but that will mean no dirty ebs will be writtenback 
until a transaction is commited (and cleared that flag).

Or a more complex solution that makes btree_writepagse() aware of 
filemap LRU and only writes back those older untouched ebs first. Which 
can be super complex.


So the current solution looks good to me as a good compromise, at least 
it makes sure those ebs can still be written back after 
btrfs_search_slot() finished.


But this also makes me wonder, what will happen for all other 
btrfs_cow_block() callers out of btrfs_search_slot().

E.g. for relocation we do not use btrfs_search_slot() to handle reloc 
trees, but manually calls btrfs_cow_block() inside replace_path().

Should they also receive a similar treatment?

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/extent_io.c |  4 +++-
>   fs/btrfs/extent_io.h |  8 ++++++++
>   3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7267b2502665..473e78f398b4 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1972,6 +1972,40 @@ static int search_leaf(struct btrfs_trans_handle *trans,
>   	return ret;
>   }
>   
> +/*
> + * Track an extent buffer that was COW'd during btrfs_search_slot.
> + * Prevents the flusher from writing this buffer until the search completes.
> + * This avoids COW amplification where a restart would force an unnecessary
> + * re-COW of the same block.
> + */
> +static inline int btrfs_search_slot_track_cow(struct xarray *cowed_buffers,
> +					       struct extent_buffer *eb)
> +{
> +	u32 tmp;
> +	int ret = 0;
> +
> +	lockdep_assert_held_write(&eb->lock);
> +
> +	ret = xa_alloc(cowed_buffers, &tmp, eb, xa_limit_32b, GFP_NOFS);
> +	if (!ret)
> +		atomic_inc(&eb->writeback_blockers);
> +	return ret;
> +}
> +
> +/*
> + * Clear COW protection from all extent buffers tracked during this search.
> + * Called at the end of btrfs_search_slot to allow normal writeback behavior.
> + */
> +static inline void btrfs_search_slot_clear_cow_protection(struct xarray *cowed_buffers)
> +{
> +	struct extent_buffer *eb;
> +	unsigned long index;
> +
> +	xa_for_each(cowed_buffers, index, eb)
> +		atomic_dec(&eb->writeback_blockers);
> +	xa_destroy(cowed_buffers);
> +}
> +
>   /*
>    * Look for a key in a tree and perform necessary modifications to preserve
>    * tree invariants.
> @@ -2009,6 +2043,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>   {
>   	struct btrfs_fs_info *fs_info;
>   	struct extent_buffer *b;
> +	DEFINE_XARRAY_ALLOC(cowed_buffers);
>   	int slot;
>   	int ret;
>   	int level;
> @@ -2121,6 +2156,11 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>   				ret = ret2;
>   				goto done;
>   			}
> +			ret2 = btrfs_search_slot_track_cow(&cowed_buffers, b);
> +			if (ret2) {
> +				ret = ret2;
> +				goto done;
> +			}
>   		}
>   cow_done:
>   		p->nodes[level] = b;
> @@ -2242,6 +2282,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>   			ret = ret2;
>   	}
>   
> +	btrfs_search_slot_clear_cow_protection(&cowed_buffers);
> +
>   	return ret;
>   }
>   ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dfc17c292217..5dd7fcaec5a5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1940,7 +1940,8 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
>   	 * of time.
>   	 */
>   	spin_lock(&eb->refs_lock);
> -	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> +	if (!atomic_read(&eb->writeback_blockers) &&
> +	    test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
>   		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
>   		unsigned long flags;
>   
> @@ -3009,6 +3010,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>   	eb->len = fs_info->nodesize;
>   	eb->fs_info = fs_info;
>   	init_rwsem(&eb->lock);
> +	atomic_set(&eb->writeback_blockers, 0);
>   
>   	btrfs_leak_debug_add_eb(eb);
>   
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 73571d5d3d5a..da77c4eb9a43 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -102,6 +102,14 @@ struct extent_buffer {
>   	/* >= 0 if eb belongs to a log tree, -1 otherwise */
>   	s8 log_index;
>   	u8 folio_shift;
> +
> +	/*
> +	 * Active btrfs_search_slot() operations blocking writeback.
> +	 * Prevents COW amplification when searches restart under memory
> +	 * pressure. Checked under eb->lock in lock_extent_buffer_for_io().
> +	 */
> +	atomic_t writeback_blockers;
> +
>   	struct rcu_head rcu_head;
>   
>   	struct rw_semaphore lock;


