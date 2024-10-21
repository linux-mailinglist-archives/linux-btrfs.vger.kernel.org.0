Return-Path: <linux-btrfs+bounces-9041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361EF9A8FCD
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 21:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAA61F22E7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E91EF945;
	Mon, 21 Oct 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Hn24H+35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HU2CyUyF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314A1FB3F1
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539008; cv=none; b=oTt1o3qJfxAQsy/eNCjNxqNjU0xzEApyft4/mtQnpu8MEqvsgXhJlN3icPP4mDb58xfrwq58Y/RRLC/c+GJLgmZsUDON4gMjnMAvG5Ch6ZEOX/y9tVYR5rxiyTdNk1e14foBEiIzQJ5pMtSIuxxMmHqRX9wjf9Nfwqih7nGryCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539008; c=relaxed/simple;
	bh=Bo+XG1xG01hsBPAPx8G3g51Dwj0JI0HvnHNEEXRmocE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz31fbUf4R957H0vJz4GOiKWPzcN9kBZrbeHzsbQ5k7xg1W4yqkzYZbu8gGFLmrbrd2+wIrIXPi68ieZUhQ4vBbqLgYbgp5FHwYl8SrXRuoLSnLziGsI70bgLTuDwJs8wYN2NnhE6QsChPp+E9ELF87/0xAwDAHFoGTGLk8Mi9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Hn24H+35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HU2CyUyF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 07F6813806E4;
	Mon, 21 Oct 2024 15:30:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 15:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1729539005; x=1729625405; bh=sR124NpQA8
	3XkapmZ5HnkSVu7MnCFLQMQh/qpQv0ufI=; b=Hn24H+3599qLJAaUL10anDLhpi
	V727eqNKvcAkOd0/ulodZ3E5+UJlhrmxi+lPvsNVSB3M2IRnZesLorN6c7G2NbUB
	bLpYiRMk2h/0dWklOJe/1aTvOy8HJ1WrIsciC9Ik+P6oBB+mAM51V+6ZFvjsp+ZP
	0TZzFkYsQjIbF6XWHlEtNblX6Dhv3NUcoC3BzhdyZIZZ7I83CTmrZ01DMKJxo+2a
	JSgbsyWHDVkVtsPnMACQVYsag7VI1R1+DehDrc7IxVYfh+0Xi3NRJwoZVl250stp
	VhOdhylyxS7JZC7sx/0VZsa2V7P5F1/zLJq77ncST+wPS2Z//NdV7rZnhT/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729539005; x=1729625405; bh=sR124NpQA83XkapmZ5HnkSVu7MnC
	FLQMQh/qpQv0ufI=; b=HU2CyUyFg6cLAtoe+bNPOuMWXQKF8zTqWERKwKEyOs6/
	vStahTSMYy0dmdCPkc1ozKRuDfEFQxUOlKtL256bOZQPPlWNGSgl+tk1q5dWSRA4
	0drHhG00q13OJNh/d3PvEcRlJsVYmFxN0URArtdkIW3h5ifbi5oF5VM8LtzEGc8o
	MeOu1oFFSB8iqDO2WLXlc9X//tQwvLvzsJX0+MX24gMCyySQZoR2pNqs5GiAckr1
	2yiAJ0THGYnBSGzKcInSy3KfY1QkEyssYQvs885Utj5A2uBG1hagPesverxtbmBZ
	pqn2zcNoOgsVJwtQzlr7UEq6w93fG/YBepSn1fHgTA==
X-ME-Sender: <xms:vKsWZ_II0wJfONDQfbViVuQcTC21-f8movT48LYM5UuCnMBNlEKP5g>
    <xme:vKsWZzJX8jDqqeMxoavQH2e1Jmi_YrSW21LNudtHWrM31A_oHjyh5o_Pdr8LSX8g8
    hJ9VnFe6yVAQcx5fdw>
X-ME-Received: <xmr:vKsWZ3tk_kbeywAxzpUvNdaKC03Zp2Fcko2lMj-00cpuKnxbLgx7arF7zYVbY9pcmRxq3A66aW4TWGdIJ-o2U_2OKTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepiefgffekheetvdeivdetieethedtgedujeefgeeivddvgefg
    heelveduueevledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvghlrghsthhotg
    hlohhuugdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtiidprhgtphht
    thhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:vKsWZ4a23liVV0lsLx-JPuaqHMbydCbQvsyOudGwasknvcZ9jkt_yg>
    <xmx:vKsWZ2bfm6KzOCbw4muGjAKJn2NTtKLw9Q3r_LheuO_qzrFvIWe5lw>
    <xmx:vKsWZ8BeAi6b4feUSLsUoZKfN3w89hITAhjnhqoo7rq_Aw-Mm15O2g>
    <xmx:vKsWZ0ZpwAMYDLTgtIZIsNI1nnkteJ-j8JAzRD8V1AVjnhUtBjOa0w>
    <xmx:vKsWZ2Hcjz48LX-Q3jJUDm0QJMEugVSdueH2KTw0wHrdS9MrHxjQZj-3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:30:04 -0400 (EDT)
Date: Mon, 21 Oct 2024 12:29:31 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <20241021192931.GA2861189@zen.localdomain>
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <20241017140112.GT1609@twin.jikos.cz>
 <20241017164159.GA3061885@zen.localdomain>
 <20241021185651.GC24631@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021185651.GC24631@suse.cz>

On Mon, Oct 21, 2024 at 08:56:51PM +0200, David Sterba wrote:
> On Thu, Oct 17, 2024 at 09:41:59AM -0700, Boris Burkov wrote:
> > On Thu, Oct 17, 2024 at 04:01:12PM +0200, David Sterba wrote:
> > > On Tue, Oct 15, 2024 at 02:38:34PM -0700, Boris Burkov wrote:
> > > > If you follow the seed/sprout wiki, it suggests the following workflow:
> > > > 
> > > > btrfstune -S 1 seed_dev
> > > > mount seed_dev mnt
> > > > btrfs device add sprout_dev
> > > > mount -o remount,rw mnt
> > > > 
> > > > The first mount mounts the FS readonly, which results in not setting
> > > > BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> > > > somewhat surprisingly clears the readonly bit on the sb (though the
> > > > mount is still practically readonly, from the users perspective...).
> > > > Finally, the remount checks the readonly bit on the sb against the flag
> > > > and sees no change, so it does not run the code intended to run on
> > > > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> > > > 
> > > > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> > > > does no work. This results in leaking deleted snapshots until we run out
> > > > of space.
> > > > 
> > > > I propose fixing it at the first departure from what feels reasonable:
> > > > when we clear the readonly bit on the sb during device add.
> > > > 
> > > > A new fstest I have written reproduces the bug and confirms the fix.
> > > > 
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > > Note that this is a resend of an old unmerged fix:
> > > > https://lore.kernel.org/linux-btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
> > > > Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
> > > > were also explored but not merged around that time:
> > > > https://lore.kernel.org/linux-btrfs/cover.1654216941.git.anand.jain@oracle.com/
> > > > 
> > > > I don't have a strong preference, but I would really like to see this
> > > > trivial bug fixed. For what it is worth, we have been carrying this
> > > > patch internally at Meta since I first sent it with no incident.
> > > 
> > > We have an unresolved dispute about the fix and now the patch got to
> > > for-next within a few days because it got two reviews but not mine.
> > > The way you use it in Meta works for you but the fix is changing
> > > behaviour so we can either ignore everybody else relying on the old
> > > way or say that seeding is so niche that we don't care and see what we
> > > can do once we get some report.
> > 
> > Please feel free to remove it, and I am happy to review whatever other
> > fix you think is best. Sorry for rushing, I just wanted to get it done
> > and out of my head so I could move on to other issues.
> 
> I'm concerned because change like that needs an announcement,
> documentation changes or eventually an optional change so both use cases
> are available. I haven't merged it since the last time you or somebody
> posted it because I don't see a way how to fix it without fixing the bug
> and not breaking the use case.
> 

That's fair. However, I assume we agree we need some fix, somewhere.
Anyone who is really currently relying on this and not cycle mounting
after adding the device doesn't get a cleaner thread, which includes
empty block group cleanup, autorelocation, deleting snapshots, and defrag.
I think subvolume cleanup and block group cleanup are probably the worst
to lose.

So let's step back from me impulsively stuffing this in to for-next and
do the right thing together :)

Thinking of our options, in no particular order:

1a. just land the fix
It's not great if a lot of people rely on the fs "working" after device
add. Some of them might quickly find the proper steps in the docs, but
this might confuse/upset people.

1b. land the fix but properly socialize it
We can also make btrfs device add notice that it is seed sprout and add
a loud message that you need to remount rw. If this requires skipping a
merge or two while we socialize it to obvious or google-able users, that
seems reasonable.

1c. land the fix and make btrfs-progs do the remount after the device add
This is kind of weird, but does preserve the expected behavior. We could
also add some seed sprout specific flags or commands as the "main" way to
do it.

2. have the device add detect the seed sprout case and really make the
fs read-write
If we are committed to the behavior, and don't believe in a userspace
only fix, then it could be possible to make the current path which
simply clears the ro bit also invoke some or all of the remount rw
logic.

3. do nothing (remove the fix from for-next)
I keep carrying an internal patch forever, upstream stays in danger of
running an fs without a cleaner. If no one runs a long-lived fs off a live
cd for long enough to care, maybe it is ok, too. But stuff like this is
out there in google, for example:
https://blog.elastocloud.org/2022/11/btrfs-seed-devices-for-ab-system-updates.html

That's all I can think of, but I'm definitely open to other ideas!

Thanks,
Boris

> > I assume your concern is that before this fix, the filesystem is actually
> > read-write after the device add, which this patch breaks?
> > 
> > My only argument against this is that the documentation has always said
> > you needed to remount/cycle-mount after adding the sprout, so there is
> > no fair reason to assume this would work. (In fact, it *doesn't*, the fs
> > is once again in a unexpected, degraded, state...)
> > 
> > But if existing LiveCD users are relying on this undocumented behavior,
> > then I think you are right and it's a bad idea to break them.
> 
> The problem here is that we don't know how the feature is used, the
> documentation came much later than the feature. So I take it as that
> people rely on code, not documenation, even if there's an undocumented
> behaviour.

