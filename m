Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681A24E573F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbiCWRSR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 13:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCWRSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 13:18:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE17C16D
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 10:16:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5FCDD210F4;
        Wed, 23 Mar 2022 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648055804;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wn+KWGaz6ULBxFxtdEtJwiIlv3+3/IpJqEOR6EN9s2k=;
        b=Ccr77k2MA7BN3cUPWUeRuGs+o60yzYD+rAQsbrijK9UapNubAYKSMYZJS7nMgZKGoquvz1
        T+SBtXtBkTEL1UgAbgdutBVGYyg0TNpKwS9AfV0UQC9rTYKuUl4wzgDehNI2ICeEBk8c87
        CISB65OyZtLzPGd4rVsgXlzS7k7Wkn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648055804;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wn+KWGaz6ULBxFxtdEtJwiIlv3+3/IpJqEOR6EN9s2k=;
        b=Qz/NUMEbOrpX34LHzu5fZj2vlae19Haka12R73cL+rpA8h837KTXoDQOmemAjeo758mY4k
        BIs66/pRWFgXZbDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 569D3A3B92;
        Wed, 23 Mar 2022 17:16:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D241CDA7FB; Wed, 23 Mar 2022 18:12:49 +0100 (CET)
Date:   Wed, 23 Mar 2022 18:12:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: add check and repair ability for super
 num devices mismatch
Message-ID: <20220323171249.GA2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646009185.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646009185.git.wqu@suse.com>
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

On Mon, Feb 28, 2022 at 08:50:06AM +0800, Qu Wenruo wrote:
> The patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/super_num_devs
> 
> The 2nd patch contains a compressed raw image, thus it may be a little
> too large for the mail list.
> 
> This patchset will allow btrfs check to detect and repair super num devices
> mismatch.
> 
> The detect part is to iterate through chunk tree to grab the correct
> number of devices.
> This is more reliable than counting devices in fs_devices, since seed
> device is in another fs_devices.
> 
> The repair is more straightforward, just reset the value in superblock
> and commit a transaction.

As repair it should work and be safe, also it should be reasonably safe
to be part of --repair. In addition to that we may also want the rescue
subcommand as it's meant to be for such one-time fixes for specific
errors.
