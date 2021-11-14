Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455F844F6F4
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 06:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKNFu4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 00:50:56 -0500
Received: from mail.mailmag.net ([5.135.159.181]:43796 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhKNFuz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 00:50:55 -0500
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 689CEEC5AC2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Nov 2021 20:48:01 -0900 (AKST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1636868881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5//jlFdIdP0XQA9qemlJQD95TfR8NwHJjGxW3JD2kXk=;
        b=H30nfT8BJntLAvwIjml9dC6euQ/nj9VZaZmwVJFKDkJM4kx+CK0JwiJjLz/xeEkW9+byiN
        wjcxHCww2jyWysqq+NXXv60G0d07Keme6yPnFlH4KxfiJ7kTyLYx6HJggV7HHm4rpAmAjh
        8f2CT4Gg/YbYP+dS+vwa8kR/52TWWKc=
MIME-Version: 1.0
Date:   Sun, 14 Nov 2021 05:48:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Joshua" <joshua@mailmag.net>
Message-ID: <2f87defb6b4c199de7ce0ba85ec6b690@mailmag.net>
Subject: Large BTRFS array suddenly says 53TiB Free, usage inconsistent
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1636868881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5//jlFdIdP0XQA9qemlJQD95TfR8NwHJjGxW3JD2kXk=;
        b=LGdTispOiACQPJpg+qvH7AfKvSw5S905YIOAc3ZXN2EqUTABTdFvVA8DNOhIfU3F5ONDgn
        5lgdc2YDtI1ysptZQExFi9up0x85W6CWDqrmH8e4hAKqry0WPsodG6zLSXGhDcUZayQHJy
        lw3oOM/RacHhNFtEofdB+XRlDrLi5vE=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1636868881; a=rsa-sha256; cv=none;
        b=WAsEgM92TJAWuHy50X1ICoMYCmNnHv35rtrL5CcLTReLUTUCNNc1491vfmqXljgNB+OO8G
        t+3pu8Brd5gFlC61q0iRrM3ur2mhTp92n6ALtiZFzNtDTZvrTzd5BgzaICJ9RcYtyuzwnq
        Jk2CNSCKjAyECD3Xpl53W0myUgVP/FE=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a large multi-device BTRFS array. (13 devices / 96TiB total usable=
 space)

As of yesterday, it had a little over 5 TiB reported as estimated free by=
 'btrfs fi usage'

At exactly 7am this morning, my reporting tool reports that the "Free (es=
timated)" line of 'btrfs
fi usage' jumped to 53TiB.

Now I do use snapshots, managed by btrbk. I currently have 80 snapshots, =
and it is possible old
snapshots were deleted at midnight, freeing up data.  Perhaps the deletio=
ns didn't finish committing until 7am?

However, the current state of the array is concerning to me:

#> btrfs fi usage /mnt
Overall:
Device size: 96.42TiB
Device allocated: 43.16TiB
Device unallocated: 53.26TiB
Device missing: 0.00B
Used: 43.15TiB
Free (estimated): 53.27TiB (min: 53.27TiB)
Free (statfs, df): 4.71TiB
Data ratio: 1.00
Metadata ratio: 1.00
Global reserve: 512.00MiB (used: 0.00B)
Multiple profiles: no

Data,RAID1: Size:43.10TiB, Used:43.09TiB (99.98%)
{snip}
Metadata,RAID1C3: Size:66.00GiB, Used:62.51GiB (94.71%)
{snip}
System,RAID1C3: Size:32.00MiB, Used:7.12MiB (22.27%)
{snip}
Unallocated:
{snip}

As you can see, it's showing all my data is Raid1 as it should be, and al=
l my metadata is raid1c3
as it should be.
BUT it's showing data ratio: 1 and metadata ratio: 1
Also, the allocated space is showing 43 TiB, which I know to be around th=
e actual amount of used
data by files. Since Raid1 is in use, Allocated data should be around 86.=
...

Any ideas as to what happened, why it's showing this erroneous data, or i=
f I should be worried
about my data in any way?
As of right now, everything appears intact....

--Joshua Villwock
