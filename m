Return-Path: <linux-btrfs+bounces-3220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED987925A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C933CB2110D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C877655;
	Tue, 12 Mar 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="wu3gF9SN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366B59147
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240296; cv=none; b=dHXDtvuvRiDa9Dyl4ZG0C/0+rNeE+t0k4xzjuWWJHapIXh8wqjKZMPhroOXNyYAGrvIwNY/g+NIvETCfoFxDklGkMQAYja0UNq6vF90ULHmoMwwBNen5jkPMJLZ/D+DD8RIPZ+vl6EGDJszpPS03Kg1vNdW/XDvzmgUZL079YM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240296; c=relaxed/simple;
	bh=ZWJFt9ArA4iplleYU0mIx7skKLELMaKDxiFxsDWlCbI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JkYFXu1q0G/41MytIpQUDSRmaRzUlBY1hd2+HRf1RPVZdbVCQ7OvgxdWCnA9vb9FQZNOrkxWvcM3rb2A5VeiLNqdWmT4kKpOTTi+4wgCoHi3Cyw32p3HU+8jzuKK9d+phPdZuOS34tF0z89Q4C8fTx7eE1DBLbesg8U3qBCIwTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=wu3gF9SN; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 73F8460C7F
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 11:39:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1710239958; x=
	1711978759; bh=ZWJFt9ArA4iplleYU0mIx7skKLELMaKDxiFxsDWlCbI=; b=w
	u3gF9SN3+67aaIg/BwlcM6iFxlE7dghGbMIauSJu0dTCnjHquOlViq6q+9tqi4zC
	blvZh3edZyDGxGgjqx2l992eGyjC91iDDjNK/dHgAce7Fg0swu4A7vmxRZCNskQZ
	xtOkgYFcVfMB05rQjfme2yknTcH9l+PYpIsg/YkqM8PAiIGebUfF/nlEsIJm1HmB
	dCUAG+BYgnIrM7CwX5uOdNF3dq55yi/kFwqUrdn2yXeXWYzboQ1ymU16kS6Jq0ag
	eq/LiMsNlFi/hfZFr/FpmdN39vQEvtZFAX9BXxitohx7U34g6dlkvnsUx3So4w6x
	anh8asj2XXwCGIHYDhb/w==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id cdT-gwx_zhQo for <linux-btrfs@vger.kernel.org>;
 Tue, 12 Mar 2024 11:39:18 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Tue, 12 Mar 2024 11:39:18 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: mount ... or other error?
Message-ID: <20240312103918.GA374710@tik.uni-stuttgart.de>
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
X-Mailer: smtpsend-20230822


I have (on Ubuntu 22.04):

root@fextest:~# lsblk -o NAME,SIZE,FSTYPE,LABEL /dev/sdd
NAME    SIZE FSTYPE LABEL
sdd    13.5T
`-sdd1 13.5T btrfs  spool

root@fextest:~# blkid | grep sdd1
/dev/sdd1: LABEL="spool" UUID="4d8b313d-5710-406b-bdba-b01625bf45ef" UUID_SUB="a57d255f-24af-4562-9421-a1eb6e76c051" BLOCK_SIZE="4096" TYPE="btrfs" PARTUUID="a409c49c-2b2d-654f-a0aa-9d0b5ea4307f"

root@fextest:~# file -s /dev/sdd1
/dev/sdd1: BTRFS Filesystem label "spool", sectorsize 4096, nodesize 16384, leafsize 16384, UUID=4d8b313d-5710-406b-bdba-b01625bf45ef, 223643512832/44530217717760 bytes used, 3 devices

root@fextest:~# mount -t btrfs /dev/sdd1 /mnt/tmp
mount: /mnt/tmp: wrong fs type, bad option, bad superblock on /dev/sdd1, missing codepage or helper program, or other error.

How can I debug this further?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240312103918.GA374710@tik.uni-stuttgart.de>

