Return-Path: <linux-btrfs+bounces-5876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85712911C63
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 09:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F8DB21C05
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EECC167D98;
	Fri, 21 Jun 2024 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="R4eEdYUS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F6167D8C
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953451; cv=none; b=IM3zNmfHx7Jc9Ms3SyQ/fT53oSj1QOeTGI1KzknH4CqTKUf/ThCiAMoC3qsJGXSNecex2wRdZ7sI0Y0YxzVoUSl4QcZpwaR3mSXNBaShcDdgUzqGz29qYsF23ChhOiW2HvaL0VFC7JzWAKhwRTZ/waAGLSxwgLSB0yv6MGPXICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953451; c=relaxed/simple;
	bh=BY1B0JHWbLuKpZZTrNoufOlclAo6IXFoIFT1Rc/7Jqg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xe+W4US2XtPnVEmp7toByhvgYUcrEFTGUz6M9T1ZVdFnRte3ntjR8j30LorLFy8ALkBh3A25uzZ4H6MZmfw7x8MwVpZOsXj+zlAFVAlsmJ+DgL/UCQcyNol4+MSo4ex8YYyAgjYPkzzSCJqE82e2s/vUJ13gmbJBCakJppnpGiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=R4eEdYUS; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id B5C3960A5D
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 08:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1718953029; x=
	1720691830; bh=BY1B0JHWbLuKpZZTrNoufOlclAo6IXFoIFT1Rc/7Jqg=; b=R
	4eEdYUScX+keEw9+c/06i3jf6s3G1+WBtlTFL9Re4qhdk5U49YFzZCPYgi9QsNdk
	2Dlij1F9LNZ7bhDVipmcRJolkoVlrDZ4j+p99ZUa+gmyDiwjW8Zb9H3WD8rvzRp+
	nDEMvx9G+atLfm9kulG7kEPxVse7Hm4CMqHsgqSg87caevvvx2kSq2nLbDpFB2VL
	VfZXHrO5/7NRdiLon2X8A/WbxcSRB15fVHx+Dw4t49xdN5BEQibui/cEbKIA5TX5
	ma4zHN9qdxsCj63jweCuhIZSvgM0mjMVjK15lpCHzqoj+qZ1K1Qdr4v3UMIvm1zA
	PncTdV97pdcY4+Qs/Wl1Q==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id ilTMMU9s-YXu for <linux-btrfs@vger.kernel.org>;
 Fri, 21 Jun 2024 08:57:09 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Fri, 21 Jun 2024 08:57:09 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: workaround for buggy GNU df
Message-ID: <20240621065709.GA598391@tik.uni-stuttgart.de>
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


The GNU tool df does not work correctly on btrfs, example:

root@fex:/test/test/test# df -T phoon.png
Filesystem     Type 1K-blocks     Used Available Use% Mounted on
-              -     67107840 16458828  47946692  26% /test/test

root@fex:/test/test/test# grep /test /proc/mounts || echo nope
nope

The mountpoint is wrong, the kernel knows the truth.

Therefore I have written fst:

root@fex:/test/test/test# fst phoon.png
path:       /test/test/test/phoon.png
mountpoint: /
subvolume:  /test/test
volume:     /dev/sdd1
filesystem: btrfs


https://fex.belwue.de/linuxtools/index.html#fst


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240621065709.GA598391@tik.uni-stuttgart.de>

