Return-Path: <linux-btrfs+bounces-8853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425799A3D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 14:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3540A283C6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6821731B;
	Fri, 11 Oct 2024 12:27:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25826215026
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649673; cv=none; b=ddPRftaDc+rl+WMSQWJ0skUJGx8J/uLHP8kOyFsz/J+xKlhLAkqUjT7R9bl8hXsVKC4tI0p/ObWoNMnpTd2Ye6JvcNUN9sMc0Fp92NLU1Ma1Q58hDtdim4JaIpIpv3Ccj72d479FsB8ZyBG3EoZTY05UB5uABB9Db7OIOeu2wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649673; c=relaxed/simple;
	bh=UXpI3OBBKlVamf43XiZRYp5Psl72oNmEkccN4Z9bqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAgROof+DTEqz5CCm0Agq2vPpfZmZOaBFsCLYD6WDte47Gme6Bqpzp5Fb/z+PSjoRyH9au+o7gYHjUS4XRh9sZb7uLXa/u3nyR10nX0NUnebJfme1YVCLsoF5SpvLfRyENfTwzKS0QiYu94yLlSD0gJET+vpvKA2eFRsSWoHuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 15C813F1D8;
	Fri, 11 Oct 2024 12:20:45 +0000 (UTC)
Date: Fri, 11 Oct 2024 17:20:43 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Yuwei Han <hrx@bupt.moe>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [RFC] New ioctl to query deleted subvolumes
Message-ID: <20241011172043.122e81ff@nvm>
In-Reply-To: <E2F46BD92527EA46+29cb502c-a5ee-48db-a439-ab692a3747b9@bupt.moe>
References: <20241009180300.GN1609@twin.jikos.cz>
	<308CF1DDC38EE68A+91e40dff-783f-43f4-9e49-a5cd4fa0b7a8@bupt.moe>
	<20241010170841.GR1609@twin.jikos.cz>
	<E2F46BD92527EA46+29cb502c-a5ee-48db-a439-ab692a3747b9@bupt.moe>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 20:06:00 +0800
Yuwei Han <hrx@bupt.moe> wrote:

> There is a misunderstanding. What I mean is that why users need to 
> "confirm" subvol is deleted? I can't come up with actual usage. Hope you 
> can help me with that.

A backup system may delete outdated subvolumes first, then wait until the
space has actually freed up, before copying new data; otherwise it could run
out of disk space. Especially considering that IO from starting to copy
without such a wait would interfere with the cleaner process IO, resulting in
it taking a longer time to finish.

Or in my case I also wait until deleted subvolumes have been freed up *after*
a backup, to then record how much remaining space a backup disk actually has,
before unmounting it and putting into storage.

-- 
With respect,
Roman

