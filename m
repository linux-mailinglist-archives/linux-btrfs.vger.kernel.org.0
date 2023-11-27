Return-Path: <linux-btrfs+bounces-394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F807FA65C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817AA2819AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8FD36AE7;
	Mon, 27 Nov 2023 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Q+jn4EXE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09FCE
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:28:03 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cfa65de9ecso15832697b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701102483; x=1701707283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uc2wkNag+aQT/KLFQIGy27+XX/TfQs2Vy9hNG5R6ngg=;
        b=Q+jn4EXE5dSx8AwyfPIcPUNaECodbhS3TgLCL59VRf5BAvQ1PP1vollLyDs8ER7XyD
         fujMj0umgH0oe9SkTvSyAFGsy9kMSBpuNuDd184pYMJXJsH6KJmn15A9PHKgBr+ttkrN
         n3o4ug1hCf/jN1j4Y04n9WATmXY5rASYpSUo+j/TjYr/OnOuwkYxBKcSjc9y+pzueyQ7
         48Op4dNvygRM4BODgjxWxm2noI5KJnDBXiR8Y9cWlodXRgIQZ8Flr234eFeUi55gVcSc
         qAfSaVsrsc7TENdxQPusK8u+Gi+0CtGKKH1oSJTVAYFRPv7ujcCiSny43TrK69AK0wkm
         7E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102483; x=1701707283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc2wkNag+aQT/KLFQIGy27+XX/TfQs2Vy9hNG5R6ngg=;
        b=DgPpKzgUKWkxNVrO1QH7qxhYwfmcUCxvqx8abKMNFXRlgsEntjg4a/ge5Y+XiJuAzt
         8dUqKWAqZss7N/ttvfFa7RtuFLfN4jCK+62t/iuS1k/QVqZK1HMXejVol0DJXlAau0nw
         zy0f4UFNZxeeYDU3JuQ9SzVM9h4uBmWs9VFWUnnKDfG/4ROTzTKuEv9zV/U9mGMPkr/n
         autgErvB9ucHnhg2yg/Nmam85eo551R8i7SL8tfubucEvwgXLK3amNahKy7/mpP63DVv
         86I6JyvJaPmXdT55s8BLVyOwPVAXl9NfcTuzMNyJ65D+BuGrzOYukEPONnL99Bira4iA
         N1Zg==
X-Gm-Message-State: AOJu0Yw/KOYSHpN9gQ3BlKNqlE1elnjxgbqy2GQ13DJHVUxzQVAEpHUg
	bp81xQ2d/b58QRKnfMOcm7cOYQ==
X-Google-Smtp-Source: AGHT+IHybYCxfApKAE5Dhz+A1Zo5sxuXPCkdS3PcPxjsf8UuK4wvLfcofOHsuQzjTIQcL3u0zhTRBQ==
X-Received: by 2002:a81:a18f:0:b0:5d0:c305:e7b2 with SMTP id y137-20020a81a18f000000b005d0c305e7b2mr2022335ywg.52.1701102482930;
        Mon, 27 Nov 2023 08:28:02 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x126-20020a814a84000000b005ca7a00a9b0sm3348527ywa.64.2023.11.27.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:28:02 -0800 (PST)
Date: Mon, 27 Nov 2023 11:28:01 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
Message-ID: <20231127162801.GE2366036@perftesting>
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122141403.GD1733890@perftesting>
 <5e56826f-2463-42f3-8714-f4eb3e76dab7@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e56826f-2463-42f3-8714-f4eb3e76dab7@gmx.com>

On Thu, Nov 23, 2023 at 06:30:05AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/23 00:44, Josef Bacik wrote:
> > On Wed, Nov 22, 2023 at 10:05:04AM +1030, Qu Wenruo wrote:
> > > Currently alloc_extent_buffer() utilizes find_or_create_page() to
> > > allocate one page a time for an extent buffer.
> > > 
> > > This method has the following disadvantages:
> > > 
> > > - find_or_create_page() is the legacy way of allocating new pages
> > >    With the new folio infrastructure, find_or_create_page() is just
> > >    redirected to filemap_get_folio().
> > > 
> > > - Lacks the way to support higher order (order >= 1) folios
> > >    As we can not yet let filemap to give us a higher order folio (yet).
> > > 
> > > This patch would change the workflow by the following way:
> > > 
> > > 		Old		   |		new
> > > -----------------------------------+-------------------------------------
> > >                                     | ret = btrfs_alloc_page_array();
> > > for (i = 0; i < num_pages; i++) {  | for (i = 0; i < num_pages; i++) {
> > >      p = find_or_create_page();     |     ret = filemap_add_folio();
> > >      /* Attach page private */      |     /* Reuse page cache if needed */
> > >      /* Reused eb if needed */      |
> > > 				   |     /* Attach page private and
> > > 				   |        reuse eb if needed */
> > > 				   | }
> > > 
> > > By this we split the page allocation and private attaching into two
> > > parts, allowing future updates to each part more easily, and migrate to
> > > folio interfaces (especially for possible higher order folios).
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/btrfs/extent_io.c | 173 +++++++++++++++++++++++++++++++------------
> > >   1 file changed, 126 insertions(+), 47 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 99cc16aed9d7..0ea65f248c15 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -3084,6 +3084,14 @@ static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
> > >   static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
> > >   {
> > >   	struct btrfs_fs_info *fs_info = eb->fs_info;
> > > +	/*
> > > +	 * We can no longer using page->mapping reliably, as some extent buffer
> > > +	 * may not have any page mapped to btree_inode yet.
> > > +	 * Furthermore we have to handle dummy ebs during selftests, where
> > > +	 * btree_inode is not yet initialized.
> > > +	 */
> > > +	struct address_space *mapping = fs_info->btree_inode ?
> > > +					fs_info->btree_inode->i_mapping : NULL;
> > 
> > I don't understand this, this should only happen if we managed to get
> > PagePrivate set on the page, and in that case page->mapping is definitely
> > reliable.  We shouldn't be getting in here with a page that hasn't actually been
> > attached to the extent buffer, and if we are that needs to be fixed, we don't
> > need to be dealing with that case in this way.  Thanks,
> 
> The problem is, with the new way of allocating pages first, then attach
> them to filemap, we can have a case where the extent buffer has 4 pages,
> but only the first page is attached to filemap of btree inode.
> 
> In that case, we still want to lock the btree inode private, but
> page->mapping is still NULL for the remaining 3 pages.
> 

In this case I think we just change the error handling at the end, as we already
have to do something special anyways, so we now would do

for (int i = 0; i < attached; i++) {
	unlock_page(eb->pages[i]);
	detach_extent_buffer_page(eb->pages[i]);
}

for (int i = 0; i < num_pages; i++) {
	if (!eb->pages[i])
		break;
	put_page(eb->pages[i]);
}

and then we can leave detach_extent_buffer_page on its own.  Thanks,

Josef

