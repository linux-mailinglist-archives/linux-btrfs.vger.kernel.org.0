Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8349242BFA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhJMMRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhJMMRE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:17:04 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379CC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:15:01 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id q189so5928492ybq.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FxYapxrqjMFKwHwlPS/lX3DPmz/Qy5/IdwcwUymD6M=;
        b=PpXURSmireTu4pNtBViPJa/cqxyzXvWpjIOnJtg4XkeRB9n/We0uguIlpiPioxy17r
         Dn0ZWZ36WiliJHN0edjZxFTg5W5Wj1DsuMG4bwtEe81FihsCHZ2pTTAMeI7d4RvKkvQi
         ccsqlMslObfz9D6LY2nljtVEQRr5Usfv13UgilKotuNPri9kiND0s5ufVu+X7ydk7W1F
         Xh2fwJyy94ntCxrMSJsr4GZsvLF2mhbJ+dJifoJ1wxXbSBz5RiEQ+7e8Kfdq47jQxl8J
         F98QmI0bYeA/RiTs5eYiuNW6DtCcoaBsXdCZKa9L8gp5Oe3KMQ6OntQr9t9CJSgrMW++
         Jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FxYapxrqjMFKwHwlPS/lX3DPmz/Qy5/IdwcwUymD6M=;
        b=yTldFivZqWw7iKhtd//eCrmG2NwYfYb4WkkChDtxFHC8vrddd/c9/FBw1UYpRlhAME
         uCCgJ/smMRxFTV6OGo8hkloOm/Y/GReZ5ROXdmHFSBRUFUHCbRariuBi1/BXCRlYXnvx
         9FcE7p8cXnpEwFwFDSKodDIO6rDRlywsbCLm2XzyaUwwkuajkWmzi3rbsyHy2kd/zriq
         BhqOe2fJ1jYkoCdBYOCcRzAQLl9tIECmKhCz7kMX1YL1kgCQ7ww0/Z7Ru/IoRENXgSUm
         ZBWAjU3QVF70Bcwu4Z5WAAj6nqZltXfDxz4vUt4P04NCamkshJqC7hhlnZ9W0kvql9rW
         foDg==
X-Gm-Message-State: AOAM530Bkkdm7zB9XB9eTAWH3K8OZiioK/R8m4YN2DRelsFIXojBBufG
        NyRM2Txlg9kq++VV6KFokuTj7q/i3//xMpjjLNmwiA==
X-Google-Smtp-Source: ABdhPJwq6HTKwbNk3YHVBUXT+cyTJtoJzf6GPvE5L+x7/BFFpPKjvVrwMPyFsjVkLoCHNnDQ5Z5A68zUHJgRbJbMh+Q=
X-Received: by 2002:a25:db49:: with SMTP id g70mr32109686ybf.341.1634127300230;
 Wed, 13 Oct 2021 05:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com> <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
In-Reply-To: <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Oct 2021 08:14:44 -0400
Message-ID: <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Qu Wenruo <wqu@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK so something like this:

/usr/src/kernels/5.14.9-300.fc35.aarch64/scripts/faddr2line
/boot/vmlinuz-5.14.9-300.fc35.aarch64 submit_compressed_extents+0x38
async_cow_submit+0x50 run_ordered_work+0xc8 btrfs_work_helper+0x98
process_one_work+0x1f0 worker_thread+0x188 kthread+0x110
ret_from_fork+0x10

Chris Murphy
