Return-Path: <linux-btrfs+bounces-15128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800BEAEE753
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 21:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5E6165EB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 19:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17071EB5D0;
	Mon, 30 Jun 2025 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="cOFBhVW+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAD433A4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310983; cv=none; b=FpvnJbFisHsGOTMKzm0b8nwO4qEfykWmVloDkuZEwByXZh0oe6w7YaCmbFPnFZHy498cMI9urMbRF7yOOBaNkHKQENNyiATNbQGRfH9dNo+kTt5wVHWsrJHyV/ZdTpweLI7ucLje6XsiBpDQa5C6FYr3DalHGn4ZsYwm+tipwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310983; c=relaxed/simple;
	bh=vBtXUY8uZUz/2CZIVJTsMejbHrmds87tINe9qVlE+kg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiUbRW0C/HDA4k6HwPzTcEmhH3yGQTYhv2ybQCWPhETn5V2TBQ3sG+q+Kvh4YiL5CfnoZnoLdJbMfmPdKnRXEMdf+mKDx64nVbPur75/kFxy4QMS/bpX8pGU1PmihkKlTweyAhWyPg+jBgLmxXqpTetHk8AvKk5wzxeiijX1w9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=cOFBhVW+; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 40DBB609EE
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 21:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1751310969; x=1753049770; bh=vBtXUY8uZU
	z/2CZIVJTsMejbHrmds87tINe9qVlE+kg=; b=cOFBhVW+M3DiH249vwAKgl+wfm
	N03eWsEHTJUznN555+GVcyjNobs8EpjnHGvbB0spJk5GLZn2EaE0kisqMqDvQ315
	VkeKRr7KhgiAR/bC4kYe/RPFju1Z6Fc2eKb5/o+xncsd+JX+DDB4YdG6/nF5Kkvv
	4Dqf3BDYJh/MeU1B63pq0WJXUep1WKHkItI2eMwJYibRxPqzTxMO823U52NKtMA6
	9Xj7bfuMn8+hDP9esuDX/IOcwWMQ6ajKdNmFSuolz3/aYlsaUR3QH5mO9+09fK/x
	1RljMtTTnTIpKrmsC8q3WMdN/cTXxyWiFRebD9SOhhfNIt3Iwv2F5wrvopFQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id SEtetQRZmLMj for <linux-btrfs@vger.kernel.org>;
 Mon, 30 Jun 2025 21:16:09 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 30 Jun 2025 21:16:09 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: restic backup with btrfs /
Message-ID: <20250630191609.GB1048979@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
 <82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>
 <20250630173041.GA1048979@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630173041.GA1048979@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Mon 2025-06-30 (19:30), Ulli Horlacher wrote:

> > > mount --bind / /backup/restic
> > > restic backup /backup/restic
> > > umount /backup/restic
> > >
> > 
> > This is unlikely to work, as bind mounts will also be seen as different
> > filesystems.
> 
> No problem here, because I will will use the option --one-file-system

TYPO! I will NOT use the option --one-file-system here!


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250630173041.GA1048979@tik.uni-stuttgart.de>

