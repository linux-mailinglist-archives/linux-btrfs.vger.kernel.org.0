Return-Path: <linux-btrfs+bounces-3989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6453189A768
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 00:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907561C23BBE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF32E84E;
	Fri,  5 Apr 2024 22:47:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA452E63B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357253; cv=none; b=O7AYjA3iCb+llwQSWv0TcQCLyiGZYAFBdI47GI3IGpcgOvi5wh5zNlKCo/d2ZeVdggeC/NiJOs7s4pvQoZSOtqxuL6qTZRhYz/TmIB9BLYbyPipbXrtU+uhNk60asa2GYERWS2govHo+WgmZOJ1e0cH13wg+lslByQOhpA0aJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357253; c=relaxed/simple;
	bh=qCfH48d+USFrorlirUC3YcFgPd49CKqLSA/CJ4YWet0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5z5Atz+ysQdxxxWCaesrOgODVbMjDr8UoBcefNRc2aZ1GR4B4KIK15+yfY+rqb+3kpFS1EuAUT6a5qQJHtiZC+UIT2hZcb3pbvIVisnR48Vt24zIzAEBCiTNF2qkHpg6FDwHDWX8BUbuT0Su4J1BnSLjP6DJDElDuWVikByI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id 5EADB3F6B9;
	Fri,  5 Apr 2024 22:37:04 +0000 (UTC)
Date: Sat, 6 Apr 2024 03:37:00 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: exactly shrinking btrfs on a device?
Message-ID: <20240406033700.2c2404c1@nvm>
In-Reply-To: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
References: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Apr 2024 00:22:52 +0200
Christoph Anton Mitterer <calestyo@scientia.org> wrote:

> If that btrfs on some given device was placed within some other
> container (e.g. a partition, LUKS, LVM, etc.) one likely wants to next
> shrink that outer container.
> 
> How does one do that? I mean, how do I find out the exact last by that
> btrfs uses on a particular device?

I do it like this:

Shrink it with a large headroom left to spare, e.g. by 50-100 GB more than
necessary (or say by 10%, if it is small). Then shrink the outer container.
Then grow the FS using the "max" keyword, to occupy the entire new size of the
container.

-- 
With respect,
Roman

