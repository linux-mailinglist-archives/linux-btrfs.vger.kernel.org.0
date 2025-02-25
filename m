Return-Path: <linux-btrfs+bounces-11752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76827A437A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 09:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBDD189D0C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB3215182;
	Tue, 25 Feb 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="mqUl3l/S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07919342E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472146; cv=none; b=MrEpvBlyPz67KnrHGd80FuFNh+P7k49U9lEdizgCw3SY0WAa5ouXEFVXCdTkruALM5nruZEEHvWcbAow/vyQxDwYkU5r2qfO+gVR11ZB+9lTVGdspcwqevZEbDFUMokxLQzf1Ryy/jqiSgLOij/9obTl8ipknQWZx+3+b5WirlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472146; c=relaxed/simple;
	bh=N0uo/xeUw9j7Ay6g9lEgkbloUmr7GSLRbkyu+5B0S+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH5cSXr18ZadjD3mLSVSjN2LAiV5QmsNsQZ9C87g5kGZHhCAtW3lUn7QBPWM8RiW58GIfMj/hpldjHKTew1lc/LnpfQ6ZCVwjgRzArvMOOwd7UOceA4xt6+KkopVz/llJOZm7K/O4BUZFWGrdkzgfc3MIsKXx/ijxDK3PVMBiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=mqUl3l/S reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Qrtph7q7gvigVxdqoRJjmuyi2d6soo766BKlS1ThyEI=; b=mqUl3l/SNb9kboTzwLvcqbyyjG
	PotCavCWJHGGXMVA8mWs5Jt38jpzcgOKIwgcEgaDZDsHqDpUhqzIxHKdwNsbBapfGGQScrRE3AQOm
	cSZSfCGJ66PVLZTNSeWTUhNO4AnUfyPbgmx8ztSnd7h/uqSk8O+O4UFcycETBMT8Cc4vQvL03VsSC
	Hsu3am26UNtuJpqJFkMpT2YZ5EU+RE0wZrezo2dzCMnUKyT5FE3ns3UNAFx5si/17YBVvu2IE6uCL
	994k5eBjmKB4e6B1VSXD1rdcaAjNftmlQVmfMMUuyAKK+0antvLzf5Sju45irtd+cyaCBqVwZGgYe
	zonojwsQ==;
Received: from lfbn-idf3-1-18-9.w81-249.abo.wanadoo.fr ([81.249.145.9]:47688 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1tmox2-0006wo-F6 by authid <merlins.org> with srv_auth_plain; Tue, 25 Feb 2025 00:29:03 -0800
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1tmqJJ-007RG5-1X;
	Tue, 25 Feb 2025 00:29:01 -0800
Date: Tue, 25 Feb 2025 00:29:01 -0800
From: Marc MERLIN <marc@merlins.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Su Yue <Damenly_Su@gmx.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Murphy <lists@colorremedies.com>,
	Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
	Roman Mamedov <rm@romanrm.net>, Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <Z71_TednCt9KzR45@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
 <Z71yICVikAzKxisq@merlins.org>
 <018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 81.249.145.9
X-SA-Exim-Mail-From: marc@merlins.org

On Tue, Feb 25, 2025 at 06:37:40PM +1030, Qu Wenruo wrote:
> Full dmesg please.
> 
> The detailed extent tree leaf is what we really need.

Sure thing, it was posted in the first message but too big to put inside the message body without bzip2
https://www.spinics.net/lists/linux-btrfs/msg152512.html

https://www.spinics.net/lists/linux-btrfs/attachments/biniWUoCw198B.bin (keys.bz2)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

