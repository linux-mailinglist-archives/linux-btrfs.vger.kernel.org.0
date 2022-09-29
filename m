Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98615EF3A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiI2Knl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiI2Knk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 06:43:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A510F8FB1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Sep 2022 03:43:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F2B321E3D;
        Thu, 29 Sep 2022 10:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664448218;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZgM9GB9ihhQxSJ9Ua082q5BYBBQ3dP3zxjZQYysQLxg=;
        b=zyn3MDRXQcKLxPiFeN9MBosyDgA3iphFluTYJFNVSGmoFpgqmWs378HL6wHSfizMrVcvg9
        A77b78XlWoIhsTqlQF/fbuWzP1LjF1r+AWRxAFSYuKCaGh714kklTt4Rls5iuxu4k6AGcv
        ZZ0dCNplYEwRwj2IcOslxOMyKcPixMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664448218;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZgM9GB9ihhQxSJ9Ua082q5BYBBQ3dP3zxjZQYysQLxg=;
        b=cPICocpKZOVDtKnBzh46/eXnR2quPhtdnKrmEYfq5vaF7gY5xQxl2F7qOLmyWmoGMmJapD
        xhHFczk5vg4ViTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEDC013A71;
        Thu, 29 Sep 2022 10:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pdpxNdl2NWP1WQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Sep 2022 10:43:37 +0000
Date:   Thu, 29 Sep 2022 12:38:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mariusz Mazur <mariusz.g.mazur@gmail.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: Is scrubbing md-aware in any way?
Message-ID: <20220929103802.GF13389@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
 <20220914142738.GN32411@twin.jikos.cz>
 <CAEg-Je-vB+UgU2uDspdN8P+aG+JQP1h-7hx34siy6FasgJ=e3w@mail.gmail.com>
 <CAGzuT_1_NWtqtZhC83xsW9L3NXwz02v_PdaABpuJ-OheqZ6drQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGzuT_1_NWtqtZhC83xsW9L3NXwz02v_PdaABpuJ-OheqZ6drQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 26, 2022 at 05:36:04PM +0200, Mariusz Mazur wrote:
> niedz., 25 wrz 2022 o 20:46 Neal Gompa <ngompa13@gmail.com> napisał(a):
> >
> > On Wed, Sep 14, 2022 at 10:37 AM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 04:15:26PM +0200, Mariusz Mazur wrote:
> > > > Hi, it's my understanding that when running a scrub on a btrfs raid,
> > > > if data corruption is detected, the process will check copies on other
> > > > devices and heal the data if possible.
> > > >
> > > > Is any of that functionality available when running on top of an md
> > > > raid?
> > >
> > > No, the type of block device under btrfs is considered the same in all
> > > cases, except zoned devices, so any advanced information exchange or
> > > control like devices reporting bad sectors or btrfs asking to repair the
> > > underlying device by its own means.
> > >
> > > > When a scrub notices an issue, does it have any mechanism of
> > > > telling md "hey, there's a problem with these sectors" and working
> > > > with it to do something about that or is it all up to the admin to
> > > > deal with the "file corrupted" message?
> > >
> > > It's up to the admin. I've looked if there's some API outside of the
> > > md-raid implementation, but there's none so it would have to be created
> > > first in for the btrfs <-> md cooperation.
> >
> > IIRC, the Synology folks created such an API for their own use-case.
> > Does anyone on-list know the folks at Synology to see if they'd be
> > interested in working with us and the md folks to make this fully
> > supported upstream?
> 
> Yes, wondering how synology uses btrfs on top of md raid effectively
> is what prompted my question. I'd like to be able to use btrfs (and
> other filesystems) in such a fashion as well.

IIRC the synology kernel sources are available as some .tar or .rpm
file, I don't know if there are the separate patches available anywhere.
Also it's up to synology ty upstream the patches. We've got some btrfs
patches from them that were good, but adding the MD API itself seems to
be an extensive change and harder to get accepted upstream. I haven't
seen the code so I can't say how much it would be intrusive to the btrfs
code but with enough cleanups and abstractions everything is possible.
