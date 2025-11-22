Return-Path: <linux-btrfs+bounces-19263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28DC7C082
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 01:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D917335ED09
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D223D7D8;
	Sat, 22 Nov 2025 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWjk9N8d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C814A91;
	Sat, 22 Nov 2025 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772724; cv=none; b=GUC9yUb5+BRlsIp06vv/1Y5tCi/dgtq7ok6kaDVbDoLCgbAh/f2OvaXkGrrEqIribAK9abvIKq7dtyLO650wuiT/5CuK1DAbsEGBzjCsgiu65KcyoZvOg/6sjL1pVdL1R7g0382XLg63gx4isJKexsGhVVCwVoBDuUKrO/SDyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772724; c=relaxed/simple;
	bh=WeOuYkSdA1MDcv3G8G4Cvn5JzKAR8WohLwbgyaSTALs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ralbUWCasokWTOVBkt1Dc2/hGfow6gk+omnXISUjX1vJX5/TssmNvefFZCbwSJgIlpHB/6kA8XSg0qewGbONMSZ5fG6D7hw6wm9qZVEUhS5Kcq0F1uONAzFODdnv3+koirnQky+Pg6wG5qu5Vx73nuDUKa+32M5PglxpYKa99gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWjk9N8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFDAC4CEF1;
	Sat, 22 Nov 2025 00:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763772722;
	bh=WeOuYkSdA1MDcv3G8G4Cvn5JzKAR8WohLwbgyaSTALs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWjk9N8dMgfKgkqNNsev4bYLXIJaF0Thz2mLNGSPjbZ9GKe+xRYf7ky0zjpZHags+
	 DTj2PmkkzjtlEcSc9eFqlO7hN4WfSdkbF5ZLjUmOcslSx+JR8KCxAbdc13IQEiV59F
	 dPCXaP/WtapvMJCdZi6NBHW/3scPR90NLVDGxuD0RB6KA3ZvzjKWVCxqrteFYyb56M
	 NBrLruG3EnOWg88mcYnncupTPZxQMsSNnI2/+u2MGVSc9WugtKzpSvh0S+EfyApqKD
	 3frzneEWcktTqOMYXcR2yCUUFsohPma2Zg7FhI0ztm3puy0OdDt47CTeZoHtLGfsNi
	 GLJBpX3hRv2mw==
Date: Sat, 22 Nov 2025 00:52:00 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: docs: add warning for btrfs checksum
 features
Message-ID: <20251122005200.GC3300186@google.com>
References: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
 <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org>
 <bc5249ba-9c39-42b1-903d-e50375a433d2@suse.com>
 <3C200394-F95B-4D1C-9256-3718E331ED34@scientia.org>
 <5495561f-415d-4bb0-9cd4-4543c510f111@suse.com>
 <5493c0684cc1014614ae156e9b8888d52857d2bf.camel@scientia.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5493c0684cc1014614ae156e9b8888d52857d2bf.camel@scientia.org>

On Sat, Nov 22, 2025 at 12:55:18AM +0100, Christoph Anton Mitterer wrote:
> On Fri, 2025-11-21 at 17:14 +1030, Qu Wenruo wrote:
> > 
> > Adding linux-crypto list for more feedback.
> 
> It would be good if any of them could confirm or reject:
> 
> - Whether a filesystem that uses full checksumming (data + meta-data)
> and that is encrypted with dm-crypt,... is effectively integrity
> protected like it would be with an AEAD.

No, encrypting checksummed data using an unauthenticated encryption mode
isn't equivalent to an AEAD.

- Eric

