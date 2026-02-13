Return-Path: <linux-btrfs+bounces-21659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAp2DqKnjmkyDgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21659-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 05:25:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E840132E23
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 05:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE3CA3053BAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 04:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5851823EA86;
	Fri, 13 Feb 2026 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JC4pq2wo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D776450F2
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770956697; cv=none; b=e5dmxlWDKHPpMUpH0cmhD8eDXnfOwUoRb5KATXvuBPU4r2JbKsx+cqLBGQKN4RAbj9udouW3NGJnaNnFRqMs5g935g1XncqBj9OxNwKZ3Vlw2Qh4zhzPsjauqViH5rWpyQTQU2c4X6dSNDn4KdEH18N/gA+ZpuGV2MutAO65rQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770956697; c=relaxed/simple;
	bh=1jFmDSzDqJ0DrUyoleD81f5yJuaRF4j6eEwd1FKd4ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jty3zEgVE0YvyEgpUocqIVtZy9BG2iBdI/wg8M3cuh8om6+EH9EVk/qtbvsz2EUlP26NIiexq5rfr6j8jxJDbAZvHgyD7Wmxi54/C1AGZjEnvx+YxvuNibIqNxrIKMOsup2/mJz7Mh2plaRj/BlujaCtBOwbbRtEaDNnupD7BYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JC4pq2wo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so3761705e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 20:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770956694; x=1771561494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fcfM9D0anavF+QlaAjFX3HhihpWHjbNx8O3GDAo8CV4=;
        b=JC4pq2woaz0hhiwnfrHAAU3N0XbnljXGQDgjeyOQMHji7k9qJCc6ob++aTJ7+B/mtz
         obPIsfIx2DLUITAMjsdAZL9UYVAaylgHZRVCSZlLmVMihDDorINuHRnUN6xy9bycgr/D
         61fCGRoYCVWRMCg2I4PFzbu1W7uzpkHEOrnadUWwVySLQbQswcNZPqReYzUSe0SPd1uu
         hKqgzGy1+Hlnkym9pj0b50nxzJRXX0eui3kMlZUB7Jr9hbom81hg8BSupNxkXzIYDaVq
         1cQOmGeNu4CKvcznf8XTYPpfHomyvoWB5p80aa8Zvol3YcfiNKRekFtRtekTcW2pjRgJ
         cOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770956694; x=1771561494;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcfM9D0anavF+QlaAjFX3HhihpWHjbNx8O3GDAo8CV4=;
        b=Ww5+WIPh/+z7hgihhoXrUK6GWnVR5JLoaSWt97nqYqC1M3gTEE8DLjlnOy73cWe3NQ
         xuyTv1KLfqfXXKMhy09ZQftaoJIDTYwyL2xwPiX4Z3Es6UAYlNpx21X5pM4kVPHM96K9
         +UFXDCSbKagKGbPuJedxwxIcB0I6aHasU3j2cIIxc4u0NvMddUCjROKZoZOC6UEQhwe6
         Bp+Ymxv+XL4aw1+n4olX8SpTzRYWpOiGGn6fV7cNfIsVSlrEnZqGyNU6PCeT3XFwC4+F
         rPTLQq77ICoyL1o4RuwffijtVWYuNqv9ZK9S38smb2b2ZWOfLEC4WxinEGJkB8Evfrhu
         tfdg==
X-Forwarded-Encrypted: i=1; AJvYcCUUSr0KWT8qljZ2uqndIkRWZfma4tIw9Hl7gNqtQe3DQ4Dp3CG1bGcmUTF7bsz5jIbPMwhHORLl9SOt1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtHE9GPXIPltYCVILW5hd+orwBie93zmJMOYN2PG10lDx2aij
	l4R+hnrBp7lJFQo2U9Mjb7yOrjO/ULHSB380gTYhRCyshnVKPEzKH8wjdrKabyMezbZUfsC9kah
	A/4uZztY=
X-Gm-Gg: AZuq6aLR3kI7hoQxvVuA7hlg6C13YEMwPYg03d9GK+FbjXtAmOSxIsiBecO2+MOT9sr
	dDcom71sNpSwJxGcLP4KPdzXWDngHOvHpxw9YKtM3VkBcCjO+clx3V37PewBzntxEcvbL4OZExI
	2v9RgY+8itpFRWsRBH1N/DwFxZkW4S6jyO7cmIGqM67IEFJOxPqmPrhSIfFMNpZw8/8XanXH9Nu
	HDsrfgWUKF0Epok224StkK7chM6JCBbUtfXbkhR79xcHaqVY1YZz+wx/y6Y2LlIgfvjZ55jBx8m
	3w3baWUkgapzgYX18oP0PFCb7nfFFCRQa2rPwnXYywydVvrtBr3neCyvYoIzn97Zdjtbp/k81g/
	MC90sDyGUyulRO8ep0m56Ppm3+pQZ6oYOTVfBzvgYYoVgtqQ9YD6Di1Us/Sjy7S4yfSqU6E+EkX
	O8NilsiAxg+Or143uzFu+/U4B27HVfxY3MQUu4a9WCmLmgF+BJ3aQ=
X-Received: by 2002:a05:600c:3e14:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-483710904ecmr18440065e9.29.1770956694367;
        Thu, 12 Feb 2026 20:24:54 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb3549sm907150b3a.59.2026.02.12.20.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 20:24:53 -0800 (PST)
Message-ID: <be41f741-8c26-4fdf-8cb3-987b7e2abc11@suse.com>
Date: Fri, 13 Feb 2026 14:54:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] btrfs: update per-profile available estimation
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-btrfs@vger.kernel.org
References: <202602130252.89b82f3f-lkp@intel.com>
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
In-Reply-To: <202602130252.89b82f3f-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21659-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email]
X-Rspamd-Queue-Id: 8E840132E23
X-Rspamd-Action: no action



在 2026/2/13 11:45, kernel test robot 写道:
> 
> Hello,
> 
> kernel test robot noticed "INFO:trying_to_register_non-static_key" on:
> 
> commit: 50b35a50fe83cb7870710b173f8b5ee78dd20107 ("[PATCH v2 2/3] btrfs: update per-profile available estimation")
> url: https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-introduce-the-device-layout-aware-per-profile-available-space/20260204-105811
> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> patch link: https://lore.kernel.org/all/b4d6fcecccd3c2c3b5359131e0493f190d1f5959.1770173615.git.wqu@suse.com/
> patch subject: [PATCH v2 2/3] btrfs: update per-profile available estimation
> 
> in testcase: perf-sanity-tests
> version:
> with following parameters:
> 
> 	perf_compiler: gcc
> 	group: group-02
> 
> 
> 
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 22 threads 1 sockets Intel(R) Core(TM) Ultra 9 185H @ 4.5GHz (Meteor Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

Thanks for the report, it's already fixed in btrfs/for-next branch.

Thanks,
Qu


> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202602130252.89b82f3f-lkp@intel.com
> 
> 
> kern  :err   : [   91.987109] [   T4552] INFO: trying to register non-static key.
> kern  :err   : [   91.988642] [   T4552] The code is fine but needs lockdep annotation, or maybe
> kern  :err   : [   91.990349] [   T4552] you didn't initialize this object before use?
> kern  :err   : [   91.991930] [   T4552] turning off the locking correctness validator.
> kern  :warn  : [   91.993525] [   T4552] CPU: 1 UID: 0 PID: 4552 Comm: mount Tainted: G S      W           6.19.0-rc8-00146-g50b35a50fe83 #1 PREEMPT(full)
> kern  :warn  : [   91.993530] [   T4552] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> kern  :warn  : [   91.993531] [   T4552] Hardware name: ASUSTeK COMPUTER INC. NUC14RVS-B/NUC14RVSU9, BIOS RVMTL357.0047.2025.0108.1408 01/08/2025
> kern  :warn  : [   91.993532] [   T4552] Call Trace:
> kern  :warn  : [   91.993533] [   T4552]  <TASK>
> kern  :warn  : [   91.993535] [   T4552]  dump_stack_lvl (lib/dump_stack.c:122)
> kern  :warn  : [   91.993541] [   T4552]  register_lock_class (kernel/locking/lockdep.c:985 kernel/locking/lockdep.c:1299)
> kern  :warn  : [   91.993545] [   T4552]  __lock_acquire (kernel/locking/lockdep.c:5113)
> kern  :warn  : [   91.993549] [   T4552]  lock_acquire (include/linux/preempt.h:469 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
> kern  :warn  : [   91.993551] [   T4552]  ? btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5537) btrfs
> kern  :warn  : [   91.993701] [   T4552]  ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
> kern  :warn  : [   91.993704] [   T4552]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
> kern  :warn  : [   91.993706] [   T4552]  _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> kern  :warn  : [   91.993710] [   T4552]  ? btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5537) btrfs
> kern  :warn  : [   91.993849] [   T4552] btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5537) btrfs
> kern  :warn  : [   91.993988] [   T4552]  ? __pfx_btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5518) btrfs
> kern  :warn  : [   91.994127] [   T4552]  ? btrfs_verify_dev_extents (fs/btrfs/volumes.c:8602) btrfs
> kern  :warn  : [   91.994268] [   T4552]  ? __lock_release+0x5d/0x1b0
> kern  :warn  : [   91.994270] [   T4552]  ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
> kern  :warn  : [   91.994274] [   T4552] btrfs_verify_dev_extents (fs/btrfs/volumes.c:8604) btrfs
> kern  :warn  : [   91.994415] [   T4552]  ? __pfx_btrfs_verify_dev_extents (fs/btrfs/volumes.c:8512) btrfs
> kern  :warn  : [   91.994562] [   T4552]  ? btrfs_verify_dev_items (fs/btrfs/volumes.c:8641) btrfs
> kern  :warn  : [   91.994704] [   T4552] open_ctree (fs/btrfs/disk-io.c:3533) btrfs
> kern  :warn  : [   91.994842] [   T4552] btrfs_fill_super.cold (fs/btrfs/super.c:981) btrfs
> kern  :warn  : [   91.994976] [   T4552] btrfs_get_tree_super (fs/btrfs/super.c:1945) btrfs
> kern  :warn  : [   91.995108] [   T4552] btrfs_get_tree_subvol (fs/btrfs/super.c:2087) btrfs
> kern  :warn  : [   91.995241] [   T4552]  vfs_get_tree (fs/super.c:1751)
> kern  :warn  : [   91.995245] [   T4552]  vfs_cmd_create (fs/fsopen.c:231)
> kern  :warn  : [   91.995249] [   T4552]  __do_sys_fsconfig (fs/fsopen.c:474)
> kern  :warn  : [   91.995251] [   T4552]  ? __pfx___do_sys_fsconfig (fs/fsopen.c:356)
> kern  :warn  : [   91.995255] [   T4552]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
> kern  :warn  : [   91.995257] [   T4552]  ? do_syscall_64 (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/entry-common.h:108 arch/x86/entry/syscall_64.c:90)
> kern  :warn  : [   91.995261] [   T4552]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> kern  :warn  : [   91.995263] [   T4552]  ? __pfx_ksys_read (fs/read_write.c:705)
> kern  :warn  : [   91.995265] [   T4552]  ? kfree (mm/slub.c:6674 (discriminator 3) mm/slub.c:6882 (discriminator 3))
> kern  :warn  : [   91.995268] [   T4552]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
> kern  :warn  : [   91.995270] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> kern  :warn  : [   91.995272] [   T4552]  ? __do_sys_fsconfig (fs/fsopen.c:499)
> kern  :warn  : [   91.995274] [   T4552]  ? __do_sys_fsconfig (fs/fsopen.c:499)
> kern  :warn  : [   91.995277] [   T4552]  ? __pfx___do_sys_fsconfig (fs/fsopen.c:356)
> kern  :warn  : [   91.995279] [   T4552]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
> kern  :warn  : [   91.995282] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> kern  :warn  : [   91.995284] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> kern  :warn  : [   91.995286] [   T4552]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
> kern  :warn  : [   91.995288] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> kern  :warn  : [   91.995290] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> kern  :warn  : [   91.995292] [   T4552]  ? irqentry_exit (include/linux/irq-entry-common.h:298 include/linux/irq-entry-common.h:341 kernel/entry/common.c:196)
> kern  :warn  : [   91.995294] [   T4552]  ? trace_hardirqs_on_prepare (kernel/trace/trace_preemptirq.c:64 (discriminator 4) kernel/trace/trace_preemptirq.c:59 (discriminator 4))
> kern  :warn  : [   91.995296] [   T4552]  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4629 (discriminator 4))
> kern  :warn  : [   91.995299] [   T4552]  ? irqentry_exit (arch/x86/include/asm/jump_label.h:37 include/linux/context_tracking_state.h:138 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:301 include/linux/irq-entry-common.h:341 kernel/entry/common.c:196)
> kern  :warn  : [   91.995301] [   T4552]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
> kern  :warn  : [   91.995304] [   T4552] RIP: 0033:0x7fb38ba0e4aa
> kern  :warn  : [   91.995331] [   T4552] Code: 73 01 c3 48 8b 0d 4e 59 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1e 59 0d 00 f7 d8 64 89 01 48
> All code
> ========
>     0:	73 01                	jae    0x3
>     2:	c3                   	ret
>     3:	48 8b 0d 4e 59 0d 00 	mov    0xd594e(%rip),%rcx        # 0xd5958
>     a:	f7 d8                	neg    %eax
>     c:	64 89 01             	mov    %eax,%fs:(%rcx)
>     f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>    13:	c3                   	ret
>    14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    1b:	00 00 00
>    1e:	66 90                	xchg   %ax,%ax
>    20:	49 89 ca             	mov    %rcx,%r10
>    23:	b8 af 01 00 00       	mov    $0x1af,%eax
>    28:	0f 05                	syscall
>    2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>    30:	73 01                	jae    0x33
>    32:	c3                   	ret
>    33:	48 8b 0d 1e 59 0d 00 	mov    0xd591e(%rip),%rcx        # 0xd5958
>    3a:	f7 d8                	neg    %eax
>    3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>    3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>     6:	73 01                	jae    0x9
>     8:	c3                   	ret
>     9:	48 8b 0d 1e 59 0d 00 	mov    0xd591e(%rip),%rcx        # 0xd592e
>    10:	f7 d8                	neg    %eax
>    12:	64 89 01             	mov    %eax,%fs:(%rcx)
>    15:	48                   	rex.W
> kern  :warn  : [   91.995334] [   T4552] RSP: 002b:00007ffd1dd07898 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
> kern  :warn  : [   91.995337] [   T4552] RAX: ffffffffffffffda RBX: 000055a8acde41d0 RCX: 00007fb38ba0e4aa
> kern  :warn  : [   91.995339] [   T4552] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
> kern  :warn  : [   91.995340] [   T4552] RBP: 000055a8acde5d20 R08: 0000000000000000 R09: 0000000000000000
> kern  :warn  : [   91.995342] [   T4552] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> kern  :warn  : [   91.995343] [   T4552] R13: 00007fb38bba0580 R14: 00007fb38bba226c R15: 00007fb38bb87a23
> kern  :warn  : [   91.995347] [   T4552]  </TASK>
> kern  :info  : [   92.094700] [   T4552] BTRFS info (device nvme0n1p5): enabling ssd optimizations
> kern  :info  : [   92.096302] [   T4552] BTRFS info (device nvme0n1p5): turning on async discard
> kern  :info  : [   92.097968] [   T4552] BTRFS info (device nvme0n1p5): enabling free space tree
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260213/202602130252.89b82f3f-lkp@intel.com
> 
> 
> 


