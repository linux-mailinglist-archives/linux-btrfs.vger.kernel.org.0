Return-Path: <linux-btrfs+bounces-1274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AD9825B64
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 21:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2769285F00
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651E36091;
	Fri,  5 Jan 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="t/KjPY4M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB436085
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 9BCDA806A5;
	Fri,  5 Jan 2024 15:11:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1704485499; bh=PSBhLOAePP/Q9oH0xUtoZTB+2PPJIlxtFJl5jm5pJnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t/KjPY4MQk6gd2b6GQ92rX58we4Obx1gmlOu5014A84lWBuU5OJV/M+qZWVTMEX/H
	 BdeOAww1tK5vQqGzTv5FkjukhiNMPZ19DoJvP9x25Shylj/O+Vqy2XJ6rfmKnTC0W/
	 cczoOFOl/CSh8YxF1Kdf4dDlkLjxmBm3cwvbJOioqLHQRiqi3em9jNvMlOORZ0Zhhc
	 3ewtNSA2w86sBQHM1BK1rSsLZSqR6xdY+sYLiHdT9GekK6UaISlj+MM3AurpiAXhok
	 i5Bsi1dsYgK6LZfPrM5qR7B8qDNPsuySzVg8ckuwGnLKr/z6X6X1+viPNsYdG9UO1Q
	 FhilOurq1pM2A==
Message-ID: <905e0bad-ac5d-49f5-8f60-c5ea239e42e3@dorminy.me>
Date: Fri, 5 Jan 2024 15:11:36 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] btrfs: subvolume deletion vs. snapshot fixes
To: Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
References: <cover.1704397423.git.osandov@fb.com>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1704397423.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/4/24 14:48, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> This small series fixes a couple of bugs that can happen when trying to
> snapshot a deleted subvolume. Patch 1 fixes a filesystem abort that we
> hit in production. Patch 2 fixes another issue that Sweet Tea spotted
> when reviewing patch 1.
> 
> An fstest was sent previously [1].
> 
> Thanks!
> 
> Changes from v1 [2]:
> 
> - Rebased on latest misc-next.
> - Added patch 2.
> 
> 1: https://lore.kernel.org/linux-btrfs/62415ffc97ff2db4fa65cdd6f9db6ddead8105cd.1703010806.git.osandov@osandov.com/
> 2: https://lore.kernel.org/linux-btrfs/068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com/
> 
> Omar Sandoval (2):
>    btrfs: don't abort filesystem when attempting to snapshot deleted
>      subvolume
>    btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of
>      subvolume being deleted
> 
>   fs/btrfs/inode.c | 22 +++++++++++++---------
>   fs/btrfs/ioctl.c |  3 +++
>   2 files changed, 16 insertions(+), 9 deletions(-)
> 

For the series:
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

