Return-Path: <linux-btrfs+bounces-2990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2499386F927
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 05:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69701F2149C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 04:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62AD6138;
	Mon,  4 Mar 2024 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRdBYE2T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29579539E
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526237; cv=none; b=PbGqRGjMNQD+u4xVYtXVOaBo/r5TspkUW0wiFPlL7NRK0JRHgqrxboKz/wSSbkVu8irTx/F+EXs3rU837vtO8LFraA/pQj/xxUJ8nHbRs2aTteKy3locLLMyrDkwrxcRUWYJnCmfmkcMWBLTv5BNNJ0w5z4xKcdJ2fPF+XYBwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526237; c=relaxed/simple;
	bh=DhNX2oBh5LvaglMly1c227TPqgbAm6OlZGGBdTpZTlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9eRd9ylBRMY0/5aW4qcK9Et4W1hFtR/lF1aUdnbYDJ5PXTPyBwJjQtHfCaYIBINo6nOksAZUVSMvbwzkSaa0DRJC2mGLF6b5915wALGgmt2fo2G8I3zvY3Jx8oK9MY9mwIsWnouIlJ860ci0oYSB7DwbfeQgRHQiADk2l1f3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRdBYE2T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709526234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=reWP60JwLe3mjI4/UtFge8V8YORp/pKuRg/jb6euxrU=;
	b=aRdBYE2TKCbW7qI16HgmDpi7wxhd/xUdQqTtHz+F+ziHpe/xv5RHlYvg4TX9X18kHLM2VB
	NzloZcUiXvEjb5q1NDEe7SE+XLlxjv+dxqXNT8FMsAEbulQo+iXMX/xrCJiw7be1cg1x2N
	gFFMbdxS6UVJ5obCYxnUeN2sVucE5cw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-JSqYcIqjOgWlNtBD_Lzx1Q-1; Sun, 03 Mar 2024 23:23:52 -0500
X-MC-Unique: JSqYcIqjOgWlNtBD_Lzx1Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e5788f1324so4045132b3a.0
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Mar 2024 20:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709525924; x=1710130724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reWP60JwLe3mjI4/UtFge8V8YORp/pKuRg/jb6euxrU=;
        b=PqG5+ebWDqsS/OlFo2D8sOVpXgfYxlou3x4HVqTm/Tu3DI0b0Vwp0F9X6yEEMIfoDz
         1d90OaRnQLegkeIcJ30EfgjTCRblqSZa9R0745E3wn9tGyHqW6F+4s9bjHUMKx0msYnA
         IIUER65l2bU4mt+gWx7VvM3g3f5okXWopT4XbiwDbgJR+e+YyCpvjSj2pFtJ5riTPIvL
         kuqRTd31QDJemt09mEEQcxrShl2VDHK31ojYpYKuCL2x5SemiWbPe4p9wWIDarveH6MJ
         fmiXgrfRHUksquuX/SgWnlJ/tXaZgXneHV2HQsLSGhZ18ClLVVikMsxhLsJiuLkS7gz6
         XP/Q==
X-Gm-Message-State: AOJu0YzA6pnZEt3UtO7kddxfkbpZuqkXJ8D2H7E/9DoIk0we7cgL9EnL
	FGuUP7y/njZT0+Iv4M6jchHop8x78JKScqila5Sg17Mr+4P4iLIJCiKYOrR+QrxKM0CzPZuYDfL
	GMq+rvEl2yyTnfEbVSQyjMqw8dAHpdnKKcqwQxtlSmOyANpQle/zE0Dh+XVH7TVX+PEYrvl0=
X-Received: by 2002:a05:6a20:3f8b:b0:1a0:e187:87c4 with SMTP id ay11-20020a056a203f8b00b001a0e18787c4mr8464753pzb.38.1709525924116;
        Sun, 03 Mar 2024 20:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFw6kGXTHd06Ze1+sTp8Fzar2DKwEC/69hcqGG9ZOFN3aJpjidInR/QKVKzr6rLvDf8d3PHg==
X-Received: by 2002:a05:6a20:3f8b:b0:1a0:e187:87c4 with SMTP id ay11-20020a056a203f8b00b001a0e18787c4mr8464740pzb.38.1709525923731;
        Sun, 03 Mar 2024 20:18:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001dcc7795524sm7523128pln.24.2024.03.03.20.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 20:18:43 -0800 (PST)
Date: Mon, 4 Mar 2024 12:18:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/121: allow snapshot with invalid qgroup
 to return error
Message-ID: <20240304041840.rfn6mhkk5a6mlxnf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240303065251.111868-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303065251.111868-1-wqu@suse.com>

On Sun, Mar 03, 2024 at 05:22:51PM +1030, Qu Wenruo wrote:
> [BUG]
> After incoming kernel commit "btrfs: qgroup: verify btrfs_qgroup_inherit
> parameter", test case btrfs/121 would fail like this:
> 
> btrfs/121 1s ... [failed, exit status 1]- output mismatch (see /xfstests/results//btrfs/121.out.bad)
>     --- tests/btrfs/121.out	2022-05-11 09:55:30.739999997 +0800
>     +++ /xfstests/results//btrfs/121.out.bad	2024-03-03 13:33:38.076666665 +0800
>     @@ -1,2 +1,3 @@
>      QA output created by 121
>     -Silence is golden
>     +failed: '/usr/bin/btrfs subvolume snapshot -i 1/10 /mnt/scratch /mnt/scratch/snap1'
>     +(see /xfstests/results//btrfs/121.full for details)
>     ...
>     (Run 'diff -u /xfstests/tests/btrfs/121.out /xfstests/results//btrfs/121.out.bad'  to see the entire diff)
> 
> [CAUSE]
> The incoming kernel commit would do early qgroups validation before
> subvolume/snapshot creation, and reject invalid qgroups immediately.
> 
> Meanwhile that test case itself still assume the ioctl would go on
> without any error, thus the new behavior would break the test case.
> 
> [FIX]
> Instead of relying on the snapshot creation ioctl return value, we just
> completely ignore the output of that snapshot creation.
> Then manually check if the fs is still read-write.
> 
> For different kernels (3 cases), they would lead to the following
> results:
> 
> - Older unpatched kernel
>   The filesystem would trigger a transaction abort (would be caught by
>   dmesg filter), and also fail the "touch" command.
> 
> - Older but patched kernel
>   The filesystem continues to create the snapshot, while still keeps the
>   fs read-write.
> 
> - Latest kernel with qgroup validation
>   The filesystem refuses to create the snapshot, while still keeps the
>   fs read-write.
> 
> Both "older but patched" and "latest" kernels would still pass the test
> case, even with different behaviors.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/121 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/121 b/tests/btrfs/121
> index f4d54962..15a54274 100755
> --- a/tests/btrfs/121
> +++ b/tests/btrfs/121
> @@ -24,8 +24,14 @@ _require_scratch
>  _scratch_mkfs >/dev/null
>  _scratch_mount
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -# The qgroup '1/10' does not exist and should be silently ignored
> -_run_btrfs_util_prog subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1
> +# The qgroup '1/10' does not exist. The kernel should either gives an error
> +# (newer kernel with invalid qgroup detection) or ignore it (older kernel with
> +# above fix).
> +# Either way, we just ignore the output completely, and we will check if the fs
> +# is still RW later.

The explanation makes sense to me, just ask if you might want to output to .full
file, to save some information for debug if the test fails? I can help to change
the "&> /dev/null" to "&> $seqres.full" if you only need to change.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1 &> /dev/null
> +
> +touch $SCRATCH_MNT/foobar
>  
>  echo "Silence is golden"
>  
> -- 
> 2.42.0
> 
> 


