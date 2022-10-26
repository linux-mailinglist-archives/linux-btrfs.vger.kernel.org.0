Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A860E1FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiJZNVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiJZNU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 09:20:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC31B864
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 06:19:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7A2121FC8;
        Wed, 26 Oct 2022 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666790394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OEwgyQU4VcFOYW4m9iT9AJqgawrQLTU0IBmcJim+vg=;
        b=Fl935em6BcH0B9jkQaoESm3h43shOhv6JXxepgX6iO8hCx1OOQAFQp4U0G2ci+Po3jLTH4
        /IFxA49+qgka4IM+5bkrMiWpTnSZBRi4vIfkGflvVpPl56COprtiW70+bmH0s2XsbWDSjm
        OpicRN3lzT9hlnPKHXRTx6pQ3b28mwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666790394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OEwgyQU4VcFOYW4m9iT9AJqgawrQLTU0IBmcJim+vg=;
        b=0V0rZlH2Yicqhyfr2PqImXICfzODD0OAElt78dLW5FvIcNf55bkwCLdVolVdKANLfyUWLp
        eg9xrQt2nyDzaxCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDCB713A6E;
        Wed, 26 Oct 2022 13:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9UKJLfozWWMFXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 26 Oct 2022 13:19:54 +0000
Date:   Wed, 26 Oct 2022 15:19:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] btrfs: raid56: do full stripe data checksum
 verification and recovery at RMW time
Message-ID: <20221026131940.GR5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665730948.git.wqu@suse.com>
 <20221025134824.GK5824@twin.jikos.cz>
 <a9310323-f19e-258a-5dac-88a40e50ce06@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9310323-f19e-258a-5dac-88a40e50ce06@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 26, 2022 at 07:30:04AM +0800, Qu Wenruo wrote:
> On 2022/10/25 21:48, David Sterba wrote:
> > On Fri, Oct 14, 2022 at 03:17:08PM +0800, Qu Wenruo wrote:
> > So this improves reliability at the cost of a full RMW cycle, do you
> > have any numbers to compare?
> 
> That's the problem, I don't have enough physical disks to do a real
> world test.
> 
> But some basic analyze shows that, for a typical 5 disks RAID5, a full
> stripe is 256K, if using the default CRC32 the csum would be at most 256
> bytes.
> 
> Thus a csum search would at most read two leaves.
> 
> The cost should not be that huge AFAIK.

Ok, thanks, that's also a good estimate. We can ask somebody with a
sufficient setup for a real test once we have the code ready.

> > The affected workload is a cold write in
> > the middle of a stripe, following writes would likely hit the cached
> > stripe. For linear writes the cost should be amortized, for random
> > rewrites it's been always problematic regarding performance but I don't
> > know if the raid5 (or any striped profile) performance was not better in
> > some sense.
> 
> Just to mention another thing you may want to take into consideration,
> I'm doing a refactor on the RAID56 write path, to make the whole
> sub-stripe/full-stripe write path fit into a single function, and go
> submit-and-wait path.
> 
> My current plan is to get the refactor merged (mostly done, doing the
> tests now), then get the DRMW fix (would be much smaller and simpler to
> merge after the refactor).

Ok, also now is a good time for the refactoring or preparatory work.
