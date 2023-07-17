Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D364C756ED0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 23:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGQVPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 17:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQVPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 17:15:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F1F3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 14:15:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so6728661a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689628513; x=1692220513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEUfcl3usvXcPo/meaJClYhsZoD3C4N0uNl6ovwBMNI=;
        b=F0jzRmYA42Sfum683nY60VDr5AWMh65H/0yoWA2JckX7e5gDcKKb58CGdDPuU00T6L
         xMS10rIkFb8lA+5NnKJ4UybsLYeVeW4rsQxIKkUwykuw2tunJsqEPwF9+QfHCh1NkX+g
         XTh7MGhjO94L7IVMaZFUuwsix1N4tLHWb/b0m3++qQ6y0i8CRLgb6naircrlibBOT7rg
         riehbZ3Zm+2O5lxrBEyOKQQCP4kcTGKfETVGiVIrWNnDa8sWiVcJCkZlC6v4TLbojBzH
         +Ocg1SXgW7YMiGZ6fmwADw4lxsEZEhRAObc6MFvQ7A+d51gT4cIayYdidSdnwxzue40e
         AW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689628513; x=1692220513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEUfcl3usvXcPo/meaJClYhsZoD3C4N0uNl6ovwBMNI=;
        b=k3rA4NVKVmGLBKsVzkyTh7o/lNjOpvJ1og/TRCvJZbejaj+2rQBKGHr/ZdcCb3KJDZ
         adlCNXoZpC4PXOOpXf5eYG6yxh59Uk+40h9pHzr2QrANhPWOp2tkzyo4w+Ga5TZ0hgp1
         3bsFBqICBnlcFBijF06fNdhEJeSAXwPGcIys2v/iH7kDi5ASmRcIyrQSC580Xn4PHWFk
         jTbU1Twjq7U2DKKjzxF2XNB3HYbtTnMvit3P2D30fFHmIhq7CtnJnfI6eJJXLNgei9WC
         7xHOhGs5OztsKxXHb8Z4jMze/5bH2n2+0YJ4j7NA0M+TGchl+qkR5x51hfGU4POXT6yc
         1nFg==
X-Gm-Message-State: ABy/qLbwgAX4w+aeFU6h4o0UooM1d6wM6CTQhwW2Ked9EUcuk0f3h6k3
        GNKX+BPLUjg5v41y8YREs7/6x/jYgdNBh9NXxTk=
X-Google-Smtp-Source: APBJJlFd1VVOrLKsGCapzFxBHTyXeeMiWIaL/zp/VljSFBgfqNSVfoJnrVXABK4u/6ijGIHeZKgUh6pQH46y1KXgOuk=
X-Received: by 2002:aa7:d98e:0:b0:521:7881:4f39 with SMTP id
 u14-20020aa7d98e000000b0052178814f39mr7554494eds.14.1689628512616; Mon, 17
 Jul 2023 14:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230717185715.GA757715@perftesting>
In-Reply-To: <20230717185715.GA757715@perftesting>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 17 Jul 2023 17:14:36 -0400
Message-ID: <CAEg-Je_HLAvZrSnUm6EWJkLD9Ewe3ZRvJH6TgdnS_rN-3j-pBA@mail.gmail.com>
Subject: Re: [ANNOUNCE] New GitHub CI workflow
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 17, 2023 at 3:17=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Hello,
>
> For the last few years we've been relying on my nightly tests to catch an=
y
> regressions we have in our development tree.  The results have been crude=
ly
> dumped to http://toxicpanda.com and http://toxicpanda.com/performance/.  =
This is
> a bunch of VM's on a Intel NUC with cronjobs and chewing gum holding it a=
ll
> together.  It has worked pretty well, but it is beginning to show it's ag=
e, as
> the overnight runs literally take all night, starting around 8PM my time =
and
> finishing 1:30PM my time.
>
> I've upgraded my hardware and re-built the VM setup.  The old setup will
> continue so we have a nice baseline of what's going on, but the new setup=
 will
> be triggered with GitHub Actions.
>
> # tl;dr
>
> If you are a btrfs developer and are in the https://github.com/btrfs
> organization, you can now submit PR's against the "ci" branch in the "lin=
ux"
> repo.  This will trigger a full fstests run using my VM's, which currentl=
y test
> 7 different configurations, 5 on x86 and 2 on ARM64.  Zoned will be added
> shortly, I've just been fighting with the thing to get this far so that p=
art is
> still in the pipeline.
>
> It is highly encouraged that if you've got a decently involved patchset t=
hat you
> take advantage of this system to pre-check your code, either before submi=
tting
> it to the list for review or in parallel.
>
> # Details
>
> On every run we pull from our "staging" branch in our copy of the "fstest=
s" repo
> in our https://github.com/btrfs repo.  Everybody in the org has commit ac=
cess to
> this, if you want new tests run through the CI please do feel free to com=
mit
> them to this branch and then trigger a CI run.
>
> We also pull down the latest "devel" branch from Sterba's btrfs-progs tre=
e.
> This will help us catch any output changes or related user space bugs wit=
h our
> fstests runs, as well as allow us to easily test new fs features.
>
> These runs take around 4.5 hours currently.  There's a 6 hour timeout, so=
 if
> there's a deadlock or a panic it'll simply timeout.  I haven't figured ou=
t a way
> to capture this information for the results so that's a bummer of a limit=
ation
> currently.
>
> # Clean runs
>
> In order to make this as easy as possible for us to catch regressions in =
our own
> code, my goal is to make sure the baseline runs of fstests run with 0 fai=
lures.
> This means we're utilizing exclude files in this GitHub CI setup.  The ol=
d setup
> will continue to run the full suite so we can make sure we're tracking wh=
at
> tests are flakey.
>
> Currently x86 is clean, however ARM still has a few iterations to go befo=
re I'll
> have nailed down all the flakey tests.  In the first few weeks please
> investigate failures to make sure they're not real regressions, or check =
the
> existing http://toxicpanda.com list of runs to see if the test already ha=
s found
> to be flakey.  In our "staging" branch in our "fstests" repo there is EXC=
LUDE
> and EXCLUDE.arm, simply add tests to the relevant file to expunge them fr=
om the
> CI runs.
>
> # We're just ignoring flakey tests?
>
> For now, yes.  For things that are easier to reason with, for example the
> block-tree root feature is incompatible with ~NO_HOLES, patches are prefe=
rred to
> detect and skip the test for specific incompatibilities.  However for har=
der to
> debug things feel free to simply exclude them.  With this list of exclude=
s we
> can then go back when we have time and nail down each of them and get the=
m fixed
> up so they're no longer flakey.
>
> # OMFG GITHUB!?!?
>
> Yes, I'm nothing if not lazy, and honestly it took me about a week to wor=
k out
> all the kinks in this particular system.  We're already on GH, we already=
 have a
> lot of processes around using our existing GH org, so I did this with Git=
Hub
> actions.  I have 0 interest in debating this particular choice.  If you a=
ren't a
> core developer you aren't my target audience.  If you don't want to use t=
he CI
> you don't have to, this is simply a convenience offered to those of us wh=
o do
> this for our job.
>
> # I'm not in the GH Btrfs org/don't have a GH account and want to use the=
 CI?
>
> If you have a sufficiently large patchset you would like run against the =
CI for
> you all you have to do is ask one of the Btrfs developers and we'd be hap=
py to
> push a PR for you so you can get your patches tested.
>
> If you would like to be added to the GH Btrfs Org and aren't a current me=
mber
> please email myself or Dave Sterba and we can decide if you can be added =
as a
> member, but this will be limited to consistent contributors.  We are alwa=
ys
> happy to submit PR's on your behalf if you're just looking for some extra
> validation of a large contribution.
>

Will we move btrfs-progs to this GitHub organization?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
