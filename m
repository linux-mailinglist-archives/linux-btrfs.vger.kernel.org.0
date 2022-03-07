Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DBA4D00A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 15:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiCGOEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 09:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiCGOE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 09:04:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E456205
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 06:03:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1DDCF210EC;
        Mon,  7 Mar 2022 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646661808;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gvHhHRTumj3kEjXvI8amk/0zl3HcZGcvOoWVM/FCnRI=;
        b=mdoe8IbLuoHTHf8a3aKdf6eTg7mp4gIMvD2JhyCADxOhc/hOmMwxjrfrABb3dC+R6drFs/
        1Qdew4Q3NZHqTQcw0FFvu6MK4N3017D6eLAOYBt18wGXU8oUmuGwZvG1WXintNAJ6WpR9h
        QSxsCfCDpqGXzpBb8dkvkNcqNYVSuRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646661808;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gvHhHRTumj3kEjXvI8amk/0zl3HcZGcvOoWVM/FCnRI=;
        b=25BGYxZU5BPbHK5lPZ68oWPSYXcK9rAKxs6hq2MBBp9rsTdD1l5H0IJDKs3OxQj9k4OSL0
        MpNTaTog5HB8KSAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 14AC0A3B8A;
        Mon,  7 Mar 2022 14:03:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8FA9DDA7F7; Mon,  7 Mar 2022 14:59:33 +0100 (CET)
Date:   Mon, 7 Mar 2022 14:59:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: Put block group after final usage
Message-ID: <20220307135933.GE12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220307133002.28765-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307133002.28765-1-nborisov@suse.com>
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

On Mon, Mar 07, 2022 at 03:30:02PM +0200, Nikolay Borisov wrote:
> It's counter-intuitive (and wrong) to put the block group _before_ the
> final usage in submit_eb_page. Fix it by re-ordering the call to
> btrfs_put_block_group after its final reference. Also fix a minor typo
> in 'implies'
> 
> 
> Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
