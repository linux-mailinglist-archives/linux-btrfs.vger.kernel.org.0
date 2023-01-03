Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9B65BFAE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 13:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbjACMMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 07:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjACMMN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 07:12:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B61005
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 04:12:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0DF166FE2;
        Tue,  3 Jan 2023 12:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672747930;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJ45+G9M6cL/4rEkiZ9Qu2hiLVm/mKCXjnEXPAlld7I=;
        b=NU8NL33Vqb///wYdVZ9zZRRz5h6m6zmKMTaxKFzSLWQX5zxzO0TjF4vBE0odws35+N9VCv
        WUEwenZf1zkA5Vzlzw82DKvodSEKCujcXvJArhEM1vf9+jweG+9J/zUygIRrBjdhP8qB5N
        54hRO+3WVRSKdyEwYTkQA2053+9aXWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672747930;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJ45+G9M6cL/4rEkiZ9Qu2hiLVm/mKCXjnEXPAlld7I=;
        b=0O4JImoz/7mU+PYN1G8DdKxj3XAqcT/YIdaw+gaPM0z7fDwtCSEG3OwB5Rb4cWLMV2aF5r
        pbvQ0kAMC/ZJCmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6A0A1392B;
        Tue,  3 Jan 2023 12:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eUekJ5obtGOxfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 03 Jan 2023 12:12:10 +0000
Date:   Tue, 3 Jan 2023 13:06:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa@fedoraproject.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: btrfs-progs 6.1 broke the build for multiple applications
Message-ID: <20230103120640.GO11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
 <20230103113941.GN11562@twin.jikos.cz>
 <22447f37-50fa-3914-a817-e95b66797944@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22447f37-50fa-3914-a817-e95b66797944@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 03, 2023 at 08:02:27PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/3 19:39, David Sterba wrote:
> > On Mon, Jan 02, 2023 at 07:11:57PM -0500, Neal Gompa wrote:
> >> Hey all,
> >>
> >> It looks like btrfs-progs v6.1 broke the build for multiple
> >> applications in Fedora.
> >>
> >> Notably, it broke:
> >>
> >> * btrfs-assistant
> >> * buildah
> >> * cri-o
> >> * podman
> >> * skopeo
> >> * containerd
> >> * moby/docker
> >> * snapper
> >> * source-to-image
> >>
> >> The bug report is here: https://bugzilla.redhat.com/2157606
> >>
> >> It looks like this change broke everything:
> >> https://github.com/kdave/btrfs-progs/commit/03451430de7cd2fad18b0f01745545758bc975a5
> > 
> > On no that's bad, I'm going to do a bugfix release today.
> 
> I'm a little confused, why would those projects relying on the ioctl.h 
> from progs?

Because they're probably using the legacy libbtrfs and headers from
/usr/bin/btrfs/*.h, it'll take time before all could be switched to
libbtrfsutil.

> Shouldn't those things got exported through kernel uapi?

The kernel UAPI reflects what the installed and possibly running kernel
API is providing, interfaces that can be used at run time. But the build
can be against any newer version even with functionality not implemented
by the kernel. Think LTS stable releases vs updated btrfs-progs.
