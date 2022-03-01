Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE584C9053
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiCAQa6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 11:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiCAQa5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 11:30:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F7387A5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 08:30:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7260B21997;
        Tue,  1 Mar 2022 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646152214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ebVxbfU6Oe46UhxnH3kyfk2DQ2MvZ8ndGa3HzC71HA=;
        b=cKm5rIGJSxOq1XTDBBG6iBQrEgBTkZDCiL9STlz84EPDq3K9kLascjTdhYskJf6LtiW9tv
        hZMwX/hDeDGlUY3ekZ7mniLuuj7KUSjMnZt/A+o1obqNlF8kif4eRuN2hCCLOIAOY5dEPy
        Hvs1PmCuZ4wwIC3NFp8MPyukvQMRSLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646152214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ebVxbfU6Oe46UhxnH3kyfk2DQ2MvZ8ndGa3HzC71HA=;
        b=B5mRcCP4eofTRhij9i+jUF8dXdgrDFCzqlYpvjD4t6SM3MuihbF2udsv7dJHC3Qji6vxQ1
        ejZtBuOgtga+WKAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6AA0EA3B81;
        Tue,  1 Mar 2022 16:30:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE811DA80E; Tue,  1 Mar 2022 17:26:22 +0100 (CET)
Date:   Tue, 1 Mar 2022 17:26:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] btrfs: some extent tree modification cleanups
Message-ID: <20220301162622.GQ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645643109.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645643109.git.josef@toxicpanda.com>
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

On Wed, Feb 23, 2022 at 02:06:42PM -0500, Josef Bacik wrote:
> Hello,
> 
> These four patches are some prep/cleanup patches that I have for the next batch
> of extent tree v2 changes I have queued up.  They are cosmetic, simply moving
> some code around and cleaning up some old cruft that was left over.  Thanks,
> 
> Josef
> 
> Josef Bacik (4):
>   btrfs: remove BUG_ON(ret) in alloc_reserved_tree_block
>   btrfs: add a alloc_reserved_extent helper
>   btrfs: remove `last_ref` from the extent freeing code
>   btrfs: add a do_free_extent_accounting helper

Added to misc-next, thanks.
