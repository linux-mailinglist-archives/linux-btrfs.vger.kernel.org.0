Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A93029A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 21:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3TJw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 15:09:52 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45278 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3TJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 15:09:52 -0400
Received: by mail-lf1-f42.google.com with SMTP id m14so5864899lfp.12
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=bdzGvmRMTjsJtyDYlfeop9d5JXX421pEGhVjdfJelAU=;
        b=jOt+c2xmqTMHCH9yu9LWVrvaxm62z4z4sQ9LL29xAXHrue4GDquICGLDYx61UxpcnH
         wViGdjZlMeeqrcJgpcQMRL2CBlwzbWJ7UZsl2uF0go3beZWqHJUwtAjdTmmHkd6/Zo13
         rEv0b1/Xrin+9BVhFsY083hfB3GYM/SJg09bViA7vx0wySemar8GoMuCjVK3CJevs/Sz
         0QO9tBNVbkzxNPFo8FBZ1nt116sOvUmzP/wognAXeqsvALewKVRY+otBHvGhMRRYS4R6
         q2NMVXpIJpErmHWcBPcjk9TGpb/H8BVcZRrk0RV4oY8Mcn169RYa7r9GAnGOKn3P6MM6
         twdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bdzGvmRMTjsJtyDYlfeop9d5JXX421pEGhVjdfJelAU=;
        b=pPxMuPjBIEMTcYqFGgRCLAxdcg2NY2v9arme+QYK/jrveVt1GYfq7BKp3gjW2nTO8a
         HSmlDO/J/lWrU0zZWGoF0oTV7SfP2BQy/jFXWwTa7g6mUaC8MTGoFzcjlf9HrGLqqPrI
         R3LuC40CLGgzn80NnPQupCIOQxmK7mtrOgjPjs04RnZ+UbJeGHn6H39SyJwHrm8i0ozl
         cTxFjWBYl2STwrhgVO83HhPm0xhiodEbtMNfPbTpO7D+8T7YcgpOVQni+XOvC9Qa8e5x
         /Ew7LEXHnMmiZ+ncnhOudT5Cxd1Sp2o4MrhmvwzeMBBRuLl2iakcQseZzaiKJ40mMoJ5
         3H5g==
X-Gm-Message-State: APjAAAVVGTaftT9VAk61hm3l36sDxSstJRHGsLy+9KGLi/CmNwQ0oxIw
        i3/RII/Afjs855VnmdLhHZOxOBb6KByWCH3dpbTwb3awDyA=
X-Google-Smtp-Source: APXvYqx7SmGQE66qlOGx8LoYC5IUpxQ+rQ78GZfjVm1oyTQp8xN+n1gtiB3VguMnjgzN8ZDBzjuO3pOl5GGM+Z65kqg=
X-Received: by 2002:ac2:54a6:: with SMTP id w6mr2981051lfk.108.1559243389547;
 Thu, 30 May 2019 12:09:49 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 May 2019 13:09:38 -0600
Message-ID: <CAJCQCtSaSjHJQ1CTg6tk_8f7kvzej0mqTE3RpbFsvmYEc=Q8jg@mail.gmail.com>
Subject: leaf size and compression
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I recently setup a test ppc64le VM, and incidentally noticed some
things. Since the page size is 64KiB, the sector size and node size
with a default mkfs.btrfs also became 64KiB. As a result, I saw quite
a lot of small files stuffed into a single leaf (inline data) compared
to the default 16KiB, where often the inline process seems to give up
and put even very small files less than 1KiB into a data block group,
thus taking up a full 4KiB extent (that's on x86).

Further, due to how compression works on 128KiB "segments" (not sure
the proper term for it), there is quite a metadata explosion that
happens with compression enabled. It takes quite a lot more 16KiB
leaves to contain that metadata, compared to 64KiB leaves.

I'm wondering if anyone has done benchmarking that demonstrates any
meaningful difference for 16 KiB, 32 KiB and 64 KiB node/leaf size
when using compression? All the prior benchmarks back in ancient times
when default node size was changed from 4KiB to 16KIB I'm pretty sure
were predicated on uncompressed data.

It could be a question of how many angels can dance on the head of a
pin, but there it is.


-- 
Chris Murphy
