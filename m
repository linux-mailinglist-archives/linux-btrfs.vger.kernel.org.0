Return-Path: <linux-btrfs+bounces-1636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004A838677
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 05:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BCC2853AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 04:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC520F1;
	Tue, 23 Jan 2024 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VFxfXXjS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3wa141uN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VFxfXXjS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3wa141uN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B01FB4;
	Tue, 23 Jan 2024 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985877; cv=none; b=JRotkR8kIyxVdOB024oUtrh8SNXC5cgE0ZZZ4ml5iBgFQaYC2EVkiJvunQmCmXn2bImCsi1srifmQAZx7lzW+Tu1o0HGhvozt42Iv1NvDBmuh+LOLCyuHK/xHlk+BK8vWY59jcNkSozcJ3IkgsWP4A5rdyBc12aXwwau3X6c2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985877; c=relaxed/simple;
	bh=3KQx26NFNzippL7HGM/EhzQ7ZK0SJX55NablMSJOD58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4GFj7Kn3Ow07OyBEY00z4cyE/1tjzZOn26j3OFdi2vQsnBIybQJZZRBWnb0v0vK4UkUrrNAyDay83cG8p5qIgj0ooXvyUVF8lr9NgNRwjlXnZjGq4d519SpTWMiJ7f04dj4z74k3/jnK30aEsMgbMqnLtTD+ZgCbIe95w4ncK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VFxfXXjS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3wa141uN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VFxfXXjS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3wa141uN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D6921F45B;
	Tue, 23 Jan 2024 04:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705985873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgcm5FiVZB7hvX8/V800PhCd7452sD6L0zg07mD6fM=;
	b=VFxfXXjSwXK06yl/0Vl9H3J7L2+omrUuIKCeHSBwgntslVrrbYXdV3MVhHuzUIjijzZnhg
	5JLwvoTJ3d5xVJym7D84c41NqtMs6Yv/f83seSc9oSr/ApZUV75QmPovL40E7KPzT4VVJN
	rvMfvCRT35keLf2jdXP7asVexc9C0IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705985873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgcm5FiVZB7hvX8/V800PhCd7452sD6L0zg07mD6fM=;
	b=3wa141uNrH0vvX57asxi7LZ8YVPXo+mogRe+tjS6GvrKPd7RZELmhL0GM5Syi3fA3V8tvJ
	b6VSsJHLfXtPbXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705985873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgcm5FiVZB7hvX8/V800PhCd7452sD6L0zg07mD6fM=;
	b=VFxfXXjSwXK06yl/0Vl9H3J7L2+omrUuIKCeHSBwgntslVrrbYXdV3MVhHuzUIjijzZnhg
	5JLwvoTJ3d5xVJym7D84c41NqtMs6Yv/f83seSc9oSr/ApZUV75QmPovL40E7KPzT4VVJN
	rvMfvCRT35keLf2jdXP7asVexc9C0IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705985873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgcm5FiVZB7hvX8/V800PhCd7452sD6L0zg07mD6fM=;
	b=3wa141uNrH0vvX57asxi7LZ8YVPXo+mogRe+tjS6GvrKPd7RZELmhL0GM5Syi3fA3V8tvJ
	b6VSsJHLfXtPbXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43607136A4;
	Tue, 23 Jan 2024 04:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3Ed/OE9Hr2UbPAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 23 Jan 2024 04:57:51 +0000
Date: Tue, 23 Jan 2024 15:57:45 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: verify the read behavior of compressed
 inline extent
Message-ID: <20240123155745.35941fec@echidna>
In-Reply-To: <20240123034908.25415-1-wqu@suse.com>
References: <20240123034908.25415-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 23 Jan 2024 14:19:08 +1030, Qu Wenruo wrote:

> [BUG]
> There is a report about reading a zstd compressed inline file extent
> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
> content.
> 
> [CAUSE]
> The root cause is a incorrect memcpy_to_page() call, which uses
> incorrect page offset, and can lead to either the VM_BUG_ON() as we may
> write beyond the page boundary, or writes into the incorrect offset of
> the page.
> 
> [TEST CASE]
> The test case would:
> 
> - Mount with the specified compress algorithm
> - Create a 4K file
> - Verify the 4K file is all inlined and compressed
> - Verify the content of the initial write
> - Cycle mount to drop all the page cache
> - Verify the content of the file again
> - Unmount and fsck the fs
> 
> This workload would be applied to all supported compression algorithms.
> And it can catch the problem correctly by triggering VM_BUG_ON(), as our
> workload would result decompressed extent size to be 4K, and would
> trigger the VM_BUG_ON() 100%.
> And with the revert or the new fix, the test case can pass safely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/310     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  2 ++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
> 
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 00000000..b514a8bc
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Make sure reading on an compressed inline extent is behaving correctly
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +# This test require inlined compressed extents creation, and all the writes
> +# are designed for 4K sector size.
> +_require_btrfs_inline_extents_creation
> +_require_btrfs_support_sectorsize 4096

Hopefully coverage can be expanded in future to cover some other sector
sizes. This looks fine for now:

Reviewed-by: David Disseldorp <ddiss@suse.de>

