Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149D0475AAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbhLOOba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 09:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhLOObZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 09:31:25 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A70C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 06:31:25 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso25197364otf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=VSZ3LSHRkEfZ76VFhJ958m2aQVJKQAL0hb1VIFawvP0=;
        b=SBfW5hBdHHDthVUP8ctdL1a2VgR/48jT0YNDP8IO1jAum4QLDBBDl3qCvLKZr5q35T
         dYsjSlgWHuggY1jd9kVgqm5VnazAxWLObaHLAzSb8gNLj+xAhG4EqchHPkYpXKiqB1Fq
         J1pAva8aqboJekkSqZ0d78xxwshfB4n1NcN6qpMhLQJW5IOdEaDsGPkJ/i8hnsXzcdtL
         u3or7Cxt2Y4OZAqbOAo5sLY8MTYmJNUfbm0PcrgfNnkWI/UW3VgB1OilZwItQY/xjhEt
         W+SWYhZ+tRM9WDGBiQG2TdtlGBqPMsGLlBJyF1iZ1in1AeO7ey8j1yj3GNpRb4gcFneH
         vD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VSZ3LSHRkEfZ76VFhJ958m2aQVJKQAL0hb1VIFawvP0=;
        b=PMOHb3FKX0WrWyG8VIVKhToF088qP3weuoA8FcuW9VlpZiR/PMWm+o+SDH6jN9OEuN
         MEb9z1R15NoGCa/nI2M7ypzZh9GMxfqtIn5+5tL90qpgsl9Lx9NzSrFAZrsFi0Te/UdK
         G/oL1K8bKC6tSqG+jL8VUl1MwaSMl4DEO9CMtAlaK/03eDxCdd7u28OdNxltQCd5txtY
         GSv4TAQ3NljDzUsKOtaYsEFyFu3kpLnOv71sUw6YvpXwJd5HvNMfNQTbB2b8r/Q8mYwt
         nBrf+08KbhDgsSh9zL/Va6EL3ljaRYwyt/v/ESTSQ4UOLuHE00DKVlc3ztjqneLstOEy
         OPyA==
X-Gm-Message-State: AOAM531+awGeJeDHAhno2v9y2Kuj5pVU9tVEd1272TBYbs5b5R9kjF37
        C2MZRE6iKqJ3SoPPw26H9WXagWC859iM/LJGJuTWyRdqbqKLDIDp
X-Google-Smtp-Source: ABdhPJy6wechdI4kuYuJJIHM5Pzg0HwDU+OKlWMuCSB/8Fp/KKun2syzh5nrYArHvRBk60d2QlxRvdx81l+rNGNHTq0=
X-Received: by 2002:a05:6830:4090:: with SMTP id x16mr9082983ott.281.1639578684337;
 Wed, 15 Dec 2021 06:31:24 -0800 (PST)
MIME-Version: 1.0
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Wed, 15 Dec 2021 22:31:13 +0800
Message-ID: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
Subject: unable to use all spaces
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I have a 14TB WDC HM-SMR disk formatted with BTRFS,
It looks like I'm unable to fill the disk full.
E.g. btrfs fi usage /disk1/
Free (estimated): 128.95GiB (min: 128.95GiB)

It still has 100+GB available
But I'm unable to put more files.

Do you know if there are any mkfs/mount options that I can use to
reach maximum capacity? like mkfs.ext4 -m 0 -O ^has_journal -T
largefile4

Thank you very much.
