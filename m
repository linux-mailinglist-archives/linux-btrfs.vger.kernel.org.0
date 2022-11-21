Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5821A632C02
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 19:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKUSYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 13:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUSYt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 13:24:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD8CDFD1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:24:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96F45220BD;
        Mon, 21 Nov 2022 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669055086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LwykWCS3lJs+ukJ4gLP9oLOk32KYWxUeU1ei5+dOmU=;
        b=KeUypytaxqL9wkgwhYHoIqj0jiX5i38Oz9s/Uu+udQtRz5fKUukraUtX8OST3B9ljHNEvW
        pWTRt95yag0bRFh4CJXzzRU7+7ohxnkuvr1ushUj08dL4jEKnIaAIjOTcI8cPQ/Jk7Erpt
        VJSnh05ISv7w/6qN/oG3H2VJQvaVd8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669055086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LwykWCS3lJs+ukJ4gLP9oLOk32KYWxUeU1ei5+dOmU=;
        b=zEhQ6VmM1KGut+notIMunkmSdv7NPTPj3QowOOJA9CubDGn/qS1xoyFhAiFf4g/jrcmYlQ
        FtmgM8TGBPGpscCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A9791377F;
        Mon, 21 Nov 2022 18:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TwQOGW7Ce2OhHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 21 Nov 2022 18:24:46 +0000
Date:   Mon, 21 Nov 2022 19:24:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix uninitialized variable in
 find_first_clear_extent_bit
Message-ID: <20221121182416.GA5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bf7143200d35786f2d20e929cb3a626a94b4e9b4.1668802173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7143200d35786f2d20e929cb3a626a94b4e9b4.1668802173.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 18, 2022 at 03:09:42PM -0500, Josef Bacik wrote:
> This was caught when syncing extent-io-tree.c into btrfs-progs.  This
> however isn't really a problem, the only way next would be uninitialized
> is if we found the range we were looking for, and in this case we don't
> care about next.  However it's a compile error, so fix it up.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
