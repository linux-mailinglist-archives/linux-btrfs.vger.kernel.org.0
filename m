Return-Path: <linux-btrfs+bounces-6351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3853F92DEEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B9C1C21186
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5C26AEC;
	Thu, 11 Jul 2024 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="d2Smy8wP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C76208A1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669820; cv=none; b=FJD4DhOEQsNYOV3swAnT1CkbLhryUiaF9KT48zk7p/nUf6Bt166sW15flt3BbZKaDKmRJcyAnsYeL4e/6usrgxhkmkLnbm02u9pYK7d3w2lgatI9n0yaw/nI4hae7LC21J7UhkrWkIWfIt5UmFs99Ztd4qat1ixGgRtGXTTJuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669820; c=relaxed/simple;
	bh=mv0DUrMWTLWzae+JhFjg8EAr3aVnWRrGVi6toymFZu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2QA7S2G7/TkumC4AA3V0mQZMoTlmJAUBOelg/v73tylz5g67AtCO7deO9ddmlodYwxuKofzrvcTYSyqaLYUIIRkpPUQV6ITLMUVEzqlKJurtQTeam0dxhEIefTxWLoWTKaQHfsepdTtyAM8//Pux6atfkYhvUcyTdo5cjLnM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=d2Smy8wP; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1720669816;
	bh=9Gn9xrhiVx/zkqXKQ+fsDVhzs5vPu+yGVxlqazr2REc=; l=2262;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2Smy8wPwn9gcbU+ZopAUduv5RGysJFtqMu8/uRMvxwtrgmtbfvSWPSwKq3nZ2rAH
	 EBk1Mv0m1lRER9Dp6S5/VdEBPnuYKmH8OKEbzOzOD89NvYhzirhLXwzoqS29+La0Zr
	 riKu9CjiDo8N7cQA5RfU4l0aZ6KxqxgdFfLKtbV4=
Received: from liv.coker.com.au (247.234.70.115.static.exetel.com.au [115.70.234.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 422581081C;
	Thu, 11 Jul 2024 13:50:14 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Subject:
 Re: btrfs-progs: btrfs dev usa as non-root is wrong and should just abort
Date: Thu, 11 Jul 2024 13:50:11 +1000
Message-ID: <2138052.8hb0ThOEGa@cupcakke>
In-Reply-To: <20240710162938.GA3394284@zen.localdomain>
References:
 <2159193.PIDvDuAF1L@cupcakke> <20240710162938.GA3394284@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 11 July 2024 02:29:38 AEST Boris Burkov wrote:
> Also wrong, but at least it's the "size" number?!
> 
> btrfs device usage (and btrfs filesystem usage) usually give
> pretty reasonable results without root on my systems, so this is sort of
> surprising to me, especially since it looks like we both have the same
> trivial raid/volume setup and you are on a relatively new kernel.
> e.g., on my system running 6.9:

I'm surprised that it worked for anyone, my experience was that it fails on 
all systems and I had assumed that was the general experience.

> Does the same discrepancy happen for you when running
> 'btrfs filesystem usage /' with and without root? That command gives me
> lots of useful, interesting output without root. e.g.,

For me btrfs fi usa gives me almost everything as non-root.  A bogus value for 
device slack is the only thing wrong.

# btrfs fi usa /
Overall:
    Device size:		476.37GiB
    Device allocated:		222.07GiB
    Device unallocated:		254.29GiB
    Device missing:		    0.00B
    Device slack:		  1.50KiB
    Used:			209.94GiB
    Free (estimated):		263.99GiB	(min: 136.84GiB)
    Free (statfs, df):		263.99GiB
    Data ratio:			     1.00
    Metadata ratio:		     2.00
    Global reserve:		385.50MiB	(used: 0.00B)
    Multiple profiles:		       no

Data,single: Size:216.01GiB, Used:206.31GiB (95.51%)
   /dev/mapper/root	216.01GiB

Metadata,DUP: Size:3.00GiB, Used:1.81GiB (60.50%)
   /dev/mapper/root	  6.00GiB

System,DUP: Size:32.00MiB, Used:48.00KiB (0.15%)
   /dev/mapper/root	 64.00MiB

Unallocated:
   /dev/mapper/root	254.29GiB

$ btrfs fi usa /
WARNING: cannot read detailed chunk info, per-device usage will not be shown, 
run as root
Overall:
    Device size:		476.37GiB
    Device allocated:		222.07GiB
    Device unallocated:		254.29GiB
    Device missing:		    0.00B
    Device slack:		 16.00EiB
    Used:			209.94GiB
    Free (estimated):		263.99GiB	(min: 136.84GiB)
    Free (statfs, df):		263.99GiB
    Data ratio:			     1.00
    Metadata ratio:		     2.00
    Global reserve:		385.50MiB	(used: 0.00B)
    Multiple profiles:		       no

Data,single: Size:216.01GiB, Used:206.31GiB (95.51%)

Metadata,DUP: Size:3.00GiB, Used:1.81GiB (60.50%)

System,DUP: Size:32.00MiB, Used:48.00KiB (0.15%)

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




