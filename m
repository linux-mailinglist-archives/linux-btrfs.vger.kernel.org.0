Return-Path: <linux-btrfs+bounces-9572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18A59C68FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 06:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A7F1F2549F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 05:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560D176251;
	Wed, 13 Nov 2024 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="X+qum1As"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B87081F
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477552; cv=none; b=kkG0lS9V2+fAkl7D8qeae8PrvnLZrN8J72UvpvzEMPrbSKJGftBX6kyfF5Rozl8p+0th4+n4zLH0/nqYhjdknppfERMm+AjiB/a/m4QcpHD5I/yhmGd6so7OzerMf8Ejz4Myh/1KglVJwteeM6gcywhl2S5ekJJ5o+KYCSo1Cdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477552; c=relaxed/simple;
	bh=eb8RtMicM8yRxxjDZUuRc18LCCriuYnzD5sfltfhUTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T2LeVCsSdZnk6TP80u+V152LhqwZ4TM1JV1g5V6iGvRJ+P59VGIvViaZveGIGndo/vVvzxE58xLYHQ8kXThT6NkKV6RK3xqW7z41Me9V+V7m2/u/CYc9CR3hCal82uAWBMw5eADz+Bk11MjQHxa6/tFuq+ExAWyd5lFb5dej0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=X+qum1As; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 20EFE14C1E1;
	Wed, 13 Nov 2024 06:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731477540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qai2R3g4jfEr1/pzQkv0elU3wIOXS3oOYIVz6ia3arM=;
	b=X+qum1AsFQHRuS7jQgOBBXCuqGeIWnGyajlO1nEo6xC4pLIXL0kQJrAqz/2Rh3PIsRifQ2
	RdB+ulhV2VQlc1yQMK+P+AiXDV9NZrOvH3v+dhZRBGsWuz7wv99DoKN+FI++sli9spY6aU
	os8WavcfSj9ez9JwZvOkiXofgWJxaHS2iWHUJ6QVGLaAUspmMTUYCRA0zizR021nP4A2bv
	DhGEQLbmzTDv8wm4ImdjmyKvNR+8htmIFOVdWC7wsZK1V7sZVWARr327P6fq1ZwCVVs/R1
	IqumASm4hvD2ct5atAI+Ry7Av82Bh5TSlSkIqC4hZsdjvuZ9YI8K7zjAzpn4jA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 14ab8819;
	Wed, 13 Nov 2024 05:58:57 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:58:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Tom Rini <trini@konsulko.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on
 'load'
Message-ID: <ZzRAEgQYS46yM7Ct@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dominique Martinet wrote on Wed, Nov 06, 2024 at 09:56:42AM +0900:
> Running commands such as 'load mmc 2:1 $addr $path' when path does not
> exists historically do not print any error on filesystems such as ext4
> or fat.
> Changing the root filesystem to btrfs would make existing boot script
> print 'Cannot lookup file xxx' errors, confusing customers wondering if
> there is a problem when the mmc load command was used in a if (for
> example to load boot.scr conditionally)

Ugh, sorry, I was a bit quick on checking with an updated u-boot on
this... our tree is *cough* slightly *cough* old and that was the case
at the time, but since somewhere in 2020 there is a warning in fs/fs.c
in case load fails.

That doesn't change the fact that this patch is useful to avoid the
message being printed twice, but I'll need to update my scripts anyway
to use `size` first instead (as a first approximation of `test -e`)

Please let me know if you want me to resend this with an updated commit
message; otherwise I'll let this sleep.

-- 
Dominique

