Return-Path: <linux-btrfs+bounces-8950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C899FC6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 01:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DD6B26033
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F4F1DD880;
	Tue, 15 Oct 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="bg/86Wop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDmzjmTx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8D1B0F1A
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034629; cv=none; b=LIPU6L+wVGPEz3RUPlUjM++/IvjTJmkg90/iL/Vcieh0xoutjNZpu7x76BFHltPmTmEss98iAy/lKfvJ1wwAcHiZGRgkIVN2Jv2ICJkoNgqmun8Q38SlJg2mLiJ82DtSoRvcvAEjRTEGGw0bkESDdlyPjJ4AtvazvB+AxQ8mRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034629; c=relaxed/simple;
	bh=8V/vvZorUVZj38Q77PFoxIKDTGGMZTjbtTL7x1R+lSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQAL+EJoKbxIT4ifLE0m4MMiIjqGR1dQisLjLdp3CPcLaV7UyBjKk0KJh6QBVMIEGFxyhq2ZVAgq5GpteW8RrBKXZiM5lFVev+lqiWJwEk4uoRa/UfXa+3mMrqEuC/BmuO0J3FL23NdMplmA2f57WDV3o46OjMx7mc8g8cvgvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=bg/86Wop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VDmzjmTx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77E301140130;
	Tue, 15 Oct 2024 19:23:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 15 Oct 2024 19:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729034625;
	 x=1729121025; bh=VgvJJdo9dWAspKCqL9LIAReGimNm1yJkdlFZIVYhS7M=; b=
	bg/86WopTQ4hHPONFe/sShqmEHOLqdoJavtx/CM1rhj1iU0yr48VZvNS1XhPYotr
	mE6CqSKJ1ZaeyiT69zI6SE4IEp8yChIRnNnxwoaSrEqJrX93tbOM81cqJuM4cs+/
	3epWtmtpbEbefIJdvIyW0NcVnyzQgZz6CXC8NZSBrdds3GkBz/sf4GyShPsTqzME
	6wB5EOI8hWAaUlzuvLoTWILZfM9KQWro8eC5W2T+hE0oC0f7zDrwGdPSXXcYdPji
	03GRbUM5oe3XMqBKuvTfvq4AY2Ws5xT5YLfW/E3yTLu4qIFyoiqZokph6MUjAY8R
	Hfq0HtI26HWnPeqqpcdkDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729034625; x=
	1729121025; bh=VgvJJdo9dWAspKCqL9LIAReGimNm1yJkdlFZIVYhS7M=; b=V
	DmzjmTxbnrB/0TlaYK6fxtOkjoyqaaotEsVJC/ltOAdaoPsaIxd9zIUw1N232I0G
	VSiRMk7kRDMlrGqGMSWqqw4AA6IsRcu9EMRge+ZfH63husvZYsK1ya8D1D7oBM3N
	Ra7fJwYqy6K17bkf325zt6gyt7GsBqsOHV0sQabj2AFl7dnHjBw16A99Cvmwnf1L
	8z1pyFxnejP9LglrnYktPcjBvc1dze1t68HRl1+xBwUa2w+VysrxIzPw3Ijz3RoQ
	WvNYFK11Q9U8hNlBpcyE90Kn2L/b57WILl4tmyawKDK0JPyvhAa7wU02hxW8mwIV
	hZVPd91dh6dyjlmhNULmw==
X-ME-Sender: <xms:gfkOZ1kKQPrtvV0jRQR3b6XwpZ5fT7jDRstX9_gOzVtpnwgSpDFVAQ>
    <xme:gfkOZw16khYcAeOU4yK-OFoYvsX-s93k3G-gVbNY1kyWB0or_fVbEbSmQNJzS3LdE
    mfIxRM2tLLbhcOBjvk>
X-ME-Received: <xmr:gfkOZ7r9YfejSvBeZ7PXuaJbgTJmce0vV18vk88fIXCIiiYJq2lmVFgFJgsfyxwN3LCmSB7inKoynOx6LvxxJPV0I48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehhfduhefgkeehud
    efvdetgfetleeuiefgfefhfeegjeekfeehhffgkeejhfdvheenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtg
    homhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:gfkOZ1mQCdfkWfFhFVoAskcPkOcqFp9VvooGG5dEyNgQj6AkFotrbg>
    <xmx:gfkOZz0wEqMcdQaJcKTDmPA9y6YvPDD3jh92eene6bRw5jyXg-cN9Q>
    <xmx:gfkOZ0v0N6WxyfSyElLOXmL-xqzawx-r758YqLCxZPmM2GwiSkrjWg>
    <xmx:gfkOZ3X3D1AmpinIM7rrvxXbvD7bkvKq133rbTFQsJngC4JpRrAbxg>
    <xmx:gfkOZ0x4cNYnOAv-sCBKMYr3xcT812_pUI0qBMbHxFgV8uaydEE2xMml>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 19:23:44 -0400 (EDT)
Date: Tue, 15 Oct 2024 16:23:21 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <20241015232321.GA1920606@zen.localdomain>
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <08994c44-da91-4944-8b9a-4522865e4faa@gmx.com>
 <483e1bd7-83d3-42fc-96e1-8c2b75dd5c7f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <483e1bd7-83d3-42fc-96e1-8c2b75dd5c7f@gmx.com>

On Wed, Oct 16, 2024 at 08:42:14AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/16 08:30, Qu Wenruo 写道:
> > 
> > 
> > 在 2024/10/16 08:08, Boris Burkov 写道:
> > > If you follow the seed/sprout wiki, it suggests the following workflow:
> > > 
> > > btrfstune -S 1 seed_dev
> > > mount seed_dev mnt
> > > btrfs device add sprout_dev
> > > mount -o remount,rw mnt
> > > 
> > > The first mount mounts the FS readonly, which results in not setting
> > > BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> > > somewhat surprisingly clears the readonly bit on the sb (though the
> > > mount is still practically readonly, from the users perspective...).
> > > Finally, the remount checks the readonly bit on the sb against the flag
> > > and sees no change, so it does not run the code intended to run on
> > > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> > > 
> > > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> > > does no work. This results in leaking deleted snapshots until we run out
> > > of space.
> > > 
> > > I propose fixing it at the first departure from what feels reasonable:
> > > when we clear the readonly bit on the sb during device add.
> > > 
> > > A new fstest I have written reproduces the bug and confirms the fix.
> > > 
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > 
> > The fix looks good to me, small and keeps the super block ro flag
> > consistent.
> > 
> > IIRC the old behavior of sprout is, adding device will immediately mark
> > the fs RW, which is a big surprise changing the RO/RW status.
> > 
> > So the extra Rw remount requirement looks very reasonable to me.
> 
> Forgot to mention, although it's a trivial change in the behavior, if we
> are determined to go this path, the man page of the "SEEDING DEVICE"
> chapter also need to be updated.

I just checked the man page and everything there looks correct, at least
to me. It quite clearly states that after the 'device add' the fs is
ready to be remounted read-write (via cycle mount or remount).

Please let me know if there is some specific update you want me to make
that I missed, though!

BTW, this patch does change the rdonly flag behavior, so I will update
the test to look at that, as you suggested.

> 
> Thanks,
> Qu
> > 
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > 
> > Thanks,
> > Qu
> > 
> > > ---
> > > Note that this is a resend of an old unmerged fix:
> > > https://lore.kernel.org/linux-
> > > btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
> > > Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
> > > were also explored but not merged around that time:
> > > https://lore.kernel.org/linux-btrfs/
> > > cover.1654216941.git.anand.jain@oracle.com/
> > > 
> > > I don't have a strong preference, but I would really like to see this
> > > trivial bug fixed. For what it is worth, we have been carrying this
> > > patch internally at Meta since I first sent it with no incident.
> > > ---
> > >   fs/btrfs/volumes.c | 4 ----
> > >   1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index dc9f54849f39..84e861dcb350 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
> > > *fs_info, const char *device_path
> > >       set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
> > > 
> > >       if (seeding_dev) {
> > > -        btrfs_clear_sb_rdonly(sb);
> > > -
> > >           /* GFP_KERNEL allocation must not be under device_list_mutex */
> > >           seed_devices = btrfs_init_sprout(fs_info);
> > >           if (IS_ERR(seed_devices)) {
> > > @@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
> > > *fs_info, const char *device_path
> > >       mutex_unlock(&fs_info->chunk_mutex);
> > >       mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> > >   error_trans:
> > > -    if (seeding_dev)
> > > -        btrfs_set_sb_rdonly(sb);
> > >       if (trans)
> > >           btrfs_end_transaction(trans);
> > >   error_free_zone:
> > 
> > 
> 

