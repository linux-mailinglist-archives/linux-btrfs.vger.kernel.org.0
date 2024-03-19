Return-Path: <linux-btrfs+bounces-3447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E5880627
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 21:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549F51C21620
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF003BBED;
	Tue, 19 Mar 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nFm1XFCl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F323BB38;
	Tue, 19 Mar 2024 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880989; cv=none; b=P8RV3WwUSR3+LR7v+woapY71eTyr4+d4IlR/rT6TX0WBGPLc8oaQ5fMiid1ablp4KhL24lpBXUYbWWzYWCAfoYC0eMNEjTh3lofpkJFmysEU/yi8S0bNoe5YS0nU9a/qs2B85vgtsKAMFjDhhHdc511odAju4xasSL2AwKUMAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880989; c=relaxed/simple;
	bh=QkswPpgOtXXFNcDeCoeEx1SieVgPGMW3NjoP3EmstgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/xfL+hTeLaBQKpTeDZaY541ya9PJk75tvTnRXOgXgBtL8YnxuuldeXo1nYTcrlk3+pB3KuLfn+VFzk3P7qx7vNVcrOEjzJ+O/3VMsYzslkHmg5dXtb3LidFLL/MdNGnRvAGx2fExRFU+yxO+7g5uLxvN/mGG9RIn7MXxX6nRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nFm1XFCl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rYtbm5+pkm2dKroe0uH9xBfAGU8+RFH65jr8MzNOzaE=; b=nFm1XFCl4gKjulVBLv6C51RtOj
	Inn9FOwWxNkigQ5QTmS22NunMtOtEKn2JoqhAcIoCvdlvasVxJVsPswi6ebwrxgOunVGoY7wD0y/I
	rhFSoZ4Z/AtfJ73t38C/xnztrZh0k1SuXkUBDyBq6zzYEz6N05QLN2hbNFptX92jMOi7YEJb05FAs
	F/KCwrYVgNknBEJNGxMl1C90XaeTIvZ5Brk5tRM6sHXLHVydOK+AGLQgH5MI0eBHwvvMbzR8qejqR
	jpVrzUyf64GjR74klgqMZSxG1iaOLJQUK8TK7Od3/aidHxKlYyhplr5N4R9WbuvuhfSSYE7wNZ0bj
	ANwXv2yQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmgIa-0000000EA05-04M2;
	Tue, 19 Mar 2024 20:43:04 +0000
Date: Tue, 19 Mar 2024 13:43:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, Anand Jain <anand.jain@oracle.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <Zfn412vXi8V7Sqd3@infradead.org>
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
 <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 19, 2024 at 12:16:33PM +0800, Zorro Lang wrote:
> I didn't suggest to make it a shared case directly, I asked if there's a
> _require_xxxx helper to make this case notrun on "not proper" fs, not
> just use "btrfs ext4" to be whitelist :
> 
> https://lore.kernel.org/fstests/20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> In my personal opinion, the "shared" directory is a place to store the cases
> which are nearly to be generic, but not ready. It's a place to remind us
> there're still some cases use something likes "supported btrfs ext4" as the
> hard condition of _notrun, rather than a flexible _require_xxx helper. These
> cases in shared better to be moved to generic, if we can improve it in one day.
> 
> It more likes a "TODO" list of generic. If we just write it in generic/
> directory, I'm afraid we'll leave it in hundreds of generic cases then forget it.
> 
> What do you think?

I like we're you're going, but I'd like to take it a step further:

I think we should just kill _supported_fs entirely.

tests/$FSTYPE is run for $FSTYP only, period.
tests/generic/ is run for all file systems, and run/notrun deciѕions
should be based on feature checks.  Where they can't happen without
fs-sepcific infrastructure we need a _require/_have check that
switches on $FSTYP like we already have in many places.  shared
should be folded into generic.

And a list of all hte places where we have to or should plug fs
knowledge in would be really nice as well..


