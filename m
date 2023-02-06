Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8155F68C46B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBFRSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 12:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBFRSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 12:18:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE721EBD1
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 09:18:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3432B3F603;
        Mon,  6 Feb 2023 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675703911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6BvIHx6afsgTLSEbm06QE8mQ72GJK/Ybll8+QFdN/0=;
        b=JVfw0+c1+6FVBaJqZlyPlMUxGdiA+G+N8tCp2pHsBq5+TcihjOIWMXkbGPC2/XmzhXGEB/
        3y5LRrWRmy6qUrYmPQeQBniZgSC7yv296QuZOE144x7mFs6rxSUeqUYR8WEIVG1bjsieer
        R6HYw48kkdDUopoF3tm1gPje/svC3Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675703911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6BvIHx6afsgTLSEbm06QE8mQ72GJK/Ybll8+QFdN/0=;
        b=k7b5YqsLBbBBkOXV2wT49NFt5kbb1mQV2dAt7hwtzsaDwgJ7VvF5cUEU9kIjhLEcQtEoHG
        YjxacBJ/D6FHPvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EDC8138E8;
        Mon,  6 Feb 2023 17:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OQK+Amc24WMEKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Feb 2023 17:18:31 +0000
Date:   Mon, 6 Feb 2023 18:12:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/7] extent buffer dirty cleanups
Message-ID: <20230206171242.GA28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1674766637.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 26, 2023 at 04:00:53PM -0500, Josef Bacik wrote:
> v2->v3:
> - Reworked the logic around clearing dirty on extent buffers not in our
>   transaction.  We do need this for update_ref_for_cow in some cases that I
>   didn't account for.  I've expanded the logic for this make it more idiot
>   proof, and adjusted all of the patches accordingly.

Added to misc-next, thanks.
