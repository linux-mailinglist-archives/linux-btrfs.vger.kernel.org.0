Return-Path: <linux-btrfs+bounces-20111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D25CF54B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 20:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E313A3009299
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 19:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC055315D53;
	Mon,  5 Jan 2026 19:07:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151622097
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640069; cv=none; b=hI5NbJnNaSnd0xZqiUhBznc6kNOnuR44up6rs3uRZDEjseVkajCNNtVVIc3naP4Vtr16PByX72ZYDhx4LEHn5XyYfPTBT8xty9hcZu45FzwgHzl+yM5l9VUSG+2TfdOo1ozdA9hu4Kzq3lCBLzojBNg9xsAb3VLKB/R9YHYfNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640069; c=relaxed/simple;
	bh=zEtwYGZ7j8ay6zzBUYic9J7ATzBZ67Zq2YNRKHJEt7c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=QjlE+helqZUbaAgLpK3foDz9eyZenncM32KlvIQ2fvMPugPonlwNQZr9A6rhtnnPDoI584puHALp5Wd1EeiX0Vj4j8vCKnEJOW9P3Qnvk3K0sQXUOP6JrHilcp2247LA5E9HE81Y48jxnJE6qTNeZafj0utAQMlo3JV9JqAO44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.0.romanrm.net [IPv6:fd39:ade8:5a17:b555:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 95748412E9
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 19:07:36 +0000 (UTC)
Date: Tue, 6 Jan 2026 00:07:35 +0500
From: Roman Mamedov <rm@romanrm.net>
To: linux-btrfs@vger.kernel.org
Subject: Cancel of "btrfs dev delete" not working
Message-ID: <20260106000735.4794991b@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

# btrfs dev delete --help
usage: btrfs device delete <device>|<devid> [<device>|<devid>...] <path>

    Remove a device from a filesystem (alias of "btrfs device remove")

    Remove a device from a filesystem, specified by a path to the device or
    as a device id in the filesystem. The btrfs signature is removed from
    the device.
    If 'missing' is specified for <device>, the first device that is
    described by the filesystem metadata, but not present at the mount
    time will be removed. (only in degraded mode)
    If 'cancel' is specified as the only device to delete, request cancellation
    of a previously started device deletion and wait until kernel finishes
    any pending work. This will not delete the device and the size will be
    restored to previous state. When deletion is not running, this will fail.

    --enqueue                 wait if there's another exclusive operation
    running, otherwise continue

# btrfs dev delete cancel /mnt/dir/
Request to cancel running device deletion
ERROR: error removing device 'cancel': Operation canceled

The ongoing deletion is not cancelled and carries on.

# btrfs --version
btrfs-progs v6.14
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=builtin

-- 
With respect,
Roman

