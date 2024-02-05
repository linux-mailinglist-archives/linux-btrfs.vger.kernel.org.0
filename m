Return-Path: <linux-btrfs+bounces-2097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB2849377
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 06:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB655B214F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 05:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B08DBA30;
	Mon,  5 Feb 2024 05:39:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from relay.mailchannels.net (gt-egress-004.relay.mailchannels.net [172.255.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62DB641
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=172.255.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111593; cv=pass; b=AqjF34VCRQM+ZqC/AYCS7iWu5i+VAtDcTrKHNFqnd354WFjO0I0g0n6g/IT/BcOQHgV8nAMtHoiIj3vcsPRrMD4ajrPYjcM43BUkzV0OKxYdHDhcUkwgS31oe/hDQKgA4PQ0qi61+DNNqUBmwRkwpdOTpq42Fo4IuK3X0exFSsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111593; c=relaxed/simple;
	bh=e5rvbnn4282xN5ZeWTITqUxNrno2Fg9RrieMeFcj6Fc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOGKTo6oUiyBHXdBlStUhQqOwDcpMV8+qU2rErWG+gxvfG6Mg+vXt50tR3rhZzwfV5gyHkLvYXSEXjoTakaVian0pN7Y9HOOw/UleU2c0S1KiYl86pTneXIcDNvCvO9TYJioW29/9k7QrSObyIPMRjRxkw3KAmnlC2gkpe1Ubmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=172.255.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9220D902A9F
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 05:39:38 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id D7D3F9030BD
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 05:39:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1707111578; a=rsa-sha256;
	cv=none;
	b=fER2HIXmU64vXO0q76qihA0J24ye4x5VIB2YXZ8ojgnbvSIqGx2u058mx1FjLoDQFGau+j
	wKQj798F+cEud7nBnMw2MMk+LHmSUlmcQ75Dabz5/gglC/R4VGOUw3U1VAH5gwX1VLR/Bw
	7ltI3lkLOwlzG2uL7Jn0ehyDQxaj1XgYBrbEGKrYpANLT0YvCswnn9TQrsrv5gcpOXOdIg
	Oft/q+gz1ITmW56MdVJIJi0tYUHqDGZrpKGU02+Ty8SZuTY8lfvP8UA2oP508fqvapn89K
	YuCaToMQo4FRxsGt+dvPZFzOy+nHD+bLNfuruSa/y01XY98c5JAvcrr9U4v0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1707111578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5rvbnn4282xN5ZeWTITqUxNrno2Fg9RrieMeFcj6Fc=;
	b=2g7QW/CYFLO1jhQvVFB/uz6PzGK1vmFk4NaQWVIdSgNBPPbLR7adq9UufMpLPbcfd//gnO
	VWUnNJuzLdtGiKjobD1JjVvjC00QIBkUnF+CZbq6RzteWL5Pp2G8bIjMlIVzmyMQ3fLe84
	Ims6rITqqjrt0p6OvsrkmKWFe8sTsJs2L9YU0zmuHrs4y+cCMBAmatPAQcnOqoZU5t0arE
	O/xxfl/S3/hiSDZu4T5iw/aSvZzDYkzMdFyPea37BTaJGYRsriPVc7Br8EKcq/WXxJ6yzZ
	o99uQ1WXiR84lw1ZWwHjqibZjczMAfexYmFy/wIf6jS7C+ip5GX667js7YVKLg==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-8k67v;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stretch-Trail: 0abb30392f0899f6_1707111578366_2913438999
X-MC-Loop-Signature: 1707111578366:2375096191
X-MC-Ingress-Time: 1707111578366
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.100.214.50 (trex/6.9.2);
	Mon, 05 Feb 2024 05:39:38 +0000
Received: from p5b0ed8de.dip0.t-ipconnect.de ([91.14.216.222]:38310 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rWrhc-0003C6-1g
	for linux-btrfs@vger.kernel.org;
	Mon, 05 Feb 2024 05:39:36 +0000
Message-ID: <c6fcbd44c7ecb06c92f6062e6843a1d106b5799a.camel@scientia.org>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag
 target list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs@vger.kernel.org
Date: Mon, 05 Feb 2024 06:39:31 +0100
In-Reply-To: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
References: 
	<2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey there.

Is that patch still under consideration?

The filesystems on my 6.1 kernel regularly run full because of these IO
patterns... and AFAICS the patch hasn't been merged to master or
backported to the stables yet.


Any ideas how to proceed?
I mean if btrfs just break with that specific kind of IO patterns and
there will be no fix,... fine,... but then please tell so that I can
witch to something else for that use case :-)


Cheers,
Chris.

