Return-Path: <linux-btrfs+bounces-4657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ACA8B870C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A0283514
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69350289;
	Wed,  1 May 2024 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="wUZmiRoM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA048CF2
	for <linux-btrfs@vger.kernel.org>; Wed,  1 May 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714553877; cv=none; b=HwGSZxQgxZ1NFH/mwaJV/b0LlZ/udi5kgkMwO6k142GhdhAz0EQj6uVKI2aN84XOph/TWuCCZOXTqRyIaeeUP3GYoESdPV1wtfKh5lHq7T6KPzDBb/ueleQPM4eJ3aGlIm5NDq35H4S8XcsN+3YShz6eHt/062OBwEjc5JUzsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714553877; c=relaxed/simple;
	bh=mvA208wV7zCoOgw5v3rnfMQNcpfiYuXMLTgg7fqIQuw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQBGHQCGbda9P6rKO+7Z3bKBwQLQEBxRYx7pVtTAMzehQy1O3Us9vfHmK6b05BJsHPStiifdwNTdscxVYREGwAsdrUeYkA7AScELpksoDyvlc59539eacYmnaIlwvx51cpgX3r0mjYmyUL1AiQcZJXM923I4tibN7LjRaoj+eEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=wUZmiRoM; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 04DF660E7C
	for <linux-btrfs@vger.kernel.org>; Wed,  1 May 2024 10:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1714553413; x=1716292214; bh=mvA208wV7z
	CoOgw5v3rnfMQNcpfiYuXMLTgg7fqIQuw=; b=wUZmiRoM78JG0XhYak74iGG3qv
	jKHH5bIvW26Oe0n7XRNETr/muDc0u0d+F5qB5R8OCFN91fxaRy0/5YoCBzUYTtrL
	7re/9rUCG4c65OH0VOE3X5L0cGBwq30i/hOo5yaugrifL7PwYDWSKqi0TyaX7nkv
	HhhMY4XPf5Ii6xX5jV2WJ4duy/z6h5bMRODyJ1PMnkCtr2zmDQW6n+4p6IdiESVM
	eGvIHFDpDn863rYQf1F322ZnMcZ/CaXTkA0IpxYfWdSeJgAgevn1ok+31TYQvFol
	bWfa7MIF34DRG3iMmOnx5AQdGm1B5oIYRDHNnjG1CI3uiJiUaUG6e5wRQTcA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id TGu6BHMnog5T for <linux-btrfs@vger.kernel.org>;
 Wed,  1 May 2024 10:50:13 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 1 May 2024 10:50:12 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 2 PB filesystem ok?
Message-ID: <20240501085012.GA393383@tik.uni-stuttgart.de>
Mail-Followup-To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240428233134.GA355040@tik.uni-stuttgart.de>
 <6609017e-8931-4559-b613-4b3e28d9fb48@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6609017e-8931-4559-b613-4b3e28d9fb48@wdc.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20230822

On Mon 2024-04-29 (12:34), Johannes Thumshirn wrote:

> I have used 2PB filesystems in my RAID Stripe Tree test environment, but
> for practical uses, I suggest you to enable the block-group tree feature
> during mkfs time.

I cannot find such an option in man-page for mkfs.btrfs


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<6609017e-8931-4559-b613-4b3e28d9fb48@wdc.com>

