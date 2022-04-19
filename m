Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542A8507B16
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 22:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357642AbiDSUle (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 16:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiDSUld (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 16:41:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6DA40919
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 13:38:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7370B1F748;
        Tue, 19 Apr 2022 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650400728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1FAccQsYd2EXI7EiTQe5SVFrlKfYlqB2nn7+lg7hRc=;
        b=qwI5lvBeFOReMboEF0aO6h+XJTPpAmqNhdWaMEIRjmDPa9oelxZp0QSGxYz8hJ63bLAql3
        y04BF89xNC239UDbfxuf4WS6zibFOGtyJFPDOeyOjdMfJiC1Plj9whAvMRAhqauyDXdone
        G/EIcfTFVa/jiU9uBPMePM+QiGS4R+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650400728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1FAccQsYd2EXI7EiTQe5SVFrlKfYlqB2nn7+lg7hRc=;
        b=y3VLIIkcXs2SU2mnQXIpT1q1SibKbv98Y5xhYAUcSkQEOJ1j57gvaZZllEuOCDM+Q+oTNn
        e/oH1d7BdG2LpBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5000E132E7;
        Tue, 19 Apr 2022 20:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ig/EtgdX2JiJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 20:38:48 +0000
Date:   Tue, 19 Apr 2022 22:34:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Su Yue <l@damenly.su>
Subject: Re: [PATCH v2] btrfs: remove an ASSERT() which can cause false alert
Message-ID: <20220419203444.GB1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Su Yue <l@damenly.su>
References: <f0d4a789788e8e63041dc6d91408f40234daa329.1645091180.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d4a789788e8e63041dc6d91408f40234daa329.1645091180.git.wqu@suse.com>
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

On Thu, Feb 17, 2022 at 05:49:34PM +0800, Qu Wenruo wrote:
> [BUG]
> Su reported that with his VM running on an M1 mac, it has a high chance
> to trigger the following ASSERT() with scrub and balance test cases:
> 
> 		ASSERT(cache->start == chunk_offset);
> 		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
> 				  dev_extent_len);
> 
> [CAUSE]
> The ASSERT() is making sure that the block group cache (@cache) and the
> chunk offset from the device extent match.
> 
> But the truth is, block group caches and dev extent items are deleted at
> different timing.
> 
> For block group caches and items, after btrfs_remove_block_group() they
> will be marked deleted, but the device extent and the chunk item is
> still in dev tree and chunk tree respectively.
> 
> The device extents and chunk items are only deleted in
> btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs()
> or btrfs_relocate_chunk().
> 
> This timing difference leaves a window where we can have a mismatch
> between block group cache and device extent tree, and triggering the
> ASSERT().
> 
> [FIX]
> 
> - Remove the ASSERT()
> 
> - Add a quick exit if our found bg doesn't match @chunk_offset
> 
> - Add a comment on the existing checks in scrub_chunk()
>   This is the ultimate safenet, as it will iterate through all the stripes
>   of the found chunk.
>   And only scrub the stripe if it matches both device and physical
>   offset.
> 
>   So even by some how we got a dev extent which is no longer owned
>   by the target chunk, we will just skip this chunk completely, without
>   any consequence.
> 
> Reported-by: Su Yue <l@damenly.su>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Filipe sent a fix that's slightly different, as you haven't sent an
update I'll take his patch.
