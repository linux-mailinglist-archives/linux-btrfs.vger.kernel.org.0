Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B454525370
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 May 2022 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356760AbiELRUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 May 2022 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356972AbiELRUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 May 2022 13:20:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6113D1E
        for <linux-btrfs@vger.kernel.org>; Thu, 12 May 2022 10:20:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A014D21B4C;
        Thu, 12 May 2022 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652376045;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rx1v3luk2lpwgawsxEeKozeb8bwAW0/IhD1mAnVDYug=;
        b=yGu2odCwfPoFQk7nvWP5BnqwERrPcc7SJi+FOApbrJNnDaECS55/3iFsFoUdJmGVPvekmY
        bcKTVhCpdKvyl8Xn5tEPpGE5fFKz0IO9uhRlVcrgSNhxnx9y9lZwe/iKYSRjExHTvb2RCc
        X+bzI3tOPtKv4V4/VYq4ATaWl927ztE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652376045;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rx1v3luk2lpwgawsxEeKozeb8bwAW0/IhD1mAnVDYug=;
        b=VTM9yI2emUBjMsSAlacssPiUzv2/XL0XxrST/JZv+1iB33uwgNjphhmFcVDhLIZhpPoIpU
        OYOrrpkl7Q98vnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 743EC13ABE;
        Thu, 12 May 2022 17:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e1ByG+1BfWLSIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 May 2022 17:20:45 +0000
Date:   Thu, 12 May 2022 19:16:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <20220512171629.GT18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
 <YnKIM/KBIJEqU/6b@infradead.org>
 <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
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

On Thu, May 05, 2022 at 06:40:31AM +0800, Qu Wenruo wrote:
> On 2022/5/4 22:05, Christoph Hellwig wrote:
> > On Wed, May 04, 2022 at 09:12:50AM +0800, Qu Wenruo wrote:
> >>> This is a really bad idea.  Now every read needs to pay the quite
> >>> large price for corner case of a read repair.  As I mentioned last time
> >>> I think a mempool with a few entries that any read repair can dip into
> >>> is a much better choice here.
> >>
> >> The problem is, can mempool provide a variable length entry?
> >
> > It can't.  But you can allocate a few different bucket sizes as a
> > starter or do a multi-level setup where you don't have a bitmap that
> > operates on the entire bio.
> 
> That sounds way more complex than either the original method (just fail
> to repair) or the current pre-allocation method.
> 
> We need to cover a pretty wide length variable, from the minimal 4K
> (only need one bit), to much larger ones (observed bio over 16M, but
> only for write).
> 
> It would make sense if we have a hard limit on how large a read bio can
> be (I have only observed 4M as the biggest bio size for read, and if
> limited to 4M, we only need 128bytes for the bitmap and can go mempool).
> 
> 
> In fact, the original one (just error out if failed to allocate memory)
> is way more robust than you think.
> 
> The point here is, if a large read bio failed, VFS will retry with much
> smaller block size (normally just one page or one block), and if we even
> failed to allocate memory for an u32, we're really screwed up.
> 
> Do we really need to go down the rabbit hole of using mempool for
> variable length situation? Especially we're not that eager to ensure the
> memory allocation.

I'm reluctant to use mempools in filesystem on any other layer than for
bios and better just wrapped under the biosets. Anywhere else it creates
potential for high-level deadlocks between various threads. In this
particular case of repair it does not seem that risky, as the only user
of the mempool is the repair submission and does only that, ie. no
interaction with other threads.

I think mempool in this case is a hammer too big, we could have a
per-device preallocated chunk of memory for repair purposes and manage
that by a lock and/or wait queue. There would be only a linear
dependency: request (use) -> io -> wait -> endio (return. If the repair
resource is not available any other request waits. Effectively what
mempools do but much simpler.
