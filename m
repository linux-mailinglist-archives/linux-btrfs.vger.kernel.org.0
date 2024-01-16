Return-Path: <linux-btrfs+bounces-1488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E782F4DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 20:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6007F285C17
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B61D54E;
	Tue, 16 Jan 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQlmYwfL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545151CF8F;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431739; cv=none; b=AJWDikvdxNIWezvaE8AA5e6kgNFFoGBgEbkkbtcDzO84L8FuEidQf4JmkdzV+VIGrxCutJC/gI+ZhKlT5M0aBIxc27qzmI42Tw0Jgw0lZrkLDR9gAgfFh9pi7e4ROxt1z/KvFJcKIn29Km/r+3BAeBDyMktx5msWm/3LQD2PSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431739; c=relaxed/simple;
	bh=oxwRyeIL7M3hBA9vL9BEAgyW9LT9u2t413CGMrrBAAY=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GxcklUavu9RIEhjDVPuJzPN14tKjhTewAJJGOLJI+Q8aDr+XzojMAEm2bAR+RknHjXUjeP8fP12+A76a4RD5PWyxrzaA+PlW5ROzV0JUt/yM419rEcJdq3g1jrJuF3aHBSku2Z662AZxs7w1X+oe2C1XE05GUXAO6cTi4F1Mryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQlmYwfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCB27C433F1;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705431738;
	bh=oxwRyeIL7M3hBA9vL9BEAgyW9LT9u2t413CGMrrBAAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BQlmYwfLboHO4veFxacQLWA1eyijOjOtpvGdOcLB0sJS7z9eyKYF2Kv6ylK8KAJzX
	 udynA+l1fx/Jxo9NUVI+CNFE1qI3OrGTniJeYVSiJ4reRLREBBQL3xHMvrqwwiw/Gu
	 IKzO4vBoMYNROkk2z4d2RP8CjLajJTU237dQ/uqq0sx/B6CYDpjTbzThBUiNq0wnpX
	 X8gNWgdAyEN8wYTXEhaE3JMmp6ZzcwihS2XBvNccMc8QH4mfkSIhbeDlc+owz8aiyj
	 pGCvOM0Ta4kMlmWsLhLO9yha6U0JHDHRCENEuJlyVpAG6ox/Y412LVgVi4G1swMuoJ
	 UFwOnulWFyR1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2AD0D8C987;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/5] virtio_blk: cleanup zoned device probing
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170543173879.30188.5344312872944674652.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 19:02:18 +0000
References: <20231217165359.604246-2-hch@lst.de>
In-Reply-To: <20231217165359.604246-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, dm-devel@lists.linux.dev, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
 dlemoal@kernel.org, stefanha@redhat.com, pbonzini@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Sun, 17 Dec 2023 17:53:55 +0100 you wrote:
> Move reading and checking the zoned model from virtblk_probe_zoned_device
> into the caller, leaving only the code to perform the actual setup for
> host managed zoned devices in virtblk_probe_zoned_device.
> 
> This allows to share the model reading and sharing between builds with
> and without CONFIG_BLK_DEV_ZONED, and improve it for the
> !CONFIG_BLK_DEV_ZONED case.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] virtio_blk: cleanup zoned device probing
    https://git.kernel.org/jaegeuk/f2fs/c/77360cadaae5
  - [f2fs-dev,2/5] virtio_blk: remove the broken zone revalidation support
    https://git.kernel.org/jaegeuk/f2fs/c/a971ed800211
  - [f2fs-dev,3/5] block: remove support for the host aware zone model
    https://git.kernel.org/jaegeuk/f2fs/c/7437bb73f087
  - [f2fs-dev,4/5] block: simplify disk_set_zoned
    https://git.kernel.org/jaegeuk/f2fs/c/d73e93b4dfab
  - [f2fs-dev,5/5] sd: only call disk_clear_zoned when needed
    https://git.kernel.org/jaegeuk/f2fs/c/5cc99b89785c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



