Return-Path: <linux-btrfs+bounces-21821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA7lDLj+mmlKpQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21821-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 14:03:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDAD16F1B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01A493012268
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2A258EE0;
	Sun, 22 Feb 2026 13:03:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42E19D074
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765424; cv=none; b=LBvhIl3qrGq95tMcAKopF8hZQjMnlMssY925u1dyWq7pgZHP4e1kATh243VAag1j5mx5y3Y+9qQw90VM0mxtbaEIcHsnd+X309iHOUd1rm/4oDsBUSj6BqnpYchPxnG8vBchIOa6So9YvfLo2HAOFL43m3r2pNIhLAHVjmUYGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765424; c=relaxed/simple;
	bh=b4U8oS6bL428EGZtA8TRci55LnLtZxZbxVLk4YBbAg4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Ge24pr7uaGIaT/1IeLa8ZqZjt2c+MBurlAO9oVeSyIksmJnNdzqcfNs9aUOnGDT3Mg5lfwgY71ej5FonuYeZCXaKxpzQotuuabgaN1W2GldJYAl8PR7rg8FfY4ENMFcx+6BYBvaVsIOLwZ1rgNHYojg6l/PqH8kbbyAzxewKmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e0a:156:6850:7018:89ff:fecb:6f21] (unknown [IPv6:2a01:e0a:156:6850:7018:89ff:fecb:6f21])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 26FFF19F73C
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 14:03:40 +0100 (CET)
Message-ID: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
Date: Sun, 22 Feb 2026 14:03:39 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phako <phako@free.fr>
Subject: Stuck on a BTRFS problem
To: linux-btrfs@vger.kernel.org
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[free.fr : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	TAGGED_FROM(0.00)[bounces-21821-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phako@free.fr,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDDAD16F1B3
X-Rspamd-Action: no action

Hello

I recently changed the 2x2TB disks I had on my NAS (hardware RAID) with 
2x16TB, after the migration (moved the data on an external HDD, then 
moved them back on the new system)
The actual configuration is a /dev/sda3 with a root and home subvolume.

The OS is a Debian 13 stable with running the 6.12.73+deb13-amd64 kernel

2 days after the migration I noticed that one disk of the RAID array had 
a enormous number of UDMA CRC errors (93976 errors), I then clean the 
connection of the cables and HDDs and the CRC errors stopped increasing.
But a couple of day later, when I ran a btrfs scrub I get 5 csum error 
on 1 file.
I blamed the very bad cabling problem during the sync of the array and 
the transfert of the data back and deleted the corrupted file and copy 
it back from the external HDD.
But 2 weeks later after another scrub a new file with 5 csum errors is 
detected, and it's on the same physical address (590581006336) but with 
a different logical address than the first one, but smart and the RAID 
controller don't report physical error.
I launched a full smart test (1 day long) on each disk to see if that 
trigger some error.
But for now I have a couple of question to try to go deeper to find the 
cause of the problem.
I deleted the file concerned by this last csum errors but when I run :

btrfs inspect-internal dump-tree --follow -b590581006336 /dev/sda3
btrfs-progs v6.14
checksum verify failed on 590581006336 wanted 0x2424c600 found 0x0456148c
ERROR: failed to read tree block 590581006336

Is there a way to ignore the csum error with the dump-tree function,

I guess that "590581006336" is the address of the block in bytes on 
sda3, right?

Is someone have an idea on how I could force BTRFS to rewrite this block 
or stop allocating it to data until I found the problem?


