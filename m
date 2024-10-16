Return-Path: <linux-btrfs+bounces-8973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AEA9A1090
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 19:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81B32822AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52C20FAB2;
	Wed, 16 Oct 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CPoBlL+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DA+c+rHt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBC18732A
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099473; cv=none; b=AlIUuO4al3yAsjQ4gFVgLTPpM8NPgBGU5NQQc+iFsUENzfEJw++dT+BVG+obqKOtzZOKPT5m/2evP060w3Oo6YwKEWOmE2seq8yoZVz4GR4GS/pa9wE4P/YJjQUslq0hpXH8E1UNj7CZPlccuG1PF8sJY7iV6BLVIKVsRiQkKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099473; c=relaxed/simple;
	bh=0Gp+NGx8ltZCELqsXOlvY7Fzv6tc9wXCPsAnaJZXqFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwtb5pmbMkD6qeWfItFHM7aBJgfo9XtCa8kzLFYpFA71ksTn8keRqhCK1GgkbdlW6aiYj8ThQnKvhhdYHZH+7nQNmb5n6zoY7rMdGtjpOPuddUl1stBsxjPqHqj9RDNyJGOod3udqpeJAstZJTs+yvXPfefMqDPq7ysdcnAmOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CPoBlL+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DA+c+rHt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5172E13801B7;
	Wed, 16 Oct 2024 13:24:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 16 Oct 2024 13:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729099469;
	 x=1729185869; bh=Kt2nBYm3Ns3FIbv0Xl/ieA9j9OM7ePoOqwp/nGk5LDE=; b=
	CPoBlL+PCz5GlmLVET/N01TRIEmJcAe7k2Es0eskmK8lHwEPO41aUahWsAkbHQdP
	UjO8w+kg4oOX7lrHYgA+rsGFn+ooGp9L1QpgOCpBCKnZyDbrqS+nQ8X/RNBRTm5O
	UWNoanMV52SV1HALC/kBMrbJf6euK9iFPrfRDZwl40ee+SIaVlb3L4wZ3kCOshdV
	e28AbpD2rgjOZ5kZcxX+AzBSNeVRigqnZ3u3aTONKxG+v1aLs1tIHfl6DNJ6bueM
	+hNm1VPxmJvVFuhO7sFs6hgshnXZi0dRTTjY0I2Ecx3o+ULQFOKbAagwz00SqsU3
	UW+7JAZAXB5dyWWjdNpxIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729099469; x=
	1729185869; bh=Kt2nBYm3Ns3FIbv0Xl/ieA9j9OM7ePoOqwp/nGk5LDE=; b=D
	A+c+rHtim+B5tSi6TM1TLRwRQYxxXvRWgz9SiN/ST0lbvesTmFyzC6cDXmZcQHTM
	rIX9DdTilApxKDhhZhkHM2+z1mu7XYcnoQZ9qZo6D84hFAS2Gvyid/t54lufSzmv
	nahw36OCapNBLjtTAoQ844lrwrLa/yBFDtMuk1oF7oqt0i7aUPqvyxFZUZAR96iB
	By6zrcv0H7juk7sJV+l0ej+okzDaqrlnufHb9WdrPzgOBrHijIbmj//jozsuzUvh
	dPKMU3vko+Id8X5RZyNV5zsFZou45Q+kPS6rqjRDs3r+fTtHNxmi2KJXhsmAqLBV
	k7kjPk+cch8HvNFrxELww==
X-ME-Sender: <xms:zPYPZzaSvLz1Bw7rlYPW5VNr7TsPJ1rLWDcnjZOjkQCzM8aOw09Jrg>
    <xme:zPYPZybhZK2ay456XzdM7ZXsiCFxj8xzo3Mfp9CHVOh5XBxQWvHdklKTachScq5Lw
    O6jbl64haD-cBm_uEA>
X-ME-Received: <xmr:zPYPZ19ZpPB02yIw3YpNo2Vj6OocZXy_L-LZ3-Q4kFqIlPVS3ew4Fm6sBjrrkwr6FGZ0GflZRDg7hSLB4tyPq8aPJxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpedujedvkeffhfduleeijeevueffueehieffudejleekffeg
    vdelgefgffegfefhhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusg
    drtghomhdprhgvrgguqdhonhhlhidrtggrthenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpth
    htohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnrghnugdrjhgrihhn
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgt
    ohhm
X-ME-Proxy: <xmx:zPYPZ5rTvChL9c412II0rSZqffrj2MpO_d4E3hshqDyPM08PfsCQQQ>
    <xmx:zfYPZ-o4vtjpuPMInrEVtOokeKiNov1jiUiy6Hqdi50mPhTqH4W7Xw>
    <xmx:zfYPZ_QTvxQZXNAADe86WQU20kj1mu4uiZXnaX8hrAO4g328l1NmfA>
    <xmx:zfYPZ2pI1vC62J4heSmhv6mXfqpuN1qKcFWYasnUp2uPcRjbTxNkMg>
    <xmx:zfYPZxWE8q0FlR1n_YPMYzKtjnX1uUyHNMPVANrXgzUxwbZ1MnO4Bu6A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 13:24:28 -0400 (EDT)
Date: Wed, 16 Oct 2024 10:24:04 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <20241016172404.GA2521545@zen.localdomain>
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <694552b3-5f70-48d2-a62f-4c2b8caf10fd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <694552b3-5f70-48d2-a62f-4c2b8caf10fd@oracle.com>

On Thu, Oct 17, 2024 at 01:14:16AM +0800, Anand Jain wrote:
> On 16/10/24 05:38, Boris Burkov wrote:
> > If you follow the seed/sprout wiki, it suggests the following workflow:
> > 
> > btrfstune -S 1 seed_dev
> > mount seed_dev mnt
> > btrfs device add sprout_dev
> > mount -o remount,rw mnt
> > 
> 
> 
> 
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
> > ---
> 
> 
> I remember fixing this before. I tested on 5.15, and the bug isn't
> there, but it’s back in 6.10, so something broke in between.
> We need to track it down.

Thanks for weighing in again, and for re-testing on 5.15. That's
interesting that it broke again. And sorry if I didn't follow the rdonly
check patches properly and those did end up getting merged. Poor code
archaeology on my part :)

At any rate, I have pushed this patch into for-next for now, as I
think it constitutes an improvement without breaking any documented
behavior. If you look into what happened between 5.15 and 6.11 and want
to back it out with a different fix, I will not be offended.

If we also land the fstest I submitted, then hopefully future kernels
will *not* be breaking this again!

Thanks,
Boris

> 
> The original design (kernel 4.x and below) makes the filesystem switch
> to read-write mode after adding a sprout because:
> 
>    You can’t add a device to a normal read-only filesystem
>  so with seed read-only mount is different.
>    With a seed device, adding a writable device transforms
>  it into a new read-write filesystem with a _new_ FSID and
>  fs_devices. Logically, read-write at this stage makes sense,
>  but I’m okay without it and in fact we had fixed this before,
>  but a patch somewhere seems to have broken it again.
> 
> 
> (Demo below. :<x> is the return code from the 'run' command at
>  https://github.com/asj/run.git)
> 
> 
> ----- 5.15.0-208.159.3.2.el9uek.x86_64 ----
> $ mkfs.btrfs -fq /dev/loop0 :0
> $ btrfstune -S1 /dev/loop0 :0
> $ mount /dev/loop0 /btrfs :0
> mount: /btrfs: WARNING: source write-protected, mounted read-only.
> 
> $ cat /proc/self/mounts | grep btrfs :0
> /dev/loop0 /btrfs btrfs ro,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> $ findmnt -o SOURCE,UUID /btrfs :0
> SOURCE     UUID
> /dev/loop0 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
> 
> $ btrfs fi show -m :0
> Label: none  uuid: 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
> 	Total devices 1 FS bytes used 144.00KiB
> 	devid    1 size 3.00GiB used 536.00MiB path /dev/loop0
> 
> $ ls /sys/fs/btrfs :0
> 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
> features
> 
> $ btrfs dev add -f /dev/loop1 /btrfs :0
> 
> # After adding the device, the path and UUID are different,
> # so it’s a new filesystem. (But, as I said, I’m fine with
> # keeping it read-only and needing remount,rw.
> 
> $ cat /proc/self/mounts | grep btrfs :0
> /dev/loop1 /btrfs btrfs ro,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> $ findmnt -o SOURCE,UUID /btrfs :0
> SOURCE     UUID
> /dev/loop1 948cea35-18db-45da-9ec8-3d46cb5f0413
> 
> $ btrfs fi show -m :0
> Label: none  uuid: 948cea35-18db-45da-9ec8-3d46cb5f0413
> 	Total devices 2 FS bytes used 144.00KiB
> 	devid    1 size 3.00GiB used 520.00MiB path /dev/loop0
> 	devid    2 size 3.00GiB used 576.00MiB path /dev/loop1
> 
> 
> $ ls /sys/fs/btrfs :0
> 948cea35-18db-45da-9ec8-3d46cb5f0413
> features
> ---------
> 
> 
> Thanks, Anand
> 
> >   fs/btrfs/volumes.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index dc9f54849f39..84e861dcb350 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >   	set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
> >   	if (seeding_dev) {
> > -		btrfs_clear_sb_rdonly(sb);
> > -
> >   		/* GFP_KERNEL allocation must not be under device_list_mutex */
> >   		seed_devices = btrfs_init_sprout(fs_info);
> >   		if (IS_ERR(seed_devices)) {
> > @@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >   	mutex_unlock(&fs_info->chunk_mutex);
> >   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> >   error_trans:
> > -	if (seeding_dev)
> > -		btrfs_set_sb_rdonly(sb);
> >   	if (trans)
> >   		btrfs_end_transaction(trans);
> >   error_free_zone:
> 

