Return-Path: <linux-btrfs+bounces-391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1CE7FA545
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EC9B212FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F27A347C0;
	Mon, 27 Nov 2023 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cOJbfPJx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D15619B5
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 07:53:00 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5c08c47c055so42447847b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701100379; x=1701705179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmXj7rg3ylnD13YAaf4BpsSWURNtIlxZw1GlxyVB+YU=;
        b=cOJbfPJxCKfzM5zsGgQgWxSWp+lm3qV4JcsWkzCwY05rafbZVBi6xHEt+/aAApRi6J
         uEqKFfPJoSy0yP7XxtIHyUFdSUDNsI5aVonmVkceqRJFzW5Ts2+IBKiOn78xej2S2Vxv
         fyxGsmVlAOtpZblxftiLKSdVjVS4cwRd4wi5o0vBFSvSLkVhwq+94XhChJVObSnORoKq
         I0pKjd0NcieWuQ03dYaXIIQqVnujZGR8TDM8sr4GmjULQBgVm5sqXBddwQmvObWWqndV
         lppEARt3VmpAoxZ/EvrBZEfGBBczAKr6JCUXmuvybXPTKHgZpYXNfzM+NrcwbMQ/RsWS
         BA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100379; x=1701705179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmXj7rg3ylnD13YAaf4BpsSWURNtIlxZw1GlxyVB+YU=;
        b=JaZjnleiIeKltDAJ7kJp43E4XfLzIYN2gJsU2d0cV0nFP+OzAyO4RnxtpuC0GNupes
         BzR8Mdp/elD+zAU6sHTws4vba6T7jZMsWsGVdJxbN3yAhK87Bin54CB/jZgVogNgalWP
         fs4dyKq61GkAy3kdvgVZ2NB3xOGTR2nCgrtf9//0Ll4CN+ARS3MoR+tT19afLjYRAKbl
         zQr7TD4qXZ4M85xFSct/fS8FyuIxKOy0+OGCrPfFRg1Xyb3GR1BapkFg77069khlBEgx
         T6VBEAwqWQf3VeWGjiHw0/BLDzt2A+Zvis+sIwUhbK9jA089Aot6u1mIPiP+SkZo9ViW
         izZA==
X-Gm-Message-State: AOJu0YySl9p4Q4KtYKDXYJxTjtgeQhHTNJREQiel6M4TC0fw8Wk+bo0J
	H31QfeEYMKCrt/YQs/DhmzVnEqy9InFcE/yK53hLQAOG3b0=
X-Google-Smtp-Source: AGHT+IG3OXKBWVMJCkCYVTXbyAX+Brcj/hADRXCZpqiZIAE8N+6cgLxaEAatVeqv2sblQGZSyrShQQ==
X-Received: by 2002:a0d:e20a:0:b0:5cc:3963:ff69 with SMTP id l10-20020a0de20a000000b005cc3963ff69mr13733891ywe.8.1701100379145;
        Mon, 27 Nov 2023 07:52:59 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dt4-20020a05690c250400b005cea6de9980sm2321389ywb.95.2023.11.27.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:52:58 -0800 (PST)
Date: Mon, 27 Nov 2023 10:52:58 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.cz>
Cc: Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3 00/19] btrfs: convert to the new mount API
Message-ID: <20231127155258.GB2366036@perftesting>
References: <cover.1700673401.git.josef@toxicpanda.com>
 <CAEg-Je-oQ4Eh4vyidHWM-X_ppwE=_aV0Ra7EmL59ZKNQoT18SQ@mail.gmail.com>
 <20231122182946.GE11264@twin.jikos.cz>
 <CAEg-Je_A+yuMc4XvM_e+4BKMu0wEDM6WFtKxaEiA2apJyuH2wQ@mail.gmail.com>
 <20231122225500.GG11264@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122225500.GG11264@twin.jikos.cz>

On Wed, Nov 22, 2023 at 11:55:00PM +0100, David Sterba wrote:
> On Wed, Nov 22, 2023 at 05:12:02PM -0500, Neal Gompa wrote:
> > On Wed, Nov 22, 2023 at 1:37 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Wed, Nov 22, 2023 at 12:41:30PM -0500, Neal Gompa wrote:
> > > > On Wed, Nov 22, 2023 at 12:18 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > > >
> > > > > v2->v3:
> > > > > - Fixed up the various review comments from Dave and Anand.
> > > > > - Added a patch to drop the deprecated mount options we currently have.
> > > > >
> > > > > v1->v2:
> > > > > - Fixed up some nits and paste errors.
> > > > > - Fixed build failure with !ZONED.
> > > > > - Fixed accidentally dropping BINARY_MOUNTDATA flag.
> > > > > - Added Reviewed-by's collected up to this point.
> > > > >
> > > > > These have run through our CI a few times, they haven't introduced any
> > > > > regressions.
> > > > >
> > > > > --- Original email ---
> > > > > Hello,
> > > > >
> > > > > These patches convert us to use the new mount API.  Christian tried to do this a
> > > > > few months ago, but ran afoul of our preference to have a bunch of small
> > > > > changes.  I started this series before I knew he had tried to convert us, so
> > > > > there's a fair bit that's different, but I did copy his approach for the remount
> > > > > bit.  I've linked to the original patch where I took inspiration, Christian let
> > > > > me know if you want some other annotation for credit, I wasn't really sure the
> > > > > best way to do that.
> > > > >
> > > > > There are a few preparatory patches in the beginning, and then cleanups at the
> > > > > end.  I took each call back one at a time to try and make it as small as
> > > > > possible.  The resulting code is less, but the diffstat shows more insertions
> > > > > that deletions.  This is because there are some big comment blocks around some
> > > > > of the more subtle things that we're doing to hopefully make it more clear.
> > > > >
> > > > > This is currently running through our CI.  I thought it was fine last week but
> > > > > we had a bunch of new failures when I finished up the remount behavior.  However
> > > > > today I discovered this was a regression in btrfs-progs, and I'm re-running the
> > > > > tests with the fixes.  If anything major breaks in the CI I'll resend with
> > > > > fixes, but I'm pretty sure these patches will pass without issue.
> > > > >
> > > > > I utilized __maybe_unused liberally to make sure everything compiled while
> > > > > applied.  The only "big" patch is where I went and removed the old API.  If
> > > > > requested I can break that up a bit more, but I didn't think it was necessary.
> > > > > I did make sure to keep it in its own patch, so the switch to the new mount API
> > > > > path only has things we need to support the new mount API, and then the next
> > > > > patch removes the old code.  Thanks,
> > > > >
> > > > > Josef
> > > > >
> > > > > Christian Brauner (1):
> > > > >   fs: indicate request originates from old mount api
> > > > >
> > > > > Josef Bacik (18):
> > > > >   btrfs: split out the mount option validation code into its own helper
> > > > >   btrfs: set default compress type at btrfs_init_fs_info time
> > > > >   btrfs: move space cache settings into open_ctree
> > > > >   btrfs: do not allow free space tree rebuild on extent tree v2
> > > > >   btrfs: split out ro->rw and rw->ro helpers into their own functions
> > > > >   btrfs: add a NOSPACECACHE mount option flag
> > > > >   btrfs: add fs_parameter definitions
> > > > >   btrfs: add parse_param callback for the new mount api
> > > > >   btrfs: add fs context handling functions
> > > > >   btrfs: add reconfigure callback for fs_context
> > > > >   btrfs: add get_tree callback for new mount API
> > > > >   btrfs: handle the ro->rw transition for mounting different subovls
> > > > >   btrfs: switch to the new mount API
> > > > >   btrfs: move the device specific mount options to super.c
> > > > >   btrfs: remove old mount API code
> > > > >   btrfs: move one shot mount option clearing to super.c
> > > > >   btrfs: set clear_cache if we use usebackuproot
> > > > >   btrfs: remove code for inode_cache and recovery mount options
> > > > >
> > > > >  fs/btrfs/disk-io.c |   85 +-
> > > > >  fs/btrfs/disk-io.h |    1 -
> > > > >  fs/btrfs/fs.h      |   15 +-
> > > > >  fs/btrfs/super.c   | 2357 +++++++++++++++++++++++---------------------
> > > > >  fs/btrfs/super.h   |    5 +-
> > > > >  fs/btrfs/zoned.c   |   16 +-
> > > > >  fs/btrfs/zoned.h   |    6 +-
> > > > >  fs/namespace.c     |   11 +
> > > > >  8 files changed, 1263 insertions(+), 1233 deletions(-)
> > > > >
> > > > > --
> > > > > 2.41.0
> > > > >
> > > >
> > > > Looks like my r-b wasn't picked up for this revision, but looking over
> > > > it, things seem to be fine.
> > >
> > > Honestly Neal, I don't know how I should interpret your Reviewed-by. You
> > > don't contribute code or otherwise comment on other patches on the
> > > technical level. If you as an involved user want to give feedback that
> > > some feature is desired then it's fine to do so but the rev-by tag is
> > > not the way to do that.
> > >
> > > https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> > 
> > If it helps, I put "Reviewed-by" on patch sets that I have downloaded
> > and applied to a local build that I test and read to check to see that
> > they make sense.
> 
> Download and build is just a build test, you may find build problems
> like with missing config options or warnings though which is valuable
> but not enough. Reading code if it makes sense means different things to
> you and me. I expect knowledge deep enough that if somebody puts a
> Reviewed-by there then I can ask questions to get explanations how
> things get fixed or improved. Or to CC that person when a bug appears
> and then jointly debug it or expect a fix.
> 
> > If the patches make sense, build, and work for me, I'll send a
> > "Reviewed-by" statement. I figured that would be sufficient for
> > "Reviewed-by" statements. If there's something more you're expecting
> > for that, then please let me know.
> 
> I expect that I can rely on the person's understanding of the code. It
> takes time to build the reputation, actually based on real code-level
> discussions or sending own patches of a reasonable quality. Otherwise it
> devalues the tag meaning.
> 
> > It's pretty rare that I'd test code
> > without at least looking at it and checking it over, so I don't feel
> > "Tested-by" makes sense.
> 
> If you test the code then it's for Tested-by, eventually stating which
> testsuites were run or in what configuration, which would apply in this
> case.
> 
> I would be sad to discourage you from contributing, it happens on
> different levels, just that I was surprised first and was not the only
> one.

Generally speaking we all have different ideas of what the 'Reviewed-by' tag
means.  Dave your definition is a relatively common one, and isn't incorrect.
However we as a kernel community have been trying to encourage more
participation and have specifically called out patch review as a good place to
start.

Everybody has something to add, and in Neal's case specifically he's been
working in storage/file systems for many years.  He and Chris Murphy were the
primary drivers of btrfs adoption in Fedora.  I've been fielding bug and feature
requests from him for years.  Is he a veteran kernel developer?  No.  Does he
have context on btrfs and it's wider usage and how it behaves?  Absolutely.
He's able to add context to use cases that we may not think about from the user
side

https://lore.kernel.org/linux-btrfs/CAEg-Je_zGBAgPLgpnjWbRwGLXNSpmor-mokZyMT6iSfF2121QQ@mail.gmail.com/
https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/


Additionally as the btrfs-progs maintainer for Fedora he's testing and rolling
our packages regularly, and is able to provide feedback and patches

https://lore.kernel.org/linux-btrfs/CAEg-Je8FNefaKjYFeqw2Gh-TXSjVWbgczYtL3qpgJWQj3pJjCw@mail.gmail.com/
https://lore.kernel.org/linux-btrfs/20230920140635.2066172-2-neal@gompa.dev/

In addition to just generally testing the things that we ship, even big things
like the sub-page blocksize stuff that I know he's been involved in heavily
because of the Fedora-Asahi stuff

https://lore.kernel.org/linux-btrfs/CAEg-Je8b74AHC32Z7Zwrfz_83bBSLjaU58AdzvgSanBNoZ3X=w@mail.gmail.com/

I don't think anybody here is arguing that Neal doesn't provide value to the
community, but I wanted to provide context for random passer-by's to understand
the full context.

I personally value feedback from Neal.  I regularly get feedback from the larger
Fedora community from him and others and use that as a way to guide our
development and feature work.  He's also usually the first one to raise
important user-facing bugs we miss, the most recent one being the -EFAULT in the
O_DIRECT write case that Boris fixed earlier this year.  I know if he's looked
at my patches and he doesn't understand something that I didn't do a good job of
explaining my changes.

Looking through the history of Reviewed-by's from Neal, and then looking at
what has been committed there's a pretty big discrepancy.  There's 4 patches
with his Reviewed-by in the git tree, but a lot more series that he's reviewed.
It is fair to say "this is our standard for Reviewed-by, you need to do X for us
to attribute value to Reviewed-by."  It's not fair to silently ignore and drop
tags, especially for a contributor we know is actively involved.  Neal isn't
trying to score internet points, he's trying to contribute.

Looking through our process documentation at the different tags it looks like
the 'Acked-by' tag is a reasonable middle-ground for this type of contribution

```
If a person was not directly involved in the preparation or handling of a
patch but wishes to signify and record their approval of it then they can
ask to have an Acked-by: line added to the patch's changelog.
```

I don't want to open up for a flood of random people to try and score internet
points, so I don't think we should allow anybody to get their 'Acked-by's on any
patchset, but in the case of contributors like Neal and others I think this is a
good way to acknowledge their contributions.

I would propose that we use 'Acked-by' for contributors who have been in the
community and active for a while and that have context of the wider use of
btrfs, but not necessarily code contributions that would indicate deep
understanding of the relevant code.

I'm fine with using Dave's definition for 'Reviewed-by', so long as we
communicate to new contributors our expectations of what these tags mean.

As maintainers of btrfs we need to be better about communicating our
expectations to new contributors.  Guiding new people is an important part of
keeping a thriving community.  I will be more proactive about this as it's an
important area for me, but this is not just a thing that needs to be a me, Dave,
or Chris's responsibility, every core contributor to btrfs is capable of doing
this sort of guidance.

Going forward, is using 'Acked-by' an acceptable compromise for everybody in
these cases?  Are we satisfied with the standards I've laid out above?  Thanks,

Josef

