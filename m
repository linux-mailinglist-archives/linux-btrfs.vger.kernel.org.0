Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9916F5B0CE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 21:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIGTId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiIGTI3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 15:08:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32490820
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 12:08:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BD38205DF;
        Wed,  7 Sep 2022 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662577707;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsr69OFjMz03pS8BR2nm8cun/hAgAA9CQ90CyiRgsx8=;
        b=r/JpWqRD5NhM2T/ZZpvvW+i5DKKNRvQElNO0J7Soe1RFkThrxp3wnE2KzS3vFac0hQbJnC
        Wk2lrhJwc/u6pviRgDQvTiEmdLNmOmY3IFfPwwqgMDp1wPxM/0zVakOpt6MgVbKwxhZU+Z
        x5QNy5bJ7fUZ4rG7+O7ojzz/4NaLBfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662577707;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsr69OFjMz03pS8BR2nm8cun/hAgAA9CQ90CyiRgsx8=;
        b=G7ZVziVwYnISKzIJRi9B8ZArqIShUZHaMNUbabi98b5rBV8RRbTXvZA/3yrb+cljLrCrx3
        lrafKzMwa68KoEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E5E013A66;
        Wed,  7 Sep 2022 19:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id whxLDivsGGPTKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 19:08:27 +0000
Date:   Wed, 7 Sep 2022 21:03:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/31] btrfs: move the core extent_io_tree code into
 extent-io-tree.c
Message-ID: <20220907190303.GG32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
 <c534c12c1dcf0821971b8918abced08aafd27055.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c534c12c1dcf0821971b8918abced08aafd27055.1662149276.git.josef@toxicpanda.com>
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

On Fri, Sep 02, 2022 at 04:16:17PM -0400, Josef Bacik wrote:
> This is a big patch unfortunately, all of this code is tightly coupled
> together.  There is no code change at all, it is simply cut and paste
> from extent_io.c into extent-io-tree.c.

Doing it cleanly one by one would require temporary exports, move,
unexport again. I understand doing it in one go but it's still 1600
lines of diff, hard to do review, but let's see.
