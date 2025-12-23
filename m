Return-Path: <linux-btrfs+bounces-19993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3BCD93F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 13:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCB21301F5DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF1732AABE;
	Tue, 23 Dec 2025 12:27:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602583002B3
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492851; cv=none; b=WqyCPrvvG26dbaZGXRELuEyBY05ZizKFTvhhUOeLX1fAtfBtY6zWcNPgEgOobDjdWOg6+AClBb4Grg4KMtFuehW2QfvVxHA7Y54cz+LKYg/FP5WMAIyYNawH25chbkxzfnyFHDlBuEXH2I8c84iFFKfmB8XB0l3bjlAnsA4pi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492851; c=relaxed/simple;
	bh=h/8MrxAiJ2/mgEJoRsQEeHO9p/drcGWMNtrZrL8Ob6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZ0aDfjuXiheLtGrU1zqo0EwBOV/xT2JPvEU9Gfyg9SKcURLlMmBhLPI0ompgbcoHKo8dmSoMAZH2buD1cC5Elo2hMjRmSmA4JoUeUcCXaBfHYaj16vprnzlHz9b7I6D+xqTCsaAJZVc8iXlyn69DEyOxz3DHJtTAccTgiJQL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.0.romanrm.net [IPv6:fd39:ade8:5a17:b555:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id C910E4094C;
	Tue, 23 Dec 2025 12:27:24 +0000 (UTC)
Date: Tue, 23 Dec 2025 17:27:24 +0500
From: Roman Mamedov <rm@romanrm.net>
To: BP25 <bp25@posteo.net>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, Linux btrfs
 <linux-btrfs@vger.kernel.org>
Subject: Re: Snapshots of individual files
Message-ID: <20251223172724.1b1176d5@nvm>
In-Reply-To: <282168f52d13e55e466c2fd079a246de@posteo.net>
References: <79ae6c26545c107010719ee389947c1c@posteo.net>
	<20251223125647.6626b266@nvm>
	<1403c713e107106e18e000d7b0f81eaf@posteo.net>
	<CAA91j0XJNaGMyxJegYr7kr+JDg1RRFv9mOcGkwmoDKKk5dDp8g@mail.gmail.com>
	<282168f52d13e55e466c2fd079a246de@posteo.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 12:08:04 +0000
BP25 <bp25@posteo.net> wrote:

> Is there a standard way to 'follow' the same file along its snapshotted
> versions? Say, ask btrfs to return the list of snapshotted versions by
> giving input this or that file in the current version of the filesystem?
> Note that if such file was deleted and another with the same name created I
> don't want that new file also to show up. And related question, is there any
> command that would list the snapshotted files which have no corresponding in
> the current version of the file system (for example because I deleted such
> file after having snapshotted it)?

There is none of that :)

I put "snapshotted" files in quotes for a reason, it is not a snapshot and
there is no snapshot tree or inheritance.

It is a lightweight instant copy, which lets you to very quickly and
efficiently hold on to states of that file as it was at various points in the
past, if you want to. Where you put it, or which scenarios you envision, is up
to you.

I use this to backup running file-backed VMs, first reflink the image to a
file, then can safely start to gzip that file or copy it to a remote host. The
running VM otherwise would ruin the consistency, with ongoing writes to
its image halfway in that process.

Cool part is that like the snapshots, this is done instantly and consumes no
extra disk space, only the changed bits in the "current" file will. Or you can
go ahead and start changing both files at the same time, that too, will only
increase overall space usage by the amount of changed portions.

-- 
With respect,
Roman

