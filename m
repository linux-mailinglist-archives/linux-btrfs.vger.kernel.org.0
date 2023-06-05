Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AB17231E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjFEVGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 17:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFEVGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 17:06:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A357ED
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 14:06:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9B552197F;
        Mon,  5 Jun 2023 21:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685999206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BF/yBblMHIKvNsgG2oewxUYdqYpZNsMDqlg5bIJpr1Y=;
        b=uhDw0wkvO1W3Volkf8riZ9Z1D2Z5pMV+PgSCyM+kGSGz9AVgX6ELQHkE9jDCel5JRN658k
        IsM3ARInPvzP3Or5+h+WNGaCkFNDi8UlmCVg1jGZ9uzIXvvYK5bhcSExHBkvoFt1hgW3Rb
        657UmSh4buE8OK/fN+346etdZ4x4N30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685999206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BF/yBblMHIKvNsgG2oewxUYdqYpZNsMDqlg5bIJpr1Y=;
        b=5QaTwDDVKRtzXdfNp4//0lH+Ox7e59sDHy2GFueuuGhRQNP4NePegRzeTZzzIeqgpDR5sM
        0C5bQuSEIK105VAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DD9D139C8;
        Mon,  5 Jun 2023 21:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gGyzJWZOfmQTFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Jun 2023 21:06:46 +0000
Date:   Mon, 5 Jun 2023 23:00:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/16] btrfs: don't redirty the locked page for
 extent_write_locked_range
Message-ID: <20230605210032.GE25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230531060505.468704-1-hch@lst.de>
 <20230531060505.468704-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531060505.468704-15-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 08:05:03AM +0200, Christoph Hellwig wrote:
> Instead of redirtying the locked page before calling
> extent_write_locked_range, just pass a locked_page argument similar to
> many other functions in the btrfs writeback code, and then exclude the
> locked page from clearing the dirty bit in extent_write_locked_range.

I'm still not convinced this is safe, the changelog should be much
longer for this kind of change. I remember some bugs with redirtying
(e.g. 1d53c9e6723022b12e4a, 4adaa611020fa6ac65b0a). The code has evolved
since so I'd like to see more than "instead of this just do that" style
of changelog.
