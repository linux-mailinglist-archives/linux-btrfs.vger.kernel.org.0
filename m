Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC51752E4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 02:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjGNAcp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 20:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGNAco (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 20:32:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EAF2D53
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 17:32:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC1FB220DE;
        Fri, 14 Jul 2023 00:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689294761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZT/1TGnjfaErJjcs7cRuPKF0LJkStD9SKCPUqLOXEY=;
        b=2NjD0u03V8+Si4IklzHpIhseviyMOaTtVUWo/1asdRiAB44DZsCEMgw0ABNQOTCeeyEuyZ
        tUPLYhn6gUW27zsKrUpNEg6DF5oNB0lXZHE0wF0LXDcm3qhXtRD9w5Dv5xEyHfC09BkVrk
        lMyDuUVtZCaP+KBObMWRCosC2DM/s5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689294761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZT/1TGnjfaErJjcs7cRuPKF0LJkStD9SKCPUqLOXEY=;
        b=/7XG5gb3CDKgFREYBgeANAKlnQPPmPMX2zyZOenh0Hc1eb3Yg+lfp0Twkmq2+IvNJMbh+i
        epkWMJ4tqLV5kADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA2BF138F8;
        Fri, 14 Jul 2023 00:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H5hAKKmXsGRyDwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Jul 2023 00:32:41 +0000
Date:   Fri, 14 Jul 2023 02:26:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230714002605.GD20457@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz>
 <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
 <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 08:09:16AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/7/14 06:03, David Sterba wrote:
> > On Fri, Jul 14, 2023 at 05:30:33AM +0800, Qu Wenruo wrote:
> >> On 2023/7/14 00:39, David Sterba wrote:
> >>> 		ref#0: tree block backref root 7
> >>> 	item 14 key (30572544 169 0) itemoff 15815 itemsize 33
> >>> 		extent refs 1 gen 5 flags 2
> >>> 		ref#0: tree block backref root 7
> >>> 	item 15 key (30588928 169 0) itemoff 15782 itemsize 33
> >>> 		extent refs 1 gen 5 flags 2
> >>> 		ref#0: tree block backref root 7
> >>
> >> This looks like an error in memmove_extent_buffer() which I
> >> intentionally didn't touch.
> >>
> >> Anyway I'll try rebase and more tests.
> >>
> >> Can you put your modified commits in an external branch so I can inherit
> >> all your modifications?
> >
> > First I saw the crashes with the modified patches but the report is from
> > what you sent to the mailinglist so I can eliminate error on my side.
> 
> Still a branch would help a lot, as you won't want to re-do the usual
> modification (like grammar, comments etc).

Branch ext/qu-eb-page-clanups-updated-broken at github.
