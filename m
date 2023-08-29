Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09E078CB95
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbjH2Rw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbjH2RwO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 13:52:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF9E9
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 10:52:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E29F021858;
        Tue, 29 Aug 2023 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693331529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17r4jOteHREKKPNO1QqenpNfRsqJEbecFYGyeM+rtRM=;
        b=Onut3w5lZ0bebgAD/TkXPEaHO1NsDnVW5/rAsY55vb4V9kGgrdLze1syA767thjKa3083J
        oqTreX6P/dYiidzJNZ/fT5V5MGd71WsrK47KuM+n2ZNQ9aP0PDg9NKYx39LSXQ4mYLFuR1
        2u6+fA+DnIb9wyNOk2KaOgzI72+tz0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693331529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17r4jOteHREKKPNO1QqenpNfRsqJEbecFYGyeM+rtRM=;
        b=/HqA8xyNGSVbuEg3DW84qzJQgFhxEmxFCcQq3aFaVsPB6g+Z1e1Q4OgNynD3I7q3IDkqBn
        rbO9WIpCWpyeSwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C62C513301;
        Tue, 29 Aug 2023 17:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QkhIL0kw7mR6awAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 29 Aug 2023 17:52:09 +0000
Date:   Tue, 29 Aug 2023 19:45:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add a free_root_extent_buffers helper
Message-ID: <20230829174533.GI14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9dde35bf7b2817ae22d60510ec8f4fc6e0614221.1692969459.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dde35bf7b2817ae22d60510ec8f4fc6e0614221.1692969459.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 09:17:45AM -0400, Josef Bacik wrote:
> Our CI started failing a bunch because I accidentally introduced an
> extent buffer leak.  This is because we haphazardly have ->commit_roots
> used in btrfs-progs, and they get freed when the transaction commits and
> then they're cleared out.  In the kernel we make sure to free all this
> when we free the root, but we don't have the same thing in btrfs-progs.
> Fix this by bringing over the free_root_extent_buffers helper and use
> this for free'ing up all the roots.  This brings us inline with the
> kernel more and eliminates the extent buffer leak.

With this patch applied in devel I still see the leaks after mkfs.
