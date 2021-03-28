Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596BC34BB2F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 07:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhC1FWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 01:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhC1FVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 01:21:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EE8C061762
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 22:21:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so9546515wrc.3
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K+gCsIPZ3sn1cI+Va5CjwFfp/h+DRTjb/2VqR+I21A=;
        b=G2EM2COkBE3eJk4fVjuY3IdBG8x97lPeToJT82k+d9Me8thskOi7B7gPVNERiPTt+S
         OfeJ2D2RQI987nDcGwDXr64vZ2YWjtZqjO2TnPMUHH5mZXyJg3GabO5ACmz2XFh7zsOx
         4XehFySXqZpNzGmupDSij5BEa+Y/tegToQSUky+B7rmvQ0ZHwMi/pN+4kGlQosXO+VQg
         1lSEHud8LtOrQs6KpCuRliC/wNoktN6ZS1YTgMIVxiW5QVqbyZjGavo8Jm3XPnoobadV
         U87i/A6xh5X26QLl6AoXBwGpDP88ldMdQS8JBFk2hevhJu77Cpb5v51FI4sva1pSYQMI
         nE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K+gCsIPZ3sn1cI+Va5CjwFfp/h+DRTjb/2VqR+I21A=;
        b=I4ZJ7zz0TuhdOwNR+Q1jHbfwBfRpWMwxnto8byqwUgIaJY+4qtcMs01BdAao6B0Pmn
         erRD4VpMPBOo7BEaY7TLrYIYk+NgS+JEXZSQFpoBR4SY4pXG3RuVDJWzg6/6K6LB4Qpw
         kSXkg2XmkGnuUOBk3pbrspuZB2/FUBNLGN+Tr9Hp4UlKInpVFFD3Az/UxTiEvW6XDfE3
         fIvarp0W66fb4ztSoobqih7wSJxtF3RgRGTtNMHbydZIB/UCP8I0ct3k2wp7nJsbVURB
         Y/FwvCQOWGt1oxY69a3w3mYjLfC/opQsUwos/RNBJo54P95NXLlk/blHKQTRleR29IUK
         aiLw==
X-Gm-Message-State: AOAM531t8AwbT0muVcUhbaP50n58chfkbAZEi/YOFi0RKYjBqf3782zG
        sDFdp/7086Mcwv70C+TL3FaUXB58CjsusWyXxJaT6YEB2Jv901kG
X-Google-Smtp-Source: ABdhPJzW2mAMsK6F9oCxs7oD3KeNyj6QAktSZJG4BupueB8ymkOGqRr3X/TtgIh/WP3PtTcG2iXTXQ/Iu9veEtYmm6g=
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr22363035wrz.42.1616908909105;
 Sat, 27 Mar 2021 22:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTv-xmDgRtoZFgmz=ny+SFYiTXqJS05VdRfkbST0L-ijQ@mail.gmail.com>
In-Reply-To: <CAJCQCtTv-xmDgRtoZFgmz=ny+SFYiTXqJS05VdRfkbST0L-ijQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 27 Mar 2021 23:21:32 -0600
Message-ID: <CAJCQCtRFM-qcAhwQPrEF1g4iG9Vamnk8rgh49HfT2Nty7H+OZg@mail.gmail.com>
Subject: Re: 5.12-rc4: rm directory hangs for > 1m on an idle system
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fresh boot, this time no compression, everything else the same. Time
to delete both directories takes as long as it takes to copy one of
them ~1m17s. This time I took an early and late sysrq t pair, and
maybe caught some extra stuff.

[ 1190.094618] kernel: Workqueue: events_unbound
btrfs_preempt_reclaim_metadata_space
[ 1190.094633] kernel: Call Trace:
[ 1190.094641] kernel:  ? find_extent_buffer+0x5/0x200
[ 1190.094656] kernel:  ? find_held_lock+0x32/0x90
[ 1190.094683] kernel:  ? __lock_acquire+0x172/0x1e10
[ 1190.094694] kernel:  ? lock_is_held_type+0xa7/0x120
[ 1190.094714] kernel:  ? btrfs_search_slot+0x6d2/0x9f0
[ 1190.094729] kernel:  ? btrfs_get_64+0x5e/0x100
[ 1190.094751] kernel:  ? lock_acquire+0xc2/0x3a0
[ 1190.094768] kernel:  ? _raw_spin_unlock+0x1f/0x30
[ 1190.094779] kernel:  ? rcu_read_lock_sched_held+0x3f/0x80
[ 1190.094798] kernel:  ? __lock_acquire+0x172/0x1e10
[ 1190.094811] kernel:  ? lookup_extent_backref+0x43/0xd0
[ 1190.094829] kernel:  ? release_extent_buffer+0xa3/0xe0
[ 1190.094846] kernel:  ? __btrfs_free_extent+0x49c/0x8f0
[ 1190.094878] kernel:  ? __btrfs_run_delayed_refs+0x29a/0x1270
[ 1190.094912] kernel:  ? _raw_spin_unlock+0x1f/0x30
[ 1190.094934] kernel:  ? btrfs_run_delayed_refs+0x86/0x210
[ 1190.094954] kernel:  ? flush_space+0x570/0x6d0
[ 1190.094966] kernel:  ? lock_release+0x280/0x410
[ 1190.094987] kernel:  ? btrfs_preempt_reclaim_metadata_space+0x170/0x2f0
[ 1190.095007] kernel:  ? process_one_work+0x2b0/0x5e0
[ 1190.095035] kernel:  ? worker_thread+0x55/0x3c0
[ 1190.095045] kernel:  ? process_one_work+0x5e0/0x5e0
[ 1190.095060] kernel:  ? kthread+0x13a/0x150
[ 1190.095070] kernel:  ? __kthread_bind_mask+0x60/0x60
[ 1190.095085] kernel:  ? ret_from_fork+0x1f/0x30

dmesg
https://drive.google.com/file/d/1VQNAVynVTJo6VqsRX9K5-Z0dMsLmb-vH/view?usp=sharing
