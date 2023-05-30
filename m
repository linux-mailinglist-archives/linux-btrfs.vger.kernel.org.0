Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CB7160DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjE3NAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjE3M77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 08:59:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1E9D
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 05:59:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C47AC1F8B9;
        Tue, 30 May 2023 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685451275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Lq6go64eJNUWQSbdOtF+EJ+SgLoDE5KkjAEOQgpNMU=;
        b=eRNHuyO0PO0skR2/waJjWRVi0AzlEdA4KziFCTGTxC/oA0e4XlyAEp0WlbDpQRxfDFoQe6
        VKy+b5a3+XioTGwAIn4A7Q1MVarghDgQ3XEC4HMnClEh5cJOiddGPabenolw0Sy6gGbptd
        0DMSqlzFEFHUJJzy+/ASCmgsY+/A3mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685451275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Lq6go64eJNUWQSbdOtF+EJ+SgLoDE5KkjAEOQgpNMU=;
        b=ui9LwoFof9H5jH+iV4R9jzy/shZiiRHkNnR5YXC54OLPMKhCbzRPo3CLN7y14bN1qgrQ2d
        56gSj9vu/B02mrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0C5113478;
        Tue, 30 May 2023 12:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p4CIJgvydWQoLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 12:54:35 +0000
Date:   Tue, 30 May 2023 14:48:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: small cleanups mostly for subpage cases
Message-ID: <20230530124824.GO575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1685411033.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685411033.git.wqu@suse.com>
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

On Tue, May 30, 2023 at 09:45:26AM +0800, Qu Wenruo wrote:
> Changelog:
> v2:
> - Fix an offset-by-one bug in the 3rd patch
>   Unlock extent range end is inclusive.
> 
> During my hunt on the subpage uptodate desync bugs reported from Matt, I
> exposed several PageUptodate usage which results inefficiency for
> subpage cases.
> 
> Those two are fixed in the first two patches.
> 
> Furthermore I found processed_extent infrastructure is no longer needed
> especially after all the csum verification is moved to storage layer (or
> bio.c inside btrfs), we can easily unlock the full range without the
> need for the infrastructure.
> 
> Thus the last patch would delete the processed_extent infrastructure
> completely.
> 
> Qu Wenruo (3):
>   btrfs: make alloc_extent_buffer() handle previously uptodate range
>     more efficient for subpage
>   btrfs: use the same @uptodate variable for end_bio_extent_readpage()

1 and 2 added to devel.

>   btrfs: remove processed_extent infrastructure

As Christoph pointed out this needs some investigation.
