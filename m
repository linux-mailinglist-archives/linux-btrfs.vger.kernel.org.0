Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97BE53EF94
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiFFU3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 16:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiFFU2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 16:28:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC649688
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 13:27:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72C5D1F959;
        Mon,  6 Jun 2022 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654547272;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UdxTLVWg2WMhYW9uR8bj5bj/y7JrH2QhTts1T+XyR8=;
        b=bFAQzzZoTCyEV6ef+yJh9cMxf7gIhHzzsF6L7ZcJV8dZ2/zW0YxDn9t48BHM4fDB9Sux+4
        /BYhJkFKudIBOSaWWlbgeCJ5K+4fGnvSP6xHJ8TGmyfgcEoIG3pu32Z4EwrvC27GVlvscv
        ekLAm7SVFZL/tv1a+CH5KjEMd0GaTXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654547272;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UdxTLVWg2WMhYW9uR8bj5bj/y7JrH2QhTts1T+XyR8=;
        b=kIASxTZaWOev0d2jpI/a3tyYygEl5CR8Dn8wOCZl7jeGNHSVjW4hmA8oUFnItZ4EhrxhZN
        bUxhW05EvaAhO6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3192913A5F;
        Mon,  6 Jun 2022 20:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ad0uCkhjnmKQTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Jun 2022 20:27:52 +0000
Date:   Mon, 6 Jun 2022 22:23:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: pass the btrfs_bio_ctrl to submit_one_bio
Message-ID: <20220606202322.GE20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220603071103.43440-1-hch@lst.de>
 <20220603071103.43440-4-hch@lst.de>
 <0eb3ddf9-af5f-e67f-c8f8-17c80c731359@suse.com>
 <20220606162929.GA10835@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606162929.GA10835@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 06, 2022 at 06:29:29PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 06, 2022 at 01:41:50PM +0300, Nikolay Borisov wrote:
> >> +static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> >> +{
> >> +	if (bio_ctrl->bio)
> >> +		__submit_one_bio(bio_ctrl);
> >>   }
> >
> > Why do you need a function just to put an if in it, just move this atop 
> > __submit_one_bio :
> >
> > if (!bio_ctrl->bio)
> >     return
> >
> > and rename it to submit_one_bio.
> 
> Because just moving it to the top will lead to null pointer dereferences.
> I'd also have to move some initialization down.  Based on that the
> wrapper seems cleaner and safer to me.

I don't see much reason to have the safe and unsafe variants, it's all
for internal use in one file, also there's only one real instance where
__submit_one_bio can be used.  I'd expect a normal and __ variant for
some public API. Moving the initialization does not seem to be making
the code hard to read, so I'd apply this diff on top of your patch:

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -179,11 +179,18 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
        return ret;
 }
 
-static void __submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
+static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
-       struct bio *bio = bio_ctrl->bio;
-       struct inode *inode = bio_first_page_all(bio)->mapping->host;
-       int mirror_num = bio_ctrl->mirror_num;
+       struct bio *bio;
+       struct inode *inode;
+       int mirror_num;
+
+       if (!bio_ctrl->bio)
+               return;
+
+       bio = bio_ctrl->bio;
+       inode = bio_first_page_all(bio)->mapping->host;
+       mirror_num = bio_ctrl->mirror_num;
 
        /* Caller should ensure the bio has at least some range added */
        ASSERT(bio->bi_iter.bi_size);
@@ -200,12 +207,6 @@ static void __submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
        bio_ctrl->bio = NULL;
 }
 
-static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
-{
-       if (bio_ctrl->bio)
-               __submit_one_bio(bio_ctrl);
-}
-
 /*
  * Submit or fail the current bio in an extent_page_data structure.
  */
@@ -223,7 +224,7 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
                /* The bio is owned by the bi_end_io handler now */
                epd->bio_ctrl.bio = NULL;
        } else {
-               __submit_one_bio(&epd->bio_ctrl);
+               submit_one_bio(&epd->bio_ctrl);
        }
 }
---
