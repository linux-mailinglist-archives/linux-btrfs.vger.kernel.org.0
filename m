Return-Path: <linux-btrfs+bounces-15697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C08B131D5
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 22:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33211738FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E2239E75;
	Sun, 27 Jul 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="m2PBRybH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from dcvr.yhbt.net (public-inbox.org [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C71C6FF6
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648846; cv=none; b=j7O0FaYuX13Lve07Oxn6bOQvDMmZEcJgoo3tXMmZ3U3OK6h6Avzq1MOnaUZ/C/29lIGZb8M+oDiD1cFo/+5Pqz3BRuNEU8tbb4thMV4KleJh12ctAUMX8XkK75D7NybK5GHs67mvCq3bmHD9vXhUuX5XO63fd2swg2fi5LoMu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648846; c=relaxed/simple;
	bh=4wUIOlqL+i1L0BbWa+SXws2WhZYPM+rsorgS1vEGMn0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DID7uKwFuN8PfCuAh5wLxk/oSxd5y/LfKZneyDO0/+GF3e9gsZFD3XBhsTOGzJAfzqAJxkJwxc051gYcD5KdkpB4iwvt/YauZsO4TYtb3c/46zRXOlwqP2ENdj0SwjXyxFn7oTkyTE4cD2GWesmqqfzJjjJ9ZDE/tS0NPo8cTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=m2PBRybH; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E591F4E9;
	Sun, 27 Jul 2025 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1753648407;
	bh=4wUIOlqL+i1L0BbWa+SXws2WhZYPM+rsorgS1vEGMn0=;
	h=Date:From:To:Subject:From;
	b=m2PBRybHtvbWi2hHljHBKYJtuu758sfQJ6ygNacFNmrNe3Fs+kk/m43X8IcgRXWPH
	 ch9uApSPbDNOiUsQxB40HrcDgVL2NP9PyHoSSR2lbsX8fxAWMaIOmyY1tpeOciB6Je
	 HLXQS4HxoX9qnQJUmff0bIUkOflijQ9NFllEJ+Ps=
Date: Sun, 27 Jul 2025 20:33:27 +0000
From: Eric Wong <e@80x24.org>
To: linux-btrfs@vger.kernel.org
Subject: defragmenting non-files only
Message-ID: <20250727203327.M348733@dcvr>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm wondering how much fragmentation affects users with large
active Maildirs where files are frequently created and removed.

I'm avoiding a blanket `btrfs fi defrag -r` to reduce storage
wear for files which won't live long.

So some questions:

1. how to monitor fragmentation of subvolume/extent tree or
   anything else which filefrag(8) doesn't seem to report
   fragmentation for?

2. does `btrfs fi defrag $DIR' work only for that directory?
   In other words, can I `btrfs fi defrag $TOPLEVEL_DIR` and
   expect subdirectories to be defragmented?

   Or should I do:

	find $TOPLEVEL_DIR -type d -print0 | xargs -0 btrfs fi defrag
   ?

Thanks.

