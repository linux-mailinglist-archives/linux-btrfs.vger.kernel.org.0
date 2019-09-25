Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C612FBD703
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 06:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392199AbfIYEPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 00:15:19 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38662 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392066AbfIYEPT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 00:15:19 -0400
Received: by mail-wm1-f48.google.com with SMTP id 3so2679353wmi.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sj65fseuCEXIv4C0inVwsERBI354ojkulbeKq5ZGLo4=;
        b=BRsgOavGZHtYGWRMFZsRzPQ3lTbQq9cXBSsnr7OPMTJ6FkcgYqjqwVEvG25iJR5tDL
         A2DbN2ndX1eCTX0korJoOaWNY4E1covbd40Bxai9Qa+IgD8hS7LHuCRLtMWRsVPwukqN
         w49X01c8t2wBi2voEMEJ0JCxHQnmIqqv9CRGQNG2zLt7fg4Du4c6lnzXDsh4Xbo7BgTG
         UoTuCRNaHVCRIb8aaDxHJWBOQxULKx6w6MVuf9dnqV0KLtZEL+qxHvEuMHfjUZkXrmHw
         +v3RM62Kc44oLm6hEFeD0Y7m2hHpCaBlhZtE0YqoFbz+AyoPdtMTylPgcKBhcltXfn6+
         dfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sj65fseuCEXIv4C0inVwsERBI354ojkulbeKq5ZGLo4=;
        b=RBzrQs5LQx8s00EXNX4Gohn9rbj61Mir0aVY/sZGeQtt/sZFU4YB7jFYOk2c++U2ws
         pjp58X6ltCDEU61Rxij71qaZPZRuPy+5QYslTAuovwIiWf66bDiB8usos5P27FYvJdgB
         Uc+q5wDcellYHrHM0cVxPa4teemO8pZsX+0QwHsCG0txqoeFGKGYHPJxNAAFY90mWv/s
         vdXpr0VhlAO5nTSBXYYKSahNUBeZ6CH8mpujz6rbv6Th7tRL3Rqr9VtEDRsDD7Ehc1Oe
         YZ11Fm8X77279xRJJ/2shG+TqafaM6vTBDpamvBDuDxngWs0L2EN5Yo1npzvKBZyYCOG
         uNbg==
X-Gm-Message-State: APjAAAWD41gvLNN2h6cAwliHR7DmJU0KJ3hushAtuSWooNye1Y6dS+w4
        1YeqIPvlxSRZ2qp/zOFwEfqwkLviK0bnynRJ1RlaxA==
X-Google-Smtp-Source: APXvYqxDZcDCp0Y3cAcTqEwAJZuFwp6cugWs1nLnxmAA7fke1s7sCff/+S3Spc6QwHNfLvs3+3fAhvohCXvySkIXoL4=
X-Received: by 2002:a1c:4886:: with SMTP id v128mr4759270wma.176.1569384917209;
 Tue, 24 Sep 2019 21:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtS6uHcH3CmM5WpTOGrZ8EFPkFr8Xo92X+Q+VxvBiaW4ug@mail.gmail.com>
 <dd2ed71d-df70-28e2-206d-afd16dad64a6@gmx.com>
In-Reply-To: <dd2ed71d-df70-28e2-206d-afd16dad64a6@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 24 Sep 2019 22:15:06 -0600
Message-ID: <CAJCQCtQBTPTF2i+e_wKPdX5gC3RiKJs-yqNnrswepkmLMnxMKQ@mail.gmail.com>
Subject: Re: error: invalid convert data profile single
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

$ sudo btrfs balance start -dconvert=single,soft /

It's definitely a 5.3.0 regression, it works without -f on 5.2.15.
Super slow. The media should be able to write at 20M/s.

Total DISK READ :       0.00 B/s | Total DISK WRITE :       0.00 B/s
Actual DISK READ:       0.00 B/s | Actual DISK WRITE:    1418.15 K/s
    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>
COMMAND
   1138 be/4 root        0.00 B/s    0.00 B/s  0.00 % 99.18 % btrfs
balance start -dconvert single soft /
    402 be/4 root        0.00 B/s    0.00 B/s  0.00 %  3.09 %
[kworker/0:2-events]

But anyway, it completed without error.


---
Chris Murphy
