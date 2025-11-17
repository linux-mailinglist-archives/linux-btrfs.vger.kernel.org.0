Return-Path: <linux-btrfs+bounces-19069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEFCC63733
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 11:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A7D93570DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97109275B16;
	Mon, 17 Nov 2025 10:07:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673C259CA9
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374050; cv=none; b=Tjhzu5hqk7qU5xBZ8pk+NErlbtSSr98xaCWzDqvys7AyvKveuchvFeVgM83fX0DqEGfVNZRJF4KKp2zT4wLpEfrv+N9M2gwHwvmQl0BoxrJGSsYnpXmYqoPCrIi9PfIOMDAjAilIyscUv8q1+8zPwjXcgop1vpzMxMFGS2FJ2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374050; c=relaxed/simple;
	bh=uZ4BxfCeiwe8tHUTm1/KzkhHeKfp8ogA5bkaMAVCSVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDiaqzp5iASp+hXzDkkEs4n9mZkM2aXkMwwnjPRoXmw3JGtK/zYHMYMvWoTWpvxqTwWYhFzjnq+JB6ErQtm/5IvTs5e1snqYhCeqGv25qewA06J16jUHvlfNwJu4PerXF3evYNdZuXb7i9Ac0JBdP2U8R9wSSMq4CmCxVYS9MKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 88201340E6C;
	Mon, 17 Nov 2025 10:07:27 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Qu Wenruo <wqu@suse.com>
Cc: boris@bur.io,  kernel-team@fb.com,  linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix racy bitfield write in
 btrfs_clear_space_info_full()
In-Reply-To: <7a15f000-4a11-4ea5-ba74-a311077439cc@suse.com>
Organization: Gentoo
References: <87zf8lxa44.fsf@gentoo.org>
	<7a15f000-4a11-4ea5-ba74-a311077439cc@suse.com>
User-Agent: mu4e 1.12.13; emacs 31.0.50
Date: Mon, 17 Nov 2025 10:07:25 +0000
Message-ID: <87qztxx99e.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <wqu@suse.com> writes:

> =E5=9C=A8 2025/11/17 20:18, Sam James =E5=86=99=E9=81=93:
>> Has this one been taken into a tree yet? We've been "backporting" it for
>> a while now.
>
> It's already in our for-next tree, which will be pushed upstream in
> v6.19 release.

Ah, sorry for missing it. Thanks!
>
> Thanks,
> Qu

