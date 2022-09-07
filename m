Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA25B0CD3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIGTDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGTDM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 15:03:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4909751C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 12:03:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DEDE200DC;
        Wed,  7 Sep 2022 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662577390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PSEDS3pX0NbmdT6/sKBpy6I/2lM2B+wxXnwkx3H954Y=;
        b=ffYbrBZWH0DnQy/3QfrGWXPcjJJk3Yc8SzSlhtT2+uG6kgw3t7sQuY2hieE71dpPRnNdvZ
        0qE/EVUE1zGWhVJ67fxXZBc6ImRVSNJzVJDUBS7A2z1QBq9N00o2iGVmbd5RSH+w4TZtwn
        9zr8qxL5grZ456U/n1FxnbLtT5K/eiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662577390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PSEDS3pX0NbmdT6/sKBpy6I/2lM2B+wxXnwkx3H954Y=;
        b=gLWnoGlygrIwJSerY2EtrtcDiX9TeNoOrRutJlzQruaiwopz8J2fNescGMUrWRC3oxxo+X
        EXvZ3PQK3k6GYzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2F3613A66;
        Wed,  7 Sep 2022 19:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i0ZfOu3qGGNDKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 19:03:09 +0000
Date:   Wed, 7 Sep 2022 20:57:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 09/31] btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to
 ASSERT's
Message-ID: <20220907185746.GF32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
 <4360935b03c1103514ac907f35405e1137fe5486.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4360935b03c1103514ac907f35405e1137fe5486.1662149276.git.josef@toxicpanda.com>
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

On Fri, Sep 02, 2022 at 04:16:14PM -0400, Josef Bacik wrote:
> These should be ASSERT()'s, not BUG_ON()'s.

This could explain why, the BUG_ON is a runtime check though not the
best one, while ASSERT is good to make sure that the API is used
correctly. It's from an old commit, I'm not sure if we have started
using asserts back then.
