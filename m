Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BF054B22D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiFNNSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 09:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiFNNSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 09:18:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE83B2BA
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 06:18:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEA1321B3D;
        Tue, 14 Jun 2022 13:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655212726;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/755uzTBkSiGX+okPA7lxGEo+0sncu5UyuLzgYfGc8Q=;
        b=bhKBSA2CAdFoo5BH3BnO+klc+aB6xDSXfu7MMQS088WUFnBJ9bzuDvtxBp6arpAWa1Caw5
        aS0yVz/OIqjaRfiotWgrlz62KvHmuh85E275Cn2Ev6pDnCKnqeK0tOQx/y1ZBwLcw6enY/
        NUG4DHffkYk+zl3eR4Dk8myH1a23dAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655212726;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/755uzTBkSiGX+okPA7lxGEo+0sncu5UyuLzgYfGc8Q=;
        b=sJSZlKXgI4/u0KxB53r6axqWDlz6Z9LTQTzk5IeBh6gYm0QJ3+0/rcTarY3i+HVyCIBj+O
        LDz65PnX6LkR2YDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD2551361C;
        Tue, 14 Jun 2022 13:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ktn/MLaKqGIAJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Jun 2022 13:18:46 +0000
Date:   Tue, 14 Jun 2022 15:14:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs: fix deadlock with fsync and full sync
Message-ID: <20220614131413.GJ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1655147296.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655147296.git.josef@toxicpanda.com>
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

On Mon, Jun 13, 2022 at 03:09:47PM -0400, Josef Bacik wrote:
> v1->v2:
> - Make btrfs_sync_file also use the new BTRFS_LOG_FORCE_COMMIT define.
> - Adjust the title of the second patch
> 
> --- Original email ---
> Hello,
> 
> We've hit a pretty convoluted deadlock in production that Omar tracked down with
> drgn.  I've described the deadlock in the second patch, but generally it's a
> lock inversion where we have an existing dependency of extent lock ->
> transaction, but in fsync in a few cases we can end up with transaction ->
> extent lock, and the expected hilarity ensues.  Thanks,
> 
> Josef
> 
> Josef Bacik (2):
>   btrfs: make the return value for log syncing consistent
>   btrfs: fix deadlock with fsync+fiemap+transaction commit

Added to misc-next, thanks.
