Return-Path: <linux-btrfs+bounces-21650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMRjNqAejmnp/gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21650-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 19:40:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ED213058B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D47530427C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AC2877ED;
	Thu, 12 Feb 2026 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvikwpx7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYxbiM72"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4727586E
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770921616; cv=none; b=VJz+ASqnY/OlcaH3uHyqY36Zfwmg+/TC9s7Dep7qhC6iw4w/S+BzKFuChues8+WGhGS6edayaSYNfAKnOhhwRLlnPV1waTwmcLO99ZMxtGGvr2tKpswt1uu+8mx8Sj8IbUbiI4vaxImkC8ytBzMrFrFpmn/KTpioR9kaXZJrZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770921616; c=relaxed/simple;
	bh=g3KveXRy84ewrKb79rs3rt3LFpuRwuI+ZfACt5NfNUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGcC25VFSgIXuUB6Nck6Zb9Ovv/WmtUJ3kgbtj0kuf4h6HS9RK49rCb+Xre5k3S1Th3GAK/wXKoSBSE2t3tp56kTd6j2Li1pxpQZXUEo3/WtZekk6NEfAA+aMTFlvNpVo/u9CgGS5+PnitGbw4kMdYZdmnYMitDfeJtLdJsAI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kvikwpx7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYxbiM72; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770921614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rQ4D/44Wfm5LQQPoh3Nucbx0K4XT0hM6hTMK5vwuKg=;
	b=Kvikwpx7sDZlqk5c0PpF0vuYd3SyKVyRI2CYQG6BQATdNrAG+9bh1iPo1ljuDqTXePRQIb
	+Ovv4Q45TkBoX/V1OBM6HPHrqlKKprEPINrIJ19/2b6BkmrTBI7CQ/gOwul0p8GqBDPxVQ
	N3G3+oL4oxGB/3qNXFaTopeIaJz2woA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-tfLKleY2PUSAsprNrZIz_A-1; Thu, 12 Feb 2026 13:40:13 -0500
X-MC-Unique: tfLKleY2PUSAsprNrZIz_A-1
X-Mimecast-MFC-AGG-ID: tfLKleY2PUSAsprNrZIz_A_1770921612
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0eb08ceso580074a91.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 10:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770921612; x=1771526412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rQ4D/44Wfm5LQQPoh3Nucbx0K4XT0hM6hTMK5vwuKg=;
        b=XYxbiM72hzk0TYKw5sWQvXHxLeUKv6a+l0f9NW6ttUJbHeF1BXOz0XmC81rpzFut4h
         3+Bgw5JKt89+rRruEBfUo2jZKzEJJ35WzqsW6498UmMQmOUdDojuNfWL4w5FRYXe2lUq
         OQXehag3qi1wyYqIl3ias9hX0FJ2V5Hk/f+ulpfL85yVg0YpjmXTcRTt/VBk4UcNBs7y
         V9aZumPQUa34aRDJ51pUUNJs05Rr1Dx91so+D7onRWad6fnGJAulRV3RMPJtE/nn6dun
         TgnJAKPfa+nbyDAz+Mf5P/xT2we7rmJqz0bBAKzOMM1/vduNcfHYyQP5uCp6iQ4zFuFe
         qsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770921612; x=1771526412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rQ4D/44Wfm5LQQPoh3Nucbx0K4XT0hM6hTMK5vwuKg=;
        b=S7eNZDsiNJRuOtxZ15qnEnChMI4PkJp411tOR++qiUKfP+7U+gOQJlXPZ+rQJHtg/2
         BSrlSSXTHmlssME6kp/2RbNyV5/D87KGj9snhfbfYHsPJkj681jcMxNH1VLpmB+Feb3u
         PJ3jgyyFgrQ8IUDhvuUmenrBGTMcZOVsCsAXPXcLvFf6aDqlQoSi75ExaWGGelYKz7Q/
         P7EqPvkmuZe937EzGXPw4SnR4uoOrLrzNxBNmktE7n6vhEP7x3U8JV3KdBW76Z2RXHtx
         2+kuKrxTlwJUdHhiVM1FeDGJXgHNUsv5absGeEwrJNPu2XiWCumHtTSNnZTcecx70D+I
         3aOg==
X-Gm-Message-State: AOJu0YyO0hAZhBD0UxJyHV4uaunXnk3q4Uc0hi2yzJNxch5b7JYONdC4
	bc0GUzwtlHICNgN9bNvc/NXrfmaJFzXuUHWKi9O6kYfuATLr39OA7ALaZW1QWuKdXCXi5qkQl/5
	Hogj8gn7QAyJQxZPBcofXr3N7mFlKrD29nEgSgoPMo8zPPHk6A7s40Op0g6cL9FJV
X-Gm-Gg: AZuq6aL4wiERKl0Fdur1yFAMNBwWkIT2Dl6lEqYuAVPoul5XO61g/rbI2E4CDpBfW2n
	x3HA/7PQKic8H55Yw510z4e9d52ViY1hMU5aDUHmAcpeN4ScQex9p7TViwuDKa1KW5EqeZ+VH5p
	OaHTyemm8IgkOaKR9PxlaNJBpwcf1qelUtSM3zB4ZkfjwPxfV+yV44GOeIjc6xe5aDqcKdmYSWG
	sFhICuBprwpnpVsp64l+SCtazRaascch769XwLnDL5BlrqSPiYUpT5dLbp4zJ01re2p5N6G/ouh
	eWVBNE0zyHepZMVsTQdvAraH053I3oGpijRgsWQ1WyJ1KXOogosn7k+bFzkc4UxUpQtfqsSlb10
	2YV4bd7NPvkOVajo0uxN9GcKUmPJ0Y2Z/60HA8n0uGwSDoufFEVQyKYLquBSTLQ==
X-Received: by 2002:a17:90b:5583:b0:354:a284:3ff9 with SMTP id 98e67ed59e1d1-356a7a70dfbmr57590a91.26.1770921611925;
        Thu, 12 Feb 2026 10:40:11 -0800 (PST)
X-Received: by 2002:a17:90b:5583:b0:354:a284:3ff9 with SMTP id 98e67ed59e1d1-356a7a70dfbmr57575a91.26.1770921611368;
        Thu, 12 Feb 2026 10:40:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba96d0sm5758343a91.11.2026.02.12.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:40:10 -0800 (PST)
Date: Fri, 13 Feb 2026 02:40:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] fstests: btrfs: add a regression test for incorrect
 inode incompressible flag
Message-ID: <20260212184006.5pyxjnwxd5n5uad2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260209095735.130049-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209095735.130049-1-wqu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-21650-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44ED213058B
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 08:27:35PM +1030, Qu Wenruo wrote:
> [BUG]
> Since kernel commit 59615e2c1f63 ("btrfs: reject single block sized
> compression early"), a single block write at file offset 0, which can
> not be inlined due the inode size, will mark the inode incompressible.
> 
> [REGRESSION TEST]
> The new regression test will do:
> 
> - Create and mount the fs with compression,max_inline=2k
> 
> - Do the following operations:
>   * Truncate the inode to 2 * blocksize
>     This will rule out any future inlined writes.
> 
>   * Buffered write [0, 2K)
>     Which will not be inlined.
> 
>   * Sync
>     For affected kernels, this will set the inode with NOCOMPRESS
>     and reject all future compression on that inode.
> 
>   * Buffered write [1M, 2M)
>     For affected kernels, the range will not be compressed due
>     to the NOCOMPRESS flag.
> 
> - Unmount the fs
> 
> - Make sure that:
>   * The inode has no NOCOMPRESS flag
>   * File extent at file offset 1M is being compressed
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove an unnessary sentence
>   Which is confusing because I missed the "and" to connect the two
>   sentences, and it's not needed after the first paragraph anyway.
> 
> - Use full "btrfs inspect-internal" group name instead
> 
> - Add missing punctures
> 
> v3:
> - Properly commit the modification
>   Facepalm
> ---
>  tests/btrfs/343     | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/343.out |  2 ++
>  2 files changed, 50 insertions(+)
>  create mode 100755 tests/btrfs/343
>  create mode 100644 tests/btrfs/343.out
> 
> diff --git a/tests/btrfs/343 b/tests/btrfs/343
> new file mode 100755
> index 00000000..3781373c
> --- /dev/null
> +++ b/tests/btrfs/343
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 343
> +#
> +# A regression test to make sure a single-block write at file offset 0 won't
> +# incorrectly mark the inode incompressible.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix the inline compressed extent check in inode_need_compress()"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount "-o compress,max_inline=2048"
> +
> +blocksize=$(_get_block_size $SCRATCH_MNT)

Do you mind I replace _get_block_size with _get_file_block_size when I merge it?
Even though btrfs currently doesn't require special handling to get the correct block
size, using this interface is more future-proof. It will help us to easily add specific
logic later if btrfs ever needs it. Others are good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +# Create a sparse file which is 2 * blocksize, then try a small write at
> +# file offset 0 which should not be inlined.
> +# Sync so that [0, 2K) range is written, then write a larger range which
> +# should be able to be compressed.
> +$XFS_IO_PROG -f -c "truncate $((2 * $blocksize))" -c "pwrite 0 2k" -c sync \
> +		-c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
> +ino=$(stat -c "%i" $SCRATCH_MNT/foobar)
> +_scratch_unmount
> +
> +# Dump the fstree into seqres.full for debug.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV >> $seqres.full
> +
> +# Check the NOCOMPRESS flag of the inode.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> +grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
> +[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
> +
> +# Check the file extent at fileoffset 1m.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> +grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compression 0"
> +[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
> +
> +echo "Silence is golden"
> +# success, all done
> +_exit 0
> diff --git a/tests/btrfs/343.out b/tests/btrfs/343.out
> new file mode 100644
> index 00000000..2eb30e4f
> --- /dev/null
> +++ b/tests/btrfs/343.out
> @@ -0,0 +1,2 @@
> +QA output created by 343
> +Silence is golden
> -- 
> 2.51.2
> 
> 


