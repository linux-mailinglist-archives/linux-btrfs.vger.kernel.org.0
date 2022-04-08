Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805914F9E29
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiDHUbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiDHUbD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 16:31:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C5E1D97DF
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 13:28:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D270B1F861;
        Fri,  8 Apr 2022 20:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649449736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4tLVDhO+QVgM+zgXP9PJB6hLIEFM9hIv9r7qXuJod8=;
        b=X/8eFOGUw0+3oR4/nAqp0QI2cPr3NVigcd1+pRSZRUedkFQMdiBJNTKCFp9wtzO2Xi3Jam
        pI0Ne53EEBB+FUfWNeu7rMNl3g5++p4naspw2FVtwFgh0H3Vy3NiC+yMiLM1iccX7rt0ts
        eMQxWjmVplNEAX66zF/rvfZuhsspt0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649449736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4tLVDhO+QVgM+zgXP9PJB6hLIEFM9hIv9r7qXuJod8=;
        b=YJMnRHdzLBw1fdw86PAkvE548/bzaLk2y38tWqJw6Ny0JYmVqKAwrmTpdCRWALvvii3HBH
        7BJs61VyhkGW50AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A2FDDA3B83;
        Fri,  8 Apr 2022 20:28:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B62FCDA823; Fri,  8 Apr 2022 22:24:53 +0200 (CEST)
Date:   Fri, 8 Apr 2022 22:24:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: zoned: fix mkfs failure on various zone
 size
Message-ID: <20220408202453.GD15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220406014313.993961-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406014313.993961-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 10:43:09AM +0900, Naohiro Aota wrote:
> There are mkfs.btrfs failures on various zone sizes. For example, with 32
> MB zone size, mkfs.btrfs creates the initial system block group at 64 MB,
> which collides with the regular superblock location. This series addresses
> the issues.
> 
> Patches 1 and 2 fix the location of the initial system block group when the
> zone size is 32 MB.
> 
> Patch 3 fixes the location of the initial data block group when the zone
> size is 16 MB.
> 
> Patch 4 fixes a bug revealed by patch 3.
> 
> Naohiro Aota (4):
>   btrfs-progs: zoned: export sb_zone_number() and related constants
>   btrfs-progs: zoned: fix initial system BG location
>   btrfs-progs: fix ordering of hole_size setting and
>     dev_extent_hole_check()
>   btrfs-progs: zoned: fix and simplify dev_extent_hole_check_zoned()

Added to devel, thanks.
