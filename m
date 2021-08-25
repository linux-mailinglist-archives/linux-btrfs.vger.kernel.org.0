Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3B3F7EF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 01:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhHYXXa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 19:23:30 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:46910 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhHYXXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 19:23:30 -0400
Received: by mail-lf1-f53.google.com with SMTP id b4so2308780lfo.13
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 16:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t0eTLwxKSCsMCllIRX1FAHcgeEe7xTq4ZuC7mDpmJ4o=;
        b=cf+17GC88k/8Dk/DojQtj6WpP8Uu2Bq6gc5wwZIbADT8M+HGReunYQT5BIbtJtP5tm
         mjP2Ehe/sfT+40PXTMr2rxJCLRMeW/aZt/jaNptjqjpiXu5cvSxD+Faw7mTIltOgRr5S
         AxxwvWwqL0uvgST6c4Hn7uPOKGBXP/ngW2NBrs+awaYFYZ8paCc/7zikJNrOIu8rkH16
         MgdbMOPaBpMppyvWlf2ONj/RwjewV08W2k0ufX+cd89kKUPk7FwnTx+AwcgTzWRE4uoK
         9S/IgqOMs48hld+5n/ypa5CSP6PGP4u6+DsY1668yD/Y/kV+Hwff11vlejUGIcx/urCT
         CV2w==
X-Gm-Message-State: AOAM533JttVVBlQwYtmK1McLEcCLvpHeERVwcRcVtGc/D/UNwg4ggLDF
        VLUo0mF+o6mXR0eHpUGn6vqFNjSuFWnCLM3VwFI2yMlL0UY=
X-Google-Smtp-Source: ABdhPJyO2dc/0wYyHp8UG4r4Y/iauwhExArLMD/o8BlkYuJGSmnqar4sO+O6krPcDwoef6RBthTAfHEhenLiwhRdh8A=
X-Received: by 2002:a19:4941:: with SMTP id l1mr430431lfj.544.1629933762805;
 Wed, 25 Aug 2021 16:22:42 -0700 (PDT)
MIME-Version: 1.0
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Wed, 25 Aug 2021 16:22:32 -0700
Message-ID: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
Subject: Backup failing with "failed to clone extents" error
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm seeing a similar issue to the one previously posted by Matt
Huszagh. btrfs send gives errors like this:
ERROR: failed to clone extents to <some file>: Invalid argument

This mostly seems to occur with sqlite files (such as the ones in
firefox profiles).

This was supposed to be fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9722b10148504c4153a74a9c89725af271e490fc
(included in 5.5.3+). However, I'm still seeing the error with 5.3.12.
The test case provided in the previous fix does not trigger the error
for me, so perhaps it's a slightly different issue?

Please CC me on replies.

Thanks,
Darrell
