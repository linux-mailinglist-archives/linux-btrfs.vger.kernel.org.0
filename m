Return-Path: <linux-btrfs+bounces-19066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752BC63550
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1518B3ACAC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB3324B27;
	Mon, 17 Nov 2025 09:49:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76892D0C8C
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372945; cv=none; b=kdl4M7N1j8RoFYVvtqbuQTH8pv6GnV5/elQRmLLZeYHZ8pm2Wuik/HT39ckjmUT6fb2Lu1YirUTf6Js3uHXo3Ws36/m9YlPbeuRhxXNJZInzZynIh21d6YsbQQX5gd4Z1bmjNKNx8JNJfXtRjTBcaeH+YKmQg0Gw+P/Y7LvtdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372945; c=relaxed/simple;
	bh=pGpN8mnSe8qLdveMtJDTibClUgDu/HI6E996ArM/UGA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Fe7q1udv/aZQ00NytzD8Fp1lrIHkW/3+M+UhrPDdbQGkagDvhM+ev9Ex+6GZk9fegoWMRXLVSGZ8YXgZeqM8PEh54quCgpWD7v6HLF1kizC31SC6Cqs1qrcceZ6/yRLjK4eGi8VxeNF7FHw4nyqCfTQm2+3p4Jdjw5Tr36kbNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 57629340E18;
	Mon, 17 Nov 2025 09:49:02 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: wqu@suse.com
Cc: boris@bur.io,kernel-team@fb.com,linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix racy bitfield write in
 btrfs_clear_space_info_full()
In-Reply-To: <c885e50a-8076-4517-a0c0-b2dd85d5581a@suse.com>
Organization: Gentoo
User-Agent: mu4e 1.12.13; emacs 31.0.50
Date: Mon, 17 Nov 2025 09:48:59 +0000
Message-ID: <87zf8lxa44.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Has this one been taken into a tree yet? We've been "backporting" it for
a while now.

