Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8693520C83A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 15:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgF1Ndz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgF1Ndz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 09:33:55 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABB5C061794
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 06:33:54 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i18so12255292ilk.10
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FOc9ITFs2zn3ZHZGUz68WEk7fUdUnOPPkL9+weV36sc=;
        b=kEeOq/S4XcyUxo+xkAFU+jCiNg9EV4hQd5UhahD6CgISMX7WJBDOi8Ps6eCPYfBNza
         gc9azyttLNvpz5kDO2BNS7DPKv7NkC1Y26MOfRiJIw0+jlAlMByWNqOizm9COm3DMgkt
         d4uexosRXC/pB1h8PT+K86Z8dwZLlwJUZ2UCclP0EcFzf6DXsHkLOZQAsjybKFZF3oYT
         fJo3JVaqRUQZX1P2Vhjt2Awk1QEm2LSL5ej+Y76lyG4iGGLbheVyhNngBk7mH4SjfAym
         B8xxk8R8xDop2FdicmpArOY6ZoHE8wNO1IPK7oK5MYhTUJ7qb4qEue0KLFxa3nxa8Au+
         3R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FOc9ITFs2zn3ZHZGUz68WEk7fUdUnOPPkL9+weV36sc=;
        b=k80F0JoFg32vYsdRql8YbIVSZhkBmNNAa+PydunChlTbJ8Qant3AFXBiqyWPeUrVdU
         Q6yCvlNMFvokYZtzR6ANJseALZzO7CiTFsvHxyET2yYY6Td5ADIzcy9HyxILCC3gGohL
         8V6+UsqTd5lcGIdexi4KsfYNoFeiv6zYWoeb0SzhQVmgEu4MvIQWsj/efVPp7raNN1cM
         kXNZ8yfifdUIzeSrjhsViu6n1Pi8R8euUMUFmR+ols8e2++MenkKfSSmlHJbobIbmUKB
         7arGtz2Ivqfwt+/d2fIltIqhwIBGgsjMsSmQZZiGPs79stCKZUhMNa9nZl85Rxz88bGU
         GSuA==
X-Gm-Message-State: AOAM530vi8XPsjQBg31m9fsv5bBeoYbLIRsl0jO8xFhecMvsWU3vTClI
        S9WkMe0+nZ+Y2iY1E3v9N0SQWRbJzNVys18v6NOzig==
X-Google-Smtp-Source: ABdhPJz0bFP8+r/kzpGcJmbtdMewt8kpYRQSlQPdK9bsqfAsIu+l8RWtY1bX1fzrMOhPvyN5dPwlHU5uOodeEzR1Pd8=
X-Received: by 2002:a92:c00d:: with SMTP id q13mr10472665ild.222.1593351233925;
 Sun, 28 Jun 2020 06:33:53 -0700 (PDT)
MIME-Version: 1.0
From:   Pablo Fabian Wagner Boian <pablofabian.wagnerboian@gmail.com>
Date:   Sun, 28 Jun 2020 10:33:42 -0300
Message-ID: <CAK=moY9cRF0WKnBp5wRzFUuuL9=rJ8mD8uEA6murWEUYwvQkWw@mail.gmail.com>
Subject: Buggy disk firmware (fsync/FUA) and power-loss btrfs survability
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.

Recently, it came to my knowledge that btrfs relies on disks honoring
fsync. So, when a transaction is issued, all of the tree structure is
updated (not in-place, bottom-up) and, lastly, the superblock is
updated to point to the new tree generation. If reordering happens (or
buggy firmware just drops its cache contents without updating the
corresponding sectors) then a power-loss could render the filesystem
unmountable.

Upon more reading, ZFS seems to implement a circular buffer in which
new pointers are updated one after another. That means that, if older
generations (in btrfs terminology) of the tree are kept on disk you
could survive such situations by just using another (older) pointer.

I seem to recall having read somewhere that the btrfs superblock
maintains four pointers to such older tree generations.

My question is: is the statement in this last paragraph true? If not:
could it be implemented in btrfs to not depend on correct fsync
behaviour? I assume it would require an on-disk format change. Lastly:
are there any downsides in this approach?

I have skimmed the mailing list but couldn't find concise answers.
Bear in mind that I'm just an user so I would really appreciate a very
brief explanation attached to any technical aspect in the response. If
any of these questions have no merit (or this isn't the appropriate
place to ask) I'm sorry for the noise and, please, ignore this mail.

Thanks.
