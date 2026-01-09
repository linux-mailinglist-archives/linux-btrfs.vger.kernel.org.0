Return-Path: <linux-btrfs+bounces-20352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E1D0C3D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 22:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5107330128F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D7731B101;
	Fri,  9 Jan 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VtPWOqtA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870A31AF30
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992696; cv=none; b=NHi3xypddLvENSzM5Rrq9xDhHTjRNHU5j37Co1owDksVIylDkmDNxKaiVxJY3tSIr+gTb5Ld6SxgJ1tG1Dwbm4GGwA85cacWQ43nAjUT5zY2MQ1XgS+JO1qxTTnciSymOlUDWq20vkeVY+nVQcMHCp/jpkCBSq8rHd5lvUn/Ai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992696; c=relaxed/simple;
	bh=94ackt0ak+oOLNgG8vYCTodN0hGZD4GgeUtUdtMMGLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E085sXWijz0Lc0mvuCZQMI89txn3J8xMfYsKWkHdpaZZ/8qaIWg18odcx1VSWPyF4XLVqZnHWRoZWpVBO8cl76CUSukNZedyhBk9w35LWTtE0jE7QhrwlEreTdRWvzJkMStxUbSLjzLUJPl4P7SbEwngmmlM0gjZpZftzxHS1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VtPWOqtA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so36542605e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767992692; x=1768597492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7GOFVLS3DKFuaCj16Yj7n73eucTN11H2x8XLfBj4fA8=;
        b=VtPWOqtAtiY+6PXcqta5/0U9GQKFSIw3cGDYDP1QUee/XEzAMz2KI9lonjVwoVxmWM
         uv8b4Q9XsATMfzFqNkyVUzUQx1grn3yWtj/dTY5YPzbaBR5T2YbHfp19YlRwVDg/xPkt
         HPmSGuHFyDuGNqIxI+OMOwDVVsMJNAY3cgVDGGJL2IO0moCIKBxgxTYvjvbwEKioEpNt
         gkJoeyP8F1LDhpUUvsp+kK+M53yuLoJDvQUcJa0NdXGhAqGWaJPNd2ClFDdgZoUOQN9+
         YNLYw3qOl1OLO63RwUXOxGNAZZxZkYt7Y8Z/GjtiSu7gGtnhoazbvEOqZPOcNuHEGl3x
         7Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767992692; x=1768597492;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GOFVLS3DKFuaCj16Yj7n73eucTN11H2x8XLfBj4fA8=;
        b=sd7fBaCzkA6PMQglUfOi6+YOCz4+kBYMIiL0CWRS5zemdRENCYoDKEHEPF6CTXae2F
         crT0znOc7HtBvJhpSXPHkpXTyUsBmSV17juBBz/IZQq0ZqHwaJridVWexW7ciZtkgkW9
         72xeN5Bcvqo32NFqrLkIojw9Wl5xJfKIY/a4YrGIu52SvhrL6y5KUPPKl/qj3u2uKAFm
         EZ8N+PyPA1uAPlLi39zCuIGvricjcFpcDblf8XaTnxbszEBiobJUho10lb67JcHvVS6Y
         BqGy1JnBu9g1VTw34s7gtsLppsyZJBDNI/2rPyRA4L3ztidqIHJLQqjkmrQevW4bEKFG
         znSg==
X-Forwarded-Encrypted: i=1; AJvYcCU++DNOD5yZ7Sl0H+X2SOcDFEX/tED2oDE5RrcD6xuul06GmzkFgPXUcs6KmaA5cwWPmEIJT1S+wJbRGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRb8c7NXyz37Bnw761zvdz2UklCvw8g9FEz7j2ULQ2SJ7JipYy
	GtWg/PwPNvqtL3HZSUBPIeRMlyrLTLqz+awnkg0sAToS8ivj3Lya2QlJ6LLieWQQU80=
X-Gm-Gg: AY/fxX4kBs2PXQ2FaEzBhShYsFutwW2AWpODev4wHUe8LfvvVAIcC8cj9hiAtZ2KX2E
	b9ps8+26acSQJe/Z/vHEURQaNmx2PfpRq3mewxXRm6eeKjqk9zbdJ5GS4R3qA22zbHIXGGH0WIS
	f0CV4INjY27o7BcpJiGR2WuMv7C3UsDuMYEp5ARAgsfCS4dhQiwAJSZZvWiUTaJs0wCwCi6pBRp
	3lht42npP96LWAwyjMNTRFo2lDEoD5PJExBShoUQes3nniaEUBRaaqUwPdv6f0Rpejh6Ln3kY0o
	sBgJDnM/roAb2+HdSWyxEfzb92moXbrFOBDClUkiG72So5NQK3SrzGwDD9dQIVNmXxf7yKY/l2v
	oGo3fSWTbFkPE1SjRBnDFy4Xq/eB+OSuzMbo6HCQpjNkCevOX24obX5AlLJm7YFnPQx4avgeG8X
	5y6rth/XpG6d4cC/DeNojMhV6a/h8YaPCW/v0yzHYzjsvlg5tInw==
X-Google-Smtp-Source: AGHT+IENEuwdgmB6VCpfeMF13aZot4+coU8pCx8GVCsLnkLrKNm7mmXUF2YKCK7nX6ec5YpJGNMH6w==
X-Received: by 2002:a05:600c:6096:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-47d849ba979mr118457515e9.0.1767992691696;
        Fri, 09 Jan 2026 13:04:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f475sm11305984a12.8.2026.01.09.13.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 13:04:51 -0800 (PST)
Message-ID: <b1e4dbd8-0a02-4761-97a8-885465bd18da@suse.com>
Date: Sat, 10 Jan 2026 07:34:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Sync read disk super and set block size
To: Edward Adam Davis <eadavis@qq.com>, fdmanana@kernel.org
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <CAL3q7H4k3Dj9gQQhBz_eadnRUaWaNPaf7+MYucshY6cis2by5Q@mail.gmail.com>
 <tencent_A63C4B6C74A576F566AA3C0B37CE96AC3609@qq.com>
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
In-Reply-To: <tencent_A63C4B6C74A576F566AA3C0B37CE96AC3609@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/9 23:32, Edward Adam Davis 写道:
> When the user performs a btrfs mount, the block device is not set
> correctly.

Explain "the block device is not set correctly", all your later commit 
message is showing that it's end user re-setting the device block size.
There is nothing "not set correctly".

> The user sets the block size of the block device to 0x4000
> by executing the BLKBSZSET command.
> Since the block size change also changes the mapping->flags value, this
> further affects the result of the mapping_min_folio_order() calculation.
> 
> Let's analyze the following two scenarios:
> Scenario 1: Without executing the BLKBSZSET command, the block size is
> 0x1000, and mapping_min_folio_order() returns 0;
> 
> Scenario 2: After executing the BLKBSZSET command, the block size is
> 0x4000, and mapping_min_folio_order() returns 2.
> 
> do_read_cache_folio() allocates a folio before the BLKBSZSET command
> is executed. This results in the allocated folio having an order value
> of 0. Later, after BLKBSZSET is executed, the block size increases to
> 0x4000, and the mapping_min_folio_order() calculation result becomes 2.
> This leads to two undesirable consequences:
> 1. filemap_add_folio() triggers a VM_BUG_ON_FOLIO(folio_order(folio) <
> mapping_min_folio_order(mapping)) assertion.
> 2. The syzbot report [1] shows a null pointer dereference in
> create_empty_buffers() due to a buffer head allocation failure.

Although I agree with the analyze so far, I didn't see we should 
continue stick to the old read_page_cache_gfp() call.

There is already an old series which will address it pretty well:

https://lore.kernel.org/linux-btrfs/cover.1752097916.git.wqu@suse.com/

Although at that time I'm not aware of the race between blocksize set 
and read_page_cache_gfp().

Since btrfs is the last one utilizing this interface, I think it's 
better to completely remove it other than bothering the extra locking 
requirement.

> 
> Synchronization should be established based on the inode between the
> BLKBSZSET command and read cache page to prevent inconsistencies in
> block size or mapping flags before and after folio allocation.
> 
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:create_empty_buffers+0x4d/0x480 fs/buffer.c:1694
> Call Trace:
>   folio_create_buffers+0x109/0x150 fs/buffer.c:1802
>   block_read_full_folio+0x14c/0x850 fs/buffer.c:2403
>   filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2496
>   do_read_cache_folio+0x266/0x5c0 mm/filemap.c:4096
>   do_read_cache_page mm/filemap.c:4162 [inline]
>   read_cache_page_gfp+0x29/0x120 mm/filemap.c:4195
>   btrfs_read_disk_super+0x192/0x500 fs/btrfs/volumes.c:1367
> 
> Reported-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b4a2af3000eaa84d95d5
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Anyway you won't reply to any review/comment, I doubt if you will change 
this time.


> ---
> v1 -> v2: replace inode lock with invalidate lock
> 
>   fs/btrfs/volumes.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 13c514684cfb..68ff166fe445 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1364,7 +1364,9 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
>   				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>   	}
>   
> +	filemap_invalidate_lock(mapping);
>   	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> +	filemap_invalidate_unlock(mapping);
>   	if (IS_ERR(page))
>   		return ERR_CAST(page);
>   


