Return-Path: <linux-btrfs+bounces-11754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4992A4395D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF31F3A93DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416072566EC;
	Tue, 25 Feb 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="Cb1f41N+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6C1401C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475147; cv=none; b=lcyLv7OKEgaukKovDnoo9QTsCgTj1ev/+9E1La0L8ZltmchCGIu5QY5YxfkE/hZwtvbW90jkv//ytA2doVieKHR2YHa5osWFhr347W/RE3S7gXCsIogapBz7U/V4ZU6qnfv29W/u9Vg/4mIfs2CHvIF+YYKQy5uKNOL6jiXh9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475147; c=relaxed/simple;
	bh=w3xrpGAvUEE51MxLZbSAuciax6ykdvYjfnp7sT6IXMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwQxWhtTZJJwhyJXLCW6U5e3OxDn13thiOlW7BqVbdiLWisCWf1j33veSMI4rcOoSDXWiaG7THWit+C5uo2bnyoBR2xq+xz0+wJL4CnJ7fJ7+4qRUmuaPgFLWPozui89urYNsYuDgU0bypWyE4LSHxRtGPdKfu1qIMJd8Zzjin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=Cb1f41N+ reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=D95ffQzIq4Xiv7gvM1MbBIqi04yse+rvIf2y/Abpwx8=; b=Cb1f41N+UqYSGVlDkuErPLOtaH
	mGeYhRo9vBYGAWN+mNbp9Eo/HJ2hFJ9eh3a/5phUs4Gg/3+r71eIIZG7VkAIa57O+JK4JBiQtC531
	Vdtv8wDAls671CFC+3eQR5EsOehXdzO0mRBUshGtiox971x/xR1QUYq3oQilJAV/B0uYG2zrQ6rEn
	EzUr5OlJ3iPWqbqbDq65PN8EPBO9v6tO7muwLpLWCQXx1SQSPCbXZfECTXTToKoDuc53F7orf3CZB
	TXyoxV4iNFBAmg/O84CytIZjiqqoNaXl67eWHi59pkf+/RZZmtwZHvBEt/7IAg3wo57tmiy44PBcg
	l38RMI/g==;
Received: from lfbn-idf3-1-18-9.w81-249.abo.wanadoo.fr ([81.249.145.9]:37534 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1tmpjN-000820-TI by authid <merlins.org> with srv_auth_plain; Tue, 25 Feb 2025 01:19:00 -0800
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1tmr5e-007ZqJ-09;
	Tue, 25 Feb 2025 01:18:58 -0800
Date: Tue, 25 Feb 2025 01:18:57 -0800
From: Marc MERLIN <marc@merlins.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Murphy <lists@colorremedies.com>,
	Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
	Roman Mamedov <rm@romanrm.net>, Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <Z72LAZDq8IegQoua@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
 <Z71yICVikAzKxisq@merlins.org>
 <018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com>
 <Z71_TednCt9KzR45@merlins.org>
 <d973b4b7-0d98-4310-bb7e-50f87c374762@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d973b4b7-0d98-4310-bb7e-50f87c374762@suse.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 81.249.145.9
X-SA-Exim-Mail-From: marc@merlins.org

On Tue, Feb 25, 2025 at 07:16:31PM +1030, Qu Wenruo wrote:
> Ref#13 is the root that mentioned has the existing one.
> 
> I have no idea why it shows up like this.
> 
> But since the fs passes btrfs check, mind to dump the following tree block?
> 
> # btrfs ins dump-tree -t extent <device> | grep "(350223581184 " -A 50
> 
> I want to make sure if the ref 398 exists on disk, or it's generated at
> runtime.

sauron:~# btrfs ins dump-tree -t extent /dev/mapper/pool1 | grep "350223581184 " -A 50
sauron:~#
 
Mmmmh, so 350223581184 is gone now since it's been 20 days already since
my original post.
I can try to re-enable balance and see if things crash or not.
 
> I believe your machine is a ThinkPad P17 gen2 with a mobile Xeon, with DDR4
> ECC memory support, but I'm not sure if your memory sticks have ECC.

model name      : Intel(R) Xeon(R) W-11855M CPU @ 3.20GHz
sauron:~# dmesg | grep -i EDAC
[    1.293722] EDAC MC: Ver: 3.0.0
sauron:~# dmidecode -t memory | grep Width
        Total Width: 64 bits
        Data Width: 64 bits
        Total Width: 64 bits
        Data Width: 64 bits
        Total Width: 64 bits
        Data Width: 64 bits
        Total Width: 64 bits
        Data Width: 64 bits

That seems do say I do not have ECC or width would be 72 from what I
read :-/

> Just as a precaution, please run a memtest (I know it will be painfully
> slow, so please only run it after the above dump is taken).

I do not have the system with me right now and I think memtest cannot be
run from inside linux, correct?
If so, I can do this when I get home and can reboot the system.

Or is there a version I can run from inside linux?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

