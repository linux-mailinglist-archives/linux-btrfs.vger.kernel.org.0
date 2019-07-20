Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624806EDDA
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2019 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGTFkM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 01:40:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44046 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfGTFkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 01:40:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so15346454pgl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 22:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8TfnLXZ4x3haAltAYXroNf6QXnmeGjc2+t+JdMizH0=;
        b=w5X3HUZFv2B90AcshH1ZxzLwQiuPmbzjHS0/nD7tjeiqzcCB2t3TxOPHoJDKmWl+83
         sv9AmUVJGmvYyt5+KQVOeBwqsv6GoYA0idiNZW0kr2m416GGBgCHSSXkPuviC8HjaT4u
         W1sQKsdK6K/mo5Vlo8TbMJHhUHRK7EXHHAGNd0tcUUruzTx2bVoeEBRNa0G9ukYKShaX
         tZQtDH+CB9+KX+T+XgtJF1bHOukyphpYPnl3I04AAYrsXSTNiz7If6+ABWvMGuAzDw38
         YHwE4+6vhCdhZ9TlIFNnE3oKWSzhVYDG3WsyWHZ0/egBgtztTaq8J8M44mZU5isc791W
         WJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8TfnLXZ4x3haAltAYXroNf6QXnmeGjc2+t+JdMizH0=;
        b=ErTdXjYW4043VGnqOzLr+TgoenEE1jlhiVxD/qAHc0qJ35XVRTFNT9Fsmaz4HdjidR
         E5IYCl/DIxje4U6B3TnLuoA51U70X5WEp1asmN+5CehIyUpO2fF8Jm217Im6Ya9RxTqc
         WM8Xv3LaUzTy4B87x+wgPQDKldq/hp2Za+66vaWpDsaYItYzqkkUnRovDnLjimY5mwN6
         Dre+rugBJR+Tpdj/Csj6vG2XMTxVUCRmlQJmTY5nPWOXkseC8fZpjFi9NwwPtZpiNsa1
         K0Hf1nmhdWb+F+bJc8raC8La4jhCxMsE+vVzF+WfFisiqyUqxxJ/qU9C7ToXxc7axxVy
         PNnw==
X-Gm-Message-State: APjAAAXBTB2KnXnIngTRE+5m4cv7zk63MGas9SpkkkaDQpwxZxf9PLCU
        pKSbc5FLWioQxKef0ZuMt4F1tkvG6Ms=
X-Google-Smtp-Source: APXvYqyp5jNrkR2x9+T0etw/y4MFAxtVKeBQ6i9h3IJYaecYtNIKBw+KM38Wm1MdOQwHrQyWhM6uUA==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr60035209pjo.140.1563601211014;
        Fri, 19 Jul 2019 22:40:11 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:ba1e])
        by smtp.gmail.com with ESMTPSA id w3sm28453762pgl.31.2019.07.19.22.40.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 22:40:10 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/2] btrfs-progs: fix clone from wrong subvolume
Date:   Fri, 19 Jul 2019 22:39:59 -0700
Message-Id: <cover.1563600688.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series is a couple of minor fixes to btrfs receive. Patch 1 fixes a
missing strdup() return value check by getting rid of the strdup().
Patch 2 (the more important one) fixes a receive error when the same
subvolume is received multiple times.

Thanks,
Omar

Omar Sandoval (2):
  btrfs-progs: receive: get rid of unnecessary strdup()
  btrfs-progs: receive: don't lookup clone root for received subvolume

 cmds/receive.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

-- 
2.22.0

