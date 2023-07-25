Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10236761E42
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGYQSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjGYQR7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 12:17:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA32132;
        Tue, 25 Jul 2023 09:17:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70F1C21A5D;
        Tue, 25 Jul 2023 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690301867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJ1pF6dtJMkYLjA9EXsmiDrip9+xiC4QIKK0a7ZzcWI=;
        b=IDXHqoBL+fWDRrK4ZmXx0WQZqKZwuRyNF+1oCBGrOAOxB+DTrRKIv+MANTIfrXuSozTifF
        d1FByKK52ic6HfhIZWnvrDw7NVtrY3kviTe5FNa3/f+v4xl8ubb4os25OS//6UsvPY9MN8
        rM6M+jjknZNIM8+BQpeyHg2pd/0n2kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690301867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJ1pF6dtJMkYLjA9EXsmiDrip9+xiC4QIKK0a7ZzcWI=;
        b=K7CN3Q9H2IwEOKzbYDPiKkUt3glrgr2SoNXN31LWB+U/M0UppYhhj8PlwSr0eIP5jIeIUo
        BCJjBXCRE35K6UAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D8F813487;
        Tue, 25 Jul 2023 16:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qr/0Dav1v2SNPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Jul 2023 16:17:47 +0000
Date:   Tue, 25 Jul 2023 18:11:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Message-ID: <20230725161103.GH20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724030423.92390-1-wqu@suse.com>
 <ZL6Ga9zRjBmAEmA/@infradead.org>
 <olqvt73droizibdx445my4uekl7gmcmlpkhn6e4oedk3gnmikf@pfpwcncjnxn7>
 <f0695163-d613-52e3-3443-2921dc2153c3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0695163-d613-52e3-3443-2921dc2153c3@suse.com>
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

On Tue, Jul 25, 2023 at 08:58:34AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/7/25 08:22, Naohiro Aota wrote:
> > On Mon, Jul 24, 2023 at 07:10:51AM -0700, Christoph Hellwig wrote:
> >> On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> >>> The test case itself is utilizing RAID5/6, which is not yet supported on
> >>> zoned device.
> >>>
> >>> In the future we would use raid-stripe-tree (RST) feature, but for now
> >>> just reject zoned devices completely.
> >>>
> >>> And since we're here, also update the _fixed_by_kernel_commit lines, as
> >>> the proper fix is already merged upstream.
> >>
> >> Hmm, instead of spreading these checks, shouldn't we check that the
> >> RAID level is supported, and have one single nob for that based off
> >> it, similar to _btrfs_get_profile_configs()?
> >>
> > 
> > That's beneficial. We need to declare which profile the test going to use,
> > something like this?
> > 
> >    _btrfs_require_profile raid5 raid6
> > 
> > or
> > 
> >    _btrfs_require_profile data:dup
> > 
> > as the zoned mode cannot work with the DUP profile for data.
> 
> The latter one sounds good, considering zoned support differs for data 
> and metadata profiles.
> 
> Another thing is, do we have any sysfs files to indicate what profiles 
> we support?
> For now we only have a "zoned" features, but no dedicated zoned specific 
> sysfs files.
> 
> Would that be a good thing to consider?

We don't have it but I think it's a good idea not just for testing, we
export other information as the "features/supported_..." files. The
profiles don't change often but with the incremental support for zoned
this would make it easier for tests to keep up.
