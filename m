Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A234C501A95
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiDNR6L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 13:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiDNR54 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 13:57:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF313EBAD2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 10:55:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 737C41F747;
        Thu, 14 Apr 2022 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649958929;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6XG4eFrqjato0R4wP7P/l0ALnxB176CUzIFok4ed1M=;
        b=VZ1+5QIdCfoxqfXTwqkoHLiUd3W/yutik43zH7bRs3zoo7sa/FwX2rNlMPMFk1G9NPqWt/
        MQctyeW7dJPZofpn/hvC/RYJkIBxD4SK1TiPpcHhJ+qPcR3vVtxZV1kMDndKT+klzjpYAG
        Pil0KYhKmtecMZtTc6209xLXmbNqUIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649958929;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6XG4eFrqjato0R4wP7P/l0ALnxB176CUzIFok4ed1M=;
        b=e2wQYxmXK9gikWtqidM7BPojR/ayuCk0dNYbaIv8Cq/xvhWUFFadSlwg09okpFrUGkOCYj
        6g9h5rxPoWotpCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55C48132C0;
        Thu, 14 Apr 2022 17:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HWc7FBFgWGIYJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Apr 2022 17:55:29 +0000
Date:   Thu, 14 Apr 2022 19:51:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
Message-ID: <20220414175122.GR15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
 <20220413191456.GN15609@twin.jikos.cz>
 <5b296828-65fb-b684-dedc-6f018e5ece4e@gmx.com>
 <5b190bf5-892c-0856-e623-f6f716985b28@gmx.com>
 <20220414154341.GP15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414154341.GP15609@twin.jikos.cz>
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

On Thu, Apr 14, 2022 at 05:43:42PM +0200, David Sterba wrote:
> On Thu, Apr 14, 2022 at 08:43:45AM +0800, Qu Wenruo wrote:
> > > Failed to reproduce here, both x86_64 and aarch64 survived over 64 loops
> > > of btrfs/023.
> > > 
> > > Although that's withy my github branch. Let me check the current branch
> > > to see what's wrong.
> > 
> > It's a rebase error.
> > 
> > At least one patch has incorrect diff snippet.
> 
> Ok, my bad, I did not do a finall diff check, I'll update the patchset.

I should have done that, there are way more code changes that I missed
when going through the patch difference manually. I'll try to port it
again but uh.
