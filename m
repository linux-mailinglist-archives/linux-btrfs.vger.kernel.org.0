Return-Path: <linux-btrfs+bounces-70-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3C7E8056
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Nov 2023 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DADBB20E85
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Nov 2023 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8873A285;
	Fri, 10 Nov 2023 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00163B4
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 18:09:19 +0000 (UTC)
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 10:08:48 PST
Received: from freki.datenkhaos.de (freki.datenkhaos.de [81.7.17.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E06B7709
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 10:08:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by freki.datenkhaos.de (Postfix) with ESMTP id AD2CD27195E5
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 19:00:34 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
	by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oUOVnJG0s8oZ for <linux-btrfs@vger.kernel.org>;
	Fri, 10 Nov 2023 19:00:34 +0100 (CET)
Received: from [192.168.10.6] (dynamic-077-183-024-204.77.183.pool.telefonica.de [77.183.24.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by freki.datenkhaos.de (Postfix) with ESMTPSA
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 19:00:34 +0100 (CET)
Message-ID: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
Date: Fri, 10 Nov 2023 19:00:33 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
Subject: checksum errors but files are readable and no disk errors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I have a server with two 2T-disks that were running in a Btrfs-RAID1 
setup. Recently I was running into the bug of btrfs-progs-6.6, so the 
system didn't boot anymore. Because I don't have physical access to the 
system, the only option I've had was a hard reset  remotely. After this 
I noticed several checksum errors during scrub on different files. I was 
able to delete those files, but the checksum errors persisted, now 
without any file associated. In the end, I removed one disk (sdb1) from 
the RAID. Because relocation doesn't work with checksum errors, I've 
overwritten the first 10M of the partition and mounted the remaining 
disk (sda1) degraded. After this, I created a new filesystem on sdb1 
andI synced the whole sda1 to sdb1 via rsync. This worked without any 
problems, although sda1 still shows the checksum errors. I'm running the 
system from the second disk now with the newly created filesystem. But 
now this FS shows checksum errors again. Two files are affected, both 
are images for virtual servers. I'm able to read both files, I can copy 
via dd without any error. But scrub says, there are checksum errors:

[52622.939071] BTRFS error (device sdb1): unable to fixup (regular) 
error at logical 1673331802112 on dev /dev/sdb1 physical 1648107257856
[52622.939189] BTRFS warning (device sdb1): checksum error at logical 
1673331802112 on dev /dev/sdb1, physical 1648107257856, root 1117, inode 
832943, offset 566788096, length 4096, links 1 (path: 
var/lib/libvirt/images/vserv03.img)
[54629.309530] BTRFS error (device sdb1): unable to fixup (regular) 
error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
[54629.309656] BTRFS warning (device sdb1): checksum error at logical 
2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode 
832950, offset 9149956096, length 4096, links 1 (path: 
var/lib/libvirt/images/vserv06.img)
[54629.309666] BTRFS error (device sdb1): unable to fixup (regular) 
error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
[54629.309719] BTRFS warning (device sdb1): checksum error at logical 
2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode 
832950, offset 9149956096, length 4096, links 1 (path: 
var/lib/libvirt/images/vserv06.img)
[54760.218254] BTRFS info (device sdb1): scrub: finished on devid 1 with 
status: 0

So what is going on here? I'm planning to recreate the RAID1, but with 
with checksum errors I don't want to go on. System is running kernel 
6.5.11.


regards,
   Johannes


