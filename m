Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A255EC2B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Sep 2022 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiI0MaL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Sep 2022 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiI0M3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 08:29:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A341995
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 05:29:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E72721CF7;
        Tue, 27 Sep 2022 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664281787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+Ie9YBIXjIj1KRvCz1/gNz0+Qjk6HwXIZzhxld29iM=;
        b=g5TJFnzYFQqlych8ox3SXKucPT9vsR60aUgpSOAtiPkmfN4AI0Emp2V5tCCdR2EY9ukRQp
        Pmv0WIl7OKo1uWctuxYs8Y1XUopTTvdcHAYB3jlXsrvyYHYVSl5EQY40yzBvIl0cMkyh0Y
        RXahSuh76so9nKLMV9HDSMTYp3cZfF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664281787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+Ie9YBIXjIj1KRvCz1/gNz0+Qjk6HwXIZzhxld29iM=;
        b=N9XoSnOwKkaspcmH3/3ocktfwhSpGAPTDvt0RcsoGtIKqP21yXJKDsQy4Ev8UQHqoiTter
        yyws7w1ujiBb8YCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FCCA139B3;
        Tue, 27 Sep 2022 12:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1xlnGrvsMmMiCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 27 Sep 2022 12:29:47 +0000
Date:   Tue, 27 Sep 2022 14:24:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: send: gate SEND_A_MAX and SEND_C_MAX V3
Message-ID: <20220927122412.GC13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6c87faf8a6ff6172019faed9988adb9fb99689b4.1664216021.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c87faf8a6ff6172019faed9988adb9fb99689b4.1664216021.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 26, 2022 at 11:15:22AM -0700, Boris Burkov wrote:
> We haven't finalized send stream v3 yet, so gate setting the max command
> values behind CONFIG_BTRFS_DEBUG.
> 
> In my testing, and judging from the code, this is a cosmetic change;
> verity send commands are still produced (and processed by a compatible
> btrfs-progs), even with CONFIG_BTRFS_DEBUG=n set.

There must be some misunderstanding and what you implemented is not what
I had in mind. The debug protection should have been for
BTRFS_SEND_STREAM_VERSION so we have v3 available for debug builds and
not otherwise. The version support is not determined by the command
definitions but by the BTRFS_SEND_STREAM_VERSION macro exported to
sysfs.
