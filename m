Return-Path: <linux-btrfs+bounces-7175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904A950E59
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 23:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299181C2353E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D51A7073;
	Tue, 13 Aug 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="AI7lqxSe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045B1A7064
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583243; cv=none; b=l6em15AkAKNi7x3HwMGLle56JbkxtsSliZj3oG6c60jLGZ6lOYQ8OimuaQWzdUgVUpropK1M67sE40MXN1GUvEhoUeNcmi3zJXAfKMTgamH+8RkipbeyZsjqPrhrvJME8OTf1sIGr1VV7l6HSfBdEsccLGSXvWvN/rS0S+ItCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583243; c=relaxed/simple;
	bh=2ip5q0E5qNU5z35Uw3dkGtIj8tBXtbbAMvbOGmiCZpw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hgGfm1GpulfXBf1BCzZMHcminCs2l0jbmrbo+vKVeoGy3noOoN+nBgFJL8IDPIoaNJVBp/32VzBrhK0rd/czr+K+aUSqToSUg2UI/Xi0YX/oSJI1tG//RNwAKXcWF1Cm5hTI15Ekh8RJzyGr8D0GgaYCAPB+tqEuld8LD7kbZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=AI7lqxSe; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:Subject
	:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sf6NbEWgZm0AbYX7KuoD2gEUQTqESFgtMG/K1uwnFCw=; b=AI7lqxSerIOXYa+CP+Oh1Thb3X
	HpQ+mniW7VKyE3dcEaerzw9ULJ8Uf1rOS/M4C+qvccOysuYPyLRQAN58FS+SNNlaL/HzZrYMox/Sl
	trz/tqLMTazfOdwl083Ci0frK3UJPsKtk8bpu3krXAzp547E/GNRxYHFxoW8xwdhoDSxPmF5rMGJM
	p40uMfxqljBm+Ei4QIA4xChoVyYTMFfw+tAcOcdD/0q2UBQoaWvnYIUjN5XWaSR4b2tdXBcWiRQHA
	iUOrgQUhD0AuANnThA96hV2A1yf8ojX/wauhWBvjyTCJvq7+manWQSjdwch2yQulr/w1gXFip/GiY
	Sa+Dbp2g==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1sdyjY-0002wG-7m
	for linux-btrfs@vger.kernel.org; Tue, 13 Aug 2024 21:07:14 +0000
Message-ID: <55c3f03d-a650-4193-8982-ffcb70575c2e@zetafleet.com>
Date: Tue, 13 Aug 2024 16:07:11 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Colin S <linux-btrfs-ml@zetafleet.com>
Subject: Needed improvements for raid1 integrity and availability
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001,T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no version=3.4.2

Dear maintainers,

As discussed in a previous episode 
<https://lore.kernel.org/linux-btrfs/ba51784b-ba20-4bf4-865a-2670a9ddde74@zetafleet.com/T/>, 
I experienced a single disk hardware failure on btrfs raid1. Ultimately 
I would give btrfs two stars out of five in its handling of this 
specific failure condition. The final situation is:

* I mainly used a third-party guide from Forza[0] because official docs 
do not describe all steps required to replace a failed disk (thanks, Forza!)
* I did not lose any data or have to rebuild filesystem (yay!), but I 
discovered that this is partly due to luck, rather than thanks to 
inherent safety of current btrfs implementation
* I experienced hours of downtime, despite the actual hardware 
replacement taking only 15 minutes, due to btrfs current design choice 
to not mount filesystem below minimum redundancy, lack of clarity 
regarding safety of repeated use of `-o degraded` and its interaction 
with systemd[1], and tool failures
* Docs and tools provided wrong/misleading/incomplete information 
multiple times throughout the process which caused confusion and 
required some leaps of faith that happened to work out OK
* Tools crashed or failed to work several times due to bugs

I will try to figure out how to report some of the specific tools issues 
separately before I forget them or lose records. Since the recovery 
environment was a bit behind the latest release (kernel 6.9.9, 
btrfs-progs 6.6.3), I suspect some things I encountered may be either 
duplicates of existing known issues, or things that got fixed in the 
very latest versions of the tools. This has been an exhausting process, 
so my tolerance to search for existing tickets is somewhat degraded, and 
I apologise in advance for this and will be delighted to hear “hey good 
news, that thing was already fixed, closing”.

To provide minimum equivalent integrity and availability guarantees to 
mdadm in this failure scenario, I would beg for prioritisation of these 
changes in btrfs, and links to any concrete planning 
info/timeline/tracker if they exist, in order of importance:

1. Implement some more traditional generational tracking that tracks 
device failures (or something smarter but equivalent), and prohibit 
auto-rejoining devices with mismatched generation until item (2) below 
is also implemented;

2. Add write-intent bitmap, so outdated devices can be guaranteed to 
receive correct data from healthy replicas when they are rejoined to 
filesystem and not be used as read sources for known missing data 
(currently, nodatasum files will read-balance to return garbage, as will 
datasum blocks with different data but checksum collision);

3. Make `btrfs replace` auto-rebalance back to intended redundancy 
profile (single -> raid1, raid1 -> raid1c3) upon device replace, instead 
of requiring manual rebalance of the reduced profile chunks created 
after `-o degraded` mount;

4. Temporarily auto-degrade redundancy profile (raid1c3 -> raid1, raid1 
-> single) to maintain uptime instead of forcing read-only when there is 
still at least one available copy of all the filesystem data (n.b. I am 
not 100% clear on what the current expected behaviour is, because 
degrading to read-only did not happen in my case; I assume this is only 
because dm-crypt left a dangling block device so btrfs didn’t know the 
hardware was gone; I did not end up with any single blocks on the 
filesystem until removing the unhealthy device and mounting with `-o 
degraded`, because the failed disk kept working after a reboot);

5. Add `btrfs device` subcommand to perform manual resilvering in case 
some error occurs with underlying storage layer that is opaque to btrfs 
(e.g. pvmove failure as described in [2]);

6. Add device subcommand to mark existing device as unusable/missing if 
it is flaky and the user needs/wants to do this.

I would also suggest stability status for raid1 should only be “mostly 
OK” in status page documentation until at least items 1 & 2 from above 
are implemented, since currently btrfs raid1 does not assure data 
integrity to the same level as mdadm raid1 in this common failure scenario.

I will try not to rehash many discussions, remarks, implementation 
approaches[3][4][5][6][7][8][9][10][11][12][13][14][15] from others who 
have experienced unexpected downtime or unexpected data loss due to 
current btrfs raid1 behaviour. I hope by giving this list of links it 
demonstrates the urgency of this problem and provides enough evidence to 
justify dedicating resources to the problem. Nominally I would try to 
assist but I am not enough of a domain expert to make meaningful code 
contributions, nor do I have the mental capacity to work on 
data-safety-critical systems.

Best regards,

[0] https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk
[1] https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk “Systemd may 
automatically unmount a filesystem from fstab if you manually mount it 
degraded!”
[2] https://github.com/kdave/btrfs-progs/pull/863#discussion_r1710574045
[3] https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg78254.html
[4] https://www.spinics.net/lists/linux-btrfs/msg124987.html
[5] https://github.com/kdave/btrfs-progs/issues/466
[6] https://github.com/kdave/btrfs-progs/pull/863#discussion_r1710328076
[7] https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg78254.html
[8] https://old.reddit.com/r/btrfs/comments/xki69r/nodatacow_and_data_loss/
[9] 
https://forums.unraid.net/topic/123037-reconsider-btrfs-nocow-default-option-on-domains-share-due-to-irrecoverable-corruption-risks/
[10] 
https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Gotchas.html#raid1_volumes_only_mountable_once_RW_if_degraded
[11] https://www.spinics.net/lists/linux-btrfs/msg124795.html
[12] 
https://old.reddit.com/r/btrfs/comments/1d6ddgn/unmountable_raid1_filesystem_after_removing_a/
[13] 
https://old.reddit.com/r/btrfs/comments/iktbkz/failed_raid1_array/g3nl4vl/
[14] https://github.com/kdave/btrfs-progs/issues/777
[15] https://www.axllent.org/docs/btrfs-raid1-recovery/ “Don't make the 
mistake I made”

