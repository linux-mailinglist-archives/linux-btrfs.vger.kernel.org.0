Return-Path: <linux-btrfs+bounces-8882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277299BBFC
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Oct 2024 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C4828149A
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Oct 2024 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714E13DDB9;
	Sun, 13 Oct 2024 21:23:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC14231C88
	for <linux-btrfs@vger.kernel.org>; Sun, 13 Oct 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728854588; cv=pass; b=ub0wU0NYfPzis5dNnplzEoGnPCIaE0gtuCFKF/hyoMwnJTUryGaTFjbIfoWahQ3UydSScqoK6I17y3gsZ01lSgYhI5/rkvTUwVnx38pg1sVB2HXWjRtt2oMYurdQ/mTKNj09SIBs7cVhWRwNFo5HxrP1SZQ9vnj9El8vaDG8mmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728854588; c=relaxed/simple;
	bh=QWLX277iqjzkjZIuKZ3HAKWoEfINrCbAcX7Zwf7GaeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+56O5pd6xicTFHkBNzwmcYEx45SjcpI2AiP2IgdyUSJo4C25f0vM5DvWq57ndtgdXfC1gJx4jkYIAuN90hLHx3KW86f2xmIfjblzblsyuDRDtpYt7ofKTDXrPE57lGVbgRkG5hANIUSjI3CgpANiOLPJVSA172lq5+pVeA+AAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E68D11C2E40;
	Sun, 13 Oct 2024 21:14:00 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-99-175-217.trex-nlb.outbound.svc.cluster.local [100.99.175.217])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 324A21C2E5F;
	Sun, 13 Oct 2024 21:14:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728854040; a=rsa-sha256;
	cv=none;
	b=2by6ZV7MkOuwMeHUi04L0V5WkXGyXhJkMNtYZ7+1WGU9u/naC7NalxvJpPkUnHgXQx1lqp
	WfxeEwnKhSELPmMJXtfDycPnA9ZZiFBn9bYTurgLkNTlQZONSh03L/32Luab3UNvLPV2cu
	f3Wdi41m6AGmzZ3vlRvi0lv9nawDNPtZOm6CMf9QzDxEZ6h8IMFtYjHAvQ5xCrH0qlXC62
	FrC3yefBF/cWGXASd1ao8+3O5oLIvEgQAsZTk3S7UWaAEOcM2PEGLTZ4wKCIXXJ3OGrVgF
	V+BViHQPtlpNC92e04I3w3mWDgeMdBoc2JCEpsXPqjhKrULlxnLxU5WcOUbu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1728854040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWLX277iqjzkjZIuKZ3HAKWoEfINrCbAcX7Zwf7GaeU=;
	b=Vk0Y0i7MR2r3786OaoYRc3aYuQ48b0fNiOeeXoQRz9u9I9iLkkT905Uxzg1NQ+JV+0wELw
	JYO0oCf1XdWdFWu9IWPGBYRKNlr+yiC71KRHf5wtFHwgpcbahZ+SMT/cqjljmbLEkXSL+U
	Eld/YMaOb8sMNHnxAbxQPe+xfaTWWL8pPzQeJInjptHEmeBKfBbi/WJRncUJzJU+CNnghG
	AtUuJ9ufKZNd3pgoSjKSs1ccvJVTV/5eyv1R9AiblYcf0TGa/mM7dPLLbxO0yaC5HrwIHT
	0jS6TCju+SWIeMINHCaXzTJxZc3dEEPqjs/OjnTslhZnR7J3L1ey++hqsZhoww==
ARC-Authentication-Results: i=1;
	rspamd-5b4c8788b8-5rgtp;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Callous-Tank: 513b50c44f9923b9_1728854040818_87578798
X-MC-Loop-Signature: 1728854040818:368173697
X-MC-Ingress-Time: 1728854040818
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.175.217 (trex/7.0.2);
	Sun, 13 Oct 2024 21:14:00 +0000
Received: from p5090fba3.dip0.t-ipconnect.de ([80.144.251.163]:61805 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t05uY-0000000AS8d-0YSX;
	Sun, 13 Oct 2024 21:13:58 +0000
Message-ID: <df20ff9c041bad189b19971a9f41cef6c43e696a.camel@scientia.org>
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Date: Sun, 13 Oct 2024 23:13:57 +0200
In-Reply-To: <CAL3q7H7RfafuRir1Cdjh7YQ2fhas_NyK5orf4QYutzPC+TKycw@mail.gmail.com>
References: 
	<CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
	 <CAL3q7H7RfafuRir1Cdjh7YQ2fhas_NyK5orf4QYutzPC+TKycw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Fri, 2024-09-27 at 11:32 +0100, Filipe Manana wrote:
> It's a kernel bug and here's the fix for it which I've just sent a
> few
> minutes ago to the list:
>=20
> https://lore.kernel.org/linux-btrfs/5a406a607fcccec01684056ab011ff0742f06=
439.1727432566.git.fdmanana@suse.com/

If one suffered from that... could that cause any corruption? Or would
one be fine by just deleting the received subvol and start over (with
the patch).

Thanks,
Chris.

