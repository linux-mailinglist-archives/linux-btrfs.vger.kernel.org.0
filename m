Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB834D1F4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348303AbiCHRn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 12:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbiCHRn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 12:43:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE8031518
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 09:43:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C6C6210F3;
        Tue,  8 Mar 2022 17:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646761379;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jaa1xb8oFnF9ef8N4uIr1AWGNYPO4ZMoTllLPHgJ/MM=;
        b=AarsRMoj6lpxlH7aBQiK6mocaT8Upfs6hxC1cy3FBTHwTM+q0lh2PxYQ+KY8oLTo7A0bd0
        1I+/h/ItIUpcKulsfE0HtmdCGLnchiOVvHjxRIFLchmr2afdMPa4HVAxu4VTrapm4T43Lu
        bvmZh8nDqvXhUqzmRkWAkgOnGEbZWKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646761379;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jaa1xb8oFnF9ef8N4uIr1AWGNYPO4ZMoTllLPHgJ/MM=;
        b=yFEKSH3nN/s0dwb55zXdlpRBkU+4U1ST38kouCtiVzUIIUpQqE66eN0837M1Lzsg/14JEN
        0cXHtiTLoGPaDQDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4617EA3B89;
        Tue,  8 Mar 2022 17:42:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 30A87DA7DE; Tue,  8 Mar 2022 18:39:04 +0100 (CET)
Date:   Tue, 8 Mar 2022 18:39:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/7] btrfs-progs: various regression fixes
Message-ID: <20220308173903.GR12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645567860.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645567860.git.josef@toxicpanda.com>
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

On Tue, Feb 22, 2022 at 05:22:35PM -0500, Josef Bacik wrote:
> Hello,
> 
> In trying to test my new extent tree v2 patches I noticed I had regressed a few
> of these tests with my previous prep patches.  I'm not entirely sure how I
> missed this before as I generally run the tests, but there are some clear things
> that need fixing.  I've based these patches on the devel branch, with them in
> place everything passes as it should.  Thanks,
> 
> Josef
> 
> Josef Bacik (7):
>   btrfs-progs: check: fix check_global_roots_uptodate
>   btrfs-progs: fuzz-tests: use --force for --init-csum-tree
>   btrfs-progs: repair: bail if we find an unaligned extent
>   btrfs-progs: properly populate missing trees
>   btrfs-progs: don't check skip_csum_check if there's no fs_info
>   btrfs-progs: do not try to load the free space tree if it's not
>     enabled
>   btrfs-progs: inspect-tree-stats: initialize the key properly

Added to devel, thanks.
