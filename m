Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544A86DE854
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 01:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDKX4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 19:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDKX4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 19:56:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB292272B
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 16:56:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A0AF218FE;
        Tue, 11 Apr 2023 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681257370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycEvp6ml8PeV+Uoq4ymn80StoOO7ujrRTWMmLr3+dwE=;
        b=NUNg0Hao+lyCGsIpe62O7wmBvp12Pua38uwM13UkIeDLivSA4jEp4/EWzL6WaTDUTPcZq+
        ZG1hFk8wNrK6+3T1SY16bSun7teZ2Luq/Stko7mjEPw7WUdaNeuvog3IYfrBvAcT8gXo8m
        XY+2Q8sHpCdoG7A45/F5ut6mM/BoQls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681257370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycEvp6ml8PeV+Uoq4ymn80StoOO7ujrRTWMmLr3+dwE=;
        b=ZQhBgE7+IPPbPgJtJ/NHtBQ2PYpWgvWWHl0mzDkQKfnN4Yg09pNe+T8mVJLm/lXe24v3xU
        nRLxz7MZ3SCLEGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4074B1331E;
        Tue, 11 Apr 2023 23:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZhzuDprzNWR8YwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Apr 2023 23:56:10 +0000
Date:   Wed, 12 Apr 2023 01:56:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: make some of the fsck-tests run without
 root
Message-ID: <20230411235604.GD19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681150198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681150198.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 10, 2023 at 02:11:30PM -0400, Josef Bacik wrote:
> Hello,
> 
> While running tests on my ctree sync patches I noticed these tests were failing
> when I ran as a normal user.  Most of them are just needing to call
> setup_root_helper before calling the loop device helpers, some need a
> $SUDO_HELPER added to a few places.  With these patches in place I can run make
> test-fsck as a normal user.  Thanks,
> 
> Josef
> 
> Josef Bacik (4):
>   btrfs-progs: fix fsck-tests/056 to run without root
>   btrfs-progs: fix fsck-tests/057 to run without root
>   btrfs-progs: fix fsck-tests/059 to run without root
>   btrfs-progs: fix fsck-tests/060 to run without root

Added to devel, thanks. I went through all other tests, there are some
more missing helper setup calls but they're also called within some
other helpers (like run_check_mkfs_test_dev). I've added them for
clarity.
