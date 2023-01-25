Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED40267BA8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjAYTRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAYTRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 14:17:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39DE1F4BC;
        Wed, 25 Jan 2023 11:17:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 905B61FF1D;
        Wed, 25 Jan 2023 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674674257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiVNmCyZLRHkwvEBsY6M7QoOnBt+R9kiGHeRNYM/1j4=;
        b=ClKNmLPBBnELa2XgyBh9b+0FZQFoGJ9JguOB3+sXJUcIsdO0ITQRnYG4dvAATjv+7miWwV
        jg9sJBfHw5X2RAzLS67TvcSW7MZXf9C8bWCzxtINgyYRSeq/tDmAu7/+ONKSIbF78+hjUH
        HVP3s2zazIBXUKPuI45oiVQFLjml1kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674674257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiVNmCyZLRHkwvEBsY6M7QoOnBt+R9kiGHeRNYM/1j4=;
        b=iXw8x1t0yNB547fOKN0+evyoVpAvwTJNivQ3GDmzVm8z5liL70uz86Ft6QN+UeWcMHIKth
        /JnYKc5qe0GS7bAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6473F1358F;
        Wed, 25 Jan 2023 19:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zdyMF1GA0WOSYwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 Jan 2023 19:17:37 +0000
Date:   Wed, 25 Jan 2023 20:11:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Tanmay Bhushan <007047221b@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: raid56: Fix stripes if vertical errors are found
Message-ID: <20230125191155.GX11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230115203215.8115-1-007047221b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115203215.8115-1-007047221b@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 15, 2023 at 09:32:15PM +0100, Tanmay Bhushan wrote:
> We take two stripe numbers if vertical errors are found.
> In case it is just a pstripe it does not matter but in
> case of raid 6 it matters a both stripes need to be fixed.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>

Added to misc-next, thanks.
