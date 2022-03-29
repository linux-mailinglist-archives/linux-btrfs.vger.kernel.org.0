Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704E94EB50A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiC2VIX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 17:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiC2VIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 17:08:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E1D1890EA
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 14:06:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 053E2218FF;
        Tue, 29 Mar 2022 21:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648587995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vm3ovff6pN64LmLXTllNgbPVeBr42U9C0Yil8UfjHOM=;
        b=ORWipA0s+D324GxJ+MP4lBpAA2uzh6eil5JuFLrqvwGbhExv7KevlLjRvtLSw9ge5WDpCK
        ZaH/TaLO3yLzU/UUErAjdxuERMeAqeWX68ETKFdqEn7F2dcHIWefGpgALzJCrDxiCGe2N9
        qintdeaLQ5UWSgg1aaKhHIOToFb3yR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648587995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vm3ovff6pN64LmLXTllNgbPVeBr42U9C0Yil8UfjHOM=;
        b=jI1asat4WN/b6nhsCfudCDcYEC9rWNfXDHcuDJ8wXfFDjAA5jIqAqGuVqjTzKcYWgT1sUu
        TbgQuvgVK9xC8ICw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F12BAA3B82;
        Tue, 29 Mar 2022 21:06:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74E7CDA7F3; Tue, 29 Mar 2022 23:02:37 +0200 (CEST)
Date:   Tue, 29 Mar 2022 23:02:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: check: avoid false alerts for
 --check-data-csum on RAID56
Message-ID: <20220329210237.GC2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648546873.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648546873.git.wqu@suse.com>
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

On Tue, Mar 29, 2022 at 05:44:24PM +0800, Qu Wenruo wrote:
> There is a long existing bug that btrfs-progs doesn't really support
> rebuilding its data using RAID56 P/Q.
> 
> This means any read with mirror_num > 1 for RAID56 won't work, and will
> just return the P/Q raw data directly.
> 
> The RAID56 ability in btrfs-progs is only for data write.
> 
> This will cause tons of false alerts for "btrfs check
> --check-data-csum", making it useless as an offline to verify RAID56
> data.
> 
> The proper fix will need way more code modification (btrfs-fuse supports
> that, so I believe it's possible).
> 
> But for now, let's just disable mirror_num > 1 read repair for progs.
> 
> Qu Wenruo (2):
>   btrfs-progs: avoid checking wrong RAID5/6 P/Q data
>   btrfs-progs: tests/fsck: add test case for data csum check on raid5

Added to devel with some fixups, thanks.
