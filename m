Return-Path: <linux-btrfs+bounces-15470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86159B02195
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B405B5400DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C222EF2B2;
	Fri, 11 Jul 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SlBxUVLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1HE58N7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3FD2EF2B9
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250811; cv=none; b=P+A2zRe2NboAOKzkVWaIFfnnaiDT3ah348x9Xt11xmpeqllucjoxLgCwnis6pOSgRPzGh21LpYK98eqtYTFikf2G8ThLItUwAjZxg2C8/H0z0G0SM0aRTzenbnutqt3GdSTiSK3dPENxgcWFn0a4P+2UMqmi2m++KmZ8vFLoEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250811; c=relaxed/simple;
	bh=UqqANR2lk+3NbPZgwISQC55aeDU+5NGsnBtOPWkPRAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mabv84U+JjsNQZOtY3TRXVNQMvyZY5KrmsQyw7p58g33mvvQtZes2+Z+onK1PeN+oVgWtWItIFdZ6TNyDSZvdIUuHQMKfWRQ7Du21P1x/nMVyy/KG5LAwQ0uPr2mXxFRr/Q06DVSOgsxYELwDgbcKYELNsAaFHNGhCaDIkkkZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SlBxUVLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1HE58N7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2711D14001DD;
	Fri, 11 Jul 2025 12:20:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 11 Jul 2025 12:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1752250808;
	 x=1752337208; bh=ADDXq+nOmYmRH+dYWQOoAG/6AWHSfj4mqZCFySFIrp4=; b=
	SlBxUVLJVX86Y/MllWPrGFUzXXuijxSoWZHs3Zgb6kdL2CVTmAgR3Aig5vx2RKFY
	+3wY2PRVZbxGcMVS4XNUWLmUNLyxKy5J3z0MtNEnqVl2mxFNJ5Fgo/p2EXpF/OFM
	7LPSi7SqUv7W46t6QagT/+bSFd+EbeNPPJj6u0OsbYyyjE+To3pdE1BovGMgmgZu
	ZRlSN/Av3w5j3AXjuSmNqYCbtzOCovm87PET0n9QsWJ0Mj9wxPU9unxeXnzHOTjA
	Wp4GrJnpk+guOQQjbJsl/YxeDO3pz1XF6xwe5D0+y6B3yk/DO13TCLZDlOEzjcYg
	1LsDVslllws4QteZLUbQ7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752250808; x=
	1752337208; bh=ADDXq+nOmYmRH+dYWQOoAG/6AWHSfj4mqZCFySFIrp4=; b=b
	1HE58N7GGD8lMow6R3y4HGOXwzec4+pBF+eaS0NmUBJa3Jrz/j0a5iuCe2Qz/LQh
	LJIA34vG3dPbyovbddaAaoKPwwYz42ehcUAUmJxz46dLlgbqxTQiRqWK8AioT/0G
	0Fg9glWfVwxVMWcXkkxFbf8/SMacCNCza6GVdm7JeUSKRCn9wOkAVXhp3hRDn1Cw
	oGTE4J6pVjR9JS/hY8OtEWDqAMtxQpMQ/kwq91Y/vwWCmBE5q9yfrOt9eSJeUHbT
	rcwc+vMYYdrnfqCeabe4CO6xVYvu6XjWZ0jWLldOFJnqOGssH4WRknD4Km3uAJGE
	YsKMFpkdl6p8h5y8rC80w==
X-ME-Sender: <xms:tzlxaNovMdSJgfVuHUkEFvpTWYVZS0KnsNpgtm2QPnfjaME1xAbGvA>
    <xme:tzlxaBJmiDgGXTZ5bd4ONMHUK2SCKmNs5IER8le7xMnSXwiQ-NB4-CcQwRhz81bNa
    liGuQ57HtuNUmkM-h4>
X-ME-Received: <xmr:tzlxaKRedYe63kR4RQC2Hav-QXyBZu7q6nxcl-fsqXp5Wt1AsIBfQygetekqrJ1Y7N2IyF2TxlncBXb7k416we7kbvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeejfe
    ffjedtkeegteekvdevvefhteevheffudduhfdtgefhudelvedthfehuddugfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughsth
    gvrhgsrgesshhushgvrdgtiidprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshes
    ghhmgidrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:tzlxaIv9LJsKr2ZGleMB6s65OtzfSPdyhr4t_CTWkFOMtWtPFmDz2A>
    <xmx:tzlxaDYeUBovMBmAwf3QhtgirzkbjARnAP3dCeFNXKVx6fCPjaKmiw>
    <xmx:tzlxaGGietQs-mb198xMW4S3TcKGQmQVvYFLmvWFBsT7xAI_m0h-vg>
    <xmx:tzlxaPyjSb4V3Qu5lAOniMI0L7IRqMYpCjH8Nfg7eFfMWifKXdEKeQ>
    <xmx:uDlxaLNCynMI_Vzm9ehyWadNg_d1N_4dShn_2n1W7CqXolYgNRDvpCmQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 12:20:06 -0400 (EDT)
Date: Fri, 11 Jul 2025 09:21:49 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7] btrfs: try to search for data csums in commit root
Message-ID: <20250711162149.GA1448937@zen.localdomain>
References: <112a66d49285e38d7a567aa780d9545baafd3deb.1752101883.git.boris@bur.io>
 <98154adb-057a-44d7-97a4-9bfd669b9454@suse.com>
 <20250710152606.GB588947@zen.localdomain>
 <1dbd43cb-7e1f-455c-8de8-4b91826b800e@gmx.com>
 <20250711100246.GB22472@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711100246.GB22472@twin.jikos.cz>

On Fri, Jul 11, 2025 at 12:02:46PM +0200, David Sterba wrote:
> On Fri, Jul 11, 2025 at 06:57:06AM +0930, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/7/11 00:56, Boris Burkov 写道:
> > > On Thu, Jul 10, 2025 at 04:45:35PM +0930, Qu Wenruo wrote:
> > [...]
> > >> If that's the case, I'd prefer to have a dedicated flag for it.
> > >>
> > >> In fact there is a 7 bytes hole inside btrfs_bio, and we don't need to
> > >> bother the extra helpers for this.
> > > 
> > > I'm happy either way. Sterba said he preferred to not add fields to the
> > > btrfs_bio on v2:
> > > https://lore.kernel.org/linux-btrfs/20241011174603.GA1609@twin.jikos.cz/
> > > 
> > > But at that point I didn't even try to find a neat spot in the struct to
> > > slot it in, and just dumped a bool on the end of the struct.
> > > 
> > > For my learning, how are you finding the 7 byte hole? Do you have a tool
> > > for dumping a particular compiled version of the struct you like? I
> > > started trying to count up the sizes of stuff in struct btrfs_bio and
> > > quickly lost steam halfway through the union with nested structs.
> > 
> > The tried and true pa_hole tool.
> 
> It's 'pahole' from https://github.com/acmel/dwarves

Would you like me to redo the flag packed carefully in btrfs_bio or leave it
like this in the bio.bi_flags?

