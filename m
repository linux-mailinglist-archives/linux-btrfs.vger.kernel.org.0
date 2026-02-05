Return-Path: <linux-btrfs+bounces-21389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G6iJJKnhGmI3wMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21389-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 15:22:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E6F3E60
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA81E301CCC9
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD43EFD1E;
	Thu,  5 Feb 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="ZA84LuMz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A08632A
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301251; cv=none; b=BGZ8oqA09Eap2SgpDJDbGxSLRG3jMoVHtsFM3oGk0QNTVVT8yL6I932x1XXmRergEBBan7GALc2e6rJYsipYGlrVPr/M17+If/FxHp3QFNHlqCU7Gj1Gj5iJdGXo5swFq6710yZmoTxcWGLBNacHVmNj7XR8uVkLkolTXhQdFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301251; c=relaxed/simple;
	bh=z+S+Oh7dcZ25qOUrzBjYylJwQdyA7uSTjinNYhfcz28=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K1WXR+OlgSiHqNwJty1wSeuGlYUVbeOPi4qkRBjLV4V5Ff0wC6l+izuZ2PvLNXOMAdL2w3wt8fiTAkDczNtJHpgHC8Ts07GrL3kpBCl2jdb7UpDtp/pP1nEzEFagEFElQfWZmydC5izssYrA+Lxj2HhD95qsKwbExpQj3BxsDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=ZA84LuMz; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 9271A6119D
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Feb 2026 15:12:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=user-agent:content-disposition:content-type:content-type
	:mime-version:message-id:subject:subject:from:from:date:date; s=
	dkim; i=@rus.uni-stuttgart.de; t=1770300725; x=1772039526; bh=z+
	S+Oh7dcZ25qOUrzBjYylJwQdyA7uSTjinNYhfcz28=; b=ZA84LuMzlmaBK3IT6q
	IkLP/W0mPlPbQIWM+Y6vNU9pLscyu5ksjrCONxIqSkVMIFa8LEqrlN/34qDqY984
	eQs9xXk/mdy9ZF3SSNa5ps42q9bbOz9+pn2ISi0s4NyS4UDK+Jgm3tNT0iwQslLO
	oSBtOPm59X/x/fwIVcHYkOxbiVNdL2dmp2kFGy9kCOyFgY7POQgPxFzqrBK1O52+
	0gb9BVDP/w/Isgtjgjir3dX3b/FQoAI8ZR1yqSwmmDN9VuEqO/bXj3NX8dvdOM0t
	QGX9/ki7LVDlNEXZBHOrvy/VGifsUVOuBPPWAEwgdWLUnA2xK5mgucMFXZRPhrWf
	bQOg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id hUXJZWKOiH3y for <linux-btrfs@vger.kernel.org>;
 Thu,  5 Feb 2026 15:12:05 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Thu, 5 Feb 2026 15:12:05 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: critical target error?
Message-ID: <20260205141205.GA5656@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uni-stuttgart.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21389-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[uni-stuttgart.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[uni-stuttgart.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[framstag@rus.uni-stuttgart.de,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uni-stuttgart.de:email,uni-stuttgart.de:url,uni-stuttgart.de:dkim]
X-Rspamd-Queue-Id: DF9E6F3E60
X-Rspamd-Action: no action


After reboot I found in kern.log :

2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Very big device. Trying to use READ CAPACITY(16).
2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] 33951716474 512-byte logical blocks: (17.4 TB/15.8 TiB)
2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Write Protect is off
2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Mode Sense: 6d 00 00 00
2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Write cache: disabled, read cache: disabled, doesn't support DPO or FUA
2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Very big device. Trying to use READ CAPACITY(16).
2026-02-05 14:51:03 kernel: sd 3:0:0:0: [sdg] Attached SCSI disk
2026-02-05 14:51:03 kernel: BTRFS: device label spool devid 1 transid 50265 /dev/sdg scanned by mount (648)
2026-02-05 14:51:03 kernel: BTRFS info (device sdg): first mount of filesystem 68c59310-da6a-440e-bf26-5aae2f38c3f1
2026-02-05 14:51:03 kernel: BTRFS info (device sdg): using crc32c (crc32c-intel) checksum algorithm
2026-02-05 14:51:03 kernel: BTRFS info (device sdg): using free-space-tree
2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 Sense Key : Illegal Request [current] 
2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 Add. Sense: Invalid command operation code
2026-02-05 14:56:44 kernel: sd 3:0:0:0: [sdg] tag#88 CDB: Write same(16) 93 08 00 00 00 00 00 00 6a 18 00 00 01 e0 00 00
2026-02-05 14:56:44 kernel: critical target error, dev sdg, sector 27160 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0

A media error is highly implausible, because sdg is a ESX virtual disk on a
high redundant Netapp fileserver.
Maybe an internal btrfs problem?


root@fex:/var/log# grep sdg /proc/mounts 
/dev/sdg /spool btrfs rw,relatime,discard=async,space_cache=v2,user_subvol_rm_allowed,subvolid=5,subvol=/ 0 0

root@fex:/var/log# df -TH /spool/
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/sdg       btrfs   18T  105G   18T   1% /spool

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20260205141205.GA5656@tik.uni-stuttgart.de>

