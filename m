Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F425364A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHZSH6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgHZSH4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 14:07:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80808C061756
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 11:07:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id 2so2751390wrj.10
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvL1cBvsu7eOptlkTDuIxEaAxqB74Ubc6D2niJ6Bdmo=;
        b=aS5vEatZ+xTwHE1jD2b28ZAfzpPF0cja49mzl6PKiAmIPA/ejL1lDdV+oWIKKDfPHj
         L6K1xe0W9H0U+EA7d1TMhJSKt4E+1jHjL/tUNdqHSt1NwE3DME0F7L8VsMHGJ4w9Dq0D
         Se6ZrtSbrccf/StGKczewvQAeCh3sfyk470YP4GX4kvY5CwRnmt6e7CEUryXaS9gPKi4
         zNr81OHJ+nkymUlZZXyVJsnmb6hci6APRKlhM/7YOPb548hJkfDCHctX62cSeAJyk83u
         lNMS42Fl7RP2Y5JZaqkTXZZH8sJxuHB5g4W4Pd70z+wd0kClrAtbvpLzimwDhCPW08VM
         yVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvL1cBvsu7eOptlkTDuIxEaAxqB74Ubc6D2niJ6Bdmo=;
        b=Jp7jLCvpjju5SW/oN2IElz1CjQBqySZo1y4mivo4sMwADXAwTKagI1fUlG4EOJjveQ
         680winHFoQwBc1KuP81SNdbn3deFMQLeggvqeDibFVTtseqAwSJC7Yid7Md/ZQEtC3G6
         EitGHTUWwXtKR42qvbwwhQbEXLRDwkZFL/KUCEYr0HodhfI69WYMICQwBMqaZGBMjNnJ
         QAU0gOFAkrNMJvD8CIxURPg+ikLCTJz8xIGze8g1mmTs0oPAhzs4YH5Mv55wLlPZW+kh
         jXMA7UGB5uU70vFOrKeei1MndEFY3L8LYi0EF1rmc/T8PNtDaEjUgw0Nt98OJYjflp1n
         ZA7A==
X-Gm-Message-State: AOAM533biobtB23jGKkWW0CFhV8YMKoWCQgBJJ3stZdIqD04DPbQdfhu
        +pmk8dQkSA1p0hsVE3ZuxVOftW17cJPeGE4bs0iqCw==
X-Google-Smtp-Source: ABdhPJz3qoS9iwFMFvt+DUYB9nrXX6ARmqo5yU1ReziTNjisoNNWuhmKGDRB62j1pX1oq0d0BD982QxekXA9TiY4JlE=
X-Received: by 2002:adf:8401:: with SMTP id 1mr16385913wrf.274.1598465266460;
 Wed, 26 Aug 2020 11:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz> <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz> <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz> <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
 <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz>
In-Reply-To: <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Aug 2020 12:07:02 -0600
Message-ID: <CAJCQCtQWh2JBAL_SDRG-gMd9Z1TXad7aKjZVUGdY1Akj7fn5Qg@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Song Liu <songliubraving@fb.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK so from the attachments..

cat /proc/<pid>/stack for md1_raid6

[<0>] rq_qos_wait+0xfa/0x170
[<0>] wbt_wait+0x98/0xe0
[<0>] __rq_qos_throttle+0x23/0x30
[<0>] blk_mq_make_request+0x12a/0x5d0
[<0>] generic_make_request+0xcf/0x310
[<0>] submit_bio+0x42/0x1c0
[<0>] md_update_sb.part.71+0x3c0/0x8f0 [md_mod]
[<0>] r5l_do_reclaim+0x32a/0x3b0 [raid456]
[<0>] md_thread+0x94/0x150 [md_mod]
[<0>] kthread+0x112/0x130
[<0>] ret_from_fork+0x22/0x40


Btrfs snapshot flushing might instigate the problem but it seems to me
there's some kind of contention or blocking happening within md, and
that's why everything stalls. But I can't tell why.

Do you have any iostat output at the time of this problem? I'm
wondering if md is waiting on disks. If not, try `iostat -dxm 5` and
share a few minutes before and after the freeze/hang.


--
Chris Murphy
