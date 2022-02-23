Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C160F4C19BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 18:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbiBWRPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 12:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiBWRPo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 12:15:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F959C4B;
        Wed, 23 Feb 2022 09:15:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0CEE5210DB;
        Wed, 23 Feb 2022 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645636516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drRZ4RI3au+FeOyd3RQe4hd3VHT1iM+JJ0axNcietxM=;
        b=OISwRtmS4YwegylXiAcu/csQVzSZm5Jyfh+UYN+dfYU7J676mZTnhkfrLi6+BMtBs/d1sF
        JhAL8EC10EfooGEiAkTjlzu/XZ1NyBZEjTc2ctjLbxV1iAHtfY6ymwqb9O8+36Z44gWZR7
        hkh582myLYd4uvC4hzmfPm/cGTxbeiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645636516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drRZ4RI3au+FeOyd3RQe4hd3VHT1iM+JJ0axNcietxM=;
        b=qbdnGCGZSREbfU81DzhUVI6bAQBS1z8maeazzi+rMpuK97oWSnMfwVwBd5x8dUWJdZ0ME7
        jJEisWaykD0FsaBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 049DEA3B84;
        Wed, 23 Feb 2022 17:15:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C33D9DA7F7; Wed, 23 Feb 2022 18:11:26 +0100 (CET)
Date:   Wed, 23 Feb 2022 18:11:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Eryu Guan <guan@eryu.me>
Cc:     Gabriel Niebler <gniebler@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: fix btrfs/255 to fail on deadlock
Message-ID: <20220223171126.GQ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eryu Guan <guan@eryu.me>,
        Gabriel Niebler <gniebler@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220216100535.4231-1-gniebler@suse.com>
 <YhJ1VwUqPWkgPx2V@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhJ1VwUqPWkgPx2V@desktop>
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

On Mon, Feb 21, 2022 at 01:07:35AM +0800, Eryu Guan wrote:
> On Wed, Feb 16, 2022 at 11:05:35AM +0100, Gabriel Niebler wrote:
> > In its current implementation, the test btrfs/255 would hang forever
> > on any kernel w/o patch "btrfs: fix deadlock between quota disable
> > and qgroup rescan worker", rather than failing, as it should.
> > Fix this by introducing generous timeouts.
> > 
> > Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> 
> If deadlock was already triggered, I don't think killing the userspace
> program with timeout will help, as the kernel already deadlocked, and
> filesystem and/or device can't be used by next test either.
> 
> I think we should just exclude the test when running tests on unpatched
> kernel.

I don't see a way how to detect it at runtime, or do you mean to use the
expunge files?
