Return-Path: <linux-btrfs+bounces-10135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D39E883C
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34B21638E4
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF319340D;
	Sun,  8 Dec 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGoTxtS/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967BF12BF24
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697519; cv=none; b=gm+jqvTXiCfJKt2gsN6WZwdTJomudQtgwGj3KyZ+j9oacX5Bmx3WlGNLI4Qkzi7/zww8FV7+YPWyjq6lji421zW8IKbolm7Pxbecw8BvvGQSSI1ysjq3y87kPAXQAiidLQsLIbx4Xia93hNjJylzhKulNQ6n9jTHCCscdGxsodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697519; c=relaxed/simple;
	bh=u7HY5d8HFbQRdX7eKnn9ff7EphV1IDyt0O6F0HfhEs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEBK/ZyFOXT1kF7ZEeCKhUizj8kDWyuHfeK7Fr3WA71zwmW062anx19CQljdlYrrDyy9t3Ocw7Li5N0LiglSyLYe+K4S/ALOSX7kilP5P2ZQ4gqZBObCzYsFFqQQyWMfpjhJaHhclTbicwEfwq60VMrtHsRYlX0PV8Wqu+W9oXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGoTxtS/; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-841d8dec299so262206239f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733697516; x=1734302316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XiJ8/gnN5rZjeH0wKZL0xGxWVQZMGQc3R60/uNMnns=;
        b=cGoTxtS/oefyYh/lxKjuhfUxGl/rTzeO9tNijo8hjCHtF58OB7Ge4OwFnLZdQvPGO4
         +BTf8NFZVLo44y2tYxOBAZQqZhugSQuhjVTz7Nw27ypOPYLxe71H8wSLCj+eHbg7ZZZX
         2KSaJrQ5E1h4/gW1zLzBQEc3xph0Gj2TJQlfp64EopjPWi6ehIDO5MNUCmGoSI4sx5P7
         V5pJDaNAIn1XpuE9x3sXfjaYS78ZVHwfg9PuHrthzRgbvyDZ7lJeDY2z9ahGI2sL/Tln
         N4hA8nBak3iYSAtxwmxrc6Bvr1z6su9MuJg2fpwGWi+FCeZwoqBRH6bwCUuCE+ROz6EV
         yJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733697516; x=1734302316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XiJ8/gnN5rZjeH0wKZL0xGxWVQZMGQc3R60/uNMnns=;
        b=D79RPbl+/Vy5FqDpkTf/OVez/20EzfSbue6Nk93djs4XeK9K0xiQfhimn+S/IkQcOM
         sHaM/eiqEOXoNnblIybjTk6VyzCmeRQlpbspAIukb5ImhE/fRVLKkGKH414hywKjfFdH
         PsnBUu6tTPJcAes4btEWbnbk79iN567YF3W04kz4ZqEZmT0VFQC8Sc2rGlZK+SubFrqv
         kz3yks4vvdxl2OXEAcx0vSMommj9wWmK8yc/D4XSZGq0X9BrylrKtYOMzgdBuA3+FAiy
         W//ptfSxuSWHtFDKqizNs1CXwhkrHwHq4W3u8+Fiafum1wYQ3kGfPSxYPJpzBnwm878k
         Uhhg==
X-Gm-Message-State: AOJu0YxiMAppIU6mdxYRuaniU9aSW//g8/SeNlTfcfICiyW4c81+g1vv
	wSbjO+Q99krDg4cj0UeEMAEh9AtsHFn3el+JfrgQVyqIVe6i2FF8OUOiTw==
X-Gm-Gg: ASbGncuJh25lxT6pGdfF974qyT+38pLWUtFxOi7d01Vilbv0xbW/TRkqXzXLi0nI+/t
	LjI0RHVCkjIkNzgxLadDWuHQjlQ47AzR3AeVXbN4wq2zzojs2oucRwZG1gnM7IMVUp8INBmLUof
	O1x4tcwmoxZNGe1MceDHxxS48je52z6eL0QqHUbuIL6f1vtm3kRJxUBowsW0YZq9+dmtnPjhxQi
	QS+P6tkcUQZc2uoJVbrHLXnm+W0YutTFinb8Z/CY4xpQXHr0I+Ak3IAHPE=
X-Google-Smtp-Source: AGHT+IEM1goYuF7S1+9VRzoi4pmtQxnFJmUZDKDaHDufAP38yn5HoLTBsesDbbAtLsGC61oxDwsB4Q==
X-Received: by 2002:a05:6e02:1c46:b0:3a7:4e3e:d03a with SMTP id e9e14a558f8ab-3a811e2e714mr99024635ab.22.1733697515852;
        Sun, 08 Dec 2024 14:38:35 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a8f162d6dcsm12704745ab.67.2024.12.08.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 14:38:34 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCHi 0/6] reduce boilerplate code within btrfs
Date: Sun,  8 Dec 2024 16:37:59 -0600
Message-ID: <cover.1733695544.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch series is to reduce boilerplate code
within btrfs. To accomplish this rb_find_add_cached() was added
to linux/include/rbtree.h. Any replaceable functions were then 
replaced within btrfs.

Roger L. Beckermeyer III (6):
  rbtree: add rb_find_add_cached() to rbtree.h
  btrfs: edit btrfs_add_block_group_cache() to use rb helper
  btrfs: edit prelim_ref_insert() to use rb helpers
  btrfs: edit __btrfs_add_delayed_item() to use rb helper
  btrfs: edit btrfs_add_chunk_map() to use rb helpers
  btrfs: edits tree_insert() to use rb helpers

 fs/btrfs/backref.c       | 71 ++++++++++++++++++++--------------------
 fs/btrfs/block-group.c   | 40 ++++++++++------------
 fs/btrfs/delayed-inode.c | 40 +++++++++-------------
 fs/btrfs/delayed-ref.c   | 43 ++++++++++++------------
 fs/btrfs/volumes.c       | 39 ++++++++++------------
 include/linux/rbtree.h   | 37 +++++++++++++++++++++
 6 files changed, 145 insertions(+), 125 deletions(-)

-- 
2.45.2


