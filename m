Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40C757B31
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGRMFl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jul 2023 08:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGRMFh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jul 2023 08:05:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9011732
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 05:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 991641FD9E;
        Tue, 18 Jul 2023 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689681909;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kg0n5q5oV0/DtP1XeUIiZp2gAwsTmhYRDH/rNPzPVo4=;
        b=TxSGIGyvMShVsJuXVHoGX93SKf4dWgsZkXWusGpuSnwvDwJcd7C6cN/6HgYGJxZ+7BdoRu
        sosqR4A3Tv/exWyGeVemw0MEWM55MmCNLxXspDQvZioz1F2PWz9XR2nVJrdZvaMGNLRw1P
        UIyYuaR9sqzJfC2+7ojeD2ujk5oEJrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689681909;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kg0n5q5oV0/DtP1XeUIiZp2gAwsTmhYRDH/rNPzPVo4=;
        b=pxAhSYS9haRRZbGRtUo/FXj7AYSdZBJg7JC/3H5q/LrAZ3KXv3Zq8VfZSo7pxiEXq95yRz
        u/JV8vMeQtEUM1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77A10134B0;
        Tue, 18 Jul 2023 12:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ySUQHPV/tmQGOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Jul 2023 12:05:09 +0000
Date:   Tue, 18 Jul 2023 13:58:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [ANNOUNCE] New GitHub CI workflow
Message-ID: <20230718115830.GO20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230717185715.GA757715@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717185715.GA757715@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 17, 2023 at 02:57:15PM -0400, Josef Bacik wrote:
> Hello,
> 
> For the last few years we've been relying on my nightly tests to catch any
> regressions we have in our development tree.  The results have been crudely
> dumped to http://toxicpanda.com and http://toxicpanda.com/performance/.  This is
> a bunch of VM's on a Intel NUC with cronjobs and chewing gum holding it all
> together.  It has worked pretty well, but it is beginning to show it's age, as
> the overnight runs literally take all night, starting around 8PM my time and
> finishing 1:30PM my time.
> 
> I've upgraded my hardware and re-built the VM setup.  The old setup will
> continue so we have a nice baseline of what's going on, but the new setup will
> be triggered with GitHub Actions.
> 
> # tl;dr
> 
> If you are a btrfs developer and are in the https://github.com/btrfs
> organization, you can now submit PR's against the "ci" branch in the "linux"
> repo.  This will trigger a full fstests run using my VM's, which currently test
> 7 different configurations, 5 on x86 and 2 on ARM64.  Zoned will be added
> shortly, I've just been fighting with the thing to get this far so that part is
> still in the pipeline.
> 
> It is highly encouraged that if you've got a decently involved patchset that you
> take advantage of this system to pre-check your code, either before submitting
> it to the list for review or in parallel.

I would recommend to use the CI in addition to any local tests, this
should not be a substitute. All of us have a different configurations of
VMs, machines or .config and this has proven to be very useful. 

> # OMFG GITHUB!?!?
> 
> Yes, I'm nothing if not lazy, and honestly it took me about a week to work out
> all the kinks in this particular system.  We're already on GH, we already have a
> lot of processes around using our existing GH org, so I did this with GitHub
> actions.  I have 0 interest in debating this particular choice.  If you aren't a
> core developer you aren't my target audience.  If you don't want to use the CI
> you don't have to, this is simply a convenience offered to those of us who do
> this for our job.

The GH actions and configuration are partially files tracked in git,
partially doen only on the web (permissions, integration with other
services), it would be good to have it documented somewhere. I put notes
to changelogs when enabling something etc, or we can have a separate
document that enumerates what needs to be clicked and where. I'm not
expecting GH to disappear anytime soon. From past experience the
travis-ci hosted CI for btrfs-progs became unusuable and none of the
scripts could have been used directly but at least it documented which
tests were run, what packages are needed to install etc. Such changes
happen rarely but it is useful to start with something than to spend an
extra week figuring everything out again.
