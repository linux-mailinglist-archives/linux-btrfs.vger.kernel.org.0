Return-Path: <linux-btrfs+bounces-14249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BCBAC4782
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 07:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C791E1886E75
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 05:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D791DA60F;
	Tue, 27 May 2025 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q7fj10H5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C32AF10
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748323304; cv=none; b=eX+F7deEOqwcoeKvNlJoOorDve+nsN5vCQKDVvrmKACpKVYo2IjIjynP/AfnsariVS52AZS2uZTve/plnswh8FXi15CiSMnBPyOsvlt6nT1HO8aEzRNz0JcB9bhKN/wzZEHd0I0xLxhEviYwGWgSskV4EJ6FNo4M3WyODytpps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748323304; c=relaxed/simple;
	bh=4/9c6MshFwloEwkUWgdPMKBbV1Te/FM3Va1jtHltqwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=knXyViErv6tIv/Rtun6mlhGrVG5NEp/7v5ZYuK5+VwpfUvQSe7Ox5HNPyfFy4IBCzFI6VKFlCIrqIIx9B2T4Euz/RmLsdN6orIjELbvoRqtT5U0UWQJdlxP0fo9T7xlV38sK923sCagCHS7wVBtB2KDQl0GNDNz52zI1pJ40TMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q7fj10H5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4cad7d6bdso1851936f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748323298; x=1748928098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4N8viRKsnBmL7SR4ABII9BwBxFCSlUeHpBpOkcXQQqc=;
        b=Q7fj10H5n5lnKvPzGmPOUPSU9v2325c6GKSYvmzGaLd74dncD2NPGXMVYDuBQiG/bE
         T4MKa8sD3MTzZeW3XBoO5+I0V9chXXJ2f7O4PFW1rIJoCdS4Ky3zF/fYbWMqJM/8+MWI
         uQ5qr4WBu3gITKzz8DZLBht8Lf0UAoQo1Ub70RNCLCtIIP3B4oZ9Wqmt3Xfu/1UCp93r
         RVPY8Vt9Jqc9MF+dp309tUcImE2oOPDG1FN9TSrpxWKi7/EegNk2AKh65rcoYsITJU2W
         WST0RTuZ9Nleig3XVCzcNNgpHQn9sey3hTwEaEw/l/eK99gG2ym0DiH0EoeE50b5L2qx
         57XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748323298; x=1748928098;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N8viRKsnBmL7SR4ABII9BwBxFCSlUeHpBpOkcXQQqc=;
        b=EswhaPCuTDZaqfTIFjk9bZtIig5cRA6qheeEdTyQHZ5AJYeQNCRuSrE50kK/Y7F115
         se20o4oBHIQR7LdIrCeBI9AVcw3az7MnHTM/v0oH3folVZPyWD35z96itwPBIjGfarzF
         FsXgYk5baHQyrBIrQAvdITTThkGY3qZjilTWawrDepEK8ZrqXERNKvPlK7reFiEYa2QT
         QSQEW633eFPk5mk7Dt4j69uBm2x65GXPsbWV4jLp+je2zQqBMEspv4Ta81lDxgbHBtoE
         uKhaFWKHC2b5VlQ0v1u9yjMlyUevcJPh0SQdqCRIRpmUYLjUG2V19X+YRrIj2EEwmN82
         3WsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvmPl+3JTfAyA4gEFzHtnN3jALXIFeCnAKknAC+dpngRzmaJ1aL/kB2ZbER7e2P5qdygI7a2f4SbZmew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5ZfXvpsgtclMClnJNpWqFjb5JLOf+La0r0WMTa764axbRLk3
	ciuyEOGmJYdKLJOVS7P2ihnRFeWeswZgRCToWCvMBjoqxqadwmYtkfz59NaIB9+pb9s=
X-Gm-Gg: ASbGncvZ8IS5o3mty4P+WY2bjvApfLv7DKI/nBx/V33TiXCQqpaOWxEnK2eFV0U1NsX
	eHnbJC5odtg957rZicrNpcHGDfXCv6Y5Atwi52mPTfoSe1fuaX+SN60HZXa+O9u0r1jY/nynThs
	6jUVqfVFV4cnJ7NtNBsVlsYFGJD33C3H+hbtoc/y5d1Nsf4fskHchWG/6Y9iBaufXeA4c5vFdWC
	Vcc2hOBHmB/K3PgxiDyHzyWcZptSxhBrRSxgzRVuqpSWS/9w9hXPuSznq4Ltkx2pMKF366Fs//q
	MUDsl8decBYdGBcgJcoaUIfTJI5uYIX772SWhO5Y9jcMFcp6E10ZLxFZZooJ2Q1pQLogHv4Vvzd
	WAY0=
X-Google-Smtp-Source: AGHT+IESZDOixgJ3kiHFRD8iLZ9e1lhmm7nTcGft+bltc/Agj8k8UH1uMMgxFtjEDufB6bR7nDWmlg==
X-Received: by 2002:a05:6000:4006:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3a4e1f54441mr478337f8f.17.1748323298328;
        Mon, 26 May 2025 22:21:38 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a0ca7sm17907790b3a.158.2025.05.26.22.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 22:21:37 -0700 (PDT)
Message-ID: <5e7d42e4-7d77-4926-b2fd-593ea581477d@suse.com>
Date: Tue, 27 May 2025 14:51:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] v6.15+: kernel panic when mount & umount btrfs
To: Ming Lei <ming.lei@redhat.com>, Btrfs BTRFS
 <linux-btrfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <CAFj5m9LWYk4OX8UijOutKFV-Hgga_w7KPT=MRLLyOscKBwCA-g@mail.gmail.com>
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
In-Reply-To: <CAFj5m9LWYk4OX8UijOutKFV-Hgga_w7KPT=MRLLyOscKBwCA-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/27 13:36, Ming Lei 写道:
> Hello,
> 
> Just try the latest linus tree by running `rublk` builtin test on
> Fedora, and found
> the following panic:
> 
> git clone https://github.com/ublk-org/rublk
> cd rublk
> cargo test

There is a bug in commit 5e121ae687b8 ("btrfs: use buffer xarray for 
extent buffer writeback operations"), and there is already a fix queued 
for the next pull request:

https://lore.kernel.org/linux-btrfs/b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com/

Thanks,
Qu


> 
> 
> [   24.153674] BTRFS: device fsid b99703ee-349d-40fa-b3d6-b5b451f979ab
> devid 1 transid 8 /dev/ublkb1 (259:3) scanned by moun)
> [   24.154624] BTRFS info (device ublkb1): first mount of filesystem
> b99703ee-349d-40fa-b3d6-b5b451f979ab
> [   24.155123] BTRFS info (device ublkb1): using crc32c (crc32c-x86)
> checksum algorithm
> [   24.155777] BTRFS info (device ublkb1): using free-space-tree
> [   24.157502] BTRFS info (device ublkb1): host-managed zoned block
> device /dev/ublkb1, 256 zones of 4194304 bytes
> [   24.158503] BTRFS info (device ublkb1): zoned mode enabled with
> zone size 4194304
> [   24.159541] BTRFS info (device ublkb1): checking UUID tree
> [   24.166324] EXT4-fs (ublkb5): mounted filesystem
> ae8f9776-4cb7-4edd-9acd-44291433e146 r/w with ordered data mode. Quota
> mode: none.
> [   24.169139] EXT4-fs (ublkb8): mounted filesystem
> 4beadbbc-d9c3-484d-b37b-8ea7ceb4cade r/w with ordered data mode. Quota
> mode: none.
> [   24.171259] EXT4-fs (ublkb5): unmounting filesystem
> ae8f9776-4cb7-4edd-9acd-44291433e146.
> [   24.173862] EXT4-fs (ublkb8): unmounting filesystem
> 4beadbbc-d9c3-484d-b37b-8ea7ceb4cade.
> [   24.336068] ------------[ cut here ]------------
> [   24.336449] kernel BUG at fs/btrfs/extent_io.c:2776!
> [   24.336786] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [   24.337064] CPU: 7 UID: 0 PID: 119 Comm: kworker/u64:2 Not tainted
> 6.15.0+ #279 PREEMPT(full)
> [   24.337530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-1.fc39 04/01/2014
> [   24.337985] Workqueue: writeback wb_workfn (flush-btrfs-2)
> [   24.338293] RIP: 0010:detach_extent_buffer_folio+0xca/0xd0
> [   24.338595] Code: 4d 34 74 18 84 db 74 96 4d 8d 75 7c 5b 4c 89 f7
> 5d 41 5c 41 5d 41 5e e9 54 f7 aa 00 48 89 ef e8 8c 48 d0 ff eb de 0f
> 0b0
> [   24.339599] RSP: 0018:ffffd34500477880 EFLAGS: 00010202
> [   24.339887] RAX: 0017ffffc000400a RBX: 0000000000000001 RCX: ffffd34500477838
> [   24.340280] RDX: 0000000000000001 RSI: fffff5a2442fb280 RDI: ffff8bf88590ef74
> [   24.340697] RBP: fffff5a2442fb280 R08: 0000000000000024 R09: 0000000000000000
> [   24.341143] R10: 0000000000000001 R11: ffff8bf896b39500 R12: ffff8bf88de8cd20
> [   24.341597] R13: ffff8bf88590eef8 R14: ffff8bf88590ef74 R15: ffffd34500477970
> [   24.342106] FS:  0000000000000000(0000) GS:ffff8bfd3ffb6000(0000)
> knlGS:0000000000000000
> [   24.342739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.343087] CR2: 00007f55e0cdff10 CR3: 00000002af824002 CR4: 0000000000772ef0
> [   24.343504] PKRU: 55555554
> [   24.343667] Call Trace:
> [   24.343823]  <TASK>
> [   24.343956]  release_extent_buffer+0x9b/0xd0
> [   24.344209]  btree_write_cache_pages+0x1de/0x590
> [   24.344486]  do_writepages+0xc8/0x170
> [   24.344707]  __writeback_single_inode+0x41/0x340
> [   24.344979]  writeback_sb_inodes+0x21b/0x4e0
> [   24.345234]  wb_writeback+0x98/0x330
> [   24.345449]  wb_workfn+0xc2/0x450
> [   24.345648]  ? try_to_wake_up+0x308/0x740
> [   24.346052]  process_one_work+0x188/0x340
> [   24.346445]  worker_thread+0x257/0x3a0
> [   24.346811]  ? __pfx_worker_thread+0x10/0x10
> [   24.347206]  kthread+0xfc/0x240
> [   24.347560]  ? __pfx_kthread+0x10/0x10
> [   24.347924]  ret_from_fork+0x34/0x50
> [   24.348284]  ? __pfx_kthread+0x10/0x10
> [   24.348672]  ret_from_fork_asm+0x1a/0x30
> [   24.349046]  </TASK>
> [   24.349344] Modules linked in: iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi target_core_pscsi target_core_file
> target_core_iblockg
> [   24.353785] Dumping ftrace buffer:
> [   24.354170]    (ftrace buffer empty)
> [   24.354584] ---[ end trace 0000000000000000 ]---
> [   24.355021] RIP: 0010:detach_extent_buffer_folio+0xca/0xd0
> [   24.355525] Code: 4d 34 74 18 84 db 74 96 4d 8d 75 7c 5b 4c 89 f7
> 5d 41 5c 41 5d 41 5e e9 54 f7 aa 00 48 89 ef e8 8c 48 d0 ff eb de 0f
> 0b0
> [   24.357039] RSP: 0018:ffffd34500477880 EFLAGS: 00010202
> [   24.357571] RAX: 0017ffffc000400a RBX: 0000000000000001 RCX: ffffd34500477838
> [   24.358183] RDX: 0000000000000001 RSI: fffff5a2442fb280 RDI: ffff8bf88590ef74
> [   24.358807] RBP: fffff5a2442fb280 R08: 0000000000000024 R09: 0000000000000000
> [   24.359443] R10: 0000000000000001 R11: ffff8bf896b39500 R12: ffff8bf88de8cd20
> [   24.360070] R13: ffff8bf88590eef8 R14: ffff8bf88590ef74 R15: ffffd34500477970
> [   24.360746] FS:  0000000000000000(0000) GS:ffff8bfd3ffb6000(0000)
> knlGS:0000000000000000
> [   24.361451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.362055] CR2: 00007f55e0cdff10 CR3: 00000002af824002 CR4: 0000000000772ef0
> [   24.362812] PKRU: 55555554
> [   24.363145] Kernel panic - not syncing: Fatal exception
> [   24.363845] Dumping ftrace buffer:
> [   24.364213]    (ftrace buffer empty)
> [   24.364602] Kernel Offset: 0x27000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   24.365385] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Thanks,
> 
> 


