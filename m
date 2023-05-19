Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F11E70944F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjESJ7G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjESJ67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 05:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613391711;
        Fri, 19 May 2023 02:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84F7664315;
        Fri, 19 May 2023 09:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE17AC433D2;
        Fri, 19 May 2023 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684490331;
        bh=0wwhfn4BUmmnJWOa/xMUkpX+9wPbP+XwDtAw1NMRprc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=glwyyNx6GexfHo3rIW0dJ1VpdGpa26Lx2WX9EODFuqZrUgbaNUDq3X7N4TdWhaQof
         AwpbhrwM002yJJ1tQQ23OdYxOXu1ae/Ki9Dw91WXBmQ2ElngBry+Q5jP3GAWiI8wiE
         KL2BAXjmqyqoDSrnXPTphl8YumaHsuwiLaHCeHG0IOogOu9dzb34iEeFbdBYAAT36+
         oYYsv7bwgHtfEzLBcJPdLkUfXvleD6bsYZNDoykaLXY/UhPLXJW4z6Ueq2KEEPq6f0
         nIl0a1t59Oinq8t19OhmR3V6W5oTjylX+m0kX6t8uPfKMhMUUluF6uK3efg7Yi8haf
         NyaWKx2UWqoDg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-199bcf78252so2258394fac.3;
        Fri, 19 May 2023 02:58:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDzdJ06kz+vqx/mhP8fb0JRGyjbmYwtniB9R7uQr+NENdRizldAy
        4Z9dNQ1l0zQtAiyY9BwFm2Yzw5HgxwVKXAlm0x8=
X-Google-Smtp-Source: ACHHUZ7KksyQKdsLWjXMg7jXowf6zwtJ0bTIYzruSMJFGrjb5MCmb5WAk7Q5cNA8XkeGR082ZMTb316r+8+a1qjPsFA=
X-Received: by 2002:a05:6870:4ed:b0:187:9bd7:26c3 with SMTP id
 u45-20020a05687004ed00b001879bd726c3mr793167oam.23.1684490330057; Fri, 19 May
 2023 02:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
 <966568ad-de9c-e395-1ee4-1b9028987df2@oracle.com>
In-Reply-To: <966568ad-de9c-e395-1ee4-1b9028987df2@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 19 May 2023 10:58:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7TFS4M5pqZLyYXgAn06N7decYuCv3DbiZ8Yb-Kp=M-+Q@mail.gmail.com>
Message-ID: <CAL3q7H7TFS4M5pqZLyYXgAn06N7decYuCv3DbiZ8Yb-Kp=M-+Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs/213: avoid occasional failure due to already
 finished balance
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 19, 2023 at 6:05=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 18/5/23 19:08, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > btrfs/213 writes data, in 1M extents, for 4 seconds into a file, then
> > triggers a balance and then after 2 seconds it tries to cancel the
> > balance operation. More often than not, this works because the balance
> > is still running after 2 seconds. However it also fails sporadically
> > because balance has finished in less than 2 seconds, which is plausible
> > since data and metadata are cached or other factors such as virtualized
> > environment. When that's the case, it fails like this:
> >
> >    $ ./check btrfs/213
> >    FSTYP         -- btrfs
> >    PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc1-btrfs-next-131+ #1 S=
MP PREEMPT_DYNAMIC Thu May 11 11:26:19 WEST 2023
> >    MKFS_OPTIONS  -- /dev/sdc
> >    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> >    btrfs/213 51s ... - output mismatch (see /home/fdmanana/git/hub/xfst=
ests/results//btrfs/213.out.bad)
> >        --- tests/btrfs/213.out        2020-06-10 19:29:03.822519250 +01=
00
> >        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad 2=
023-05-17 15:39:32.653727223 +0100
> >        @@ -1,2 +1,3 @@
> >         QA output created by 213
> >        +ERROR: balance cancel on '/home/fdmanana/btrfs-tests/scratch_1'=
 failed: Not in progress
> >         Silence is golden
> >        ...
> >        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/213.ou=
t /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad'  to see the e=
ntire diff)
> >    Ran: btrfs/213
> >    Failures: btrfs/213
> >    Failed 1 of 1 tests
> >
> > To make it much less likely that balance has already finished before we
> > try to cancel it, unmount and mount again the filesystem before startin=
g
> > balance, to clear cached metadata and data, and also double the time we
> > spend writing 1M data extents. Also ignore when the balance failed beca=
use
> > it was already finished when we tried to cancel it.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/213 | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/btrfs/213 b/tests/btrfs/213
> > index 8a10355c..cca0b3cc 100755
> > --- a/tests/btrfs/213
> > +++ b/tests/btrfs/213
> > @@ -28,7 +28,7 @@ _require_xfs_io_command pwrite -D
> >   _scratch_mkfs >> $seqres.full
> >   _scratch_mount
> >
> > -runtime=3D4
> > +runtime=3D8
> >
> >   # Create enough IO so that we need around $runtime seconds to relocat=
e it.
> >   #
> > @@ -39,11 +39,18 @@ sleep $runtime
> >   kill $write_pid
> >   wait $write_pid
> >
> > +# Unmount and mount again the fs to clear any cached data and metadata=
, so that
> > +# it's less likely balance has already finished when we try to cancel =
it below.
> > +_scratch_cycle_mount
> > +
> >   # Now balance should take at least $runtime seconds, we can cancel it=
 at
> >   # $runtime/2 to ensure a success cancel.
> >   _run_btrfs_balance_start -d --bg "$SCRATCH_MNT"
>
>
> > -sleep $(($runtime / 2))
> > -$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> > +sleep $(($runtime / 4))
> > +# It's possible that balance has already completed. It's unlikely but =
often
> > +# it may happen due to virtualization, caching and other factors, so i=
gnore
> > +# any error about no balance currently running.
> > +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iv 'not in=
 progress'
>
> Cancel is an important step in this test case.
> Why not call _notrun() if the test case fails to make sure
> the balance is still in progress? This way, it provides
> another opportunity to fix.

Sounds reasonable. Sent a v2 with that.
Thanks.

>
> Thanks, Anand
>
> >
> >   # Now check if we can finish relocating metadata, which should finish=
 very
> >   # quickly.
>
