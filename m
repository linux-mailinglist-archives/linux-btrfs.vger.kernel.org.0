Return-Path: <linux-btrfs+bounces-21807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK9OOWKCmGlMJQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21807-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 16:48:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 906A4169080
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB4B7305C6CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336A337BAD;
	Fri, 20 Feb 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfVfB865";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRlPlNO+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2A25B31D
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602497; cv=none; b=AtQbSD5Ga+rauQ0tOBLm6EDv8ULlS/6x+pioUOjEDboEZYVIeKJQFkvU+j8nlFmLZG1PuK53kxBs2kZb9WtTHM/MQRs72xbExYPQSezVk/MB7O5kaHsIKWLnyETARm6v08OAzlj6942QLfHktoYWRxra/tedbhbS0DfowNov7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602497; c=relaxed/simple;
	bh=oGD0Dqtxdam/f2v6pXkHshry2SBRwhc39ZrZ++WLS7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJsWPVKuuL9KFzr3YOR+lzuH8Ef/+LcpEPwZceVFAYRgeBWzUdDJ69rGaZPH5tSzNGaznSYdOhPOgf2LawQAmikgYacpTOyzVTgCeIhAv4LLausJQ2PyU5uagjeAso+Uo/KVx4toQxOVdeoE4ZUxBjRVBV5tXpmSZZj4ZzkZlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfVfB865; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRlPlNO+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771602495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UByZ/fZkiO75MPabPlfve5T92mlXJbTpDo0SxQ0ZYiU=;
	b=ZfVfB865+5R+J5rpgoWl9MopvJ/SAjHHCwpJIfKpRG/ZBVRpQAt29BzduGDF2Fi45d6s4r
	9riuXnxbci+X2mTz4mDuX9ZgJkGyDe5BcZ+9ru1+O4P1nMaEQ3BEQi2UQdXNMEXDwO5p4N
	68zBrguy2Yeu0dTnxsIBIdqJ1+dJl38=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-9V1cC6eoOCirL8FXsXiNuw-1; Fri, 20 Feb 2026 10:48:13 -0500
X-MC-Unique: 9V1cC6eoOCirL8FXsXiNuw-1
X-Mimecast-MFC-AGG-ID: 9V1cC6eoOCirL8FXsXiNuw_1771602492
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e8ec30182so10565842a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771602492; x=1772207292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UByZ/fZkiO75MPabPlfve5T92mlXJbTpDo0SxQ0ZYiU=;
        b=PRlPlNO+WBrF0VxI9GtciNFEjazh6B7dcJawjFIAEMXhgoDjOqkbQ9zLOZz3aheGfQ
         q/MdTm+12pyciwcm27lHCJgQiGK2ho+3ODfGnowLCPfqa/N+Bl324hYckxzXabIrCek5
         yWsllJB40vXzUx0QcW3rhZyk2k49cqW9UYaiceXUemdmE1DXwjSAqGhJD72Lgnvvpkrv
         PHCpWfPUdxBEkKRv+k6uQ8jOFCLYkZ4PL64Rzfmqbcz2eTUBFSeG02FiF2L8qDp0nDX/
         veyPyTnGADLDghIZde7O9qADe1b8GJAJua6+XZx8vmUG8dD38EHPhRBYB+Po+O1BIr5U
         werQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771602492; x=1772207292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UByZ/fZkiO75MPabPlfve5T92mlXJbTpDo0SxQ0ZYiU=;
        b=Jo8Ux2cAjFXK1kQzAhsyN2U8nAw9yjc2jmcCvzAONqRu/THUrSa6tm0G0bNm0pYMop
         ykYZSo8+09z/vDjXzIvDmjG2L3dqUsESi7gz47UV/a67VmnW3a5MSPT8J8KntH95ccf7
         jy9qCFVaRY5w4nDCWPpUAXbjW4PB1ZtmVj8crtwDu0xml7YCPpRGlrTMyT/VhC1bQw9p
         h0yyjp0ut724AWaMRVNrjrFK6ETXUy3rrX2umd9o17E/AhkQTHbr61UhZhiSM/tdIcWe
         5kuuf1Y9BILpt2WaDek7fi/j32cCUAkFTE/0CD2PTP7sP0Pez0NKARtGXtl/qfqojBHX
         ZgmA==
X-Forwarded-Encrypted: i=1; AJvYcCVK1k+3tOopXy0+ORB22ZKVYm55OMDBMsNB+hzk+Oz8XA8eZ+Y8ufe8Jinsw3+J8v9D0R1J8PMhCc0tzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuUvnqQjIK8yJYmz2bPUzEqxaf8tdGKuxvpzC6drDU7d/41w0
	/E2NNfAlk1NsoTTSo0T3im/ulqwbupYaqn4CHg3iRl5hvHtMYSyrLG52KAIRzOgF+KpMSrHs0P5
	5fESVtI+GMueoRGbqTS+fKViLFZyF1eBadOzpFPu7j1A3rGyIsX2GJbtIYbgSAC556gYyejql
X-Gm-Gg: AZuq6aK/JpA/kbOrNKrjpisnY3hbxmodIlZOmu7MbtJSOSzIkHzc7OaTDCn7gdPLXbo
	CcV7cta3ZFtxPZPmCD94x3QeBKvm3xlDznlfjAh1aaL+FqM2WZL9LD5fLV/1HSw9EzDg9a4IVKt
	J0ZXYRSKlMy5c/MNXkk8pLwi8k3hZkNhNru57ipJ2wqFo3/qIKPu2Re8yBVDFfx0NA5pNaMHJPS
	7LHo7Taa1SBRd9YcITKtHqp18NPkvPBw2/ihSM8DtRiyt2UwS0WQexifPIbJdi7fKuErSus4CIB
	V/vyEqLBSK+Y7lFHtCU3CCL+e9dQLlwmFil7bkLpno164mlWtzVU0Roqy781/ZD6irgZY8IdK1I
	nk2BkMeWlN2qoA6+ATQjXu88W/7S94ca0OSR9IiOxYC3mMraeYqmDzO9VPyWw3g==
X-Received: by 2002:a05:6a00:4296:b0:81f:9b09:ad02 with SMTP id d2e1a72fcca58-826da8d7d6amr306939b3a.1.1771602492042;
        Fri, 20 Feb 2026 07:48:12 -0800 (PST)
X-Received: by 2002:a05:6a00:4296:b0:81f:9b09:ad02 with SMTP id d2e1a72fcca58-826da8d7d6amr306912b3a.1.1771602491587;
        Fri, 20 Feb 2026 07:48:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94562sm23054638b3a.54.2026.02.20.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:48:11 -0800 (PST)
Date: Fri, 20 Feb 2026 23:48:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fsync of a file truncated to a length of
 zero
Message-ID: <20260220154807.jdya3knqauhvnq46@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f4a25aa2a17255493a9887e0ba6610a307a4961a.1771352543.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a25aa2a17255493a9887e0ba6610a307a4961a.1771352543.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21807-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dell-per750-06-vm-08.rhts.eng.pek2.redhat.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 906A4169080
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 06:33:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we truncate a file to 0, fsync it, add a hard link to the
> file and then fsync the parent directory, after a power failure the file
> has a size of 0 (and the hardlink exists too).
> 
> This exercises a bug fixed by the following kernel patch for btrfs:
> 
>   "btrfs: fix zero size inode with non-zero size after log replay"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks Filipe, this patch is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/788     | 59 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/788.out |  5 ++++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/generic/788
>  create mode 100644 tests/generic/788.out
> 
> diff --git a/tests/generic/788 b/tests/generic/788
> new file mode 100755
> index 00000000..0234cc7f
> --- /dev/null
> +++ b/tests/generic/788
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 788
> +#
> +# Test that if we truncate a file to 0, fsync it, add a hard link to the file
> +# and then fsync the parent directory, after a power failure the file has a
> +# size of 0 (and the hardlink exists too).
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix zero size inode with non-zero size after log replay"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_scratch_mount
> +
> +mkdir $SCRATCH_MNT/dir
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/dir/foo | _filter_xfs_io
> +
> +# Persist the file and directory.
> +_scratch_sync
> +
> +# Truncate the file to 0 and fsync it.
> +$XFS_IO_PROG -c "truncate 0" -c "fsync" $SCRATCH_MNT/dir/foo
> +
> +# Create a link to foo in the same dir.
> +ln $SCRATCH_MNT/dir/foo $SCRATCH_MNT/dir/bar
> +
> +# Fsync the directory.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +echo "file size after power failure: $(stat -c %s $SCRATCH_MNT/dir/foo)"
> +echo "file link count after power failure: $(stat -c %h $SCRATCH_MNT/dir/foo)"
> +[ -f $SCRATCH_MNT/dir/bar ] || echo "link dir/bar is missing"
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/788.out b/tests/generic/788.out
> new file mode 100644
> index 00000000..37f3f36a
> --- /dev/null
> +++ b/tests/generic/788.out
> @@ -0,0 +1,5 @@
> +QA output created by 788
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +file size after power failure: 0
> +file link count after power failure: 2
> -- 
> 2.47.2
> 
> 


