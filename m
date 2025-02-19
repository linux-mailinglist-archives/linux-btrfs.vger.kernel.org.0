Return-Path: <linux-btrfs+bounces-11546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FCA3B21B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7524D18977C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815B148827;
	Wed, 19 Feb 2025 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FqKpVICk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4371179BC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949427; cv=none; b=sWHc/CRBVqRJSwlzP9NUtSxwVkv//8cm408rWWXlfuGyKP0auna9eYcsUdJS8dqudRcHsXIlx5CaEW/Et0+SGbH/17INDQ4iHPt72Ul9Qo2yMJHkIAc14kvfUZXYvAUopOWp43bMrdJFL0D1k8LRxXpUF3GQlH6kpdmh2ZhlI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949427; c=relaxed/simple;
	bh=MFxwT0fNuoMjA/l2xxW4zfhIFnLmzmtX0ymzud4bH1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qn826jQpX5sWTQ2q/Ak5Gl4xwho0dpnvq+OEmAnEap8wTqiReTxMRHsHvnYS5V/JYZmrlgm0bNob0T0pDkOZZS4jVDsKqq2LC/B4PYq3iWq5E3jpM6TWAbM7LNpruXD5q6kxLX0yRnyL5KcwzAUFkCPfIFk6FgQBaXTGMtS/OIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FqKpVICk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4397dff185fso30768965e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 23:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739949424; x=1740554224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=emRiaJ55wmAWLafh9QZUSr9omh4gj7kGu0Svn/N3GIU=;
        b=FqKpVICkocm6au0AA7vxQbWJmpKBv/BPxFAvi47P4WtFTHFuTQqTIVGICXDHmwUSwA
         ay8GfpfmkK0o/tei8AkX+pAI+nAGEZqsfR7IxsNg9+3vwU37zT7iNf2KuZpNq/oJpnNF
         RHJLy3g5x6bUkJ59m9RhtgAJ0ASKunM7nTh32zeNmB9Q9sCtnZxb4dJTqlUo5UcorhAB
         Ouq+092TEapxnAH/641kTuRaE4tYHyttnnEX5H1sqDGt3jXdS/302nvusxsUzUg7FHZe
         Q1/2SAySn0eYufY31F8Bid3bF8nwu5+pyFQq9nW+VJrUT7L71s2po0FNrJDgdDBia8vO
         1gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739949424; x=1740554224;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emRiaJ55wmAWLafh9QZUSr9omh4gj7kGu0Svn/N3GIU=;
        b=rtiKmwHUbOIgFfYSwg0HzwYnfDl5VwbP8UFq5T2qFGMuFOk/AKRI/HhsC41gMFhRQm
         f3+jxEaqx3tVq5lJQ8sFjJLgXoDvKjnspYfVkzXsX3/ynXrheAUBLlMJM9gDawmDo41G
         NfUq+aYtY2k5yWAV35aVEAgSAgEEIPWS1egswCz22TqINp0S++RU1waG9MbmzJPB6HrI
         ck16gUZY7rYsB8SeeceXaZHkuqModCUk4ijrWFrToH5lVQvknN3uy0KI7Lm+4cCLozfO
         KiuGXq+qxCdj1JdVPZxQyU3wbTZmYDJjbRt+Jjirya/p4j0r5z6NR+f+coW5jgXHxwEI
         tqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVXD+l9ZntDYE+pM3I4TJ9nnaveuxH7S1K/jCdKmmETp/kYBLcofSWD2PmRwZDlE49y2AY+FzAWsnIWnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjU7aUkwtA8PuKKoGkf2FTvaiRNXNB8XcaYH73rNmRWCLRF8J
	Ya7d/gqK2br1fCh1q/MpsdW6olHJDdsBIPDum2pU+0faJukIkF4eNrWI4PZV0XI=
X-Gm-Gg: ASbGncsLNv6Nk1U1tlRu065LeOFdkCFRD7MaEzwfhqs2pcKVgd5ckoei4y53bITkH+b
	4pUOdJiOXHTD5ILaRwAJ/HPPGKeog0U3ZA2llx5Iih/PgZE7VtkXjekkPq3Ar2fOdm2/sM/pBDK
	zDTt8+UfFj+/vQRhHSLiR2OiEqatijWuX+nin6kKDtiaDejrC6nrzYUI4aQXC8UxtEgAWMedgJe
	/dIxu9rwjqCoaq5nM580nIo5XM+6hu66jMP/8RDp0CphiUe7H4x78tEDubChSYrVW1hrVrIRylT
	l7ZG7idy9LLLpa5nzdZ84crGuyh1zZvl10Od5qKUFjA=
X-Google-Smtp-Source: AGHT+IF2Az1WRVXhNxeRj3e2L8gvtXiizKkcDAif42srFTZIikmJpCIp7vIbd7nktTiHjq7hv0SsaQ==
X-Received: by 2002:a5d:64a7:0:b0:38f:2401:a6a6 with SMTP id ffacd0b85a97d-38f5878befcmr1896831f8f.12.1739949423520;
        Tue, 18 Feb 2025 23:17:03 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349047sm99744665ad.7.2025.02.18.23.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 23:17:02 -0800 (PST)
Message-ID: <35790f76-4344-4992-adad-7f8e9d5eaff8@suse.com>
Date: Wed, 19 Feb 2025 17:46:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: fix extent unlock in cow_file_range()
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <baa48c5a32ae079b218613cbdae175f2387cd745.1739948529.git.naohiro.aota@wdc.com>
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
In-Reply-To: <baa48c5a32ae079b218613cbdae175f2387cd745.1739948529.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 17:32, Naohiro Aota 写道:
> Running generic/751 on the btrfs for-next often results in hung like
> below. They are both stack by locking an extent. This suggests someone
> forget to unlock an extent.
> 
>      INFO: task kworker/u128:1:12 blocked for more than 323 seconds.
>            Not tainted 6.13.0-BTRFS-ZNS+ #503
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      task:kworker/u128:1  state:D stack:0     pid:12    tgid:12    ppid:2      flags:0x00004000
>      Workqueue: btrfs-fixup btrfs_work_helper [btrfs]
>      Call Trace:
>       <TASK>
>       __schedule+0x534/0xdd0
>       schedule+0x39/0x140
>       __lock_extent+0x31b/0x380 [btrfs]
>       ? __pfx_autoremove_wake_function+0x10/0x10
>       btrfs_writepage_fixup_worker+0xf1/0x3a0 [btrfs]
>       btrfs_work_helper+0xff/0x480 [btrfs]
>       ? lock_release+0x178/0x2c0
>       process_one_work+0x1ee/0x570
>       ? srso_return_thunk+0x5/0x5f
>       worker_thread+0x1d1/0x3b0
>       ? __pfx_worker_thread+0x10/0x10
>       kthread+0x10b/0x230
>       ? __pfx_kthread+0x10/0x10
>       ret_from_fork+0x30/0x50
>       ? __pfx_kthread+0x10/0x10
>       ret_from_fork_asm+0x1a/0x30
>       </TASK>
>      INFO: task kworker/u134:0:184 blocked for more than 323 seconds.
>            Not tainted 6.13.0-BTRFS-ZNS+ #503
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      task:kworker/u134:0  state:D stack:0     pid:184   tgid:184   ppid:2      flags:0x00004000
>      Workqueue: writeback wb_workfn (flush-btrfs-4)
>      Call Trace:
>       <TASK>
>       __schedule+0x534/0xdd0
>       schedule+0x39/0x140
>       __lock_extent+0x31b/0x380 [btrfs]
>       ? __pfx_autoremove_wake_function+0x10/0x10
>       find_lock_delalloc_range+0xdb/0x260 [btrfs]
>       writepage_delalloc+0x12f/0x500 [btrfs]
>       ? srso_return_thunk+0x5/0x5f
>       extent_write_cache_pages+0x232/0x840 [btrfs]
>       btrfs_writepages+0x72/0x130 [btrfs]
>       do_writepages+0xe7/0x260
>       ? srso_return_thunk+0x5/0x5f
>       ? lock_acquire+0xd2/0x300
>       ? srso_return_thunk+0x5/0x5f
>       ? find_held_lock+0x2b/0x80
>       ? wbc_attach_and_unlock_inode.part.0+0x102/0x250
>       ? wbc_attach_and_unlock_inode.part.0+0x102/0x250
>       __writeback_single_inode+0x5c/0x4b0
>       writeback_sb_inodes+0x22d/0x550
>       __writeback_inodes_wb+0x4c/0xe0
>       wb_writeback+0x2f6/0x3f0
>       wb_workfn+0x32a/0x510
>       process_one_work+0x1ee/0x570
>       ? srso_return_thunk+0x5/0x5f
>       worker_thread+0x1d1/0x3b0
>       ? __pfx_worker_thread+0x10/0x10
>       kthread+0x10b/0x230
>       ? __pfx_kthread+0x10/0x10
>       ret_from_fork+0x30/0x50
>       ? __pfx_kthread+0x10/0x10
>       ret_from_fork_asm+0x1a/0x30
>       </TASK>
> 
> This happens because we have another success path for the zoned mode. When
> there is no active zone available, btrfs_reserve_extent() returns
> -EAGAIN. In this case, we have two reactions. (1) If the given range is
> never allocated, we can only wait for someone to finish a zone, so wait on
> BTRFS_FS_NEED_ZONE_FINISH bit and retry afterward. (2) Or, if some
> allocations are already done, we must bail out and let the caller to send
> IOs for the allocation. This is because these IOs may be necessary to
> finish a zone.
> 
> The commit 06f364284794 ("btrfs: do proper folio cleanup when
> cow_file_range() failed") moved the unlock code from the inside of the loop
> to the outside. So, previously, the allocated extents are unlocked just
> after the allocation and so before returning from the function. However,
> they are no longer unlocked on the case (2) above. That caused the hung
> issue.
> 
> Fix the issue by modifying the 'end' to the end of the allocated
> range. Then, we can exit the loop and the same unlock code can properly
> handle the case.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> CC: stable@vger.kernel.org
> Fixes: 06f364284794 ("btrfs: do proper folio cleanup when cow_file_range() failed")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for catching this, at the time of crafting that series, I had a 
bad feeling that there would be some bugs related to zoned support, and 
unfortunately this turns out to be true...

Thanks,
Qu

> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/inode.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1512eb94b6e5..f80db81fc853 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1378,8 +1378,14 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   				continue;
>   			}
>   			if (done_offset) {
> -				*done_offset = start - 1;
> -				return 0;
> +				/*
> +				 * Move @end to the end of the processed range,
> +				 * and exit the loop to unlock the processed
> +				 * extents.
> +				 */
> +				end = start - 1;
> +				ret = 0;
> +				break;
>   			}
>   			ret = -ENOSPC;
>   		}


