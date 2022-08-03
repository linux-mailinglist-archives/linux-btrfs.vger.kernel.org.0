Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7915892D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 21:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbiHCTio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiHCTio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 15:38:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA8D5B784
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 12:38:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39B8733962;
        Wed,  3 Aug 2022 19:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659555522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJ1zRJladjzQafF6iJYVhhwyxtB6a7OA5ydkm8Z6fpc=;
        b=2wwEdOffz0IyT5bAg3bJYQj/3AHNOLga4/TEYLHV1OhtrQNusyBUIZ2yrXSSIk5fry73ud
        yMoockz4FM9tLhQdFqvWa4kPVrpKxY8VVKPObHtywf+IuU7mLvAW8OaOUDTvHhDOuBhEtR
        B4lVrXTc3nBaRxrLcrgBTeFoBji9mdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659555522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJ1zRJladjzQafF6iJYVhhwyxtB6a7OA5ydkm8Z6fpc=;
        b=Z/fry6DFlCQc46BbopJC9CFcKirGmcsYYRH3mEkmhfpbmvQVDwo9d1r6prAGulPLA9kYcz
        gyd52zsuayTHDcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 196C413AD8;
        Wed,  3 Aug 2022 19:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id epQtBcLO6mLBGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 19:38:42 +0000
Date:   Wed, 3 Aug 2022 21:33:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: check for invalid free space tree entries
Message-ID: <20220803193339.GK13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 29, 2022 at 05:08:53PM -0400, Josef Bacik wrote:
> While testing some changes to how we reclaim block groups I started
> hitting failures with my TEST_DEV.  This occurred because I had a bug
> and failed to properly remove a block groups free space tree entries.
> However this wasn't caught in testing when it happened because
> btrfs check only checks that the free space cache for the existing block
> groups is valid, it doesn't check for free space entries that don't have
> a corresponding block group.
> 
> Fix this by checking for free space entries that don't have a
> corresponding block group.  Additionally add a test image to validate
> this fix.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to devel, thanks.
