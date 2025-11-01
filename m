Return-Path: <linux-btrfs+bounces-18513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB8AC2880E
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 22:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCD204E2D66
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989412727FE;
	Sat,  1 Nov 2025 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V4ptZRQF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C221386C9
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762032974; cv=none; b=gbz0Wk2cDiSO0Q2yVjrPqANlpjncKXf1Z3k199fNlrZb7VFSH1aiPOUZzgTwHBHY14tappd9E2eT4BJHpMhraikrD5w7DC4SGA2EKKyZXkB9kM8wm3+VnzgP8rGNA6Bc6yq38bqKPjg1OntmXoQeGAVHIboYNaOZnORyuW7fqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762032974; c=relaxed/simple;
	bh=Pai7nUv9Mxgg65oO8zt87DEuh73ycxc1DHEaiWQyJJE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uzX+0iCVC+SsYLJnuqsqN56Lr18IL768w6b2MeXV//da5LHv7+a0kLBX5QT1EY2uSn+aV9PtM0FQ/twsx50POIXOPyMvIXxeJCxkA3ePrDi3NSbZ1zrMKYiQejfU8K7h5PO8i5CeDgYqG0hXaPrT7umDU28QBtElZHDOsJKAGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V4ptZRQF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429bf011e6cso1982632f8f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Nov 2025 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762032971; x=1762637771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odjVJt1FDdSdgYDvFWviiPFK+lb0FqE6o5NcPSY7uwM=;
        b=V4ptZRQFTNdYi7oJr71R0jJ+luKSOKR0BBmCkWqxBlREraj5chC6BuHnuqfAUsQIMk
         kU4NYcmPiKa0TLi8XZ7EvB+kbmypiVVfk67ZEzyZrEZELwcDzntqMbAD0mlxxsgDcE7N
         /HA2PqmSBICvxZFEPayEeQu/NyZzJAMsFye1Shnk0Ouhb6H1a7/qM1nEz5Pm8yyQFoON
         Rzd1bh5dJLNTVNKdH3SNKhlNzIltY7AI7/Kv5WqEGBIRewk8tBenqmSqerRUzoZOagyc
         l1DyQX3Ls8ggUGU7ShKzlqcTDPRGpjjBTn5dBXkHznMPojfsVYJKmmAHMqG5UvU1W7/C
         APTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762032971; x=1762637771;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odjVJt1FDdSdgYDvFWviiPFK+lb0FqE6o5NcPSY7uwM=;
        b=dD4A6kSUEyaT6DV2z/+Xe/lPr3nbUquvj0cBxiJAb75XhfvYUpQOKPCphbdsvHP3J4
         ZCJmBZTQhbKH2KKN+PM1FqXWbqe0kKUiw0y6OnmCwPy9JScWDbYFO0sMqo/x8O4Pqy8N
         7z+3ULt4i0MsH6lGy83qbP33qLgs9pGIaJIbx7wHZvZ+GfomVlPhu60vBqD3bAy+/g4/
         XRP5L0hCOjvvYGTYG9uScfEALQ3q6+5PYeXAAzlcx/CY5loyY8xqT3lWVq3b1N5lF7/9
         yIJF+m4vABsNSzsJQnKnqblANz+5QLQEwY/Umbh7qGoIc7lz50SPjsyyp0oyoAAJV58Q
         61yQ==
X-Gm-Message-State: AOJu0YxjWNIcOMUkH6NIoesAjx5JhbnEqyKDLBNrH6G4O2KI/vqKpBRU
	EInZo2NtCmtBk6K64IpLuC1Zh6MBwEOY17O6p67pJzAqyGpl6qC+YHQ+BAuIq248qgGWVVqTuDG
	NLpMYC9I=
X-Gm-Gg: ASbGnctc4T3NGo3w9To+uDjoeFaKCZ14AkrQYhd3tJu6pNXClLOIiO0EXul1oIJCEVO
	oSnDNBoB5kfc9o59zPofR9YfXv+hulMSyJvynkPX8L3ARL5ub2fep5G47DdL/KOq65YTaqY7MPi
	hTbfJQ5umNXOO9c242btWpHNXD3d6IS+2snwcKu4fm2fB6MpbEh60nihxIbVGadET0onpIrgglH
	HoXAGe7ahTjCS/qdLLKJNAFEb/sZMUZ4dPZUJhc+MRuhB+B+X1hSeugd7D9dx54HzJbZc+/e+iI
	Dl7+nGdIoFlNMa+xQz0NdK4i3ZthgvQ9G86oTJ4cVVGiYU/WGpbnWuDIKrEUUPgZ2tVTc6BEqHf
	3YLcFhcswS8Tsc5CFWNX9Oeje4JlVr3IP/7S4NkNCkABEzSO7tK5W7gvn8Et0OozxVz0fyiTyxh
	hgpghSmasdjXf21rYna/rYDZY29V1ONj35cIkucys=
X-Google-Smtp-Source: AGHT+IGt4vg92gDUV6HXGb3jhQ8yGG4ex5ApB33lkbvGUrN6yWr2RR9QIgxlhet6h0aCIauEJOtDZQ==
X-Received: by 2002:a05:6000:400a:b0:427:6cb:74a4 with SMTP id ffacd0b85a97d-429bd6aa232mr6515441f8f.39.1762032970760;
        Sat, 01 Nov 2025 14:36:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29551168756sm38436505ad.16.2025.11.01.14.36.09
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 14:36:10 -0700 (PDT)
Message-ID: <0bc97229-4bf9-40f8-a7f3-3597299687bc@suse.com>
Date: Sun, 2 Nov 2025 08:06:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fallback to buffered read if the inode has data
 checksum
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <aa09b68f159fb0de4864de151eeba9250f2e34fd.1758840406.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <aa09b68f159fb0de4864de151eeba9250f2e34fd.1758840406.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/26 08:20, Qu Wenruo 写道:
> Commit 968f19c5b1b7 ("btrfs: always fallback to buffered write if the
> inode requires checksum") makes direct writes to fallback to buffered
> ones if the inode has data checksum.
> 
> That commit is to avoid unreliable user space modifying the write buffer
> during writeback, which can lead to data checksum mismatch.
> (As the checksum is calculated, then buffer is modified, and the
> modified data is submitted)
> 
> On the other hand, it's also possible that the user space program can
> modify the read buffer at any time.
> 
> If the content is just read from the disk, then during checksum
> verification the user space program modified the read buffer, it will
> cause false alerts about csum mismatch.
> 
> Despite the possibility of false alerts, we should also keep the
> behavior between direct read and direct write consistent.
> If direct writes are already falling back to buffered for inodes with
> checksum, the direct reads should also follow the same behavior.
> 
> So here, add the same data checksum checks for direct reads, so that
> those reads will also fallback to buffered reads.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

A gentle ping.

Any feedback on this patch?

Thanks,
Qu

> ---
> This will make test case btrfs/267 fail, as the fallback to buffered
> read will happen in a different context (workqueue), screwing up the pid
> based read balance.
> 
> Furthermore true direct reads will require NODATASUM, it no longer makes
> any sense to test direct IO read repair.
> 
> If this is merged, I'll send out a patch to remove btrfs/267.
> ---
>   fs/btrfs/direct-io.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 6018d8c3e101..6f35fed5fa3f 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -1046,6 +1046,13 @@ ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
>   	if (check_direct_read(inode_to_fs_info(inode), to, iocb->ki_pos))
>   		return 0;
>   
> +	/*
> +	 * To keep the behavior consistent with direct write, fall back to
> +	 * buffered IO if the inode has data checksum.
> +	 */
> +	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
> +		return 0;
> +
>   	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
>   again:
>   	/*


