Return-Path: <linux-btrfs+bounces-17051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87CB8FCF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A4018A1E1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9CA2877F1;
	Mon, 22 Sep 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="Y8QEU4Gj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2C287519
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534191; cv=none; b=gKprDgXP8HLF1ZprzgY86qe+UoVS0xk8lBCW3pbNLCqKP0BwhKpVkaR90q1mvi2vY0jz9SM6/AqAXc7PYH1OMyeAdW3vh9VxYdewgebpyS2r6vxWKIaIwD1qaDfSyFdS7fnXojwh4aMdFLJCk7cqcTxjAO1irTbSBom31w6CFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534191; c=relaxed/simple;
	bh=5CTjdGIjfbdJSNf2MBVEG96uVHSqFg8n3fJ8NQPcQk0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj0jLGPKZOu5Fj7Anent/xCvlrF/hdAXqYaOx3Pfl9fqtgihBoZmphhWegGn8op+zVABwM3rUqWIaT+DE9SQq+wWnFI2JBgBx4HUwB+lVmPWypiTxrDSO+9JMxyer47PKPvp6o7eFkPMq1EkLI3SHJi6PZT/9GBvGPfv/W+B50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=Y8QEU4Gj; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 4203C60EAB
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1758534184; x=1760272985; bh=5CTjdGIjfb
	dJSNf2MBVEG96uVHSqFg8n3fJ8NQPcQk0=; b=Y8QEU4Gjjcc8lY9smvyMWFdyH9
	ZIkHP0WjqFbS2hU9rz0rHOBf4ppsRO4q21I9QAokkQLzKYr5cZBkiyQqn3ait1xY
	gBtToGFIcD+E1LIRvTxwNjcOH9W9j1iL0qNgXcqrL2XNA/kzIdRcNFnREneS4EwT
	oKwO9ajqExr605UhzK0POs9Dvh17UzzKyPh/kaWF7EqIBOJjOJqjRRsOYYDFIt9j
	1AqAQbwgtjD/yZWV0zbd4dY+ANyW2U4u9QBxu5GagdQ1pbgMpzlno269pByz/gVz
	OGqmCHulMsVk7YOWkdtsgzrDhxDxcGED+Ph8OgZbuJ/W0LXnxq5NbbRPXVbA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id UDRXleTIyPeT for <linux-btrfs@vger.kernel.org>;
 Mon, 22 Sep 2025 11:43:04 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 22 Sep 2025 11:43:04 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
Message-ID: <20250922094304.GB2634184@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Mon 2025-09-22 (17:11), Qu Wenruo wrote:

> Btrfs RAID56 has no journal to protect against write hole. But has the
> ability to properly detect and rebuild corrupted data using data checksum.

As I wrote before, I could use btrfs RAID1 (only) for the / filesystem (64
GB), the other partitions without any RAID level, just simple btrfs
filesytems. No md RAID volumes at all.

btrfs RAID1 is not prone to write holes, but is able to rebuild corrupted
data using data checksum?

Then this is could be the most robust solution for me.
In case of a disk failure I have to recover from backup.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>

