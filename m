Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B164665AD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358780AbhLBOtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 09:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358733AbhLBOsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 09:48:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3FC06174A;
        Thu,  2 Dec 2021 06:45:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B57E4CE2301;
        Thu,  2 Dec 2021 14:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A35C53FCC;
        Thu,  2 Dec 2021 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638456327;
        bh=Xfcfw3JWtrMV0Rf9FQxiXQT5spatfb8Gea2Kf++dZp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sehmH91SePOwMIztFcj+oyAJERDwEipcKYQp6B+VvnyUWjv3bzKQxGWiMqjR8VzwY
         5O8/witt8Iu7Mr3xKFkZAglvGFNji1Uvv3gL+TC7Oe2A2mn5h/sNLbaigRgPG/gc6q
         vslHJaFmuOD4ZAEj75cyW3uX68GgiC4lYQjZLczNdUBFJUQw1l7cKuXkXVPmbUXUSI
         PcUP3yAWxGgLudTWT8LG4Ycdh9I4UEX2+GQ7Red4G+qY8H8YWA+KP3RPuidJdg1CUs
         bJzBTQjUryk7xYjD59sbLZX7JphVqvbQgJE6Im+zFcf7a+MohMN5l62fO4dm8RzJ0k
         NY87si5m1u3oQ==
Date:   Thu, 2 Dec 2021 14:45:24 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: UDEV_SETTLE_PROG before dmsetup create
Message-ID: <YajcBNMm3dR4YI/N@debian9.Home>
References: <ebf63c27065c5fa676701184501353a9f2014832.1638382705.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf63c27065c5fa676701184501353a9f2014832.1638382705.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 01, 2021 at 01:18:52PM -0500, Josef Bacik wrote:
> We've been seeing transient errors with any test that uses a dm device
> for the entirety of the time that we've been running nightly xfstests

I have been having it on my tests vms since ever as well.
It's really annoying, but fortunatelly it doesn't happen too often.

> runs.  This turns out to be because sometimes we get EBUSY while trying
> to create our new dm device.  Generally this is because the test comes
> right after another test that messes with the dm device, and thus we
> still have udev messing around with the device when DM tries to O_EXCL
> the block device.
> 
> Add a UDEV_SETTLE_PROG before creating the device to make sure we can
> create our new dm device without getting this transient error.

I suspect this might only make it seem the problem goes away but does not
really fix it.

I say that for 2 reasons:

1) All tests that use dm end up calling _dmsetup_remove(), like through
   _log_writes_remove() or _cleanup_flakey() for example. Normally those
   are called in the _cleanup() function, which ensures it's done even if
   the test fails for some reason.

   So I don't understand why we need that UDEV_SETTLE_PROG at _dmsetup_create().

   And I've seen the ebusy failure happen even when the previous tests did
   not use any dm device;

2) Some tests fail after creating the dm device and using it. For example
   btrfs/206 often fails when it tries to fsck the filesystem:

   btrfs/206 3s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad)
        --- tests/btrfs/206.out     2020-10-16 23:13:46.554152652 +0100
        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad      2021-12-01 21:09:46.317632589 +0000
        @@ -3,3 +3,5 @@
        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
        wrote 8192/8192 bytes at offset 0
        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
        +_check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
        +(see /home/fdmanana/git/hub/xfstests/results//btrfs/206.full for details)
        ...

       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/206.out /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad'  to see the entire diff)

    In the .full file I got:

    (...)
    replaying 1239@11201: sector 2173408, size 16384, flags 0x10(METADATA)
    replaying 1240@11234: sector 0, size 0, flags 0x1(FLUSH)
    replaying 1241@11235: sector 128, size 4096, flags 0x12(FUA|METADATA)
    _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
    *** fsck.btrfs output ***
    ERROR: cannot open device '/dev/sdc': Device or resource busy
    ERROR: cannot open file system
    Opening filesystem to check...
    *** end fsck.btrfs output
    *** mount output ***

   The ebusy failure is not when the test starts, but when somewhere in the middle
   of the replay loop when it calls fsck, or when it ends and the fstests framework
   calls fsck.

   I've seen that with btrfs/172 too, which also uses dm logwrites in a similar way.

So to me this suggests 2 things:

1) Calling UDEV_SETTLE_PROG at _dmsetup_create() doesn't solve that problem with
   btrfs/206 (and other tests) - the problem is fsck failing to open the scratch
   device after it called _log_writes_remove() -> _dmsetup_remove(), and not a
   failure to create the dm device;

2) The problem is likely something missing at _dmsetup_remove(). Perhaps add
   another UDEV_SETTLE_PROG there:

   diff --git a/common/rc b/common/rc
   index 8e351f17..22b34677 100644
   --- a/common/rc
   +++ b/common/rc
   @@ -4563,6 +4563,7 @@ _dmsetup_remove()
            $UDEV_SETTLE_PROG >/dev/null 2>&1
            $DMSETUP_PROG remove "$@" >>$seqres.full 2>&1
            $DMSETUP_PROG mknodes >/dev/null 2>&1
    +       $UDEV_SETTLE_PROG >/dev/null 2>&1
     }
 
    _dmsetup_create()

  I can't say if that change to _dmsetup_remove() is correct, or what it's
  needed, as I really haven't spent time trying to figure out why the issue
  happens.

    


> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  common/rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/rc b/common/rc
> index 8e351f17..35e861ec 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4567,6 +4567,7 @@ _dmsetup_remove()
>  
>  _dmsetup_create()
>  {
> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
>  	$DMSETUP_PROG create "$@" >>$seqres.full 2>&1 || return 1
>  	$DMSETUP_PROG mknodes >/dev/null 2>&1
>  	$UDEV_SETTLE_PROG >/dev/null 2>&1
> -- 
> 2.26.3
> 
