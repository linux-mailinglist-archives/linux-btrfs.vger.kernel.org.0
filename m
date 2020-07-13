Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00221D5C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgGMMWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 08:22:41 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.115]:19529 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgGMMWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 08:22:39 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id A27ED5B4126
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 07:22:31 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id uxTbj0ooXhmVTuxTbjZRQM; Mon, 13 Jul 2020 07:22:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YSHxxL1sI0xOqbkHZb4SQTGHfkboMkplH3QvR/HbykU=; b=FcNKoD2fCdMDr2JImbusYz0khr
        1OVnXklw8kSomMF+ulCybqHzRGHerEOlGc2mxrvRKKyt4uDj8yyEw3LKfwYb1YsOHtvF9x4p3lUmS
        RiS0rOk0qIDEG+VKWs0/Knt5xZNXc/OX6riLNvPWV6PvzN+7HBPy17BeDPofMLUjZFuBUGo5NogED
        TDbgJIcapBbeD9dfMTbFvEF1+muv6rVH8PbrYfFPbOZ6bX01o6lMy3ro74TeYdldccMY8IOSPWVyw
        1aQThjRHScgjXAet51PTrQUnYucDTr8V/bQtKqg31wT2ScXrCuvZ/qgG90IgjxtdvsdTgpyWU0DGQ
        3PVcNHBw==;
Received: from 179.187.204.46.dynamic.adsl.gvt.net.br ([179.187.204.46]:60234 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1juxTb-002CRh-3P; Mon, 13 Jul 2020 09:22:31 -0300
Message-ID: <2eea62e0d90e6948ae5210bebad80c206314656f.camel@mpdesouza.com>
Subject: Re: [PATCH] btrfs: Ignore output of "btrfs quota rescan"
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     fdmanana@gmail.com
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Mon, 13 Jul 2020 09:22:27 -0300
In-Reply-To: <CAL3q7H4PswiXqS_Zy+w58Oj8cv6iBHj-LYDN4-EmU-Q5PAEubA@mail.gmail.com>
References: <20200710185519.10322-1-marcos@mpdesouza.com>
         <CAL3q7H4PswiXqS_Zy+w58Oj8cv6iBHj-LYDN4-EmU-Q5PAEubA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.187.204.46
X-Source-L: No
X-Exim-ID: 1juxTb-002CRh-3P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.204.46.dynamic.adsl.gvt.net.br ([192.168.0.172]) [179.187.204.46]:60234
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-07-13 at 11:05 +0100, Filipe Manana wrote:
> On Fri, Jul 10, 2020 at 7:57 PM Marcos Paulo de Souza
> <marcos@mpdesouza.com> wrote:
> >
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> >
> > Some recent test already ignore this output, while older ones do
> not.
> > It can sometimes make tests fail because "quota rescan" can show
> the
> > message "quota rescan started". Ignoring the output of the command
> > solves this problem.
> 
> 
> Hi Marcos,
> 
> Can you elaborate exactly how it fails?

QA output created by 210
quota rescan started
Silence is goldenSure, my fault to not clarifying the error I was
facing. This only happens with btrfs/210, which fails for me:

QA output created by 210
quota rescan started
Silence is golden

I've never seen those tests fail due to an unexpected "quota rescan
> started" message.
> 
> I also don't see how this change fixes anything, because:
> 
> 1) The quota rescans are always executed - so we should always see
> such failure;

Yes, it's interesting because running other tests touched by this
patchset do not trigger the issue, but I thought it would be nice to
have this pattern among all tests that start a quota rescan. Any ideas
why this happens?

With this patch, specifically with the change on btrfs/210 solves the
issue for me as the message is dropped.

Thanks,
  Marcos

> 
> 2) More importantly _run_btrfs_util_prog is:
> 
> _run_btrfs_util_prog()
> {
>    run_check $BTRFS_UTIL_PROG $*
> }
> 
> and run_check:
> 
> run_check()
> {
>    echo "# $@" >> $seqres.full 2>&1
>    "$@" >> $seqres.full 2>&1 || _fail "failed: '$@'"
> }
> 
> So any output from _run_btrfs_util_prog is redirected to the test's
> .full file.
> It will not cause a mismatch with the golden output.
> 
> 
> >
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  tests/btrfs/017 | 2 +-
> >  tests/btrfs/022 | 4 ++--
> >  tests/btrfs/028 | 2 +-
> >  tests/btrfs/057 | 2 +-
> >  tests/btrfs/091 | 2 +-
> >  tests/btrfs/104 | 2 +-
> >  tests/btrfs/123 | 2 +-
> >  tests/btrfs/126 | 2 +-
> >  tests/btrfs/139 | 2 +-
> >  tests/btrfs/153 | 2 +-
> >  tests/btrfs/193 | 2 +-
> >  tests/btrfs/210 | 2 +-
> >  12 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/tests/btrfs/017 b/tests/btrfs/017
> > index 1bb8295b..a888b8db 100755
> > --- a/tests/btrfs/017
> > +++ b/tests/btrfs/017
> > @@ -64,7 +64,7 @@ $CLONER_PROG -s 0 -d 0 -l $EXTENT_SIZE
> $SCRATCH_MNT/foo \
> >              $SCRATCH_MNT/snap/foo-reflink2
> >
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> 
> So this is pointless, as mentioned before, any output is already
> redirected to the test's .full file.
> The same applies to all changes below.
> 
> So I fail to see what problem you are trying to solve.
> 
> Thanks.
> 
> >
> >  rm -fr $SCRATCH_MNT/foo*
> >  rm -fr $SCRATCH_MNT/snap/foo*
> > diff --git a/tests/btrfs/022 b/tests/btrfs/022
> > index aaa27aaa..442cc05c 100755
> > --- a/tests/btrfs/022
> > +++ b/tests/btrfs/022
> > @@ -38,7 +38,7 @@ _basic_test()
> >         echo "=== basic test ===" >> $seqres.full
> >         _run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> >         _run_btrfs_util_prog quota enable $SCRATCH_MNT/a
> > -       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> >/dev/null
> >         subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> >         $BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep
> $subvolid >> \
> >                 $seqres.full 2>&1
> > @@ -77,7 +77,7 @@ _rescan_test()
> >         echo "qgroup values before rescan: $output" >> $seqres.full
> >         refer=$(echo $output | awk '{ print $2 }')
> >         excl=$(echo $output | awk '{ print $3 }')
> > -       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> >/dev/null
> >         output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT |
> grep "0/$subvolid")
> >         echo "qgroup values after rescan: $output" >> $seqres.full
> >         [ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
> > diff --git a/tests/btrfs/028 b/tests/btrfs/028
> > index 98b9c8b9..4a574b8b 100755
> > --- a/tests/btrfs/028
> > +++ b/tests/btrfs/028
> > @@ -42,7 +42,7 @@ _scratch_mkfs >/dev/null
> >  _scratch_mount
> >
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >
> >  # Increase the probability of generating de-refer extent, and
> decrease
> >  # other.
> > diff --git a/tests/btrfs/057 b/tests/btrfs/057
> > index 82e3162e..aa1d429c 100755
> > --- a/tests/btrfs/057
> > +++ b/tests/btrfs/057
> > @@ -47,7 +47,7 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w
> -p 5 -n 1000 \
> >         $FSSTRESS_AVOID >&/dev/null
> >
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >
> >  echo "Silence is golden"
> >  # btrfs check will detect any qgroup number mismatch.
> > diff --git a/tests/btrfs/091 b/tests/btrfs/091
> > index 6d2a23c8..a4aeebc3 100755
> > --- a/tests/btrfs/091
> > +++ b/tests/btrfs/091
> > @@ -59,7 +59,7 @@ _run_btrfs_util_prog subvolume create
> $SCRATCH_MNT/subv2
> >  _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
> >
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >
> >  # if we don't support noinode_cache mount option, then we should
> double check
> >  # whether inode cache is enabled before executing the real test
> payload.
> > diff --git a/tests/btrfs/104 b/tests/btrfs/104
> > index f0cc67d6..d3338e35 100755
> > --- a/tests/btrfs/104
> > +++ b/tests/btrfs/104
> > @@ -113,7 +113,7 @@ _explode_fs_tree 1 $SCRATCH_MNT/snap2/files-
> snap2
> >  # Enable qgroups now that we have our filesystem prepared. This
> >  # will kick off a scan which we will have to wait for.
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >
> >  # Remount to clear cache, force everything to disk
> >  _scratch_cycle_mount
> > diff --git a/tests/btrfs/123 b/tests/btrfs/123
> > index 65177159..63b6d428 100755
> > --- a/tests/btrfs/123
> > +++ b/tests/btrfs/123
> > @@ -56,7 +56,7 @@ sync
> >
> >  # enable quota and rescan to get correct number
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >
> >  # now balance data block groups to corrupt qgroup
> >  _run_btrfs_balance_start -d $SCRATCH_MNT >> $seqres.full
> > diff --git a/tests/btrfs/126 b/tests/btrfs/126
> > index 8635791e..eceaabb2 100755
> > --- a/tests/btrfs/126
> > +++ b/tests/btrfs/126
> > @@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
> >  _scratch_mount "-o enospc_debug"
> >
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >  _run_btrfs_util_prog qgroup limit 512K 0/5 $SCRATCH_MNT
> >
> >  # The amount of written data may change due to different nodesize
> at mkfs time,
> > diff --git a/tests/btrfs/139 b/tests/btrfs/139
> > index 1b636e81..44168e2a 100755
> > --- a/tests/btrfs/139
> > +++ b/tests/btrfs/139
> > @@ -43,7 +43,7 @@ SUBVOL=$SCRATCH_MNT/subvol
> >
> >  _run_btrfs_util_prog subvolume create $SUBVOL
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >  _run_btrfs_util_prog qgroup limit -e 1G $SUBVOL
> >
> >
> > diff --git a/tests/btrfs/153 b/tests/btrfs/153
> > index f343da32..1f8e37e7 100755
> > --- a/tests/btrfs/153
> > +++ b/tests/btrfs/153
> > @@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
> >  _scratch_mount
> >
> >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >  _run_btrfs_util_prog qgroup limit 100M 0/5 $SCRATCH_MNT
> >
> >  testfile1=$SCRATCH_MNT/testfile1
> > diff --git a/tests/btrfs/193 b/tests/btrfs/193
> > index 16b7650c..8bdc7566 100755
> > --- a/tests/btrfs/193
> > +++ b/tests/btrfs/193
> > @@ -43,7 +43,7 @@ _scratch_mkfs > /dev/null
> >  _scratch_mount
> >
> >  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> > -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> > +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
> >  $BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
> >
> >  # Create a file with the following layout:
> > diff --git a/tests/btrfs/210 b/tests/btrfs/210
> > index daa76a87..a9a04951 100755
> > --- a/tests/btrfs/210
> > +++ b/tests/btrfs/210
> > @@ -46,7 +46,7 @@ _pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" >
> /dev/null
> >  # by qgroup
> >  sync
> >  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
> > -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
> > +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
> >  $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
> >
> >  # Create a snapshot with qgroup inherit
> > --
> > 2.26.2
> >
> 
> 

