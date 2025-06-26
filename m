Return-Path: <linux-btrfs+bounces-15011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2007AEA95A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 00:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9A41C42EBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D619264A74;
	Thu, 26 Jun 2025 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="PoCInKup"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323320C024
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975766; cv=none; b=HJJ+BBmd73EzulCshQnt6cby2QJElhllc0aMqzZhedvZTXEnqrEPKDS2LKNm7alR5Q7ch94g2m/n8yAJq4NRXRfWS6Wcrs77F7rH7ZA8IUjdoDapUgyKEJffTB5Z7bznuEfcofvAaX/pnsiwDxhfxVQpUIkHd+bEX2Wg633j6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975766; c=relaxed/simple;
	bh=3pdoaOxl79EmIVeSqJYi34fgvKw/MCUPhxbTjcgdPU4=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VI7P2GEFWTIJGgZwdsqwczsVh27Wm0Z5TXA4RRhY8zrAqCM6uzSU+ogizwI1RY5qEXIHhjY2ea5mVs1OGgezls47So371/ZmbQCOA3LjryVL2ph59ClKb8ScHTLHePTadlQH1TowrU8gPh+AZGK93ZrAzHKObzMKmLuCsG5OTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=PoCInKup; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 1B745290A20
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 23:09:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1750975747;
	bh=ILxhK1ZCX7uXggqNT+Ld8H3IqHod/+K1x3aRu0NbtsE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=PoCInKupAvXD/GQQwazjpNcZWYCfGcBLB1BS4iFs1xUCSSLHhSiem8m9XJsaqSsjL
	 sFCQ2qZylcAusxHDLDphZt/0J9fEycNUscBsFZ4WcQlTA2bw+WmQzW5PbPoGwCfhgs
	 h3eIiGJPQym1qOnuTaToOlTi5sEFIUUDpMfQO+tk=
Message-ID: <0e60acd0-8a20-49cb-8029-5dbf90b426db@harmstone.com>
Date: Thu, 26 Jun 2025 18:10:38 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 00/12] btrfs: remap tree
To: linux-btrfs@vger.kernel.org
References: <20250605162345.2561026-1-maharmstone@fb.com>
Content-Language: en-GB
From: Mark Harmstone <mark@harmstone.com>
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Some performance figures for this.

There's a statistically insignificant slowdown doing I/O after a balance:

	Compiling kernel after balance (5 times)
	925s	without remap-tree
	926s	with remap-tree

Doing I/O with a balance looping in the background is slightly quicker:

	Compiling kernel while balancing
	209s	without remap-tree
	207s	with remap-tree

Doing a data balance with a 10MB file snapshotted 100,000 times is far, 
far quicker:

	Balancing with 100,000 snapshots
	29.4s	without remap-tree
	0.089s	with remap-tree

I can provide the exact scripts for any of this if anybody's interested.

Mark

