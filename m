Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900276B9F2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 19:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCNSzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNSyp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 14:54:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3131812065
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 11:54:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10ADC21C50;
        Tue, 14 Mar 2023 18:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678820059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RLg1yPvaPXFVdKoDIpLKQlQiWB1HAhjkwJ7JHxE8QoA=;
        b=mbqCNf+WvnHwvBmrxMs6fgDK+8A8eIDo9qnHAOlmHyZ5fNwpRd1FoCJ3SR+qrmCNfnN17B
        /UeAnoY0poXnG9sOXkS3QN9stIrEZerhwUTJAlRapA4ONwQxS5n60Db879dwBgfpNyjcPB
        Mi+No73tW0/7/0lERvlhiVscpEx0Gd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678820059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RLg1yPvaPXFVdKoDIpLKQlQiWB1HAhjkwJ7JHxE8QoA=;
        b=3xyW9aXVaD+YSS+rjIokFAGfXGLYV9rVWOk+dlKh/vZiCSJxlXBBXrZvHVzNNgt+Tduyj9
        LmNr3cnZmPK5vVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E71E813A26;
        Tue, 14 Mar 2023 18:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /rBUN9rCEGRrMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Mar 2023 18:54:18 +0000
Date:   Tue, 14 Mar 2023 19:48:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <20230314184812.GS10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1678777941.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678777941.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 03:34:55PM +0800, Qu Wenruo wrote:
> This series can be found in my github repo:
> 
> https://github.com/adam900710/linux/tree/scrub_stripe
> 
> It's recommended to fetch from the repo, as our misc-next seems to
> change pretty rapidly.

There's a cleanup series that changed return value type of
btrfs_bio_alloc which is used in 3 patches and it fails to compile. The
bio pointer needs to be switched to btrfs_bio and touches the logic so
it's not a trivial change I'd otherwise do.

There's also some trailing whitespace in some patches and 'git am'
refuses to apply them. Pulling the series won't unfortunatelly help,
please refresh the series.

Regarding misc-next updates: it gets rebased each Monday after a -rc is
released so the potentially duplicated patches merged in the last week
disappear from misc-next. Otherwise I don't rebase it, only append
patches and occasionally update tags or some trivial bits in the code.

If you work on a patchset for a long time it may become a chasing game
for the stable base, in that case we need to coordinate and/or postpone
some series.
