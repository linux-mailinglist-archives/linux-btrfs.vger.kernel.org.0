Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A23391D1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhEZQfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 12:35:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234348AbhEZQft (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 12:35:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622046856;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trD9dMjYsZxD3peh/1VCuVlOAzAGw5JsL+Zi97Y8FIQ=;
        b=KyOMFNsbgM5D5WxZ6XL7JmZOrxAvCv7vpUL85yT3s6ZyoJkpMkd22R73yOi/f/uwMpD2ai
        JDOz7HXhgGL7yCnPyIgNk9VQ/WS0E6SDuOzrhsWKGJpC6zwCqnRTginVdRsf+RD9ZWjq4U
        Ms/fkUK9LZ6W9SH8PbP1H4lmjrfwFng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622046856;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trD9dMjYsZxD3peh/1VCuVlOAzAGw5JsL+Zi97Y8FIQ=;
        b=j5QxIyTS0vLDOh+ib7s0e+dfk4qv8xTXMCISArc8NZEMJaYNtna0YzhWB0ciLuhPWZDkzs
        EdECWoWRa8rMfBCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 823E7AE92;
        Wed, 26 May 2021 16:34:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 742D6DA70B; Wed, 26 May 2021 18:31:39 +0200 (CEST)
Date:   Wed, 26 May 2021 18:31:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/9] btrfs: simplify eb checksum verification in
 btrfs_validate_metadata_buffer
Message-ID: <20210526163139.GG7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <6828072ccda5d55b9d130f48b750455ea728781b.1621961965.git.dsterba@suse.com>
 <0b51e0c9-896a-4ee2-f965-eec7b57cbd39@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b51e0c9-896a-4ee2-f965-eec7b57cbd39@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 26, 2021 at 08:05:51AM +0800, Qu Wenruo wrote:
> On 2021/5/26 上午1:08, David Sterba wrote:
> > The verification copies the calculated checksum bytes to a temporary
> > buffer but this is not necessary. We can map the eb header on the first
> > page and use the checksum bytes directly.
> >
> > This saves at least one function call and boundary checks so it could
> > lead to a minor performance improvement.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> The idea is good, and should be pretty simple to test.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> But still a nitpick inlined below.
> > ---
> >   fs/btrfs/disk-io.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 6dc137684899..868e358f6923 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -584,6 +584,7 @@ static int validate_extent_buffer(struct extent_buffer *eb)
> >   	const u32 csum_size = fs_info->csum_size;
> >   	u8 found_level;
> >   	u8 result[BTRFS_CSUM_SIZE];
> > +	const struct btrfs_header *header;
> >   	int ret = 0;
> >
> >   	found_start = btrfs_header_bytenr(eb);
> > @@ -608,15 +609,14 @@ static int validate_extent_buffer(struct extent_buffer *eb)
> >   	}
> >
> >   	csum_tree_block(eb, result);
> > +	header = page_address(eb->pages[0]) +
> > +		 get_eb_offset_in_page(eb, offsetof(struct btrfs_leaf, header));
> 
> It takes me near a minute to figure why it's not just
> "get_eb_offset_in_page(eb, 0)".
> 
> I'm not sure if we really need that explicit way to just get 0,
> especially most of us (and even some advanced users) know that csum
> comes at the very beginning of a tree block.
> 
> And the mention of btrfs_leave can sometimes be confusing, especially
> when we could have tree nodes passed in.

Ah right, I wanted to use the offsetof for clarity but that it could be
used with nodes makes it confusing again. What if it's replaced by

	get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));

This makes it clear that it's the checksum and from the experience we
know it's at offset 0. I'd rather avoid magic constants and offsets but
you're right that everybody knows that the checksum is at the beginning
of btree block.
