Return-Path: <linux-btrfs+bounces-13126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98A2A919C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB48D5A68F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657422F3BD;
	Thu, 17 Apr 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLJFSPIh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC3A22DFB0;
	Thu, 17 Apr 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886978; cv=none; b=evKurV3aqPuWsWlV+xLunKJs5a+ySZHYg2fdbc+zrUhtyl2iPHgFJYXlygrq9IwOlb5KGuPKjHkC7YEWaX+p/fihWWsxjQfSvDjV9qYzogNuDVarhyRuGQ2Da5MFzm8gWY2sXNxKhrTm36ScgpD2WS31yZ6rRz57ZpDZ/wh/pNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886978; c=relaxed/simple;
	bh=4iPCuiXYB2jUiWs5jh7YSOXOcG1+1foyAfujWLcxWdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScFOocXiujIweC9JOKZxIjApRvMKeh+VkJXTldTGrHEZF0CNrI3aNO5CJkIAzVJPZz1IQ0Iax9DaeekgUXu6EM/ATXjzvFuJ71x9rLrFTtIxVP7L4Zr6YpqmB5L0XxIUJQ9KselRlXBeM/P75eCLK42AeJFYtn1VcG5LxUItgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLJFSPIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407CFC4CEE7;
	Thu, 17 Apr 2025 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744886978;
	bh=4iPCuiXYB2jUiWs5jh7YSOXOcG1+1foyAfujWLcxWdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jLJFSPIhozleBay9EVU4ncF5F/8UNZRyZ7reO/dVRkysrJmBN1fDtO8QiY1N/8GUX
	 e6SPZkRkAGWCKDsvG4K0lZAZuaj0nVZwH3MAHtvUuROoVvW8HSZ0kbOtlqJf3da/pn
	 hLkW6p9K6ao88iz+6K8jdIdH4XWas7FTm+D1y+QshVAoGVwhaoYVJ7vgSrXNkQvrRw
	 a2PmL1ZrlacCzYmcUw4j0p17PS9uGjp3mMBX3L4DcTk14Qdr/dUKw4KQMoMCU8qAdS
	 0G1d8SYrxMJ9pLLCplpZNZ2PWZEmmKYEzwAkalUeDsGAHZSPr4G44HXh1cpWqgYURW
	 mhYaxJMOejGWw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so97304966b.1;
        Thu, 17 Apr 2025 03:49:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6FFhPYCRCeN/SaycUwj+xScFwgHu0EMcWLP1ooKwLuCPZOCDKxsXWwTjMo8CJo/HWm8k/Xgl/@vger.kernel.org
X-Gm-Message-State: AOJu0YyimH7w3GQGB7LHojGloXgo5MVpYuI9t15MkbZL9UHT5xckYfJU
	HpdVjk4OZgt3OQa4q8wWfa3LEBmU37L1otYLbeQeFb77DOEyRFOjxLtHjnrgpFSx1MxidHsEh5g
	alW4KrQ/ogt4nVoGZegpEaDKGnN4=
X-Google-Smtp-Source: AGHT+IF5VKN+HbznVYEyGpoi2q93PiWW2Q+WU66BNcBp4cBpg25DNyDLH/YZV93dSyovhVV3+EyodZCix2FWK/SJha0=
X-Received: by 2002:a17:906:813:b0:acb:5c83:251 with SMTP id
 a640c23a62f3a-acb5c83064bmr156321466b.53.1744886976845; Thu, 17 Apr 2025
 03:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417102623.8638-1-wqu@suse.com>
In-Reply-To: <20250417102623.8638-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 17 Apr 2025 11:49:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6SZ73LWuCJcnOLK-QToD8C6kOaEL3KOaPGenNd6Li4vw@mail.gmail.com>
X-Gm-Features: ATxdqUFNqj-aCoKdcPuwWRGRG9vAuGkI4UMrWPHmWqH1orNeJBP9qMJlxYnlvt8
Message-ID: <CAL3q7H6SZ73LWuCJcnOLK-QToD8C6kOaEL3KOaPGenNd6Li4vw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/271: specify "-m raid1" to avoid false alerts
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 11:26=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [FALSE FAILURE]
> Test case btrfs/271 will failure like the following, if the MKFS_OPTIONS

will failure -> will fail

> has specified a metadata profile (either SINGLE or DUP):
>
>   btrfs/271 1s ... - output mismatch (see /home/adam/xfstests/results//bt=
rfs/271.out.bad)
>       --- tests/btrfs/271.out   2022-11-07 09:59:11.256666666 +1030
>       +++ /home/adam/xfstests/results//btrfs/271.out.bad        2025-04-1=
7 19:49:00.129443427 +0930
>       @@ -1,523 +1,9 @@
>        QA output created by 271
>        Allow global fail_make_request feature
>        Step 1: writing with one failing mirror:
>       -wrote 8192/8192 bytes at offset 0
>       -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>       +fsync: Input/output error
>        Step 2: verify that the data reads back fine:
>       ...
>       (Run 'diff -u /home/adam/xfstests/tests/btrfs/271.out /home/adam/xf=
stests/results//btrfs/271.out.bad'  to see the entire diff)
>   Ran: btrfs/271
>   Failures: btrfs/271
>   Failed 1 of 1 tests
>
> [CAUSE]
> The test case relies on mkfs.btrfs to use RAID1 as default metadata
> profile if multiple devices are provided.
>
> This is no longer true if the run has specified certain profile in
> MKFS_OPTIONS.
>
> If "-m dup" or "-m single" is specified, the fs will flip read-only as
> either profile can handle any missing or failed device super block
> writeback.
>
> [FIX]
> Just specify both metadata (RAID1) and data (RAID1, already in the test
> case) to avoid the false failure.
>
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/271 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/271 b/tests/btrfs/271
> index 2fc38e9c..7d5424f8 100755
> --- a/tests/btrfs/271
> +++ b/tests/btrfs/271
> @@ -18,7 +18,7 @@ _require_scratch_dev_pool 2
>  _scratch_dev_pool_get 2
>
>  _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
> -_scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
> +_scratch_pool_mkfs "-m raid1 -d raid1 -b 1G" >> $seqres.full 2>&1
>
>  _scratch_mount
>
> --
> 2.47.1
>
>

