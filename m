Return-Path: <linux-btrfs+bounces-1122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F781C48C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 06:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74971F23F39
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 05:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3EB63B9;
	Fri, 22 Dec 2023 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Djgbvez6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1jQpRtnW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Djgbvez6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1jQpRtnW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BA6112;
	Fri, 22 Dec 2023 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 474811FC24;
	Fri, 22 Dec 2023 05:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703221660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFidapggxzA/WY5jl5BDs3zsjb/1/XUdwqY1NvUCmTY=;
	b=Djgbvez6Db6DpuM7//FBl1ET15/GMPPlm5GTmYY71+J3T769g+m0VRQLHnSKATB0V4Myq6
	WuGYRz0w2hP/pk2/CotCVyE9ZB8owIbP5TLhsKlov5qQfXO5d6pDY7uOXAdA6S/fbiExYD
	QU+19TQzi6ug2b71eKSp5lUFL/lV8HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703221660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFidapggxzA/WY5jl5BDs3zsjb/1/XUdwqY1NvUCmTY=;
	b=1jQpRtnWzrsXASnzJ56wJpsZojhJNzUIWezMjNgpmqxkS6mfXnoqgz+egbakmbU3MJiBH1
	aelHVJ4hvBzWTMCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703221660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFidapggxzA/WY5jl5BDs3zsjb/1/XUdwqY1NvUCmTY=;
	b=Djgbvez6Db6DpuM7//FBl1ET15/GMPPlm5GTmYY71+J3T769g+m0VRQLHnSKATB0V4Myq6
	WuGYRz0w2hP/pk2/CotCVyE9ZB8owIbP5TLhsKlov5qQfXO5d6pDY7uOXAdA6S/fbiExYD
	QU+19TQzi6ug2b71eKSp5lUFL/lV8HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703221660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFidapggxzA/WY5jl5BDs3zsjb/1/XUdwqY1NvUCmTY=;
	b=1jQpRtnWzrsXASnzJ56wJpsZojhJNzUIWezMjNgpmqxkS6mfXnoqgz+egbakmbU3MJiBH1
	aelHVJ4hvBzWTMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B244F13AB5;
	Fri, 22 Dec 2023 05:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id leoME5oZhWVDVwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 22 Dec 2023 05:07:38 +0000
Date: Fri, 22 Dec 2023 16:07:26 +1100
From: David Disseldorp <ddiss@suse.de>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: use proper filter for subvolume
 deletion
Message-ID: <20231222160726.7206676f@echidna>
In-Reply-To: <727fc0e695846a43830bdfc2d6757d6edc2d6878.1703213691.git.naohiro.aota@wdc.com>
References: <727fc0e695846a43830bdfc2d6757d6edc2d6878.1703213691.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.77
X-Spamd-Result: default: False [-3.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.846];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, 22 Dec 2023 11:56:22 +0900, Naohiro Aota wrote:

> Test cases btrfs/208, 233, 276 does not use _filter_btrfs_subvol_delete()
> to process "btrfs subvolume delete" command's output. So, the following
> diff occurs even with a previous fix.
> 
> btrfs/208       - output mismatch (see /host/btrfs/208.out.bad)
>     --- tests/btrfs/208.out     2023-12-22 02:09:18.000000000 +0000
>     +++ /host/btrfs/208.out.bad 2023-12-22 02:21:40.697036486 +0000
>     @@ -6,12 +6,12 @@
>      subvol1
>      subvol2
>      subvol3
>     -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
>     +Delete subvolume 256 (no-commit): 'SCRATCH_MNT/subvol1'
>      After deleting one subvolume:
>      subvol2
>     ...
> 
> Let them use the filter and fix the output accordingly.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>
One minor nit...

> ---
>  tests/btrfs/208     | 2 +-
>  tests/btrfs/208.out | 6 +++---
>  tests/btrfs/233     | 3 ++-
>  tests/btrfs/233.out | 4 ++--
>  tests/btrfs/276     | 3 ++-
>  tests/btrfs/276.out | 2 +-
>  6 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/btrfs/208 b/tests/btrfs/208
> index 909f9fa40803..d58803e2f801 100755
> --- a/tests/btrfs/208
> +++ b/tests/btrfs/208
> @@ -28,7 +28,7 @@ _delete_and_list()
>  	local msg="$2"
>  
>  	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
> -	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
> +	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_btrfs_subvol_delete
>  
>  	echo "$msg"
>  	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> diff --git a/tests/btrfs/208.out b/tests/btrfs/208.out
> index 9b660699a4b2..dc5761ba1c87 100644
> --- a/tests/btrfs/208.out
> +++ b/tests/btrfs/208.out
> @@ -6,12 +6,12 @@ Current subvolume ids:
>  subvol1
>  subvol2
>  subvol3
> -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
> +Delete subvolume 'SCRATCH_MNT/subvol1'
>  After deleting one subvolume:
>  subvol2
>  subvol3
> -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
> +Delete subvolume 'SCRATCH_MNT/subvol3'
>  Last remaining subvolume:
>  subvol2
> -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
> +Delete subvolume 'SCRATCH_MNT/subvol2'
>  All subvolumes removed.
> diff --git a/tests/btrfs/233 b/tests/btrfs/233
> index 2b94a9c6befe..f2c1eba090be 100755
> --- a/tests/btrfs/233
> +++ b/tests/btrfs/233
> @@ -21,6 +21,7 @@ _cleanup()
>  
>  # Import common functions.
>  . ./common/filter
> +. ./common/filter.btrfs

common/filter.btrfs sources common/filter, so you can replace these.

