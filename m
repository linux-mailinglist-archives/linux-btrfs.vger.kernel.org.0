Return-Path: <linux-btrfs+bounces-8458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FEC98E37D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84912285B46
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0831D12F9;
	Wed,  2 Oct 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="SkVWPigc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8xbwm1r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A6215F77
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897524; cv=none; b=HAXsuFgejsjgJPUwccZV/eHcaeYH5wEXWeF689PIQB7NB30+0OFbU7eHO3uxiZUaEnhdYLSu/nijWVmh4uLQHz+GjqEJiH5uw1igBmayIogoVrfteBxao8FsS42Dtm39vYfpAhi/NQT61t6nkR6yiG+iTATjLUKedeQtHF9ZB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897524; c=relaxed/simple;
	bh=z77Q0Bbo40jmEWC5pMBvxyydF+CimfkfWuyBR+BetrU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CEfA3ULN1TCDdEY/NxUCXFRDxd9Tzl6cNOuW6tzbojfn1CNGQCfsXMdeK4nygQX89lA0Uo/oeO5LOg18mBONOi3Le04a6sIqOUwbI1rxXbw5fUeguAUqHtBV8NOC5ZI37qKgSz+rq/tNsbd7QpCt8Yumsr6B17Q3U+2hPhjX5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=SkVWPigc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8xbwm1r; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95F9C11401C3;
	Wed,  2 Oct 2024 15:32:01 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Wed, 02 Oct 2024 15:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1727897521; x=1727983921; bh=pqwATKrsPjwK6AGBjJp+/
	GCaf0pPz6bnYRH1PewDZRg=; b=SkVWPigcfrNxmDAbogXUS2UxbyjKZP1cyq88D
	YyGP43OV/WIZLoTNCoA9wobaEjiE5L3KQ6jy0JETTXpj0lWRqZZRyQc0dSDs4FMO
	qvgtabp2TkgviN1fOjs0nCVFzLpNhuC0vUXDysZBlnmCyTBDe1BT8A512WLV0fRG
	xznkEpvfcGv8x4DQ5oUjvk10zD04TbtrC/+P2lB0Eu36SekReI6LZnKPtqx16SVk
	9vT2A0zm5wPcG/5/CfnR/HgJnTVXnYIytCHONJDKm6++CIEbG3SZdT8V0nH7rxHv
	MKi7SQA4PC9krTMBrjoeVmPCe53GH0XTLnchcImp2bYnJGfVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727897521; x=
	1727983921; bh=pqwATKrsPjwK6AGBjJp+/GCaf0pPz6bnYRH1PewDZRg=; b=L
	8xbwm1r4aaHmgGWvTZZdDJmQpNhi402xo2Q48mTbBRob5BzgM5++nS2CWoKI7OAl
	KXJtM70nmQLRgQ1LN6dFzLEJuQIgzJ/yQimm3fkMB2AyQbR60VRxtrRDEwPOYG+c
	8NEInP2KesuSho6yXlRMBiTtFu7hhay+fuR8oQ1JLueEBI9qvOkzJ+t6zCvyLWNd
	2ZF0fwg4dbBJxEzHFFvyVmGujPRJO/N2EoTZgR8Dt5OI76AggKWvOUJVlpgOHOGv
	nkgNyjUZHs5xCDyfi0ZzdX4hJXbvwdEkbDfChFc6yAAKb6Hxr461rVg0NXG3HHD2
	0fwn4nvxy6I/lxXjt6JXg==
X-ME-Sender: <xms:sZ_9ZoFg5ioi5-4RVE2n7iO7oPUifOR2aDMlhV5f-dU0W7amc1G85A>
    <xme:sZ_9ZhUZrVvc61NSzlr8tFUwz1bjHPylYrDCanZGhdBCX_t-R0VBVNH4dJaAVV58-
    p0PldiONg3LiP31WCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrh
    gvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeekieeujeekfffhvedvfeeg
    fefflefflefgjeeiveetveelffeuuedvgffhudejhfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughi
    vghsrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqsghtrhhfshdqmhhlseiivghtrghflhgvvghtrdgtohhm
X-ME-Proxy: <xmx:sZ_9ZiLk-Nl4jn701SWlU8NG1eNfHuq2sPOVw8kRLcbdZ5p1YxZczQ>
    <xmx:sZ_9ZqEaK3xc8gaM0FaxvJLocRkWz4pvzt0jlrzDyIXtR5Ya9QoMmA>
    <xmx:sZ_9ZuXA9v72ejGFnv-qWrCTmN67Xqcqru05Vbq03_ZfDcquLA-AXA>
    <xmx:sZ_9ZtN7YCo0aiRlCcQf8-oCis0eSIfRcTzB3N5ekpi87MnWB9Kzew>
    <xmx:sZ_9Zhd5tLrti7E9bcJAZquBE44fueIAngqJ_7Oc1j9wdSLZjbsCwj-r>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2D5CC1C20066; Wed,  2 Oct 2024 15:32:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 15:31:34 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Colin S" <linux-btrfs-ml@zetafleet.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <b33797e4-476f-4719-90ae-87218079499f@app.fastmail.com>
In-Reply-To: <28059007-9d87-458d-ab4e-a498977d8268@zetafleet.com>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <20240927212755.5b24ecd4@nvm>
 <03de7723-0be2-a153-d264-a1024be3c2b8@georgianit.com>
 <28059007-9d87-458d-ab4e-a498977d8268@zetafleet.com>
Subject: Re: BTRFS list of grievances
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Sep 27, 2024, at 3:01 PM, Colin S wrote:

> Furthermore, if a lost device ever mounts rw on its own, it will cause=20
> permanent split-brain, because btrfs doesn=E2=80=99t track lost device=
s so will=20
> happily rejoin all devices again later.=20

RW degraded mount makes transid ambiguous. There isn't a timestamp in th=
e super, so we can't use that to help disambiguate matching or similar t=
ransids on multiple members that were mounted rw degraded.

One idea I had is a "mounted degraded" flag that would cause the kernel =
to do some logic to prevent rw mount that will cause the split brain pro=
blem. i.e. do not permit the mount of a file system when 2+ devices pres=
ent have the degraded rw flag set. Perhaps not even RO, I'm not sure.

Would such a flag need to go in the super though? Or could we just make =
such a thing an item in the device tree? And for that matter, add fs cre=
ate time, and the last mounted and unmounted times in device tree?

We also need a partial scrub, i.e. start a scrub from a certain point so=
 that not all data and metadata needs to be read. Write intent bitmap wo=
uld help do that but can we infer a write intent bitmap via transid?=20

Or still another idea, a variation on the seed device but a single devic=
e can be both seed and sprout?  i.e. upon mounting rw degraded, changes =
to the filesystem need to go in a separate location, the point being to =
preserve the state prior to mounting degraded, and isolate the degraded =
writes to "play them back" later when all the drives are together again =
and we're running normally (not degraded).

We really need some things in place with automatic degraded recovery and=
 device readd before we could ever figure out how to have unattended deg=
raded boot (for the 10 people on earth who want this - bad but funny jok=
e). Right now we can't set degraded mount option persistently because sp=
lit brain. And we can't even try to mount when not all devices are prese=
nt because mount will fail (without degraded mount option). Therefore th=
ere's a udev rule in place to not even try to mount during boot if not a=
ll devices are found. Indefinitely waits. Kinda annoying!



--=20
Chris Murphy

