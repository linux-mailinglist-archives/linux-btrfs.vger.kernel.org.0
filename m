Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEA353ADFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 22:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiFAUpt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiFAUpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 16:45:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E52629FD
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 13:32:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 365D721A40;
        Wed,  1 Jun 2022 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654112036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/aJMjdK7Tsu5dIdfdU/yfvdQuSF9VDQd7P4stoQDBA=;
        b=DcD84l83vxH18kjyV2DLS5TM0ceqHTSGXc6lpYBibOLgYVfArElVC3G7zGfdryiFm7F+Lp
        REB/NS7KtQ2uiZ3ER7wJl7I4+Ge10vY1A2rxRUxwtKTlmNP6vWhCmBfL5pFmGYf4QNwfGF
        f0YcGnR6Hf2y/g6FWFOsq0+nqhrLWpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654112036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/aJMjdK7Tsu5dIdfdU/yfvdQuSF9VDQd7P4stoQDBA=;
        b=vRryYHcte/6R6CEJH8aJhQfGImKD5dErlKyzJHRBRlS4pIEgyjpqT1tSzhQm3InMZsJ5e4
        VHc7dtzgwLPOPSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 081F41330F;
        Wed,  1 Jun 2022 19:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tMBzACS/l2LeFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 19:33:55 +0000
Date:   Wed, 1 Jun 2022 21:29:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs bio handling, part 2 v4
Message-ID: <20220601192929.GQ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220526073642.1773373-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526073642.1773373-1-hch@lst.de>
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

On Thu, May 26, 2022 at 09:36:32AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the need to allocate a separate object for I/O
> completions for all read and some write I/Os, and reduced the memory
> usage of the low-level bios cloned by btrfs_map_bio by using plain bios
> instead of the much larger btrfs_bio.
> 
> Changes since v3:
>  - rebased to the latest for-next tree
>  - move "btrfs: don't double-defer bio completions for compressed reads"
>    back to where it was before in the patch order

This is a prerequisite for the raid-repair patches so I've added it to
for-next. There's a minor conflict in patch 4 after the recent changes
to raid56 from Qu, only in the context of the btrfs_bio_wq_end_io
removal and usage of differen work queue. There are also some style
comments I'll send as replies to the patches.
