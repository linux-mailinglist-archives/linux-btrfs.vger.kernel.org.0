Return-Path: <linux-btrfs+bounces-12370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D2A6702C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5033D3B3060
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5619F424;
	Tue, 18 Mar 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FAvbIESL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61879E1
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291224; cv=none; b=SkmDYLDR3fKYa0zgH64g7gXX1dIiasXfgwk6mhv3fQO2VBUQMFeWwXDoXk2CMiQsVBS3aRC0rjP9wsPO+XWkBzroNy7aYj9UwRzfRt5gQ0fxaF24ZtSkA+m3tfheKvo6BxM0ZzFVQXKNsIxs44DO2KXRjO5vCJcZTBn/Bdn+lKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291224; c=relaxed/simple;
	bh=p4b5Nt4Rs+6lKUuvaxX9yuKMjutatRrgPtXf8F3XBBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFZBgLSOUSATalrOD/B8YuvnHXJOtbGEtXW9nGlf7lS9Ht19C2orj9irJzlR6wK3MCBhqZMZT6tSJ9weUrBNvQSORz1MuLUO/g9gnAyBSOf6uKLHkzSKiLxGvmPeM9V2rB0yRa+ULrA7jMMBx9YHAAMIGbtVqAQuU6qCfpDNLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FAvbIESL; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 64F6314C2D3;
	Tue, 18 Mar 2025 10:46:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742291212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cM4JKQrUwVHZxpUnorkdDpt/Be71iNRjKu2U5aEABGc=;
	b=FAvbIESLL1QRtwHCciXbn1d2FXaDGbl9C3MPW9v+6iUEfj82gZDI2QEb0E8ps8IdWYq2JY
	1KF/p6XajBhQU3cJhF2I7kZfF1eZBsnHFAGbo0YUpcxQ3NDJrzcKws19dyn9JIt5vTEf2b
	GUF6L/hcMMkPzqn7/+62PtnO/g/sbc9g2nS4J/A7K/9Uk4qz65m+sligJZM1YDjJso7rLy
	nwVJl4t1DU+m2SAg84lUqZ24jpf6KurpztRdD/+GAtknVYk1tF7qCBUpCniSzII2QSBgyB
	zyKSymG+vj869GWlv3KmVDXWixcLnim+/lIAkIJBfqRXv0ULDPEGddIhQnac6Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9c157c6d;
	Tue, 18 Mar 2025 09:46:49 +0000 (UTC)
Date: Tue, 18 Mar 2025 18:46:34 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs-progs: resize: remove the misleading warning for
 the 'max' option
Message-ID: <Z9lA-mONFDDzqW7P@codewreck.org>
References: <5c9857b5fbc5b71984594f2f7e6f666cc435118a.1736525474.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c9857b5fbc5b71984594f2f7e6f666cc435118a.1736525474.git.anand.jain@oracle.com>

Anand Jain wrote on Sat, Jan 11, 2025 at 12:11:35AM +0800:
> The disk max size cannot be 256MiB because Btrfs does not allow creating
> a filesystem on disks smaller than 256MiB.
> 
> Remove the incorrect warning for the 'max' option.`
> 
> $ btrfs fi resize max /btrfs
> Resize device id 1 (/dev/sda) from 3.00GiB to max
> WARNING: the new size 0 (0.00B) is < 256MiB, this may be rejected by kernel
> 
> Fixes: 158a25af0d61 ("btrfs-progs: fi resize: warn if new size is < 256M")

Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

> -	if (new_size < 256 * SZ_1M)

(I was about to send a patch changing this to `if (new_size != 0 &&
new_size < ...`, but this works too)

Thanks,
-- 
Dominique Martinet | Asmadeus

