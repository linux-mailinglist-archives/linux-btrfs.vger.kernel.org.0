Return-Path: <linux-btrfs+bounces-10375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330859F205A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 19:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F701887C59
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18898199FA4;
	Sat, 14 Dec 2024 18:43:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A53EA76
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734201830; cv=none; b=o1ZQ10QGa3t+8jpx4sOIZYQl+QG7Q7VNuHQ0TwvEHGypRRnZEZZfp7mn4Ih61qHHgSE17D4QEzXXygl1Ex6uhLxAbBJtNXtsGSlflg2Eqve8qdoW9Exl9hpxvtdTiSTHqfSFvMsf6Z5q7G3d2NP97TIXMdbq0J1iKMQIcz4tH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734201830; c=relaxed/simple;
	bh=UXxWUCDQNWYmHd5H/EuONNh3ZlQuG1getwOl7Vbf/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiY99ubwp7N/cNtZKpYO3/I2onZiNYxePYp0RciLnsFC+4Bu6vi+Ky1DDopiiJarEqtoB6TRzLZW96Ew4fKEr06Ig2eJl2h5P0siqeN5WPDWyT+UpLc3TbyjeM+MkY9nI7KQ8o3tGooghinIl8i0ecGNeAEW5Xx06n+HguZa/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 696D33F4A3;
	Sat, 14 Dec 2024 18:35:28 +0000 (UTC)
Date: Sat, 14 Dec 2024 23:35:27 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Leszek Dubiel <leszek@dubiel.pl>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 97% full system, dusage didn't help, musage strange
Message-ID: <20241214233527.5d7d3eff@nvm>
In-Reply-To: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 18:55:06 +0100
Leszek Dubiel <leszek@dubiel.pl> wrote:

> What should i do next?

Logically speaking it seems the next to try would be -musage=40, 50 and so on.
But even so, the current physical space taken up by metadata is 88 GB, with
36 GB of actual metadata (72 GB in RAID1). So the potential gain here is only
16 GB at best.

It looks like the rest of the "free" 256 GB is really scattered across data
extents, even those beyond 90% utilization. To reclaim that into unallocated
it could take balancing with the 95-98 filter or no filter at all, and a
very long time.

-- 
With respect,
Roman

