Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E5656A980
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiGGRYc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 13:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiGGRY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 13:24:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1506B57223
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 10:24:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 966921FA76;
        Thu,  7 Jul 2022 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657214665;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mua5vVo02Nv0aLOvf+o0qzEjiBa8GfSHBQf2hDtg5Ao=;
        b=PTTi7/peHbyPGr9i1Q8mkAK4+S8zdvJimP1eH11kmHSLa+NbpxEpseKdD/YRiixun8Xi3W
        sP7+VZ+Ca8gLS/4BOp99Cz3YE4TCxtKiMcgiS9vumVWleB6c9rJQwkN5s0R1yg/+owMUq+
        k5uEcwwNJPtYTw0FB35s5DkpemjVoqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657214665;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mua5vVo02Nv0aLOvf+o0qzEjiBa8GfSHBQf2hDtg5Ao=;
        b=c+ekhF3j+vyWtoh7UHC082Q/DaxJ6Qi+a+K6U95rx9VAG0rEOgdKeyv2UtldK+2dJPYRom
        Cai4IyZvYy0GW4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68ADF13461;
        Thu,  7 Jul 2022 17:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bGWdGMkWx2LOegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 17:24:25 +0000
Date:   Thu, 7 Jul 2022 19:19:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
Message-ID: <20220707171938.GJ15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
References: <20220630160319.2550384-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630160319.2550384-1-hch@lst.de>
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

On Thu, Jun 30, 2022 at 06:03:19PM +0200, Christoph Hellwig wrote:
> Don't leak the bioc on normal completion.
> 
> Fixes: 7db1c5d14dcd ("btrfs: zoned: support dev-replace in zoned filesystems")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.
