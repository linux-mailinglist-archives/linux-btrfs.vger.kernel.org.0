Return-Path: <linux-btrfs+bounces-6821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DB93F1EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 11:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DFC1C20842
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CC145B20;
	Mon, 29 Jul 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sGeo6C1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYEV6eol"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10267145A16;
	Mon, 29 Jul 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246910; cv=none; b=DGYcHCyNPRq3kfpisNfZdKBPkMkMXU4lxJl+qyTuQ7ivbbiaNnzpUWUrrSNvpiSL+kbAxZ3P2AURbEaQ1jTB0xqeEvo2aFUPvn7HID3RtpqNpWMHefUCBMS7hu/WVQjj1R0ZI/svhbesiLex9SHe3E56uG+ClLcDFisWoSOsIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246910; c=relaxed/simple;
	bh=Mrhi4sZKNx/W9utBxQLEsPZMz5Dli4I7T9WNBjrKQDk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ppCeu/EBvMYR0o9+FD0E3c+EBOWmtGAJFubTlYu0La6vVC5OAXX3X9CVulbUJ/ii4fJe2zLjDpeVhDON2PbTzZQfW3oPrAVZpsWE2NmaVGmiok1Aa7T/g03fC49Q/MRLTSDq2maTU+K2e0w+mkkkJPD+5NxrEm+k6w50N6hcy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sGeo6C1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BYEV6eol; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 38B3A1140158;
	Mon, 29 Jul 2024 05:55:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 05:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722246908; x=1722333308; bh=wXV/r3Ef+R
	SOwF3n9b+Go+Q2efekHDW22bLwz2SfG8U=; b=sGeo6C1x+smISDrrbyZ04v7yjH
	iZ0mw8uxR0llQzXg1BRcJlNE0S9qM0PfgzAYcXWXOybVkmd6nPWhvCdpIY/8TESa
	s8QSOBViokCkYq7oeQURDo3I99SC2wA/LQRHxH2w4UW8p6WMpb1q9NnP7hYfnyUX
	+hhq5uc35LJD8aLqqloOaDogbX+baUzVeco9AbiucecA4HJrjwSZ3Qg1ZrE2MJzy
	pCX1sA86LQTlJnTi1mE0zafviR7WrMmhvw1ULywlXCE9KNqrC07veaq7byj3KEGc
	Zy8bYWy3dJnTNRmAQGBkhrtTI3tqHw7F+G1cl+OoB8DOs5UZcGIuexZUigPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722246908; x=1722333308; bh=wXV/r3Ef+RSOwF3n9b+Go+Q2efek
	HDW22bLwz2SfG8U=; b=BYEV6eolZK5ALcEAnnnsWy2rseyxqIwqhekuEBooGfxD
	7KrNXk/OH6YQBNw1YlT9clYlTtk0DiCuRNt38id90a0aXgq6oj/BIWJZkUBhCiQf
	jaiLN2Zyj37g+Z8uy6O/NgySBsWOMlQz3mDxQHV0DKdXW/ejJKMcrIreCHEUzgj/
	3VExgSckmfDM4jrm5fVvf4/wPFm+gRhEKTTOCv2QOHka0wOz6PQg+8d5aAwu4x0W
	F+Dojy9u4xwYL4G/u4GtiZTkkItQ1yC0oTdBUvIHaRKL3+QlTP8+6IvVWvyP59dF
	95JebUMqIJpnI52cNdVv1fKREF4tg+Z5FNIWMmH+zQ==
X-ME-Sender: <xms:_GanZuUFj9a4RBACPe0wzqbttPE7veUNjUeWZ8rCXHqnfRFxmGkAIQ>
    <xme:_GanZqlcQycvH9Nwsr8pFF0SMHpAdvNkQJlVIYe-YI2gPHk4lNhd97IVgCwttA8gO
    5_k54V12HnxP6mPA1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:_GanZiaiGi4ItI5HJqKLwKX8lOzNDC3NZ7MI-4UmXjAfZiY2oz3Z2g>
    <xmx:_GanZlWa8EJeZaqO_p8fzZTkloUL4bpdZryWl5E7xgzVJi6vl-Ml7g>
    <xmx:_GanZonYueOLEeXCG7W-f1RY4yUQV7OSCmBSnyZTyonKoC35cayIhw>
    <xmx:_GanZqfk3tsJlL3EsCDS-FlEQ1EvK20d-iRG8tAH4Lr1DsXB7JeMPQ>
    <xmx:_GanZhefW1QGQFVvsMx3iJHP8GHj0MEL_fFdncS-8VMEIz123uNHAZfP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0A546B6008D; Mon, 29 Jul 2024 05:55:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <502ee081-8e09-422a-a1f9-be40aeaa84fb@app.fastmail.com>
In-Reply-To: <bd4e9928-17b3-9257-8ba7-6b7f9bbb639a@linux-m68k.org>
References: 
 <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <20240729092807.2235937-1-geert@linux-m68k.org>
 <bd4e9928-17b3-9257-8ba7-6b7f9bbb639a@linux-m68k.org>
Date: Mon, 29 Jul 2024 11:54:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-mips@vger.kernel.org, dm-devel@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
 intel-xe@lists.freedesktop.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.11-rc1
Content-Type: text/plain

On Mon, Jul 29, 2024, at 11:35, Geert Uytterhoeven wrote:
>
>>  + /kisskb/src/kernel/fork.c: error: #warning clone3() entry point is missing, please fix [-Werror=cpp]:  => 3072:2
>
> sh4-gcc13/se{7619,7750}_defconfig
> sh4-gcc13/sh-all{mod,no,yes}config
> sh4-gcc13/sh-defconfig
> sparc64-gcc5/sparc-allnoconfig
> sparc64-gcc{5,13}/sparc32_defconfig
> sparc64-gcc{5,13}/sparc64-{allno,def}config
> sparc64-gcc13/sparc-all{mod,no}config
> sparc64-gcc13/sparc64-allmodconfig

Hexagon and NIOS2 as well, but this is expected. I really just
moved the warning into the actual implementation, the warning
is the same as before. hexagon and sh look like they should be
trivial, it's just that nobody seems to care. I'm sure the
patches were posted before and never applied.

sparc and nios2 do need some real work to write and test
the wrappers.

It does look like CONFIG_WERROR did not fail the build before
505d66d1abfb ("clone3: drop __ARCH_WANT_SYS_CLONE3 macro")
as it probably was intended.

      Arnd

