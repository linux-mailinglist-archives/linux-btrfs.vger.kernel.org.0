Return-Path: <linux-btrfs+bounces-204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36697F1D90
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 20:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209BB1F25317
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC67737145;
	Mon, 20 Nov 2023 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UXACml2P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdA0mpKd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA592;
	Mon, 20 Nov 2023 11:53:01 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EBC8E5C0ABF;
	Mon, 20 Nov 2023 14:52:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 20 Nov 2023 14:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1700509977; x=1700596377; bh=+AWNJrGXrrAethsmDsGzlF4mvdYF9sp19fg
	iz7FAD5k=; b=UXACml2Pye7oSVgGAPS4X33U9U6sEmjJUJrc5n6d81x5+u9ZrED
	DfTQnDcTsY6dn02mhe0CNIco9Dhq9rJOHDmgaWRaG3PdqBolM/B6fkMoCpTWda92
	4OG4E2H148eoTN9k6qlG1xljXoymuaWSDrziyZi/k4SWsGfH6MrwwugxgxtBHF2z
	rsSBnkcS+Su5uH2BBGrba1KUE8YkTT2iaR27fwxDZJL6MC9vGp1i1I6AKa7JW6G9
	JYZYX5+HCyJ+lFjccKL6FiUSii8QIXe7c6wSus8YVudJPjqPZOJpeX//RtBRWkX2
	LJPv7hlAiRW+obSHsyddQ5bzFa4QR0RQvWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700509977; x=1700596377; bh=+AWNJrGXrrAethsmDsGzlF4mvdYF9sp19fg
	iz7FAD5k=; b=OdA0mpKdgOhwvZmIUShaCZFzmDcLXk2v4PrkX8jx5TCtbOTQrdV
	9xWy3Iw8g41hfhmGwEFn+1AvyLbvFKKkwKPwNbUz0DMMpB5knBCoJ+GNTdkbDAQS
	GaM2xZVkZE8MOJ4jWbvbSiJK/v/PFy5EvWFy1kR6PInOlD0AD/DJsCtRBDT7WOlO
	hvkLETfNTvfdbiJE5RSllcmgBLwyHNnzGxaxnSeUjoX2J1zN4QXUvMZ6GMIRCxjq
	XBra3V4hRnxJW9eOGCr1glatj/U2s0zunwEGuRvKs1OQlO1RaABjnzoun/4FWB2z
	47Y5ic7rcbL7UPzG4sRNXTK1Mg3qixDnrqQ==
X-ME-Sender: <xms:GblbZR6SnhipjzxhXetLvlNWvrzwQyl44qx4cYQ7o741fSwzgRxF3w>
    <xme:GblbZe5GafJ_IHhfF_UhKTgim0BgHUZQQH1cH89oCXRKqjQFb5fHn0ptTiEFvIYIv
    2xN9g0xuEKvxm3xPjE>
X-ME-Received: <xmr:GblbZYdfVYuzpnrgsbYy8rH_Iuvng7G5o3FmSk676pX2tGMIoBzqZpPAuom_CIyZBX3iH_03S40YqcA6rd5K0hOg5GI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegjedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    rhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrh
    hnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrih
    hssegsuhhrrdhioh
X-ME-Proxy: <xmx:GblbZaJihG4cnkaEhtHVOVPO0Z7huj88Uq3xm-zuBcZeZ5oryMBu3Q>
    <xmx:GblbZVJPl6SCrUbzjKMCmx2aiPJikHRA-4hDWZhqyK0_SppksnH5pQ>
    <xmx:GblbZTwOL8Jde19zezxkP__WJmYdHxNniFvWbPPzmXqnOYywj1TmjA>
    <xmx:GblbZcU0alNXQfPPAU-FUaU_se5ZH1TxXuI4kFOj1UdtotSlXZpdoA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 14:52:57 -0500 (EST)
Date: Mon, 20 Nov 2023 11:53:50 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs/301: fix hardcoded subvolids
Message-ID: <20231120195350.GA262427@zen.localdomain>
References: <cover.1700505679.git.boris@bur.io>
 <da0104f52b8253be8b905f77ce467acaf6afc9cd.1700505679.git.boris@bur.io>
 <CAL3q7H5XcFeFFTYjm84y+uc_Jz2eUSzcfq9OyxX3cs=gv2UDfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5XcFeFFTYjm84y+uc_Jz2eUSzcfq9OyxX3cs=gv2UDfw@mail.gmail.com>

On Mon, Nov 20, 2023 at 07:45:01PM +0000, Filipe Manana wrote:
> On Mon, Nov 20, 2023 at 6:44 PM Boris Burkov <boris@bur.io> wrote:
> >
> > Hardcoded subvolids break noholes test runs, so change the test to use
> > _btrfs_get_subvolid instead of assuming 256, 257, etc...
> 
> How exactly does no-holes affect the assigned IDs to subvolumes?
> It's a default feature for quite a while and the test passes with it
> and without it (-O ^no-holes).
> 
> Aren't you confusing this with enabling or disabling features that add
> some tree?
> Like disabling the free space tree (which is a default for quite a
> while now), for example.

Yes I am. Josef reported this to me and I misread the name of his
configuration that was failing. For completeness it was one that doesn't
use free space tree, like you say.

> 
> For me it fails with -O ^free-space-tree, and it fails even with this
> patch applied:

And didn't reproduce it, since he proposed the fix, which seemed
"straightforward" enough to me.

> 
> $ MKFS_OPTIONS="-O ^free-space-tree" ./check btrfs/301
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.6.0-rc5-btrfs-next-140+ #1 SMP
> PREEMPT_DYNAMIC Thu Oct 19 16:55:42 WEST 2023
> MKFS_OPTIONS  -- -O ^free-space-tree /dev/sdb
> MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/301 70s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/301.out.bad)
>     --- tests/btrfs/301.out 2023-10-18 23:29:06.029292800 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/301.out.bad
> 2023-11-20 19:33:04.988824928 +0000
>     @@ -13,6 +13,16 @@
>      fallocate: Disk quota exceeded
>      pwrite: Disk quota exceeded
>      enable mature
>     +ERROR: unable to limit requested quota group: No such file or directory
>     +/home/fdmanana/git/hub/xfstests/tests/btrfs/301: line 373: [:
> -lt: unary operator expected
>     +captured usage from before enable  >= 134217728
>     +/home/fdmanana/git/hub/xfstests/tests/btrfs/301: line 377: [:
> -lt: unary operator expected
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/301.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/301.out.bad'  to see
> the entire diff)
> Ran: btrfs/301
> Failures: btrfs/301
> Failed 1 of 1 tests
> 
> I see variables like subvid below being declared as global in one
> function and then used in other functions.

I tried to test that they get populated correctly (confused why it works
sometimes...)

But clearly it's broken in general and I'll do something more robust. I
think the basic problem is I call prepare() in each test function, so I
wanted prepare to set the global state, without making each test lookup
the subvolid. But it's not the end of the world to have the tests get it
one way or the other.

> Maybe there's something wrong with that... it would be cleaner to make
> the variable local and pass the subvolume id as an argument to other
> functions.
> 
> Thanks.

Thanks for catching the mistake.

> 
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  tests/btrfs/301 | 138 ++++++++++++++++++++++++------------------------
> >  1 file changed, 70 insertions(+), 68 deletions(-)
> >
> > diff --git a/tests/btrfs/301 b/tests/btrfs/301
> > index 7a0b4c0e1..5bb6b16a6 100755
> > --- a/tests/btrfs/301
> > +++ b/tests/btrfs/301
> > @@ -172,25 +172,27 @@ prepare()
> >         _scratch_mount
> >         enable_quota "s"
> >         $BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
> > -       set_subvol_limit 256 $limit
> > -       check_subvol_usage 256 0
> > +       subvid=$(_btrfs_get_subvolid $SCRATCH_MNT subv)
> > +       set_subvol_limit $subvid $limit
> > +       check_subvol_usage $subvid 0
> >
> >         # Create a bunch of little filler files to generate several levels in
> >         # the btree, to make snapshotting sharing scenarios complex enough.
> >         $FIO_PROG $prep_fio_config --output=$fio_out
> > -       check_subvol_usage 256 $total_fill
> > +       check_subvol_usage $subvid $total_fill
> >
> >         # Create a single file whose extents we will explicitly share/unshare.
> >         do_write $subv/f $ext_sz
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> >  }
> >
> >  prepare_snapshotted()
> >  {
> >         prepare
> >         $BTRFS_UTIL_PROG subvolume snapshot $subv $snap >> $seqres.full
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 0
> > +       snapid=$(_btrfs_get_subvolid $SCRATCH_MNT snap)
> 
> Make the variable local please.
> 
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid 0
> >  }
> >
> >  prepare_nested()
> > @@ -198,13 +200,13 @@ prepare_nested()
> >         prepare
> >         $BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> >         $BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
> > -       $BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqres.full
> > +       $BTRFS_UTIL_PROG qgroup assign 0/$subvid 1/100 $SCRATCH_MNT >> $seqres.full
> >         $BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
> >         do_write $nested/f $ext_sz
> > -       check_subvol_usage 257 $ext_sz
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       local subv_usage=$(get_subvol_usage 256)
> > -       local nested_usage=$(get_subvol_usage 257)
> > +       check_subvol_usage $snapid $ext_sz
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       local subv_usage=$(get_subvol_usage $subvid)
> > +       local nested_usage=$(get_subvol_usage $snapid)
> >         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> >  }
> >
> > @@ -214,8 +216,8 @@ basic_accounting()
> >         echo "basic accounting"
> >         prepare
> >         rm $subv/f
> > -       check_subvol_usage 256 $total_fill
> > -       cycle_mount_check_subvol_usage 256 $total_fill
> > +       check_subvol_usage $subvid $total_fill
> > +       cycle_mount_check_subvol_usage $subvid $total_fill
> >         do_write $subv/tmp 512M
> >         rm $subv/tmp
> >         do_write $subv/tmp 512M
> > @@ -245,19 +247,19 @@ snapshot_accounting()
> >         echo "snapshot accounting"
> >         prepare_snapshotted
> >         touch $snap/f
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid 0
> >         do_write $snap/f $ext_sz
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 $ext_sz
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid $ext_sz
> >         rm $snap/f
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid 0
> >         rm $subv/f
> > -       check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > -       cycle_mount_check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> > +       cycle_mount_check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> >         _scratch_unmount
> >  }
> >
> > @@ -267,14 +269,14 @@ delete_snapshot_src_ref()
> >         echo "delete src ref first"
> >         prepare_snapshotted
> >         rm $subv/f
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid 0
> >         rm $snap/f
> >         trigger_cleaner
> > -       check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > -       cycle_mount_check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> > +       cycle_mount_check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> >         _scratch_unmount
> >  }
> >
> > @@ -284,13 +286,13 @@ delete_snapshot_ref()
> >         echo "delete snapshot ref first"
> >         prepare_snapshotted
> >         rm $snap/f
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid 0
> >         rm $subv/f
> > -       check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > -       cycle_mount_check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> > +       cycle_mount_check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> >         _scratch_unmount
> >  }
> >
> > @@ -300,18 +302,18 @@ delete_snapshot_src()
> >         echo "delete snapshot src first"
> >         prepare_snapshotted
> >         $BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid 0
> >         rm $snap/f
> >         trigger_cleaner
> > -       check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> >         $BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
> >         trigger_cleaner
> > -       check_subvol_usage 256 0
> > -       check_subvol_usage 257 0
> > -       cycle_mount_check_subvol_usage 256 0
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid 0
> > +       check_subvol_usage $snapid 0
> > +       cycle_mount_check_subvol_usage $subvid 0
> > +       check_subvol_usage $snapid 0
> >         _scratch_unmount
> >  }
> >
> > @@ -321,12 +323,12 @@ delete_snapshot()
> >         echo "delete snapshot first"
> >         prepare_snapshotted
> >         $BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> > +       check_subvol_usage $snapid 0
> >         $BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
> >         trigger_cleaner
> > -       check_subvol_usage 256 0
> > -       check_subvol_usage 257 0
> > +       check_subvol_usage $subvid 0
> > +       check_subvol_usage $snapid 0
> >         _scratch_unmount
> >  }
> >
> > @@ -337,16 +339,16 @@ nested_accounting()
> >         echo "nested accounting"
> >         prepare_nested
> >         rm $subv/f
> > -       check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 $ext_sz
> > -       local subv_usage=$(get_subvol_usage 256)
> > -       local nested_usage=$(get_subvol_usage 257)
> > +       check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid $ext_sz
> > +       local subv_usage=$(get_subvol_usage $subvid)
> > +       local nested_usage=$(get_subvol_usage $snapid)
> >         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> >         rm $nested/f
> > -       check_subvol_usage 256 $total_fill
> > -       check_subvol_usage 257 0
> > -       subv_usage=$(get_subvol_usage 256)
> > -       nested_usage=$(get_subvol_usage 257)
> > +       check_subvol_usage $subvid $total_fill
> > +       check_subvol_usage $snapid 0
> > +       subv_usage=$(get_subvol_usage $subvid)
> > +       nested_usage=$(get_subvol_usage $snapid)
> >         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
> >         do_enospc_falloc $nested/large_falloc 2G
> >         do_enospc_write $nested/large 2G
> > @@ -365,21 +367,21 @@ enable_mature()
> >         # we did before enabling.
> >         sync
> >         enable_quota "s"
> > -       set_subvol_limit 256 $limit
> > +       set_subvol_limit $subvid $limit
> >         _scratch_cycle_mount
> > -       usage=$(get_subvol_usage 256)
> > +       usage=$(get_subvol_usage $subvid)
> >         [ $usage -lt $ext_sz ] || \
> >                 echo "captured usage from before enable $usage >= $ext_sz"
> >         do_write $subv/g $ext_sz
> > -       usage=$(get_subvol_usage 256)
> > +       usage=$(get_subvol_usage $subvid)
> >         [ $usage -lt $ext_sz ] && \
> >                 echo "failed to capture usage after enable $usage < $ext_sz"
> > -       check_subvol_usage 256 $ext_sz
> > +       check_subvol_usage $subvid $ext_sz
> >         rm $subv/f
> > -       check_subvol_usage 256 $ext_sz
> > +       check_subvol_usage $subvid $ext_sz
> >         _scratch_cycle_mount
> >         rm $subv/g
> > -       check_subvol_usage 256 0
> > +       check_subvol_usage $subvid 0
> >         _scratch_unmount
> >  }
> >
> > @@ -394,7 +396,7 @@ reflink_accounting()
> >                 _cp_reflink $subv/f $subv/f.i
> >         done
> >         # Confirm that there is no additional data usage from the reflinks.
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> >         _scratch_unmount
> >  }
> >
> > @@ -404,11 +406,11 @@ delete_reflink_src_ref()
> >         echo "delete reflink src ref"
> >         prepare
> >         _cp_reflink $subv/f $subv/f.link
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> >         rm $subv/f
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> >         rm $subv/f.link
> > -       check_subvol_usage 256 $(($total_fill))
> > +       check_subvol_usage $subvid $(($total_fill))
> >         _scratch_unmount
> >  }
> >
> > @@ -418,11 +420,11 @@ delete_reflink_ref()
> >         echo "delete reflink ref"
> >         prepare
> >         _cp_reflink $subv/f $subv/f.link
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> >         rm $subv/f.link
> > -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> > +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> >         rm $subv/f
> > -       check_subvol_usage 256 $(($total_fill))
> > +       check_subvol_usage $subvid $(($total_fill))
> >         _scratch_unmount
> >  }
> >
> > --
> > 2.42.0
> >
> >

