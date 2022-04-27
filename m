Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51B51245C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiD0VO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiD0VOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 17:14:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB029804
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:11:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f2so4346020ioh.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zk3rHEDT6k20qJVc4rpRRKbK2ZqjWI1zMEO/prumO4=;
        b=svLRoKq9Hdkh6SlL1mLEF+17tDr598DflYavh6IgbBHy4igkBLJtx3cvVFnhF2oEfA
         /v01TzjxDbHFBgyRB/0gC3EX/8QDnSEcJI6AMsKPDnutxc8cMRbpLvGBkDE7yOjDZ3v5
         3/UqrYFjdkDmJShhZYnZRbIELKURqKSAdjLD2dJyjZI0grNnx+IgjdQ4iK6jf5mMlP82
         9OePRQ8mOfg73OVfJfzs/RFwBWrMigoWlA8K1QoR5fJLMS7SJsanZXJLTeM/dddaiVTT
         XIoUQ+oJ/4MD8RcmGb4GVS01J8omWDhgEG88Gf68Of9p9EXAuU9pLKYyKpGkriuYnxzr
         nUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zk3rHEDT6k20qJVc4rpRRKbK2ZqjWI1zMEO/prumO4=;
        b=2QfZrk9tzN9MA2RlTnITCz4toJl4TAuBSuJgSK06D6YaAiG/GZ0ni7m2XnC7xfFciP
         HuIl6PzieZia2bD8/Sj3VsrRt+KUoJ6XJh/ST7bWnloW/BIj/oF9lQbBA7Q/xsrDeq16
         jjnG1T4l3okw8YNXkKtHqwJDJ91n9syP27uY5lBHc0lmpPY/OYHdFn4K9uH/+nnKaIdf
         adHaDkUm7aYhoIy0wt7LoE5kcUiKoelvVryaz7mtHHJpi+Y0oQvvMR2MFmE0bjwuCseY
         5ONrPs7qgM3MLsYsdP7+hpdBxYbjRuzI4CxIYSpoNouLpJbv3oPXg36xVfDrlJBRzxCN
         twbw==
X-Gm-Message-State: AOAM530RLD0bvreqFwO80iVCCGx9I2/6xmov+LCIMPFueeToHPoJf0NH
        mRHouf+WkcQyRPO67eYO8s625BB0f2Kn1ErjSUuX7ssBmAY=
X-Google-Smtp-Source: ABdhPJz1JriAEGqlv8zfsuW9Zr4lfU06h4oP2W2Hgs/pB7jCD2h8QOhNS49GKodJbb0VmV5WmVRcUilqKCtOUwXNFi4=
X-Received: by 2002:a05:6602:14ce:b0:657:2bbc:ade8 with SMTP id
 b14-20020a05660214ce00b006572bbcade8mr12429804iow.83.1651093901984; Wed, 27
 Apr 2022 14:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220426002804.GI29107@merlins.org> <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
 <20220427035451.GM29107@merlins.org> <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org> <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org> <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org>
In-Reply-To: <20220427210246.GV12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 17:11:30 -0400
Message-ID: <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 5:02 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 04:21:31PM -0400, Josef Bacik wrote:
> > On Wed, Apr 27, 2022 at 2:24 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 01:49:46PM -0400, Josef Bacik wrote:
> > > > > Result:
> > > > > doing insert of 12233379401728
> > > > > Failed to find [7750833868800, 168, 262144]
> > > >
> > > > Oh it's data, interesting.  Pushed some more debugging.  Thanks,
> > >
> > > inserting block group 15840439173120
> > > inserting block group 15842586656768
> > > processed 1556480 of 0 possible bytes
> > > processed 1130496 of 0 possible bytesdoing an insert that overlaps our bytenr 7750833627136 262144
> > > processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr??
> >
> > Well crap, you have bytenrs that overlap.  I've adjusted
> > init-extent-tree to dump the paths of the files that have overlapping
> > extents, as well as the keys.  Run it again so we know what files are
> > fucked. From there you need to tell me which one you don't care about
> > and are willing to delete, and then I'll give you the command you need
> > to remove that bad extent and then we can go again.  Thanks,
>
> I see.
>
> Not sure if that helped. Should I have run it differently?
>
>
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Wed Apr 27 16:19:46 2022 -0400
>     fix some things so dump path works
>
> (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> (...)
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1130496 of 0 possible bytesadding a bytenr that overlaps our thing, dumping paths for [5064, 108, 0]
> doing an insert that overlaps our bytenr 7750833627136 262144
> processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
> Failed to find [7750833868800, 168, 262144]
>

Of course it doesn't work for you, I pushed some debug stuff.  Thanks,

Josef
