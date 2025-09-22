Return-Path: <linux-btrfs+bounces-17038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9058B8F42C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AFF3AB1B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B562A59;
	Mon, 22 Sep 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="A1BaXuFD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D12F1FD3
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525476; cv=none; b=aunaubF7BFDlLR3xnQp2Db+gJYlt7skfhjdMm+WH8bP3io4znkx6Cim0OEkqTmxIqXf1EZwsK/2TjvijnW6zslh+obX8DfiulOa3XLTcmeUTSeYlldT9FQ+URwWikZYA5Lo8LEpSGWgu3S2GJb2K0s4BX3ADNkMvvrZcqRdjw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525476; c=relaxed/simple;
	bh=rgfIpW1Sfi5wlfVEte0HLcy8+dPpchbw0QNJt5z78D8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kcSI/pW/ERj7PAnh/RBiTx+jyJH0BQgxnLOe5tRtnSfGT78qX2YN6i+OCxHsVh3+nDc7ekkhVlMbC1Rg89pZ54uUBMMocbRA7LgoMhCHUmpfIIh1F/IVm+OaRSg/RDidFJ6xebTmIRyrt6LdPOHFHJpWPJmE3BCJix3C9uW041M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=A1BaXuFD; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id D6F2060ECE
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 09:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1758525468; x=
	1760264269; bh=rgfIpW1Sfi5wlfVEte0HLcy8+dPpchbw0QNJt5z78D8=; b=A
	1BaXuFDek0xMp7rFR2ZaLwfVk4nrcCzGLGAo5UoL3sitHhjm5FiFePhXW2Vl0FzN
	rYdiUUx/3A5a0PkMnlAze57CBUEeTmlOv00g1pj9YpIT+MoUg/elGipQCUTArWkL
	GSUKXTXaTnRt3uCg1JDtV7VY/W/vad8Q8gyOTkrcCBHSlAWrnIFinw+kfykR9oZP
	u+XPhJQm1ciqPPHvElIyYNX0v8R9twl4iFAnLKW2uh+zgH2oYJ79tT4QVER+5rXo
	+4EHcRwlbJ/kqeXItOS08gh1pYR7DnGdKX0pTBov4DafcBQGqid6WEq5Eft8qUSY
	8+jQHWQPRDwaWX2/AqZWw==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id C2V2Pdup-xVs for <linux-btrfs@vger.kernel.org>;
 Mon, 22 Sep 2025 09:17:48 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 22 Sep 2025 09:17:48 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: btrfsmaintenance?
Message-ID: <20250922071748.GB2624931@tik.uni-stuttgart.de>
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
X-Mailer: smtpsend-20240729

In Ubuntu btrfsmaintenance is an optional package, whereas SLES has it
default installed (at least last time I have checked it).

Is it suggestive/recommendable to install btrfsmaintenance on every system?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250922071748.GB2624931@tik.uni-stuttgart.de>

