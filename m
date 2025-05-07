Return-Path: <linux-btrfs+bounces-13810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5C7AAEDD1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1743A504005
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F928FFF4;
	Wed,  7 May 2025 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RinESwQd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B619343B;
	Wed,  7 May 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746652735; cv=none; b=slRGEByMrJVp3gAzRham8Tk2DAn0f4CN7xljHgSKOBoWzO91Yq3AV17z+7XNaSW9/dPxhHVgNFg0qxgzGx6s9beRPD+XCfBozCW0XouhDK/G1MMJzWNjIIo87/ZLqmijxDwXgGk9ZV76FHErXyF+EfyiuHRZ0MPUt18KSCIq6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746652735; c=relaxed/simple;
	bh=Rzoa//+suWP+65hhHc1KbF30oGorhKVv9nvFCeLfsU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6XXp3PQZWKutzmXURAJYl4k58Q9R+lqDJyYXi4l9zaFW6zxcbPrkFUGrmDS4ahBxwRbWf5XCWhllj8MqpNIMYCdfinZ1fu+vhFsl4hhQjocBk2tJa0jyRbmggt1VELhw5qDnL0dB8h3GpGfRxpQb3N/OCB8pS1sWVxxX8VY3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RinESwQd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QTihWgIiBkpZ0So2wXnOWa/xllZkmD8mBa818vmY+ag=; b=RinESwQd87yy5BJVrPytdkF/yT
	IHjOC3NetkE10Z9yLZXv4sdSE7fogbOjzKNyH8BCZqA7WfHOO3E/T/T/Vmpy1fYDR0qeP6f1yhXmd
	uPJYfsTR/0YgzqKr+HFRLHRXMVq5x7Rt/5fsGrzA5amxGKaULOZKgsSSNaFVMlKKCU92IEdfpfr58
	Q0GpF8M+Scl8JAKbsaIbWTRnpMyA94Z5UeCzkR4wTuzLSu88lNSVm6YPf8tHx5/vnFRFgWoFV07cM
	lNvLhHEURJgrnNF89r59Np+yyzHnuFATVhTeicAUXlyixzBqGtK3ZsBJWzC9SO9bVd3XyBXQJK8z8
	gvYIhSmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCmAF-00000001d1n-0KRR;
	Wed, 07 May 2025 21:18:51 +0000
Date: Wed, 7 May 2025 22:18:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-btrfs@vger.kernel.org, riteshh@linux.ibm.com,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, disgoel@linux.vnet.ibm.com,
	dsterba@suse.com
Subject: Re: [next-20250506][btrfs] Kernel OOPS while btrfs/001 TC
Message-ID: <20250507211851.GX2023217@ZenIV>
References: <75b94ef2-752b-4018-9b2a-148ecda5e8f4@linux.ibm.com>
 <2a17b9b1-c490-4571-8f6a-fa567ed0b57e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a17b9b1-c490-4571-8f6a-fa567ed0b57e@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 07, 2025 at 09:05:42PM +0530, Venkat Rao Bagalkote wrote:

> > I am observing kernel OOPS, while running btrfs/001 TC, from xfstests
> > suite.
> > 
> > 
> > This issue is introduced in next-20250506. This issue is not seen on
> > next-20250505 kernel.

Braino in fs/btrfs/super.c patch - in a couple of places 'fc' should be
replaced with 'dup_fc'.

See https://lore.kernel.org/all/?q=20250506195826.GU2023217@ZenIV
for replacement patch...

