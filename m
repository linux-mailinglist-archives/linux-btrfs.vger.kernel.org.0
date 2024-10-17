Return-Path: <linux-btrfs+bounces-8986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB429A2945
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 18:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174C41F274B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23961DFD87;
	Thu, 17 Oct 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="E2gRZ0Te";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pu2MSp65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384321DED5B
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183352; cv=none; b=Cb0JTSP6dgmL2B0gVWgld5UYrZX9E0tNXS6wgLiCUuAxArmMY1ePn8QTGIurI+5ECaNSRDlxg/7mkZ6CAL+SCVbExxM3pav0uS4OtjhSRGfnOqpcTugrR9kq6vLBRW7RogbsWjD7mI+3B4lYb+XkVYHJFDorvsVC2boMyJ5Se6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183352; c=relaxed/simple;
	bh=b/NULi8Q2TGQRivD0ImBXkwjubBcn1XqP+GhfTcxbPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4Q7G9yQ/7ghSNVSS3pCIlNN6uTbEII3hYZP1p2QnvO1yS4xCBwqUybbtgPUCrb4l8K4ziTq11F7+f9cylaASohweGQ4TVJc3w9MZWyTUbvKsWwcJElla8c+kv8pnYBi4FIg2C9MhNPrFhKkqRymLL9jc9O9B71sEXGvZWlIkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=E2gRZ0Te; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pu2MSp65; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 153A11140213;
	Thu, 17 Oct 2024 12:42:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 17 Oct 2024 12:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729183346; x=1729269746; bh=fTmtoxu+zC
	XxvGO99fRfP+GSfjFrbK/HI3ordRjMVM0=; b=E2gRZ0TeRCjO4X13BHzgCXICni
	CafwiIOT0a4rYZa23si/z2IIlI/qHTah9+P4PHtojC5jf0GvDxg2IQ7XjzMNjGlb
	1gnpOrZ3YS+9PClOMdxk5dYUGBHq1O/g1HX609Is3/Qs7KChosJpyPIbSBb+iyP8
	4MUvTFjnCn/tSIcGN4OwFoaW50dq+pafTlLCKbQ9D6QVmVAz8McJ0pD3yN3XPAIu
	+y/IKQ5Ez/obG+9Wfq0VDrDY150tnQiDOLMcIOSuxkdvd0yrRSs2e3ASyfh95HKJ
	lfIRnfh5EuA7Y1GQOJfZSdD6TRpD3+MFe/3sntkQJPklDEfe9tEcvTCI2b8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729183346; x=1729269746; bh=fTmtoxu+zCXxvGO99fRfP+GSfjFr
	bK/HI3ordRjMVM0=; b=Pu2MSp656PvzfgZo+MyhUpXRbCG9Y2gKDK2vsmchVpvm
	/HemFZsEC0TOXK8AvTfXgY6mdxPDvbQmpAVfiFI6zGuxWEiEy4sWmsP6PGxhQAXz
	vseJf2fOHydMi0sv7PlLC2J0WS2rEFy2OnxU3osJftwxHyKNx8Dfb2ZrHpcp2MPO
	IPfFaIysvxTSnZsnQzkZAJC+lHnaaolCKEdl5ass6u1IAlq20XLl6+vPzmXyNr6j
	quh8VM4VnCQbNsMAawhvWFyiWvyufm2bpaUomSzHlPjs1HANL8WAHvrORSBIcsxq
	j7T/zmys8GKN9YbWgtOuJpvUovF3mg+oUBUgtaYc4A==
X-ME-Sender: <xms:cT4RZ5paNsAisJAGs1i7DgjwUxfmdoqYZYqtOLLP97dXHKZIhNHpDw>
    <xme:cT4RZ7oLeQYQ02KZCRRbDtJPZNHucRo3Ta87zjmUSeX2odL_CE5YGj7uJ65_ktZRz
    cXu-5VWVG4aFE42fsc>
X-ME-Received: <xmr:cT4RZ2Ny65Tq3BoTBTbzz_0yp6oB75LIXy-QXd-PJcXWGJMV6iqUg0mPtCfbHetqtxt64D1g_a2svJR8GR0MDrRuU14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheet
    leeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhi
    ohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfh
    gsrdgtohhm
X-ME-Proxy: <xmx:cT4RZ04SLIOoJlqDIi6d5xKvFQYDQj04r1o3jcxwfHirZonb4lPODQ>
    <xmx:cT4RZ46jYTILIZnwP2uyj4mK13ObPJrBSO2q0Cf189WjyZVfM9-kag>
    <xmx:cT4RZ8jTUphXViqQeiQ2XuI2TdZf8r3l0tLvk125JvDZpi3fosquYg>
    <xmx:cT4RZ65th2TceRoZaGe0KGeiCgATJqe5yPKZvTnoedv0_H7SsDrM9w>
    <xmx:cj4RZ2nqxs3pxAf6wZcQ_z6ujlSHNS3833BKoh2OSSyjL5wYEHrS3jRb>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 12:42:25 -0400 (EDT)
Date: Thu, 17 Oct 2024 09:41:59 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <20241017164159.GA3061885@zen.localdomain>
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <20241017140112.GT1609@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140112.GT1609@twin.jikos.cz>

On Thu, Oct 17, 2024 at 04:01:12PM +0200, David Sterba wrote:
> On Tue, Oct 15, 2024 at 02:38:34PM -0700, Boris Burkov wrote:
> > If you follow the seed/sprout wiki, it suggests the following workflow:
> > 
> > btrfstune -S 1 seed_dev
> > mount seed_dev mnt
> > btrfs device add sprout_dev
> > mount -o remount,rw mnt
> > 
> > The first mount mounts the FS readonly, which results in not setting
> > BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> > somewhat surprisingly clears the readonly bit on the sb (though the
> > mount is still practically readonly, from the users perspective...).
> > Finally, the remount checks the readonly bit on the sb against the flag
> > and sees no change, so it does not run the code intended to run on
> > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> > 
> > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> > does no work. This results in leaking deleted snapshots until we run out
> > of space.
> > 
> > I propose fixing it at the first departure from what feels reasonable:
> > when we clear the readonly bit on the sb during device add.
> > 
> > A new fstest I have written reproduces the bug and confirms the fix.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Note that this is a resend of an old unmerged fix:
> > https://lore.kernel.org/linux-btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
> > Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
> > were also explored but not merged around that time:
> > https://lore.kernel.org/linux-btrfs/cover.1654216941.git.anand.jain@oracle.com/
> > 
> > I don't have a strong preference, but I would really like to see this
> > trivial bug fixed. For what it is worth, we have been carrying this
> > patch internally at Meta since I first sent it with no incident.
> 
> We have an unresolved dispute about the fix and now the patch got to
> for-next within a few days because it got two reviews but not mine.
> The way you use it in Meta works for you but the fix is changing
> behaviour so we can either ignore everybody else relying on the old
> way or say that seeding is so niche that we don't care and see what we
> can do once we get some report.

Please feel free to remove it, and I am happy to review whatever other
fix you think is best. Sorry for rushing, I just wanted to get it done
and out of my head so I could move on to other issues.

I assume your concern is that before this fix, the filesystem is actually
read-write after the device add, which this patch breaks?

My only argument against this is that the documentation has always said
you needed to remount/cycle-mount after adding the sprout, so there is
no fair reason to assume this would work. (In fact, it *doesn't*, the fs
is once again in a unexpected, degraded, state...)

But if existing LiveCD users are relying on this undocumented behavior,
then I think you are right and it's a bad idea to break them.

As long as my test (and presumably some fix) goes in and I don't have to
carry this patch internally for two more years, then I am happy.

Thanks,
Boris

