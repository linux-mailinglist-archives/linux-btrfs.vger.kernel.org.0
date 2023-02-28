Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A246A63C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 00:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjB1XUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 18:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjB1XUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 18:20:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBCE1CF4D
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 15:20:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B32121F38D;
        Tue, 28 Feb 2023 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677626431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9W7IZuIUuomx2iut7Jvrrbvg//WTokwjsV5c9g2wVMA=;
        b=v/9RS2GV8FHxSPrBqwf7r+6d2nRjHFo2NXzyvtcSzeboceE7WgvA9K8F1xYdI3/bO8pCtP
        44qnqNNNqVvj1QlczSy9h7NzdzTEhkZyN8eecFD7f7gZjzWKRAXwBTqxP1r66BsvtyMV/C
        nWVWPWq2IRYk/K6J+z3wCxg15iZJ554=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677626431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9W7IZuIUuomx2iut7Jvrrbvg//WTokwjsV5c9g2wVMA=;
        b=Xxc/LonT+dOt5/Gm9kiRqbP3ArLUVJyf+bwNeL3uWo7rKihdz4lXN92U/d9pKgPD1Vv/ad
        LC47W7gE9NwZ4SBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 908481333C;
        Tue, 28 Feb 2023 23:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MkRxIj+M/mMTNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Feb 2023 23:20:31 +0000
Date:   Wed, 1 Mar 2023 00:14:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     linux-btrfs@vger.kernel.org
Cc:     konstantin@linuxfoundation.org
Subject: btrfs.wiki.k.org is going to be archived
Message-ID: <20230228231432.GS10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

kernel.org is sunsetting all wikis [1] and will archive them (with
redirection of existing links to the archive). The primary source of
documentation will be btrfs.readthedocs.io and mirrored to
btrfs.docs.kernel.org (in the future).

The RTD pages lack some of the wiki content, this will be ongoing work
until all the relevant pages are migrated. Please note that some wiki
pages were old and kept for historical reference so they may not be
migrated but if you'd miss something please open an issue at
github.com/kdave/btrfs-progs .

[1] https://social.kernel.org/notice/ASRGuCQytDxiltpVbM
