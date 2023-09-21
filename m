Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18FF7AA536
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 00:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjIUWvJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIUWvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 18:51:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885DC91
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 15:51:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB8C433CA
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695336661;
        bh=omty4blZ6sLaExjBt5iqII3AhN76FWlS1XzylqG5RSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bhaXpWml77fDPQo5svQj71/GlolN+aTE93MhIo558l3cQ91vkyvfSrcncyzY7AcyE
         K2AooUaYWvNX2VnhfuI1NvG+GBF+estJH6mzmhkpJgD4sjlceARv6lRzWkbvM1fxI3
         XQsRlnOIyPNCWfIc6i9MfW12TEhZUX7Q0LTAuseoDv1POk4SFOHMARE3CmaGoJRYNw
         F8uKTH05u3Hr4RxMHRHqE5v1dbKuezPQ+kg1L39Io8slulGUVpnQAvr9yFe6dUVe4g
         YqRLgXr4eiE0+7OjoO9bDFVaO500RajOVqog2bLRWftO7NZWWU5eLL6pemj+FnSi4G
         Xbmi+ix/rfL2A==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1d637f9c587so1532594fac.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 15:51:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZcHlrZ2grJbpeTKDmwi8S7ylPy5hLgfnYZGV3evOrcYiHzCUj
        zTqvcud4d4SSdEY9LTeutZYUpz9EfvHSHSOy0Nw=
X-Google-Smtp-Source: AGHT+IHiAuqnGN/7mpn0NzHlvIcBt6u7PwaxSi/cSeDCD2sfJHhZRNHwjCYhaTKrZvx629UzE47t87jdh8C94KfrvgY=
X-Received: by 2002:a05:6870:1606:b0:1b4:4c6d:765c with SMTP id
 b6-20020a056870160600b001b44c6d765cmr685546oae.26.1695336660314; Thu, 21 Sep
 2023 15:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
 <20230920190547.GI2268@twin.jikos.cz>
In-Reply-To: <20230920190547.GI2268@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 21 Sep 2023 23:50:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4Z79TMV6L3EM61-gCk1Z70OFT=VnPvN=fUbzCUm8oeKg@mail.gmail.com>
Message-ID: <CAL3q7H4Z79TMV6L3EM61-gCk1Z70OFT=VnPvN=fUbzCUm8oeKg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: adjust overcommit logic when very close to full
To:     dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
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

On Wed, Sep 20, 2023 at 11:44=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Mon, Sep 18, 2023 at 03:27:47PM -0400, Josef Bacik wrote:
> > A user reported some unpleasant behavior with very small file systems.
> > The reproducer is this
> >
> > mkfs.btrfs -f -m single -b 8g /dev/vdb
> > mount /dev/vdb /mnt/test
> > dd if=3D/dev/zero of=3D/mnt/test/testfile bs=3D512M count=3D20
> >
> > This will result in usage that looks like this
> >
> > Overall:
> >     Device size:                   8.00GiB
> >     Device allocated:              8.00GiB
> >     Device unallocated:            1.00MiB
> >     Device missing:                  0.00B
> >     Device slack:                  2.00GiB
> >     Used:                          5.47GiB
> >     Free (estimated):              2.52GiB      (min: 2.52GiB)
> >     Free (statfs, df):               0.00B
> >     Data ratio:                       1.00
> >     Metadata ratio:                   1.00
> >     Global reserve:                5.50MiB      (used: 0.00B)
> >     Multiple profiles:                  no
> >
> > Data,single: Size:7.99GiB, Used:5.46GiB (68.41%)
> >    /dev/vdb        7.99GiB
> >
> > Metadata,single: Size:8.00MiB, Used:5.77MiB (72.07%)
> >    /dev/vdb        8.00MiB
> >
> > System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
> >    /dev/vdb        4.00MiB
> >
> > Unallocated:
> >    /dev/vdb        1.00MiB
> >
> > As you can see we've gotten ourselves quite full with metadata, with al=
l
> > of the disk being allocated for data.
> >
> > On smaller file systems there's not a lot of time before we get full, s=
o
> > our overcommit behavior bites us here.  Generally speaking data
> > reservations result in chunk allocations as we assume reservation =3D=
=3D
> > actual use for data.  This means at any point we could end up with a
> > chunk allocation for data, and if we're very close to full we could do
> > this before we have a chance to figure out that we need another metadat=
a
> > chunk.
> >
> > Address this by adjusting the overcommit logic.  Simply put we need to
> > take away 1 chunk from the available chunk space in case of a data
> > reservation.  This will allow us to stop overcommitting before we
> > potentially lose this space to a data allocation.  With this fix in
> > place we properly allocate a metadata chunk before we're completely
> > full, allowing for enough slack space in metadata.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Added to misc-next, thanks.

So after this change, at least 2 test cases from fstests are failing
with -ENOSPC on misc-next:

$ ./check btrfs/156 btrfs/177
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.6.0-rc2-btrfs-next-138+ #1 SMP
PREEMPT_DYNAMIC Thu Sep 21 17:58:48 WEST 2023
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/156 14s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/156.out.bad)
    --- tests/btrfs/156.out 2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/156.out.bad
2023-09-21 23:41:49.911844058 +0100
    @@ -1,2 +1,6 @@
     QA output created by 156
    +ERROR: error during balancing
'/home/fdmanana/btrfs-tests/scratch_1': No space left on device
    +There may be more info in syslog - try dmesg | tail
    +ERROR: error during balancing
'/home/fdmanana/btrfs-tests/scratch_1': No space left on device
    +There may be more info in syslog - try dmesg | tail
     Silence is golden
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/156.out
/home/fdmanana/git/hub/xfstests/results//btrfs/156.out.bad'  to see
the entire diff)
btrfs/177 2s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad)
    --- tests/btrfs/177.out 2023-03-02 21:47:53.872609330 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad
2023-09-21 23:41:57.200117690 +0100
    @@ -1,4 +1,8 @@
     QA output created by 177
    +ERROR: error during balancing
'/home/fdmanana/btrfs-tests/scratch_1': No space left on device
    +There may be more info in syslog - try dmesg | tail
     Resized to 3221225472
    +ERROR: error during balancing
'/home/fdmanana/btrfs-tests/scratch_1': No space left on device
    +There may be more info in syslog - try dmesg | tail
     Text file busy
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/177.out
/home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad'  to see
the entire diff)
Ran: btrfs/156 btrfs/177
Failures: btrfs/156 btrfs/177
Failed 2 of 2 tests

The tests pass again after reverting this change.

Thanks.
