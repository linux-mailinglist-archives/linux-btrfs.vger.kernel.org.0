Return-Path: <linux-btrfs+bounces-15213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D3AAF6388
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28624E7BFE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623C2D77E0;
	Wed,  2 Jul 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="cbIOmuoW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F52BE65F;
	Wed,  2 Jul 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489231; cv=none; b=mnnJW7oRV4VZ+OLVv5pWmzL14YHIMxagrr9WocplsxAKPVJNsfUGnMSJ/BPrtjlV5h5esX40lmS8yWJDTOoMqmYrk6wDj7vhXh/pHdBVfjm+Dy+w6FR50O9NEtxNO+4747yVKX0CHdEOcln6tCDS9oCNgTR7CXnvQHULLqPcDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489231; c=relaxed/simple;
	bh=b7KpTvLGxlxB3a/FnKhICdjRjsnZi/EjjVjuL7ed9+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CczavsrYvqFMpGkSa7pEYa+nWxbToQwVg2Dy32LjmCtKLSliLj5/KlC2nE4ncYWztRFDwjLn1B3OvA+g3cS/E/iGAWYnG32aB7eC2SRTH7G1BvzBdzfHbWvG/fytlGnIk/0JYqPxA4ga7/H4vXPpB+lhDOig8w9TQJAILsQMpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=cbIOmuoW; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bXX4z2XGPz9t9v;
	Wed,  2 Jul 2025 22:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1751489219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj9HS6v1hLzfdQ76bVuuUjdPTAKEhhmP3lT0F4JEgMs=;
	b=cbIOmuoWsdnUS+VhCcJFdQKvp1C+3vx47T9m38YeVQekkwpWuPusmL3EbsDs/jVk0RMGeJ
	zb8qJvAGsSfR1fGrlU6O7N8D3HzrJK5gWtkZseHygqRRy90cjJUCXgYPjQU5Qcj3VV4leU
	iW/5NgQfZrgESGsWNQ8/+khwj6itDmmpETAOnLd/7Uh7cc/gt8OFDeIxFdZF4BykFkR6s2
	m8pL1iPm53JWvHB10KZQC1FgclV4vvHMfPryKXRh2xTmnI7J4nX6nsWJ64yFShduVALgUg
	SOATgFC7W5jG5J2oB1dpvLpDbvrp3aE3FGvq4bbaJU4vvwYBHSq/fnog83gx6Q==
Date: Thu, 3 Jul 2025 02:16:48 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	kees@kernel.org, ailiop@suse.com, mark@harmstone.com, 
	David Sterba <dsterba@suse.cz>, Brahmajit Das <bdas@suse.de>
Subject: Re: [PATCH v4] btrfs: replace deprecated strcpy with strscpy
Message-ID: <pef6rt4ggd2gizakr7kqr2p4yn5mh6rqlqojuwx3gaoiexycxi@bzgezdja3pst>
References: <20250620164957.14922-1-listout@listout.xyz>
 <20250702182712.GA3453770@ax162>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702182712.GA3453770@ax162>
X-Rspamd-Queue-Id: 4bXX4z2XGPz9t9v

On 02.07.2025 11:27, Nathan Chancellor wrote:
> Hi Brahmajit,
> 
> On Fri, Jun 20, 2025 at 10:19:57PM +0530, Brahmajit Das wrote:
... snip ...
> 
> It looks like the offset_in_page(buf) part of the WARN() in
> sysfs_emit() gets triggered with this, presumably because kmalloc()
> returns something that is not page aligned like sysfs_emit() requires?
> 
> Cheers,
> Nathan

Hey Nathan, thanks for reporting this. From the QEMU logs this looks
like on ARM64. Unfortunately I didn't boot test on arm due to not having
the hardware. I'll setup a qemu test env. for ARM and get back.

Sorry I'm new to kernel development.
-- 
Regards,
listout

