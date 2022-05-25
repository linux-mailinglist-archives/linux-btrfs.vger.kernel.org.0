Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA9533F8D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiEYOuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiEYOt7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 10:49:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF809AB0FC
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 07:49:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A09C71F924;
        Wed, 25 May 2022 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653490197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIspBw1Jm9f2zOUz867VfANHy1sADJVdtY+udpYbDtc=;
        b=ePtW5yDUPueIGEh6pzO1QtQrAirbJtzrAOZyuAPOhhFwKdTUDq5mdJdwO0IQaCP3RANp6A
        pfJCV+UfMHtg3Ij+rK0152MLuDH6xg5rzrlNBev1Htj1EiYIE7Mx1waIpv7ooij9dJ0bin
        mAQ0LCoJZKDazGtufCi7vpEDsvR6mPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653490197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIspBw1Jm9f2zOUz867VfANHy1sADJVdtY+udpYbDtc=;
        b=v0kewFc5BLPPx10Otf9KWzjKyoqRGmmSZ55yP7rVKu3wFoNo7j1N6qLdDcU+Ur5SdypdIA
        w7VtTGIA/oeggqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8299313ADF;
        Wed, 25 May 2022 14:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a/jgHhVCjmLsdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 May 2022 14:49:57 +0000
Date:   Wed, 25 May 2022 16:45:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: prevent remounting to v1 space cache for
 subpage mount
Message-ID: <20220525144535.GC22722@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <141ea1f29543c7eccabc3899f34b691a13841a5a.1652850165.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141ea1f29543c7eccabc3899f34b691a13841a5a.1652850165.git.wqu@suse.com>
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

On Wed, May 18, 2022 at 01:03:09PM +0800, Qu Wenruo wrote:
> Upstream commit 9f73f1aef98b ("btrfs: force v2 space cache usage for
> subpage mount") forces subpage mount to use v2 cache, to avoid
> deprecated v1 cache which doesn't support subpage properly.
> 
> But there is a loophole that user can still remount to v1 cache.
> 
> The existing check will only give users a warning, but not really
> prevents the users to do the remount.
> 
> Although remounting to v1 will not cause any problems since the v1 cache
> will always be marked invalid when mounted with a different page size,
> it's still better to prevent v1 cache at all for subpage mounts.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
