Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3A50BA26
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Apr 2022 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448693AbiDVOeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448569AbiDVOeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 10:34:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC775A5A6;
        Fri, 22 Apr 2022 07:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68A13B82EDB;
        Fri, 22 Apr 2022 14:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A1DC385A4;
        Fri, 22 Apr 2022 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650637874;
        bh=jsBUInxvZH9heMmXUFPkdRuExl9G/3qW/JTtoEit3jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cwoedock6kTEUf2zpSv5RktPkI6V9QmGM54zDF05/LGOH6k2KUArI1OMDYxTaUNsM
         zMe5p080PlIWfMmCC8FWTBvDhwgMgvgrUOyJAVVji93phx8VChPTdPSYSZNnviEOa4
         U3Nz+sNA+uNInRAdflwclDqxIXQbxGAG6nWeZBa4RQS9uxNDNaP1CerKT/q4nwX4mF
         73VQ05miuqOL/FAE1f50k6DYW/xeu48eBjDUAyZ2cPBuVNAR+zKWp3jsxjBfVj88K7
         R0F1ZocX3IW7jZfkSXB1UbBXV/PekqIe4tFXArenVCpneHsiKJtm9rl5IZpDWAU/rx
         lTRxUY1ILOfRg==
Date:   Fri, 22 Apr 2022 15:31:11 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>, fstests@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>, nborisov@suse.com,
        David Sterba <dsterba@suse.com>, kernel@cccheng.net
Subject: Re: [PATCH] fstests: btrfs: test setting compression via xattr on
 nodatacow files
Message-ID: <YmK8LwtOisHLsXjs@debian9.Home>
References: <20220418075430.484158-1-cccheng@synology.com>
 <Yl7MsVxpaYWfIEZH@debian9.Home>
 <CAHuHWtnCxSgh+JOOHhPQc_4A0f9O6DCXUz3vBVZg6riOQg01FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHuHWtnCxSgh+JOOHhPQc_4A0f9O6DCXUz3vBVZg6riOQg01FA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 22, 2022 at 07:11:42PM +0800, Chung-Chiang Cheng wrote:
> Hi Filipe,
> 
> > > +_require_scratch
> > > +_require_chattr C
> > > +_require_chattr c
> >
> > This require, for chattr c, is not needed, since the test never calls
> > chattr with +c or -c.
> >
> > It also misses a call to:
> >
> > _require_attrs
> >
> > Due to the calls to setfattr and lsattr.
> 
> Thanks for your notification. I'll fix these issues.
> 
> 
> > root 15:43:50 /home/fdmanana/git/hub/xfstests (master)> diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/264.out /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad
> > --- /home/fdmanana/git/hub/xfstests/tests/btrfs/264.out 2022-04-19 14:49:03.845696283 +0100
> > +++ /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad  2022-04-19 15:43:50.413816742 +0100
> > @@ -1,9 +1,9 @@
> >  QA output created by 264
> >  SCRATCH_MNT/foo ---
> >  SCRATCH_MNT/foo Compression_Requested
> > -SCRATCH_MNT/foo ---
> > +SCRATCH_MNT/foo Dont_Compress
> >  SCRATCH_MNT/foo Compression_Requested
> > -SCRATCH_MNT/foo ---
> > +SCRATCH_MNT/foo Dont_Compress
> >  SCRATCH_MNT/foo Compression_Requested
> >  SCRATCH_MNT/bar No_COW
> >  setfattr: SCRATCH_MNT/bar: Invalid argument
> > root 15:43:52 /home/fdmanana/git/hub/xfstests (master)>
> >
> > So the test needs to be updated and tested on a recent kernel.
> > Other than that, it looks fine to me.
> 
> I can see why my output is different from yours. I tested this item with
> the latest upstream kernel, but my `chattr` comes from e2fsprogs-1.45.5,
> which does not yet support Dont_Compress. This test relies on a recent
> chattr, but `_require_attrs` does not check its version. In any case, I
> will send a v2 patch based on the latest chattr.

Ah, that's interesting.
Indeed, I tested on a box with e2fsprogs 1.46.5.
Switching to 1.45.5, the test passes after the btrfs fix is applied.

Looking at the e2fsprogs git history the behaviour changed in 1.46.2:

	commit 1f4a5aba59f39a33a84152b5ae3ec0a5657b12a1
	Author: Lennart Poettering <lennart@poettering.net>
	Date:   Thu Feb 25 12:33:35 2021 -0500

	    chattr/lsattr: expose FS_NOCOMP_FL (aka EXT2_NOCOMPR_FL)

Before that, lsattr never printed anything if the 'no compress' bit was set.

So generally test cases for fstests are written such that the test passes with
any version of a particular tool, or it requires a minimum version to run (and
is skipped on older versions).

We do the former approach using filters on the output of a tool, converting the
output from an older version to match the output of a new version.
Though in this case it would be tricky, because we really want to distinguish
between having the 'no compress' bit set versus not having it set. And setting
the value 'no' or 'none' for the btrfs.compression xattr, means setting the
'no compress' bit, therefore we want to verify it's set.

Making the test require e2fsprogs 1.46.2+, is tricky: lsattr has no '--version'
flag to query the version, the only way would be to use distro specific commands
to check the e2fsprogs version (e.g. "apt-cache policy e2fsprogs" on debian for
example). The only way I can think of now is to add a require helper that tests
the output of lsattr after setting 'no compress' - if it ouputs 'Dont_Compress',
then it's 1.46.2+, otherwise something older.

That's complex, so a simple way would be to make the test fail if compression is
still set after the setfattr, instead of relying on the exact output of lsattr.
Something like this:

  $SETFATTR_PROG -n btrfs.compression -v no "$test_file" |& _filter_scratch
  $LSATTR_PROG -l "$test_file" | grep -q 'Compression_Requested'
  [ $? -eq 0 ] && echo "Compression is still set in the file"

With a comment somewhere before mentioning the behaviour change in e2fsprogs 1.46.2,
and removing the lsattr output from the golden output file (264.out).

This way the test serves its purpose, to test we can not set both compress and nodatacow,
and runs with any version of e2fsprogs. 1.46.2 is about 1 year old, and most enterprise
distros are very likely using an older version - we want the test to be able to run on them.

Thanks.

> 
> Thanks.
