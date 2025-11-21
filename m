Return-Path: <linux-btrfs+bounces-19236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA034C7755B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 06:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6DCA12B76F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 05:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8F32D5C91;
	Fri, 21 Nov 2025 05:17:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9AA19E992
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702271; cv=pass; b=TNl5F9sK+W8/T56c/5iDhDcejhcXjI30agR0YuKgIleQsbv57gf2klYVVg+IveCxDoyc1lHuwBboguBOOT36PN8dHv3Bm+0fVbybEUxqc6hl1KfsKHCs6HXPgw2KppfXoCwEm/dEkatvxiqoPHCjgyls/MbVmkNPLOkopnpNmcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702271; c=relaxed/simple;
	bh=BEc60bixy15/sOl7n21SpnTRsTkM29+scJM/GgfWlWU=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qKAudf5ImEwwFTVGFtO2IqXZpk6b/A9350B9zTSxXHfWuLWVr4TtndirbitM5hYsFDhpm/XSEHea7VI0R0WAxjE3nCuEsMfY1FhXu32o/NnzcQ8oBt+YKCbvpOMzK1msj0XCFduosFLQmyEFDYtd8fCJDNxjOg88mpppkMhJLCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8E91C7E18C3;
	Fri, 21 Nov 2025 05:17:42 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-96-111-164.trex-nlb.outbound.svc.cluster.local [100.96.111.164])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 49C107E1AC7;
	Fri, 21 Nov 2025 05:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763702261;
	b=PkobNx5uckbMQHMbDTdyttKk8EWi9RDw3Arc26wBZd5sgHOkjhKh9sLVwHTDXCtymiGfuG
	hhB5LXw81pyJzSgwy5AWPOFnkXnBH4rrvxiPD4REeeKiTaR92iHsGbDR6XmLos5mKZuyr3
	MCItZaUs8xc9YsAEETqhDuqEryHYnMPYZvKI3LRBYpogDAQC4EapWWwuKmVZOVa5NLZ8sB
	Ku25HZQj7U1mnZWgxQY0mNi081cLqtjeL4TFZa7d8YiiuD8A5XjAXxDN2HUT1GtkdNaoWU
	hxNMA+qvsHr5cdWLAUE2QKo3tNh02t8zUXLklg8qAt7EnBWZEPVji64Cxr8bWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763702261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEc60bixy15/sOl7n21SpnTRsTkM29+scJM/GgfWlWU=;
	b=Z3wvm5ijjvxFsO0wXoITJg+VMgMhKg2ZZ0hNq4FdDUilERa6DVqPqVgcsWNqkNCsxnGcTn
	/DJ6WTRsroPPGVQgY5ZvfUu1HBIG6gyLszZgtnCyDMB+C4f4xmwGHoeOotzGSHlwZo0q+Y
	0K1/onl2X1AQq50KTgAa71ubcCOSXxrAGXRW079PMJ4RMaZWFz7lHmPG4uM6mZ7qhdHCCD
	UITWiTvne+GiwGYvW3tMVXdiFouff1DXtBCrKmKv6LbB6f77vbRhdYrddq0LyFNEBkJgZP
	wf/nJUl5zIOP4cDZpwCkA/LMjlOaIWy+5am+HSJDHPPBTI2Scm467Qn864nwFA==
ARC-Authentication-Results: i=1;
	rspamd-7b65966669-ffcsq;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Continue-Glossy: 2e5bff944f99d1e8_1763702262343_1040159995
X-MC-Loop-Signature: 1763702262343:2327592997
X-MC-Ingress-Time: 1763702262343
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.111.164 (trex/7.1.3);
	Fri, 21 Nov 2025 05:17:42 +0000
Received: from p5090fa32.dip0.t-ipconnect.de ([80.144.250.50]:62865 helo=ehlo.thunderbird.net)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vMJWf-0000000Bls1-1nrD;
	Fri, 21 Nov 2025 05:17:39 +0000
Date: Fri, 21 Nov 2025 06:17:38 +0100
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_btrfs-progs=3A_docs=3A_add_?=
 =?US-ASCII?Q?warning_for_btrfs_checksum_features?=
In-Reply-To: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
References: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
Message-ID: <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-AuthUser: calestyo@scientia.org



On November 21, 2025 6:03:05 AM GMT+01:00, Qu Wenruo <wqu@suse=2Ecom> wrot=
e:
>The checksum of btrfs, no matter the algorithm utilized, can not provide
>any guarantee that the metadata/data is not modified by a malicious
>attacker=2E

Is that even the case when the wohle btrfs itself is encrypted, like in dm=
-crypt (without AEAD or verity, but only a normal cipher like aes-xts-plain=
64)?
Wouldn't an attacker then neet to know how he can forge the right encrypte=
d checksum?

Cheers,=20
Chris

