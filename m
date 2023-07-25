Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056757624C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjGYVtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjGYVtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 17:49:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B612126
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 14:49:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2717521EF8;
        Tue, 25 Jul 2023 21:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690321749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=it0i63JoLK8P6KFz6N6bttzduaNQapZWGt7onNHAmHc=;
        b=eGUVPgtBV6CzCZd7biqAau0WIz7AeMuW69rx07tl3nglCY7GD/fm9ALVrvHR4mB9v92JY5
        vSy9gPBA1LhJb0ebfulZcgThTXIxiFcPrxPTF6ljivZR1i7mHyzhdMeXVo+JvhnDUqQGNp
        lX+R/PhctbdL85Qc31wtK+RbqirgWgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690321749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=it0i63JoLK8P6KFz6N6bttzduaNQapZWGt7onNHAmHc=;
        b=vwCeJaTIbegWdWWqI9F7eH0vC2vMv4zdg9tOpyGYS+lIKYCS5S0Vq9rMyCYLJU3twUOcHW
        WW91y7SOxebndyAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E70A513342;
        Tue, 25 Jul 2023 21:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z/OaN1RDwGTqRAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Jul 2023 21:49:08 +0000
Date:   Tue, 25 Jul 2023 23:42:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs NOCOW fix and cleanups
Message-ID: <20230725214225.GJ20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724142243.5742-1-hch@lst.de>
 <20230724183033.GB587411@zen>
 <20230724194923.GC30159@lst.de>
 <20230724195824.GA30526@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724195824.GA30526@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 09:58:24PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 09:49:23PM +0200, Christoph Hellwig wrote:
> > Yeah, looks like for-next got rebased again today.  I'll rebase and
> > push it out to the git tree later today and can resend as needed.
> 
> Looks like for-next has in fact pulled this series in already.

Please note that for-next is a preview branch and for early testing. It
will be rebased regularly, patches may appear and disappear or get moved
to misc-next. Currently there are some problems in misc-next so I'm
bisecting and trying to find a stable base for development branches
again.
