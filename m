Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0467624115
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfETTXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 15:23:51 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:41669 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfETTXu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 15:23:50 -0400
Received: by mail-lf1-f47.google.com with SMTP id d8so11163109lfb.8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=f39SFbDd/BLat0YQcM8gsTfXqB0MQL1YvnA5eelW6HQ=;
        b=CCN8KhEcZevpswiRHAN0y051Hpnc9xOSo7mGnjtGZMRp9tJE+e/WxVX6ev+Ar3mfSN
         GS6w8oE2cdZ2bBtxTVnHs+vXV3OigZBxaDETmLmc5D5JOP3Xzv17p1tBNJBF9w4B+f72
         Vf8dDjKHkMhPATeD7OrPed82S/gFOuS+w/5TuMNOnh5JDpktvuF0uyqeVOrl51I6juQP
         my+dow8qtdASSRZryp1tcgXBorRiAdwVIzneCQU1LCYHk65V2wriQMSECzckckqX9HjY
         7ufuDSpTH2q6SxYh9e5jmCun3fffbdILd4Lh08mxYLmwx58elgpMAo7rtLLTPFf85K2g
         a7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f39SFbDd/BLat0YQcM8gsTfXqB0MQL1YvnA5eelW6HQ=;
        b=nB8AYzXJ/9qiUOTmocdwLF8sjDBnek1kxBGWuHBd1MfSVLNd607Lvuvc0YDKDPn9eM
         qm1ZFSuKF/+YTv8cnpOwsq4h34ibcf8fjO6VKLbEyqYsVZza8ByySj7EyixrKHt+Viht
         vafw5LHvjA1tR81JMZt27R043/pa8O9P9BIfyVtsjLLUiqthH5gWXB/mB8b165Pl86TS
         P/uHpDa1NW7b15R8a3QY9/g4L8FbQ6dXfH6Tvy4HKHgJoL9p5eiPjUxzT7YCnsAPs855
         bsnUY93XcJ0t1BtbouyzOJWPIxw77MzhHeSUyVylPo1C3pKljcl7DBG2kNi0EyUU7eUD
         v1cQ==
X-Gm-Message-State: APjAAAVhYXc1Nv0d4hS5q5/ecVsSJpt1Kmj7x/Eox7/aJq9lbQgxgEAs
        Fr0GtIZnAsyfNMr7rU5fJe8JuLO5LXZV7LsiBDLOYD77CtA=
X-Google-Smtp-Source: APXvYqyPDjrUmdlHGD0VXkjWTDBF2J9IVofqeWPF0XmiWBLChiN/Z4h6/flql9KxysqdWO/R5tEs9DrDda8M6+QLn3Q=
X-Received: by 2002:a19:3f4f:: with SMTP id m76mr36684941lfa.17.1558380228759;
 Mon, 20 May 2019 12:23:48 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 20 May 2019 13:23:37 -0600
Message-ID: <CAJCQCtR4NsGc7uA+j2yuZkuQ4NYpvdZ5enkh_-zDd2FhV0pJ7A@mail.gmail.com>
Subject: 'watch btrfs fi show' crash while 'btrfs device delete'
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs: btrfs_scan_kernel(): btrfs killed by SIGABRT
https://bugzilla.redhat.com/show_bug.cgi?id=1711787

btrfs-progs-4.20.2-1.fc29
kernel:5.0.16-200.fc29.x86_64

If I understand the bug report correctly, one shell is watching for
changing 'btrfs fi show' while another deletes a device, and then
there's a crash.


-- 
Chris Murphy
