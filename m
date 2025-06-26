Return-Path: <linux-btrfs+bounces-14983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B39AE99B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF63A70E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B32BCF54;
	Thu, 26 Jun 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fqnwnt/W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA029E0EE
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929043; cv=none; b=GuYc1M0RXK01TbFCXxmQGx3ATeis/ntpierwLt56MI6oCNUrlF/WusjV+dShlMjGRrkdBpL+cFK7WBHX29yxkTChEqEy/YUQ0XhFaQC7EzXLIEHNjB4DlmgRM7XH/kKmq5ubP5h0m7x3cwnek+pl177JvkWsCVFg2R6+N9JRl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929043; c=relaxed/simple;
	bh=U6RSnd+wYLm+0tjwMhOy8BFqRTtzEB822jcXyORqUuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qtcw7WJe2uzojOF3B70pn5QoNZbwlpQ97ovyJK9CyFIcXdGCZVo9X6UnOLug9hifgqwZHfoYlXGMiLTE0bH0MbNktD4G8m0c/4PjeXWVfN38oRIDByEaNxVa6aDY7ccVgLa+qPYx8/dPu1/cdWUftXvBwRLN7gxMaQFv406L4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fqnwnt/W; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so707871f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750929040; x=1751533840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uMd/JyGLuKS0RBMxfxqFgWYU1CCGC47M7FEupYZIOgQ=;
        b=fqnwnt/WxwDSRD08qo4ZSglFYs0qBBCCkWxy/cd+2EPArRW2TgcZHweMyxORHy+PB+
         Cj5FPvB0gi4bpI+kzWnE1XuH6oitx8yJhs+a+N3nUq0agtH887f93Rj7prAIXVEm9mCH
         w/SJFfDgW+YLfjYXeNCfAZToSOGyzs3DgenOO4o+JWJRD5lvUoTYAxCZHkJPNt/MKXnZ
         WNj1hqNKJ/u8YQcLWGQwAWkcU8NAr2CsTkh/Vy4MmTSUvwmjGOxbFU7O3Dkvym558mPM
         780NmnuSrT/Yg7TmMoyIxSkyKAJjSeHR1USS+BT+qTmRgMDSw+fg29VICTCGZc82QBkw
         41Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750929040; x=1751533840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMd/JyGLuKS0RBMxfxqFgWYU1CCGC47M7FEupYZIOgQ=;
        b=h1uL9lqIQpe02GMe72BpbIbwk2+QJRXnBxlFGUmzeP0WbfNQMxE7gmQcFeHL/pYYI3
         4PEMC86I5TLJ9VAWcu1WuDglpIgN3+scrL+TtepaFVqfnp92tEcri/GNrtTQ19+kzFZ5
         1N134YwAQmpDa1o2ftzqpvrbBYSLyQr/JFbOCSDVjPsVBWBFgD1h3c78nj8efhjjtH+5
         aGubGeMjG2S5vz8Hab9z5HuKMj0N6IFefgwQn/6t5bCyEPtFV/BJKvdfc7hD7283D+NC
         LNzbfsIgDvYx3B7lKbYfk23BaJTIHwnau8ly9j5SKaS9Lug1qJnArwBPLs53mowt1Zmu
         qtxg==
X-Gm-Message-State: AOJu0Yyl68yYDvANDn83UmEOp4mwJoUs7tqmbdonfosGLv7JZxH8dX+n
	vExcxbMO7+W6YWpMNl2sq0QeP3NrSuDAl62hpXaitjZQL9ZHcdRUgL5ucio8IiZKroU=
X-Gm-Gg: ASbGnct5h6tqF5ahCPw+eeFkSS4XBuUiaPQq9eTk/nK6KKj2xR9W+aCDdVan26ZU9sg
	5hM2fy4kpaPzrL1rplZ0Ks9xkmzjBMtlOorjQUJxEcWaOsIR1fEzDbxrTemo/DnIlmn1VKKjVy4
	TJrr6cT+xF93K34e5ihm+BDDNgJkfj6WZH2dJy8YZwWq4tuH8Mnf4RkBeJiFMpbObqSJfx35Omu
	Sy3fUUAEu7xbowGeCzXsrqkoB5g3zIackLJrcFVjh45ESiyvzwwLFniIiw6AuqK+ln2URzv4OR6
	//e79yUlB6wJKHSY8uXs7nGW3kxkmDJBdRV9p983i90kseeNQGP4RFNKSINTPbKZVf/btY6bhYM
	cOfEvNVcP7jpElQ==
X-Google-Smtp-Source: AGHT+IHD8Fu7B69vsQ7Tdx1hsXXvedNHpvs2Os8oK1UcXYCK/TyIDEmiHCApn/3mXgwyGxoQHZT4Qw==
X-Received: by 2002:a05:6000:2207:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3a6ed5b880amr5409966f8f.5.1750929039376;
        Thu, 26 Jun 2025 02:10:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ad0bd67d4sm4855793b3a.40.2025.06.26.02.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:10:38 -0700 (PDT)
Message-ID: <3316b26c-346a-43a7-bfe3-b9c2d3b81c6f@suse.com>
Date: Thu, 26 Jun 2025 18:40:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Five data races in btrfs
To: haoran zheng <zhenghaoran154@gmail.com>, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, zzzccc427@gmail.com
References: <CAKa5YKiTodi=aDMqa8gb4o+4RAdis=-OYFv4HP9nQ3EHcCTzMA@mail.gmail.com>
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
In-Reply-To: <CAKa5YKiTodi=aDMqa8gb4o+4RAdis=-OYFv4HP9nQ3EHcCTzMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/26 17:53, haoran zheng 写道:
> [BUG] Five data races in btrfs
> 
> Hello maintainers,
> 
> I would like to report five data race bugs we discovered in the BTRFS
> filesystem on Linux kernel v6.16-rc3. These issues were identified
> using our data race detector.
> 
> We are currently analyzing the Btrfs codebase and have identified
> several instances that may involve potential data races during
> concurrent execution. While we have reviewed the relevant code
> paths carefully, we are uncertain whether these issues could lead
> to any practical impact or system instability.
> 
> Below is a summary of the findings:
> 
> ---
> 
> 1. Race between `__btrfs_set_fs_incompat()` and `btrfs_fs_incompat()`
> 
> `__btrfs_set_fs_incompat()` performs a write to the
> `super_copy->incompat_flags` field under `fs_info->super_lock` while
> `btrfs_need_stripe_tree_update()` calls `btrfs_fs_incompat()` without
> acquiring `super_lock`, which may read a stale or partially updated
> value of `incompat_flags`.

I think we should cache the super block incompat/compat_ro flags into 
btrfs_fs_info, so that we can use bit operations.
> ---
> 
> 2. Race between `btrfs_defrag_file()` and `inode_need_compress()`
> 
> In `btrfs_defrag_file()`, the field `inode->defrag_compress` is
> assigned while holding the inode lock via `btrfs_inode_lock()`.
> But in `inode_need_compress()`, the same field is read without
> any apparent locking or memory barrier.
I do not think we should hold any inode lock just to access defrag_compress.

Mind to explain why accessing that member without any lock can be 
problematic?

The only thing I can think of is some unaligned access,
but accessing a u8 alone shouldn't need special lock.

> ---
> 
> 3. Race between `join_transaction()` and `btrfs_get_fs_generation()`
> 
> In `join_transaction()`, `fs_info->generation` is assigned while
> holding the lock `fs_info->trans_lock`. But reads of
> `fs_info->generation` are done using READ_ONCE() in
> `btrfs_get_fs_generation()`.

Again, I didn't see much problem accessing a single u64 value with or 
without holding a lock.


> ---
> 
> 4. Race between `btrfs_super_bytes_used()` and `btrfs_update_block_group()`
> 
> In `btrfs_set_backup_bytes_used()`, super_copy is read and stored  without
> holding lock `info->delalloc_root_lock`. But in `btrfs_update_block_group()`
> the `info->super_copy` is set concurrently.

This is definitely false alert.

In btrfs_update_block_group() it holds a transaction handle, thus no one 
can commit the current transaction until the transaction handle is released.

Furthermore, btrfs_super_bytes_used() is accessing the superblock copy, 
but super block copy is only updated during the end of commit transaction.

So it's very safe to access the super block members with a trans handle 
hold.


> ---
> 
> 5. Race between `btrfs_defrag_file()` and `btrfs_defrag_file()`
> 
> In the function btrfs_defrag_file(), we also noticed a possible
> race condition involving the writeback_index field of the
> address_space structure associated with the inode. Specifically,
> the code performs a read and conditional write without any
> evident locking:

This may need some extra digging, but so far I'm seeing other fses doing 
a similar work.

And considering all the above 4 cases, I'm not that confident if your 
reports are that helpful.

Thanks,
Qu


