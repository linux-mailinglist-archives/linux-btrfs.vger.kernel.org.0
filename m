Return-Path: <linux-btrfs+bounces-20021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376ABCDEA3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E26300CBB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD631AF0A;
	Fri, 26 Dec 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="l2OrhywM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC04287518;
	Fri, 26 Dec 2025 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766748311; cv=none; b=lWMcH2m/IOTDyCUiUQiGoWkOldryIaT8/pYF/Oeko/tdh1bab37ajccN3raPMrSPeUG9ETl319tzCHn1BCYIADTpfnlVHiZmoaIHLRHsheaF93moJedq9UzpT0Jn0Dr+IdVBcLc0MIbXru7o8145UJJqRqR9qdv9JN7919UiuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766748311; c=relaxed/simple;
	bh=2dt4QXvjBu8ixPqO+clN1qCNd2fZCG33X+lfbUwjzb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YfguYpVJL3eVXxkpoxKf0a+LNTifRWf1gNnUXCL34pHeFZwZOiIxCL6wJFmaMeSN/i4T4LuCLsLNeBfjpskW9j4lH0qHTUJJ/A/emDUrCy68JL4mOYThn4ARl0lHpnu65Ols+v8IQ1YSzx85tsdWXIkLFysUzwEMA/o7JX6d5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=l2OrhywM; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2eac8892f;
	Fri, 26 Dec 2025 19:24:56 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: quwenruo.btrfs@gmx.com
Cc: clm@fb.com,
	dan.carpenter@linaro.org,
	dsterba@suse.com,
	jianhao.xu@seu.edu.cn,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunk67188@gmail.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
Date: Fri, 26 Dec 2025 11:24:55 +0000
Message-Id: <20251226112455.1879731-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fb336d1c-ce68-403c-9a7a-556906c05112@gmx.com>
References: <fb336d1c-ce68-403c-9a7a-556906c05112@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b5a67956303a1kunm1d7f082639ed5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGktNVhhJH0JDGB4ZQxpJGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=l2OrhywM5uA5b1qAfpXBqRKbnblH2datp+bPslJiR5h9HcvFw9Lr1Vxj2ZEevutFevQd/hCkMkQkmxdV9FWCqA4orbtpd2nerJHOVAGIBTjDaKlIYd5+XdP2ILl4yuD/as31FWYP3z4q3xnsW3ClwarMqbrZZmFD9pDM5QMKO7s=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=YKT8WrZjSqX1iqg4VAmGdomJmgYg1ua9eUwz0QfVw1E=;
	h=date:mime-version:subject:message-id:from;

Hi Qu,

On Fri, Dec 26, 2025 at 06:33:34PM+1030, Qu Wenruo wrote:
> In that case it's correct to move the free_root immediately after 
> btrfs_insert_fs_root().
> 
> 
> And since you're here, you may also want to modify the error message of 
> the subvolume tree, it's copy-pasted from the fs root one, which is not 
> correct anymore (it's not fs tree but the first subvolume tree).

Thanks for the confirmation. I will update the error message accordingly in v2.

> > We have reviewed our previous submissions and found that most of them
> > have been accepted. Despite this, we will enforce stricter verification
> > processes in the future. Currently, our team enforces a strict
> > verification process: we manually confirm there is a clear path missing
> > a free before reporting a leak, and every patch undergoes a double-check
> > by at least two members.
> 
> If that's the case, please add them with proper tags.

Sure, I will include the related tags in v2.

Thanks,
Zilin Guan

