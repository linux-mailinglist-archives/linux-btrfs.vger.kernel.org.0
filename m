Return-Path: <linux-btrfs+bounces-8154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF197DFB6
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2024 03:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3D01F2148A
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2024 01:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C591917D6;
	Sun, 22 Sep 2024 01:10:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-177.us.a.mail.aliyun.com (out198-177.us.a.mail.aliyun.com [47.90.198.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4191531F2
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726967432; cv=none; b=ZnOYTQBPbZIwTgt0WVRTFqNS/3npsRy82Q+0ZgobuUSSwsbs4Tmhd+fSmvwcOv5yfTR9VEp4HN1SExsMxoOKsdHHSaLsw7EvwRhgzqRGNlH3aJb1W0AG5Gby5E6OSjlYsJOulY1XE6c03+U7D9P2Q3rc6KISlte7cyWHqNFLMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726967432; c=relaxed/simple;
	bh=N/e6dqXHCfbaYu6NYU+Kq41VN/OfXojlXP2fPImJKeQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=rWJxqPbIOIgUD2PsZZqipD9sqtLi6oLJK7YfxmlQsVq6lEdI2Eowr526L/cVvqI6xoWmNWNaU0S4xIYbcbehRCZ1LuzY+fvb+YOUweJxcBr/uUUHAbLMedDSd2u/HiQnEcU/gUA+Ea8TDUo/1ey09uuBD4FnoyXzHWq38xs0jNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ZPhUctk_1726967414)
          by smtp.aliyun-inc.com;
          Sun, 22 Sep 2024 09:10:15 +0800
Date: Sun, 22 Sep 2024 09:10:16 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: fdmanana@kernel.org,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix buffer overflow detection when copying path to cache entry
In-Reply-To: <20240922060246.B4CE.409509F4@e16-tech.com>
References: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com> <20240922060246.B4CE.409509F4@e16-tech.com>
Message-Id: <20240922091015.EE50.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.81.07 [en]

Hi,

> Hi,
> 
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Starting with commit c0247d289e73 ("btrfs: send: annotate struct
> > name_cache_entry with __counted_by()") we annotated the variable length
> > array "name" from the name_cache_entry structure with __counted_by() to
> > improve overflow detection. However that alone was not correct, because
> > the length of that array does not match the "name_len" field - it matches
> > that plus 1 to include the nul string terminador, so that makes a
> > fortified kernel think there's an overflow and report a splat like this:
> 
> xfstests generic/591 failed with this patch.
> 
> generic/591 1s ... - output mismatch (see
> /usr/hpc-bio/xfstests/results//generic/591.out.bad)
>     --- tests/generic/591.out   2024-08-06 21:26:52.100477701 +0800
>     +++ /usr/hpc-bio/xfstests/results//generic/591.out.bad      2024-09-22 06:00:37.920543850 +0800
>     @@ -1,5 +1,10 @@
>      QA output created by 591
>      concurrent reader with O_DIRECT
>     +splice-test: open: /mnt/test/a: Is a directory
>      concurrent reader without O_DIRECT
>     +splice-test: open: /mnt/test/a: Is a directory
>      sequential reader with O_DIRECT
>     +splice-test: open: /mnt/test/a: Is a directory
>     ...
>     (Run 'diff -u /usr/hpc-bio/xfstests/tests/generic/591.out /usr/hpc-bio/xfstests/results//generic/591.out.bad'  to see the entire diff)

This is just a noise. Sorry.

¡®splice-test: open: /mnt/test/a: Is a directory¡¯ is a problem of other patch,
not this one.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/09/22



> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2024/09/22
> 
> 



