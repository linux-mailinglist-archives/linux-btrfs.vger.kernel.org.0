Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984B94F9F11
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiDHVWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiDHVWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 17:22:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4365326029
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 14:20:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8630121602;
        Fri,  8 Apr 2022 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649452839;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlWItPisi+AvauT/ZM7GihtEWdhB8OcaKRO7h94dwqo=;
        b=JsGeqgfiYaFLu174kUKSLLfRuJJj1UPAJ8fmEBj0Olg+AY+Yucy91LT2wwK7s5upJUiaJj
        vd5EzwCnhmwEF3WHvJhMUqC6oP/bRfZVaZQfCXemxW2lM7jb+rr0/kQOA36K8x1hkKzS2E
        gNACrkCAVae5FTnS3Vxg/ECMTlCdQyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649452839;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlWItPisi+AvauT/ZM7GihtEWdhB8OcaKRO7h94dwqo=;
        b=/LLYTsRk3VqGf5oKH3a2duysjn6BCdjf8sIN8UxGZQzBl3BnlAr5jLdjhLfqLuqvdzLqr8
        Wtf06YSdrtbRq3Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E223A3B82;
        Fri,  8 Apr 2022 21:20:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 920CDDA7FB; Fri,  8 Apr 2022 23:16:36 +0200 (CEST)
Date:   Fri, 8 Apr 2022 23:16:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs-progs: add RAID56 rebuild ability at read time
Message-ID: <20220408211636.GE15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649162174.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
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

On Tue, Apr 05, 2022 at 08:48:22PM +0800, Qu Wenruo wrote:
> This branch can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/raid56_rebuild
> 
> Please note that, the last time I check devel branch, the RAID56 warning
> patch is not yet merged.

It was there but I had not the branch pushed.

> So this is based on the latest devel branch from github.
> 
> And since we're adding proper RAID56 repair ability, there is no need
> for the patchset "btrfs-progs: check: avoid false alerts for --check-data-csum on RAID56"

OK so I'll replace it with this patchset.
