Return-Path: <linux-btrfs+bounces-12968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F9A87086
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Apr 2025 06:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B35460EF9
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Apr 2025 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD3146A60;
	Sun, 13 Apr 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="kKUVsq34"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1659322A;
	Sun, 13 Apr 2025 04:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744517270; cv=none; b=OA3j/oob21QXt632Qc+MDO9dhnk8Xn2eyNadw9YwdfgvodxlEH9jCl7JoWge+xzofgzrwjtGJ8nPJxjBJldREDvZncvtbZ8cAlFx31PjZU5QShGnzAReflm/9agR/ZhvDlE9kCEF3Ya4NITU6i4LEai+5okjQKKx8A2Uf+rqPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744517270; c=relaxed/simple;
	bh=xEz793w2M0kSImdcADaQSBCkIeRk63K3BR/qu/F3SEI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ibvl8mj+6rEiTF0BAjiT77VpJz4K4/qpVyU/szOp8NMsim7osidmqt/u7IgG5HvYI7KglNJqiBpiXmi+3zeKP+/6EP9WvDtwl6zvtB0oRNhPSPRbtUOVFor/GOaJ6SljtkLM2Fdz3EkTvogf6PqPGFD65LjFPCNcbQCbe+Xi8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=kKUVsq34; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=v0PyADkNvrOo96Mgb/IdXo5AW/uvVk3HKxrReDz3oFw=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1744517251; v=1; x=1744949251;
 b=kKUVsq34RF3aJ+3fgDtEVCk7tqlO245HSpfQBJd48VVxpekJKiPkq6z2yjK9FSVzmYuwwgzP
 f3OxK494RKwO77Mx7nnAfhP4HQVJpDI+KHrXWHLboNEYW2QacWTCcLbKR/8fugonEbcpXOlaRY5
 ChE010Ud/Qg07r4hd41dV6ajq9hXMVk2KC8vH6fGKlfZrDwUpdSx28GpDjCIrsOzcPJfL6pGQQW
 pX+/Tn0bV59bb0GegJ1QW9X6XZ3sk6Wdw8gG8W3xg6Hy9MilL8rde5MMrwNFb2VDNtPXO8AE0Eq
 4zO/i+VczMLe0+bqDri/8t+EbRdU2p+nMaOJd4dSr4VlA==
Received: by wiki.archlinuxcn.org (envelope-sender
 <integral@archlinuxcn.org>) with ESMTPS id e161c20b; Sun, 13 Apr 2025
 12:07:31 +0800
Message-ID: <8c2e5d04-dbda-4b12-992e-34f0e70c7218@archlinuxcn.org>
Date: Sun, 13 Apr 2025 12:07:26 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Integral <integral@archlinuxcn.org>
Subject: Maybe we can set default zstd compression level to 1 when SSD
 detected?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


When SSD is detected, maybe we can set default zstd compression level to 1.


Current default compression level for zstd is 3, which is not optimal 
for SSDs.

This GitHub Gist [1] can serve as a reference.


An example is Fedora Workstation [2], which uses `zstd:1` as default

compression option.


[1] Link: 
https://gist.github.com/braindevices/fde49c6a8f6b9aaf563fb977562aafec

[2] Link: https://fedoraproject.org/wiki/Changes/BtrfsTransparentCompression


Sincerely,

Integral


