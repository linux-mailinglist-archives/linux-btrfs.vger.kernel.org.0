Return-Path: <linux-btrfs+bounces-14192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E8FAC27C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D1816F7B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C9C296D39;
	Fri, 23 May 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b="SNNQRfLs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.tnonline.net (mx.tnonline.net [135.181.111.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2E4120B
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.111.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018382; cv=none; b=hRG8dgQKwXFIfv06R30w2aQIxYC4iP6pfR3q4ESJUdJlIEdK5EZKh7JJ7VT3yNj3kANsuvOWT+O/zlxQovsQVCvXNETWy0HF24jMOEsZ75J/J5C3HWyc+1z+QzumR+drOvTX4xaFnlQFILgk39xpY4RvL6qCAHp5jndny8KKVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018382; c=relaxed/simple;
	bh=ntT3I7lgEY+iNfuxj09mDF9mzl3Idxmctf84viPYZec=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=AkREtwP/nc1uYC7Y5z7h1U4EqfxFNRHCwCk83j6rZQQg0kJhmJe5W7BVfMfZufseMX1RpWef7wJFWXFDEvSDN62z2kX8rxrGEhxdlhMwVFkP4Codaa9+IOEBmk67ge1cBd9tXwDqVBLIhobzXwhz3gqX5E/Kzju/tN2pmWcGkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tnonline.net; spf=pass smtp.mailfrom=tnonline.net; dkim=pass (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b=SNNQRfLs; arc=none smtp.client-ip=135.181.111.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tnonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnonline.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=43VtItRBM6X+ALWDdkNJbzCyUjLZ7qq/pkUdJECcQdU=; t=1748018380; x=1749227980; 
	b=SNNQRfLsS+708bYIdqMTOM01NcMzeWKR9HKoBPvAdH5S/hiVs5lGFvMa0Ey3ONWgCaE2tIn4gkA
	DZEK9uPj7xLyghChfztiTj3UuIIUmSjQNSR39AjSE3M9dX9iDjJrnHsuFseAR184jJwpXDZJzD+7w
	bcICzXbZ856BRVdc3tldtrQUQGc27ialf0BrCA/b2jOqGmDc74iygYsr5u1GUfXXj/v+u3oRg9S3q
	Bw+BhqRkM/8kyLCIShFCwvD7JK4JjYKDYJ7ESvd26le4GYTiA55S4z/p5gxyPOJVf9So4XUhHOEvh
	2pFAHDCF2iDBZwfR6sZsTmjF7GEmm6XS5irw==;
Received: from [2001:470:28:704::1] (port=33228 helo=tnonline.net)
	by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <forza@tnonline.net>)
	id 1uIVQi-000000005sI-2Qdq
	for linux-btrfs@vger.kernel.org;
	Fri, 23 May 2025 16:39:33 +0000
Received: from [192.168.0.114] (port=36106)
	by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <forza@tnonline.net>)
	id 1uIVQh-00000000Cxw-14s6
	for linux-btrfs@vger.kernel.org;
	Fri, 23 May 2025 18:39:31 +0200
Date: Fri, 23 May 2025 18:39:30 +0200 (GMT+02:00)
From: Forza <forza@tnonline.net>
To: linux-btrfs@vger.kernel.org
Message-ID: <883424e.30d76975.196fe039728@tnonline.net>
Subject: data chunk_size ceiling and shrinking stripe sizes on large
 RAID1/10 arrays
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
X-Spam-Score: -6.7 (------)

Hi all,

Because the default

/sys/fs/btrfs/<fsid>/allocation/data/chunk_size

value is capped at 10 GiB (and cannot be raised), the allocator=E2=80=99s l=
ogic in decide_stripe_size_regular() progressively reduces the per-device s=
tripe_size once data_stripes * stripe_size would exceed that 10 GiB ceiling=
.

Concrete example:

40-device RAID10  =E2=86=92  data_stripes =3D 20, allocator shrinks stripe_=
size to =E2=89=88 512 MiB

Functionally, I think everything works, but the result is a much smaller st=
ripe per device than the customary 1 GiB.  With even more drives the stripe=
 continues to decrease.

Questions

1. Is this behaviour considered acceptable or just a stop-gap until a bette=
r solution is developed? The limit seems.to have been introduced in https:/=
/github.com/torvalds/linux/commit/fce466eab7ac6baa9d2dcd88abcf945be3d4a089 =
(btrfs: tree-checker: Verify block_group_item) but with no direct explanati=
on to why 10GiB was chosen.

2. What are the risks if we increase BTRFS_MAX_DATA_CHUNK_SIZE limit beyond=
 10GiB?

3. Has anyone measured performance impacts once stripe_size drops below 1 G=
iB? Are there other issues that may happen on such a filesystem?

Thanks!

~ Forza


