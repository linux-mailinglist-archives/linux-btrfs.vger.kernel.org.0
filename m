Return-Path: <linux-btrfs+bounces-15933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1FEB1E829
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 14:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D357A42AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35527700C;
	Fri,  8 Aug 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="M92IArc3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E51E7C34
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655428; cv=none; b=ShJkJNjDcVW0wcDFPqhQaCLPEzb7VFjQilYlbfwb/eEGou5Tz8fOxvJazeTfjtAwKuMtPpzo7kC6OTTt1TbYmzJPuVt9veSZ2eyM+0CAFrN93rZV7LKPYJW43+eFoAhdDvymQ3ekv11NhKpRcSvtMM4CGU2mj+YyLoz8RuggO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655428; c=relaxed/simple;
	bh=Y92+IMvICiJ1r42tR7WNIvGO3deeW5e46rKqzrXjKfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGAMoipjtC4adqv9XAEYQEdO+6uG6rU/okaQx7ZnQ8BGL+BafWT2QlZ8fW8xm+jW9f2rthfCe1aJJNAg1Ii5lJtrFYhft/T2mX/0KwiICjeeIzYRiEzXMsv39pkqaLmMbr/G9cQ9tTW29xOmwPZ4Goz4R8gEOJdUhPk8PjDDdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=M92IArc3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-76.bstnma.fios.verizon.net [173.48.113.76])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 578CGxnl001376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Aug 2025 08:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754655421; bh=yCCpjIqmVHoeUa/8t+Ug37kq7ZMxL4KNoxaQysxunz0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=M92IArc3xqIILSkxfRZBpLVcShAPVcKNuyAYV2Vd7Y81cmoAZ2klRSg6MgqrG1+Sa
	 cSv8Np5c4mzHwOBAAkdUZ+DdRyoWi1k8gu6ZlNnwHt38V1mOTROilxbgytbjKGrkEn
	 odDbaLykat79IKtdZGdSMWc+63g468tyxpTaMulPEaJrYuD9Mm5znwEVa3RLy7CQDs
	 EaH1dEtsMioM9r3icbQn2pKquX5lxabCMIk6OIWpEH0hv2mJ2DGkI9XizuD4qKXJ2X
	 AWUDeyFwgXKHGrFyh+SVkDez/zU52QDk2ujXB/g+8wYpKwdROwljwDB0f9PA1swzCb
	 e5FEtTuTHcQzQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5B2BE2E00D6; Fri, 08 Aug 2025 08:16:59 -0400 (EDT)
Date: Fri, 8 Aug 2025 08:16:59 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
Message-ID: <20250808121659.GC778805@mit.edu>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>

On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
> 
> 在 2025/8/8 17:22, Qu Wenruo 写道:
> > Hi,
> > 
> > [BACKGROUND]
> > Recently I'm testing btrfs with 16KiB block size.
> > 
> > Currently btrfs is artificially limiting subpage block size to 4K.
> > But there is a simple patch to change it to support all block sizes <=
> > page size in my branch:
> > 
> > https://github.com/adam900710/linux/tree/larger_bs_support
> > 
> > [IOMAP WARNING]
> > And I'm running into a very weird kernel warning at btrfs/136, with 16K
> > block size and 64K page size.
> > 
> > The problem is, the problem happens with ext3 (using ext4 modeule) with
> > 16K block size, and no btrfs is involved yet.


Thanks for the bug report!  This looks like it's an issue with using
indirect block-mapped file with a 16k block size.  I tried your
reproducer using a 1k block size on an x86_64 system, which is how I
test problem caused by the block size < page size.  It didn't
reproduce there, so it looks like it really needs a 16k block size.

Can you say something about what system were you running your testing
on --- was it an arm64 system, or a powerpc 64 system (the two most
common systems with page size > 4k)?  (I assume you're not trying to
do this on an Itanic.  :-)   And was the page size 16k or 64k?

Thanks,

					- Ted

