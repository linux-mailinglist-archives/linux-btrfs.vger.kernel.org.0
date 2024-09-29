Return-Path: <linux-btrfs+bounces-8315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DEC9897F7
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Sep 2024 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E18E1F21569
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Sep 2024 21:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282017BB34;
	Sun, 29 Sep 2024 21:42:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD41DFF0
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Sep 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646166; cv=none; b=OIk5erlS3f3qVCbiJdjhDtP5+ZbNDxhp7HB7Dr+PGAtLbZdi+tQ/9b7ipaK9LMpGH64NTVe56yhRU+PvCCsy66coyw+IVA0M/EX4bF4GO/Umh4Ju09me4kBwnSbw75j8d7wsjsV+rZxiPEXGpafA+peruiwMDW7SvnhrsncmJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646166; c=relaxed/simple;
	bh=Xqv1h1mZXXlCKX3BQxrmT6ZwTG/S1RKAPECl4wQqzbc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FRkPfyp3HwervHeO0MfdkPndEaUa3rPsnHiyX3g8hKIGSgaU8bhCcsyjOcbNlso2k2bcq2FPMEU6K2Dmwr9iZZ2aJvNPJcHOWHTP0a4gHOeeUzTvf38zbT1oxmF6P1POxrBR2zlmorfOLTqSBIogzSsOcdHzEvB6JcZHKkObS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id ACA63C0C683
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Sep 2024 23:32:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vro9jOWRKJCZ for <linux-btrfs@vger.kernel.org>;
	Sun, 29 Sep 2024 23:32:57 +0200 (CEST)
Received: from [192.168.55.110] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id D2045C0C61B
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Sep 2024 23:32:57 +0200 (CEST)
Message-ID: <03362532-cf30-4f02-b5fc-f1a5cc5f5a53@dubiel.pl>
Date: Sun, 29 Sep 2024 23:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pl-PL
To: linux-btrfs@vger.kernel.org
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: =?UTF-8?Q?Bytes_scrubbed_=E2=80=94_more_than_100=25?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Strange balance statistics — Bytes scrubbed — more than 100% — 100.06 %.



# btrfs scrub stat /

UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Sat Sep 28 19:20:34 2024
Status:           running
Duration:         28:09:48
Time left:        19507110:45:51
ETA:              Sat Feb  9 05:16:16 4250
Total to scrub:   24.21TiB
Bytes scrubbed:   24.22TiB  (100.06%)
Rate:             250.51MiB/s (some device limits set)
Error summary:    read=1
   Corrected:      1
   Uncorrectable:  0
   Unverified:     0


