Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B09D7E1F08
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjKFK7b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 05:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFK7a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 05:59:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB699B0
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 02:59:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AD5C433C8;
        Mon,  6 Nov 2023 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699268367;
        bh=Zcz8isnEaoq9DvnDd7s+Wc4LLet3BGYrAiwVdwrYkDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cI/SuAX74liNBUq15FRz3SghmO1rmjBrjTvpZuzDnNrtxo1ubog3ZiMhP74IbHdBM
         i/ArshxqqhLMmBNFaKUZ5CbFefcIyXOBXg5N6tb6ecTNqyYr7b8V5Ko5nvas9hT9Ww
         o/GiD1nJGGTEF/7yROlVtBWI2Jblc5Gcc+0dkjeH7H+OMPUA8Gy2l0vvv+D9xgkJU8
         ucj+IANIj6XSe/gPMXao5CYWxp4P1SnUicEUjV1uOmwgu4wqvV/52O8xB8hah31yg0
         jfl3kDzEtnBjMM6KP3OvWixvzp6mEFqpNptpTEZ8h6xRt5XE0AfTzzEf6D0yYwWnRf
         pKcuNGl4J6DOg==
Date:   Mon, 6 Nov 2023 11:59:22 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-postfach-erhoffen-9a247559e10d@brauner>
References: <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > They
> > all know that btrfs subvolumes are special. They will need to know that
> > btrfs subvolumes are special in the future even if they were vfsmounts.
> > They would likely end up with another kind of confusion because suddenly
> > vfsmounts have device numbers that aren't associated with the superblock
> > that vfsmount belongs to.
> 
> This looks like you are asking user space programs (especially legacy
> ones) to do special handling for btrfs, which I don't believe is the
> standard way.

I think spending time engaging this claim isn't worth it. This is just
easily falsifiable via a simple grep for btrfs in systemd, lxc, runc,
util-linux.

And yes, I'm definitely asking userspace to change behavior if they want
to retrieve additional information about btrfs subvolumes. We're
exposing a new api.

You get the same problem if you make subvolumes vfsmounts. Userspace
will have to adapt anyway. New APIs don't come for free and especially
not ones that suddenly pop 10 vfsmounts into your mountinfo during a
simple lookup operation.

> 
> > 
> > So nothing is really solved by vfsmounts either. The only thing that we
> > achieved is that we somehow accommodated that st_dev hack. And that I
> > consider nakable.
> 
> I think this is the problem.
> 
> If we keep the existing behavior, at least old programs won't complain
> and we're still POSIX compatible, but limited number of subvolumes
> (which can be more or less worked around, and is there for a while).
> 
> If we change the st_dev, firstly to what value? All the same for the
> same btrfs? Then a big behavior break.
> 
> It's really a compatibility problem, and it would take a long time to
> find a acceptable compromise, but never a sudden change.

This is a mischaracterization. And I'm repeating from my last mail,
st_dev wouldn't need to change. You can keep doing what you're doing
right now if you want to. We're talking about a new api to allow
differentiating subvolumes that is purely opt-in through statx().

> You can of course complain about the vision that one fs should report
> the same st_dev no matter what, but my counter argument is, for
> subvolume it's really a different tree for each one, and btrfs is
> combining the PV/VG/LV into one layer.
> 
> Thus either we go treat subvolumes as LVs, thus they would have
> different devices numbers from each other. (just like what we do for
> now, and still what I believe we should go)
> 
> Or we treat it as a VG, which should still a different device number
> from all the PVs. (A made-up device id, but shared between all
> subvolumes, and break up the existing behavior)
> 
> But never treating a btrfs as a PV, because that makes no sense.

Whatever this paragraph is supposed to tell me I don't get it.

You are reporting a single st_dev for every single btrfs mount right now
including bind mounts in mountinfo.

What you're asking is to make each subvolume a vfsmount and then showing
these vfsmounts in mountinfo and reporting made up device numbers for
that vfsmount. Which is a massive uapi change.
