Return-Path: <linux-btrfs+bounces-12300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D064A624F1
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 03:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8796319C6BA2
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 02:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F853189916;
	Sat, 15 Mar 2025 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="ytzHm3Jy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04E189B9D
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007127; cv=none; b=TaVQBn3Ihz6dggTzFS5ZhI2NLW4+J0dXEsI1IlrpR/1MxZRJcSrVYAgwe/l8z/5caOvJywi0Y9xUciGoI47e5eOjbyVwTxIVoW8D7znbB/SI9tPQQNlzqgChSHtbUdQmUsHaJ7EgGZ/jDh3M1VwJtLWqvcTPpD69zdF37KSo7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007127; c=relaxed/simple;
	bh=AT37cZdFq40xGyvZtOwppkGBAmzbvjOwxnCxM12jzWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqZqDiiOk40c2TAUUB4GO028MO6ugV/ZcKYzVrf7ix8R6zjyGaLXpMlAO6DXRkyCokIRKYXuxQ71rpUu8PobxfLriZZ85/x+bpVJ0EhSL/XFNSM54aQiHHYWN5v5QzAP+XtKkyDrxiKso/9GynlgNiOyX5o8cqlqkA0B56MfSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=ytzHm3Jy; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1742007122;
	bh=HheAfASilzJn70fNk5WdU6EeQXYVYexJoAkIe7W4p8A=; l=753;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ytzHm3JyDfuldLbXL7c0+eaR2zGFHzauQjqOtce33lKVp51IIDjCUwEQuhc8cqY1H
	 DziKqE/pyH4xsG+jfHTW2nDg8fdeJaj/2VgHIWKCrgBjUS4XsBRQg8Pnln0cb8B39u
	 k5zSZ/QXoxxUrJXSQv3FAIfYNPR+YilZfYRvdddQ=
Received: from liv.coker.com.au (n175-33-134-179.sun22.vic.optusnet.com.au [175.33.134.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id EEA0D15B16;
	Sat, 15 Mar 2025 13:52:00 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: Thiago Ramon <thiagoramon@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: strangely uncorrectable errors with RAID-5
Date: Sat, 15 Mar 2025 13:51:19 +1100
Message-ID: <3813747.MHq7AAxBmi@cupcakke>
In-Reply-To:
 <CAO1Y9wpT=gZgWD0=69TUefB-+qOSEY+9+zypo89PMQdgdO_P9w@mail.gmail.com>
References:
 <23840777.EfDdHjke4D@xev> <3349775.aeNJFYEL58@xev>
 <CAO1Y9wpT=gZgWD0=69TUefB-+qOSEY+9+zypo89PMQdgdO_P9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 15 March 2025 06:32:46 AEDT Thiago Ramon wrote:
> > while true ; do
> > 
> >   for DEV in c d e f ; do
> >   
> >     dd if=/dev/zero of=/dev/vd$DEV oseek=$((20+$RANDOM%3*1000)) bs=1024k
> > 
> > count=1000
> > 
> >     sync
> >     btrfs scrub start -B /mnt
> >     sync
> >   
> >   done
> >   date
> > 
> > done
> 
> Your script is writing randomly to ALL your disks. You just need to
> get lucky for them to overwrite the same sector in 2 different disks
> to ruin RAID5 and RAID1. If you want to stress test the filesystem you
> need to pay more attention to what you're doing.

Are you saying that the btrfs scrub is not designed to correct the errors?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




