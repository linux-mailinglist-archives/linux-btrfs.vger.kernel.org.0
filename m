Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B59282EA6
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 03:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgJEBd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Oct 2020 21:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJEBd2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Oct 2020 21:33:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB8C0613CE
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Oct 2020 18:33:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id q7so1046132ile.8
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Oct 2020 18:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HaJUnnc6Y9rwpxKkaV/iKRhXsNfhHSy42zTkC3BvB/I=;
        b=FVzn8MUNg9KC2qp0AFXMUdu1ivLbGRxzZ/8baG3G4v+Vmhtdjx97JSMU4zh1ps5jbE
         aFpgGNho20mYdMrElvIWK8u4Gz4cnDK+4eXhtC/Q8ssz1CFd+9uy8rSKhaLfy/5MJqr0
         tf5lUJMv5cqCNJTiPptoDv3opXSSk3SSNdL3iWsm2jLaOY/rQj4HuaBG4IWNmQ+8NfEx
         nU9Fc1Q6+beFGhvgQVPpiHnJlc1cqiLotP7XVR+RQwm1h49xzC+52jXFmoR6k41Dl5hH
         /S+8LHfW9GIYZZAZLXkrEz55aaOk4UylaAtk3MLsVZUBwfPJcn+GFNARAWp0Yv1i34Oc
         44OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HaJUnnc6Y9rwpxKkaV/iKRhXsNfhHSy42zTkC3BvB/I=;
        b=LDXLduFrtaG0k0Sq76lFrX/yetV6/xraNkHuOmOSqolEkgl5JDpI0Xx25uikgP36kT
         xACDFSoQ14SDnmomW3vgPBLDvRwNhBGPtRHInq+Y8QOuAt+i3COikOpHnL2Yh1w5Sflk
         yWMWjudcCos5BGFNk/vinZW+hkrU6Pc9NcVGQSmN6lrzM0Sjydg6fmMqgYWLdalXe2F4
         6Z8VJ2wRT/VbQ1W8b2fSPu80zN1vHMsL1nT86Q28gjZp0pivtWa7U0U3X6VReo6r7eAu
         lD0YKbzak1voOLn75MlG9ExW5hBDaTRUVr3tCOgNvT6OjbpWNI+6WEV7+dtqi8GaAlYd
         BR8A==
X-Gm-Message-State: AOAM531Q3kcG8wSSSHHKmmbkAjRerNwyTRd+xKZRTslZCCAtzF0CC8Qn
        L5Tu+g4pIQiD5VMn0BidhuMzglVgfCOftoN3NZ/N531joAYJaw==
X-Google-Smtp-Source: ABdhPJxpVoHCIPCCB+0D/4IdPyEAFPjTEIFLjnGnDyOMMaf2o5dk+JrMB5R9LsBTnNXSaLAq/HfAjqNhr4vflR3zQxk=
X-Received: by 2002:a05:6e02:13eb:: with SMTP id w11mr87474ilj.249.1601861607017;
 Sun, 04 Oct 2020 18:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
In-Reply-To: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
From:   Eric Levy <ericlevy@gmail.com>
Date:   Sun, 4 Oct 2020 21:33:16 -0400
Message-ID: <CA++hEgxubm6qW++ozNbxUfeikjJ9g_MGn3wnQBoj=mST3x0kZg@mail.gmail.com>
Subject: Re: ERROR... please contact btrfs developers
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new observation is that I notice that through the RO option,
although the mount still degrades after continued use, it is more
stable than in a standard RW mode. At this point, I believe I have
recovered the crucial folders, though I have no guarantee that no
files are missing or corrupted. I would hope to restore this
filesystem to a fully functional state, or otherwise clone the
subvolumes successfully to another partition, with as much data
recovery as possible.

Even with RO, the receive command still fails rather abruptly, though
not always immediately:

ERROR: send ioctl failed with -5: Input/output error

I have written to the list because I believe that doing so best
satisfies the request within the error message to "please contact
btrfs developers". If another avenue of communication is more
suitable, then please advise.

On Tue, Sep 29, 2020 at 9:44 PM Eric Levy <ericlevy@gmail.com> wrote:
>
> I recently upgraded a Linux system running on btrfs from a 5.3.x
> kernel to a 5.4.x version. The system failed to run for more than a
> few minutes after the upgrade, because the root mount degraded to a
> read-only state. I continued to use the system by booting using the
> 5.3.x kernel.
>
> Some time later, I attempted to migrate the root subvolume using a
> send-receive command pairing, and noticed that the operation would
> invariably abort before completion. I also noticed that a full file
> walk of the mounted volume was impossible, because operations on some
> files generated errors from the file-system level.
>
> Upon investigating using a check command, I learned that the file
> system had errors.
>
> Examining the error report (not saved), I noticed that overall my
> situation had rather clear similarities to one described in an earlier
> discussion [1].
>
> Unfortunately, it appears that the differences in the kernels may have
> corrupted the file system.
>
> Based on eagerness for a resolution, and on an optimistic comment
> toward the end of the discussion, I chose to run a check operation on
> the partition with the --repair flag included.
>
> Perhaps not surprisingly to some, the result of a read-only check
> operation after the attempted repair gave a much more discouraging
> report, suggesting that the damage to the file system was made worse
> not better by the operation. I realize that this possibility is
> explained in the documentation.
>
> At the moment, the full report appears as below.
>
> Presently, the file system mounts, but the ability to successfully
> read files degrades the longer the system is mounted and the more
> files are read during a continuous mount. Experiments involving
> unmounting and then mounting again give some indication that this
> degradation is not entirely permanent.
>
> What possibility is open to recover all or part of the file system?
> After such a rescue attempt, would I have any way to know what is lost
> versus saved? Might I expect corruption within the file contents that
> would not be detected by the rescue effort?
>
> I would be thankful for any guidance that might lead to restoring the data
>
>
> [1] https://www.spinics.net/lists/linux-btrfs/msg96735.html
> ---
>
> Opening filesystem to check...
> Checking filesystem on /dev/sda5
> UUID: 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
> [1/7] checking root items
> [2/7] checking extents
> ERROR: invalid generation for extent 4064026624, have 94810718697136
> expect (0, 33469925]
> ERROR: invalid generation for extent 16323178496, have 94811372174048
> expect (0, 33469925]
> ERROR: invalid generation for extent 79980945408, have 94811372219744
> expect (0, 33469925]
> ERROR: invalid generation for extent 318963990528, have 94810111593504
> expect (0, 33469925]
> ERROR: invalid generation for extent 319650189312, have 14758526976
> expect (0, 33469925]
> ERROR: invalid generation for extent 319677259776, have 414943019007
> expect (0, 33469925]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> block group 71962722304 has wrong amount of free space, free space
> cache has 266420224 block group has 266354688
> ERROR: free space cache has more free space than block group item,
> this could leads to serious corruption, please contact btrfs
> developers
> failed to load free space cache for block group 71962722304
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups
> found 399845548032 bytes used, error(s) found
> total csum bytes: 349626220
> total tree bytes: 5908873216
> total fs tree bytes: 4414324736
> total extent tree bytes: 879493120
> btree space waste bytes: 1122882578
> file data blocks allocated: 550505705472
>  referenced 512080416768
