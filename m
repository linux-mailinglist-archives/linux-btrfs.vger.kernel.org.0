Return-Path: <linux-btrfs+bounces-2171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449884BECD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378271C23A4F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541621C294;
	Tue,  6 Feb 2024 20:37:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14A1C282
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251853; cv=pass; b=GuSnfXwAEBQLWpdeV54gD/yLOZnXzoCXl0xB0m0HNq1N4Akyyycgr01wWlLQxNzMJC5H80nrprxeAw+ogl0swLIgiMhQ6OkaFMU10MPtAjrXAXt4SQjEhZkefrTS/PiWEmJbLeZZV+hzXL2Q1fba2hGWzIgsFVmS4AwX5MdPyII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251853; c=relaxed/simple;
	bh=6/Wb0gJcKXJOSjKu6jZY0lNwvpRlUb92/3DW+sBT618=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmOfm4unSITJNfRsRlXMfapjb7713EC2fnemxu2raxCfCAtF4mu8iASEQ28ncmSkId/HOuXlbDX35jKnBEmXcI0K2jd/TEmJiCki27LEBmSgUEAa2QbSX00wC9TthkOZ7CJRrSiFtp5SXZ000HYzC77IFVPKPCMa+v2sZQGTr14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1BF756C21BF;
	Tue,  6 Feb 2024 20:29:03 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id BD8BD6C2AA8;
	Tue,  6 Feb 2024 20:29:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1707251342; a=rsa-sha256;
	cv=none;
	b=Vlm7pCqU03/NlPxFYgS7ULCSb85bZxpwxEwbmnJAh2ZZNkj9JNx10kS5iS0agQ6sKmkC0a
	yYDQh/i5NR5jKA8FLquBoClSL36hJx9iarO5bu90hCjuDs138XzW45HtPARGzVdKOLnpNw
	/Y9EUstKe/Zkq9oO58FzZqCPby1mNtHYyw1yuAFigR5ahIqbMBnQk6fFVK2JaJ2vVk4L48
	uxg6h0H6GikTED+XDIylPd0rpcN0z4X+7hdDhrtS+fB0q1EJ+owKP6veARJKoZ2VhFY6bM
	TwPSfaRbLmypUl5NtFW3EDjV2mxH+eE5HOaI6iY+QdocP+iW67c4/G4zqMu2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1707251342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/Wb0gJcKXJOSjKu6jZY0lNwvpRlUb92/3DW+sBT618=;
	b=L8prd76ZsPc7nSLAA/ucwxUj4osoHeUHKlgLRzv0pEiKbLws2tuQbypcUhrstZdrBXPPgO
	H66TBKhQgo06IJedvh5E3+L3FrpCV3Rg8nof9/SCbD+I2PB0iZKQOWZjBw0+p2rDKNB4pQ
	wi3LYRqYOpXygnwzfG2y8fd0g+MYs8v8EzwQV4I20IwNEwRtxT/5QDdNe8eInW+iyqUHjG
	kGSxjvL6gYTyjNpoqrkmvfTmio4AFRFTN7wfHCfio8huUIs71qquqlU0YtL/CyvwgvjeL1
	9sHkgwvmh1K1TmqqFN3/hZPeRr05o7caKaapERgWbhgHB2LrmzKkpLtZ62p3OQ==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-2626q;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Squirrel-Illustrious: 386a460b686507da_1707251342773_276569399
X-MC-Loop-Signature: 1707251342773:575915594
X-MC-Ingress-Time: 1707251342773
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.124.22.107 (trex/6.9.2);
	Tue, 06 Feb 2024 20:29:02 +0000
Received: from p5b0ed8de.dip0.t-ipconnect.de ([91.14.216.222]:51610 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rXS2y-000775-2t;
	Tue, 06 Feb 2024 20:28:04 +0000
Message-ID: <9fc5dddc8831842ddde40a93bb0ac018a700993a.camel@scientia.org>
Subject: Re: [PATCH 0/2] btrfs: defrag: better lone extent handling
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Date: Tue, 06 Feb 2024 21:27:58 +0100
In-Reply-To: <cover.1707172743.git.wqu@suse.com>
References: <cover.1707172743.git.wqu@suse.com>
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

Hey.

From an admin PoV, I wonder whether this (i.e. doing it via defrag) is
the (only) desired approach to this problem.


defrag always sounds like a manual intervention on a degrading
filesystem, which for an admin is always rater undesirable than
desirable.
(questions like: How often needs on to run it? What are the best
settings? Does it impact the regular system IO? ...)


Your patches to btrfs-progs, would that allow one to defrag *only* the
extents with the cut-off?
I mean from an admin-PoV I may want to fix that - but not defrag all
other files, which may involve quite some reading/writing?


Would it technically even be possible, to fix (=3D shrink by rewriting)
the extent right at the time when the userspace truncates it?
I mean has btrfs even a chance to notice it at that point ("oops, we've
just wasted n MB, shall we do something about it right, or wait for the
user to manually defrag?").

Feels a bit like a mount option where one could say if a truncate
causes more than n bytes to be lost, re-write instantaneously.

*If* that would even be possible, it doesn't mean that the defrag way
couldn't be beneficial, too.
Some people may rather want to waste the space first, and only clean up
later, when IO is less busy.



Cheers,
Chris.

