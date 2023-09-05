Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0928792E98
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjIETOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 15:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjIETOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 15:14:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77573CFD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 12:14:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB99321ED8;
        Tue,  5 Sep 2023 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693941145;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5nklx2pct3h2K5a1+DWx4E8Txqx+uLjJrq+6ntZWBK8=;
        b=V5kSsUdwaYRD7CMlkrfsAnzVeg2XWyJ2jtgNyJW+BELd1nY5yFB6mOyy///Nk/wvNUsETH
        98E4e6kd18f8eP6/rOdzt9lid/GnWUgFUUdvW6sNqzsiiFYitCrS3oIyHTGO2q9/AbpIgQ
        ZYzsXXfqrBucsvIVP5tr+ITu3HvxD18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693941145;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5nklx2pct3h2K5a1+DWx4E8Txqx+uLjJrq+6ntZWBK8=;
        b=5loJZqVwtN6TDa5CHJyWwwImFxRDNSj3O3zg7SLtRiyxQadY8SIdj9NW0xrzTkqXgMydUN
        KFCbmP2DLIX9hIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9127913911;
        Tue,  5 Sep 2023 19:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ro+dIpl992QBagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 19:12:25 +0000
Date:   Tue, 5 Sep 2023 21:05:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: don't take the commit root ref in
 btrfs_create_tree
Message-ID: <20230905190545.GI14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <937ef150c1d9c0135bd1b158a9b5ad44dbd35b5b.1693580689.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937ef150c1d9c0135bd1b158a9b5ad44dbd35b5b.1693580689.git.josef@toxicpanda.com>
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

On Fri, Sep 01, 2023 at 11:04:56AM -0400, Josef Bacik wrote:
> In 3ca6ed76 ("btrfs-progs: don't set the ->commit_root in
> btrfs_create_tree") I stopped setting ->commit_root, but forgot to not take
> the ->commit_root reference.  Delete this extra reference so we are not
> leaking extent buffers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I've removed teh patches unifying the tree creations and the prep
patches removing the references. There were no conflicts so if you
rebase the series on top of devel the removed patches will show up.
