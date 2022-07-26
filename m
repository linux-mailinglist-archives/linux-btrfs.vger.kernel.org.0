Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F904581BB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiGZVl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGZVl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 17:41:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877DA27B2E
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 14:41:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21F3534AB6;
        Tue, 26 Jul 2022 21:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658871686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqluvcMZ+BUQ+WD8XUnSPXbv6snJsVEtIcuKUMVrV9s=;
        b=tXlnsVXYIWHBvbNPhg+oGw9antB03ytk/r5PvxiDzZ9eyZGnUGfuwogRdvLmpxKMQ7d0Gl
        kWtqg10XL22sBVpAdyOdupmu5bhZ5pf+NFDyhtOxF/Uk6rzPvrAX1FjebGniZrIMonouOQ
        WdQn/kX4VmAXFbbbq5Yt/6Go//Y027E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658871686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqluvcMZ+BUQ+WD8XUnSPXbv6snJsVEtIcuKUMVrV9s=;
        b=HwJ0Iag7cSJyG4Qlj4EBVQQl/PkV+z6koYBRr95Vv9GAYaUV2H4hMfOQpcQcqvfoieZ7JO
        2M6J3igTJun3dmBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1A6F13322;
        Tue, 26 Jul 2022 21:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AhzhNYVf4GI9WQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 21:41:25 +0000
Date:   Tue, 26 Jul 2022 23:36:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     David Sterba <dsterba@suse.cz>, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: Using async discard by default with SSDs?
Message-ID: <20220726213628.GO13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
 <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 04:00:42PM -0400, Chris Murphy wrote:
> 
> 
> On Mon, Jul 25, 2022, at 3:08 PM, David Sterba wrote:
> 
> > I think it's safe to use by default, with the usual question who could
> > be affected by that negatively. The async triggers, timeouts and
> > thresholds are preset conservatively and so far there have been no
> > complaints.
> >
> > The tunables have been hidden under debug, but there are also some stats
> > (like how many bytes could be discarded in the next round), so it would
> > be good to also publish that when it's on by default.
> 
> In my testing, discard=async rather quickly submits recently freed
> metadata blocks for gc, blocks referred by the backup roots in the
> super. Is this a concern for recovery? Is there a way to exclude the
> most recent ~5 generations of metadata from gc, and could it improve
> the usefulness of backup roots for recovery?

What is quickly here? The default timeout is set to 2 minutes and that's
what I've seen when testing that on a fresh filesystem. There's some
additional logic that's adaptive and derived from the latency increase
caused by the discard, but this could be observed on some specific
delete heavy workloads.

There's no logic that would take into account generation so it could
interfere with the backup root feature, but it's been unreliable already
and there are no guarantees to keep the recently freed blocks unallocated.
I've heared some feedback that the feature should be removed or
improved, I'm personally in the "removed" camp.

The block groups eligible for discard are evaluated based on time and
size criteria so I think adding a generation is straightforward, rough
guess is to btrfs_discard_check_filter(). This affects overall
performance though, FB guys wanted faster discard for their workload so
adding delay based on generation could make it worse. They now use the
default settings, though there are tunables, and I'd like to keep
defaults working for most users. If somebody evaluates the effects of
additional generational we can change it.
