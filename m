Return-Path: <linux-btrfs+bounces-7082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D08194DAEA
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 07:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2AB1F2222C
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 05:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F34642D;
	Sat, 10 Aug 2024 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XVlnXFg0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D8107A0;
	Sat, 10 Aug 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268206; cv=none; b=bvxIt+uOkYNf8XfIJA+PxmS4hlskm3L5yTdSHm06sxlh4euAi8JKBw/Gp5xOBp69XqpX1W4NF/rQqgZqP8SfV/IbUs+CzkgFkhKhGTRSi50rlTZhLLzihtkd9UbfJyPHkrpGMxdKG3injY+AK7SsE3gggHrU2yumlVPrzRIySyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268206; c=relaxed/simple;
	bh=t4qDXuJ3LWu7+c88bMi8bdmGb/8sdDFS6TnXOjpDKPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Bl2Tu/RBgOvD2LpjUEkVriLOlbbWxC+dpdIndmBt2G6PqIs8e6b41bA6n4nX/huL+GigABbFofNG9t6eHAsqnua+qWwL1cY9aDmDCLKYqGCSFm6hq1lBtjH0FVCLaZ9BjAXfckrubes5vagCY8hlmteVk95NXhdfsOohARifZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XVlnXFg0; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=PJAH/CyktIH57Dj1P/inZNXFX+n40cLs0bpRdnjZKo0=;
	t=1723268204; x=1723700204; b=XVlnXFg0ZlPTLukxDhGM4SoTabQJmjidKbqBzJCp+FgxrG9
	yfkuxBbf2PPbTyrufw2furbfQfEmkaDhSi+Cps3GSO8GoZSOHWgH178i+UzLf/Il832bMsslrfW7Z
	2I6f7IE0gWetg7raBSiJJ/WcKxUu+8scw45X9bCxQbj4RtPj3899Z/TruqHImC3Y0eHEBL20fNfWA
	ZhE1ucugFeKA6YOtrqu5joLYLSJDCHnGpN2KvSx0Zvf5dOdqgmOAiH01GG/V319MD0vm3tK/Kqfgj
	8E6pAR0He+u/0alYwo6DtpGdPVpkkxyjlk6qkZF4Bx8Rovrb433M9XT+K+O0tOdQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1scemI-0000NC-UF; Sat, 10 Aug 2024 07:36:35 +0200
Message-ID: <3b3262d9-5383-494e-a19b-698a9e289c2c@leemhuis.info>
Date: Sat, 10 Aug 2024 07:36:34 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bisected Regression: Cache filling up causing drastic performance
 degradation on Linux 6.10.3
To: Filipe Manana <fdmanana@suse.com>,
 Abhinav Praveen <abhinav@praveen.org.uk>
References: <f43jqpkjg7gehwtskurg5ze6omkcldme62u32ftsht32xevc5y@sdnm66w24ins>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
Cc: regressions@lists.linux.dev, linux-btrfs <linux-btrfs@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
In-Reply-To: <f43jqpkjg7gehwtskurg5ze6omkcldme62u32ftsht32xevc5y@sdnm66w24ins>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723268204;b50555c4;
X-HE-SMSGID: 1scemI-0000NC-UF

On 10.08.24 02:28, Abhinav Praveen wrote:
> I recently ran into an IO/Memory Management issue and posted about it on
> the linux-mm mailing list here:
> https://marc.info/?l=linux-mm&m=172306192530745&w=2
> 
> I have since bisected with mainline and found that:
> 956a17d9d050761e34ae6f2624e9c1ce456de204 is the first bad commit

TWIMC, that is 956a17d9d05076 ("btrfs: add a shrinker for extent maps")
[v6.10-rc1]

Adding Filipe and the Btrfs folks to the list of recipients.

Abhinav: thx for the report. There are at least two other discussion
ongoing about what to my untrained eyes look like similar problems that
remain after the fixes than went into 6.10 right before the release. You
might want to consult them:

https://lore.kernel.org/all/CAHPNGSSt-a4ZZWrtJdVyYnJFscFjP9S7rMcvEMaNSpR556DdLA@mail.gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=219121

Ciao, Thorsten

> The issue is present on mainline commit:
> 58d40f5f8131479a1e688828e2fa0a7836cf5358 (Fri Aug 9 10:23:18 2024)
> 
> The bisect log is below:
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [58d40f5f8131479a1e688828e2fa0a7836cf5358] Merge tag 'asm-generic-fixes-6.11-2' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
> git bisect bad 58d40f5f8131479a1e688828e2fa0a7836cf5358
> # status: waiting for good commit(s), bad commit known
> # good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
> git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> # bad: [3e334486ec5cc6e79e7b0c4f58757fe8e05fbe5a] Merge tag 'tty-6.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect bad 3e334486ec5cc6e79e7b0c4f58757fe8e05fbe5a
> # bad: [d34672777da3ea919e8adb0670ab91ddadf7dea0] Merge tag 'fbdev-for-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
> git bisect bad d34672777da3ea919e8adb0670ab91ddadf7dea0
> # bad: [b850dc206a57ae272c639e31ac202ec0c2f46960] Merge tag 'firewire-updates-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394
> git bisect bad b850dc206a57ae272c639e31ac202ec0c2f46960
> # good: [59729c8a76544d9d7651287a5d28c5bf7fc9fccc] Merge tag 'tag-chrome-platform-for-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
> git bisect good 59729c8a76544d9d7651287a5d28c5bf7fc9fccc
> # good: [101b7a97143a018b38b1f7516920a7d7d23d1745] Merge tag 'acpi-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 101b7a97143a018b38b1f7516920a7d7d23d1745
> # good: [47e9bff7fc042b28eb4cf375f0cf249ab708fdfa] Merge tag 'erofs-for-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
> git bisect good 47e9bff7fc042b28eb4cf375f0cf249ab708fdfa
> # bad: [b2665fe61d8a51ef70b27e1a830635a72dcc6ad8] Merge tag 'ata-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
> git bisect bad b2665fe61d8a51ef70b27e1a830635a72dcc6ad8
> # bad: [aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2] btrfs: handle errors in btrfs_reloc_clone_csums properly
> git bisect bad aa5ccf29173acfaa8aa2fdd1421aa6aca1a50cf2
> # good: [d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028] btrfs: embed data_ref and tree_ref in btrfs_delayed_ref_node
> git bisect good d3fbb00f5e21c6dfaa6e820a21df0c9a3455a028
> # good: [5fa8a6baff817c1b427aa7a8bfc1482043be6d58] btrfs: pass the extent map tree's inode to try_merge_map()
> git bisect good 5fa8a6baff817c1b427aa7a8bfc1482043be6d58
> # bad: [9a7b68d32afc4e92909c21e166ad993801236be3] btrfs: report filemap_fdata<write|wait>_range() error
> git bisect bad 9a7b68d32afc4e92909c21e166ad993801236be3
> # bad: [85d288309ab5463140a2d00b3827262fb14e7db4] btrfs: use btrfs_get_fs_generation() at try_release_extent_mapping()
> git bisect bad 85d288309ab5463140a2d00b3827262fb14e7db4
> # bad: [65bb9fb00b7012a78b2f5d1cd042bf098900c5d3] btrfs: update comment for btrfs_set_inode_full_sync() about locking
> git bisect bad 65bb9fb00b7012a78b2f5d1cd042bf098900c5d3
> # bad: [956a17d9d050761e34ae6f2624e9c1ce456de204] btrfs: add a shrinker for extent maps
> git bisect bad 956a17d9d050761e34ae6f2624e9c1ce456de204
> # good: [f1d97e76915285013037c487d9513ab763005286] btrfs: add a global per cpu counter to track number of used extent maps
> git bisect good f1d97e76915285013037c487d9513ab763005286
> # first bad commit: [956a17d9d050761e34ae6f2624e9c1ce456de204] btrfs: add a shrinker for extent maps
> 
> The original issue (from my previous post) is as follows:
> 
> If I read from my Steam Library (this has about 430GiB of data), stored on an
> ext4 formatted NVMe drive like this:
> 
> find /mnt/SteamLibrary/steamapps/common -type f -exec cat {} + -type f | pv >
> /dev/null
> 
> I see that it initially starts reading at 800MiB/s (6.4 Gbps) then, once my
> cache fills up (as shown by buff/cache in free), the read speed drops to as low
> as 6MiB/s (48 Mbps) but periodically returns to 800MiB/s as the cache gets
> freed.
> 
> When the cache fills, other tasks are also affected (e.g video playback
> stutters or stops). I also see high CPU usage from kswapd0 and btrfs-cleaner
> (which is strange because, again, it's an ext4 filesystem that I'm reading
> from) using top.
> 
> Running echo 1 > /proc/sys/vm/drop_caches immediately improves performance.
> 
> But, instead, if I run the same read command in a Memory cgroup with memory.max
> set to 500M, I get a solid 800MiB/s read speed without filling up the cache or
> affecting other tasks.
> 
> TL;DR simply reading files seems to be enough to cause major system-wide
> performance degradation. This also applies when updating games on Steam or
> moving them between Library locations.
> 
> Anyone know if this is a bug or regression in Linux 6.10? Or whether there are
> any tunables or Sysctls that could improve performance without manually running
> things in CGroups?
> 
> This happens on a AMD 7950X3D with 96GB of ram.
> 
> I describe the same thing on my post at:
> https://www.reddit.com/r/linuxquestions/comments/1emetro/cache_filling_up_causing_drastic_performance/
> 
> It also seems that someone else has experienced something similar here*:
> https://www.reddit.com/r/linuxquestions/comments/1e83ltj/610_disk_caching_vs_memory_exhaustion_issues/
> 
> *Their issue seems to have been resolved by 6.10.2 however.

