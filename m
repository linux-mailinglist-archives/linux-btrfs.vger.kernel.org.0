Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83E251E89
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 00:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFXWq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 18:46:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33052 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfFXWq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 18:46:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so949614wme.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b5RYjZPxVtqnSvbGY/0ILGMkaCluJbrzDpHmyB7N76E=;
        b=JSgAzzSpibbTv1kPe7bAP3eBeozKAhJj5uCed9zlbhVysiZ7/ZzLbgXJylvdjISikx
         +xFNNVaBC/OCI0XrJqziZgTFT9Acav9iRy1WGr2Jhg0sIz8JDyuAVbwTZiMITEp71fOb
         4gZKfu2xnwi3Cyg8QgVQo0bvjbF803OR7FA8cQobBMv6y6CTSKSnlIiGjLPHhzubIPVJ
         XPCe7IwR50WnQWpTyxOPb7wyVbIDgBvSoZUCExp61CkTmaNFnKmVrdCR9IMeZwY9Ut7F
         RwmxzK97UEeAruAW1hzlqQPuhVgX1QA8Mr5W4nubDI6dC90sxhFEHCeleJIy9EfmcxMm
         hl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b5RYjZPxVtqnSvbGY/0ILGMkaCluJbrzDpHmyB7N76E=;
        b=mlC4aSRUE8m5bAb2+LUW6g++2BhQg1C+oclxR/80qWSo9DqsP+VycqjabJQSAXyT6b
         RdslMjx7PhdYtKicp7M1sRX8k9UEBgpD9ITK3+f3lx1y2YzGHuT70XCSwlqSbFSXWP0e
         bHiPPlh+CB7gqYFr+sZ/eIPxMMZx6Gpvw7OvgagK1UL5SIdCnrS69tEw8VkdDAJbJZlX
         93KhoQ2DjKaL7cEBj/3n/POX8qexa7libjJKEOET1datbpxvjZo8mV4hiFPeavhzyo3q
         mpFkzksxHSXXuWstimRh5aJfCnUt9jYpzRqirmbCu7XKq3NhAbqPyPncRt71p6WD4aLa
         MgMg==
X-Gm-Message-State: APjAAAUciWgVOOhnlp0OkNjCYokCtNxG0Y7JWxxrZQxkCDftekyowfdY
        xj9+vQLWXhtj6HafnCj8sC//YgxfK+1SGaRo8DqrJ+XFSOv1LA==
X-Google-Smtp-Source: APXvYqxUUmRHESgQUG0HdnNsTYu2US2e0HbtuCeDXHglKdZarDWDCEaFULyNBEQzwg3ymqS6BK4aNd07/JdQ9vy99Zg=
X-Received: by 2002:a1c:a997:: with SMTP id s145mr16933204wme.106.1561416386543;
 Mon, 24 Jun 2019 15:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <CAJCQCtR3azJyM40P0AyHSAp=uWxchN+R=LR5BxCuzdxQ5_JcbA@mail.gmail.com>
In-Reply-To: <CAJCQCtR3azJyM40P0AyHSAp=uWxchN+R=LR5BxCuzdxQ5_JcbA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 16:46:15 -0600
Message-ID: <CAJCQCtSN5EO5K3T3K0hkzGPX0sXVL_HiL7V-W_aW5kE_1jjfEw@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Same call trace on ro mount and ro scrub with 5.2.0-rc2+, but also an
additional call trace related to zstd. As this is a zstd compressed
file system, it might be related.

[  366.319583] ================================
[  366.325036] WARNING: inconsistent lock state
[  366.330615] 5.2.0-0.rc2.git1.2.fc31.x86_64 #1 Tainted: G        W
[  366.336202] --------------------------------
[  366.341788] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  366.347423] swapper/4/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[  366.353042] 000000006070e818 (&(&wsm.lock)->rlock){+.?.}, at:
zstd_reclaim_timer_fn+0x26/0x170 [btrfs]

full dmesg for that is  here:
https://drive.google.com/open?id=1GJlSExS2xQcplVRyg-hjI47KWR7Vs7iS

I'm going to try to boot off the damaged volume, and use
systemd.debug-shell=1 to see if I can gain access to the system at the
crash point. I'm gonna guess it's this same message, failure to clean
up a transaction due to some prior corruption, and then probably goes
read only.


Chris Murphy
