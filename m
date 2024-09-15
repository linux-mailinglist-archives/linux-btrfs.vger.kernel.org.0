Return-Path: <linux-btrfs+bounces-8037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED47979967
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 00:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FA02839EE
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367207641E;
	Sun, 15 Sep 2024 22:32:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AF381AD
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726439528; cv=none; b=p2LpbjIhyq5iA9PeNnnDXyCSJutWxH2RGFOQXrGWTr2WKkG5EyPTXaXpz/yTLE7JwYNjWQf+rF9ZgG2tNuih1Me8Rmkiez+hl57ukvQIiunENjzi6i7uUtfvIpvnoj27UIRu/sLCesnMH/CUlW5936kSl2rTDb2ed7VgiGTyr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726439528; c=relaxed/simple;
	bh=j4m9h08bZ6BHXfP8nwWXTdaZwHdoYhnckv1ELCHCG40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCREiH5UknH1rEU5U3obrMnbve2ZxrfVxRhh4FM9OSKN49hfIpQuxeFkeGX/1P6nV5YFZTlutI3VE22rTfOk3HATCgoSiyFuc37WP+7PN3eVLPOdjhgaiBMh+BUOJXPNz/gC8r4yyTY0F6dOwOo+a2exLWg4maS9ldklawKek/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 612883F624;
	Sun, 15 Sep 2024 22:32:00 +0000 (UTC)
Date: Mon, 16 Sep 2024 03:31:59 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Btrfs keeps getting corrupted
Message-ID: <20240916033159.670efe45@nvm>
In-Reply-To: <05487866-261a-46da-8b1b-fa8e0092be81@gmx.com>
References: <20240916004527.0464200f@nvm>
	<05487866-261a-46da-8b1b-fa8e0092be81@gmx.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 06:59:54 +0930
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> > Such a high disparity in transid mismatch, flush is not working somewhere? But
> > I specifically do "sync" even multiple times now, before unmounting and after.
> 
> Manually sync still relies on FLUSH, and FLUSH is not working on the
> lower storage stack (from LUKS to your SSD/HDD firmware), sync won't
> save you.

I always kept in mind that 'sync' was the key to ensure all data has been
moved from RAM to the HDD. But I now realize that I missed that there's also a
buffer in the HDD, which also needs to be flushed to disk. It could be that I
power-off the device before it manages to do that. Also it is an SMR HDD, so
it might need to do housekeeping with the data on-disk as well.

One idea I got is sending drive to sleep (hdparm -Y) before calling power-off
now. Hopefully that makes it flush before sleep.

> > How can I figure out what is to blame here, is it the enclosure, is it USB,
> > LUKS, Btrfs, or some fundamental bug involving a combination of these?
> 
> In that case, you may want to provide your kernel version first (to rule
> out known bugs or too old kernels), then reduce the depth of the storage
> stack, aka, running btrfs directly on that device as a test.

The kernel is 6.6 series, cannot say exact, but was at most 5-10 point
releases older than latest, both of the times the issue occured.

-- 
With respect,
Roman

