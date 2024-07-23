Return-Path: <linux-btrfs+bounces-6671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C593A9CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961D01F231C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9D1494BD;
	Tue, 23 Jul 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bZGTVV7c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EE28E8
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777103; cv=none; b=h1ZrtLtQtVdD0IXE/Yu0YEyyqipfgEZ4SwsE/zcfswGj+GkDnCowuF09lX+Je4LYr4Kun2YenDuwPwMAZ0xV1D5TWJw+vZFH18sLTz1gzQBfhWVjeVUy9R5WqnWLfTGPyDape98BeZuyOcH0xRXW/NHG9xWpDijx2jJFiGvxnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777103; c=relaxed/simple;
	bh=OPrkf8X+0mK7glC29dXSmgIqagmR2Oqm7QVtLNJNwgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g6xg5nOWpRlMSxM2UmF1e6MP1ijuB6sQBeMfgJBmuzruu5b3PbVZw85ev7XojUytXccIW4XmHCeu+SUZc8C6c+0cW5cpx2rU5SR4nHak1+dU8u8Z1Wys6XXfsi2iSEuQS47KYNmsEwEpOtclsJw1wq7QakEJ2jCBNggtaQZsvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bZGTVV7c; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36844375001so3470378f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721777100; x=1722381900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1e4aTU2KW9+kfgSisI6shJL80P6nl3Dr1UOjE4emRac=;
        b=bZGTVV7cGONrsBJgX3SaBQ51/TIKTtZ5BNC/k0F3cjNFzQKVVno5YSqfhgbcRKSEP4
         DnEzvykQ+rmX+S/KQtykcdzl1MeuxwHpDBGSjFOA/T2FRxRcxEwOGONZFZrZjR73C4fl
         QloxFrHgH6y8CMcuRDJCTQZ+/6kxN49rh+JTNeVCjz0PHZOAC+vf6P0TF31jtkC7KWes
         DxMXkRf2aW1LpTm6zXJ1dvOahTHFtF71Rfyo+q99CoaX8dB1d0JePYViUotrOgRCBMFr
         yM1R2YFrUxZJk2wXtry34cZ3z1dGSmv0pdKF8tIyLotmWFrZqYoJE+KoJa/HRhPnAoI1
         4psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721777100; x=1722381900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e4aTU2KW9+kfgSisI6shJL80P6nl3Dr1UOjE4emRac=;
        b=LeKwPt2woJSJ/yBoolxmKt/ApWOh7sFEo4CW62Qt4nAjjOTxWBG5Q0KdJkphQojKIJ
         J3+hzWIbmQMKPbwggGzWOKBjBhAXCv9NX0zH6DFHXfzkQDzWGbPCf0HbCFRU1UClsfo2
         1uml5nD1eOSVTGLWC27IiOsDec9zFYO0CR6Ho5bS8d4v1R9I17F/9f6YgW2K7kDfvmsG
         tauL7Fi9mV030mJGmH61fprLbg3Kjb4IemUyrrtWiAPuEmLfWQI+IpIhx5wGNutuoQPT
         WjYPy9prTxM8UgP0NV7DT+yHShBInXCSwzCuwov99rkeFRQg83tSnzZz9NneU4CQgOu3
         x5eA==
X-Forwarded-Encrypted: i=1; AJvYcCUGcxlaQ5OuE/hlmHEzBMapf9xzA/kk1ccW4pBDtD762+f7MXKNiXC30+nefd3S9RbjuId3vRwQLaQ3cQN2QfqY/yDNQnLsxi+XZlc=
X-Gm-Message-State: AOJu0YyKFJEYwXEaNDWM89z1eFgVRqKvjjJViDHjAYrF1il5c6AqJ6s+
	bhMqfmTG6lXja29NF0OePAL1EDPxv0clF5dRCQT48QYEkJPuMqQF9GwUPtauoF8=
X-Google-Smtp-Source: AGHT+IH9uoGN5DCr1iGFR2xYX5+xWfPCPfbwYviljGDUf52Q0BNq37YocQVb36HxvDo0tny6/5g06Q==
X-Received: by 2002:a05:6000:1189:b0:367:9625:bd05 with SMTP id ffacd0b85a97d-369f5b19eb4mr196799f8f.15.1721777099696;
        Tue, 23 Jul 2024 16:24:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1c909397sm4713659b3a.217.2024.07.23.16.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 16:24:59 -0700 (PDT)
Message-ID: <7235e04c-6c05-4f0e-b042-6296263166bb@suse.com>
Date: Wed, 24 Jul 2024 08:54:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: fix qgroup rsv leaks in cow_file_range
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1721775142.git.boris@bur.io>
 <81a472c49ed24d85ed3c164ac46b8d4e6cc9d1e1.1721775142.git.boris@bur.io>
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
In-Reply-To: <81a472c49ed24d85ed3c164ac46b8d4e6cc9d1e1.1721775142.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/24 08:25, Boris Burkov 写道:
> In the buffered write path, the dirty page owns the qgroup rsv until it
> creates an ordered_extent.
> 
> Therefore, any errors that occur before the ordered_extent is created
> must free that reservation, or else the space is leaked. The fstest
> generic/475 exercises various IO error paths, and is able to trigger
> errors in cow_file_range where we fail to get to allocating the ordered
> extent. Note that because we *do* clear delalloc, we are likely to
> remove the inode from the delalloc list, so the inodes/pages to not have
> invalidate/launder called on them in the commit abort path.
> 
> This results in failures at the unmount stage of the test that look like:
> 
> [ 1903.401193] BTRFS: error (device dm-8 state EA) in
> cleanup_transaction:2018: errno=-5 IO failure
> [ 1903.402686] BTRFS: error (device dm-8 state EA) in
> btrfs_replace_file_extents:2416: errno=-5 IO failure
> [ 1903.446415] BTRFS warning (device dm-8 state EA): qgroup 0/5 has
> unreleased space, type 0 rsv 28672
> [ 1903.447887] ------------[ cut here ]------------
> [ 1903.448645] WARNING: CPU: 3 PID: 22588 at fs/btrfs/disk-io.c:4333
> close_ctree+0x222/0x4d0 [btrfs]
> [ 1903.450130] Modules linked in: btrfs blake2b_generic libcrc32c xor
> zstd_compress raid6_pq
> [ 1903.451408] CPU: 3 PID: 22588 Comm: umount Kdump: loaded Tainted: G
> W          6.10.0-rc7-gab56fde445b8 #21
> [ 1903.453058] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [ 1903.454542] RIP: 0010:close_ctree+0x222/0x4d0 [btrfs]
> [ 1903.455417] Code: 4d c0 48 c7 c6 a0 92 4d c0 48 c7 c7 78 82 4d c0 e8
> 63 22 36 d7 90 0f 0b f0 80 4b 10 02 48 89 df e8 33 dc fb ff 84 c0 74 13
> 90 <0f> 0b 90 48 c7 c6 c8 92 4d c0 48 89 df e8 0c 22 01 00 48 89 df e8
> [ 1903.458317] RSP: 0018:ffffb4465283be00 EFLAGS: 00010202
> [ 1903.459159] RAX: 0000000000000001 RBX: ffffa1a1818e1000 RCX:
> 0000000000000001
> [ 1903.460286] RDX: 0000000000000000 RSI: ffffb4465283bbe0 RDI:
> ffffa1a19374fcb8
> [ 1903.461408] RBP: ffffa1a1818e13c0 R08: 0000000100028b16 R09:
> 0000000000000000
> [ 1903.462555] R10: 0000000000000003 R11: 0000000000000003 R12:
> ffffa1a18ad7972c
> [ 1903.463679] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [ 1903.464803] FS:  00007f9168312b80(0000) GS:ffffa1a4afcc0000(0000)
> knlGS:0000000000000000
> [ 1903.466082] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1903.467004] CR2: 00007f91683c9140 CR3: 000000010acaa000 CR4:
> 00000000000006f0
> [ 1903.468124] Call Trace:
> [ 1903.468548]  <TASK>
> [ 1903.468890]  ? close_ctree+0x222/0x4d0 [btrfs]
> [ 1903.469689]  ? __warn.cold+0x8e/0xea
> [ 1903.470260]  ? close_ctree+0x222/0x4d0 [btrfs]
> [ 1903.471052]  ? report_bug+0xff/0x140
> [ 1903.471646]  ? handle_bug+0x3b/0x70
> [ 1903.472212]  ? exc_invalid_op+0x17/0x70
> [ 1903.472838]  ? asm_exc_invalid_op+0x1a/0x20
> [ 1903.473518]  ? close_ctree+0x222/0x4d0 [btrfs]
> [ 1903.474283]  generic_shutdown_super+0x70/0x160
> [ 1903.475005]  kill_anon_super+0x11/0x40
> [ 1903.475630]  btrfs_kill_super+0x11/0x20 [btrfs]
> [ 1903.476405]  deactivate_locked_super+0x2e/0xa0
> [ 1903.477125]  cleanup_mnt+0xb5/0x150
> [ 1903.477699]  task_work_run+0x57/0x80
> [ 1903.478267]  syscall_exit_to_user_mode+0x121/0x130
> [ 1903.479056]  do_syscall_64+0xab/0x1a0
> [ 1903.479658]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 1903.480467] RIP: 0033:0x7f916847a887
> [ 1903.481034] Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44
> 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 71 25 0d 00 f7 d8 64 89 02 b8
> [ 1903.483951] RSP: 002b:00007ffe035d1648 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a6
> [ 1903.485153] RAX: 0000000000000000 RBX: 000056074eba0508 RCX:
> 00007f916847a887
> [ 1903.486244] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 000056074eba0810
> [ 1903.487128] RBP: 0000000000000000 R08: 00007ffe035d03f0 R09:
> 0000000000000001
> [ 1903.488010] R10: 0000000000000103 R11: 0000000000000246 R12:
> 00007f91685cc22c
> [ 1903.488905] R13: 000056074eba0810 R14: 0000000000000000 R15:
> 000056074eba0400
> [ 1903.489792]  </TASK>
> [ 1903.490071] ---[ end trace 0000000000000000 ]---
> [ 1903.490657] BTRFS error (device dm-8 state EA): qgroup reserved space leaked
> 
> Cases 2 and 3 in the out_reserve path both pertain to this type of leak
> and must free the reserved qgroup data. Because it is already an error
> path, I opted not to handle the possible errors in
> btrfs_free_qgroup_data.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c5155981f99a..06337aee856a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1581,6 +1581,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   					     locked_page, &cached,
>   					     clear_bits,
>   					     page_ops);
> +		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
>   		start += cur_alloc_size;
>   	}
>   
> @@ -1594,6 +1595,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   		clear_bits |= EXTENT_CLEAR_DATA_RESV;
>   		extent_clear_unlock_delalloc(inode, start, end, locked_page,
>   					     &cached, clear_bits, page_ops);
> +		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
>   	}
>   	return ret;
>   }
> @@ -2255,6 +2257,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
>   					     PAGE_START_WRITEBACK |
>   					     PAGE_END_WRITEBACK);
> +		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
>   	}
>   	btrfs_free_path(path);
>   	return ret;

