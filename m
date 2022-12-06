Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A36441E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 12:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiLFLPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 06:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLFLPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 06:15:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A3B4AE;
        Tue,  6 Dec 2022 03:15:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8850D6164C;
        Tue,  6 Dec 2022 11:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E77C433D7;
        Tue,  6 Dec 2022 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670325332;
        bh=PqDQm94J3t+gGNqHINyLNZ7fv2cNXyPIy4NnBX/JFV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ljjVCKiFFyIBzy2y+x7LtU4Vz30MzORul96MgfjgKoVwq1c/XRLDrArLemwqQuE2z
         m/EQvdcSjEr70C5ApnDR2kaBCRxafkw/1IdjXWKjjYVtdBgJiS4rEJovHnUCTnT0D8
         yxQp2wiH8fEAFPKUIfY13fACv4Ojp+vRlGiqSSIX4QtjSHGB9gzov+5CN0aKgD7f+D
         GleDGcgJcFs1xSw7EcWjdTf52iuCiKdH8qpSV7MJxxJuvLuSyNKyyTuZc/I4IvHezU
         Iv7i8vaDCkS6xjhkmF9YvElYcGEPBO/37JJAWSxdIKYG0v2PdLJ6YxC1PABmDBTIii
         ecdoPGzNfPWUA==
Received: by mail-oi1-f172.google.com with SMTP id v70so8143185oie.3;
        Tue, 06 Dec 2022 03:15:32 -0800 (PST)
X-Gm-Message-State: ANoB5plJbwt26yp8LSKzYBDeLMj6YPVmy2oGhvlIj7T9Bo0TGsHlBV75
        rXptAW5vvAmXtlnDmA4V79QBKY06PQSyipU4dRs=
X-Google-Smtp-Source: AA0mqf4u+iJbUwbSdDXC/jIEn3IT3ygxCVlqYD9xnVHrNF3bmjW+zTs78IzJDs6M7he5V/CXX62EcO4/YJRP8dz1q0I=
X-Received: by 2002:aca:1e02:0:b0:35b:75b:f3b9 with SMTP id
 m2-20020aca1e02000000b0035b075bf3b9mr33898236oic.98.1670325332068; Tue, 06
 Dec 2022 03:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20221201160724.2593341-1-cccheng@synology.com>
 <CAL3q7H5oet2P9XijTtzPo3joZWdoa3OuD9L-wK9nTEFya2PY8w@mail.gmail.com> <CAHuHWtnbVsS2pp5EySmZ_72fCrDqKJTAOkssa-D-X5wKoR9uWQ@mail.gmail.com>
In-Reply-To: <CAHuHWtnbVsS2pp5EySmZ_72fCrDqKJTAOkssa-D-X5wKoR9uWQ@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Dec 2022 11:14:56 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5+aVYC-nQaX4_F=eRPpU8xRNEE73MHy-_fdoQFwNMDsA@mail.gmail.com>
Message-ID: <CAL3q7H5+aVYC-nQaX4_F=eRPpU8xRNEE73MHy-_fdoQFwNMDsA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: refuse to remount read-write with unsupported
 compat-ro features
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@cccheng.net, Johnny Chang <johnnyc@synology.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 6, 2022 at 2:42 AM Chung-Chiang Cheng <shepjeng@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 6:45 PM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > Wasn't this already done by the following commit?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81d5d61454c365718655cfc87d8200c84e25d596
> >
> > Thanks.
> >
>
> Wow. I did not notice this commit doing the same job by Qu. But I have
> tested the latest linux-6.1 rc-7, and it's still able to mount a unsupported
> comat-ro btrfs as read-write via remount.
>
> It's caused by the follow-up commit d7f67ac9a928 ("btrfs: relax
> block-group-tree feature dependency checks"). This commit checks read-
> only with the current superblock, which will always pass in the situation
> remounting from read-only to read-write. It seems `btrfs_check_features()`
> cannot cover this scenario.
>
>         if (compat_ro_unsupp && !sb_rdonly(sb)) {
>                                 ^^^^^^^^^^^^^^

Yep, that's a bug.
btrfs_check_features() is called before the read only flag is updated
in the super block.

So the condition should be:

if (compat_ro_unsupp && sb_rdonly(sb) && we_want_to_transition_to_rw)

We need to pass the flags passed to btrfs_remount() to
btrfs_check_features() for that "we_want_to_transition_to_rw" check.

That seems to be what needs to be fixed.

Thanks.


>
> Thanks,
> C.C.Cheng
