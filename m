Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E703742C9E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 21:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhJMTYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJMTYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 15:24:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3715CC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 12:22:04 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q189so9045143ybq.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xp8kcBkg2qp8R9hnOoMR7Unc1KGFymAlRVUbAzzCCU=;
        b=IGjck9dVm2L2YJGxl7VikLWuw92j3HgAgS+UX58rB1yOXljYoMaZ4z2Yyc+Jh30i+Q
         rfdqe50n9bDvA2fxojqnh44dFEWZd+RNG43BfFWfiY40VUGwEoHIPRr/oD5XZhnQdRs4
         WeLOdVqjAk515zZ6FaZfLrQO+q3FhcKavHX59rycbYEFY8K+E4O/sYieD3kjPOxkXnDQ
         NLPhJHycva6TP4yreqIN9esFgANfsR5/oIwR8uCpCTGe1XQC02zpEHQQYLgjlRMM7xbe
         GCqW5uU1gXpl6xzB14HIK1OlwYs9t7rd2wUNNQn9/MK8yp5QFnCJJjBeN7Z+KoWophkH
         WeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xp8kcBkg2qp8R9hnOoMR7Unc1KGFymAlRVUbAzzCCU=;
        b=OxyFXVwPdko/RVNctWBYPJTexQqwm1ZAQy1hyl0/Omey82tBIVQolsixZtS1ajv4pS
         g9qh8WySHrYIToiN921NS9VRUwdIr3OBZqDYiwupEZXp1+g5AvvvNtYRYW5Y1PlUBuKc
         1yq6QNgH2cC1V4SRm1MSfIc7dixC5A8DiU+7WpPpSTbnqWBMGS2EaVwTLPZhnQjCD1mv
         aAXPwLMxAfa2BZyWLCErruK0BGlROmx62UqTeLBJwipXZtuuygRlV15Dm+0aa/C/r97l
         QNSmzykPlfzHvESeOVmg4GWzGqc+SxG9w0TP8WVEkiujBufIJco1wAnj+Ki2PzcU8qNl
         pccg==
X-Gm-Message-State: AOAM532fFCIveabhy3kuvuJJJIgDWNCHMk5Aophgs6zbpbS7UpekHE8S
        TXZDYvAzgpE/EiTcwaPmrTLsOYYQkeg0QtyB6H39UQ==
X-Google-Smtp-Source: ABdhPJzssdOMHM3FXmgH83+S6nAjzo0lsk/SF799VZEu/OzefWxr0gROQCNKz9DO1fEdG9h0s8HHlptr53r1JOpV3dg=
X-Received: by 2002:a25:bd08:: with SMTP id f8mr1366069ybk.89.1634152923379;
 Wed, 13 Oct 2021 12:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
In-Reply-To: <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Oct 2021 15:21:47 -0400
Message-ID: <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From the downstream bug:

[root@openqa-a64-worker03 adamwill][PROD]#
/usr/src/kernels/5.14.9-300.fc35.aarch64/scripts/faddr2line
/usr/lib/debug/lib/modules/5.14.9-300.fc35.aarch64/vmlinux
submit_compressed_extents+0x38
submit_compressed_extents+0x38/0x3d0:
submit_compressed_extents at
/usr/src/debug/kernel-5.14.9/linux-5.14.9-300.fc35.aarch64/fs/btrfs/inode.c:845
[root@openqa-a64-worker03 adamwill][PROD]#

https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c26

Also curious: this problem is only happening in openstack
environments, as if the host environment matters. Does that make
sense?


--
Chris Murphy
