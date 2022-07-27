Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F450583342
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiG0TNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiG0TNd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 15:13:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E75F9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 11:58:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0928B20CBA;
        Wed, 27 Jul 2022 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658948321;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9Cp5MT/agwr3Oa/qoMLjAhWWxsqClgp8kO0B96tQMo=;
        b=Wci4Vri2Mqnmb15dU9P8pU1oKBihYJRv2AVoXL3JmS65wD5ViVLvTPj0xSoGVl3fmLoIZ/
        wszcUJcc0yJ3iuZgt9nvDI+VJ3ZKOCaNnlDFtXjEnbsv3Ogfbr9M7n/VTF2Dpgv+XIOyRW
        8dX5XVdiYFsLd1XvzMRKakPQ84y6MFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658948321;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9Cp5MT/agwr3Oa/qoMLjAhWWxsqClgp8kO0B96tQMo=;
        b=vl8Y+/Pz9WI61Gxf6KYqjPbsi/qVuMLrJw1oLT3YfT2H7DzYVdxoS8XC5rvguWjGuVWl3f
        Q1mp8KrHNUS/iUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD2B113A8E;
        Wed, 27 Jul 2022 18:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gx/FNOCK4WL9PgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Jul 2022 18:58:40 +0000
Date:   Wed, 27 Jul 2022 20:53:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/4] btrfs-progs: support for fs-verity fstests
Message-ID: <20220727185342.GV13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1658867979.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658867979.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 01:43:21PM -0700, Boris Burkov wrote:
> Adding fstests for fs-verity on btrfs needs some light support from
> btrfs-progs. Specifically, it needs additional device corruption
> features to test corruption detection, and it needs the RO COMPAT flag.
> 
> The first patch defines (u64)-1 as "UNSET_U64"

I've dropped the patch, we've been using (u64)-1 everywhere so it's
basically the coding style.

> The second patch adds corrupting arbitrary regions of item data with -I.

The corrupt-block options are a mess I've dropped the short options (in
a separate patch).

> The third patch adds corrupting holes and prealloc in extent data.
> The fourth patch includes BTRFS_FEATURE_RO_COMPAT_VERITY to ctree.h

Added to devel, thanks.
