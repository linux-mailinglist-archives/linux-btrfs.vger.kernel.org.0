Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC9625EFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 17:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiKKQAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 11:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiKKQAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 11:00:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779C3E09D
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 08:00:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B548020209;
        Fri, 11 Nov 2022 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668182451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7fOy8zEUT6wlAFtaSJZJsgbr14+rrPBu/qeRzcnesVU=;
        b=MCv3Zy4s5EA2UBerqSRsqspKxQFVjOnyDuj4s4vdHxVuxco87M9KW+6KmJqRoRxXqjAiss
        pVjjzLZFXdoIE14nVPEC0GpktnNsWt412KwrZVdNvj9HKAF2rRcWQJivux0gZD6wxbfgVf
        Fqus1NfoZUR43cf1bFHfx0f7VFXTFxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668182451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7fOy8zEUT6wlAFtaSJZJsgbr14+rrPBu/qeRzcnesVU=;
        b=qQ2VMKSYycY/CH84uhIBGX0K+/GvofJQebjGJ3MdpeCX/XJ8d5eqi6W8ZIC4OlapajuNJI
        WKpATEW4xJhWpDAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92F2513273;
        Fri, 11 Nov 2022 16:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N/jaIrNxbmPYRAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 16:00:51 +0000
Date:   Fri, 11 Nov 2022 17:00:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: btrfstune: add -B option to convert back to
 extent tree
Message-ID: <20221111160027.GS5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <18c52a4ae1bb038beb16ad6d011d6dbe10321922.1663917740.git.wqu@suse.com>
 <20220923103945.GQ32411@twin.jikos.cz>
 <5f23506e-a505-0a37-5ceb-c55a02b114ed@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f23506e-a505-0a37-5ceb-c55a02b114ed@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 07:56:55PM +0800, Qu Wenruo wrote:
> On 2022/9/23 18:39, David Sterba wrote:
> > On Fri, Sep 23, 2022 at 03:22:44PM +0800, Qu Wenruo wrote:

> Finally we're going to integrate btrfstune into the main program.
> 
> Personally speaking, I have no preference between long and short option,
> so it would work for me either way.
> 
> But I really want bi-directional conversion, not only for the bg tree
> feature, but also things like no-hole/skinny things.
> 
> Thus what about "btrfs tune/convert feature 1/0"?
> 
> And of course, we should give warning/error if one is turning off some
> default feature.

This will happen incrementally and as experimental command first, basic
idea is to add 'btrfs tune' with subcommands convert, analyze, enable,
disble.  Parameters will be describing features according to the
semantics of the subcommands. A 1:1 option compatibility won't be
possible due to the split, the standalone command will work for some
time like usual.
