Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361834FBE11
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346845AbiDKODW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 10:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346843AbiDKODU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 10:03:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1B131DEE
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 07:01:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9C03B1F38D;
        Mon, 11 Apr 2022 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649685664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAaWsFlQgnpFiKa2ICentdlcTubkB3MJUuvPCoVAhKE=;
        b=YrQW2iQP8B8vp4EcUm3z38P0bdbQbF5Z+Q2FYtjN76/SgLwj37X0mrO4+OI61LUaE+y7Y0
        IFkSE3LhQe49Rz1hyFTg7LHaQMcLpHm0rCZfoRLGb1sasQxvuQicb6tjSaXMlF467wE1P2
        ncMP8iY+iLOG5exScWTzNsT4FGZFrz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649685664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAaWsFlQgnpFiKa2ICentdlcTubkB3MJUuvPCoVAhKE=;
        b=t/UlWD2rPd0dj6KGIIlRc/wZIbls55dbQPKRvZgElXgTqN9oEfT79f0UPr58q1FKurSfPY
        AsIQ/uLqRcSq+yDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 65242A3BA4;
        Mon, 11 Apr 2022 14:01:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B4D7DA7DA; Mon, 11 Apr 2022 15:56:59 +0200 (CEST)
Date:   Mon, 11 Apr 2022 15:56:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH] btrfs: do not sleep unnecessary on successful batch page
 allocation
Message-ID: <20220411135659.GH15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <1c7f75c138cba65d0af23ad4eda7c1bab1cc21fe.1649666810.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c7f75c138cba65d0af23ad4eda7c1bab1cc21fe.1649666810.git.naohiro.aota@wdc.com>
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

On Mon, Apr 11, 2022 at 06:02:52PM +0900, Naohiro Aota wrote:
> After commit 727fd577af04 ("btrfs: wait between incomplete batch memory
> allocations"), fstests btrfs/187 becomes incredibly slow. Before the commit
> it takes 335 seconds to run the test on 8GB ZRAM device running on QEMU.
> But, after that patch, it never finish after 4 hours.
> 
> This is because of unnecessary memalloc_retry_wait() call. If
> alloc_pages_bulk_array() successfully allocated all the requested pages, it
> is no use to call memalloc_retry_wait() to wait for retrying.
> 
> I confirmed the test run time back to 353 seconds with this patch applied.

Thanks, I've folded the fixup to the patch.
