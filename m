Return-Path: <linux-btrfs+bounces-13181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D19A9477F
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FF5161D15
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6481E25ED;
	Sun, 20 Apr 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tba7xBNP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BF1BD4F7
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Apr 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146462; cv=none; b=A3gexWE35+mJ9jWHtU0SDuJxyDeAqxUtPk+18IOY9aptaFn0/arqVhtbUXMw4CSANt4oHTb4Ln+UfQYA+3JmlflKAU9PnCZsacsKFlrF+11nEXkIGW7KtPkrUArThvnCLlwR2EkwwLcu+sg9Sl+vF1wmHUDpuybgH2Y1L5ZhDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146462; c=relaxed/simple;
	bh=PcazFpMljLR8flxaIh4AF3YdRz2pWRyr9u/RdAAwJlI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=vAJafPv1Rrk7hHUPl4zx/koShlMJzZdwXzEuMlzs2XL5sOnwIgUtO4A3NYVi1sA042vkAHaNVQfIJaE43ITzAkM56kFVJyfCpKS2+k7S/L9x8A+bTT0Ie13TorG+sfGoVvbtHMWwRMKbu83z//PxQkd8oPjtvZQCcDstIk3VR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tba7xBNP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so3238029f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Apr 2025 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745146457; x=1745751257; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms1sE6rGGS2GW+DPE380k9vWnvdN6p9fSn3ixqOZYpI=;
        b=Tba7xBNPJiiwPsw5xFmZFnitK2oW/Cl5pX6SRflrEz9+A2xQhjzLrszfvHuLsin8pm
         ldk6qvK8i9v7Kje8vJoe4k9hJPzEA6o4iUohG36I3SA55vvVR40m7zfO4ihB1NiARXvV
         96WO80qibJaGdctzwUOjgE+/HbFJM+MaVQlxl3PwpX3MU/PEvlsVtX7feoM9ELCDpBu/
         unzCh5D+Xpt6uQr+QazWRqd5+FwHZp90EeUMO3li2bQcWYboNZpHS6NaMqFyDGOG4g6t
         nzMyiH6Bk1f0fNmlfeMPtZKWzJP9aeBrN18emgAtGATOXCTagzxzPKmC7748rTCg0Hob
         SxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146457; x=1745751257;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms1sE6rGGS2GW+DPE380k9vWnvdN6p9fSn3ixqOZYpI=;
        b=exyO2zvGPrOKqG45up0Wyrs77Gr9n+he34fk6K5R3+7AQV7zC96W1xEhMuzQfDoG1q
         OUBsjvxu9n0ynWDk9IwGNbu1q+Nm28/SIbx6fQYhLcAhc+MerFhgR+f2OCcVj4tfvujy
         0oPcfkMsS/CidbKGFTYjVS1VSeI0P1yfrNqMOFsLLKVj3FXEEbJe1e3IPUB5uYGExSm7
         k41QBw1TjHZQoVis02UnX/S2/IKO9U4/gV+azjAKrPuqNARHD4rf7KWLBjOcJ2MQUVrK
         Uo/PeMB6zQpdy9wPBGLdWA5LUdM7rBhq2np41NdB9VT7ZXUKwVfBm4gXQm0cfPHjX1e5
         mIrg==
X-Forwarded-Encrypted: i=1; AJvYcCX48veXo8K76U4i2VrY9GjFbZJ6Helr+1yCSxkprGgGS/ULkytWBS+UOhb6x7kxSPkcJc4R/RnlfyJlPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6bBUX+Y0Zy94q3plOARkbhUadtnRb27zLgFCC/K2J0AfNtzd
	Sr/v3hoabwHO0eSg/IJY5ODBtOh1KwPP5F3r6sUtnDFbUOBLosO/m7SQPFUuS5reP5tLyfShySc
	j
X-Gm-Gg: ASbGncs9197f86o+VItGmPOPemhrSlJUU7Cw7dA4qsuTy6XcLdCCXEcv3LEZkF2ai5i
	Nu0NlDFq1p6s6xLZguqlBTfM7Z3DtbkH7GYqf3CymOAjUDwtL3+pBRRtnbyZkcKkSbYEu708HHn
	kWgBrIGs2vqYVSOZ6NasGoYdk17UVwxuAX4Macf5yQ/kTqiQkD9jwQMGqs/0MAg+q/gHeW+RzIn
	QdF6RfZhyGtNtHF80VWhNdCBA4cLZNXWIKPCuxGyU6WV2gvFn7f/4hCzxIZSpUgeSBYvL1m8/Oe
	lB3hZxVYBGiUP2GAi/R6iFxvhVlm+CNPXR/KHoQT/wkjzQskjMXue2h+RPFbe2aFgBFg
X-Google-Smtp-Source: AGHT+IHJpusqLKfYt4HNrrl5xanVjDSvKTtFa9c2tQRFlaNdATw6IaLVQKOWIfTXgkxBOfdme5gs3g==
X-Received: by 2002:a05:6000:4201:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-39efba608e1mr5964095f8f.34.1745146456481;
        Sun, 20 Apr 2025 03:54:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfab289asm4527999b3a.153.2025.04.20.03.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 03:54:15 -0700 (PDT)
Message-ID: <d6c22895-b3b5-454e-b889-9d0bd148e2fb@suse.com>
Date: Sun, 20 Apr 2025 20:24:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <wqu@suse.com>
Subject: Sleep inside atomic for aarch64, triggered by generic/482
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently I hit two dmesg reports from generic/482, on aarch64 64K page 
size with 4K fs block size.

The involved warning looks like this:

117645.139610] BTRFS info (device dm-13): using free-space-tree
[117645.146707] BTRFS info (device dm-13): start tree-log replay
[117645.158598] BTRFS info (device dm-13): last unmount of filesystem 
214efad4-5c63-49b6-ad29-f09c4966de33
[117645.322288] BUG: sleeping function called from invalid context at 
mm/util.c:743
[117645.322312] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 
46, name: kcompactd0
[117645.322325] preempt_count: 1, expected: 0
[117645.322329] RCU nest depth: 0, expected: 0
[117645.322338] CPU: 3 UID: 0 PID: 46 Comm: kcompactd0 Tainted: G 
W  OE       6.15.0-rc2-custom+ #116 PREEMPT(voluntary)
[117645.322343] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[117645.322345] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 
2/2/2022
[117645.322347] Call trace:
[117645.322349]  show_stack+0x34/0x98 (C)
[117645.322360]  dump_stack_lvl+0x60/0x80
[117645.322366]  dump_stack+0x18/0x24
[117645.322370]  __might_resched+0x130/0x168
[117645.322375]  folio_mc_copy+0x54/0xa8
[117645.322382]  __migrate_folio.isra.0+0x5c/0x1f8
[117645.322387]  __buffer_migrate_folio+0x28c/0x2a0
[117645.322391]  buffer_migrate_folio_norefs+0x1c/0x30
[117645.322395]  move_to_new_folio+0x94/0x2c0
[117645.322398]  migrate_pages_batch+0x7e4/0xd10
[117645.322402]  migrate_pages_sync+0x88/0x240
[117645.322405]  migrate_pages+0x4d0/0x660
[117645.322409]  compact_zone+0x454/0x718
[117645.322414]  compact_node+0xa4/0x1b8
[117645.322418]  kcompactd+0x300/0x458
[117645.322421]  kthread+0x11c/0x140
[117645.322426]  ret_from_fork+0x10/0x20
[117645.400370] BTRFS: device fsid 214efad4-5c63-49b6-ad29-f09c4966de33 
devid 1 transid 31 /dev/mapper/thin-vol.482 (253:13) scanned by mount 
(924470)
[117645.404282] BTRFS info (device dm-13): first mount of filesystem 
214efad4-5c63-49b6-ad29-f09c4966de33

Again this has no btrfs involved in the call trace.

This looks exactly like the report here:

https://lore.kernel.org/linux-mm/67f6e11f.050a0220.25d1c8.000b.GAE@google.com/

However there are something new here:

- The target fs is btrfs, no large folio support yet
   At least the branch I'm testing (based on v6.15-rc2) doesn't support
   folio.

   Furthermore since it's btrfs, there is no buffer_head usage involved.
   (But the rootfs is indeed ext4)

- Arm64 64K page size with 4K block size
   It's less common than x86_64.

Fortunately I can reproduce the bug reliable, it takes around 3~10 runs 
to hit it.

Hope this report would help a little.

Thanks,
Qu

