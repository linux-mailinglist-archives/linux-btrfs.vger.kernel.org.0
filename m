Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B9559A5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiFXNbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 09:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiFXNbu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 09:31:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0838BFA;
        Fri, 24 Jun 2022 06:31:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 843F71F8EF;
        Fri, 24 Jun 2022 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656077500;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgjcjsWwgFCT51qzN2+gjNYaVNpGbaTRZxVXLNJmXbg=;
        b=VvgWBKdl1CvOhvyADG1uOBOtFL4EJM2iTP2RJqENtsxjEYxFI99ueud6cmoj+xODh0wwcW
        kMqP/2+9iWPT6AEnQqfytCLGO+D2y6T+8o8FSO3uf4PV21cMv2Cyo8bgWLj0jJBKaV558o
        OODUa0Kvif5Pec8YeSKL8+/Flq4R9Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656077500;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgjcjsWwgFCT51qzN2+gjNYaVNpGbaTRZxVXLNJmXbg=;
        b=rbv9OWQH8nhn7uiUClbt61DsOVh1zVoZ2ZxvEt5asVQO0+SUARI8H8X4igIt64k89EDwJw
        uzXtiGYjZlESk3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F69B13480;
        Fri, 24 Jun 2022 13:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WYCFDry8tWJVBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 24 Jun 2022 13:31:40 +0000
Date:   Fri, 24 Jun 2022 15:27:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220624132701.GT20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20220624122334.80603-1-hch@lst.de>
 <20220624124913.GS20633@twin.jikos.cz>
 <b058e226-8a77-42bc-8c92-5bd23244e7da@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b058e226-8a77-42bc-8c92-5bd23244e7da@gmx.com>
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

On Fri, Jun 24, 2022 at 09:12:44PM +0800, Qu Wenruo wrote:
> On 2022/6/24 20:49, David Sterba wrote:
> > On Fri, Jun 24, 2022 at 02:23:34PM +0200, Christoph Hellwig wrote:
> >> Since the page_mkwrite address space operation was added, starting with
> >> commit 9637a5efd4fb ("[PATCH] add page_mkwrite() vm_operations method")
> >> in 2006, the kernel does not just dirty random pages without telling
> >> the file system.
> >
> > It does and there's a history behind the fixup worker. tl;dr it can't be
> > removed, though every now and then somebody comes and tries to.
> >
> > On s390 the page status is tracked in two places, hw and in memory and
> > this needs to be synchronized manually.
> >
> > On x86_64 it's not a simple reason but it happens as well in some edge
> > case where the mappings get removed and dirty page is set deep in the
> > arch mm code.  We've been chasing it long time ago, I don't recall exact
> > details and it's been a painful experience.
> >
> > If there's been any change on the s390 side or in arch/x86/mm code I
> > don't know but to be on the safe side, I strongly assume the fixup code
> > is needed unless proven otherwise.
> 
> I'd say, if this can be a problem to btrfs, then all fs supporting COW
> should also be affected, and should have similar workaround.

Probably yes.

> Furthermore, this means we can get a page dirtied without us knowing.

This should not happen because we do have the detection of the page and
extent state mismatch and the fixup worker makes things right again.

> This is a super big surprise to any fs, and should be properly
> documented, not just leaving some seemly dead and special code in some
> random fs.

You seem to be a non-believer that the bug is real and calling the code
dead. Each filesystem should validate the implementation agains the
platform where it is and btrfs once found the hard way that there are
some corner cases where structures get out of sync.

> Furthermore, I'm not sure even if handling this in a fs level is correct.
> This looks like more a MM problem to me then.
> 
> 
> I totally understand it's a pain to debug such lowlevel bug, but
> shouldn't we have a proper regression for it then?

The regression test is generic/208 and it was not reliable at all, it
fired randomly once a week or month, there used to be a BUG() in the
fixup worker callback.

> Instead of just keeping what we know works, I really want to handle this
> old case/bug in a more modern way.

As long as the guarantees stay the same, then fine. We need to be able
to detect the unexpected dirty bit and have a way to react to it.

f4b1363cae43 ("btrfs: do not do delalloc reservation under page lock")
25f3c5021985 ("Btrfs: keep pages dirty when using btrfs_writepage_fixup_worker")
1d53c9e67230 ("Btrfs: only associate the locked page with one async_chunk struct")

And the commit that fixed it:

87826df0ec36 ("btrfs: delalloc for page dirtied out-of-band in fixup worker")

You can find several reports in the mailing list archives (search term
btrfs_writepage_fixup_worker):

https://lore.kernel.org/linux-btrfs/1295053074.15265.6.camel@mercury.localdomain

https://lore.kernel.org/linux-btrfs/20110701174436.GA8352@yahoo.fr

https://lore.kernel.org/linux-btrfs/j0k65i$29a$1@dough.gmane.org

https://lore.kernel.org/linux-btrfs/CAO47_--H0+6bu4qQ2QA9gZcHvGVWO4QUGCAb3+9a5Kg3+23UiQ@mail.gmail.com

https://lore.kernel.org/linux-btrfs/vqfmv8-9ch.ln1@hurikhan.ath.cx
