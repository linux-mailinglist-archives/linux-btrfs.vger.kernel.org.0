Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C5F7A5502
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 23:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjIRV0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjIRV0t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 17:26:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A494118
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 14:26:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C81822218;
        Mon, 18 Sep 2023 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695072399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8IVD7EEY6t3/lvF34Z2hsKEbx2ckSF6RSSO8DAhJAs=;
        b=yD2I3pqWgtB2MW7sJnS/zyDA93IYozBHWdj3bdYgB1pnDmOJOEF5C7Zk2SpVPcVgokQqCJ
        p6KTE/dwatd1eULt7SDgXOzIFrIE7wa9HCMmRIOMOido+USVbnb0JoepQvdjIDEQ5TF5qg
        Z0T3J7oxHeqmyutnw8zTgv8RcwHa7aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695072399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8IVD7EEY6t3/lvF34Z2hsKEbx2ckSF6RSSO8DAhJAs=;
        b=joh0sw5Ec/XDGuXhihXQ0xIs6ecBPsmFCvjheZxbknpbHR3+JDv59qp3udRs3gfvpMArRr
        +Xr8tcxIhF7s44Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2D521358A;
        Mon, 18 Sep 2023 21:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j5pfNo7ACGUGegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 21:26:38 +0000
Date:   Mon, 18 Sep 2023 23:20:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: properly report 0 avail for very full file systems
Message-ID: <20230918212003.GN2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a9e6b02e9eb7a0532c401a898661b0511c31d0e8.1695047676.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e6b02e9eb7a0532c401a898661b0511c31d0e8.1695047676.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 10:34:51AM -0400, Josef Bacik wrote:
> A user reported some issues with smaller file systems that get very
> full.  While investigating this issue I noticed that df wasn't showing
> 100% full, despite having 0 chunk space and having < 1mib of available
> metadata space.
> 
> This turns out to be an overflow issue, we're doing
> 
> total_available_metadata_space - SZ_4M < global_block_rsv_size
> 
> to determine if there's not enough space to make metadata allocations,
> which overflows if total_available_metadata_space is < 4M.  Fix this by
> checking to see if our available space is greater than the 4M threshold.
> This makes df properly report 100% usage on the file system.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
