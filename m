Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150B4652658
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiLTSel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 13:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLTSeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 13:34:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883702192
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 10:34:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3EA2A76BC3;
        Tue, 20 Dec 2022 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671561275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kEuPu8dBFEO24+AhtLVHDkWinyih5adeC8AfZuoVeeA=;
        b=onX8Pc8bQ8+guoZ6xpv6WLGut1+qyDWKPDlL/OA66gEhn300pmbamwAhcqkrdUIeV9lO6h
        nzBRNirER1i0LKCLQCBKeBEdbhTMv9ou5VILqeL00L8s9EDQXdsxWQwWf7sANh9/eyNci4
        FzcyU7sj4Z4ND44yA2ek2zXi+jtglGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671561275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kEuPu8dBFEO24+AhtLVHDkWinyih5adeC8AfZuoVeeA=;
        b=OqCYGk/omzpHvhgnexBMPQBr3ZK516m/531G2RSu0HptQNUSf9nrtxd9elndN80fHxYnCM
        w9COlSxD7a/Ey7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 146D51390E;
        Tue, 20 Dec 2022 18:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IfP6AzsAomNgKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 18:34:35 +0000
Date:   Tue, 20 Dec 2022 19:33:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: delayed_ref parameter cleanup
Message-ID: <20221220183349.GM10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
 <98f29028-b984-47ef-6c9a-1742418c8bf8@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f29028-b984-47ef-6c9a-1742418c8bf8@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 09:17:22AM +0000, Johannes Thumshirn wrote:
> On 12.12.22 10:03, Johannes Thumshirn wrote:
> > While looking at the delayed_ref code for the RST series I've discovered, that
> > drop_delayed_ref is using a btrfs_trans_handle without even using it. After
> > having it removed I've identified more uses of the trans in the callchain that
> > are unused after drop_delayed_ref got rid of it.
> > 
> > Johannes Thumshirn (4):
> >   btrfs: drop unused trans parameter of drop_delayed_ref
> >   btrfs: remove trans parameter of merge_ref
> >   btrfs: drop trans parameter of insert_delayed_ref
> >   btrfs: directly pass in fs_info to btrfs_merge_delayed_refs
> > 
> >  fs/btrfs/delayed-ref.c | 24 ++++++++++--------------
> >  fs/btrfs/delayed-ref.h |  2 +-
> >  fs/btrfs/extent-tree.c |  4 ++--
> >  3 files changed, 13 insertions(+), 17 deletions(-)
> > 
> > 
> > base-commit: b7af0635c87ff78d6bd523298ab7471f9ffd3ce5
> Ping?

The patchset has been in misc-next for some time, I forgot to send the
mail.
