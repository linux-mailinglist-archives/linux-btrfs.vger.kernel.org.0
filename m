Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC22EA368
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 03:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbhAECjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 21:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhAECjh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 21:39:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9EC061574
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 18:38:57 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z5so26924666iob.11
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 18:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=KBg0Pd9CT2c7SyL1X90F18DG0ejUgIyF+XMIVJEtv74=;
        b=PQHnu84wVjAwAzZ0K4KaGCAuPpxOSHwI3qJjCwECsL5/hlcrt52cdTh4Grm3csRq6A
         f9IFrfCDpO1D1ijX4j9HlY0youlkigeeHklbdey++AlrQdvUvjA7VKQbCJWQBcqQ6Rij
         Q6DuuF8qlKPri/aW6PUk+p/Eq3OfutQwT7cWCFC4PYHNJfmdAPNGAvSsmD+AiS3eKu/e
         CQJ0EUDn+T+okt6hhFi97jtcarwER1cgeb4TddXkWsQwjj9KUyt/VnAZSD35O+/7XmMt
         IOmAy3ozWnjIHe/afWsopHpFPZIZg2PsD+17ub54ipT4rqucrUw8b4LElWR9tXEI/gVr
         h8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KBg0Pd9CT2c7SyL1X90F18DG0ejUgIyF+XMIVJEtv74=;
        b=AW+TLBJypyY2BXim9VfHh83xdKm2eyJ1K7UqmFZxn07PVAWqGKfRFIguEgMuw3xzNI
         KIpAUFYjSMM9BNfPAYBOJwZ1Hib7ZA/Qx2DFYXVYa5hWSzOCyrSrIcSJMkf8rFomrWHD
         rMnRP3CbRd9OlREwnbw3Cq23ytZYoMZ0CtVDD789h00vcpx53m7rY4nCebDHV2P60Vpk
         YeZUwp6AaRHJVWp4qrbbTbCVd23Sh8li7jL0BiRPkzWrxgU1U4SnSbCq7DZY5OgVkbEZ
         MsAbTsqliIaS/5Z/H4Kr+AVEjVfeNdUXcxGkY0Do1YD5Tos/05SyB+GGWDBciaF3P3+M
         RdKw==
X-Gm-Message-State: AOAM53117giO7zTFUUQaRQsapkgizyvQ8wy0PI4kSjsXaDkOSF2NzAOw
        cUKVdtwiXZCOWIHwY3l3tyzsJOpFNeN4qgUBB8t/AAOvmpZVLWH3+Aw=
X-Google-Smtp-Source: ABdhPJwLX2+SPZQ5UGH/zpE1bozhqYkt0DSElfZHgxrg81CbFCNTGm31Nkc33diYbkyYJVAmcV83bF3R6VFHqnv/yc4=
X-Received: by 2002:a05:6602:5d9:: with SMTP id w25mr61791116iox.206.1609814336488;
 Mon, 04 Jan 2021 18:38:56 -0800 (PST)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Tue, 5 Jan 2021 05:38:45 +0300
Message-ID: <CAN4oSBehVoPJxcdwD6wiohR9pSfAdSvzXabz6ohyFQibQ_VrxQ@mail.gmail.com>
Subject: btrfs receive eats CoW attributes
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I need my backups exactly same data, including the file attributes.
Apparently "btrfs receive" ignores the CoW attribute. Here is the
reproduction:

btrfs sub create ./a
mkdir a/b
chattr +C a/b
echo "hello" > a/b/file
btrfs sub snap -r ./a ./a.ro
mkdir x
btrfs send a.ro | btrfs receive x
lsattr a.ro
lsattr x/a.ro

Result is:

# lsattr a.ro
---------------C--- a.ro/b
# lsattr x/a.ro
------------------- x/a.ro/b

Expected: x/a.ro/b folder should have CoW disabled (same as a.ro/b folder)

How can I workaround this issue in order to have correct attributes in
my backups?
