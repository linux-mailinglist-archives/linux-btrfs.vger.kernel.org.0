Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23597756C96
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGQS5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGQS5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 14:57:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A291FAF
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 11:57:17 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76547539775so331942485a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689620236; x=1692212236;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14Zyn6v3pwGW04NcZ8k6lVPzH1aJUReBGPcAbS+jHSQ=;
        b=KLtELEG7qcAaPmdjxn1sa862ZAKy+M2GUYUfyAXCORuW8NSFNOnu92Ci5uSsvSGNza
         kbgObv7YhCdHG0w7NQTDCXGvbHTNGwDYLrB0ILk1UXRbIBnghzf8SL1Crvhda8Yp3Uom
         eU7XYOEX5Vcfj68mBOoAQrlCVhqUBEvtDnnMB8xmYUL4AMUgBOASePoG7MkHOnZYdCxY
         49/wYXdqI1X1sr1ilYDMPQVLpBbfG+PIa9i5QZJ/BB0jCZACE6Vh/b4ShJbsKbUr56Hw
         SmL99NIN2Bgthf/1RDPnefd8NVPe5nKr229ACk161lJ2kA/pziOdPTtA7FnqXMCB0SsZ
         /GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620236; x=1692212236;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14Zyn6v3pwGW04NcZ8k6lVPzH1aJUReBGPcAbS+jHSQ=;
        b=DrEDIfK9S8E6Aw0yd3neozXXQQfKy4gSVlEdjx/5zv/4l8cWGYJ53n7CHTzaBArbbD
         TGRJ3sc+ArND0V5TJ5k+BRicJmpP/oh4z39Y1prZ7RxMXFzBCeVHQKt1kO5tAUr3FXZD
         RyIkp0SszUF/sxFz1kKU2TNY7Cdt/1rWajDuBBmpMa3Wu9MMV61rVjRSteSUQ5Pd4Wxl
         CI4aCOeW+rnonW10JGzfQpVC39HLn7AllGoKLwtyOCewYK4pRB02LAflEpuwe32C2Ry3
         t7Izx9xdkapkAn/WIRmxGbjSCL7GrMhXopWuT7RQPLQaOxjKsJl0NbQ7LMaFdxC+tCfi
         50oA==
X-Gm-Message-State: ABy/qLYxgRikQPGIRob6Rzrs7nXJP/JyA59VNnOf2F2FynXvXR/blvv0
        2St+SlcE3QrYZG6HpIkib8RNlkTWUVitGglmWYr+JA==
X-Google-Smtp-Source: APBJJlHdIz3IVcxNy2uHEQnA/2/TAWdvu/OgrS8nJuQzYlmr3U99gDq6+Tf7ZWAUyn+qh+XC164pRA==
X-Received: by 2002:a05:620a:4389:b0:767:55c4:5725 with SMTP id a9-20020a05620a438900b0076755c45725mr12544301qkp.18.1689620236281;
        Mon, 17 Jul 2023 11:57:16 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id pi21-20020a05620a379500b00767c9915e32sm6331707qkn.70.2023.07.17.11.57.15
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:57:15 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:57:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [ANNOUNCE] New GitHub CI workflow
Message-ID: <20230717185715.GA757715@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

For the last few years we've been relying on my nightly tests to catch any
regressions we have in our development tree.  The results have been crudely
dumped to http://toxicpanda.com and http://toxicpanda.com/performance/.  This is
a bunch of VM's on a Intel NUC with cronjobs and chewing gum holding it all
together.  It has worked pretty well, but it is beginning to show it's age, as
the overnight runs literally take all night, starting around 8PM my time and
finishing 1:30PM my time.

I've upgraded my hardware and re-built the VM setup.  The old setup will
continue so we have a nice baseline of what's going on, but the new setup will
be triggered with GitHub Actions.

# tl;dr

If you are a btrfs developer and are in the https://github.com/btrfs
organization, you can now submit PR's against the "ci" branch in the "linux"
repo.  This will trigger a full fstests run using my VM's, which currently test
7 different configurations, 5 on x86 and 2 on ARM64.  Zoned will be added
shortly, I've just been fighting with the thing to get this far so that part is
still in the pipeline.

It is highly encouraged that if you've got a decently involved patchset that you
take advantage of this system to pre-check your code, either before submitting
it to the list for review or in parallel.

# Details

On every run we pull from our "staging" branch in our copy of the "fstests" repo
in our https://github.com/btrfs repo.  Everybody in the org has commit access to
this, if you want new tests run through the CI please do feel free to commit
them to this branch and then trigger a CI run.

We also pull down the latest "devel" branch from Sterba's btrfs-progs tree.
This will help us catch any output changes or related user space bugs with our
fstests runs, as well as allow us to easily test new fs features.

These runs take around 4.5 hours currently.  There's a 6 hour timeout, so if
there's a deadlock or a panic it'll simply timeout.  I haven't figured out a way
to capture this information for the results so that's a bummer of a limitation
currently.

# Clean runs

In order to make this as easy as possible for us to catch regressions in our own
code, my goal is to make sure the baseline runs of fstests run with 0 failures.
This means we're utilizing exclude files in this GitHub CI setup.  The old setup
will continue to run the full suite so we can make sure we're tracking what
tests are flakey.

Currently x86 is clean, however ARM still has a few iterations to go before I'll
have nailed down all the flakey tests.  In the first few weeks please
investigate failures to make sure they're not real regressions, or check the
existing http://toxicpanda.com list of runs to see if the test already has found
to be flakey.  In our "staging" branch in our "fstests" repo there is EXCLUDE
and EXCLUDE.arm, simply add tests to the relevant file to expunge them from the
CI runs.

# We're just ignoring flakey tests?

For now, yes.  For things that are easier to reason with, for example the
block-tree root feature is incompatible with ~NO_HOLES, patches are preferred to
detect and skip the test for specific incompatibilities.  However for harder to
debug things feel free to simply exclude them.  With this list of excludes we
can then go back when we have time and nail down each of them and get them fixed
up so they're no longer flakey.

# OMFG GITHUB!?!?

Yes, I'm nothing if not lazy, and honestly it took me about a week to work out
all the kinks in this particular system.  We're already on GH, we already have a
lot of processes around using our existing GH org, so I did this with GitHub
actions.  I have 0 interest in debating this particular choice.  If you aren't a
core developer you aren't my target audience.  If you don't want to use the CI
you don't have to, this is simply a convenience offered to those of us who do
this for our job.

# I'm not in the GH Btrfs org/don't have a GH account and want to use the CI?

If you have a sufficiently large patchset you would like run against the CI for
you all you have to do is ask one of the Btrfs developers and we'd be happy to
push a PR for you so you can get your patches tested.

If you would like to be added to the GH Btrfs Org and aren't a current member
please email myself or Dave Sterba and we can decide if you can be added as a
member, but this will be limited to consistent contributors.  We are always
happy to submit PR's on your behalf if you're just looking for some extra
validation of a large contribution.

Thanks,

Josef
