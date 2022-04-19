Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C0A507A2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 21:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355789AbiDST0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiDST0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 15:26:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A161263E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 12:23:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BA101F746;
        Tue, 19 Apr 2022 19:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650396228;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZQdd1Bg7uoxQbkmCxWJEKBSg79ZMzv1S4JBuzOX8HUQ=;
        b=mPUK/iR7i/Wz2gSpZJB462Rguorg/VPqZWWf8oAygCxBNAGE29Uik5kfGXK0XiEuM664Xd
        IkfsByVQTTqn86XO42+vbJ6UX1GXlEr7ndNOavDJFxd2uWetmN08LQ5KkYNAoDCE4NLiN2
        LMTIwSugenwRSbJcmLAQdOanbP5En+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650396228;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZQdd1Bg7uoxQbkmCxWJEKBSg79ZMzv1S4JBuzOX8HUQ=;
        b=1jL/lHxnTB9101s71gnWZNgTZz94Xu7rV1SvwSObj4wDHvG4Fuxbzq4HJ2aGZSIkkIogjq
        z3UEPHPAKa5AY/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FFB4132E7;
        Tue, 19 Apr 2022 19:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fCoDCkQMX2KHEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 19:23:48 +0000
Date:   Tue, 19 Apr 2022 21:19:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] btrfs: make read repair work in synchronous mode
Message-ID: <20220419191944.GI2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648201268.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648201268.git.wqu@suse.com>
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

On Fri, Mar 25, 2022 at 05:42:47PM +0800, Qu Wenruo wrote:
> The first patch is just a preparation for the 2nd patch, which is also
> the core.
> 
> It will make repair_one_sector() to wait for the read from other copies
> finish, before returning.
> 
> This will make the code easier to read, but huge drop in concurrency and
> performance for read-repair.
> 
> My only justification is read-repair should be a cold path, and we may
> be able to afford the change.
> 
> Qu Wenruo (2):
>   btrfs: introduce a pure data checksum checking helper
>   btrfs: do data read repair in synchronous mode

After reading the discussion, is it right that you're going to implement
the repair in another way?
