Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5A6D6CF7
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjDDTIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjDDTIp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 15:08:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7035F30C1
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 12:08:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso20705168wmo.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680635322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dte3PLoaekN6yboFgvAZ/nexHtXmErJtCxx7V5tDStk=;
        b=i4jeMEYlpBVHQp2baLYoRIWNGiFabFkM+VNGuXT2EGJYOFoS3rfGYglVf8eh9oM3Lt
         qjs7GV62fyUXfI56mXnkT0HGV1pc+1J19GkSZB2kBs/gQtiLkITkisWMCFObAeFqXa2Z
         pWMsfosRU9QEFuw+O6vksQYzXHndrn7hjh0dCrRJCXT7ZAUuDmzpWDsF8DAYE91otFFm
         2PoznVWZWdn9+jzot6arcd6JAJkf/S6/lXHpxtlyGbvsBtheCUfUHbHDvu7Nf8O2wWxR
         Ctq2A1+yAnzD1O+KzlGmY4vQogAON7YCkVSyeYiniwFZSL905fPG3QU+watbKh4l5NaP
         JRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680635322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dte3PLoaekN6yboFgvAZ/nexHtXmErJtCxx7V5tDStk=;
        b=2nZSHSFYTvSxIGDjz8ojYmsWuIw2Fw9DjJE6DRXE0o0PtJ4iZAHVTVOW5jWhSbRwsE
         WMDnqhlOm0O/n3cIg1/ywBFtWHq1cfgitWOrJKaefB/CraRHa9bG605alOew+j21TBpX
         FaS0vG5uHjGrexoYuQwgTrvP+JIaL5QJ8iMuEZG5xh/PNXdHgf8hKKc28NzAdG9vKm7I
         nwFjCW4fY1xvkz2Hl91n42yCBHWJHPmNzmKEiCLyujJAUR2dkHD5YL2QgMzlevlnNXGj
         0kfHtUtYmc6cBRNJ/+EvMe17f8Qnza7D76GKg9aZFh9hAYyUACOkJSC4BGdovyr45z52
         bcIg==
X-Gm-Message-State: AAQBX9fyONwzzjGiFoTOPVZkfvN9Znn+EQefdlQHBEVsxqiK9gASXC8a
        OzwMOpeIBsana3EUZyY27L7sQU2D+aFlfw==
X-Google-Smtp-Source: AKy350bBo7HCgGwR4zLM82GIbzKZ1UNozFmZ6slv9ZIlI2zcqnn+TemNrfwicc03eHk+/mVJyL5XOA==
X-Received: by 2002:a7b:cb87:0:b0:3db:8de:6993 with SMTP id m7-20020a7bcb87000000b003db08de6993mr204386wmi.4.1680635321592;
        Tue, 04 Apr 2023 12:08:41 -0700 (PDT)
Received: from nz (host81-147-8-96.range81-147.btcentralplus.com. [81.147.8.96])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003ef6708bc1esm23628306wmq.43.2023.04.04.12.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:08:41 -0700 (PDT)
Date:   Tue, 4 Apr 2023 20:08:39 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230404200839.3b466780@nz>
In-Reply-To: <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
        <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
        <ZBq+ktWm2gZR/sgq@infradead.org>
        <20230323222606.20d10de2@nz>
        <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
        <ZCxKc5ZzP3Np71IC@infradead.org>
        <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 4 Apr 2023 14:15:38 -0400
Chris Mason <clm@meta.com> wrote:

> On 4/4/23 12:04 PM, Christoph Hellwig wrote:
> > On Tue, Apr 04, 2023 at 12:49:40PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:  
> >>>> And that jut NVMe, the still shipping SATA SSDs are another different
> >>>> story.  Not helped by the fact that we don't even support ranged
> >>>> discards for them in Linux.  
> >>
> >> Thx for your comments Christoph. Quick question, just to be sure I
> >> understand things properly:
> >>
> >> I assume on some of those problematic devices these discard storms will
> >> lead to a performance regression?  
> 
> I'm searching through the various threads, but I don't think I've seen
> the discard storm quantified?
> 
> Boris sent me this:
> https://lore.kernel.org/linux-btrfs/ZCxP%2Fll7YjPdb9Ou@infradead.org/T/#m65851e5b8b0caa5320d2b7e322805dd200686f01
> 
> Which seems to match the 10 discards per second setting?  We should be
> doing more of a dribble than a storm, so I'd like to understand if this
> is a separate bug that should be fixed.

I called it a storm based on the following LED behaviour:

    https://trofi.github.io/posts.data/281-a-signal-from-the-stars/01-shimmer.gif

It's not a saturated device (as you can see the flashes on and off). But
it's not idle either. "storm" was an exaggeration. Note that it takes
linux 3-4 days to go through a backlog of 300GB of deleted files.

Is 3-4 days expected? Or my setup is somehow unusual? Maybe
`compress=zstd` makes things disproportionally problematic?

> > Probably.
> >   
> >> I also heard people saying these discard storms might reduce the life
> >> time of some devices - is that true?  
> > 
> > Also very much possible.  There are various SSDs that treat a discard
> > as a write zeroes and always return zeroes from all discarded blocks.
> > If the discards are smaller than or not aligned to the internal erase
> > (super)blocks, this will actually cause additional writes.
> >   
> >> If the answer to at least one of these is "yes" I'd say we it might be
> >> best to revert 63a7cb130718 for now.  
> > 
> > I don't think enabling it is a very a smart idea for most consumer
> > devices.  
> 
> It seems like a good time to talk through a variations of discard usage
> in fb data centers.  We run a pretty wide variety of hardware from
> consumer grade ssds to enterprise ssds, and we've run these on
> ext4/btrfs/xfs.
> 
> (Christoph knows most of this already, so I'm only partially replying to
> him here)
> 
> First, there was synchronous discard.  These were pretty dark times
> because all three of our filesystems would build a batch of synchronous
> discards and then wait for them during filesystem commit.  There were
> long tail latencies across all of our workloads, and so workload owners
> would turn off discard and declare victory over terrible latencies.
> 
> Of course this predictably ends up with GC on the drives leading to
> terrible latencies because we weren't discarding anymore, and nightly
> trims are the obvious answer.  Different workloads would gyrate through
> the variations and the only consistent result was unhappiness.
> 
> Some places in the fleet still do this, and it can be a pretty simple
> tradeoff between the IO impacts of full drive trims vs the latency
> impact of built up GC vs over-provisioning.  It works for consistent
> workloads, but honestly there aren't many of those.
> 
> Along the way both btrfs and xfs have grown variations of async discard.
>  The XFS one (sorry if I'm out of date here), didn't include any kind of
> rate limiting, so if you were bulk deleting a lot of data, XFS would
> effectively queue up so many discards that it actually saturated the
> device for a long time, starving reads and writes.  If your workload did
> a constant stream of allocation and deletion, the async discards would
> just saturate the drive forever.
> 
> The workloads that care about latencies on XFS ended up going back to
> synchronous discards, and they do a slow-rm hack that nibbles away at
> the ends of files with periodic fsyncs mixed in until the file is zero
> length.  They love this and it makes me cry.
> 
> The btrfs async discard feature was meant to address both of these
> cases.  The primary features:
> 
> - Get rid of the transaction commit latency
> - Enable allocations to steal from discards, reducing discard IO
> - Avoid saturating the devices with discards by metering them out
> 
> Christoph mentions that modern enterprise drives are much better at
> discarding, and we see this in production too.  But, we still have
> workloads that switched from XFS to Btrfs because the async discard
> feature did a better job of reducing drive write-amp and latencies.
> 
> So, honestly from my POV the async discard is best suited to consumer
> devices.  Our defaults are probably wrong because no matter what you
> choose there's a drive out there that makes it look bad.  Also, laptops
> probably don't want the slow dribble.
> 
> I know Boris has some ideas on how to make the defaults better, so I'll
> let him chime in there.

That makes sense. Thank you!


-- 

  Sergei
