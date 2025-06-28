Return-Path: <linux-btrfs+bounces-15061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76EDAEC97D
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 19:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50CF16E56A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060C2417C2;
	Sat, 28 Jun 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="h3u8xHO2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB721A704B
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Jun 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751132002; cv=none; b=LrX2jbCQk2qtTH41Ml9rZP21vYjEzPmj82UWZnvq2lZ0RAweoE/wMnhcz7oqwJe9IkHfow6r/C8Qjm1zHk3qtCbM9r8r0pvVKW3Agw/5I/Qx1EV8yienpfSqk+4ACQZBA2/iJgmk4h0+bmdJmAGUl3Pxc2RiimNscm/chtF2OcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751132002; c=relaxed/simple;
	bh=wR75pEMQo30/Zb7LLO9hB3mkw31joPUi+WAG6SgpyV4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oqo0bQPNwGjQ7ZiLQXanfUGP+bEIySHln9phg3OaEpYLOa8lZiE4FY8rhk9l7vcX0VoXS836cuTUAD6/Nc5Ig1CeuJ5wt+sNjUByrHxG+ZKH9FgyvUTh/eD1sHFQi5nDjstkL7HMCy2QpGu6Q2tiqPewOjGY94RB7Gpxr8lTaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=h3u8xHO2; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id E6D6060C0A
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Jun 2025 19:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1751131989; x=
	1752870790; bh=wR75pEMQo30/Zb7LLO9hB3mkw31joPUi+WAG6SgpyV4=; b=h
	3u8xHO2IH14zk/1eH+aNESMcPtXmW1BOWp+MN1fROA9H7ps334Pvl1QFjWSWKp3T
	/hK1NRUTCAg6oqYBLg2iaCAXvYrPA4Xaa11VgV2N8EdXJ9awpyUHxz+RrG3EvKI/
	i5xFFvroqOiKw6uOIFmiVjukX73B7sGL0o6n7EePcvPjObMDbEFmuaNY03eIVINk
	YA9bb60M67WwCYpss1TMD3WLJP1Z4Qn+P8zc1x6H+Ahk9LXlZhXBGylNkXMzwpmt
	5PC17MKoWPfJewLdPe+kE9HQlcXdeeJZWRlVY2Tq3xIxTRzYypKRcc9vopHmCzBw
	JOdzVqjzHOQ6iBFne76vQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id ZTj71NqaFlxA for <linux-btrfs@vger.kernel.org>;
 Sat, 28 Jun 2025 19:33:09 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Sat, 28 Jun 2025 19:33:08 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: restic backup with btrfs /
Message-ID: <20250628173308.GB847325@tik.uni-stuttgart.de>
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
X-Mailer: smtpsend-20240729

restic (https://restic.net/) is a great backup tool but has some
limitations or design flaws: one is, it believes that any subvolume is on a
different filesystem. This means: "restic backup --one-file-system /" will
only backup the root subvolume, but no other subvolumes like /home
/var/spool etc... 

One has to add every subvolume to the argument list. Bad if you 
create new subvolumes and forget to update the backup cronjob.
When you later need to restore a file, there will be none...

My idea is now: I do not backup the original /, but do:

mount --bind / /backup/restic
restic backup /backup/restic
umount /backup/restic

Next evolution step: 
I could recursivly mount-bind other filesystems into /backup/restic/
For example:

mount --bind /local /backup/restic/local
mount --bind /data /backup/restic/ldata

That I would have a "all in one backup".

What do you think of this idea?

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250628173308.GB847325@tik.uni-stuttgart.de>

