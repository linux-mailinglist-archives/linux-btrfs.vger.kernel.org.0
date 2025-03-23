Return-Path: <linux-btrfs+bounces-12504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB389A6CDDA
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Mar 2025 05:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBED3B9286
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Mar 2025 04:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D07D1F4633;
	Sun, 23 Mar 2025 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="NhoTq9Ba"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9F2E337D
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Mar 2025 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742703107; cv=none; b=V1ol06grp/YqHqgvrIz6z5rUyd32jesvon3Tp9Epd2hgFi1qGQWpk4WN68jqXKdx5UOOM6ZNJFqZPsHANOJzjjBy5+IbgECBaGmv3C0ZG3dQTLNqWu2uStKwDj7kUPbAf/I8u8xJwjFJWOoUhkmMbX/BDQezxdCkiyDvSWAIp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742703107; c=relaxed/simple;
	bh=ysT1Kc/gTsj841YS8rumtHHwdwCbjBX2U8U35cyaDcU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBALlAUSympPk7Bn1CnSC/8aNU19/NZLhVLhWqKr/3tCi+hTRvbVo2hhLEs7jd2av64kNDBzfnq3Ole7Rcnh0qAW2MMYLBh4NU6mgk/O7KXjdxxaLTuEQJrNPjOp5ObKO/w5ucc/LBu3bur2LAsNdNf2WE3uEpeViKAQJy3V+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=NhoTq9Ba; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1742703103;
	bh=qMw+KAelboglVBoWXEOIbip/ROfbh+d53c0wr8nkk1o=; l=1671;
	h=From:To:Reply-To:Subject:Date:In-Reply-To:References:From;
	b=NhoTq9Ba+fxAxUsmyIhpG80ct44QVcOWjkPB3zkcIfxA6cG8Rys40mnSwIzH4K7kc
	 MR9OpSPLuK7/8pj7tQWXacpLIhkr4mRh5IMnYsFoMBgsH3xVkcWOHcdIsCfrWsLQog
	 hD4wXZNNC99h5AkuPPzfXI71EXOAb4cul5UW24Pw=
Received: from xev.localnet (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.sws.net.au (Postfix) with ESMTPS id 173CF114DC;
	Sun, 23 Mar 2025 15:11:41 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Reply-To: russell@coker.com.au
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Date: Sun, 23 Mar 2025 15:11:35 +1100
Message-ID: <2310073.iZASKD2KPV@xev>
In-Reply-To: <81b64f4f-59dc-4ca1-81de-2b77cf38cd3e@gmx.com>
References:
 <3349404.aeNJFYEL58@xev> <81b64f4f-59dc-4ca1-81de-2b77cf38cd3e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 23 March 2025 08:36:56 AEDT Qu Wenruo wrote:
> > This is repeatable and it's 754 every time.
> > 
> > After I get the error I remove the device from the array and add it again.
> 
> How did you do the removal and add?

btrfs dev rem ...
btrfs dev add ...

> "btrfs device remove" then "btrfs device add"? Or just power the machine
> down and physically add/remove the device?

I didn't physically remove the devices because working out which device is 
which /dev/sd node is not easy at all.  For unrelated reasons the assignment 
of /dev/sd nodes is apparently random.

> > The system is a Dell PowerEdge T630.
> > 
> > The SSD could have a fault, but if so why does it only show up on reboot
> > and why 754 errors every time?
> 
> The error counters are stored inside the fs, it records all the history
> errors a device hit in the past.
> 
> You need to inform btrfs by either proper btrfs device removal/add, or
> make btrfs to zero the counters.

Yes I had done the proper device removal, but either the counters weren't 
properly reset or some other errors were occuring.  I even tried dding 1G of 
data from /dev/zero over the device after removal and that didn't help.

The problem has gone away now.  I was about to do another run to get dmesg 
output for you but accidentally removed the wrong device.  After I added that 
back then removed and re-added the correct device the problem went away.  I 
can now reboot without seeing an error count of 754.  I presume that forcing a 
bunch of metadata to be moved around changed things somehow.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




