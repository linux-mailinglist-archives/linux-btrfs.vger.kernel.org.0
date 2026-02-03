Return-Path: <linux-btrfs+bounces-21333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD1NE3pigmnfTQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21333-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:02:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC8DEB5E
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 054D53032C4F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46D2E7F1C;
	Tue,  3 Feb 2026 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CvMPryBW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DC26ADC
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152567; cv=none; b=hLfvw56aszXm3fFu22y4kGMxkqdYPHzbAtisaEpFAx1xdr6koxh9gfrMTt3TTRcz0/qx2syZtLS9kwq/lRGv2pA5whTm0XQosKMJyJiGLRVJlypk/I1H0dnxrTbYjwdZ7SrnreiHUp0hv4JOfl+bj0DRkQd0ckpL64AjE4uI0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152567; c=relaxed/simple;
	bh=eopv9FSeOKSPlCHSzc6zQBTOf1zD+5+Nez7LTzpYGbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=siDsseQ7gS2ONbQvWwQnQOAOVy+D0DRVCVBptZXk8KB/WKaOWO7lyduJo+n48G6SzYKeNdWS5PDD+M5wUorPjXnllY+7+4U07FgBRH+PXPEE+at7tvPXTeXn+ZuF+CZGJlqZNjyz4SYWqsMaCbpl/785nelZnLSupyFIY7SAlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CvMPryBW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806bf03573so30257625e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 13:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770152564; x=1770757364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SYXqKGPyPJRfaksykxYjCHOzEeS8qZDMtcptQC3n10o=;
        b=CvMPryBWei2GCjbl19O6FlPTd45aI25ubmLTtYyRdDrtHlz53xmnt1Avd+1U1l2vwr
         ecq2l6bJBHIHUWdnoC3YxgQm/z51Ck9Xo2t8lHNzycF85EUyFMUk6VJdg6F4GN5iv3ot
         THbDK0bXzg+BmvsrVr3yVh25LqZkCOmFI1GsGt8reqEq2APKpWcthEdoGllAQ3FvQxh8
         3BDOmmmSIq3qMrERfLeQUkoXG2B16DTe79l7nJ+S9fiqpRXDJuSeS+AjafVpSHmpdo3b
         bi/66Jq56HXCAA7wepMsAretayy7VZuAs4ZQS72V6k5FqJNLCBg5GjCjOTPT2WKgoQHl
         cQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770152564; x=1770757364;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYXqKGPyPJRfaksykxYjCHOzEeS8qZDMtcptQC3n10o=;
        b=kK/ffluQRfrdvJ0YsZWuikz0aGWtJNLuCaJuy1PuCYfQ8mxB/4l/8gXZfxow8JVUOv
         E85jpPts/zVOt0jqebOd9Fr8pyxvBWRLmmRmNRiEoQYa2FGAPV0RbxyeH/778Pi5F8jS
         +gvXX0edSdeYvk8bwuRoB/dzwpxehovMIyEGygTSXKGyWmjkqFZl9JSF5UeQTNdTA3Qg
         2C85h57AeUXzR58pZiL/uuSPVwKw/snfnMY7QfzVAI5iukwKdkQz2gJ0yWlP62QaEHoD
         9sLVcXs3ZkWb8SA2BP63NECSRtBuZ1ewEJYO1eHkaiCoW6VHM6x3diBv1IUZNHoas6C/
         9Akg==
X-Forwarded-Encrypted: i=1; AJvYcCXcwF4vjcyEkOB1lEyDKpiB1wsHnbCvbq+cWxryQIDFb/mnXlNLIUKn538dMHuu8XJrmklcqD+3vJfWHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwatUcVYyqv0TE0Pwi0LvgepLel28KdAKTDxBDrEKmhf9JVabel
	NSCjNB1rTm2i9eUiM7+ddM6DKkScd5JlNJ2Klq/kLlgLFKKPf3caAIuAJ41ECpi2pZA=
X-Gm-Gg: AZuq6aJxLB5YfjYRftwmMbg9/J8CeMhQFQuPGI+qEqlNpeW0UvODFiTEIu6i9l2a8L5
	D1DtogfIZ3qsKH4f3V3n8fxWteWa3ZgEqql03wlGVy3etc1dfEhPzxaUmAAp3FOZe2yaswXXOrm
	EFD51yCTwCj6WGck8RgsgViTBOnYwbe++rD2rqgrcnJ+aunCJwswMGKm/tyirKt8FYKT1GVCAn4
	n/h20MZH8d6yzoVZ7I87RRdGi+JZg3WNu7+JPvuQ0AKFXwTJZeGyoE6egsmtdhPfe5gKZbYNoR1
	xl+0AhrJFUVpg1FYgMX0w2Nd+zohY4gsGZGySfjUdo4D5q8JKoD2totcqYVrUDbNofL14xDCtHt
	jEehOD6+NwEaHvmpNP1v1JUYyujokY8lsBSTLRfcO3zkOjBVyVFY+UeIvH9r0nYoYiggg/eqxjK
	tkLc08CiaYLOfC3k2pnCJogF/DNiMlR7QuMPkRBeI=
X-Received: by 2002:a05:600c:4fcc:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4830e9918a1mr12687925e9.28.1770152563583;
        Tue, 03 Feb 2026 13:02:43 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e945sm3182515ad.57.2026.02.03.13.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 13:02:42 -0800 (PST)
Message-ID: <a3b63027-9e17-41b3-bc7f-477d1e59381a@suse.com>
Date: Wed, 4 Feb 2026 07:32:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: be less agressive with metadata overcommit
 when we can do full flushing
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1770123544.git.fdmanana@suse.com>
 <213736b4ab22e6ecdd6a10513eaed5d85b4053bc.1770123545.git.fdmanana@suse.com>
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
In-Reply-To: <213736b4ab22e6ecdd6a10513eaed5d85b4053bc.1770123545.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21333-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: BACC8DEB5E
X-Rspamd-Action: no action



在 2026/2/3 23:32, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Over the years we often get reports of some -ENOSPC failure while updating
> metadata that leads to a transaction abort. I have seen this happen for
> filesystems of all sizes and with workloads that are very user/customer
> specific and unable to reproduce, but Aleksandar recently reported a
> simple way to reproduce this with a 1G filesystem and using the bonnie++
> benchmark tool. The following test script reproduces the failure:
> 
>      $ cat test.sh
>      #!/bin/bash
> 
>      # Create and use a 1G null block device, memory backed, otherwise
>      # the test takes a very long time.
>      modprobe null_blk nr_devices="0"
>      null_dev="/sys/kernel/config/nullb/nullb0"
>      mkdir "$null_dev"
>      size=$((1 * 1024)) # in MB
>      echo 2 > "$null_dev/submit_queues"
>      echo "$size" > "$null_dev/size"
>      echo 1 > "$null_dev/memory_backed"
>      echo 1 > "$null_dev/discard"
>      echo 1 > "$null_dev/power"
> 
>      DEV=/dev/nullb0
>      MNT=/mnt/nullb0
> 
>      mkfs.btrfs -f $DEV
>      mount $DEV $MNT
> 
>      mkdir $MNT/test/
>      bonnie++ -d $MNT/test/ -m BTRFS -u 0 -s 256M -r 128M -b
> 
>      umount $MNT
> 
>      echo 0 > "$null_dev/power"
>      rmdir "$null_dev"
> 
> When running this bonnie++ fails in the phase where it deletes test
> directories and files:
> 
>      $ ./test.sh
>      (...)
>      Using uid:0, gid:0.
>      Writing a byte at a time...done
>      Writing intelligently...done
>      Rewriting...done
>      Reading a byte at a time...done
>      Reading intelligently...done
>      start 'em...done...done...done...done...done...
>      Create files in sequential order...done.
>      Stat files in sequential order...done.
>      Delete files in sequential order...done.
>      Create files in random order...done.
>      Stat files in random order...done.
>      Delete files in random order...Can't sync directory, turning off dir-sync.
>      Can't delete file 9Bq7sr0000000338
>      Cleaning up test directory after error.
>      Bonnie: drastic I/O error (rmdir): Read-only file system
> 
> And in the syslog/dmesg we can see the following transaction abort trace:
> 
>      [161915.501506] BTRFS warning (device nullb0): Skipping commit of aborted transaction.
>      [161915.502983] ------------[ cut here ]------------
>      [161915.503832] BTRFS: Transaction aborted (error -28)
>      [161915.504748] WARNING: fs/btrfs/transaction.c:2045 at btrfs_commit_transaction+0xa21/0xd30 [btrfs], CPU#11: bonnie++/3377975
>      [161915.506786] Modules linked in: btrfs dm_zero dm_snapshot (...)
>      [161915.518759] CPU: 11 UID: 0 PID: 3377975 Comm: bonnie++ Tainted: G        W           6.19.0-rc7-btrfs-next-224+ #4 PREEMPT(full)
>      [161915.520857] Tainted: [W]=WARN
>      [161915.521405] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>      [161915.523414] RIP: 0010:btrfs_commit_transaction+0xa24/0xd30 [btrfs]
>      [161915.524630] Code: 48 8b 7c 24 (...)
>      [161915.526982] RSP: 0018:ffffd3fe8206fda8 EFLAGS: 00010292
>      [161915.527707] RAX: 0000000000000002 RBX: ffff8f4886d3c000 RCX: 0000000000000000
>      [161915.528723] RDX: 0000000002040001 RSI: 00000000ffffffe4 RDI: ffffffffc088f780
>      [161915.529691] RBP: ffff8f4f5adae7e0 R08: 0000000000000000 R09: ffffd3fe8206fb90
>      [161915.530842] R10: ffff8f4f9c1fffa8 R11: 0000000000000003 R12: 00000000ffffffe4
>      [161915.532027] R13: ffff8f4ef2cf2400 R14: ffff8f4f5adae708 R15: ffff8f4f62d18000
>      [161915.533229] FS:  00007ff93112a780(0000) GS:ffff8f4ff63ee000(0000) knlGS:0000000000000000
>      [161915.534611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      [161915.535575] CR2: 00005571b3072000 CR3: 0000000176080005 CR4: 0000000000370ef0
>      [161915.536758] Call Trace:
>      [161915.537185]  <TASK>
>      [161915.537575]  btrfs_sync_file+0x431/0x530 [btrfs]
>      [161915.538473]  do_fsync+0x39/0x80
>      [161915.539042]  __x64_sys_fsync+0xf/0x20
>      [161915.539750]  do_syscall_64+0x50/0xf20
>      [161915.540396]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>      [161915.541301] RIP: 0033:0x7ff930ca49ee
>      [161915.541904] Code: 08 0f 85 f5 (...)
>      [161915.544830] RSP: 002b:00007ffd94291f38 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
>      [161915.546152] RAX: ffffffffffffffda RBX: 00007ff93112a780 RCX: 00007ff930ca49ee
>      [161915.547263] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
>      [161915.548383] RBP: 0000000000000dab R08: 0000000000000000 R09: 0000000000000000
>      [161915.549853] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd94291fb0
>      [161915.551196] R13: 00007ffd94292350 R14: 0000000000000001 R15: 00007ffd94292340
>      [161915.552161]  </TASK>
>      [161915.552457] ---[ end trace 0000000000000000 ]---
>      [161915.553232] BTRFS info (device nullb0 state A): dumping space info:
>      [161915.553236] BTRFS info (device nullb0 state A): space_info DATA (sub-group id 0) has 12582912 free, is not full
>      [161915.553239] BTRFS info (device nullb0 state A): space_info total=12582912, used=0, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
>      [161915.553243] BTRFS info (device nullb0 state A): space_info METADATA (sub-group id 0) has -5767168 free, is full
>      [161915.553245] BTRFS info (device nullb0 state A): space_info total=53673984, used=6635520, pinned=46956544, reserved=16384, may_use=5767168, readonly=65536 zone_unusable=0
>      [161915.553251] BTRFS info (device nullb0 state A): space_info SYSTEM (sub-group id 0) has 8355840 free, is not full
>      [161915.553254] BTRFS info (device nullb0 state A): space_info total=8388608, used=16384, pinned=16384, reserved=0, may_use=0, readonly=0 zone_unusable=0
>      [161915.553257] BTRFS info (device nullb0 state A): global_block_rsv: size 5767168 reserved 5767168
>      [161915.553261] BTRFS info (device nullb0 state A): trans_block_rsv: size 0 reserved 0
>      [161915.553263] BTRFS info (device nullb0 state A): chunk_block_rsv: size 0 reserved 0
>      [161915.553265] BTRFS info (device nullb0 state A): remap_block_rsv: size 0 reserved 0
>      [161915.553268] BTRFS info (device nullb0 state A): delayed_block_rsv: size 0 reserved 0
>      [161915.553270] BTRFS info (device nullb0 state A): delayed_refs_rsv: size 0 reserved 0
>      [161915.553272] BTRFS: error (device nullb0 state A) in cleanup_transaction:2045: errno=-28 No space left
>      [161915.554463] BTRFS info (device nullb0 state EA): forced readonly
> 
> The problem is that we allow for a very agressive metadata overcommit,
> about 1/8th of the currently available space, even when the task
> attempting the reservation allows for full flushing. Over time this allows
> more and more tasks to overcommit without getting a transaction commit to
> release pinned extents, joining the same transaction and eventually lead
> to the transaction abort when attempting some tree update, as the extent
> allocator is not able to find any available metadata extent and it's not
> able to allocate a new metadata block group either (not enough unallocated
> space for that).

I'm a little curious about why we are unable to allocate a metadata bg.

Both the original report and your backtrace only shows a very small 
data/metadata/sys space info.

Data is only 12M, metadata is around 52MiB, system is 8MiB, even with 
DUP for metadata and system, they are still very tiny.
(Add up to less than 128MiB, vs 1GiB of the device size)


Thus I'm wondering if it's some other reason, like at certain locations 
we're not allowed to allocate new bgs?

Thanks,
Qu

> 
> Fix this by allowing the overcommit to be up to 1/64th of the available
> (unallocated) space instead and for that limit to apply to both types of
> full flushing, BTRFS_RESERVE_FLUSH_ALL and BTRFS_RESERVE_FLUSH_ALL_STEAL.
> This way we get more frequent transaction commits to release pinned
> extents in case our caller is in a context where full flushing is allowed.
> 
> Reported-by: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
> Link: https://lore.kernel.org/linux-btrfs/SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/space-info.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index bb5aac7ee9d2..8192edf92d26 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -489,10 +489,11 @@ static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
>   	/*
>   	 * If we aren't flushing all things, let us overcommit up to
>   	 * 1/2th of the space. If we can flush, don't let us overcommit
> -	 * too much, let it overcommit up to 1/8 of the space.
> +	 * too much, let it overcommit up to 1/64th of the space.
>   	 */
> -	if (flush == BTRFS_RESERVE_FLUSH_ALL)
> -		avail >>= 3;
> +	if (flush == BTRFS_RESERVE_FLUSH_ALL ||
> +	    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL)
> +		avail >>= 6;
>   	else
>   		avail >>= 1;
>   


