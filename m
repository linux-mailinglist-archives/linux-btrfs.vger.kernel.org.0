Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549EF578594
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiGROgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiGROgC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 10:36:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC01183F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 07:36:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF21333D80;
        Mon, 18 Jul 2022 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658154959;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7FgH3cgcemaGTkb9x5Z/Edf32Ps/1mXxeuMGXLhCyY=;
        b=Ee/7/XuY0XL+rGk8VpRv4BGeAq+ts9eJbKL1+MF3E/aPWgGlK5Wll9YWEhx5Gk/CC7wJqA
        y7iALPiKlb+fUMVTpcD8IQWNQ6WLiO+arUw1pI4oECHt3NgJh7Lqy8wk2crce0MsIa/p7a
        cvX9Baub1xPN9LdtIEz/5hPG0J23zWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658154959;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7FgH3cgcemaGTkb9x5Z/Edf32Ps/1mXxeuMGXLhCyY=;
        b=GGykbVNGMsf92OstA9v0hIFtXZcE7php75oRNqQdAtlHSmAbhIvsYXNfXrTT2Zt+Uo0isq
        XnEuyBUN0GwcbSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C0FA13A37;
        Mon, 18 Jul 2022 14:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OVgEJc9v1WJiRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 14:35:59 +0000
Date:   Mon, 18 Jul 2022 16:31:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: align max_zone_append_size to the sector size
Message-ID: <20220718143106.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
References: <20220714091609.2892621-1-hch@lst.de>
 <20220714125247.GJ15169@twin.jikos.cz>
 <20220718081127.GA29070@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718081127.GA29070@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 10:11:27AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 14, 2022 at 02:52:47PM +0200, David Sterba wrote:
> > > Fixes: 385ea2aea011 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Folded to the patch, thanks.
> 
> Turns out this is still broken as I was misled by the fancy ALIGN
> macro.  We need the incremental change below.  Do you want to fold
> this in again or should I sent it as a separate patch:

Folding small fixups is easier for me, no need to resend, thanks.
