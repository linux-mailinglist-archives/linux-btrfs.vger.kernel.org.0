Return-Path: <linux-btrfs+bounces-18014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1499BEE9A6
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9171897BBC
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A782EC557;
	Sun, 19 Oct 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSzKmNV5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C538F80;
	Sun, 19 Oct 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760890146; cv=none; b=SINB1ywf05x3BzC74TfcONR38H7AVgs3rlYneHRt/yzZIf/lhJuGCnhLiIIesvTPYwAUHo8IP4zSqTOaDeXjpJU2anj0WjkNowkDzLvkRUBY16VJib9HAYUkg4YsGxji+3nvD/l0VCnbGeWqXk4MxjqHcRZKD7ok3Vqr7w8fivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760890146; c=relaxed/simple;
	bh=FoS+s2SLs1a/86XBAZ0WcyxTGfRjJzC9vcvuY3cy8s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSwkQSm2xdqjn9s0nNpHq5EhkOZ8S4ClXTrIBuux/YNiuz5x8n3eu4O1MgF1aeaaR6JLOGoj4lKCoKzrMzyfRPIgejCSscUEIGRxJo+znzVHSfAt36mhvU47k5GxLKnIEcevuKyVFyVLWOBVxMPCsh2va9N717fkPD9Pc9TDN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSzKmNV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DBDC4CEE7;
	Sun, 19 Oct 2025 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760890142;
	bh=FoS+s2SLs1a/86XBAZ0WcyxTGfRjJzC9vcvuY3cy8s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSzKmNV5nZZpQE35pdj80lOCp8LM4F4tJMzwcpamC1HM52wkXYj5fLUcd+p3kVjBb
	 H9zyohTNWdHko6sau+nG5V8NJVBRbCDuj7QdrTmDmT/+frTTFCH5saLdVwqFxuiG9C
	 5KjqDIXvyu0UR+iaE+j5m/eGaNmZC6Taq/AqPskpLfKM2/SttDYS2ZHb2lIV0DFm8y
	 1Ht+Jp1r0WGLuCUiyOk3Nv/PxFcFdzgBc1O2VEBB7It2bVWAZWksZrEDNNwKw4YziX
	 VsAIr5Xz7HtzOyspCEZY7Gp0FGe/ReIR0/KcDt+VTfW2phqG6uA3/hiOA6EDjOxo5k
	 9jJVKfLjD9mWQ==
Date: Sun, 19 Oct 2025 09:07:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 01/10] lib/crypto: blake2s: Adjust parameter order of
 blake2s()
Message-ID: <20251019160729.GA1604@sol>
References: <20251018043106.375964-1-ebiggers@kernel.org>
 <20251018043106.375964-2-ebiggers@kernel.org>
 <aPT3dImhaI6Dpqs7@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPT3dImhaI6Dpqs7@zx2c4.com>

On Sun, Oct 19, 2025 at 04:36:36PM +0200, Jason A. Donenfeld wrote:
> On Fri, Oct 17, 2025 at 09:30:57PM -0700, Eric Biggers wrote:
> > Reorder the parameters of blake2s() from (out, in, key, outlen, inlen,
> > keylen) to (key, keylen, in, inlen, out, outlen).
> 
> No objections to putting the size next to the argument. That makes
> sense. But the order really should be:
> 
>     out, outlen, in, inlen, key, keylen
> 
> in order to match normal APIs that output data. The output argument goes
> first. The input argument goes next. Auxiliary information goes after.

In general, both conventions are common.  But in the other hashing
functions in the kernel, we've been using output last.  I'd like to
prioritize making it consistent with:

    md5()
    sha1()
    sha224()
    sha256()
    sha384()
    sha512()
    hmac_md5()
    hmac_sha1()
    hmac_sha224()
    hmac_sha256()
    hmac_sha384()
    hmac_sha512()
    hmac_md5_usingrawkey()
    hmac_sha1_usingrawkey()
    hmac_sha224_usingrawkey()
    hmac_sha256_usingrawkey()
    hmac_sha384_usingrawkey()
    hmac_sha512_usingrawkey()
    crypto_shash_finup()
    crypto_shash_digest()
    crypto_shash_tfm_digest()
    [and the SHA-3 functions in David's patchset]

- Eric

