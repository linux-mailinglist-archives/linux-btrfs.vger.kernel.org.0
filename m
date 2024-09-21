Return-Path: <linux-btrfs+bounces-8153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589FF97DF6C
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2024 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067411F216B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A369170853;
	Sat, 21 Sep 2024 22:33:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-177.us.a.mail.aliyun.com (out198-177.us.a.mail.aliyun.com [47.90.198.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A63BB48
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726958030; cv=none; b=NPQ2L2//rmWoF5m5dDUWPc/QQYpUOmtSyjaloR0T/+7TrycbvZzUWq9NbE6MNGyURKNYeDwgBo/NXUI2Rexq6rwFeLop9Vul0AL5KiDlhgrywLfXDh2rnMwXCcq8gQHLNOd1i8RWNzr+XZIDGcSEBCNVB5Deb0ZNfXM08q0oqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726958030; c=relaxed/simple;
	bh=Nu/XSvibe1eyCuDjl75SSLQg0BFm1iiu0a5FHu/023Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=gHNFqCEhWZ8H2vCGRjMAunXAx3Cv401vy8PZHfA4xOl3qt1UdifJHf4HkGO8boIul9Q12J+tCY1d4h0fWyBJ2fotNXJ1NA0dQmWUxt6Zz1pVS/nDaHAsrJM3eXSKUtgf/KGBcuqDiIURRBSxMzxND5tAQCnENqe8fWqb1P2OyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ZPdKrVL_1726956165)
          by smtp.aliyun-inc.com;
          Sun, 22 Sep 2024 06:02:46 +0800
Date: Sun, 22 Sep 2024 06:02:47 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: fdmanana@kernel.org
Subject: Re: [PATCH] btrfs: send: fix buffer overflow detection when copying path to cache entry
Cc: linux-btrfs@vger.kernel.org
In-Reply-To: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>
References: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>
Message-Id: <20240922060246.B4CE.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.07 [en]

Hi,

> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with commit c0247d289e73 ("btrfs: send: annotate struct
> name_cache_entry with __counted_by()") we annotated the variable length
> array "name" from the name_cache_entry structure with __counted_by() to
> improve overflow detection. However that alone was not correct, because
> the length of that array does not match the "name_len" field - it matches
> that plus 1 to include the nul string terminador, so that makes a
> fortified kernel think there's an overflow and report a splat like this:

xfstests generic/591 failed with this patch.

generic/591 1s ... - output mismatch (see
/usr/hpc-bio/xfstests/results//generic/591.out.bad)
    --- tests/generic/591.out   2024-08-06 21:26:52.100477701 +0800
    +++ /usr/hpc-bio/xfstests/results//generic/591.out.bad      2024-09-22 06:00:37.920543850 +0800
    @@ -1,5 +1,10 @@
     QA output created by 591
     concurrent reader with O_DIRECT
    +splice-test: open: /mnt/test/a: Is a directory
     concurrent reader without O_DIRECT
    +splice-test: open: /mnt/test/a: Is a directory
     sequential reader with O_DIRECT
    +splice-test: open: /mnt/test/a: Is a directory
    ...
    (Run 'diff -u /usr/hpc-bio/xfstests/tests/generic/591.out /usr/hpc-bio/xfstests/results//generic/591.out.bad'  to see the entire diff)
R

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/09/22



