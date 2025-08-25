Return-Path: <linux-btrfs+bounces-16348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011FB346E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8330B5E2E50
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F430102E;
	Mon, 25 Aug 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zMXFCzn+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B44301013;
	Mon, 25 Aug 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138212; cv=none; b=Ds3/iq8ncFzpSp8vExAXxyNcBFCuN/oS5RliWtWcdkRJ8N/qShYa7r0q+EwlAptiHOFNcAQ0qrKyr8DykNGxChmZua96nKIdlJH8ZllfotLsK+uaf8gOU5urI0+7u3/tvsthqfzTM8u0uWSLJd2hj5Gs7lWb5f6X9b0SCQMR8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138212; c=relaxed/simple;
	bh=Tjj9fFFMxfm5wq/Jzz3oDejeUiSni4NVLGvr02EWqvM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rY1l/pohTl8KoT/llUH2+SQhIw5fno9h8zmdkLq/2HQbq0NTRRaYuCc5EIuc49+4bdZ7s7rHqiXoDiMMQsoGeht7WluFeFjEesS6y3sgK5d+8Hn5wglpgLSijNR2W4n+s58+e3WrFEINOxfXkk8XPbDsC/35XFjaJXpp7y6eXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zMXFCzn+; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c9bNb48gkzm174H;
	Mon, 25 Aug 2025 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=mr01; t=1756138206; x=
	1758730207; bh=Tjj9fFFMxfm5wq/Jzz3oDejeUiSni4NVLGvr02EWqvM=; b=z
	MXFCzn+1riOFKvwceh9XTxoQumlx8p3GJVsabeKIONgJaGDzQzH/uzeDGz8P+MeD
	tdnIfAVPNB5slRxtsJheAeqjSYIyUzLc0w/s4879nUUZpymI9EK90ptBQ2sCajVQ
	ee8yjf+S1pXvU0yDnQdyoRtzSHmsLhP7g53DwI/QprmSa4AG8L3Zxhijw0YqADt6
	ikAiL1PJ+jHTJHfDiJxiC5tqyKQbwByWDP//4iu1VHVN31ERrsc407noFJV7lok+
	TcnedkCh74d48bPPDJrDwrIb9QnxDmUeAIlOR2e+2HyrhaIUjhH6Git3n7UOKIQC
	QL1BiUyGAAjiQpBtXJiMA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 017oq8RA6eDE; Mon, 25 Aug 2025 16:10:06 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c9bNV56CZzm1745;
	Mon, 25 Aug 2025 16:10:01 +0000 (UTC)
Message-ID: <b2678a98-037c-4567-b028-07e5bf149714@acm.org>
Date: Mon, 25 Aug 2025 09:10:00 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-btrfs@vger.kernel.org,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
Subject: v6.17-rc3: zbd/009 hangs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

If I run blktests test zbd/009 on top of Jens' for-next branch
(commit 6763582c1263 ("Merge branch 'block-6.17' into for-next")) then
the test triggers a hang in btrfs_writepages(). The same test zbd/009
passes with older kernel versions (v6.16 and before). Other ZBD tests
pass with the same kernel. Could this indicate a BTRFS regression?

Thanks,

Bart.

