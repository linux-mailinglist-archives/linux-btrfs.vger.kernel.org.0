Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B57652F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjG0L4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjG0L42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 07:56:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91858272C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 04:56:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F6DE1F383;
        Thu, 27 Jul 2023 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690458986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cli+A+8V46HLoZDlIMuqarkrYwg3PFau5GdGrWfWUHA=;
        b=bRBc0GjpbMnlW2m8qc80PROWL/Q1gwT42PvK61LAWQs0432cDNM7hcsD5XNXWUwi6BVYPx
        AaJZ0i/pUIZLiwlXj0eV8d8GVOVBCRRvLdVS2Ts8WK36+GjAR3Z5rOCCioWLSD+Z8rFpS5
        jTSmrp96C3vGdsV1Jse4jRwT+ybjGxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690458986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cli+A+8V46HLoZDlIMuqarkrYwg3PFau5GdGrWfWUHA=;
        b=bKVVigCGXr260l407D/xW5nj51wIPyXdNEuRlW7RegeE9NaAXZjM47xREKNKYclZq1ebvj
        6k4mdsL/dUbe1jCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14E05138E5;
        Thu, 27 Jul 2023 11:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0J1TBGpbwmTcOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 11:56:26 +0000
Date:   Thu, 27 Jul 2023 13:50:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs NOCOW fix and cleanups
Message-ID: <20230727115004.GA17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724142243.5742-1-hch@lst.de>
 <20230724183033.GB587411@zen>
 <20230724194923.GC30159@lst.de>
 <20230724195824.GA30526@lst.de>
 <20230725214225.GJ20457@twin.jikos.cz>
 <ZMEYDhStXhXLWxvh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEYDhStXhXLWxvh@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 26, 2023 at 05:56:46AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 25, 2023 at 11:42:25PM +0200, David Sterba wrote:
> > On Mon, Jul 24, 2023 at 09:58:24PM +0200, Christoph Hellwig wrote:
> > > On Mon, Jul 24, 2023 at 09:49:23PM +0200, Christoph Hellwig wrote:
> > > > Yeah, looks like for-next got rebased again today.  I'll rebase and
> > > > push it out to the git tree later today and can resend as needed.
> > > 
> > > Looks like for-next has in fact pulled this series in already.
> > 
> > Please note that for-next is a preview branch and for early testing.
> 
> I know (by now), just wanted to put out the explanation why Boris
> saw the reject.
> 
> If at some point there is a good time to tweak the btrfs process, it
> would be really nice to name the branch that ends up in linux-next
> for-next like in every other subsystem, and to not use two different
> git trees, which both are things that confused even me as a long time
> kernel contributor horribly.

You should not care about my kernel.org git tree for development, that's
just for linux-next and pull requests, at no point I refer people there
nor mention it. The repo github.com/kdave/btrfs-devel is for development
and contains misc-next as stable development base as well as the
for-next snapshots, the branch 'for-next'. I don't see anything
confusing.
