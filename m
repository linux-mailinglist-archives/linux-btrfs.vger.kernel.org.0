Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F27167EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjE3Pvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjE3PvG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 11:51:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014F1A2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 08:50:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2BE0B21A3D;
        Tue, 30 May 2023 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685461826;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/+GAJsuD4s7Y/tnFgARUxJTW+W1NiiF+pfUlsE/v0k=;
        b=u5ffqMOzQFrYM5Fw4ovFEGubnTis8SxGvX85Qcn3fi8cKM6b46pyhgqvoFafxgxUdEB3xA
        IhN0DrCvLr8rVB/3QBEX0xTt962c5BGsfS6FpE7I++Oht23XYt6j1B2XAYanAb5cHsOf18
        tvCUd5veWBXM1G4yzqKpAfxkESt/csc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685461826;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/+GAJsuD4s7Y/tnFgARUxJTW+W1NiiF+pfUlsE/v0k=;
        b=0SSFNnJfFCb/WQcgowtN71lW+Ti6jUXoNns8OZ+YD2g+Vgx4zk/vsZUv6SpOLbrPfiLnEM
        a9qXWofGnal3aCDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB4EA13597;
        Tue, 30 May 2023 15:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rLSyOEEbdmSeGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 15:50:25 +0000
Date:   Tue, 30 May 2023 17:44:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/14] btrfs: return void from btrfs_finish_ordered_io
Message-ID: <20230530154415.GA30110@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524150317.1767981-10-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 05:03:12PM +0200, Christoph Hellwig wrote:
> The callers don't check the btrfs_finish_ordered_io return value, so
> drop it.

Same general comments like in
https://lore.kernel.org/linux-btrfs/20230530150359.GS575@twin.jikos.cz/

"Function can return void if none of its callees return an error,
 directly or indirectly, there are no BUG_ONs left to be turned to
 proper error handling or there's no missing error handling"

btrfs_finish_ordered_io mixes a few error handling styles, there's
direct return -ERROR, transaction abort or mapping_set_error. Some
called functions are not error handling everything propely and at least
btrfs_free_reserved_extent() returns an error but is not handled.

I'm not counting the state bit handlers (clear_extent_bit) as we know
they "should not fail". unpin_extent_cache() does not look clean either.

If 'callers don't check error values' the question is 'Should they?'.
