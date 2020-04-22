Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178311B50B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDVXO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 19:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVXOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 19:14:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BD9C03C1AF
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 16:14:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c63so4470165qke.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yutIE/3Yrasa++aWOCa3PZNUoPlrlPERr3vYpXHco/M=;
        b=roi6w8e5qBgfrEAFnX0ITcdhSDL8WSk9M0K+Pi5JsvodaNNOas+t0Q1f3de9phX1r3
         zH9nNHarNQ5F0bPzz7BOwaRNKmtglTqtN0NM6aiRDb1o0ARGr4RLUKq2Ljipggfzmq4f
         4lue9ey15OIgipQe2SFDgP3Zg483GPNPRk1b8P8tkH8JOTSig5IAtEHFk48/ttXK/xW3
         HXoY6IUYmJ/pTBF9GpTUhyyw7weiMGNPNlwjMBnBqpgI6X0Q/tR6jaPPDUnk4ojUthH4
         sJ/35wr3LbgYPfPQAvyDm9c7nFllFe/TQ0modirFmWgoD/qWXe5K3H06giTotm5Z7P3Z
         jarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yutIE/3Yrasa++aWOCa3PZNUoPlrlPERr3vYpXHco/M=;
        b=RwgKMofFVb0M6C/sJybzHYLyVch4h1K7DkMthxMFjlOxmhrzZAZl/YW30PCSB/2jIZ
         Clw9rn/jDtGuFmNDP2v/G+23WtuehrAKuPhwa0cbjmwO+jjQ/SSka9qUtyINg1QXlpjI
         LaT4/8PxA5Ad+jTEElNic6ybVtIO31RtScaxyqPMKwFyAarzLtNHSs0KZyOV03g147XO
         WzNOI6rhQq6G3XXdXcOaAMkMx5tq8mC2NNcp+I5eU4CW7Mi6PbP4RLPv5hYloc36t80d
         8/DzdZvazYRtYQ+Y2SM1trc2q7RJ5B1RRMT9Q8Qmeq7yuBnbXWR4Svo+2pkwDdNUjsMd
         Xtzw==
X-Gm-Message-State: AGi0PubQS8dEqSxKdaxnpaxFsDjUx7wmMayahU3RmY3EQHiHtL50iT/6
        O/rJi6Jxo8tVx/SWyjMtj9YUeQ==
X-Google-Smtp-Source: APiQypKpwv318za6PvBDHu/CmZW2XLyq7lRBmFefrk1Y5QT6hBrl33XFhRuafmp5OdsdRdB+WGIptg==
X-Received: by 2002:a37:6415:: with SMTP id y21mr792941qkb.258.1587597263810;
        Wed, 22 Apr 2020 16:14:23 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::1:af35])
        by smtp.gmail.com with ESMTPSA id q6sm534297qtd.61.2020.04.22.16.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 16:14:23 -0700 (PDT)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvme@vger.kernel.org" <linux-nvme@vger.kernel.org>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: LSFMMBPF 2020 Cancellation announcement
Message-ID: <0b6d3d6f-99de-3603-4b42-c3db5113633d@toxicpanda.com>
Date:   Wed, 22 Apr 2020 19:14:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Each year, we look forward to gathering at Linux Storage, Filesystem, Memory
Management, and BPF Summit to share information, collaborate, and learn
together. Due to continual assessments and growing concerns around COVID-19, we
have made the decision to cancel Linux Storage, Filesystem, Memory Management,
and BPF Summit this year. Next year the summit will be held in Palm Springs, on
May 12-14, 2021 at the Riviera Palm Springs.  A new CFP and registration will be
held again, along with a new round of invites.  The program committee will
remain the same, and next year we will choose new members.

Event Registration

The Linux Foundation will take care of canceling all event registrations - you
do not need to do anything.

We thank you for your patience and understanding while we work through this very
fluid situation. A great deal of work and preparation has gone into the
information and content planned to be delivered at LSFMMBPF and we look forward
to sharing it all with our community next year.

Thank you again for your support. Our sincere sympathies are with all those
being affected and we wish for good health and safety for all.

Thank you on behalf of the program committee:

         Josef Bacik (Filesystems)
         Amir Goldstein (Filesystems)
         Martin K. Petersen (Storage)
         Omar Sandoval (Storage)
         Michal Hocko (MM)
         Dan Williams (MM)
         Alexei Starovoitov (BPF)
         Daniel Borkmann (BPF)
