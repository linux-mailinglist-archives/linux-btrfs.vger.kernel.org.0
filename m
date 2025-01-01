Return-Path: <linux-btrfs+bounces-10675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2D9FF535
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 00:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077953A2783
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 23:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F101314EC7E;
	Wed,  1 Jan 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="U/ofm2PO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jV3vBQ2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B28827
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735774933; cv=none; b=TihRciU2rGqevLkB5hmbBr0Qy5KXJRJcWqEoxT4dbHzEWYaEzWg995Fi3leOPSVS3cPmXI8R7qtoDWbJ3F8bON5ut+GipUnUSrpjIIQDZuq+7rdx6eZGNH5n1dBWEP/DP9cJ+SuMk/rjSUVbemp0L5J2+qHYznvkPa8aXU/UIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735774933; c=relaxed/simple;
	bh=bfq5XGhJLNOr+VRGNQ5xxouX44CXEgqOlbUttLT5UHQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F19yDNPe23dBOhmR3FzkdFCdYqHcd/LAEntjknahrBJExD4Zl6YjMwN3jVZ3AuRlsTjei+7mFKfvlFtLdVf/XPwdqP/vqSLA4+wgBe0/dTtpVYSJX71cPsNGDXvueogsCrHfnHBut3GziHB0FgAKmVcgSWMFNR8d5FDE3uNiH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com; spf=pass smtp.mailfrom=georgianit.com; dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b=U/ofm2PO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jV3vBQ2L; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 669511140160;
	Wed,  1 Jan 2025 18:42:09 -0500 (EST)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-08.internal (MEProxy); Wed, 01 Jan 2025 18:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735774929;
	 x=1735861329; bh=iGEW6/OE9VcNneCzi+Z2XZdmMGmmJ4eOrsGPfN6bTmM=; b=
	U/ofm2POmslkKKW2JQkyahVeIezvNsw53BFqh31MhPmCf7/DXVaXZbgQobs5bQPq
	9jbTg6pHdepRQuEKyDAqZH4gRfAaDYYv0AcsIbhlAMPZFlz2NZt1j/BrRqG0vMZ8
	nc9lbqVdD8ORlnwEHIDS/0YhJDzYLIcAE5YE6CJ8pKfqW5T8NTO3n2cf4fyoIibi
	kF+KGh3IXlQMytAUJOth6cE4yTABUAZ5bjuKHjRxKJfqGAn04qh87xIKESheOjW5
	7FZM97mFjcrCzKCiFqUzTOzVstM530YBtYt6hqE/Z1ZA48hYu9zS4/2YDyPs6Et7
	TVs10ndcf5TB9pmfOUBSZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1735774929; x=1735861329; bh=i
	GEW6/OE9VcNneCzi+Z2XZdmMGmmJ4eOrsGPfN6bTmM=; b=jV3vBQ2LPx4vYgFUr
	ZNCLNBaah/YwXladuriJVqSuU9c2OtPeyRFroQRBS83WvlGZIf0n4seqi1xn28Ms
	PNyx9jDc/ajsHWY67f7PHU/9i4ZpuTzychHjoGYm4B6FFp9LZufDBT6QCPqebMOB
	oF1WtjPfciuC211xeBWGr7n80dX2BEmML5v+PzwKnRHGpk8aKJwTXdW7shACTEzL
	MMk8/BEbQDI0YV8NibpzC4xVPFsFglFaXZTEu5FA81TuFb1vz1vwzFt7C5uewH2y
	AZ/RqEVwzym6t8MvEAPSB11rjBIjZ486QS5RrkMbCjVuCb7ZxavfySl2v/u7MKxo
	OHjEQ==
X-ME-Sender: <xms:0NJ1ZyKV_vK_g667ebCcnUQvlGIFj8EXTWb1U0bZ5F6FEocv-qR-kw>
    <xme:0NJ1Z6InsG-ojORTqwnIWDEesHIF1lC8L7yxMWSCVMbE9t22eCZANX8sASYy52E48
    S90zr5qfm6O8VMtWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttden
    ucfhrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucggtffrrghtthgvrh
    hnpefggedthfdtteetueeuffevlefhgeeikeefveeiiedtieehhfettdekleefgffgjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmih
    esghgvohhrghhirghnihhtrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsrghnohhnrdhvihgtthhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0dJ1ZyvEVM4Ig4CKnzhGr8e5Sg04d2eDUKnTbph2tCIUJkAlllV8vQ>
    <xmx:0dJ1Z3aU3Wi_fKbTyQzJLcddUTF1RPzdVPpq7saGEPfTPD5UghVNVg>
    <xmx:0dJ1Z5b-xSZiYBpwngwzgRvac_fhP66laWXIJMTL6APmAvPSMCcFHA>
    <xmx:0dJ1ZzDGNqy5ugmdzJpV3nBKmveKCb_xtY0X-F3-39AifBtxxLhJOg>
    <xmx:0dJ1Z4x4Kv4-_pfPKggBYO46jZjoLw5XcEpp-YeNBh8PCh1qW3IPF4hp>
Feedback-ID: i10c840cd:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E06753020080; Wed,  1 Jan 2025 18:42:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Jan 2025 18:40:37 -0500
From: remi@georgianit.com
To: "Victor Banon" <banon.victor@gmail.com>, linux-btrfs@vger.kernel.org
Message-Id: <f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
In-Reply-To: <76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
 <76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
Subject: Re: BTRFS errors following bad SATA connection
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Jan 1, 2025, at 1:25 PM, Victor Banon wrote:

>
> `echo check > /sys/block/mdX/md/sync_action` identified some mismatches 
> (I believe around 1000-1300). I ran `echo repair > 
> /sys/block/mdX/md/sync_action` 

This was probably the worst thing to do in this case.  If the errors were all caused by one drive known to have suffered SATA problems, you could have tried removing that drive, mount degraded and read only, and see if the file system was intact with parity data for the missing drive, (and if yes, then rebuild that one drive.)  But forcing a repair will have replaced all the parity data with the corrupt data.

