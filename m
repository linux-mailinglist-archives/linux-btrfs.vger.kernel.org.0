Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D50712766
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 15:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbjEZNWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjEZNWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 09:22:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26EB2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 06:21:59 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E3701FD83;
        Fri, 26 May 2023 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685107318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dAbr6hvxAQOJ1b7HhKLB/x8JkF93CsGxpPtDEQptpeo=;
        b=xpr/+XZe84d/Gmj3oyb8hSPQezoFOSLDBE/DlbZNVmq9PrFDTbuDxwcWC+NCLe1ItSV2s+
        l0wQhECvZbEVHy9EbibnQibBhNHd5DVriZ+hS4XDTBgnh3aKwjJqY1SEepvAbY0r1ClauR
        3S50ebDxcad/hsNMrwrKrxauAJ/LmzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685107318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dAbr6hvxAQOJ1b7HhKLB/x8JkF93CsGxpPtDEQptpeo=;
        b=KPxFI+hUB7pT4lR3JT+EvKoPj+4UbqkDGQHL+ykSAIs0A0c+jXXIoR1qQZ+LzBM8IkwXh4
        2y2n0KYVlkkytMAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4CA7213684;
        Fri, 26 May 2023 13:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id BrQnEXaycGSyZgAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 13:21:58 +0000
Date:   Fri, 26 May 2023 15:15:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 13/21] btrfs: don't use btrfs_bio_ctrl for extent buffer
 writing
Message-ID: <20230526131549.GB14830@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-14-hch@lst.de>
 <20230523184541.GZ32559@twin.jikos.cz>
 <20230524055003.GB19255@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524055003.GB19255@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 07:50:03AM +0200, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 08:45:41PM +0200, David Sterba wrote:
> > On Wed, May 03, 2023 at 05:24:33PM +0200, Christoph Hellwig wrote:
> > > The btrfs_bio_ctrl machinery is overkill for writing extent_buffers
> > > as we always operate on PAGE SIZE chunks (or one smaller one for the
> > > subpage case) that are contigous and are guaranteed to fit into a
> > > single bio.  Replace it with open coded btrfs_bio_alloc, __bio_add_page
> > > and btrfs_submit_bio calls.
> > 
> > submit_extent_page hasn't been open coded completely, there's still call
> > to wbc_account_cgroup_owner() but it's probably skipped for other
> > reasons as this is metadata inode.
> 
> Hmm, I was under the impression that we never did cgroup accounting for
> metadata.  While that is true for the rest of the kernel, I fear I might
> have changed semantics for btrfs here (for better or worse).  Let me
> dig into the code again, but I suspect I'll need to add
> wbc_account_cgroup_owner and wbc_init_bio back to not change semantics
> vs the old code.

Until we know for sure I'd rather keep the call, so something like that
(untested):

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fcd0563f7a15..a6480fa0366c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1833,6 +1833,8 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
                        wbc->nr_to_write--;
                }
                __bio_add_page(&bbio->bio, p, eb->len, eb->start - page_offset(p));
+               if (bio_ctrl->wbc)
+                       wbc_account_cgroup_owner(bio_ctrl->wbc, p, len);
                unlock_page(p);
        } else {
                for (int i = 0; i < num_extent_pages(eb); i++) {
@@ -1842,6 +1844,8 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
                        clear_page_dirty_for_io(p);
                        set_page_writeback(p);
                        __bio_add_page(&bbio->bio, p, PAGE_SIZE, 0);
+                       if (bio_ctrl->wbc)
+                               wbc_account_cgroup_owner(bio_ctrl->wbc, p, len);
                        wbc->nr_to_write--;
                        unlock_page(p);
                }
@@ -4090,9 +4094,15 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
        if (eb->fs_info->nodesize < PAGE_SIZE) {
                __bio_add_page(&bbio->bio, eb->pages[0], eb->len,
                               eb->start - page_offset(eb->pages[0]));
+               if (bio_ctrl->wbc)
+                       wbc_account_cgroup_owner(bio_ctrl->wbc, eb->pages[0], len);
        } else {
-               for (i = 0; i < num_pages; i++)
+               for (i = 0; i < num_pages; i++) {
                        __bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
+                       if (bio_ctrl->wbc)
+                               wbc_account_cgroup_owner(bio_ctrl->wbc,
+                                                        eb->pages[i], len);
+               }
        }
        btrfs_submit_bio(bbio, mirror_num);
 
---

I can fold it to the patches.
