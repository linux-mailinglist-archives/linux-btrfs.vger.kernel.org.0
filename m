Return-Path: <linux-btrfs+bounces-3449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C5288063A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 21:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FC8283718
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E82B5FB99;
	Tue, 19 Mar 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HRXK1mI4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dMRDBEtr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA34F881
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881086; cv=none; b=Iu15IDxa8Iz8PX5l8uNOCBemCqH3hziAhchVdRUFfc8nvAO7ENsbOBNONnxQufYe3Ea3fOSddaPzlVP3NrR6DBEjJbrZTYL8M7EwQnD1CCWuSlZi/xV95VL7CrRDzyySAKJMJMuZwJlIM7prCg0qAvxuMjbsmmcCzdF0Ezle0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881086; c=relaxed/simple;
	bh=fiP62xRw7iCv6pthoucqQBcWECYx+XsARKoVh1FeEkI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=u1JrvwEDTgVGkq1SFTrad8kGNyp0DgiKliWr0i5J1VUeU3BWNFxh2mb6mkwKSYkzZqJLmso6+Pmj74o9Bm2x56kbH3qc6yBBLmjg4W4WHthDXCuUofjjUfZwAn/4FeAssQHM2BmULeLYJjaA8gTigtwpC+gulTvuZtCBtB0BvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HRXK1mI4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dMRDBEtr; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8BAAE5C007F;
	Tue, 19 Mar 2024 16:44:43 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
  by compute6.internal (MEProxy); Tue, 19 Mar 2024 16:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710881083; x=1710967483; bh=Xf1lVzxVht
	a7sPrVS5cvb5GNs9PF92Sr4PSyfJMMBtk=; b=HRXK1mI4YSH63ImMRNoGTdv5fA
	ZN4Y5QVZnNz2mv1Xni9diPWul8dqBQ5zQtRb1gJGrpw0sLO8SBHZJv6/DyaAh4XW
	Xe5/TeGeuNDPrigu6TB0Sb/iw+Q5EGF5Eehfngak4IF6ZSOji1jIB3+Ac5bkaBYM
	2OTxu34XI6IqD40HFEZsKf3K2OSCnOhs8JgHn7eRN6o2ckHK4WIENTTX5RPXJlQ9
	voERhXdGn0bcuYWq4hagFGRprdzArP7P45ylenI/ycS3fs2lm0haVSnTnPStHbM1
	2PkZWhQWbqXmZuoJYDtnFVIahRbvPSIE9CZ123+bz9FI+yBLt7xDCbdNVbqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710881083; x=1710967483; bh=Xf1lVzxVhta7sPrVS5cvb5GNs9PF
	92Sr4PSyfJMMBtk=; b=dMRDBEtrFyB1zzjX1XRkKMTrS7EpOTLm0gixiOi0yVNF
	7X00WG7rPrV3PbGx/pWW62SUq1abbToL1t3TDeQ+TjXqTHGN8m7mXXGbZQ5piEIe
	dAuSq0qK7I710vdUlW3RTaMDETSOxeVa+tDkCEfIsDaFludGBuM7LTfsHsYBeH6f
	jXlHuIsAizCu6yABQMQf6xMpUYWzTBYuIJevjPtW75sTT832FhKAkoXBuGE4+B/E
	QEIukNYjN1pVmkgfIhi1PSKYvrfvwoYxLsdacClwi+AOgEGvac/XAjDv6Vup/DDg
	cxTvmfusBfQp7qBsGF0IDHuoUTnKgxp+INQYH0qpqw==
X-ME-Sender: <xms:O_n5ZboCxDpcNPbTZtHj5mBdEHpScmofEAtHjqjupHKNWt7vSEOsmw>
    <xme:O_n5ZVphVjc5mya1N2zSTZpAUpk_i4OmOaqwtyvQvBcMmJbWyEHNjppCH_yafo-dQ
    cWEo8_EgPlnQDm6Gd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpehkihhnugdrmhhoohhnudekiedvsehfrghsthhmrghilhdr
    tghomhenucggtffrrghtthgvrhhnpefhgfehtedvueeuveekkeekgefgfeevjeekveeuie
    evteevheeugeeltefhteffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehkihhnugdrmhhoohhnudekiedvsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:O_n5ZYOnlu2fGW2mG-uIZf05091vl5WyrKTqoNmK9OCAkKFpVSN4nQ>
    <xmx:O_n5Ze5wTM_svqy57Y4RksEeEJ3HcoJMQ8VFErDR5zl7EbOaX92Y6Q>
    <xmx:O_n5Za6traw-bjWb_CtDs4tuolcNHV1z1PZvsNuSSPUTqAtObg5ZPA>
    <xmx:O_n5ZWjjSxHbG-ih41Tp7Pgm2Bnitw8U6QREBSHf0n4QfXvnGb8nVw>
    <xmx:O_n5ZQRsu3LyTBXvN3hebMoikv4Q9gSUzsmiHoOZAewn9UHebKjAXw>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 53FB036400B5; Tue, 19 Mar 2024 16:44:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f97071f-2c47-46f7-89f1-b0a80530ad38@app.fastmail.com>
In-Reply-To: <1cfe630d-ddb4-42fc-ac42-54fa53cab747@gmx.com>
References: <37de8ead-fefa-4fab-a0ed-bbdb2bf15cf4@app.fastmail.com>
 <e52a27e8-3b6f-4e33-bf0b-a225d7681454@gmx.com>
 <c233ac4a-dbce-4851-a8f3-78de0827ef19@app.fastmail.com>
 <1cfe630d-ddb4-42fc-ac42-54fa53cab747@gmx.com>
Date: Tue, 19 Mar 2024 13:44:14 -0700
From: kind.moon1862@fastmail.com
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Help requested: btrfs can't read superblock
Content-Type: text/plain

On Mon, Mar 18, 2024, at 17:53, Qu Wenruo wrote:

> And still, please run memtest before doing any rescue.
> As faulty hardware can always lead to weird problems no matter what.

memtest86+ found bad RAM.  I will replace that before proceeding.  Thanks again.

