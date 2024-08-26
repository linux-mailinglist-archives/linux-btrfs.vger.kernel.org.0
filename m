Return-Path: <linux-btrfs+bounces-7503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38AE95F447
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029CC1C21EB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535C918D64D;
	Mon, 26 Aug 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BNW4h0rG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE91553A3
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683611; cv=none; b=f2TzIBFAzTSvsJPsI3g+ms2ASZDMQ2ow48PF281CkqRm8PZuTzKFYn6ZJtaIqk8VpGNu0oO/o6OMpzbNmM3vdkbeZSPfA/r0Vq1Co1fynKdVDedG8+7bB4ag4aXFwnCsMBuBq+Kn1I0WotwMukfHULOUcTntFzpn2PSq6FVjs4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683611; c=relaxed/simple;
	bh=PTRRo3dzvxOaNSFDJFiuouiSsXgmh8iKTeY86UaaLzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dciqp5vJH+bsUo73QvYtNxOx7j99Tj1ioXHecEEmxJ1+fL81tvOXnbNx3cucb8mqqK6B3dfXodOORCHLWO7Ek77RtATSR7vDVaVu+VO86d/yXKzVl2DGRMms7ghHWfpWc7K+WbcAJCi6oiKFUvmazQpX1wolPV/YFgD5qbBUjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BNW4h0rG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a35eff1d06so296125385a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724683608; x=1725288408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=60roTMKnLbimtxG7vYaCnFjaEybHDOPOa/gCDo0rA3E=;
        b=BNW4h0rGd/bRTcmM//rHce5moOp3kqq6aj/cEDAruQ838jPkgKs6OrmcR4sNK2Kzvy
         rPNDfBw37RF5HeRB64VehjMmG05nX/154JpiylBux/nIh4SQzFMl4e3Qqo32GxeW3Dfm
         Bh+Atbj0IeKBTx8zCZWc6oUFmwjmjTUKI6pS6lNsaMtXLNrlJGDZfGnxmjHqsUsy6z3f
         6n6zIJMQDDNkBBN+CPU+4h1ID4s20t0VCjosNoVz6VhBK/bEyvVGBL3rNhNA+ZLTeJlL
         J22VZHr7Fg4M+9B2Lbbj3gURYun32oVntcV2C17HSfvqmfy/rF2ZsMw9WhQv6P5aO4cW
         DWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683608; x=1725288408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60roTMKnLbimtxG7vYaCnFjaEybHDOPOa/gCDo0rA3E=;
        b=tUBKRJoWlqMAgPu5I/MP1u2Xvu3MEOr4YQS5ZD7YCM4ZuCq8RB2VPPorWFWALJu3oH
         Fi81f8EgwlGbweZLzpvrwjhkXxLRq4lQ43RcwwFoewTXxu3zqLScTsNkB7znnsFudfXZ
         KQokTo47pZocYvJpioao+1SU4tVWQZNHF3lp2Ve5HwMVZ45n1TIauE3IZ0pIIrszpwxW
         zr8Fl3VRXeLO3Kiy2FnPkfhAaNQk8bQtIWCkdT0nS/mAeVrYRH74CFozsAtMDNf3shQ5
         q1dXOPooKK4QviYTxWwB/SmDN0pPXzGVVanebsxpc8GKkjWn7uNrS1yNeosFg3T4yaEW
         KVBw==
X-Forwarded-Encrypted: i=1; AJvYcCWVbLwUOjr38VlXhn8hllP/PTug5stix4rxevm82wVkleuU7rTpMUhtXlGI1P5cPEKomwWI/eYaH/fAFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSlCwQ8kJyXodnAfkSS+Z2JhxZeLWLd8Fx9lf/HOoQ/o1tx3o
	uP5duP1SR/jmtlteAjXeo/Tr2nUQtbKhDpKSYmb0+qLOuqZ7beVh8pUx1ZlzFng=
X-Google-Smtp-Source: AGHT+IGMYjCw+APmqru5dS4wTd9OzfykuTBi4S2Ig6gWIxrjbdQ0apShQOaiLdv3zAy46uekrtWwLg==
X-Received: by 2002:a05:620a:408f:b0:79e:ff64:39c4 with SMTP id af79cd13be357-7a6896d0f8bmr1285736085a.6.1724683608231;
        Mon, 26 Aug 2024 07:46:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f34233csm459903485a.35.2024.08.26.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:46:47 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:46:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/319: add git commit ID
Message-ID: <20240826144646.GE2393039@perftesting>
References: <fbcd0be9cf4a58086074157ea8ddd3a85eab6650.1724674946.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcd0be9cf4a58086074157ea8ddd3a85eab6650.1724674946.git.fdmanana@suse.com>

On Mon, Aug 26, 2024 at 01:22:57PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The kernel patch was merged into Linus' tree, so update the 'xxxxxxxxxxxx'
> stub with the respective git commit ID.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

