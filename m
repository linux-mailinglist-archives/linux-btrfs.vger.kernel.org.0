Return-Path: <linux-btrfs+bounces-15576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D4AB0B80E
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 21:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055F47A577A
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352DC1DDC15;
	Sun, 20 Jul 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="fNc6me8u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076C18EFD1
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040894; cv=pass; b=SuZ8xZfKe3IilXgsBJeCjc0S0KA7d1SKlA+d07YzgB0JeeZ8ctHhOS9I5v24LfslFU/4Vm8VH04B+MVmxij2wh0AnGyEpVBoiNhLy+g8LQSzgVIEPubZd0k0ZDyaCjebO4x7jIkQ/cKI6EC3FJCKTqLOEl7f5OdbTR7j/pHsPE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040894; c=relaxed/simple;
	bh=6HXIrCS695fgV7N6B/5245m9GPdqu43dc7hIemb3SSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og1KdDGRFjzW9xLnHa7A5isrZbZnYGL3XvH4X0dB76M8g9zEQvKL8yzEG+HtxHKJIbY+BPJTO0vxlZKDsN5M0aptS4R2eDB6dhTaW+yaldApKsjcEeDM1Mb3ldBaEfSGTItVT9vDTrVEOynYFBu69FJqTY6wljRDe1oZb9HRHtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=fNc6me8u; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1753040890; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iI27nodJVwlzfJvuyb4Af/wxwKjsp/LjRSLm1hHbldLkJj9SgvbcfBG3fPAZbfRerlH78ts54IkIzwPyObvzXcFZTfYG/geeAnElJ9sZX7G9RCP1DUidvC5BobfM//8jLkc0EHPyC2FVCtufgsaDsN9Ot9Alwd8jAkgGPBelPo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753040890; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6HXIrCS695fgV7N6B/5245m9GPdqu43dc7hIemb3SSU=; 
	b=m24BRA63bk4m3kRivvUV95l+QusTzVFoSjy/JNmnVrgvIrMlr9letj8iT+XcKWBwqzzWDmzpljNSxKm71W+gGNasg6lBnvmCdpRuOTnRcPkgkioST1n0uZcIoV3/Zu3E/yJEzY79mEJoKNZoyscWlpdF8IdixtFPkVB5WK9tlC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753040890;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=6HXIrCS695fgV7N6B/5245m9GPdqu43dc7hIemb3SSU=;
	b=fNc6me8uM/7zggZcLGdzLfxNWL8ANiJPLlrUI1E4EbB1aKYC3t1M8ri0NqQgcGKW
	4MwzHe8a2IPIHDDAnejqqCoi9OQii96rWNpi0Htb7MYiYoTX30bpzf/It6ksDGuxEJ2
	H3VHN0QYiFNp9J/TxWO4K9tYEiQNxO9aRRypKNeQ=
Received: by mx.zohomail.com with SMTPS id 1753040887473825.0025620033248;
	Sun, 20 Jul 2025 12:48:07 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
Date: Sun, 20 Jul 2025 22:48:03 +0300
Message-ID: <20250720194803.3661-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708132540.28285-1-dsterba@suse.com>
References: <20250708132540.28285-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272470d8d6026a0f232d0e695c00004ae87387f02d8d64fe434b801a607caba2f0d82e59298850fc:zu08011227d524681972ed9561239739690000344c9718974fa2046f499083dc1fd35c0f39818d911dc9fdf7:rf0801122c8c4c58afd8bdfa81b952f7430000f5cba98842931b49beeb7f17f008dadb181d8d53914ebcd1c72a847e6595:ZohoMail
X-ZohoMailClient: External

I just tested this patch on real hardware (laptop), and it didn't work.

This is what I did:
- I have btrfs on my root filesystem
- It is btrfs-raid with 2 copies of everything
- I started scrub, and in the same time did suspend

Suspend didn't work.

I did experiment twice: with /sys/power/freeze_filesystems set to 0 and to 1.
In both cases suspend didn't work.

( /sys/power/freeze_filesystems was introduced in
https://lore.kernel.org/linux-fsdevel/20250402-work-freeze-v2-0-6719a97b52ac@kernel.org/
)

--
Askar Safin

