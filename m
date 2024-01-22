Return-Path: <linux-btrfs+bounces-1597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A372F83632F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 13:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AD328BAE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FD13BB37;
	Mon, 22 Jan 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zLm3X1P2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lt2wcBiG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h67OjtXQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ugXGjEf/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28C3BB22;
	Mon, 22 Jan 2024 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926365; cv=none; b=ct5G27Q3GdRtta+5155cf6mF+1dPCPMGLZ5OLU/U2uRwQLAs6gtzBm5+q9Ax5B1cat6QLabZ5b3gcNsxugc05gpUZRbKcwBP7LRKUAlsm7kQcowm/lqe4RkFev1OdrEcN/djP9RR9CNSHNn4yZY9mJuriPYnMhJZ6dAZL/9ozH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926365; c=relaxed/simple;
	bh=bmWNAOKPTYlERMdCB7AZ9c76bRssMyeNpivF/fb2FnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3UcKqxzA3CFpAE7JTe+55pDAfhLpO6GB7CqQEgAKauW3sasqWhoRFUpiuMJ1fhE/3BjbmBtRqrtpZ5rC1Q0JMVfaXVR0K/QoIfBN865Om613jwmXKYivktFuoWpj7eMewSXNgM6Uiyw8Vq/y4b2J/nTlGQAaG/UFchXRJTKkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zLm3X1P2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lt2wcBiG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h67OjtXQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ugXGjEf/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31CD621FEE;
	Mon, 22 Jan 2024 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705926360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNDs2o2K3jWzu8TeQurE7mCFhHc888AjM0fRIpc2giw=;
	b=zLm3X1P2n4B5osjUN9h9AEGKh6ee1+0pbrUFYnz86WA9By4tXPEpfMy6iGPT8sR7LocOs+
	QsBMGhFRrezjx55+v0es8gZNcVdXW5piPPsmJ/eln6XUaGCHlpX66GvLbeH00YEvglmdLH
	ARTXuml7/3p6WSOi+TifbhfELQk4wVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705926360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNDs2o2K3jWzu8TeQurE7mCFhHc888AjM0fRIpc2giw=;
	b=Lt2wcBiGQsy131RHjrjf2EobN43qX5k0cEJP3Ah0UUXgwZ+jnzGPDzkCwECgBvhRFJKB51
	iVlO3X4wctKXTMBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705926358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNDs2o2K3jWzu8TeQurE7mCFhHc888AjM0fRIpc2giw=;
	b=h67OjtXQN+0N2jfCWwkXA331rhQNMNf7ci3zh3ub3dumJ+m+udeCfayyUbZkDugUe98gy4
	Cmk7W/WXOqw3+XNOS+/zLdUxi1FDwUASVwJkI7eQ1RqUX7rR6rxNvv7qesT77SF2G/FWL0
	hOXvQkLO1b5L0FbQkOarHPUDb336o6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705926358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNDs2o2K3jWzu8TeQurE7mCFhHc888AjM0fRIpc2giw=;
	b=ugXGjEf/P7R/YiFtbgHZEriWrT/1i0igli1EdeCb4n/Kl+d8pwoggeGH6uurxfOG6ZeiBQ
	qGKY7qCZXOVu4UBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42A69139A2;
	Mon, 22 Jan 2024 12:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uxH2ONNermW0LQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 22 Jan 2024 12:25:55 +0000
Date: Mon, 22 Jan 2024 23:25:38 +1100
From: David Disseldorp <ddiss@suse.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>,
 fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/zoned: test premature ENOSPC because of reclaim
 being too slow
Message-ID: <20240122232538.2a2bbca1@echidna>
In-Reply-To: <20240122105554.1077035-1-johannes.thumshirn@wdc.com>
References: <20240122105554.1077035-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

Hi Johannes,

On Mon, 22 Jan 2024 02:55:54 -0800, Johannes Thumshirn wrote:

> Add a test writing a file of 60% the drive size on a zoned btrfs and then
> overwriting the file again.
> 
> On fast drives this will cause premature ENOSPC because the reclaim
> process isn't triggered fast enough.
> 
> The kernel patch for this issue is:
>  btrfs: zoned: wake up cleaner sooner if needed
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/310     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
> 
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 000000000000..6f6f5542f73f
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Write a single file with 60% disk size to a zoned btrfs and then overwrite
> +# it again. On kernels without the fix this results in ENOSPC.
> +#
> +# This issue is fixed by the following kernel patch:
> +#    btrfs: zoned: wake up cleaner sooner if needed

To-be-queued fixes are often flagged in the test via:
_fixed_by_kernel_commit XXXXXXXXXXXX \
	"btrfs: zoned: wake up cleaner sooner if needed"

> +
> +. ./common/preamble
> +_begin_fstest auto enospc rw zone
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs

I don't see anything btrfs specific here, aside from the actual bug
being triggered.
Would it make sense to move this to generic, or would that be a waste of
cycles for non-zone envs?

> +_require_scratch
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +devsize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/size)
> +devsize=$(expr $devsize \* 512)
> +filesize=$(expr $devsize \* 60 / 100)
> +
> +fio_config=$tmp.fio
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	rm -f $tmp.*
> +}

nit: looks like there's no need to override the default cleanup.

Test looks fine otherwise.

Cheers, David

