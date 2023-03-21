Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C448F6C277F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 02:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCUBeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 21:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCUBeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 21:34:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E12365C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 18:34:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6326E1F8D9;
        Tue, 21 Mar 2023 01:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679362445;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0AzWrL6zm95SKOY25BAZAmoBXFzKkiGnVwKeA8Yh/qU=;
        b=xnIDaFdYKs5+nCwgdcnMhlvWOsPQlV8glQPwdnNTf22Ps06SVvms/3j60LznzP5A+I6/iq
        pbikwtN7cCsGE/rKXf/R/Ha3giF4kEmrTLA/1DmZt6wWkqy7eMsJTl0hDDlo4ZDcvzfnfe
        pD8LkuuxjoNBkTpFCouXJoZL+NwbGxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679362445;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0AzWrL6zm95SKOY25BAZAmoBXFzKkiGnVwKeA8Yh/qU=;
        b=CgPc0l/ozO5cQ4NnaOxROc9HbG7RyhpYRBtwhtciEFX8y9SgdcoH6oq33qWCzKkMDaOh7i
        /PTOmf8+nom+y0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CFD813416;
        Tue, 21 Mar 2023 01:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nB+tCY0JGWS3ZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 01:34:05 +0000
Date:   Tue, 21 Mar 2023 02:27:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 03/12] btrfs: introduce a new helper to submit write
 bio for scrub
Message-ID: <20230321012755.GO10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <c9482839875af328d7fe5ff6a9bebdc84c33c5ab.1679278088.git.wqu@suse.com>
 <20230321001445.GJ10580@twin.jikos.cz>
 <900424d7-0659-aabd-4456-277b60e808e8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900424d7-0659-aabd-4456-277b60e808e8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 08:54:22AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/3/21 08:14, David Sterba wrote:
> > On Mon, Mar 20, 2023 at 10:12:49AM +0800, Qu Wenruo wrote:
> >> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> >> index b96f40160b08..633447b6ba44 100644
> >> --- a/fs/btrfs/bio.c
> >> +++ b/fs/btrfs/bio.c
> >> +	/* Map the RAID56 multi-stripe writes to a single one. */
> >> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> >> +		int data_stripes = bioc->map_type & BTRFS_BLOCK_GROUP_RAID5 ?
> >> +				   bioc->num_stripes - 1 : bioc->num_stripes - 2;
> > 
> > When ternary operator is used in expression, please put ( ) around it so
> > it's clear where it starts.
> > 
> >> +		int i;
> >> +
> >> +		/* This special write only works for data stripes. */
> >> +		ASSERT(mirror_num == 1);
> >> +		for (i = 0; i < data_stripes; i++) {
> > 
> > 		for (int i = 0; ...)
> > 
> > We can now use the iterator value defined inside for (), it's relatively
> > new due to bumped minimum compiler version so I'd like to see it used
> > where possible.
> 
> Just one question.
> 
> There are quite some for loops in the last few patches.
> 
> In that case, should we still go the "for (int i = 0;...)" way?
> Or it's better to declare "i" as the old way?

For 'i' I'd use the for() declarations, even if it's for multiple loops.
