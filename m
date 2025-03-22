Return-Path: <linux-btrfs+bounces-12497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A0A6CA63
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C2189950A
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B70221F3A;
	Sat, 22 Mar 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="RnZt1s1d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC421422DD
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742651080; cv=none; b=YKcdV2qvlIFMygY154qOYvHS/VA2aXlXODkeq+dBgYqrxJwRpAzJAazdksIqaz38lojQm6FHAOehlr1siMNYxBT7vyxQEFXqOe2FzaHDmWCSAQmNVcJxfpC/v2OWT/YzxC7iuxa8rgZBzCiS8Kuae3bTnLt1hQcb+QmyM9zUGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742651080; c=relaxed/simple;
	bh=oNyNtFYQ0D3nvGL1u91eCir+90zW+YB5wRnD/LMq+lw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zhg4fzTU1QR967HRstqNZxWI13Ykpe/OjNYo2i8JUX+PaiwC5LnYWJbQXbLDfP004g/rkkHa4exlkBdURdzazgiMvYCiom1ybmp7PDHYLAo9ODgRZNem4UUY7ehJDrjZfubKiZ+eVyoW+uEhDmVBZuqH8x0fqyd2EGNQwcHvBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=RnZt1s1d; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1742651069;
	bh=p6FmoHuPeTxpxZiT1Qoe02XJNFS9f66B0OnLJ/uRCVw=; l=1282;
	h=From:To:Reply-To:Subject:Date:From;
	b=RnZt1s1dGEzPsHvmy7eTtiJnJJK/ZCfYDCCcyDXCM1TInOaQqwHCE5dRrKgqBzP1U
	 /qHW9stPi+JcIE7b6qn2IBla4vfObzA8Co7QGpqGOqtHLmK27HLX6zOk5knI6DLOX0
	 kSEmSLseSCz78UZggV2Ml34ZCSCkwsD9hnf1dWF4=
Received: from xev.localnet (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.sws.net.au (Postfix) with ESMTPS id 0A70517A09
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Mar 2025 00:44:28 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org
Reply-To: russell@coker.com.au
Subject: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Date: Sun, 23 Mar 2025 00:44:22 +1100
Message-ID: <3349404.aeNJFYEL58@xev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

[/dev/sdd1].write_io_errs    753
[/dev/sdd1].read_io_errs     1

I have a test system which has a strange problem where the BTRFS error count 
on one device (out of four) goes to 754 after a reboot.

There are no BTRFS errors in the kernel message log after booting up.  There 
are no log entries in /var/log/kern.log about BTRFS issues.  When I look at 
the console as it's shutting down I don't see any errors being logged, so 
either there are no errors logged or there are 753 errors logged in the final 
split second before power off or reboot so that I don't even see them.

This is repeatable and it's 754 every time.

After I get the error I remove the device from the array and add it again.  I 
can run it for days without problem with data being written to that device and 
read from it without error.

But when I reboot it says 754 errors.  When I swapped that device with another 
one in a different drive bay the same device has errors and the other device 
doesn't.  So it's not related to the drive bay it's related to the SSD.

The system is a Dell PowerEdge T630.

The SSD could have a fault, but if so why does it only show up on reboot and 
why 754 errors every time?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




