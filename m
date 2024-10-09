Return-Path: <linux-btrfs+bounces-8752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F09977AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E741C22257
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC01E282B;
	Wed,  9 Oct 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RP41QCZJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71B18990C
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510023; cv=none; b=aTo+zzrt3bc2DfCHVDh96kJMymEuuDjUUVlJE8YlgPhC7/NZaICG8HDvzJqAIuCcvoTYuwxrR2fryi2/nj0EM7PEwu1xKdI/+t2HH/OIF1CpAklggRZGz3YwpTQu2Xnu5Jyb28KQ8NXNPS436xSr9GuUky6nnn8RB9S5vOuyVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510023; c=relaxed/simple;
	bh=gTiaGagdVMMw1aLRa9EcHd+RnHkar77/bc056Uix1xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7jbcEx5sQO4aJX/Sofp4kD6PoGjaS77jXlk8yZ8rtH6rD7EglorMbo7wyh93rkbXGFA/4DS6lxViO02bxl0ZZW2AGRbDk3ciJtXXqE4CqDEfeib5/97EGMg50r+Sz/kTTYwRamy0ga7PfIKYSRR1p54Z3oIW9tC4s4cCuffVqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RP41QCZJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so2106021fa.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728510019; x=1729114819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UFRnl4NVD43R8I+3N6CLVBZvxIDnEm6edOBHVZzJu9A=;
        b=RP41QCZJirHbBIMKKgTCElOB9bnbd3jQmw+jTRfi0zn0zL19mX8ZHBTRqQKjdU9wro
         zRlc9+kc0pQ9SFXIbPkGserFoIYJtx7pM+vI3GIUwXD9HYZibQ8Kgwv71svrlH3ksMpB
         B5NXDk0GqlYo6uR8DgvkumtdD/ul319yxq/PXGRg8fyhzhd4G2XeKFf+3vgeyfZVH3gO
         hFN1PREbAaNvJYx4B2Mg2CdUY60buKWIRjimGbOszufkrgg92+askmoCZ0KlcOD0gScf
         47y95ZG3EWmcFWg9qHvB7/DocSTf6Ae3Q5Y/jdpazggI0oxTcnPxUQYs55Mu9x9zCedA
         DbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510019; x=1729114819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFRnl4NVD43R8I+3N6CLVBZvxIDnEm6edOBHVZzJu9A=;
        b=T9mwhIMHXDGXqJQneoQC5GC9xg09GFOPdVGnsQSAuD99QzqESxDU+xxiVCKpmk/mt1
         Y/SF1wSRRLzW7OP9bGDKwQEu4+UCtorHVVzOcXd6tKQy1F+77vVpbhULW/6jGEy8NebT
         fSFfN0qdTi0CANOJDM0INybuJqQiCYrPxwGarYOFDONEMaZu51UnBeSHF47DYczbCdcS
         ScLlrq6ZtZnYE1znjw7U7yCjINkKXuV5J9mkItH9VSb9zzoVOyJkITqJBManHqZoB8Sb
         LnScgwGdSyo9kAq292C6IqFmC+t3bGLQEwgUmHc3CY7QxdTcLiBHIYIWpfhluwafcfJ5
         v8NA==
X-Forwarded-Encrypted: i=1; AJvYcCWL+1La+QWfF2oO4NY+te/vv/UlKLzvEyjn8cVV6jf4pvaw+Im103WpPr6vEXYHwlZcuERHiSAFaFf2+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1R5ZQvDzii0ee8TZ2OaRmox4nrEAUNELPf+gIena46yBUjUa
	pzTIMUTpPuY3/TXy7Ts01YXAiaRKK34ViKG4HHc76BRcjDnm99BH4tPkitcCmvk=
X-Google-Smtp-Source: AGHT+IGDTLPUwGwZQCXvKozMbmq72n0sZH610PH8kXnnN53VaAE9NFmldZYD/NdqSvsVYv9sakf+/w==
X-Received: by 2002:a2e:709:0:b0:2fa:fc41:cf85 with SMTP id 38308e7fff4ca-2fb187ce196mr21746151fa.36.1728510018048;
        Wed, 09 Oct 2024 14:40:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd2a1bsm8197391b3a.85.2024.10.09.14.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 14:40:17 -0700 (PDT)
Message-ID: <e1585a7d-5ce1-4d9b-81ef-79167ca63249@suse.com>
Date: Thu, 10 Oct 2024 08:10:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: hch@lst.de
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
 <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/10 08:08, Qu Wenruo 写道:
> 
> 
> 在 2024/10/10 02:27, Naohiro Aota 写道:
>> The purpose of btrfs_bbio_propagate_error() shall be propagating an error
>> of split bio to its original btrfs_bio, and tell the error to the upper
>> layer. However, it's not working well on some cases.
>>
>> * Case 1. Immediate (or quick) end_bio with an error
>>
>> When btrfs sends btrfs_bio to mirrored devices, btrfs calls
>> btrfs_bio_end_io() when all the mirroring bios are completed. If that
>> btrfs_bio was split, it is from btrfs_clone_bioset and its end_io 
>> function
>> is btrfs_orig_write_end_io. For this case, btrfs_bbio_propagate_error()
>> accesses the orig_bbio's bio context to increase the error count.
>>
>> That works well in most cases. However, if the end_io is called enough
>> fast, orig_bbio's bio context may not be properly set at that time. Since
>> the bio context is set when the orig_bbio (the last btrfs_bio) is sent to
>> devices, that might be too late for earlier split btrfs_bio's completion.
>> That will result in NULL pointer dereference.
> 
> Mind to share more info on how the NULL pointer dereference happened?
> 
> btrfs_split_bio() should always initialize the private pointer of the
> new bio to point to the original one.
> 
> Thus I didn't see an immediate problem with this.
> 
> 
>>
>> That bug is easily reproducible by running btrfs/146 on zoned devices and
>> it shows the following trace.
> 
> Furthermore, IIRC zoned device only supports SINGLE/DUP/RAID1 for data
> without RST.
> 
> Then there should be split happening, but only mirrored writes.

s/should be/should be no/

> Thus it looks like the description doesn't really match the symptom.
> 
> 
>>
>>      [   20.923980][   T13] BUG: kernel NULL pointer dereference, 
>> address: 0000000000000020
>>      [   20.925234][   T13] #PF: supervisor read access in kernel mode
>>      [   20.926122][   T13] #PF: error_code(0x0000) - not-present page
>>      [   20.927118][   T13] PGD 0 P4D 0
>>      [   20.927607][   T13] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>>      [   20.928424][   T13] CPU: 1 UID: 0 PID: 13 Comm: kworker/u32:1 
>> Not tainted 6.11.0-rc7-BTRFS-ZNS+ #474
>>      [   20.929740][   T13] Hardware name: Bochs Bochs, BIOS Bochs 
>> 01/01/2011
>>      [   20.930697][   T13] Workqueue: writeback wb_workfn (flush- 
>> btrfs-5)
>>      [   20.931643][   T13] RIP: 0010:btrfs_bio_end_io+0xae/0xc0 [btrfs]
>>      [   20.932573][ T1415] BTRFS error (device dm-0): bdev /dev/ 
>> mapper/error-test errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
>>      [   20.932871][   T13] Code: ba e1 48 8b 7b 10 e8 f1 f5 f6 ff eb 
>> da 48 81 bf 10 01 00 00 40 0c 33 a0 74 09 40 88 b5 f1 00 00 00 eb b8 
>> 48 8b 85 18 01 00 00 <48> 8b 40 20 0f b7 50 24 f0 01 50 20 eb a3 0f 1f 
>> 40 00 90 90 90 90
>>      [   20.936623][   T13] RSP: 0018:ffffc9000006f248 EFLAGS: 00010246
>>      [   20.937543][   T13] RAX: 0000000000000000 RBX: 
>> ffff888005a7f080 RCX: ffffc9000006f1dc
>>      [   20.938788][   T13] RDX: 0000000000000000 RSI: 
>> 000000000000000a RDI: ffff888005a7f080
>>      [   20.940016][   T13] RBP: ffff888011dfc540 R08: 
>> 0000000000000000 R09: 0000000000000001
>>      [   20.941227][   T13] R10: ffffffff82e508e0 R11: 
>> 0000000000000005 R12: ffff88800ddfbe58
>>      [   20.942375][   T13] R13: ffff888005a7f080 R14: 
>> ffff888005a7f158 R15: ffff888005a7f158
>>      [   20.943531][   T13] FS:  0000000000000000(0000) 
>> GS:ffff88803ea80000(0000) knlGS:0000000000000000
>>      [   20.944838][   T13] CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>>      [   20.945811][   T13] CR2: 0000000000000020 CR3: 
>> 0000000002e22006 CR4: 0000000000370ef0
>>      [   20.946984][   T13] DR0: 0000000000000000 DR1: 
>> 0000000000000000 DR2: 0000000000000000
>>      [   20.948150][   T13] DR3: 0000000000000000 DR6: 
>> 00000000fffe0ff0 DR7: 0000000000000400
>>      [   20.949327][   T13] Call Trace:
>>      [   20.949949][   T13]  <TASK>
>>      [   20.950374][   T13]  ? __die_body.cold+0x19/0x26
>>      [   20.951066][   T13]  ? page_fault_oops+0x13e/0x2b0
>>      [   20.951766][   T13]  ? _printk+0x58/0x73
>>      [   20.952358][   T13]  ? do_user_addr_fault+0x5f/0x750
>>      [   20.953120][   T13]  ? exc_page_fault+0x76/0x240
>>      [   20.953827][   T13]  ? asm_exc_page_fault+0x22/0x30
>>      [   20.954606][   T13]  ? btrfs_bio_end_io+0xae/0xc0 [btrfs]
>>      [   20.955616][   T13]  ? btrfs_log_dev_io_error+0x7f/0x90 [btrfs]
>>      [   20.956682][   T13]  btrfs_orig_write_end_io+0x51/0x90 [btrfs]
>>      [   20.957769][   T13]  dm_submit_bio+0x5c2/0xa50 [dm_mod]
>>      [   20.958623][   T13]  ? find_held_lock+0x2b/0x80
>>      [   20.959339][   T13]  ? blk_try_enter_queue+0x90/0x1e0
>>      [   20.960228][   T13]  __submit_bio+0xe0/0x130
>>      [   20.960879][   T13]  ? ktime_get+0x10a/0x160
>>      [   20.961546][   T13]  ? lockdep_hardirqs_on+0x74/0x100
>>      [   20.962310][   T13]  submit_bio_noacct_nocheck+0x199/0x410
>>      [   20.963140][   T13]  btrfs_submit_bio+0x7d/0x150 [btrfs]
>>      [   20.964089][   T13]  btrfs_submit_chunk+0x1a1/0x6d0 [btrfs]
>>      [   20.965066][   T13]  ? lockdep_hardirqs_on+0x74/0x100
>>      [   20.965824][   T13]  ? __folio_start_writeback+0x10/0x2c0
>>      [   20.966659][   T13]  btrfs_submit_bbio+0x1c/0x40 [btrfs]
>>      [   20.967617][   T13]  submit_one_bio+0x44/0x60 [btrfs]
>>      [   20.968536][   T13]  submit_extent_folio+0x13f/0x330 [btrfs]
>>      [   20.969552][   T13]  ? btrfs_set_range_writeback+0xa3/0xd0 
>> [btrfs]
>>      [   20.970625][   T13]  extent_writepage_io+0x18b/0x360 [btrfs]
>>      [   20.971632][   T13]  extent_write_locked_range+0x17c/0x340 
>> [btrfs]
>>      [   20.972702][   T13]  ? __pfx_end_bbio_data_write+0x10/0x10 
>> [btrfs]
>>      [   20.973857][   T13]  run_delalloc_cow+0x71/0xd0 [btrfs]
>>      [   20.974841][   T13]  btrfs_run_delalloc_range+0x176/0x500 [btrfs]
>>      [   20.975870][   T13]  ? find_lock_delalloc_range+0x119/0x260 
>> [btrfs]
>>      [   20.976911][   T13]  writepage_delalloc+0x2ab/0x480 [btrfs]
>>      [   20.977792][   T13]  extent_write_cache_pages+0x236/0x7d0 [btrfs]
>>      [   20.978728][   T13]  btrfs_writepages+0x72/0x130 [btrfs]
>>      [   20.979531][   T13]  do_writepages+0xd4/0x240
>>      [   20.980111][   T13]  ? find_held_lock+0x2b/0x80
>>      [   20.980695][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
>>      [   20.981461][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
>>      [   20.982213][   T13]  __writeback_single_inode+0x5c/0x4c0
>>      [   20.982859][   T13]  ? do_raw_spin_unlock+0x49/0xb0
>>      [   20.983439][   T13]  writeback_sb_inodes+0x22c/0x560
>>      [   20.984079][   T13]  __writeback_inodes_wb+0x4c/0xe0
>>      [   20.984886][   T13]  wb_writeback+0x1d6/0x3f0
>>      [   20.985536][   T13]  wb_workfn+0x334/0x520
>>      [   20.986044][   T13]  process_one_work+0x1ee/0x570
>>      [   20.986580][   T13]  ? lock_is_held_type+0xc6/0x130
>>      [   20.987142][   T13]  worker_thread+0x1d1/0x3b0
>>      [   20.987918][   T13]  ? __pfx_worker_thread+0x10/0x10
>>      [   20.988690][   T13]  kthread+0xee/0x120
>>      [   20.989180][   T13]  ? __pfx_kthread+0x10/0x10
>>      [   20.989915][   T13]  ret_from_fork+0x30/0x50
>>      [   20.990615][   T13]  ? __pfx_kthread+0x10/0x10
>>      [   20.991336][   T13]  ret_from_fork_asm+0x1a/0x30
>>      [   20.992106][   T13]  </TASK>
>>      [   20.992482][   T13] Modules linked in: dm_mod btrfs 
>> blake2b_generic xor raid6_pq rapl
>>      [   20.993406][   T13] CR2: 0000000000000020
>>      [   20.993884][   T13] ---[ end trace 0000000000000000 ]---
>>      [   20.993954][ T1415] BUG: kernel NULL pointer dereference, 
>> address: 0000000000000020
>>
>> * Case 2. Earlier completion of orig_bbio for mirrored btrfs_bios
>>
>> btrfs_bbio_propagate_error() assumes the end_io function for orig_bbio is
>> called last among split bios. In that case, btrfs_orig_write_end_io() 
>> sets
>> the bio->bi_status to BLK_STS_IOERR by seeing the bioc->error [1].
>> Otherwise, the increased orig_bio's bioc->error is not checked by anyone
>> and return BLK_STS_OK to the upper layer.
> 
> That doesn't sound correct to me.
> 
> The original bio always got its bio->__bi_remaining increased when it
> get cloned.
> 
> And __bi_remaining is only decreased when the cloned or the original bio
> get its endio function called (bio_endio()).
> 
> For cloned bios, it's mostly the same chained bio behavior, with extra
> btrfs write tolerance added.
> 
> So the explanation doesn't look correct to me.
> 
>>
>> [1] Actually, this is not true. Because we only increases orig_bioc- 
>> >errors
>> by max_errors, the condition "atomic_read(&bioc->error) > bioc- 
>> >max_errors"
>> is still not met if only one split btrfs_bio fails.
>>
>> * Case 3. Later completion of orig_bbio for un-mirrored btrfs_bios
>>
>> In contrast to the above case, btrfs_bbio_propagate_error() is not 
>> working
>> well if un-mirrored orig_bbio is completed last. It sets
>> orig_bbio->bio.bi_status to the btrfs_bio's error. But, that is easily
>> over-written by orig_bbio's completion status. If the status is 
>> BLK_STS_OK,
>> the upper layer would not know the failure.
>>
>> * Solution
>>
>> Considering the above cases, we can only save the error status in the
>> orig_bbio itself as it is always available. Also, the saved error status
>> should be propagated when all the split btrfs_bios are finished (i.e,
>> bbio->pending_ios == 0).
> 
> This looks like it will not handle the write error tolerance at all.
> 
> If there is really some timing related problem, I'd recommend to queue
> all the split bios into a bio_list, and submit them all when all splits
> is done.
> 
> Otherwise we will not tolerate any write failures.
> 
>>
>> This commit introduces "status" to btrfs_bbio and uses the last saved 
>> error
>> status for bbio->bio.bi_status.
>>
>> With this commit, btrfs/146 on zoned devices does not hit the NULL 
>> pointer
>> dereference.
>>
>> Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
>> CC: stable@vger.kernel.org # 6.6+
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>   fs/btrfs/bio.c | 33 +++++++++------------------------
>>   fs/btrfs/bio.h |  3 +++
>>   2 files changed, 12 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 056f8a171bba..a43d88bdcae7 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct 
>> btrfs_fs_info *fs_info,
>>       bbio->end_io = end_io;
>>       bbio->private = private;
>>       atomic_set(&bbio->pending_ios, 1);
>> +    atomic_set(&bbio->status, BLK_STS_OK);
>>   }
>>
>>   /*
>> @@ -120,41 +121,25 @@ static void __btrfs_bio_end_io(struct btrfs_bio 
>> *bbio)
>>       }
>>   }
>>
>> -static void btrfs_orig_write_end_io(struct bio *bio);
>> -
>> -static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
>> -                       struct btrfs_bio *orig_bbio)
>> -{
>> -    /*
>> -     * For writes we tolerate nr_mirrors - 1 write failures, so we can't
>> -     * just blindly propagate a write failure here.  Instead 
>> increment the
>> -     * error count in the original I/O context so that it is 
>> guaranteed to
>> -     * be larger than the error tolerance.
>> -     */
>> -    if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
>> -        struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
>> -        struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
>> -
>> -        atomic_add(orig_bioc->max_errors, &orig_bioc->error);
>> -    } else {
>> -        orig_bbio->bio.bi_status = bbio->bio.bi_status;
>> -    }
>> -}
>> -
>>   void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>>   {
>>       bbio->bio.bi_status = status;
>>       if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
>>           struct btrfs_bio *orig_bbio = bbio->private;
>>
>> -        if (bbio->bio.bi_status)
>> -            btrfs_bbio_propagate_error(bbio, orig_bbio);
>> +        /* Save the last error. */
>> +        if (bbio->bio.bi_status != BLK_STS_OK)
>> +            atomic_set(&orig_bbio->status, bbio->bio.bi_status);
>>           btrfs_cleanup_bio(bbio);
>>           bbio = orig_bbio;
>>       }
>>
>> -    if (atomic_dec_and_test(&bbio->pending_ios))
>> +    if (atomic_dec_and_test(&bbio->pending_ios)) {
>> +        /* Load split bio's error which might be set above. */
>> +        if (status == BLK_STS_OK)
>> +            bbio->bio.bi_status = atomic_read(&bbio->status);
>>           __btrfs_bio_end_io(bbio);
>> +    }
>>   }
>>
>>   static int next_repair_mirror(struct btrfs_failed_bio *fbio, int 
>> cur_mirror)
>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>> index e48612340745..b8f7f6071bc2 100644
>> --- a/fs/btrfs/bio.h
>> +++ b/fs/btrfs/bio.h
>> @@ -79,6 +79,9 @@ struct btrfs_bio {
>>       /* File system that this I/O operates on. */
>>       struct btrfs_fs_info *fs_info;
>>
>> +    /* Set the error status of split bio. */
>> +    atomic_t status;
>> +
> 
> The same as David, please do not abuse atomic_t for this purpose.
> 
> Thanks,
> Qu
> 
>>       /*
>>        * This member must come last, bio_alloc_bioset will allocate 
>> enough
>>        * bytes for entire btrfs_bio but relies on bio being last.
> 


