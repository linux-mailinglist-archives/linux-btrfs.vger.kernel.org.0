Return-Path: <linux-btrfs+bounces-20036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC70CE85F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 01:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9300D3010AB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA651C6B4;
	Tue, 30 Dec 2025 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GQSGKYAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z3ZCOCpO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A64C97
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767052841; cv=none; b=LpJgxEg6+ZENfdIE3AwhpsbPfShAGb60IBwba2nySy3K0WeDGNajJLZBvr9/KGMWEFhtUN3JC1Ns4IAjtbHugCqSvnKyBFSvQStHfWK/9KqHPHU/ZTqmqU8iW9A9hqwNJi4rtEniTv73fRjw/Po1uNAGIyuhumWRc4eIa6+mXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767052841; c=relaxed/simple;
	bh=vZVgOO/VDqoUCQzVTQEHaDjd+C/D/gPiTCxKI09a0Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIBKwXlFOx4IZPjXy/TSWfHSpyqVJ/sznbfktjHCARPhoQPbz+JIoghaC1SpRwDz7C64KgvU7zhrmRUrM1SgiwwMlsyOwF8lrxgLAJ7EUhzUNYceBpfvpOdrwieYxJTtkqdLbVETkURxlIejBZgl2KjWOtpA7AogPx7eTYE5PhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GQSGKYAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z3ZCOCpO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 29B64EC087B;
	Mon, 29 Dec 2025 19:00:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 29 Dec 2025 19:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767052838;
	 x=1767139238; bh=0a2WmlMjF1vOOsd4vdRiwJ8Lm3mS5p8K/fuBNWc3bL8=; b=
	GQSGKYAn5ZfXxtvBOKXp76Fkmxfrqfdzb0iRT/8mY3wdC2S4MRKmQ9YbGzhIDucL
	Pfd+l1qxPnJJnqynlC5PmSD4uOcyVQ2MQD8VjT7zk9sYV432HExjN7m1iRpvadt2
	QpFjFaaAi/V9U4akZYKwFSLKKpfDf4R3E7SkAL3FMSYe0DdUTkI9fifHfD2m0CWF
	sEVQhTMPs/iJ8Bedgkz2zOeUejK20xFQxjylK39UW3Eme6ZyaoYvevZUvoHvs1MS
	fWnWJcMKZ2p9885FyJSZgnX5JbpZvglxDlnJMCYVSx6TliGwiqKm5Wex6eBYwasi
	Xpq4cLIfk+gkMkERtsMV5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767052838; x=
	1767139238; bh=0a2WmlMjF1vOOsd4vdRiwJ8Lm3mS5p8K/fuBNWc3bL8=; b=z
	3ZCOCpO4Db81WrnwjCdmgIbZjtaE36TUjytiie3inMBU4vt75Vwy8sitDLwTHSvT
	eJIQYeimfr2GHQ3sG6pf/RXrZdw7hcrsnFVhHYGZvJjMP/SY2rz3tUltVR88yx15
	WbJMAFb1xIJJSfH7kmGM2dtEwEBrulpHusob5Ywd9IAdGZYCMcqriWVcdpSIk17F
	e1m8Q53zRqRjgBHJVa0/ZuJE1Xpn2cTRZF2bQIwdjyjYY5qhMNnXQJdnsdytoDSL
	1aSr/13VOdKy2+NOc+oo8BNVXGjnPhCMfGu3OjdA44StjSBRdKxT3Fc196aVaxKH
	0eVJOZ4UbaI/ojqbLSnig==
X-ME-Sender: <xms:JhZTac_XziKWK_GP44XXNfjUVATovkgWi1_TjfXgVMNorCoFTCaOJg>
    <xme:JhZTacLUm85VEOJqtsaHNdb1XoKgdpUij2S4Yk7uTYpz0mcTtm_zbE1vVSJomNDo4
    imTvhUoTzka2KAfwk4Qc4cSO3ehkmlZiFzv96htPkDC5dFiRS_TXYM>
X-ME-Received: <xmr:JhZTafbq1Yzxl2EvfXWBXsBVZen1aZqHjNSk_8KyFDTwPB4rLB9VlAY49pk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvle
    dtvdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JhZTaWKSwP98TgDL8h6nBN30SVVnbepQVkrh0NYRScFWkop7F0u2cA>
    <xmx:JhZTaVDbO0FZtjggpYfVP5JIVveomdnHWZfmgaYq82zjyzwEkGM-ZA>
    <xmx:JhZTaTrC1yXSyR3fWMiTfgEc1xGcyKGE2CD54k-wCL9wUs0ajmDaLA>
    <xmx:JhZTaYjYqLyvQzrys-Ox83nrCJUWQy2_i24x5AafVoTWU7i0_yq5uQ>
    <xmx:JhZTaXqJbwEASaTLGnboaQZCg3cKEeh-IPGT1HNQL3JDsJlm30ojZ_q3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 19:00:37 -0500 (EST)
Date: Mon, 29 Dec 2025 16:00:35 -0800
From: Boris Burkov <boris@bur.io>
To: Sun Yangkai <sunk67188@gmail.com>
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Message-ID: <aVMWI7bVCZX4RAAa@devvm12410.ftw0.facebook.com>
References: <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
 <18e6a584-b6fb-47f9-b526-4e97798052a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18e6a584-b6fb-47f9-b526-4e97798052a2@gmail.com>

On Fri, Dec 26, 2025 at 11:07:28AM +0800, Sun Yangkai wrote:
> Hi Boris,

First off, sorry for not replying promptly. I've been in and out of the
office around the holidays.

> 
> Thank you for bring such a feature for btrfs. I love it a lot and try to enable
> it on my machine.

I really appreciate your kind words and your interest in the feature.
Thank you!

> 
> But I've get into some unexpected behavior when periodic dynamic reclaim is
> enabled and the filesystem is nearly full.

Oops! Let's debug it :)

> 
> [12月26 10:41] [T20373] BTRFS info (device sda): relocating block group
> 5214541578240 flags data
> [  +0.012446] [T20373] BTRFS error (device sda): error relocating chunk
> 5214541578240
> [  +0.000033] [T20373] BTRFS info (device sda): relocating block group
> 4540021997568 flags data
> [  +0.008927] [T20373] BTRFS error (device sda): error relocating chunk
> 4540021997568
> [  +0.000025] [T20373] BTRFS info (device sda): relocating block group
> 5606746750976 flags data
> [12月26 10:42] [T20373] BTRFS error (device sda): error relocating chunk
> 5606746750976
> [12月26 10:47] [T12072] BTRFS info (device sda): relocating block group
> 5606746750976 flags data
> [  +3.960400] [T12072] BTRFS error (device sda): error relocating chunk
> 5606746750976
> [12月26 10:52] [ T7643] BTRFS info (device sda): relocating block group
> 5606746750976 flags data
> [  +3.960314] [ T7643] BTRFS error (device sda): error relocating chunk
> 5606746750976
> [12月26 10:57] [T20373] BTRFS info (device sda): relocating block group
> 5606746750976 flags data
> [  +3.954485] [T20373] BTRFS error (device sda): error relocating chunk
> 5606746750976
> [12月26 11:02] [ T7701] BTRFS info (device sda): relocating block group
> 5606746750976 flags data
> [  +4.561796] [ T7701] BTRFS error (device sda): error relocating chunk
> 5606746750976
> 
> I guess the condition of when the periodic reclaim should happen is unpolished.

Yeah, it looks like it is triggering too frequently in conditions where
it isn't likely to succeed. Hopefully we can tune up the heuristics (or
just fix the bug you found) and it works better.

It seems to be triggering every 5 minutes or so, right? Is that the
interval of the cleaner thread running on your system? Or am I
misinterpreting the time stamps? I would normally expect the default of
30s.

> 
> I'm still digging further into it.

Were you able to confirm whether that negative reclaimable_bytes bug was
the root cause here?

If you aren't able to reproduce but it is still happening on one of your
systems, we can try to instrument the periodic reclaim lifecycle with
bpftrace to catch calls to the various important functions setting it
reclaimable, etc.

Please let me know if I can assist you with that, or if you do have a
reproducer I could also look at.

Thanks,
Boris

> 
> Thanks,
> Sun YangKai

