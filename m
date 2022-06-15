Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF054C757
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbiFOLXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245341AbiFOLXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 07:23:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B732EC9
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 04:23:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B72B1F88E;
        Wed, 15 Jun 2022 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655292224;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wBbdgUTazcnlZJaFQEYsFHgAogg6ZaOFaxjhcjmTjs=;
        b=YaCZ4ifPEZBASHx/LmVckRTSuid9arEECAGDQYeXKDQAfwhVBr5ULSz8BExGEoo1Tny8D7
        nJy1SQvPGmAs/JtvhzoaQ5FszUDUSp8ixgsraAWa/FM3SqvDktv247CgPs4uQg6ckLZAkN
        lTwTeEdHkbl/K3u9GKsisVo+5fJaITs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655292224;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wBbdgUTazcnlZJaFQEYsFHgAogg6ZaOFaxjhcjmTjs=;
        b=k7o0GXYNRci4t07W3WMQKhUyO3Pnv2XJio+86wINM6q02GXH4WtckM3EkOaEUZMftWvWwH
        k6UMK2650QWiEtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72316139F3;
        Wed, 15 Jun 2022 11:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vr8EG0DBqWJzcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Jun 2022 11:23:44 +0000
Date:   Wed, 15 Jun 2022 13:19:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Extent tree search cleanups
Message-ID: <20220615111910.GR20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1654706034.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1654706034.git.dsterba@suse.com>
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

On Wed, Jun 08, 2022 at 06:43:19PM +0200, David Sterba wrote:
> The extent_io_tree search helpers take return parameters and many
> callers pass just NULL, which are checked and add a conditionals to some
> paths. Reorganize helpers to suit what callers need and drop unnecessary
> parameters, open code rbtree search loops and clean up some other
> parameters.
> 
> This could improve performance in some cases but it's mostly micro
> optimizations and I haven't done any measurements.
> 
> David Sterba (9):
>   btrfs: open code rbtree search into split_state
>   btrfs: open code rbtree search in insert_state
>   btrfs: lift start and end parameters to callers of insert_state
>   btrfs: pass bits by value not pointer for extent_state helpers
>   btrfs: add fast path for extent_state insertion
>   btrfs: remove node and parent parameters from insert_state
>   btrfs: open code inexact rbtree search in tree_search
>   btrfs: make tree search for insert more generic and use it for
>     tree_search
>   btrfs: unify tree search helper returning prev and next nodes

Added to misc-next.
