Return-Path: <linux-btrfs+bounces-670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2469805EBF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F399C1C210D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB266ABA2;
	Tue,  5 Dec 2023 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qxRvTL+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1O50rri0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E7137
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 11:42:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 303D43200A42;
	Tue,  5 Dec 2023 14:42:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 05 Dec 2023 14:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1701805350; x=1701891750; bh=Lj
	/YuSP4cbYANvNkckEP71e0lOZIffO120yrjheRu7I=; b=qxRvTL+wQzx6eVzOtb
	782RyXOF34aSNVw2B+/NQE4pwYYvg4XvzqAJgsvn4meoi84d4KAKzw0u+wVd7vgn
	3tvV3hcp1JfBHPRd2icsGTFd5osHmMv23vIq5IqxSf4Jdn80Actoh5YwOgEW1rPJ
	ycr0oWs21ypXZgDa0lKtNQfR+/4gHOlfcQCs4QEw9Nl7miJF/H8fM8VL8rrM7oKP
	jo7CJCEA52wCS25qgz1GP8ClAOHdSUW4tlI5n6QmTpXXg3JzfTQ78724Mfss4zy5
	8kDc+NzHvrTk+Gf3fL263Zzz+rY2DPf4881vw5eL+GJHmTOtEsmwSc94HRA9u10q
	5m3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701805350; x=1701891750; bh=Lj/YuSP4cbYAN
	vNkckEP71e0lOZIffO120yrjheRu7I=; b=1O50rri0Fk8QPyLofQeABVVDPviMM
	9XirLvGY2r86Rt6w0qXKhQ7g93Lj/4bL01oRZxkGILFpzgXPPU/25DZbRwT4NpPQ
	2X5LblmbGIt+UHgyzUVV+djOU1dqo9vRVa7AnumKHruOrBf+eKhlIhluIcnFj6af
	f3KK9xkwTRxJ8tGd8AD/P6sNWq1G6bM0RbmcQQthUOx635wRflK8A+KIvUF+4x80
	dVLPgN6Jc4ZONZExp2IJOOMeZPs7M2ck6BwpUgnkDTxSovBEwcbN4V5+zgRpbmI1
	xkqgzyNDHkVKmi6v/99uS5y/ZXdfmyKRYub3hvoSwn13atssNqStrpIRg==
X-ME-Sender: <xms:Jn1vZSHT6eXSLEyCXh2WX4AZ88x4zUFEySRTcLoK-1TFyLyG4qhlcQ>
    <xme:Jn1vZTWnoIAz-xE_X6_qID1BANwJpe8RU-vuWQQwii3FnNRSD_d9fxg0a_fb-B6s7
    cvBnDOWDpjk3pFsrPM>
X-ME-Received: <xmr:Jn1vZcIn3SyAqDp8I04YdrtuEkJp8kyyXs1XdemnQUN85FgT-35yVAsy1Ln2bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvd
    evieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Jn1vZcGlnfN29eEmErKlSQ4eVGD1YhuuL8uuBryY06McTgrOed51Ew>
    <xmx:Jn1vZYW9OsWT-4H5d-VjIL4nx5QvgHz3WQNwJGG2k1NZSp2Gug1XBg>
    <xmx:Jn1vZfPLyk09Ia2KCV6RwT2cpoESGiiWwd6y95wyXc4tWC-h6VOvkw>
    <xmx:Jn1vZTdIgUAo-ub6mwUQbQU2ywP_WsfFi0pjGOFVf4EefA-2swaIQg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 14:42:29 -0500 (EST)
Date: Tue, 5 Dec 2023 11:42:25 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: free qgroup rsv on ioerr ordered_extent
Message-ID: <ZW99IahvTeLvQ0yv@devvm9258.prn0.facebook.com>
References: <cover.1701464169.git.boris@bur.io>
 <301bc827ef330a961a95791e6c4d3dbe3e2a6108.1701464169.git.boris@bur.io>
 <a72c5e7a-13ab-4f2f-8371-7ef4e2e2646e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72c5e7a-13ab-4f2f-8371-7ef4e2e2646e@gmx.com>

On Tue, Dec 05, 2023 at 07:34:10AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/12/2 07:30, Boris Burkov wrote:
> > An ordered extent completing is a critical moment in qgroup rsv
> > handling, as the ownership of the reservation is handed off from the
> > ordered extent to the delayed ref. In the happy path we release (unlock)
> > but do not free (decrement counter) the reservation, and the delayed ref
> > drives the free. However, on an error, we don't create a delayed ref,
> > since there is no ref to add. Therefore, free on the error path.
> 
> And I believe this would cause btrfs to be noisy at the unmount time,
> due to unreleased qgroup rsv.
> 
> Have you hit any one during your tests? If so, mind to add some dmesg
> output for it?
> 
> Or if no hit so far, would it be possible to add a new test case for it?

I hit the conditions for all of these fixes running xfstests with
MKFS_OPTIONS including -O squota or -O quota. IIRC the failures were
almost all in the umount path in btrfs_check_quota_leak, though some of
the issues manifested as reservation freeing underflows in
qgroup_rsv_release. generic/475 triggered most of the bugs but a handful
of other tests hit some others. Unfortunately, I did not take perfect
notes on which test was fixed by which patch. I can try to recover that
information by removing the patches and running the full suite while
iteratively adding them back in. That is obviously fairly time consuming,
so I would only do it if people really want that information in the commit
messages or something.

Thanks for the review!
Boris

> 
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> 
> > ---
> >   fs/btrfs/ordered-data.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index 574e8a55e24a..8d4ab5ecfa5d 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -599,7 +599,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
> >   			release = entry->disk_num_bytes;
> >   		else
> >   			release = entry->num_bytes;
> > -		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
> > +		btrfs_delalloc_release_metadata(btrfs_inode, release,
> > +						test_bit(BTRFS_ORDERED_IOERR, &entry->flags));
> >   	}
> > 
> >   	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,

