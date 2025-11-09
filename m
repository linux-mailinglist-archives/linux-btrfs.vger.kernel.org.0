Return-Path: <linux-btrfs+bounces-18817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97207C447A5
	for <lists+linux-btrfs@lfdr.de>; Sun, 09 Nov 2025 22:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 203384E5951
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Nov 2025 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C1253B42;
	Sun,  9 Nov 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walkerstreet.info header.i=@walkerstreet.info header.b="Wzq9z5ox";
	dkim=pass (2048-bit key) header.d=walkerstreet.info header.i=@walkerstreet.info header.b="RXv6WGus"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38604230D0F
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Nov 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.68.200.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723093; cv=none; b=o/iSLyrVupqrK+WElg6yGOy2ugldhAl0M0/50wNH0G+7M2LW2WH/eqnM0NFB8iif5DL9UriB7UPxX3haqYWfCanfG8UCMeP6qYsSrGbKkrpR+0PZnoHfsgLHgyXGZI32QurLHnuqSDPKez44E9Q9dJ7yU6+L3tcrIEy9wc62iZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723093; c=relaxed/simple;
	bh=kKUrvjhlvKMDRCNilMGWqpaoCA90Gu6Z8iHQAeEa/5E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lhBVVZ+xGZR1buZZvnFONEc4hnBnAlpYcdsIdJd7jngQInbIcuSWw5a+THkW1FaCE3RycwwEiEiVfKH3F4G+yuQih2DWXD9++4+0DmG2bBkJmZ/epVsU2wAOhiYUnddH3zDItj2xpmg+8IK+e8R97vAdxZ+HYLrvo6wQu0TqghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=WalkerStreet.info; spf=pass smtp.mailfrom=WalkerStreet.info; dkim=pass (2048-bit key) header.d=walkerstreet.info header.i=@walkerstreet.info header.b=Wzq9z5ox; dkim=pass (2048-bit key) header.d=walkerstreet.info header.i=@walkerstreet.info header.b=RXv6WGus; arc=none smtp.client-ip=64.68.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=WalkerStreet.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=WalkerStreet.info
Received: from localhost (localhost [127.0.0.1])
	by mailout.easymail.ca (Postfix) with ESMTP id 34309640DC;
	Sun,  9 Nov 2025 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=walkerstreet.info;
	s=easymail; t=1762723084;
	bh=kKUrvjhlvKMDRCNilMGWqpaoCA90Gu6Z8iHQAeEa/5E=;
	h=Date:To:Cc:From:Subject:From;
	b=Wzq9z5ox5Lmcjw6wh+eSQLkbeQx0YND8S+dSG3slUd1sQo6DToNch4DfkAvf9D1Po
	 V0+FVfEGxNZm0M347rp4d1KCQJVj0WAak/6Sp7R7niO7LwRkzdhnOuvgVBDW9Zuf99
	 jUXF9S+WQ08gZwu4D4PyqnLYJpF6kDmj/bdHry20LBezv2vbGxL4nUSyldLLwbpglK
	 HaQ8ZHSjHX0EyQ7DnzakWt8K3vRmAioQXdAot0KjiyQM5GBTB8iqms6VuaXdA8HJe/
	 tcH9NwkIpBGE8mN/HJgda1qPP6Gvgevmqkv9p3224i965UwIIl/9g/9qDMHpChpCnK
	 zz0Z/7NC88ceQ==
X-Virus-Scanned: Debian amavisd-new at emo09-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
	by localhost (emo09-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NUcX91V6ELfO; Sun,  9 Nov 2025 21:18:02 +0000 (UTC)
Received: from [192.168.1.132] (142-254-41-58.dsl.dynamic.fusionbroadband.com [142.254.41.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout.easymail.ca (Postfix) with ESMTPSA id 9594364067;
	Sun,  9 Nov 2025 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=walkerstreet.info;
	s=easymail; t=1762723082;
	bh=kKUrvjhlvKMDRCNilMGWqpaoCA90Gu6Z8iHQAeEa/5E=;
	h=Date:To:Cc:From:Subject:From;
	b=RXv6WGus853uvrchurDZ/uZy6igihrWXmy+Wx+oHKGl3qOg+HnBx2Z4gzC9hIVeph
	 fb4hXFtOUvDnhyrJW17CVKqdNdrgzM8aNqWFSmmwz0SbmcOzWBlXnHgws8rjYG0Vi/
	 qTSnbHGvHzYL+3UAv0jEN63jdV1RwST6Nj36+mkIDaWJmeHZ2Zsnqx/LdndK5G1RVu
	 6lkmcuVq0j3b+b36hlVb9cLR5obfgcSweFr7xAieYkyk/joAojhzOY3osy1dfZeAzF
	 nPYxwJcRrLWzXvcOG9g0PeXpRqil3i6SUsczaVYNvmOUUzkxBnuGc8v07Odj+fIeLn
	 Of2kSdlemJxTA==
Message-ID: <1235e241-d53d-48e0-b9e4-f1c677df2a8e@WalkerStreet.info>
Date: Sun, 9 Nov 2025 13:18:01 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: David Walker <David@WalkerStreet.info>
From: David Walker <David@WalkerStreet.info>
Subject: qgroup marked inconsistent, qgroup info item update error -2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

For the past month or so, I’ve been getting the following pair of log 
entries about once an hour on a couple of my RPI4b’s running Tumbleweed, 
currently 20251022 (kernel 6.17.4-1).

|Nov 07 23:12:58 rpi4b.walkerstreet.info kernel: BTRFS warning (device 
sda2): qgroup marked inconsistent, qgroup info item update error -2 Nov 
07 23:12:58 rpi4b.walkerstreet.info kernel: BTRFS info (device sda2): 
qgroup scan completed (inconsistency flag cleared) |

Is this something I should be worried about? After doing some web 
searching 
(https://lore.kernel.org/linux-btrfs/511dad96b50657c84f9926a3a2d370419be93722.1749604913.git.wqu@suse.com/), 
it seems that there are conditions that can cause frequent 
inconsistencies that are fixed with a rescan (as indicated by the second 
log entry of the pair). As far as I can tell, I’m not seeing any ill 
effects.

I originally asked about this on openSUSE's forums 
(https://forums.opensuse.org/t/btrfs-qgroup-marked-inconsistent-qgroup-info-item-update-error-2/189586), 
and was referred here. One of the things I was asked for was what was 
running at the time this happened. It happens during an hourly cleanup 
of snapper snapshots:

|Nov 07 01:12:39 rpi4b.walkerstreet.info systemd[1]: Started Daily 
Cleanup of Snapper Snapshots. Nov 07 01:12:39 rpi4b.walkerstreet.info 
systemd[1]: Starting DBus interface for snapper... Nov 07 01:12:39 
rpi4b.walkerstreet.info systemd-timesyncd[627]: Contacted time server 
50.117.3.95:123 (2.opensuse.pool.ntp.org). Nov 07 01:12:39 
rpi4b.walkerstreet.info systemd[1]: Started DBus interface for snapper. 
Nov 07 01:12:39 rpi4b.walkerstreet.info systemd-helper[320190]: Running 
cleanup for 'root'. Nov 07 01:12:39 rpi4b.walkerstreet.info 
systemd-helper[320190]: Running number cleanup for 'root'. Nov 07 
01:12:51 rpi4b.walkerstreet.info kernel: BTRFS warning (device sda2): 
qgroup marked inconsistent, qgroup info item update error -2 Nov 07 
01:12:51 rpi4b.walkerstreet.info kernel: BTRFS info (device sda2): 
qgroup scan completed (inconsistency flag cleared) Nov 07 01:12:51 
rpi4b.walkerstreet.info systemd-helper[320190]: Running timeline cleanup 
for 'root'. Nov 07 01:12:51 rpi4b.walkerstreet.info 
systemd-helper[320190]: Running empty-pre-post cleanup for 'root'. Nov 
07 01:12:51 rpi4b.walkerstreet.info systemd-helper[320190]: Running 
'btrfs qgroup clear-stale /.snapshots'. Nov 07 01:12:51 
rpi4b.walkerstreet.info systemd[1]: snapper-cleanup.service: Deactivated 
successfully. Nov 07 01:13:52 rpi4b.walkerstreet.info systemd[1]: 
snapperd.service: Deactivated successfully. |

Also, I'm beginning to suspect that this may be associated with having 
run the following script after getting an ENOSPC error during one of 
Tumbleweed's regularly-scheduled btrfs-related maintenance processes. (I 
rarely need to do this.)

   sudo journalctl --vacuum-time=1years
   sudo btrfs balance start -dusage=0 /
   sudo btrfs balance start -dusage=5 /
   sudo btrfs balance start -dusage=10 /
   sudo btrfs balance start -dusage=20 /
   sudo btrfs balance start -dusage=30 /
   sudo btrfs balance start -dusage=50 /
   sudo btrfs balance start -dusage=80 /
   sudo btrfs balance start -dusage=100 /
   sudo btrfs balance start -musage=0 /
   sudo btrfs balance start -musage=5 /
   sudo btrfs balance start -musage=10 /
   sudo btrfs balance start -musage=20 /
   sudo btrfs balance start -musage=30 /
   sudo btrfs balance start -musage=50 /
   sudo btrfs balance start -musage=80 /
   sudo btrfs balance start -musage=100 /

For completeness, here is some more information I was requested to provide:

|> sudo btrfs qgroup show -c / Qgroupid Referenced Exclusive Child Path 
-------- ---------- --------- ----- ---- 0/5 16.00KiB 16.00KiB - 
<toplevel> 0/256 16.00KiB 16.00KiB - @ 0/257 7.61GiB 7.61GiB - @/var 
0/258 16.00KiB 16.00KiB - @/usr/local 0/259 16.00KiB 16.00KiB - @/srv 
0/260 88.34MiB 88.34MiB - @/root 0/261 4.82GiB 4.71GiB - @/opt 0/262 
5.96MiB 5.96MiB - @/boot/grub2/arm64-efi 0/263 224.00KiB 224.00KiB - 
@/.snapshots 0/840 9.48GiB 11.58MiB - @/.snapshots/555/snapshot 0/885 
9.41GiB 217.51MiB - @/.snapshots/600/snapshot 0/886 9.39GiB 496.00KiB - 
@/.snapshots/601/snapshot 0/887 9.39GiB 1.53MiB - 
@/.snapshots/602/snapshot 0/888 9.68GiB 2.59MiB - 
@/.snapshots/603/snapshot 0/889 9.68GiB 608.00KiB - 
@/.snapshots/604/snapshot 0/890 9.48GiB 768.00KiB - 
@/.snapshots/605/snapshot 1/0 13.40GiB 3.93GiB 
0/885,0/886,0/887,0/888,0/889,0/890 <0 member qgroups> > sudo btrfs 
subvolume list / ID 256 gen 2504609 top level 5 path @ ID 257 gen 
2562219 top level 256 path @/var ID 258 gen 2562040 top level 256 path 
@/usr/local ID 259 gen 2562044 top level 256 path @/srv ID 260 gen 
2562044 top level 256 path @/root ID 261 gen 2562219 top level 256 path 
@/opt ID 262 gen 2536414 top level 256 path @/boot/grub2/arm64-efi ID 
263 gen 2561278 top level 256 path @/.snapshots ID 840 gen 2562216 top 
level 263 path @/.snapshots/555/snapshot ID 885 gen 2535322 top level 
263 path @/.snapshots/600/snapshot ID 886 gen 2535328 top level 263 path 
@/.snapshots/601/snapshot ID 887 gen 2535338 top level 263 path 
@/.snapshots/602/snapshot ID 888 gen 2536290 top level 263 path 
@/.snapshots/603/snapshot ID 889 gen 2536305 top level 263 path 
@/.snapshots/604/snapshot ID 890 gen 2536404 top level 263 path 
@/.snapshots/605/snapshot|



