Return-Path: <linux-btrfs+bounces-8214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32707985192
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 05:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29D4B23084
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622DE14B087;
	Wed, 25 Sep 2024 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjXT42eL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1E14AD19
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235687; cv=none; b=IS+HHpgP9DiAmEix9hpZXtobmXcDvNi2Ol5Karro9MQBYFNzbRZ4d+nySIyloSPx6sUo0qK2WggW25LR7FnFMyc0qNakT14hKFQI0Hyaxx3lv4d934CFFa89C0FLXkfaDfPEJArUMLDyQ4eAXEII7Fw8F4jfpr1K7dQ7ZdVjPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235687; c=relaxed/simple;
	bh=0KPP4EoTFplAZ3mMmt9nybfEbdhCUPmpFvNKHeyyYU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m7jdP/vXbWs5vCGdvMCL6xPEHaJe+8ZwKg6BTxhpRQe3bJRgCO5RFnrwQMoqopHdk5ctIa5OUK0ePLmK2sYd9bSTwYhA8KglRuTbbELVVSgyK4Da+suTCl5ATklMKJWbH4O6O166czpeN48x8+dKTHWqBkTyHKIGg+oLbImZre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjXT42eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B085C4CEC3;
	Wed, 25 Sep 2024 03:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727235686;
	bh=0KPP4EoTFplAZ3mMmt9nybfEbdhCUPmpFvNKHeyyYU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mjXT42eLMHN402XP5cp2i5bSbITtu0+0LhQKa+nTNyYMshcTwfH39/EuFEDTuW/RG
	 hwM4eHwwc9lCG4vqa4m8dcXKAXJbBYB93hWDzjKZ6fmZIE93AhKImr2iHxeIBaxWuO
	 fSotR23uoDBBjTxv8UEGqHUTYbmXDKoPYHFG9gWsjpSgPvdA+sA1njAkD/KhhLVwML
	 jwOVYggGwlW9FPWW5hk4i6RnHwcV9dJ7hJXGxuLqX7ED6RE6zMo5WrksMJUFP77efm
	 FjH8MZVRdV+4dR4xeCfNHuz69C4c7a62OLXpZU/xLn7COFLVX+KnhJybivIWRSqBK6
	 Hy2j5cZ9JGyYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B14F8380DBF5;
	Wed, 25 Sep 2024 03:41:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH -next 00/14] btrfs: Cleaned up folio->page
 conversion
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172723568853.97387.7741681136209020061.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 03:41:28 +0000
References: <20240822013714.3278193-1-lizetao1@huawei.com>
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
 linux-btrfs@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by David Sterba <dsterba@suse.com>:

On Thu, 22 Aug 2024 09:37:00 +0800 you wrote:
> Hi all,
> 
> In btrfs, because there are some interfaces that do not use folio,
> there is page-folio-page mutual conversion. This patch set should
> clean up folio-page conversion as much as possible and use folio
> directly to reduce invalid conversions.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/14] btrfs: convert clear_page_extent_mapped() to take a folio
    (no matching commit)
  - [f2fs-dev,02/14] btrfs: convert get_next_extent_buffer() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/d4aeb5f7a7e6
  - [f2fs-dev,03/14] btrfs: convert try_release_subpage_extent_buffer() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/0145aa38cb39
  - [f2fs-dev,04/14] btrfs: convert try_release_extent_buffer() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/b8ae2bfa685f
  - [f2fs-dev,05/14] btrfs: convert read_key_bytes() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/884937793db5
  - [f2fs-dev,06/14] btrfs: convert submit_eb_subpage() to take a folio
    (no matching commit)
  - [f2fs-dev,07/14] btrfs: convert submit_eb_page() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/08dd8507b116
  - [f2fs-dev,08/14] btrfs: convert try_release_extent_state() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/dd0a8df45566
  - [f2fs-dev,09/14] btrfs: convert try_release_extent_mapping() to take a folio
    (no matching commit)
  - [f2fs-dev,10/14] btrfs: convert zlib_decompress() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/54c78d497b38
  - [f2fs-dev,11/14] btrfs: convert lzo_decompress() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/9f9a4e43a870
  - [f2fs-dev,12/14] btrfs: convert zstd_decompress() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/b70f3a45464b
  - [f2fs-dev,13/14] btrfs: convert btrfs_decompress() to take a folio
    https://git.kernel.org/jaegeuk/f2fs/c/aeb6d8814841
  - [f2fs-dev,14/14] btrfs: convert copy_inline_to_page() to use folio
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



