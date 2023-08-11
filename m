Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8C778810
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 09:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjHKHVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 03:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKHVe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 03:21:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8142738
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 00:21:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40fd2de0ddcso11361451cf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691738493; x=1692343293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SoTEizoONpCukS7NOPXu/rtvi/W45rgHetNVWnYANo=;
        b=slqoF0RTPaphI0VB9/9bjVB96gAzCceInOZJah42qqfjs2A7fGrNJaI+ZEAke5G3nr
         r07kU2tAQFxUR3hFck/6U7USx4izeisYNeFpwIwdOnmR/HcavmHYrX/cPJvvU+oXpj29
         FshCqCQl8k5XYu3bkiWcfC8yQ6bjmuSY0ObcX2LSNEfieHk/k54DEneeRJ7qaBTCCHrm
         TA5hv4FfViB2r01LgJKsgzqst9llATCd0yC0MeM15X0Ppx1jIT6ge/2t67sRfeMz3IKj
         0jW7JZZ/hzYumZCxbernKETIzaNwSkDma1BTOgb2G6m9nChe81JUMDOqGp0o34GblOlJ
         RHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691738493; x=1692343293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SoTEizoONpCukS7NOPXu/rtvi/W45rgHetNVWnYANo=;
        b=g011QXajDkT5pzoTghHf8Ci8d6Cvn76iN+gUIrdJt3qwMTrIaYHAyoD/DTVwMYpM00
         CKb+HZz1CJkOnvsaZWlg4Sy4vqKyVNHsphwn13VDBvVJtXTIuHBa/6PoNI5Bo/4WetHM
         Pxbzts4sbJXVFXRDTWrN7/lwh7f0i4W86gsdMAyYXIQesia8tmV2nG0XzYanDpA/nAS2
         u0AVSwBZKEyMWzsqaIvIP56tP/CcqfKDPQvcK0uinbcBEZ1UOggzvRiQtsjiUmAA8xYT
         wCpZwVtQRWSJk/jz0HnPv+UTB72pnHmCuFCJ5RwuGzeSKPoDQXlDkya0/r37a4/WrX3E
         BhRw==
X-Gm-Message-State: AOJu0YxEn0O2/IqTtVC/cnIO4Qybm/zuSFyCK0cRPM4gBm587+gkJd7D
        L9QwFsOldMKIfuY74six8ZDml8WT6G0rwHr/X4ynkTE1PSU=
X-Google-Smtp-Source: AGHT+IGH7gzAXpHsOraYJ1zC2Lw0c9KCCd8LfJ9kveyQePV+I/6WXRHlPV0jRfhZVCSMo2y2yLmOekogtRGJE5l7Ayk=
X-Received: by 2002:a05:622a:44:b0:403:a9aa:56d6 with SMTP id
 y4-20020a05622a004400b00403a9aa56d6mr1428996qtw.58.1691738492940; Fri, 11 Aug
 2023 00:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <6f254344-8e0c-4127-339f-921c6595b3be@fau.de>
In-Reply-To: <6f254344-8e0c-4127-339f-921c6595b3be@fau.de>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Fri, 11 Aug 2023 09:21:17 +0200
Message-ID: <CAK-xaQbkZdy9Yro8VnooZ+wBp2NgJ8TiyKEmJ-Kv9mWP7_VnMA@mail.gmail.com>
Subject: Re: Filesystem hangs under high NFS load
To:     Philipp Weber <philipp.ph.weber@fau.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno gio 3 ago 2023 alle ore 03:30 Philipp Weber
<philipp.ph.weber@fau.de> ha scritto:
> we are running nfs on btrfs on a hardware raid6 and are experiencing an
> issue under high I/O load originating from the network. I am not
> completely sure whether the issue is originating from the filesystem
> directly, but I do not have a better place to start.

Same thing here.
Short story: we use a R730xd to share a ~120TB storage (100M files on
45M dirs, with compression and deduplication). Sometimes, we have
reads always running, but writing completely stuck.
running iotop we can see BTRFS threads working (but rate is just about
100kb/s) (no visible activity on sas HD).
Doing tests in the weekend, I found it could took till 20 minutes just
do complete a "mkdir".

Anyway, we mitigate this (after asking in the chat), by reducing the
number of snapshots and rebalancing the metadata.
It can still happens, but less frequently.

My shot is about metadata tree. i.e. after 20 minutes (just one case,
not always) for the first mkdir, all the next mkdir in the same dir
runned immediately.

Not hardware problem. Before we used with ext4 and XFS, and never had
this. We used for a year ZFS, but we had other drawbacks.

Hope it helps,
Gelma
