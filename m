Return-Path: <linux-btrfs+bounces-20541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC72D25397
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 16:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE2730B8ED1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B593AE713;
	Thu, 15 Jan 2026 15:11:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCB3AEF55
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489880; cv=none; b=sIKlbGt0USWrAr6+rSC38gymSI9iu9XjqzsPkQplRfNYrmawqfFX4+hcxziNM1EGvDkKa5RH+sHNfPMJMkMOlp/hD3uFRFmjSeB0IniHeC+lH5amDObUp5xCffvHHH0oqMrXlAzLZwuiXqae+1dF6ODgOyGkdlo+dXmK0H9+gE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489880; c=relaxed/simple;
	bh=XkoC2rk+lFz/Q85dzNY+JtNMw39L+bj127dOTKiXB2Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kbaV0G126CDaQwVhRmUfMDtf+MNh7HRmYyw9HYwqRBPqej+sRpZYM80Qj2mpH5fHu+JVvZ+QmvcocFNlpdLgqPHL2EHHZ+Vd6Vaw8VG3dsTXa+imFARFSOUUxl3SqL4Gz7GRuKLvn1g8gnWzzW69UXvvCVdlJmZM+ElTIZ4+0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07ecd7.dip0.t-ipconnect.de [91.7.236.215])
	by mail.itouring.de (Postfix) with ESMTPSA id B11B4129182;
	Thu, 15 Jan 2026 16:05:27 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 621306018AB97;
	Thu, 15 Jan 2026 16:05:26 +0100 (CET)
Subject: Re: btrfs: refcount_t underflow/use-after-free in delayed inode
 update on 6.18.y (works on 6.17.y)
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, clm@fb.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc: Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
References: <CAK8fFZ6EBcV2p8NRBbKxWQj16yzKVpn1gsobvcpgjz7QDnyxfA@mail.gmail.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <34dc9243-95a2-bb3a-2182-0e6ddf16c3b5@applied-asynchrony.com>
Date: Thu, 15 Jan 2026 16:05:26 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK8fFZ6EBcV2p8NRBbKxWQj16yzKVpn1gsobvcpgjz7QDnyxfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2026-01-15 15:46, Jaroslav Pulchart wrote:
> We started to see a kernel regression after rolling out Linux 6.18.y
> (vanilla-based) on our fleet. Systems upgraded from 6.17.y and were
> stable there. With 6.18.y we see refcount warnings in Btrfs related to
> delayed inode updates, followed by a general protection fault and a
> kernel panic.

Might be fixed soon by:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.18/btrfs-fix-use-after-free-warning-in-btrfs_get_or_cre.patch

(unless I'm misreading things).

cheers
Holger

