Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5441D7BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349965AbhI3Kco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349927AbhI3Kcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 06:32:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8BC06176A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 03:30:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t2so5142682qtx.8
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XHDjiwvCwunLBM/5AFdSWBDON0tNa4WhGV8WHdiQUeA=;
        b=GQvovt2tkpZiWpypM6oEIlPsKuebYqd+7hu9VxTtXgmKB3luIjFDXK0EcatbGGY3pK
         4Vv4AsrqyHckaBK4NpMKFzrl0MPmlMDvXrXkdbVB/kz2XGy7K3/II5MgGcJ+2gXPqOn3
         PT9rdTez1LjrrnOP8pPTyh0ZeewBBDKGYWT/N/MdnveR1KzBOJXTdpmelAX+aV+f+uO/
         07PL7Jo4BEzymLBR+o/o4uCPg30+faPaadQ6xlhkrZ2Gv25ay4yhTNqC9G1ka7HHhDTH
         NiyfKPJhujJrEUqXKxpuQ9JL4ZmDkkeaV4iBhJBC5yWKaXCGw3YkDc9Ug3FdMcNvYGRQ
         cNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XHDjiwvCwunLBM/5AFdSWBDON0tNa4WhGV8WHdiQUeA=;
        b=rEXFM8buLvzoqYg5GROb/WLBwyBlXIJdyWxfY7yqXLhfoKpvTlkK00j0XDlTU5Gcpt
         NopSRsBA5M65wcgukaFms8POxpboeOLJch15WXk7LmQsLbxeO7kVhdB4o+sNbRadbvqX
         2n+xbqh3LSRnzeGf8G8tviOS7qFdGOxXLYVXIqXajO7hPhfouI2x/qnr0/PPl9dP2S/y
         3fEKKuHFq1E5FI9Noul5qhv+jdvaRFQPO4UKzRa1HK126Q6WuUSjhAVjK2HUKQuO8VsF
         CpPJVcT5aWhgP8gX/uTVIYXQSPZJskhniWvxmF8uDQuGn0TiUEXC7cucVMde5meTTn7q
         X9Tg==
X-Gm-Message-State: AOAM533K/Onju6ZAaB2wdQQqBFN24sxXrzK2GVMGYuTkV/2r54FqGrbh
        yKXYyQ5jy7cdNuiqw61DSpSRKGEDqmWE1K9QV3Y=
X-Google-Smtp-Source: ABdhPJx7LqMx38R4RsnWQK5HPr+cvXGwFzBBYWXe0+5QjdbozORKzMU81+UFl2Z1gguiPei3wKqpOfLlOAXigshj7kM=
X-Received: by 2002:ac8:404b:: with SMTP id j11mr5747510qtl.140.1632997857946;
 Thu, 30 Sep 2021 03:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210930000042.10147-1-wqu@suse.com> <20210930000042.10147-3-wqu@suse.com>
 <CAL3q7H7ccjnLQM9Hawe3VtRkcYVM__jCqJRZ-BjaYJzfYQ+2Yg@mail.gmail.com> <7c1442f6-9d2c-03f8-200a-1a6132a1a419@gmx.com>
In-Reply-To: <7c1442f6-9d2c-03f8-200a-1a6132a1a419@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Sep 2021 11:30:21 +0100
Message-ID: <CAL3q7H7qytwkFCV856rU2COvV9ry-H6120UtuH5RmZnsoFUmoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs-progs: misc-tests: add test case for receive --clone-fallback
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 11:18 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/30 18:03, Filipe Manana wrote:
> > On Thu, Sep 30, 2021 at 1:06 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> The new test case will create two send streams:
> >>
> >> - parent_stream
> >>    A full send stream.
> >>    Contains one file, as clone source.
> >>
> >> - clone_stream
> >>    An incremental send stream.
> >>    Contains one clone operation.
> >>
> >> Then we will receive the parent_stream with default mount options, whi=
le
> >> try to receive the clone_stream with nodatasum mount option.
> >>
> >> This should result clone failure due to nodatasum flag mismatch.
> >>
> >> Then check if the receive can continue with --clone-fallback option.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   .../049-receive-clone-fallback/test.sh        | 60 +++++++++++++++++=
++
> >>   1 file changed, 60 insertions(+)
> >>   create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.=
sh
> >>
> >> diff --git a/tests/misc-tests/049-receive-clone-fallback/test.sh b/tes=
ts/misc-tests/049-receive-clone-fallback/test.sh
> >> new file mode 100755
> >> index 000000000000..d383c0e08a68
> >> --- /dev/null
> >> +++ b/tests/misc-tests/049-receive-clone-fallback/test.sh
> >> @@ -0,0 +1,60 @@
> >> +#!/bin/bash
> >> +# Verify that btrfs receive can fallback to buffered copy when clone
> >> +# failed
> >> +
> >> +source "$TEST_TOP/common"
> >> +
> >> +check_prereq mkfs.btrfs
> >> +check_prereq btrfs
> >> +setup_root_helper
> >> +prepare_test_dev
> >> +
> >> +tmp=3D$(mktemp -d --tmpdir btrfs-progs-send-stream.XXXXXX)
> >> +
> >> +# Create two send stream, one as the parent and the other as an incre=
mental
> >
> > stream -> streams
> >
> >> +# stream with one clone operation.
> >> +run_check_mkfs_test_dev
> >> +run_check_mount_test_dev -o datacow,datasum
> >> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv"
> >
> > You can use the default subvolume and therefore avoid creating a
> > subvolume and making the test longer than needed.
> > Your call.
>
> I understand we can use the default fs tree, but I just can't find my
> mind at peace when doing snapshoting of fs tree.
>
> It always remind me of the bad memories using hacky way to solve the
> qgroup problem for such snapshot.

I don't get it.
The fs tree is a subvolume like any other, it was always possible to
create snapshots of it, and snapshotting it is done the same way as
for any other subvolume (both in terms of api and at the
implementation level).
So I don't see anything "hacky" about it, and it feels very natural and com=
mon.

So I don't understand the relation with solving some qgroup related
problems in a "hacky" way.

You can leave it though.

>
> Thus I always try to avoid snapshotting fs tree.
>
> >
> >> +run_check $SUDO_HELPER dd if=3D/dev/zero bs=3D1M count=3D1 of=3D"$TES=
T_MNT/subv/file1"
> >> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/=
subv" \
> >> +       "$TEST_MNT/snap1"
> >> +run_check $SUDO_HELPER cp --reflink=3Dalways "$TEST_MNT/subv/file1" \
> >> +       "$TEST_MNT/subv/file2"
> >> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/=
subv" \
> >> +       "$TEST_MNT/snap2"
> >> +
> >> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/parent_stream" \
> >> +       "$TEST_MNT/snap1"
> >> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/clone_stream" \
> >> +       -p "$TEST_MNT/snap1" "$TEST_MNT/snap2"
> >> +
> >> +run_check_umount_test_dev
> >> +run_check_mkfs_test_dev
> >> +
> >> +# Now we have the needed stream, try to receive them with different m=
ount
> >
> > Reading this is confusing, it mentions receiving them with different
> > mount options, but they are the same for the first receive.
> >
> >> +# options
> >> +run_check_mount_test_dev -o datacow -o datasum
> >> +
> >> +# Receiving the full stream should not fail
> >> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/parent_stream" "=
$TEST_MNT"
> >> +
> >> +# No remount helper, so here we manually unmoutn and re-mount with di=
fferent
> >> +# nodatasum option
> >
> > Seems pointless to mention there's a lack of a remount helper in the
> > test framework.
> > Just say that now we mount the filesystem with nodatasum so that the
> > new file received through the incremental stream ends up with the
> > nodatasum flag set.
>
> Or maybe I should just add run_check_remount_test().
>
> Thanks for the review,
> Qu
>
> >
> > Thanks.
> >
> >> +run_check_umount_test_dev
> >> +run_check_mount_test_dev -o datacow,nodatasum
> >> +
> >> +# Receiving incremental send stream without --clone-fallback should f=
ail.
> >> +# As the clone source and destination have different NODATASUM flags
> >> +run_mustfail "receiving clone with different NODATASUM should fail" \
> >> +       $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/clone_stream" "$TES=
T_MNT"
> >> +
> >> +# Firstly we need to cleanup the partially received subvolume
> >> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "$TEST_MNT/snap2=
"
> >> +
> >> +# With --clone-fallback specified, the receive should finish without =
problem
> >> +run_check $SUDO_HELPER "$TOP/btrfs" receive --clone-fallback \
> >> +       -f "$tmp/clone_stream" "$TEST_MNT"
> >> +run_check_umount_test_dev
> >> +
> >> +rm -rf -- "$tmp"
> >> --
> >> 2.33.0
> >>
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
