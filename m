Return-Path: <linux-btrfs+bounces-10687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE29FF9D7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB24F3A3A5E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7361AC456;
	Thu,  2 Jan 2025 13:33:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5737462
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824816; cv=none; b=CcHMnISU26tcYoJTSizZrxr7vW78Tyin3lEF78CnL0ifFBzU54N6h2jaUvVNh2HgF2V4eN/B1FiP8Y42YOGRFE2RTJrGgFpcjF5LMdeHjzLIScbw7Ubk4k/mRxwoKE/jTW5aXnWqQieXm/5YX9viQcrK09EMa1+zSjg8XnUq2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824816; c=relaxed/simple;
	bh=4947ODme0CoQkzylfCmHmCz19UFOg9MC3fmB6dxy0F0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCmxGPQ2sZzqAkEGngOWitxP5pwHm8v8PvFs79yd79TwcixYUKKpXGeAN/ejALJzriPz9GzKI1K+SEYHJ9P58MhnsRA/A1r6fLqRgpfgn+FfcHRGA3ZmTQ8ZXnEV4+30oZBr+ntU03ShAajpT6GTcBQm9RGCWhZmluTyyL7EtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 5217840446;
	Thu,  2 Jan 2025 13:33:30 +0000 (UTC)
Date: Thu, 2 Jan 2025 18:33:29 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Victor Banon <banon.victor@gmail.com>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS errors following bad SATA connection
Message-ID: <20250102183329.35047254@nvm>
In-Reply-To: <a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
	<76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
	<f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
	<a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 10:32:43 +0100
Victor Banon <banon.victor@gmail.com> wrote:

> So I understand I possibly have 1000 corrupted files somewhere with no way
> of identifying which without using a backup for comparison.

Btrfs stores checksums for data, so unless you turned that off, reading
corrupted files will return an I/O error, not bad content. So you can just
reread all files into /dev/null, and the corrupted ones will be unreadable.

Overall for your FS it's not looking good, there is no proper fix for "parent
transid verify failed" and this may require a reformat.

I remember reading something about the mdadm RAID5 making this issue of Btrfs
worse, due to mdraid "write hole", which its PPL feature is supposed to fix.

Basically, while with one disk it's either "written" or "not", with mdraid it
could be written on some disk but not on others, and it may present older
portion of the ondisk state to the FS, where all breaks loose.

-- 
With respect,
Roman

