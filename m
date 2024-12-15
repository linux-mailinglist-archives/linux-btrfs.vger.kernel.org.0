Return-Path: <linux-btrfs+bounces-10383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C289F249B
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 16:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C282D164F00
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAD18FDD5;
	Sun, 15 Dec 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxoPvlJI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA0A937
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276453; cv=none; b=gsE5rGgl/lP9K4i4/Il50L4sgEq2vtfVs6F2135f3QCxTA5lMlHqELk8kpqh64ff0uqTf6c2/eg4lm+XXi+OTVhmXhyUiU84rXnE72MTAzs8TB+ehO9kTsqrwjzHvoQgfM9o3hZU7Syx6l6o7qdJOSb3eTXmmNCY/4bEwbFvHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276453; c=relaxed/simple;
	bh=BGzuI7cwtD5+dy22aD805qpwPg/M8H7NWcT1rbYwSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAHvltDe+IzlV7LnxwLN1dZsQxaL1SmdS420qpUfSVJjJQnaIl98gWeNPaAvhotbBC2Q2o4+zNyl2h/+vXdrg1tBy9BpP0FQv52+5S+huN9t9Xy74x5dVBoKCBbb6LUz6c3oX9jcbehh53uZc5I4je5BTNkoytzKeBhQrQ7GFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxoPvlJI; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a9cb667783so28596995ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734276450; x=1734881250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T175VZvE8aGspfyBUIxmnH4/lX9pM7PKJsIPa+xrouY=;
        b=dxoPvlJIE/T+vrKs4N5fMKMLFZ+9+lgg3nCHxsfYIs6QzfJEh+xbejyrtXcTE6c7Cu
         v6Da2K0AzmyquR1T0YtX5YRrEIfhtXL6GnquEz1U0Ehy3whgPpqLuUK965lzST1RbYr7
         jz1NK/5icT53kkOg/LXLW6y+CQWljR3sPvr2ZC0ZUUbEmpDZ3ra3KAQXQSJQXCbf+BH/
         UsS4+hKRbka6TyTJqLuW5ls11LPHJwhh2QLwH+sY8CQdtpd+Y1x9P1eBVSSaQBEAcTWA
         cP6h3r+jYgEvKXHrNBSif8RqHvAQDMBqpqVIkiXrAeRa0flbAIZAkcPPO1hHpfNo71Vw
         imjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734276450; x=1734881250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T175VZvE8aGspfyBUIxmnH4/lX9pM7PKJsIPa+xrouY=;
        b=lFELkUba9m3hSBkQbU1w6Ln46bCp3LsL4RTyBOtyVnSybMIDvcRfACFYA7iKr/RToc
         nLN+nMAOOuqo8TxoUU6rUwF7f122/7Yt0vu1epPB7cqkGOTOHJg4XlJOe9rf07CY8ymB
         e3nntk2hSkX6U4nga+SAJKZhmG0Wm6Ivk7Hd6dSbDOM5TrqWRtrCG520MBvDOXGaWL1o
         fGReCZE4+H79ba8yro1jentoUzwsclvRmgEZfKi15YW/LgYI42xHzsVbA742PqIsR4WF
         se+VS8xoEj27tgT5f8SLSppJm3B1JE/I668+PvHVf0XPNVf4pFnYaeUkMnIZKmFOgsff
         ySaw==
X-Gm-Message-State: AOJu0Yw6vDUwt3v7Gspxijkv4D+kBFPygsVAtCmPKDS18ilg5lE+m29C
	7c9hQNL3KwJwhiA3k+7aSfcH21EsLYcnaCj5Xk2tNmMwQyJ1oNvNbqdoAw==
X-Gm-Gg: ASbGncvvwCGIBUAvwBIA/+lUjz0sUFfyujtrVQDu5rhF77350NAWV3yVk7FkdNC6RbQ
	7nSLeUVBzqig+nZnQEMJki3uXVIoyu0vpQTZy8HB/VyAXdlXW0WyGD4wZ061NO5ciLXZxYOcU4N
	zbi2O1+zsV13//O0ZEW9irH6XAKXN+Q7x6x5DCsykX6OYy8ghKbqKZU5Ncshuoq+6W1kId1aNgn
	hsZEDSvMuNWjD3ReRMR9JRrsGxFxckR6W6JlpYQmNbOdsYDlwuBS4j6+qmL6nEigQ==
X-Google-Smtp-Source: AGHT+IGmgNd2ZYOa54Q1WT0msFeQffosl+Yznytw/B4QpgIfdUFMRQLtkbgpvHfpEiV/e2PB7F/arA==
X-Received: by 2002:a05:6e02:1b0c:b0:3a9:e2f3:8dc4 with SMTP id e9e14a558f8ab-3aff8aa28bemr117382595ab.20.1734276449932;
        Sun, 15 Dec 2024 07:27:29 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e37817e7sm773846173.114.2024.12.15.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 07:27:28 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v2 0/6] reduce boilerplate code within btrfs
Date: Sun, 15 Dec 2024 09:26:23 -0600
Message-ID: <cover.1734108739.git.beckerlee3@gmail.com>
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

changelog: 
updated if() statements to utilize newer error checking
resolved lock error on 0002
edited title of patches to utilize update instead of edit
added Acked-by from Peter Zijlstra to 0001
eliminated extra variables throughout the patch series

Roger L. Beckermeyer III (6):
  rbtree: add rb_find_add_cached() to rbtree.h
  btrfs: update btrfs_add_block_group_cache() to use rb helper
  btrfs: update prelim_ref_insert() to use rb helpers
  btrfs: update __btrfs_add_delayed_item() to use rb helper
  btrfs: update btrfs_add_chunk_map() to use rb helpers
  btrfs: update tree_insert() to use rb helpers

 fs/btrfs/backref.c       | 71 ++++++++++++++++++++--------------------
 fs/btrfs/block-group.c   | 41 ++++++++++-------------
 fs/btrfs/delayed-inode.c | 40 +++++++++-------------
 fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
 fs/btrfs/volumes.c       | 39 ++++++++++------------
 include/linux/rbtree.h   | 37 +++++++++++++++++++++
 6 files changed, 141 insertions(+), 126 deletions(-)

-- 
2.45.2


