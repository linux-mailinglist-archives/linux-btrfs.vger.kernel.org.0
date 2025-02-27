Return-Path: <linux-btrfs+bounces-11915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDFAA486AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6808618880A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519C1DE2C3;
	Thu, 27 Feb 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="AwTGt5v/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758727002E
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677612; cv=none; b=LHm6tIQTrhKPRjeIYl6b9oPHXhl7buD9TdGvIeEhKjfh17QVlzi/Lo3yGYltmzlArmRv3KrDqllgG4Ifa4IhTxskO5hftx9aW5Y76V3/RknvTxx0wFJH9UjPymV9h2p/FS6kw405MFgj2W+zn9DfBsqmRbjxlJLF06hkRe3oU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677612; c=relaxed/simple;
	bh=nkJvYPvvWCgNKexdhZa3uj740NHWsttjPLU6bSZAKAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJmXpy9E5pHoSSI3fr2lVRpnkPrxD8yNpwx0KfeMotbkI6gEfOuB+OETV2WxbDLRP2D1E9Y7iI8eHilYZ0fRaBd1XxAX8mVzA4KXBCIGWwEVpdv02dFUtSu+1RY0/ksnoSo+5e2EzFnpri0mTx43yuC5V9p/iClm9tX3QeG7lno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=AwTGt5v/ reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KWg/ZYm5viSOM4m9S3zIRG8sFq4LEL6cecaeOP3rzf4=; b=AwTGt5v/H6q39D0t8ZKPYd4Psf
	onb8gBwuqoE7GjkIFW0V9oFzM/q9/xBM8ODslRkvIGfkbJaBhGG7H7x9dBQk3VbsGn3gEJ3FaShPx
	WkDg04OfG7f9lUe2E+AkWlwp2V0TmlOT0gqUoisVHp+t4kHpYRCpyaoY2NFn8FjToUP8fez9uvJ16
	RFZE5OjmdRv5PLFDFkOA9z/bgDJfRJlB6RdwiMmTLH9MwqfWUIOmD9/YAkFBRjdFVfOjUScDbxYR1
	n1f8OGBGoYSINjsam/H4xUuPaSe2GsOiGTQrqGwxuAuPX+D4l3Q/kzdIi/fijcwbDzzyJ6dDBBPzv
	EYHSKFWw==;
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
	id 1tnhlE-0003ij-3V by authid <merlin>; Thu, 27 Feb 2025 09:33:24 -0800
Date: Thu, 27 Feb 2025 09:33:24 -0800
From: Marc MERLIN <marc@merlins.org>
To: Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>,
	QuWenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Murphy <lists@colorremedies.com>,
	Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
	Roman Mamedov <rm@romanrm.net>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <20250227173323.GD11500@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
 <20250227170220.GA2202481@zen.localdomain>
 <20250227172113.GA2210558@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227172113.GA2210558@zen.localdomain>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org

On Thu, Feb 27, 2025 at 09:21:13AM -0800, Boris Burkov wrote:
> > https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com/
> > and
> > https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com/
> > 
> > I'll dig through the rest of the emails now, confirm whether you have
> > the fixes, etc. but just wanted to get that on your radar.
> 
> Your kernel is 6.11.2 and those fixes went in to 6.12-rc2:
> https://lore.kernel.org/linux-btrfs/cover.1728050979.git.dsterba@suse.com/
> and 6.12-rc8:
> https://lore.kernel.org/linux-btrfs/cover.1731619157.git.dsterba@suse.com/
> 
> so unless you have backported those fixes, that is almost certainly the issue. 

Thanks much Boris, I was not aware of this bug or patch, so indeed I
will need to merge in the patch.

Not sure if the 6.11 tree is closed or if the patch can also be added
there. Cc'ing Joseph.

I will merge the patch and report back since I seem to be able to
reproduce easily.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

