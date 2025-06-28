Return-Path: <linux-btrfs+bounces-15060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66617AEC953
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75CD3B0986
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D45264F9F;
	Sat, 28 Jun 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="LrP/wXgn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088921B9E7
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Jun 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130949; cv=none; b=NZL65qDgyUtzqQoFV02maRpRxybg0mV6ZG0OkqZeEMTJv+OsHJPczT3NNmmtLNsvuyNazevsWFXHmpwyU8LgnJE2+++FsxH4EiYmBAgEqCzINmqYzZHUrpEyLkF4HTxeaWZ9JnfXnY0xogEa1GDWz+GFFWKC5T8/FRkzkyYTHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130949; c=relaxed/simple;
	bh=u5sqwglJ6xozU3fmPxkTF5XNnPuk7Nm8XuqSF2H9nW4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/yNr/g6VePq23WGzXOBEFnmlipwFNb9T/BeiQO5I2pkYW1dB9qNsXtz3QCbek7m60fQ9+ORyOs9XhmS54XhNmCv9Ox4V2/VnbolTbZ5O85NjjNf5NNu++cvRcvLCv1ZFxbAiDWflX99Mw2ZvbfQOdeYK6eTl/Kdle09cbfCfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=LrP/wXgn; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 41C2460BD6
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Jun 2025 19:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1751130935; x=1752869736; bh=u5sqwglJ6x
	ozU3fmPxkTF5XNnPuk7Nm8XuqSF2H9nW4=; b=LrP/wXgnqrRwERVa0G9jbI5yGh
	C+lnHFwXd935Ogxs4HKJEZ/GTrCb50/Jzt/H5loAtwqrjdWBBtK6e3e1qayr/ZLx
	pRoJCYsrq+oVb/XnUrMzw9thMma6AgwPzM0+uBAi9cMwW2LKaHV9O2ky5ckyHHnf
	cf16dedTSt7J/ceToJIl5/qUZf2x9x/SsfAweg24rvnav0MSpPrt7UBM3nggFZW1
	gkDS3w+59zQllj+b4D9wbUzi5CDbJB8+0WFGrZxYUG4K2C5h4a31XtDJi3pHHzqR
	mjgGQORn6sjRTx622SxWPnMvy9g8LThbRH4DW4thKh2jeAHYac+xVERqOYGQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id JwFB279JQA1d for <linux-btrfs@vger.kernel.org>;
 Sat, 28 Jun 2025 19:15:35 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Sat, 28 Jun 2025 19:15:35 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: Linux BTRFS mailing list <linux-btrfs@vger.kernel.org>
Subject: Re: 2 PB filesystem ok?
Message-ID: <20250628171535.GA847325@tik.uni-stuttgart.de>
Mail-Followup-To: Linux BTRFS mailing list <linux-btrfs@vger.kernel.org>
References: <20240428233134.GA355040@tik.uni-stuttgart.de>
 <ZjJOuiu0o1PqV3jA@ws>
 <20240501181903.GB393383@tik.uni-stuttgart.de>
 <2183753.irdbgypaU6@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2183753.irdbgypaU6@lichtvoll.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Wed 2024-05-01 (21:47), Martin Steigerwald wrote:

> > > So I believe it would be `mkfs.btrfs -O block-group-tree ...'.
> >
> > root@fex:~# mkfs.btrfs  -O list-all
> [...]
> > root@fex:~# btrfs --version
> > btrfs-progs v5.16.2
> >
> >
> > This is Ubuntu 22.04
> 
> Too old.

root@zentux:~# mkfs.btrfs  -O list-all 2>&1 | grep block-group-tree
bgt                 - block-group-tree alias
block-group-tree    - block group tree to reduce mount time (compat=6.1)

root@zentux:~# sysinfo
System:        Linux zentux 6.8.0-62-generic x86_64
Distribution:  Ubuntu 24.04.2 LTS /sw

root@zentux:~# btrfs --version
btrfs-progs v6.6.3

Got it! :-)

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<2183753.irdbgypaU6@lichtvoll.de>

