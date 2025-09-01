Return-Path: <linux-btrfs+bounces-16546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7461FB3D813
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 06:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADADD7A1844
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 04:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742721B9E0;
	Mon,  1 Sep 2025 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="Nw8aE+Uq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A184323E;
	Mon,  1 Sep 2025 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699442; cv=none; b=B/SIpg/KxqJQfUZQYv2soTx9tqZuBC1pATrAdg30Pwkdtz176AOKYYz6xRMP9tjjHixizWz32vMqaIcqXOhUxvw/tDxoFn7sMwgCyXFZowe50xtoBBc/52eSuuqDYpjnz39/3WYXH5V4OpUc1a8pQjHr/NpAklH3k739bv6ahnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699442; c=relaxed/simple;
	bh=DkEqatWISCiVKm2dMwyvquzsbkJhra96CoIe0u4+Ta4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W0gUv3/qxvdF+u8QNAG96WkTuvtWEDt604nmdY0WUWU5TFe6goMCWdGaWYet+YQTdKtdj3XYNEeW/0LDKJ9wDepaxPrq1FOxDnSdJHKNlsVPi6GM574ncUDyfD7w4vbWqIiMvHQUQ/IJE54AjdBOuZgne2A5plRMh9Wq33AJpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=Nw8aE+Uq; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 837B482828;
	Sun, 31 Aug 2025 23:54:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1756698880; bh=DkEqatWISCiVKm2dMwyvquzsbkJhra96CoIe0u4+Ta4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Nw8aE+Uq2SpwOc8W6mCjvWebHytsIyiA+tv1n0KRxYvO2uJYcQZtUmxp45UCtgSBx
	 LDeKrzPsNW1OFhDh+msQPC//dwQJmscCtoMLD+cRyWUCN/KBWaM861eOHo5rFhd+gs
	 32wyDJyDGIXmHyVzFp1IFSoEyVPSzSzoPDxErbBeKFx+Mgo5MDFkI0rC1YrhhKjxNN
	 wD2E300W5uFf5ahr3OzE9/ZpazkChU0xmM9fLdZZ23f1IGK+qr75RfhbP5HsN2BNbc
	 GvZErS7JG6us+RPtXoSwwZ3rCwCjeN7mKzBCrPSOROQ5tm2/qJflz7Rq/OVY3aEL7W
	 sgdepGVBkyMXg==
Message-ID: <fc1e2106-2974-474a-aa5c-89178383f4be@dorminy.me>
Date: Sun, 31 Aug 2025 20:54:40 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: generic/563 failure caused by losetup no longer handles block
 device anymore
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <db593e62-1d57-4d11-84b0-18d0f49cf0e4@gmx.com>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <db593e62-1d57-4d11-84b0-18d0f49cf0e4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/31/25 8:07 PM, Qu Wenruo wrote:
> Hi,
> 
> Recently generic/563 is failing on btrfs and ext4, and it turns out the 
> losetup inside _create_loop_device_like_bdev() is not properly creating 
> a valid loopback device if a block device file is passed in:
> 
> E.g:
> 
> # lsblk  /dev/test/scratch1
> NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
> test-scratch1 253:2    0  10G  0 lvm
> 
> # losetup -f --show /dev/test/scratch1
> /dev/loop0
> 
> # lsblk /dev/loop0
> NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
> loop0   7:0    0   0B  0 loop
> 
> Thus all filesystems, not only btrfs is affected.
> This looks like a regression in loopback device size handling.
> 
> 
> What should we as the next step? Waiting for loopback fix or start using 
> files inside TEST_MNT as a workaround?
> 
This looks like it might be the same thing that Lennart references here:
https://lore.kernel.org/linux-block/1182267c-d291-47bc-8e5f-2e11aa93421b@kernel.dk/

Which should be fixed in -rc4 according to that email.

Hope this helps;

Sweet Tea

