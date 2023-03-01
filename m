Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A06A7554
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 21:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCAUcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 15:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCAUcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 15:32:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04AF474F2
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 12:31:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9074921A98;
        Wed,  1 Mar 2023 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677702714;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRRVk7FUfBqQb7VXXyef9KR4ki4f34KGClg0Jxq8vSs=;
        b=TGPIOQhoF8/Uah6Si5so9sl6oPsd+uJcRoyaLr8fIP5dECIO8mODRpyzDxz5K8NEKynlZW
        WeFCNSEODgi0vjmTu36E+kKi5mRx4/Ay/wiCJ3RCTbKqPewXeJCWgtisGQcrvrY4l2qASG
        6vhDjrns0k4sxuDQk5vbYKvrCSDNTJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677702714;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRRVk7FUfBqQb7VXXyef9KR4ki4f34KGClg0Jxq8vSs=;
        b=2zeM7lkBmQwhJb5upHRbOYaRnLSljDmmOZeXpclb8KcUQlk1dnrrar27miD1KIEJ4lGHis
        0KVma2bTfQJLWpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7442313A3E;
        Wed,  1 Mar 2023 20:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RXpqGzq2/2PfdQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 20:31:54 +0000
Date:   Wed, 1 Mar 2023 21:25:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/11] btrfs: remove unused @path inside scrub_stripe()
Message-ID: <20230301202554.GB10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1673851704.git.wqu@suse.com>
 <716c80826f14a61bf87398cf0b4b99ba846954bf.1673851704.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <716c80826f14a61bf87398cf0b4b99ba846954bf.1673851704.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 16, 2023 at 03:04:12PM +0800, Qu Wenruo wrote:
> The variable @path is no longer passed into any call sites after commit
> 18d30ab96149 ("btrfs: scrub: use scrub_simple_mirror() to handle RAID56
> data stripe scrub"), thus we can remove the variable completely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This is an independent patch, now added to misc-next, thanks.
