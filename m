Return-Path: <linux-btrfs+bounces-21254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PKWAk5JfWlZRQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21254-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 01:14:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F56BF8A4
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 01:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AB36305E9A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 00:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97373285CA8;
	Sat, 31 Jan 2026 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="QNdaSzKh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqhgSAQd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973B261B8F
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818318; cv=none; b=Ia/98QOGkDfz3Ck/c0UdCqBmbStDvEUF3uFn+O8TdSXRprq7rwwfjHBOLmhSTGHnr8459x5euAOGAlY5Lto/MvNt/ohbgpkPHwf7BsqZdY6EZNeWqERWQgDJmnbtgVrZogDDgESwuyqnOOklOjl4ebe31JSuwWk8K6Zh1hvwf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818318; c=relaxed/simple;
	bh=8ea84Og8U89qJ6WGTlKBuNNxRbuLfXzorh6ppYEdS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiDtA7CBskqaJiBf1i3pJA4FFDX0AbJWromhJqGmOdDg7zTvfeu0FTcy22AwJe7xvsQO0Buxx0zD/oqPn8vAyRQZ5HWnjUVxSr89pjs9OODIDTayyibvKDWg/xzfADX6sEUeBPbNOGhshSgvZbbLeq7MrzIWG5IY1PW/wNNpQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=QNdaSzKh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqhgSAQd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56CF1140010E;
	Fri, 30 Jan 2026 19:11:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 30 Jan 2026 19:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769818308;
	 x=1769904708; bh=NpPt1MR/kllXkHIkzZyeQEf2kseQIDb+Y/Yq+1+nMyg=; b=
	QNdaSzKh/q1GSeObpCriuVvSgBtm4F6Zg8AEpAfDSTJDbE1pyv2/q8e8oasoj8BH
	fA+163Q933akFpnPvwAIG//F9aY9jNUh6FqfLLSm29gMeXOiVR1HBe2AIKw1G0Jm
	kZh9Bz/p//YlsvpAs+0nG69PAz97aaQNDGPlJCKK/d5hgvg7B/+7mx1A14OKeXDr
	3CceO1npb/0sD8V+o1ARyy8r+dXKQcwxofuiDENeHFZ18FMkcETxaJH+mCvL5n/z
	QgBwg6ny1WpNSDtz+Xn30LoRqk4pfkBtaTfaHMvxNkOLKNFMWpFU1IKXoV7OITHf
	7zONO44rU7hojWsu2C8gnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769818308; x=
	1769904708; bh=NpPt1MR/kllXkHIkzZyeQEf2kseQIDb+Y/Yq+1+nMyg=; b=U
	qhgSAQd6ZIqqLh0VSz8T0qhftJYYLZDBmhDfFFHGeJeV3CbsICRcheh8xCML3RpB
	wwvghpkNEsAkRbTWPBq66tksi3RLJWmzu9y6hd4o2/n02bBunO+NPQFtCmyf3oYC
	DVqj0SfW+jhhQxuYpekCG1KetTi93A12ufb37BXF+3l3i7UQrzHSJYKdDfbbTJct
	z9JQkqJqWkeL6Ztd0D3GjfPgFyQFp1wglTfbNYrjslE92F90vrBHWhy9BKRN6S+w
	37+cxUisj+r7GXIN5da1Tceb5Eg4WEBbsojGmWi1ZiW9Rtsd91kG+Mmt87zCa0cw
	dhnCHgLJaRSRtkgVx1hnA==
X-ME-Sender: <xms:xEh9aZRebC8gkaTv10UzrmVmqpALoHPluOIEl2H2nYnh7IziJqzhHA>
    <xme:xEh9aZojujF0L8BZir01LEnN0HzxHwhDuPeDAwZG5mcEqiCxNl0zfwew6lfLoxaw_
    mH8qTKDEMTc3siOPTKkxnJ0btxEuadl9zeJKDSwrQnEw3Vo4zRLg_k>
X-ME-Received: <xmr:xEh9aXIXSGlSBlnYzqjqCUhyjMo90YFzXxf4GuP4Gl9D_Cw0riEBOqMk9tIP6q5er61h5QaXSulZ7bI__p6w8eQ2HBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlohgvmhhrrgdruggvvhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:xEh9acqRe5djA7oCTrtNAp9GzKxg0OxM8yCpo_oczAvZvPCrdl6lfg>
    <xmx:xEh9afxL5kuz9h3K2i6d00vAB25Z5gSqPnjesNysFEFVx-uCdxYL2Q>
    <xmx:xEh9aQMcn9ENpSe-uuWcz7u9IGcLDeeE3BKK8dtEC3yMElfr0PE8ig>
    <xmx:xEh9aU7n5vb1W4hkPP_QjikA--EcwiEEWkwqRow4MTIy5A1ltCn0-Q>
    <xmx:xEh9afR1cghP8ZN8j-pUwMNVxb9pk8zNZoTpziQaHFlPktjI5rtEB5yn>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 19:11:47 -0500 (EST)
Date: Fri, 30 Jan 2026 16:11:18 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: Leo Martins <loemra.dev@gmail.com>, Filipe Manana <fdmanana@kernel.org>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
Message-ID: <20260131001118.GA1432933@zen.localdomain>
References: <20260130214319.3714908-1-loemra.dev@gmail.com>
 <4bff1e42-57de-4169-b3c0-a2085182cbb3@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bff1e42-57de-4169-b3c0-a2085182cbb3@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21254-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,fb.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zen.localdomain:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 29F56BF8A4
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 09:04:03AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/1/31 08:13, Leo Martins 写道:
> > On Fri, 30 Jan 2026 12:49:55 +0000 Filipe Manana <fdmanana@kernel.org> wrote:
> > 
> [...]
> > 
> > > 
> > > This was before a recent refactoring of should_cow_block(), but you
> > > should get the ideia.
> > > IIRC all fstests were passing back then, except for one or two which I
> > > never spent time debugging.
> > > 
> > > And as that attempt was before the tree checker existed, we would need
> > > to make sure we don't change and eb while the tree checker is
> > > verifying it - making sure the tree checker read locks the eb should
> > > be enough.
> 
> That may still be racy not just to tree-checker, but with the extent buffer
> writeback path.
> 
> Even we locked the eb for tree-checker, but someone still modified the the
> eb after tree-checker but before submission, it can still be very
> problematic.

Agreed that it feels very fishy, like we can write an eb with bad csum,
much like DIO and unstable pages. But do we think it *actually* matters?

In principle, if I buffered an eb, wrote total garbage to the disk during
the transaction, but then during the commit wrote out the correct eb, I
think that is still OK. If we crash, that bad eb isn't reachable from
any root when we mount again, right?

In the proposed design, the dirty page cache is that buffer.

> 
> Or we have to block all future writers until the eb is fully written back,
> which may slow down the whole fs.
> 
> > > 
> > > There's also one problem with this idea: it won't work for zoned
> > > devices as writes are sequential and we can't write twice to the same
> > > location without doing the zone reset thing which only happens around
> > > transaction commit time IIRC.
> 
> That's also the same concern I have, meaning having to again divide zoned
> and non-zoned metadata routine.
> 
> Although before all the new ideas/attempts, I'm wondering the following two
> points:
> 
> - With the AS_KERNEL_FILE flag, how frequent we're re-dirtying COWed ebs
>   We need extra benchmarks on this first.

As far as I am concerned, any amount more than zero is a bug when you
consider it from the perspective of the transaction block_rsv. If you
had an 8 deep tree doing splitting, then a single re-cow you didn't plan
on will use space not in the block_rsv.

In practice today we see 30x amplification at least. To flip it around,
what amount is "OK"? An amount that doesn't happen to cause ENOSPCs on
most machines?

I don't think it's responsible to let it slide and hope it doesn't happen
too much. There's always systems in global reclaim to worry about as well..

I do, however, completely agree that this argument means we should try
to avoid inventing some really wild and costly solution. Ideally we can
find something tidy to plug up the hole :)

> 
> - Is there any pattern of the re-dirtying COWed ebs
>   E.g. which trees are re-drity the most frequently? Extent or csum or
>   log trees?

In the Meta fleet data, the subvol trees and the csum tree see by far
the most lock contention, which I think is likely going to be correlated
with COW amplification. But we don't have detailed COW re-dirtying data
yet.

> 
>   Can we take advantage of such patterns if they exist?
> 

That is why I wasted everyone's time and brain-cells on those very tricky
csum commit root patches I kept messing up for like nine iterations :D

If there are other heuristic improvements I think it's a good idea, but
I think also doesn't change the reality of the transaction block_rsv
over-spend bug.

> - Is there any less invasive alternatives to changing COW basics?
>   E.g. Changing btree_writepages() to utilize some LRU so only the
>   oldest/least frequent accessed dirty ebs are written back first.

With sufficient sustained memory pressure I am not sure that something
like this will work, even to satisfactorily reduce the problem,
but I have not yet reproduced it without resorting to small cgroups
and no AS_KERNEL_FILE (as we have discussed elsewhere)

Ideas we have considered, which I think would fully solve the bug:
(in no particular order, and I'm sure there are others)

- Leo's xarray to block writeback on the shortest scope
- Block writeback on a longer but easier to manage scope (e.g. trans_handle)
- Block writeback to the whole tree while it's being cow-ed.
- Have writeback also take a new type of tree lock which cow paths do not release
- Relax the strictness of the transaction block rsv guarantee 

Personally, I am still quite excited about Filipe's idea and hope we can
make it work. That would be really slick.

Thanks,
Boris

> 
> Thanks,
> Qu
> 
> > > 
> > > Thanks.
> > > 
> > > > 
> > > > Please let me know if you see any issues with this approach or
> > > > if you can think of a better method.
> > > > 
> > > > Thanks,
> > > > Leo

