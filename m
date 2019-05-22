Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1326014
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfEVJEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 05:04:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:43346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbfEVJEb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 05:04:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 812BCAE3F;
        Wed, 22 May 2019 09:04:30 +0000 (UTC)
Date:   Wed, 22 May 2019 11:04:29 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>
Subject: Re: [PATCH v3 11/13] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190522090429.GC3776@x250>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-12-jthumshirn@suse.de>
 <8452a97a-685d-7cb8-7145-3ad37e8aa385@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8452a97a-685d-7cb8-7145-3ad37e8aa385@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 11:33:39AM +0300, Nikolay Borisov wrote:
> > +	memset(csum, 0xff, btrfs_super_csum_size(sctx->fs_info->super_copy));

David can you fold this in?

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 65bd4999c7ad..d97039338952 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1810,7 +1810,6 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	page = sblock->pagev[0]->page;
 	buffer = kmap_atomic(page);
 
-	memset(csum, 0xff, btrfs_super_csum_size(sctx->fs_info->super_copy));
 	len = sctx->fs_info->sectorsize;
 	index = 0;
 	for (;;) {
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
