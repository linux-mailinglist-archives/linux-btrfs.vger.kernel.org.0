Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB885B0CB8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIGSxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGSxI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 14:53:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B1979D5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 11:53:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AA1834051;
        Wed,  7 Sep 2022 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662576785;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dO4YH3zKZ+VX6llZKlEo/vPRCqSX2Ao7H/Iw2b6fGYI=;
        b=l0M94wH6E600lbXa/YqZT4QumUD8P/9tSIbIar1M4u3/0xZiMMDGVNO/A1Qc3CUkxt8JMR
        uzHGHfQHpcWsI+8igChHC1R2KTeyWfq6miRa+kT/jsCWXHAr+rrDo0Z9R+c5FjvXfGkmfB
        FihXjX4NdaXN1lP1KF8YfgnumD38hyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662576785;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dO4YH3zKZ+VX6llZKlEo/vPRCqSX2Ao7H/Iw2b6fGYI=;
        b=5ap3HtZieAGDWYfVYjSKC13mLn9a7qXAv8oWRLqr/vnfk4F1zCn+yY/8WPrP3qld4ht/GI
        5tR2N350qu9U3GDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D8BF13486;
        Wed,  7 Sep 2022 18:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qu4+CpHoGGM2JQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 18:53:05 +0000
Date:   Wed, 7 Sep 2022 20:47:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 26/31] btrfs: get rid of track_uptodate
Message-ID: <20220907184741.GB32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
 <e6f0ab425f44e63a22cb1c469b754292a91bf160.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f0ab425f44e63a22cb1c469b754292a91bf160.1662149276.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 04:16:31PM -0400, Josef Bacik wrote:
> This is no longer used anymore, remove it from the extent_io_tree.

This should mention the last commit that removed the functionality, I
think it's in this series so referenced by the the subject. Also if it's
a struct member removal should say from which it's being removed, ie.
extent_io_tree::track_uptodate.
