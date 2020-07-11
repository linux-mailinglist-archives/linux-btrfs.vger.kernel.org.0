Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D361421C4B1
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgGKOmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgGKOmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 10:42:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E0C08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 07:42:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k17so4848116lfg.3
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4jAbqJ5rMQDBy574Q7SHDCEGxS79zzFhnyv0ZKTE0Js=;
        b=LNSZIy5ap+V65ecFMbXy07VCUgSlGbA3xy7ctFnuRfHop8BJ5J0NVu1KxeDGYWt4kQ
         I+qQuwkDVSrkOySxv6G3XJVSyVT3bvvjWV5w1diFJy77VcggM+gXV+ZRcSwHQgf5/Ihe
         vqvEgkHFrQhd/fLLZFLGeDoEVA4PJ9cfXnjaj2LWCIlPxLNKU2HquXGiv6NnxJcqZq2x
         9fD4A4SXOhElGC5OY3aZmU1ZZGilmg1Z1vMlnnbe8ehphs2g7Kj2aqWfD6FJ1mQ6XLQn
         AUfTXZgFDYr8zUPWXKYwe1MWOq7dPchg43Rpn/SmP+45c5xrkRfhgo1WL1GyDBfz3azw
         QV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4jAbqJ5rMQDBy574Q7SHDCEGxS79zzFhnyv0ZKTE0Js=;
        b=pWQ7meVa40dNccT8P/X7zxUFYaNoFk1iJt8j8hPTAJU5bTw6ngJZ8be+bL2uF0ZTPE
         cXhHAi85kPw+xBs9S9rVVWemX4sxarUxar6bonsuJcr67bfJt/68X7cXvFPRDFAURt6U
         Lvti9ghRUsyv0Owmb+MHBqgd98lsCqmhjZ2FLGFyByIEcQvtoeLzSasD1uxYMMI2dZs5
         BOW2hvhBXA2IgOdc51N+Bmz+zPaY/GbXNAJp3wIsNBbmVVFRnu906y4AYAQqQU8iVSdT
         vha8sm+ovt/f41psJaQtwO3KMz5+8UJgD5W2LhsoIwnh7S9++wmRi3vuy3O5NkFDB2qG
         9s7w==
X-Gm-Message-State: AOAM533laeMVWngju/OS2m+ciPcpbT2eXqvLoi0ILDVHtBW7DgY5/5a1
        Rt9pal6fwb3B1nVAN8YnM+HNylZJnxhuvrkCV5n/eQ==
X-Google-Smtp-Source: ABdhPJxp2233h6Q9g7rkGE9kd3YA/HusaTGcHGObAd6ibRvxBCQzkBbNgIV9pf5UJFdQoU3Ii+6hVJVFWZ1V6NRObfw=
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr46725953lfa.60.1594478561706;
 Sat, 11 Jul 2020 07:42:41 -0700 (PDT)
MIME-Version: 1.0
Reply-To: swestrup@gmail.com
From:   Stirling Westrup <swestrup@gmail.com>
Date:   Sat, 11 Jul 2020 10:42:30 -0400
Message-ID: <CAJt7KB-c4vRYgjJ1WZJyNZuey6nH=y2BcQNVYJa6YAG9MTfKhQ@mail.gmail.com>
Subject: Rebalancing Question
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a BTRFS built with two devices md0 and md1 on a server. I wish
to move as much data as will fit from md0 to md1, but I cannot figure
out a balance command that will do that.

My use case is a file server with a fixed number of hard drive slots
and two raids. md0 is a raid using most of the slots with small
drives, and md1 is a raid using the remaining slots with large drives.
I'm trying to shrink md0, so I can remove some small drives and put in
new large drives to add to md1.

I have read the notes on the balance command several times but I can't
figure out how to get it to do what I want, if it's even possible.

-- 
Stirling Westrup (he/him)
Programmer, Entrepreneur.
http://www.linkedin.com/in/swestrup
(+1) 514-626-0928
