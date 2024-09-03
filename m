Return-Path: <linux-btrfs+bounces-7790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E594A969EFE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEC51F24FFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A71B12D8;
	Tue,  3 Sep 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="Ljt2gf+G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B61A0BC6
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370021; cv=none; b=XdK/F20uwrVkWqLZ3NgdXol45x6O4ypStau7WErMyQHxzz6nnGDsrxfGrc3nNt+GZhh9RACnjlS58eyLyG3VXR9df1TI+o2yKUMr0NIWnuWw3134dSy4duBUiwAGkB/gBqYMF641B5+07BOd2ucgp43o7yXOKaXbDW6eKQDeeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370021; c=relaxed/simple;
	bh=yWqHt73awSNYEAr2mplgcfpAepf9G46cyKROlZ6oyz4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/1JqSl2oytU8xwGfUZ4oe6vvTmrO8W733FrUd3zBtQacersmItfZPMGwGGPOPZDgoKySlkTxkLqQt7k2dV11CbyH75wP4TZSjN9ZtyS5tTwJJr27VZWyt51Ly2w0JHkh0iaor6MRNrtRnGBysPYyBMm8XU6mtbl07MhZwRrvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=Ljt2gf+G; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 28BFE60A09
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 15:26:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-transfer-encoding
	:content-disposition:content-type:content-type:mime-version
	:references:message-id:subject:subject:from:from:date:date; s=
	dkim; i=@rus.uni-stuttgart.de; t=1725370010; x=1727108811; bh=yW
	qHt73awSNYEAr2mplgcfpAepf9G46cyKROlZ6oyz4=; b=Ljt2gf+GjtnWOD4Hrd
	cBQCmd61gqH5yzJK/FheCM5DVeYKWBmrDygMLJS7uUnjGv46cbe2zQyCeKBO8JJT
	Ea0dBLYsXCKiyqpydUCiBpVdiWyt0+L2SCou1cf9EZ7jYXGk55fCEY/0xszr+dxG
	20PCPVm9TAeG50XKnOJ/8pmvD997htBwvjS3hP1A31yO1yVGnl2L3vubhtuWLoGf
	5NE2AryNLbkhnZLcqsVDDSf6bH/j50JTH64/K2urT0g5aLql7NurK91oIA9Wx09+
	2ft34JUK8zIflnelRPlBH+mvkcG/gXvjdt+KGh5Fo2yI+GsbjCcMWd4ZMBUuRMBr
	HSig==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id BDjloyNQcUDJ for <linux-btrfs@vger.kernel.org>;
 Tue,  3 Sep 2024 15:26:50 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Tue, 3 Sep 2024 15:26:50 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: workaround for buggy GNU df
Message-ID: <20240903132650.GB20488@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20240621065709.GA598391@tik.uni-stuttgart.de>
 <87le2s6gbw.fsf@vps.thesusis.net>
 <4da3947b-5412-ccaa-527d-d2263da7f36d@georgianit.com>
 <303dee41-7b6e-4a54-be75-acbc3b4da5a5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <303dee41-7b6e-4a54-be75-acbc3b4da5a5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Wed 2024-06-26 (09:40), Andrei Borzenkov wrote:
> On 25.06.2024 22:12, Remi Gauvin wrote:
> 
> > On 2024-06-25 2:13 p.m., Phillip Susi wrote:
> >>> The GNU tool df does not work correctly on btrfs, example:
> >>>
> >>> root@fex:/test/test/test# df -T phoon.png
> >>> Filesystem     Type 1K-blocks     Used Available Use% Mounted on
> >>> -              -     67107840 16458828  47946692  26% /test/test
> >>>
> >>> root@fex:/test/test/test# grep /test /proc/mounts || echo nope
> >>> nope
> >>>
> >>> The mountpoint is wrong, the kernel knows the truth.
> >> How did you get this to happen?
> >>
> >
> > Very easy to replicate.  If you call df with a path, it prints the
> > location of the subvolume in the "Mounted As" column.  No other steps
> > necessary.
> >
> >
> 
> bor@tw:~> df -T /home
> Filesystem     Type  1K-blocks     Used Available Use% Mounted on
> /dev/sda2      btrfs  39835648 20799988  16982220  56% /home
> bor@tw:~> df -T /home/bor
> Filesystem     Type  1K-blocks     Used Available Use% Mounted on
> /dev/sda2      btrfs  39835648 20799988  16982220  56% /home
> bor@tw:~> df -T /home/bor/bin
> Filesystem     Type  1K-blocks     Used Available Use% Mounted on
> /dev/sda2      btrfs  39835648 20799988  16982220  56% /home

You have no subvolumes in /home, therefore no problems with df output.
Try:

framstag@watschel:~: btrfs sub create tmp/test
Create subvolume 'tmp/test'

framstag@watschel:~: df -H tmp/test
Filesystem      Size  Used Avail Use% Mounted on
-               199G  154G   44G  78% /local/home/framstag/tmp/test

framstag@watschel:~: fst tmp/test
Path:       /local/home/framstag/tmp/test
Mountpoint: /local
Subvolume:  /local/home/framstag/tmp/test
Volume:     /dev/sdc3
Filesystem: btrfs

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<303dee41-7b6e-4a54-be75-acbc3b4da5a5@gmail.com>

