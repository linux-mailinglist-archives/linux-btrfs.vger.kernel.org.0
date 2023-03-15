Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261BD6BBDB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 20:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjCOT6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCOT6m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 15:58:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E5E1BE
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 12:58:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0CD1219E9;
        Wed, 15 Mar 2023 19:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678910318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rC6m+YFf/phYs/M/mzwHhQDi5hcdL5eyPkOSHFHBtaA=;
        b=DAhB1OG4EKbZ0lxj7Eg/M2KrCJ3/fKuxnP82M7WE4DmohBZR18xqUhrmXEImtm6U/ta+VM
        wIALsNqsoF7M2DRq72p0KzuhxSNsv56IkcG80NmfEsLaoVtEF+7Zelsi0XfgkHM3mSK3pj
        5uWycJKsS7BPrAiueqzRKry+pD/t5Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678910318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rC6m+YFf/phYs/M/mzwHhQDi5hcdL5eyPkOSHFHBtaA=;
        b=Z6ZpOIggCQ/1w8Uh58Hc49GJx8F2OASDjp8lyE263JOJDSePnKNNeXZt7M+pdQ5vl83qer
        XDJSSUDlerqr6XBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA08313A2F;
        Wed, 15 Mar 2023 19:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l+NxLG4jEmT8bQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Mar 2023 19:58:38 +0000
Date:   Wed, 15 Mar 2023 20:52:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: fix dio continue after short write due to
 buffer page fault
Message-ID: <20230315195231.GW10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6733f2fac24b674d9f60dc1093de30513c099629.1678212067.git.boris@bur.io>
 <20230309174050.GI10580@twin.jikos.cz>
 <20230315195255.GA27662@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315195255.GA27662@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 15, 2023 at 12:53:24PM -0700, Boris Burkov wrote:
> On Thu, Mar 09, 2023 at 06:40:50PM +0100, David Sterba wrote:
> > On Tue, Mar 07, 2023 at 12:49:30PM -0800, Boris Burkov wrote:
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > > Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
> > > Link: https://pastebin.com/3SDaH8C6
> > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > > Changelog:
> > > v3:
> > > - handle BTRFS_IOERR set on the ordered_extent in btrfs_dio_iomap_end.
> > >   If the bio fails before we loop in the submission loop and exit from
> > >   the loop early, we never submit a second bio covering the rest of the
> > >   extent range, resulting in leaking the ordered_extent, which hangs umount.
> > >   We can distinguish this from a short write in btrfs_dio_iomap_end by
> > >   checking the ordered_extent.
> > 
> > Replaced v2 in misc-next, thanks.
> 
> Embarassingly, I have now proven that this version is _still_ broken :(
> 
> TL;DR, this "fix" reintroduces the original bug Filipe was fixing in the
> first place, just a more subtle version of it.

Ok thanks, I'll remove the patch from branches.
