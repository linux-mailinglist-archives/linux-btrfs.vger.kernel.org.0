Return-Path: <linux-btrfs+bounces-15219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06918AF66D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 02:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14849488522
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 00:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D033594F;
	Thu,  3 Jul 2025 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="Vh89Nxq6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25B2F29;
	Thu,  3 Jul 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503122; cv=none; b=GxKbWNj6HMLO+NBtQhVFu1mNI+5R/5GqQ7kjBUvim5u+iM+awXxc7pv072pty9uruz4NO5QzE0XZkp/sWM8mVvnJtDHdpiLwMXrByXEMm6MFnk5YoO3ONrF0B2r3uovdoxD/w/hElz7Qx0sfZ63VNPBGg8tGEHUsqIaREBwuoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503122; c=relaxed/simple;
	bh=g9Me9kmoPTzT0HnHlWcgqhB/Q5G0RngRw+bx7+XrqVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/P38QfBhJGgJEjET44zt2ZSZT6H+7a5YXvKVUmOFeeEpxuiikO0DkEche/PqNbOLSI0MTwdUKTenCCY7cTYY40SPzZBEkQnKj36sA3v/sFLWbIYUGWp+ivTJIsg3m7k/pJCGO1t+C2UPfLaAQPH1WAt4+ilofvhZgMOEO11+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=Vh89Nxq6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bXdDD4nMKz9tc3;
	Thu,  3 Jul 2025 02:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1751503116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PoB/Y9BQu84C/gSWrL3uiOGDePV7Lkp3Z6VQaSyvfV0=;
	b=Vh89Nxq6By/fLoaWcBiM6Z/uO1OB2vC06SSZd7oNyrWWtXILt8urquz8n36GhHmX48F0rs
	XsYKonuvgE/snaIQLZR0Pg1YNf3mxEO+8A7PDS9bUwiLZjFrWmWx2nWeJgJvMcJfq9fGSg
	aRm8Zr/G2096YSVWyMz8rYu6SIDXdTa7SpSW1fIr27U2F1gKjtebmZdf3leJ4Idf4dnRZb
	esNp8Jp9l1fdJNcjQV9CmrKPyOsYCDAVpbIUP5iGj3spu+5YrUQ4PHMrPaEvAPr9Hm/bPk
	PKZo/lwUQhWcduRws0IA1xiIVMNETnUhsuyPZ+obOKQ15yMrkQGOCOykXoCpgA==
Date: Thu, 3 Jul 2025 06:08:24 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	kees@kernel.org, ailiop@suse.com, mark@harmstone.com, 
	David Sterba <dsterba@suse.cz>, Brahmajit Das <bdas@suse.de>
Subject: Re: [PATCH v4] btrfs: replace deprecated strcpy with strscpy
Message-ID: <25hcimtuueppt4w3ccvid3d7c3eots7nat4qspdr6t6minxfa2@zb4fmwz7qsyp>
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

On 02.07.2025 11:27, Nathan Chancellor wrote:
> Hi Brahmajit,
> 
> On Fri, Jun 20, 2025 at 10:19:57PM +0530, Brahmajit Das wrote:
...
> 
> This change is now in -next as commit d282edfe8850 ("btrfs: replace
> strcpy() with strscpy()"), where this hunk appears to causes a slew of
> warnings on my arm64 systems along the lines of:
> 
...
> 
> It looks like the offset_in_page(buf) part of the WARN() in
> sysfs_emit() gets triggered with this, presumably because kmalloc()
> returns something that is not page aligned like sysfs_emit() requires?
> 
> Cheers,
> Nathan

Nathan, can you help me with providing a bit more info to debug this. I
set up qemu aarch64 env with btrfs but couldn't reproduce this issue by
boot test. Basically trying to understand what workflow triggered this.

You can find my kernel config, dmesg log and boot logs here:
https://gist.github.com/listout/de8b6efa6ddb02805b5886f35c3f73d4

Not to mention I'm very much open to suggestion from other btrfs
developers as well.
-- 
Regards,
listout

