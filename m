Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D589B79B050
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355569AbjIKWA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbjIKOmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 10:42:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33259E40
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 07:42:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5409621847;
        Mon, 11 Sep 2023 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694443323;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lan2WQ0FKxOqktmgh4WSaeI0r1Nm1KmyBkm0kxaLsCU=;
        b=hS6dMw7LW/k+JZlg4AvK7D3/R42rSSGDCg/8CJVa4EGNww6jmQqzdIxQ/B3zraHwYAlEzv
        MNw8J7Wbwuxje3jYq6OxitS9loAODspxeSvdi8fxRzoio0vKt3QyyhO6JG1k2d2+hfIWy3
        Aa4r3lfmbBy1FD4R8Jt05CKTuqnhouk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694443323;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lan2WQ0FKxOqktmgh4WSaeI0r1Nm1KmyBkm0kxaLsCU=;
        b=764pi+xGLP9CmqT5a5tlNreTAvOA2daJq6CYaYoFZnu113SdE1r9u+Du77xJ90j3iq87Xp
        77xAaYpylGyyspCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C023139CC;
        Mon, 11 Sep 2023 14:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kVIJCjsn/2TgUgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Sep 2023 14:42:03 +0000
Date:   Mon, 11 Sep 2023 16:35:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: rename errno identifiers to error
Message-ID: <20230911143529.GB3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230908191006.31940-1-dsterba@suse.com>
 <43024b78-debe-4764-8dc2-098e398df719@gmx.com>
 <8dbd9c7b-0f51-4edd-a6e5-0ad6c30e2dd2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dbd9c7b-0f51-4edd-a6e5-0ad6c30e2dd2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 10, 2023 at 02:35:30PM +0930, Qu Wenruo wrote:
> On 2023/9/10 14:28, Qu Wenruo wrote:
> > On 2023/9/9 04:40, David Sterba wrote:
> >> We sync the kernel files to userspace and the 'errno' symbol is defined
> >> by standard library, which does not matter in kernel but the parameters
> >> or local variables could clash. Rename them all.
> > 
> > Well, initially I thought this problem should be exposed by -Wshadow in
> > btrfs-progs, but I'm wrong.
> > 
> > When going W=2 for btrfs-progs, we indeed got some error on some shadows
> > but not any @errno one in the current devel.
> > 
> > Is there some warning option we can use in progs to expose such warnings?
> 
> Never mind, those files are not yet synced to btrfs-progs, thus no such 
> variable shadowing problem.
> 
> For this -Wshadow, I think after cleaning up all those existing warning 
> we may consider put it into the default warning options.

Agreed.
