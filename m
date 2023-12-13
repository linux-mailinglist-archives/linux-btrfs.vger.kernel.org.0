Return-Path: <linux-btrfs+bounces-907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44892810D2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 10:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CE01C20AE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383920324;
	Wed, 13 Dec 2023 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lRHjh1f/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ABEFE;
	Wed, 13 Dec 2023 01:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rUfGZho7K3qVy9Gsxf7KYBLzMAnHb4FXaY/ImZeL51o=; b=lRHjh1f/v8TJ3gPOlHvQgTclLv
	qygO+TeqmKCyUkmIBQqo6kkTe1wCYqrgzmKOrITbYUslPzl1oIN1HYglmwMJ4BllaFEV5HCkzk8Jj
	TCJGv0hEd/E5pFRXy/WYcdAb92VhykYcrJWJFHLwISVDYvKgJD+j+TAXTWvdm2hxVC1C04frjVFJ2
	f/OOTBNue/0vBrImSJc4PchByRgPNQEmbshErUzEUreC0Vgkc/w2aQut8ItRzWy6R+PdKJbGSRQYF
	rjgt0fA4Rj1Xg7Q50y+0YF9tpws9MFJJgAmsgQggT7g8q4V8yZ6SkHzZ1vVYsXIZAngB7+8beVXTY
	UOc/tG4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDLMe-00E7rL-1b;
	Wed, 13 Dec 2023 09:17:12 +0000
Date: Wed, 13 Dec 2023 01:17:12 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Message-ID: <ZXl2mL90/2WtZgL4@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
 <ZXlyPqtXO+j90vJb@infradead.org>
 <f1cc59fa-9260-4a42-b346-17862d0f8385@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cc59fa-9260-4a42-b346-17862d0f8385@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 13, 2023 at 09:09:47AM +0000, Johannes Thumshirn wrote:
> > I think raid stripe tree handling also really should move out of
> > set_io_stripe.  Below is the latest I have, although it probably won't
> > apply to your tree:
> > 
> 
> That would work as well and replace patch 1 then. Let me think about it.

I actually really like splitting that check into a helper for
documentation purposes.  Btw, this my full tree that the patch is from
in case it is useful:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/raid-stripe-tree-cleanups

