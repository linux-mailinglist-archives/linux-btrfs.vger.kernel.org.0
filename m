Return-Path: <linux-btrfs+bounces-19658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A98CB6158
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 14:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4B1302488B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD623BD02;
	Thu, 11 Dec 2025 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="oA6Lhx6l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE62356D9
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460835; cv=none; b=pEiRU9bTlm3rOITfmfhc11XLMDa4rSoWfQGQO5vHmNxEQnYSz1tW+PL+5PlaPWBDmkh5tgOXcGm36O0oCxg2qMj9L/sEfOXmdw3D1hJzalC5RfzX29KYgNwz2/e1mKWKG+IjC/6iQdM0cPX843xeXXaBWjkzQnL+DSshNgDSUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460835; c=relaxed/simple;
	bh=iCGPDsnXLsQ1YX7OLoh/hePcEO1s84lPdtqQF7qDE40=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAYu/ATsqeGwVgESIuVFIMGWU31jSxpp2jK+yCuKDUQORvA7c0E17Ozfmye6fwoDcmxTGZ9Ztyd8HOt5mUx8jq9DD3/vqC6P+kF3wz0iLeNcwpPrs2unKr1O8F9S/CDAs6L2ax7LjIoPccm+dKvKbfZEdJFgV7p+6qjiRKihf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=oA6Lhx6l; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id CEFA8613E0
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 14:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1765460825; x=1767199626; bh=iCGPDsnXLs
	Q1YX7OLoh/hePcEO1s84lPdtqQF7qDE40=; b=oA6Lhx6l/YKHQZ8jLqetgfzaiQ
	HUv1S4AAp5R6AAQ3A/R/66/urjWnjY46L38ptwMa2CHL9YzovulkFHFbOwna8O//
	BwVLlb3cEp3a+SXLRr/vUrpAFTnUnik/gvqYY/PA9tKTDHEyiNYgK/029InIf8X5
	6cG9gQ1AzmYJRXvA2v69bhSZ4AFzXvBHAhu23z7TaRA14ydi1oxIh41IKHqaFSn1
	wakiA4zZ5UUseMHWB8MD3x1w8YV8EkQHYt79pfj1chid1cvilih4NYyL0qvq1SQ4
	GMWgzZ3lpFnlmBKRzGOpUJ3qFVCA+aZDr/TsAmCDC2+5Grw53MbSDghkgVZQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id ohxCEXMLkWUJ for <linux-btrfs@vger.kernel.org>;
 Thu, 11 Dec 2025 14:47:05 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Thu, 11 Dec 2025 14:47:05 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: command to list all devices of all filesystems?
Message-ID: <20251211134705.GA684677@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20251210175222.GA590927@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210175222.GA590927@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Wed 2025-12-10 (18:52), Ulli Horlacher wrote:

> Id there a command which lists all devices of all mounted filesystems?

I have now written lshd:

https://fex.belwue.de/linuxtools/bin/lshd

root@mux22:~# mount /dev/sda4 /mnt/sda4
root@mux22:~# mount /dev/sdb6 /mnt/sdb6
root@mux22:~# lshd
Device    Size Type        Label                     Mountpoint
sda       3.5T SAS:GPT     "NETAPP_X357_SLBPE3T8ATE"
 sda1       4M BIOS boot
 sda2    1016M vfat        "EFI"
 sda3      64G swap        "swap"
 sda4      64G btrfs       "M22"                     /mnt/sda4
 sda5      64G btrfs       "tmp"
 sda6     3.3T btrfs       "local"                   /mnt/sdb6
sdb       3.5T SAS:GPT     "NETAPP_X357_SLBPE3T8ATE"
 sdb1       4M BIOS boot
 sdb2    1016M vfat
 sdb3      64G swap
 sdb4      64G btrfs       "M22"                     /mnt/sda4
 sdb5      64G btrfs
 sdb6     3.3T btrfs       "local"                   /mnt/sdb6
sdc       3.5T SAS:GPT     "NETAPP_X357_SLBPE3T8ATE"
 sdc1       4M BIOS boot
 sdc2    1016M vfat
 sdc3      64G swap
 sdc4      64G Linux
 sdc5      64G btrfs
 sdc6     3.3T btrfs
sdd       3.5T SAS:GPT     "NETAPP_X357_SLBPE3T8ATE"
 sdd1       4M BIOS boot
 sdd2    1016M vfat
 sdd3      64G swap
 sdd4      64G btrfs
 sdd5      64G btrfs
 sdd6     3.3T btrfs
sde       1.8T ATA:DOS/MBR "ATA_SEAGATE_ST2000NM"
 sde1      32G swap        "swap"
 sde2      64G btrfs       "mux22"                   /
 sde3      64G ext4        "tmp"
 sde4     1.7T btrfs       "local"



In opposite:

root@mux22:~# lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT
NAME    SIZE FSTYPE LABEL MOUNTPOIN
sda     3.5T
|-sda1    4M
|-sda2 1016M vfat   EFI
|-sda3   64G swap   swap
|-sda4   64G btrfs  M22   /mnt/sda4
|-sda5   64G btrfs  tmp
`-sda6  3.3T btrfs  local /mnt/sdb6
sdb     3.5T
|-sdb1    4M
|-sdb2 1016M vfat
|-sdb3   64G swap
|-sdb4   64G btrfs  M22
|-sdb5   64G btrfs
`-sdb6  3.3T btrfs  local
sdc     3.5T
|-sdc1    4M
|-sdc2 1016M vfat
|-sdc3   64G swap
|-sdc4   64G
|-sdc5   64G btrfs
`-sdc6  3.3T btrfs
sdd     3.5T
|-sdd1    4M
|-sdd2 1016M vfat
|-sdd3   64G swap
|-sdd4   64G btrfs
|-sdd5   64G btrfs
`-sdd6  3.3T btrfs
sde     1.8T
|-sde1   32G swap   swap
|-sde2   64G btrfs  mux22 /
|-sde3   64G ext4   tmp
`-sde4  1.7T btrfs  local

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20251210175222.GA590927@tik.uni-stuttgart.de>

