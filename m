Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9681A128FB9
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 20:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfLVTXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 14:23:50 -0500
Received: from len.romanrm.net ([91.121.86.59]:53616 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfLVTXu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 14:23:50 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2019 14:23:49 EST
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id EECFB402EF;
        Sun, 22 Dec 2019 19:15:12 +0000 (UTC)
Date:   Mon, 23 Dec 2019 00:15:12 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
Message-ID: <20191223001512.6477bd8f@natsu>
In-Reply-To: <a6488349-301f-1071-0d96-4970ca50c3cd@suse.com>
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
        <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com>
        <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
        <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com>
        <a6488349-301f-1071-0d96-4970ca50c3cd@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 22 Dec 2019 20:06:57 +0200
Nikolay Borisov <nborisov@suse.com> wrote:

> Well, if we rework how fitrim is implemented - e.g. make discards async
> and have some sort of locking to exclude queued extents being allocated
> we can alleviate the problem somewhat.

Please keep fstrim synchronous, in many cases TRIM is expected to be completed
as it returns, for the next step of making a snapshot of a thin LV for backup,
to shutdown a VM for migration, and so on.

I don't think many really care about how long fstrim takes, it's not a typical
interactive end-user task. By all means it's great to speed it up if possible,
but not via faking that with unexpected tricks of continuing to TRIM in the
background. Sure, SSDs already do that under the hood, but keep in mind that
SSDs are not the only application of TRIM (the other being as mentioned, thin
LVs and sparsely allocated disk images).

-- 
With respect,
Roman
