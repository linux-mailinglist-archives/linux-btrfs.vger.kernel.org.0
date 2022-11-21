Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7BC632BAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKUSCN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 13:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKUSCM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 13:02:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DF1C413
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:02:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9BD3220CF;
        Mon, 21 Nov 2022 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669053730;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4kO9FVbiwRfV69KzyqFJratRmenaDsm5fBgrA0bIlg=;
        b=jUSr5TaT3hnJT1ECtB/E4gPpqIfHgXDXyVhnUBIQ5Hu2zLiYhIP8EvxkSjPWVCr+u6Tx7j
        XCQbCqU3nV8HGOd4+8ItWsgJEG9hXrsM56+o8bMkSm/92zg/9lBXXBHMBr0PzakdV0hihf
        AWs3RzTE8CwoqKppq6xwopJZkL59wzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669053730;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4kO9FVbiwRfV69KzyqFJratRmenaDsm5fBgrA0bIlg=;
        b=FsjRdmY/AVwrKmgxPYc+N7InNeTkoRkUdEJNzH4a6LNnJBPEWFcQTe3H4G9u3R8JbpLrqF
        6iz3jkqrUoCtiHCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A06531376E;
        Mon, 21 Nov 2022 18:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VKZgJiK9e2M2FQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 21 Nov 2022 18:02:10 +0000
Date:   Mon, 21 Nov 2022 19:01:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix uninitialized parent in insert_state
Message-ID: <20221121180141.GZ5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9292ce2f2a9cadb80337cc350716ad9fc244ac2f.1668801961.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9292ce2f2a9cadb80337cc350716ad9fc244ac2f.1668801961.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 18, 2022 at 03:06:09PM -0500, Josef Bacik wrote:
> I don't know how this isn't caught when we build this in the kernel, but
> while sync'ing extent-io-tree.c into btrfs-progs I got an error because
> parent could potentially be uninitialized when we link in a new node,
> specifically when the extent_io_tree is empty.  This means we could have
> garbage in the parent color.  I don't know what the ramifications are of
> that, but it's probably not great, so fix this by init'ing parent to
> NULL.  I spot checked all of our other usages in btrfs and we appear to
> be doing the correct thing everywhere else.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks. The initialization got lost during the
conversion in c7e118cf98c7 ("btrfs: open code rbtree search in
insert_state").
