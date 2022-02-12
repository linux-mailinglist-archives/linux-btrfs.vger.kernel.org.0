Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A64B324A
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 02:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354505AbiBLBFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 20:05:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiBLBFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 20:05:51 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63FD82
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 17:05:49 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p5so29585212ybd.13
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 17:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxQVHviVKuleA4DgItET3cSucmU6/FrXpWdNCX8Qya8=;
        b=jVfintLfknz0vDaFfi09mKU/RqKHo/+UrbKZicDL9nsaz1ZjBh8xX5V4hYDnkSRb0C
         ZTZacKbhtdo4SfZ9A6yCURk9bSbUV8vBbOyWku0AstosiQtzP5d+0SM676+bXHzceAC3
         sX6i25s8HmuQvMSvs/xvhTS2a3zuN7kzuYTyT2SBZpRB6szEtttZLLcNenqc0+2cH9CB
         NtFlY2zLuPixaJ/bsIKzCtKZijRcI2DXn/91636CQTwzPdRcJq93OB10N9oIXWwrCGXQ
         2YZDffKnojFZw3jQaDFcJUJ+ZKoNj7x+N/7Bf3gWvLKvObhITk00fanjv9R9PCSa3PwO
         nwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxQVHviVKuleA4DgItET3cSucmU6/FrXpWdNCX8Qya8=;
        b=UVC2UO0Z1slvfXAICAiEHkC+kjeRWsmV+vE3885y6ikJvQw3Dt58pY++z+24LIbxEd
         wIaw68T1bmCZuRMkaXKbmjklNOYTr4vbFuJskwX5FAQY5uQLWhaeLbPgTQVWa7hSrhbE
         J/e82pB0GoYepi12BoUlECJazTMLUIk6AauPJTvgyvMLbHa6BmmfJQWEN/LMSgdo/L3B
         +gJt6apce3GJfi2TIOTsCMe+p8YMHjO9KF1UL029XPw05SN+TuLL9ojg00FLRgbUDs38
         Fr7q7LzPrRRxpXOImof5sz2EvmuLU5UyC5jTb7U+KRIz6jY0MfpmTyE2nFzOM2TDdpA4
         O+vQ==
X-Gm-Message-State: AOAM531GLeZ3MkaEceyK3q4exZyzaIvY6Sc2FSqEa/P99v//xMa/e6yc
        eNf/M39vbMINIxbaT/fk6I6oMXXClNuD0EKhxIlthIDbk42pxuUI
X-Google-Smtp-Source: ABdhPJx5nxhLk13zEs+K2jNIEq8oInOXQgxWZcYI6aFGs9aopIO998AE78pgFX48vNTSMmbn4TBSkxFKlgTAas+oSAk=
X-Received: by 2002:a5b:d4f:: with SMTP id f15mr3838635ybr.239.1644627948538;
 Fri, 11 Feb 2022 17:05:48 -0800 (PST)
MIME-Version: 1.0
References: <CA+XNQ=hiF0us76Odk=0Kc5d2qoviY2OL2+KJnkJUSRjozGRGwg@mail.gmail.com>
In-Reply-To: <CA+XNQ=hiF0us76Odk=0Kc5d2qoviY2OL2+KJnkJUSRjozGRGwg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 11 Feb 2022 18:05:32 -0700
Message-ID: <CAJCQCtQVPmLmOVkHWmf7DzQCHLaUhhL24Kyb65K=JYmKAkrNAQ@mail.gmail.com>
Subject: Re: BTRFS FS options on eMMC
To:     Gowtham <trgowtham123@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 5:42 PM Gowtham <trgowtham123@gmail.com> wrote:
>
> Hi
>
> We are using BTRFS on eMMC as our application needs it. It is fairly stable.
>
> Seeing errors like below when we powercycle the box (which cannot be
> avoid for our test case but done occasionally)
>
> Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
> Begin: Running /scripts/local-premount ... [    4.334033] Btrfs
> loaded, crc32c=crc32c-generic
> Scanning for Btrfs filesystems
> [    4.390977] BTRFS: device label rpool devid 1 transid 64872 /dev/mmcblk0p2
> done.
> Begin: Will now check root file system ... fsck from util-linux 2.34
> [/usr/sbin/fsck.btrfs (1) -- /dev/mmcblk0p2] fsck.btrfs -a /dev/mmcblk0p2
> done.
> [    4.448780] BTRFS info (device mmcblk0p2): disk space caching is enabled
> [    4.448801] BTRFS info (device mmcblk0p2): has skinny extents
> [    4.464891] BTRFS info (device mmcblk0p2): enabling ssd optimizations
> [    4.464915] BTRFS info (device mmcblk0p2): start tree-log replay
> [    4.485747] BTRFS: error (device mmcblk0p2) in
> btrfs_replay_log:2287: errno=-22 unknown (Failed to recover log tree)
> [    4.485794] BTRFS info (device mmcblk0p2): delayed_refs has NO entry
> [    4.579954] BTRFS error (device mmcblk0p2): open_ctree failed
> mount: mounting /dev/mmcblk0p2 on /root failed: Invalid argument

You could use mount option 'notreelog' and accept slower fsync
performance (fsync becomes a full fs sync as i understand it so it
could be a significant performance impact).

I'm not sure why it's failing to recover. Could be the device didn't
get all the tree log writes to stable media before the power cycle.
This is decently common with consumer SD Cards. eMMC should be more
reliable but *shrug* maybe in this case it's dropping writes on a
power cycle. A ridiculously long delay in power cycling may not help
test this because eventually Btrfs will write all the pending metadata
updates and clear the tree log.

You could test 5.17 on a btrfs that's failing to mount with this error
to test if it's something newer kernels can handle. It could still be
a kernel bug writing out the tree log though, so you you'd need to
test a newer kernel being active during fsync operations followed by
the abrupt power cycle.

It's a bit of a complicated operation because it requires a drive that
will actually commit writes to stable media when it returns success
for flush/FUA; and a kernel that's writing to the tree log correctly,
and a kernel that's replaying the tree log correctly. And I'm seeing
in linux git log quite a lot of commits against tree-log.c since
kernel 5.4.

At least, hopefully you're using 5.4.179 already, just because that
has all available stable backports so far. But I think most developers
would encourage updating the kernel to something quite a lot newer.
Ideally, current stable series 5.16, or 5.15 series is a longterm
kernel.


-- 
Chris Murphy
