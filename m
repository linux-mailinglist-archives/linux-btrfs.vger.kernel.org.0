Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34060F961
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiJ0Nke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiJ0Nkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 09:40:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F757E06
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 06:40:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E46DA21BB5;
        Thu, 27 Oct 2022 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666878026;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ro7fA1vrhZ6oVNcnUOVthKbTl5JWIW4eeZaGtK28d2s=;
        b=oqfhcPQyN+9rRq5jgaSZ3R1zaGRzsds4pkJCqQ2VrNgG1F5WDK5GqrjhGigukcMYx6S9/W
        753lCy1YrhWIWah8X50NHkXZmhmBbUOvR8i9dZnCiIx3pmrwJHv/owsuBu00Anda6KXQOI
        BvjZK8Q0vzWwTByaV9Q7Cb7i5H4MHgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666878026;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ro7fA1vrhZ6oVNcnUOVthKbTl5JWIW4eeZaGtK28d2s=;
        b=Z7jdQ+WQlAdPGunSfTev9lPYVRn3dvzuQxOkkSZ26HWXWN+OKa4dphE0H+ult3zTbrFeN0
        16ImxAW/TZA5RjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B04BB13357;
        Thu, 27 Oct 2022 13:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hoLJKUqKWmPhcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Oct 2022 13:40:26 +0000
Date:   Thu, 27 Oct 2022 15:40:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 02/26] btrfs: move btrfs_chunk_item_size out of ctree.h
Message-ID: <20221027134011.GU5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666811038.git.josef@toxicpanda.com>
 <e1ec74ccbcedc5c9dc9cb8d82b3ffba387075afa.1666811038.git.josef@toxicpanda.com>
 <70564ebd-96ed-c8d1-d1d7-e133a7a60dc0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70564ebd-96ed-c8d1-d1d7-e133a7a60dc0@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 27, 2022 at 06:43:42AM +0000, Johannes Thumshirn wrote:
> On 26.10.22 21:11, Josef Bacik wrote:
> > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > index d7f72b0a227c..cab1ba8f6252 100644
> > --- a/fs/btrfs/volumes.h
> > +++ b/fs/btrfs/volumes.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/btrfs.h>
> >  #include "async-thread.h"
> > +#include "messages.h"
> >  
> >  #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
> >  
> > @@ -605,6 +606,13 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
> >  	}
> >  }
> >  
> > +static inline unsigned long btrfs_chunk_item_size(int num_stripes)
> > +{
> > +	ASSERT(num_stripes);
> > +	return sizeof(struct btrfs_chunk) +
> > +		sizeof(struct btrfs_stripe) * (num_stripes - 1);
> > +}
> > +
> >  void btrfs_get_bioc(struct btrfs_io_context *bioc);
> >  void btrfs_put_bioc(struct btrfs_io_context *bioc);
> >  int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> > @@ -759,5 +767,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
> >  bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
> >  
> >  bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
> > +unsigned long btrfs_chunk_item_size(int num_stripes);
> 
> Maybe I don't have enough coffee yet, but that change I don't get. Why are you
> creating both a 'static inline unsigned long btrfs_chunk_item_size()' and
> 'unsigned long btrfs_chunk_item_size()' in volumes.h?

That's maybe just a typo, the non-static can be removed if there's the
static inline.
