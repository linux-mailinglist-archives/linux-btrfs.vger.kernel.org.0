Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2154E7C91
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Mar 2022 01:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiCYURg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 16:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiCYURf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 16:17:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986E53A5B
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 13:15:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 100821F37D;
        Fri, 25 Mar 2022 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648239358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzRcRf0ciU8mYDmqkJhNgn6GLl/gZKaVtC/dkLMJ4m8=;
        b=uuRBtZ6iaa2yfqtBgc117DqIEvwCZsxIo3HTmUJ1nkQjQCYkwkLofHQhxOXiQZPqRxl8PW
        9NZe5dF1sJ1BwBigsLNFpf4Alv1j1H/Lj0ejByG3OP296vuF+PY2F01ZlxbZc/83bWNIa2
        Ht0MhsQ5r1+c0Ewt0jwEFJ+PGM/jKm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648239358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzRcRf0ciU8mYDmqkJhNgn6GLl/gZKaVtC/dkLMJ4m8=;
        b=4q1SDJ+1a1VD7lDSHrJheYrVgOyvdrheq5yxRGmtuQ5YWhDuXTzuX3XicZNpHjBqhNzUUQ
        lNYb5PNfENDTMpAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F40CFA3B8A;
        Fri, 25 Mar 2022 20:15:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65B84DA7F3; Fri, 25 Mar 2022 21:12:02 +0100 (CET)
Date:   Fri, 25 Mar 2022 21:12:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jonathan Lassoff <jof@thejof.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] Add Btrfs messages to printk index
Message-ID: <20220325201202.GM2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jonathan Lassoff <jof@thejof.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
References: <b16ccc0d48d9a25fd001f57eaeb3066055ac17a4.1648162972.git.jof@thejof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16ccc0d48d9a25fd001f57eaeb3066055ac17a4.1648162972.git.jof@thejof.com>
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

On Thu, Mar 24, 2022 at 04:04:17PM -0700, Jonathan Lassoff wrote:
> In order for end users to quickly react to new issues that come up in
> production, it is proving useful to leverage this printk indexing system. This
> printk index enables kernel developers to use calls to printk() with changable
> ad-hoc format strings, while still enabling end users to detect changes and
> develop a semi-stable interface for detecting and parsing these messages.
> 
> So that detailed Btrfs messages are captured by this printk index, this patch
> wraps btrfs_printk and btrfs_handle_fs_error with macros.
> 
> PATCH v1
>   - Fix conditional: CONFIG_PRINTK should be CONFIG_PRINTK_INDEX
>   - Fix whitespace
> PATCH v2 -- Minimize the btrfs ctree.h changes
> 
> Signed-off-by: Jonathan Lassoff <jof@thejof.com>

Added to misc-next, with some fixups, thanks.
