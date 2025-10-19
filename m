Return-Path: <linux-btrfs+bounces-18013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB05BEE734
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFF4021E6
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4072EB5C8;
	Sun, 19 Oct 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DAENDZL9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659652E7BA5;
	Sun, 19 Oct 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884606; cv=none; b=M3sfE+c8abcY07GMBD8G0B9mLRSz2vMIpGsB/5ndxJpy9Bz2/+Pmo2Y2+wxm+kCrntiL6zB4wrpEm5qNbh8Avc1zSAw1fUx1g/G7WnHlSZ/QEFmK06pl+O6NPjMnv5M1c9Q4DpMJI8WyEJSS2n1S7XhnDmMAMjCL3fUowmrJEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884606; c=relaxed/simple;
	bh=2xUKFX7jw6qWv0HUe8RCDkQBGTXDQ0mfdbRecnCXCZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX2BMW4bQFYNT4KGCF1i3cKrL60s8qbo5fqRtRWsKlkoBI/dHZRPI2UIE6TqVIoMLqw51E3tsdlkM55m8q4+8hlN8NCOyW6HJD05wseKNr+RA9bckJIoCLfiskMd3MihzpNzTvNkgLwUTHOb/zOIn85GYsQN8aRTE88t3qNRt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DAENDZL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406FAC4CEE7;
	Sun, 19 Oct 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DAENDZL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1760884599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ij+Sm1Vah+l0KCMrEHjRbzH5BNb2BrYiDgNTHM/FUDw=;
	b=DAENDZL99fVwH3WpVJgi/8/EKcff+KC0u6xxQjNTNgORIUrG1JrkuT8CoMfg81Gxd4CyGa
	jzUOyMalaPFF28PmJwyRiXVvJsS09conv3gMe6DSIF4cCFiF7acLgon+XVvlARpc585s0g
	/hw1Xtk7e06jFuTtUv2OC8iX1NG+D5Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5b1ef5a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 19 Oct 2025 14:36:38 +0000 (UTC)
Date: Sun, 19 Oct 2025 16:36:36 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 01/10] lib/crypto: blake2s: Adjust parameter order of
 blake2s()
Message-ID: <aPT3dImhaI6Dpqs7@zx2c4.com>
References: <20251018043106.375964-1-ebiggers@kernel.org>
 <20251018043106.375964-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251018043106.375964-2-ebiggers@kernel.org>

On Fri, Oct 17, 2025 at 09:30:57PM -0700, Eric Biggers wrote:
> Reorder the parameters of blake2s() from (out, in, key, outlen, inlen,
> keylen) to (key, keylen, in, inlen, out, outlen).

No objections to putting the size next to the argument. That makes
sense. But the order really should be:

    out, outlen, in, inlen, key, keylen

in order to match normal APIs that output data. The output argument goes
first. The input argument goes next. Auxiliary information goes after.

