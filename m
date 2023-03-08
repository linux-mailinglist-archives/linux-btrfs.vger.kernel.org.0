Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC46B03BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCHKJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCHKJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 05:09:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB927D69;
        Wed,  8 Mar 2023 02:09:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6510BB81C14;
        Wed,  8 Mar 2023 10:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D8AC433EF;
        Wed,  8 Mar 2023 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678270181;
        bh=6MFmD8pwATWBVFR/u+ZY17+kLUtQdscqLPcTZNzmMTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FJy21Ph45xeAalcLFFpnV6KcLpd/Fi7s8Zz1RPGSPivs8rzODOZoBkumssIbQxrl/
         HLGE7KaLfeLgJPsJEf0420d3fo89VuE5GRytBbvET7fkKSNArG1ZKsf6Fhv3TMBdHn
         mI9F+stLNmhu1f5AtnmRdafpddMJogHMVk1jEOo99OEPj0zJQ4GPlrsi0Bq5qX7UW8
         HF1quy29nXov7OOT2IxfwUGkI3xFmXAbMxdi+R/ya7aWfyhZ/BCxOPAt210BwsiC9u
         QinI5twYOLKjvqImB2tO70T/Zz5XOu9kagW0me2i7MFo03Msjj/klBOiqso2k+pKNr
         hfzh7fIVcwfEQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-176b90e14a9so10540759fac.9;
        Wed, 08 Mar 2023 02:09:41 -0800 (PST)
X-Gm-Message-State: AO0yUKXw1FVv3Z1LBLLLqARS8B/tuk0X6UDXodyMJiPXD/zrRaEHupze
        P+tL+ZjGCpX48nbizEmYyTpTtxmAtXkFCgd0HGs=
X-Google-Smtp-Source: AK7set+vR7IXPqNgvytqOtBlh6yDoRDDIBeQGMox+qx6/NvUHnRMqyO64tx+JznogkjmHH0JeUGd/+AA6hcnhYUerWU=
X-Received: by 2002:a05:6870:a8ab:b0:172:39d6:edc7 with SMTP id
 eb43-20020a056870a8ab00b0017239d6edc7mr4913893oab.4.1678270180291; Wed, 08
 Mar 2023 02:09:40 -0800 (PST)
MIME-Version: 1.0
References: <7be1169e950b807f24e4b2ac33177e44fc13e434.1678189053.git.fdmanana@suse.com>
 <5a542a82-b47b-ced3-97d6-a38b6e926522@oracle.com> <20230308084756.sdeko4gm4x4teuvx@zlang-mailbox>
 <dfd8863c-3a18-f5f1-8391-10fdf101ee62@oracle.com>
In-Reply-To: <dfd8863c-3a18-f5f1-8391-10fdf101ee62@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 8 Mar 2023 10:09:03 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ocf8KNhB=b6dr6BskdzJW8qJGvS8ro9DRgRRpyH89qg@mail.gmail.com>
Message-ID: <CAL3q7H7ocf8KNhB=b6dr6BskdzJW8qJGvS8ro9DRgRRpyH89qg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/284: list a couple btrfs-progs git commits
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 8, 2023 at 9:17=E2=80=AFAM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
>
> On 3/8/23 16:47, Zorro Lang wrote:
> > On Wed, Mar 08, 2023 at 04:03:57PM +0800, Anand Jain wrote:
> >> On 07/03/2023 19:38, fdmanana@kernel.org wrote:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> This test may often fail when running with btrfs-progs versions not v=
ery
> >>> recent. The corresponding git commits in btrfs-progs that fix issues
> >>> uncovered by this test are:
> >>>
> >>> 1) 6f4a51886b37 ("btrfs-progs: receive: fix silent data loss after fa=
ll back from encoded write")
> >>>      Introduced in btrfs-progs v6.0.2;
> >>>
> >>> 2) e3209f8792f4 ("btrfs-progs: receive: fix a corruption when decompr=
essing zstd extents"")
> >>>      Introduced in btrfs-progs v6.2.
> >>>
> >>> So add the corresponding _fixed_by_git_commit calls to the test.
> >>>
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>> ---
> >>>    tests/btrfs/284 | 5 +++++
> >>>    1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/tests/btrfs/284 b/tests/btrfs/284
> >>> index 0d31e5d9..c6692668 100755
> >>> --- a/tests/btrfs/284
> >>> +++ b/tests/btrfs/284
> >>> @@ -20,6 +20,11 @@ _require_test
> >>>    _require_scratch_size $(($LOAD_FACTOR * 1 * 1024 * 1024))
> >>>    _require_fssum
> >>> +_fixed_by_git_commit btrfs-progs e3209f8792f4 \
> >>> +   "btrfs-progs: receive: fix a corruption when decompressing zstd e=
xtents"
> >>> +_fixed_by_git_commit btrfs-progs 6f4a51886b37 \
> >>> +   "btrfs-progs: receive: fix silent data loss after fall back from =
encoded write"
> >>> +
> >>>    send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> >>>    rm -fr $send_files_dir
> >>
> >>
> >> Along with this, why not check the btrfs-progs version using
> >> 'btrfs --version' and call _not_run()?
> >
> > Does this case expose some known bugs, right? Or the failures due to so=
me
> > features missing?
> >
>
> It tests for a bug.

The test is meant to be a generic stress test for send v2 streams.

It happens to have uncovered 2 bugs (so far). And if it finds out more
bugs in the future, I'll surely list more commits in it.

So I don't get where you got the idea to skip running a test based on
the btrfs-progs version.
We don't do that anywhere in fstests, neither for btrfs-progs nor
kernel or anything else. The reason was already pointed out to you:
distros, vendors, often backport commits to older versions - working
for a company with a distro, I would expect you to be familiar with
that :)

Thanks.

>
> > If this case uncovers some known issues, then the failure is expected o=
n unfixed
> > version. We should let the failure exposing, not hide it by _notrun.
>
> Makes sense.
>
> > And the package version is not a good way to jundge if a issue is fixed=
 or a
> > feature is merged. Due to many downstream packages might merge some ups=
tream
> > patches independently.
> >
>
> Yeah, I agree. You can guarantee that if btrfs-progs is plain vanilla.
>
> Looks good as it is.
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Thanks, Anand
>
> > Thanks,
> > Zorro
> >
> >>
> >> Thanks, Anand
> >>
> >
