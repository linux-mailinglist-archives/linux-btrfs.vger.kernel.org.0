Return-Path: <linux-btrfs+bounces-7722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D79681FB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005AE1C22071
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536D187327;
	Mon,  2 Sep 2024 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZAWEKyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7C152E02;
	Mon,  2 Sep 2024 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265956; cv=none; b=aOnkAv5gvQWB/+M6eojRoz6CVrbnNX5cLTMgJ18s0RJLTg+NiBRi4T/cpA0zk1T5xnXDx0JLGvSb2+vxHHmJOwqquFFblNF317KUG/NrHZGOkQrmZplW8NSpkSrnm2PKvSHPvrOjQF0m7AhIwiEdGVSe/pWWtv9iGvwBm9DGSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265956; c=relaxed/simple;
	bh=7FZnShZRd0x2utlhzfu4Eekgm2UYIkwtTWtHyEwJbCE=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzAj6oEaYAq7G1e8ridVbhDhSup+bgdHZrVJNttLBxM9oJF2+FoeMBP/WV/TChwD+ksKYABLmDQqgE7/2KbpvIfPF9KcFHhMofJcKDlKXu7jkcNyyIumF7rJ70v+6eWIhLpDP3R+s2zd4ZtQq4OA00J2l/ZCn0qoOO+AmEwlPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZAWEKyQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb6d3e260so33984475e9.1;
        Mon, 02 Sep 2024 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725265952; x=1725870752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ad1s1rIxRrEpyNR3oCAjJRyVZo5P/SYBoOa1wy1w9IY=;
        b=EZAWEKyQv3kAGftIAS/0Zz4z0kFwz35XgdxDe9+yoj5c1zKOruThq6Au40g6NU2KYC
         KaDRdszJ8Qs2cBr/JyN42w4Og97iys0BNErXYLO+9FVVTyi6PHAZlkwLa3wwGQyZuFKI
         HmTSc696ZBmQuCJ+P9xI/+2OVyE+O+OML3KPZlkhZeJdW0JkBWkaHL7VGBZQQUmaPXv5
         etG4vp3qeK0fbEVR0Dcae9lPMSvdEBXOEeKod6Yy4lEchd+TeFzevRrlK96nvHkfdRD6
         hrKx3Yt5Jk/doZ2L+o2Ubnm0Pdj6mnoh23UQ1o0m82ysA4x9JZ2CS+KRYWyuIvLrMtPx
         mjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265952; x=1725870752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ad1s1rIxRrEpyNR3oCAjJRyVZo5P/SYBoOa1wy1w9IY=;
        b=jiGeKh6NQPxyFcpB4/SXCTMESW13GQ7/jU097PCAD+anBZieNX9dYFIm6X39G4t52O
         Hjvx54yKnVf44Bxemt4n2OoTP+dGZFl00PzN1ywQ2GxqBFo2ib4Yqq7ch8LB8S13zDnd
         R2FyhGtNKEX2Q0hR97r7rF8Ha4TT9xoWICKZXaFBlgiaTT3lmqeQJKgtcuauGVQLPqAb
         ju3M9PpHyUKH7XaelgjAVIhR3WUcPqsYkuxgOIUnM7KT/9S6N047Vsn/tV09ySoNd8V5
         04xMTaLWTNOY5lIFGdyDl6Am5JDVxME6qn1WEGxF1Qr1kmVvLO9HfZ51lbDCrNFARcyw
         r0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV985jpP2r40Nn1fHQ6NyVXGuAa2uShj+vO49JMTmt9oRAfmysNVtDy1M5dWutPaAN8unxObxtqujdq7g==@vger.kernel.org, AJvYcCXzpRSIoUn5gQDi8IfRCUiu1P3i4+F2xAuCCE1MlYWJOVWFPIPcWmrYIJkcq63+7DZ+F5Ln94kUz50qN9bl@vger.kernel.org
X-Gm-Message-State: AOJu0YymLafmOugEnAiJpajeC+yCw4DhPHWk0boGzRepeRKhA9NfHHFN
	HgbG3s7FVdPWdian7IrSYfGBg41k5rEyM6iM6U+xPeIxAWFTGxwg
X-Google-Smtp-Source: AGHT+IEjulrPxXagSdzHmKjzbaPPNUMTXjgMgxx3Uh7IpKhWHzGnSC0UqD2yzPPIO7H+U15+fEJ+fQ==
X-Received: by 2002:a05:600c:1d27:b0:428:9ba:39f with SMTP id 5b1f17b1804b1-42bdc6333bdmr47714375e9.11.1725265951883;
        Mon, 02 Sep 2024 01:32:31 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639643esm166587045e9.1.2024.09.02.01.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 01:32:31 -0700 (PDT)
Message-ID: <400d2855-59c2-47d2-9224-f76f219ae993@gmail.com>
Date: Mon, 2 Sep 2024 10:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Don't block system suspend during fstrim
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Any update on this? It's not critical but I'd like to know if it's in 
some part proper.
Thanks, Luca.
> Sometimes the system isn't able to suspend because
> the task responsible for trimming the device isn't
> able to finish in time.
>
> Since discard isn't a critical call it can be interrupted
> at any time, we can simply report the amount of discarded
> bytes in such cases and stop the trim.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
> I have no idea if that's correct, just something I implemented
> looking at the same solution made in ext4 by 5229a658f645.
>
> The patch in itself seems to solve the issue.
>
> repro is as follows:
> sudo /sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo --verbose --quiet-unsupported &
> sudo ./sleepgraph.py -m mem -rtcwake 5
>
> [836563.289069] PM: suspend exit
> [836563.909298] PM: suspend entry (s2idle)
> [836563.935447] Filesystems sync: 0.026 seconds
> [836563.951391] Freezing user space processes
> [836583.958957] Freezing user space processes failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=0):
> [836583.959582] task:fstrim          state:D stack:0     pid:241865 tgid:241865 ppid:241864 flags:0x00004006
> [836583.959592] Call Trace:
> [836583.959595]  <TASK>
> [836583.959600]  __schedule+0x400/0x1720
> [836583.959612]  ? mod_delayed_work_on+0xa4/0xb0
> [836583.959622]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959628]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959631]  ? blk_mq_flush_plug_list.part.0+0x1e3/0x610
> [836583.959640]  schedule+0x27/0xf0
> [836583.959644]  schedule_timeout+0x12f/0x160
> [836583.959652]  io_schedule_timeout+0x51/0x70
> [836583.959657]  wait_for_completion_io+0x8a/0x160
> [836583.959663]  submit_bio_wait+0x60/0x90
> [836583.959671]  blkdev_issue_discard+0x91/0x100
> [836583.959680]  btrfs_issue_discard+0xc4/0x140
> [836583.959689]  btrfs_discard_extent+0x241/0x2a0
> [836583.959695]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959702]  do_trimming+0xd2/0x240
> [836583.959712]  trim_bitmaps+0x350/0x4c0
> [836583.959723]  btrfs_trim_block_group+0xb8/0x110
> [836583.959729]  btrfs_trim_fs+0x118/0x440
> [836583.959734]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959738]  ? security_capable+0x41/0x70
> [836583.959746]  btrfs_ioctl_fitrim+0x113/0x180
> [836583.959752]  btrfs_ioctl+0xdaf/0x2670
> [836583.959759]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959763]  ? ioctl_has_perm.constprop.0.isra.0+0xd8/0x130
> [836583.959774]  __x64_sys_ioctl+0x94/0xd0
> [836583.959782]  do_syscall_64+0x82/0x160
> [836583.959790]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959793]  ? syscall_exit_to_user_mode+0x72/0x220
> [836583.959799]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959802]  ? do_syscall_64+0x8e/0x160
> [836583.959807]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959811]  ? do_sys_openat2+0x9c/0xe0
> [836583.959821]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959825]  ? syscall_exit_to_user_mode+0x72/0x220
> [836583.959828]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959832]  ? do_syscall_64+0x8e/0x160
> [836583.959835]  ? syscall_exit_to_user_mode+0x72/0x220
> [836583.959838]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959842]  ? do_syscall_64+0x8e/0x160
> [836583.959845]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959849]  ? do_syscall_64+0x8e/0x160
> [836583.959851]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959855]  ? do_syscall_64+0x8e/0x160
> [836583.959858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959861]  ? do_syscall_64+0x8e/0x160
> [836583.959864]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959868]  ? srso_alias_return_thunk+0x5/0xfbef5
> [836583.959873]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [836583.959878] RIP: 0033:0x7f3e4261af2d
> [836583.959944] RSP: 002b:00007ffec002f400 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [836583.959950] RAX: ffffffffffffffda RBX: 00007ffec002f570 RCX: 00007f3e4261af2d
> [836583.959952] RDX: 00007ffec002f470 RSI: 00000000c0185879 RDI: 0000000000000003
> [836583.959955] RBP: 00007ffec002f450 R08: 0000562d74da7010 R09: 00007ffec002e7f2
> [836583.959957] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562d74daafc0
> [836583.959960] R13: 0000000000000003 R14: 0000562d74daa970 R15: 0000562d74daad40
> [836583.959967]  </TASK>
> ---
>   fs/btrfs/extent-tree.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index feec49e6f9c8..7e4c1d4f2f7c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -16,6 +16,7 @@
>   #include <linux/percpu_counter.h>
>   #include <linux/lockdep.h>
>   #include <linux/crc32c.h>
> +#include <linux/freezer.h>
>   #include "ctree.h"
>   #include "extent-tree.h"
>   #include "transaction.h"
> @@ -6361,6 +6362,11 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
>   	unpin_extent_range(fs_info, start, end, false);
>   }
>   
> +static bool btrfs_trim_interrupted(void)
> +{
> +	return fatal_signal_pending(current) || freezing(current);
> +}
> +
>   /*
>    * It used to be that old block groups would be left around forever.
>    * Iterating over them would be enough to trim unused space.  Since we
> @@ -6459,8 +6465,8 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>   		start += len;
>   		*trimmed += bytes;
>   
> -		if (fatal_signal_pending(current)) {
> -			ret = -ERESTARTSYS;
> +		if (btrfs_trim_interrupted()) {
> +			ret = 0;
>   			break;
>   		}
>   
> @@ -6508,6 +6514,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	cache = btrfs_lookup_first_block_group(fs_info, range->start);
>   	for (; cache; cache = btrfs_next_block_group(cache)) {
> +		if (btrfs_trim_interrupted())
> +			break;
> +
>   		if (cache->start >= range_end) {
>   			btrfs_put_block_group(cache);
>   			break;
> @@ -6547,17 +6556,20 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
>   	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (btrfs_trim_interrupted())
> +			break;
> +
>   		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>   			continue;
>   
>   		ret = btrfs_trim_free_extents(device, &group_trimmed);
> +
> +		trimmed += group_trimmed;
>   		if (ret) {
>   			dev_failed++;
>   			dev_ret = ret;
>   			break;
>   		}
> -
> -		trimmed += group_trimmed;
>   	}
>   	mutex_unlock(&fs_devices->device_list_mutex);
>   

