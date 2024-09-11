Return-Path: <linux-btrfs+bounces-7926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B9974C32
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EE72828DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDB14AD20;
	Wed, 11 Sep 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="M0yLNKzW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E0154425
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042085; cv=none; b=YMTplTL3ggDNAesFPHCB5U8rWhRzED1cu1H1r9Yh+SVKLWjrvky+seYc3ipHcnnHQRTPG28DwHn9oDKm+IR2tOZCufbCy2ZWNLJtclfuf4DXfSkUNbaTzwiMax+qB3n7IVNxGNjXkNschg9I38yv0VnAUKdKsRNf7Hga7r5gpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042085; c=relaxed/simple;
	bh=yx6XipR7drNfwKzrffpb6Xc2CcdgCsjpcSLFQlxjPPQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ1bOQcMTiXrboKJEJf5pcjooyao0q7iqDcW6L1zgHFNYSbVV82N4jhvbSjnlcukOAv0yXRqLJ5Vml/gLyPgzTuNam5xVMYJ53aFavW3h5gw8E+ajD1MiSuApdef9Tt2pvcXpdyn39nbgEX5zbk7HvzAYvDNlzP83x7tTMBJKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=M0yLNKzW; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 98C4260DBB
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1726042075; x=1727780876; bh=yx6XipR7dr
	NfwKzrffpb6Xc2CcdgCsjpcSLFQlxjPPQ=; b=M0yLNKzWWbU9WDyAecnqstAl8V
	tFxaOFdbUmbsvt11yg38srf/MJWsKUogjEVO2aAOixwOft1XMMzlM/dNX/7QMF32
	Bqdy+OJ8ZUnHHRGFI2RBwPDRQufNVnCgXR8QwoTKLAME7kxEo6p8CawiAfyVkdno
	XfZp8zZcV+7qWT1yDU02d8D2Q48hZvz7CzaiyLTKTbvglhycX1E3rz7z9omBzMX6
	0qqch1ymPXEhCWnFiTMq86S+jIvQSOshzeDrdwpJalvebeWSBFqU4Z/B2y5wYco3
	q98cJkBm/qyHGfDTnDsnVDGTm8cQIcg87PeDqIQjDC/L/zjSebuv13JQf3bA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id jbTrtl11aiHu for <linux-btrfs@vger.kernel.org>;
 Wed, 11 Sep 2024 10:07:55 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 11 Sep 2024 10:07:55 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: Btrfs balance broke filesystem
Message-ID: <20240911080755.GB218002@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
 <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>
 <20240911080004.GA218002@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911080004.GA218002@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Wed 2024-09-11 (10:00), Ulli Horlacher wrote:

> I am using btrfs-balance.sh, which came originally with SLES 14. I have
> copied it to my Ubuntu systems, too.

Meanwhile it is available in Ubuntu, too, via package btrfsmaintenance:

root@fex:~# aptitude show btrfsmaintenance
Package: btrfsmaintenance
Version: 0.5-1
New: yes
State: not installed
Priority: optional
Section: universe/admin
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: all
Uncompressed Size: 70.7 k
Depends: btrfs-progs, systemd | cron
Enhances: btrfs-progs
Description: automate btrfs maintenance tasks on mountpoints or directories
 This is a set of scripts for the btrfs filesystem that automates the following maintenance tasks: scrub, balance, trim, and
 defragment.

 Tasks are enabled, disabled, scheduled, and customised from a single text file.  The default configuration assumes an installation
 profile where '/' is a btrfs filesystem.

 The default values have been chosen as an even compromise between time to complete maintenance, improvement in filesystem
 performance, and minimisation of resources taken from other processes.  Please note that I/O priority scheduling requires the use of
 BFQ or CFQ, and not noop, deadline, anticipatory, nor the new mq-deadline which uses blk-mq.
Homepage: https://github.com/kdave/btrfsmaintenance


At least I should replace my static ancient SLES 14 btrfsmaintenance
package with the official Ubuntu btrfsmaintenance package!


And I found:

From: David Sterba <dsterba@suse.cz>
To: linux-btrfs@vger.kernel.org
Subject: Btrfsmaintenance 0.5.2
Date: Thu, 4 Jul 2024 20:24:54 +0200

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240911080004.GA218002@tik.uni-stuttgart.de>

