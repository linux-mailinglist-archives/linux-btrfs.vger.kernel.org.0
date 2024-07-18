Return-Path: <linux-btrfs+bounces-6544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E3934E9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14331C22AF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBE13F428;
	Thu, 18 Jul 2024 13:57:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070712B94
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311078; cv=none; b=Cur6fiJ260feiHsy+azV1C6n5OL9BU1C9V+A4RnZSOQmnXFk+hnETJ2vosufPsCeKDphk/ukBbnIIg1Sj97eA5CHPEWaiYyXoe2KvgaobYCw8QWkQXYmLRfF+Wk7DpQJfebAJfgq1lZbsVKLMJ7Yhv4zhY4tjj6bSR+4tOnu1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311078; c=relaxed/simple;
	bh=4qHm9azHNSLFDbK5QvW02jKdSMdNDtsEvbiW2GOtwrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9FxIhX5+1hfjotdGBE6SBn+Epl4GEkHp2DQ26iLgshs4RngQA27FQX3j6JkrcfoS6Uf7r4OyNM2/dTAHulKcIyFPulz0yQb6wBTfwzgnEazqUymfmoJKf25ho+XOMb/PvX8eK+RJy5uLhL8Zk5ynz0eDSqdKLmx1GPMtBnFH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id EE0A6400E2;
	Thu, 18 Jul 2024 13:50:19 +0000 (UTC)
Date: Thu, 18 Jul 2024 18:50:19 +0500
From: Roman Mamedov <rm@romanrm.net>
To: David Schiller <david.schiller@jku.at>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Question about 32 bit limitations
Message-ID: <20240718185019.74f76e5e@nvm>
In-Reply-To: <4426d5d3202c37b9bc7cea5281c017f77521074b.camel@jku.at>
References: <4426d5d3202c37b9bc7cea5281c017f77521074b.camel@jku.at>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 13:02:25 +0200
David Schiller <david.schiller@jku.at> wrote:

> I don't want to decommission this box, so the alternative would be to
> recreate the file system from scratch and restore from backup. This is a
> very low priority system, that's why I ignored the warning initially.
> This is by no means the fault of BTRFS.

As an option, you can avoid mounting the disks on the box itself, and instead
export them via NBD, AoE or iSCSI to be mounted on another box.

I run a very old DNS-323 armv5 NAS with just 64 MB of RAM, exporting a 6 TB
disk over NBD. (qemu-nbd was the only NBD server that works well given the
limitations). Every day my amd64 server temporarily mounts the NBD device,
runs rsync to it, then unmounts and disconnects until the next backup.

In your case it would be a bit more involved to export 4 devices and then
ensure all are connected remotely on the other machine before mounting. But
not impossible with a bit of scripting.

-- 
With respect,
Roman

