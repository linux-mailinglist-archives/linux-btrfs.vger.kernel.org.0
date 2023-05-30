Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E2D71624B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjE3NlE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 09:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjE3NlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 09:41:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B87102
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 06:40:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E649D21A3D;
        Tue, 30 May 2023 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685454057;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+W1FxOLEOlkgtS4AADbLSxQOSBFLdK+zlfu8nmh3Dg=;
        b=VS5jzqUcngmsgR4VaCvG5zMFFlQ3cCzu4pWtMEXnGPIZV0xSitijGQYH+1p04QxC9txn5h
        Je3w6KpzVduQN5vpVBsqoAxYtXEhu4kcGgkvguGC3G0QilNL5vHhC8UnVYSq8Hp9io3s8k
        LjL6TSWIXMOWhk607+10spBjIG1nMw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685454057;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+W1FxOLEOlkgtS4AADbLSxQOSBFLdK+zlfu8nmh3Dg=;
        b=UgOrFUMD7U+PP7EM5NuZZI6llTZt+i9nBmrMhOTYmi+NsGSP8xdNdRhd49rvoVic2xeKtR
        Hee9Tjv9XN9N1wAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BDE813597;
        Tue, 30 May 2023 13:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6PNAIen8dWS+SAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 13:40:57 +0000
Date:   Tue, 30 May 2023 15:34:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 08/16] btrfs: stop setting PageError in the data I/O path
Message-ID: <20230530133446.GR575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-9-hch@lst.de>
 <20230529175210.GL575@twin.jikos.cz>
 <20230530054547.GA5825@lst.de>
 <ZHWS5nOm++6zCNkE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHWS5nOm++6zCNkE@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 07:08:38AM +0100, Matthew Wilcox wrote:
> On Tue, May 30, 2023 at 07:45:47AM +0200, Christoph Hellwig wrote:
> > On Mon, May 29, 2023 at 07:52:10PM +0200, David Sterba wrote:
> > > On Tue, May 23, 2023 at 10:13:14AM +0200, Christoph Hellwig wrote:
> > > > PageError is not used by the VFS/MM and deprecated.
> > > 
> > > Is there some reference other than code? I remember LSF/MM talks about
> > > writeback, reducing page flags but I can't find anything that would say
> > > that PageError is not used anymore. For such core changes in the
> > > neighboring subysystems I kind of rely on lwn.net, hearsay or accidental
> > > notice on fsdevel.
> > > 
> > > Removing the Error bit handling looks overall good but I'd also need to
> > > refresh my understanding of the interactions with writeback.
> > 
> > willy is the driving force behind the PageErro removal, so maybe he
> > has a coherent writeup.  But the basic idea is:
> > 
> >  - page flag space availability is limited, and killing any one we can
> >    easily is a good thing
> >  - PageError is not well defined and not part of any VM or VFS contract,
> >    so in addition to freeing up space it also generally tends to remove
> >    confusion.
> 
> I don't think I have a coherent writeup.  Basically:
> 
>  - The VFS and VM do not check the error flag
> 
>    $ git grep folio_test_error
>    fs/gfs2/lops.c: if (folio_test_error(folio))
>    mm/migrate.c:   if (folio_test_error(folio))
> 
>    (the use in mm/migrate.c replicates the error flag on migration)
> 
>    A similar grep -w PageError finds only tests in filesystems and
>    comments.
> 
>  - We do not document clearly under what circumstances the error flag
>    is set or cleared
> 
> If we can remove all uses of testing the error flag, then we can remove
> everywhere that sets or clears the flag.  This is usually a simple
> matter of checking folio_test_uptodate() instead of !PageError(),
> since the folio will not be marked uptodate if there is a read error.
> Write errors are not normally tracked on a per-folio basis.  Instead they
> are tracked through mapping_set_error().
> 
> I did a number of these conversions about a year ago; I'm happy Christoph
> is making progress with btrfs here.  See 'git log 6e8e79fc8443' for many
> of them.

Thank you, that helped.

I found one case of folio_set_error() that seems to be redundant:

   189  static noinline void end_compressed_writeback(const struct compressed_bio *cb)
   190  {
   191          struct inode *inode = &cb->bbio.inode->vfs_inode;
   192          struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
   193          unsigned long index = cb->start >> PAGE_SHIFT;
   194          unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
   195          struct folio_batch fbatch;
   196          const int errno = blk_status_to_errno(cb->bbio.bio.bi_status);
   197          int i;
   198          int ret;
   199  
   200          if (errno)
   201                  mapping_set_error(inode->i_mapping, errno);
   202  
   203          folio_batch_init(&fbatch);
   204          while (index <= end_index) {
   205                  ret = filemap_get_folios(inode->i_mapping, &index, end_index,
   206                                  &fbatch);
   207  
   208                  if (ret == 0)
   209                          return;
   210  
   211                  for (i = 0; i < ret; i++) {
   212                          struct folio *folio = fbatch.folios[i];
   213  
   214                          if (errno)
   215                                  folio_set_error(folio);
                                        ^^^^^^^^^^^^^^^^^^^^^^^

The error is set on the mapping on line 201 under the same condition.

With that removed and the super block write error handling moved away
from the Error bit the btrfs code will be Error-clean.

   216                          btrfs_page_clamp_clear_writeback(fs_info, &folio->page,
   217                                                           cb->start, cb->len);
   218                  }
   219                  folio_batch_release(&fbatch);
   220          }
   221          /* the inode may be gone now */
   222  }
