Return-Path: <linux-btrfs+bounces-11467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A911EA36382
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 17:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFFC171A6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BC267AF3;
	Fri, 14 Feb 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+ZIzMnk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB462676D6
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551637; cv=none; b=D4V/s+IkkghqzLBjlnL9EOm6Qv0P8hwnacT/tlqXWJGjhyhyN4SqlXucwu0cr/PuWhqW/42XzjBjqZJibuaCs/RnX/UMGKrajuoTgfj06yyXBdUEk8dNBbfprcmJILLZ83sBlgS9sD0zRkQylQ4WFsO1vHJg5ibm6QalkhZJAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551637; c=relaxed/simple;
	bh=gwm24tJjf4/Xwv6+scrU+8GRnFfcWJXh+8Z2BHkM+Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HemxW/6lsVIp11tI3rPs8ORxAcUhybDd800Ta3QFvm7QryGEkNU+Zu8cVWJ+6XkTL/fUCDEC9Jp+P3H8kJHMPCOCr3vwf7csD+iCaSHWqSX0/PqxbSGkQs61QmmaRb/8pCfUOj/PU0RCP5mKu1iObzkaTgbJ2not/AIeaWvv+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+ZIzMnk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd93a4e8eso1998516f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551633; x=1740156433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBpTQ2zV7wjIQr17mO83N6ZezN8zP5QEuX38xZgk7nc=;
        b=H+ZIzMnk+DhpDtUjeVp5uICIylNYA1DEYEb9luqtKi2rEBP/J4L8eILI+9wSd0YeWG
         DdPEf+YSdP86oaA94794tITk0FAkndt9NSwsZ+nm0/7K2rz0W5v4GC/8jjHdgXW5XCbe
         xxtyFSgmUxm9L24Dp+MSZdUDsaWwJ8jNMRg4cyEJYUaEQkPoXyVTawb9opq5mhJJMV0g
         em7U1QsKtv547N9Mm+1P4B0eBKmIp4JLDG2xQHXZdPv385tJR7EiBhktzRVXRScN2LHW
         rnUH16NNTNpNp1C6KqM6l0+0I5O2eO64LT/KLX1/974XzdtzUkQouwI4nfeSY4gvf4L0
         9H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551633; x=1740156433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBpTQ2zV7wjIQr17mO83N6ZezN8zP5QEuX38xZgk7nc=;
        b=vOglJXTSezZ4xPMAMmBKEe8pg1eMlNZFoiteqzhx+6E62XwWhgFx9HPISJykFoJlHF
         1qYYam8fIPa18RNae6QKLyL9xc2l1GhuK7D1gbuv2PHo3ke0Om4b1MD6E1xfJBRa/UGb
         jlrjoM6JXGdRE89FuXrBfuVYjoxfrl1Pq2cjVtHDqrEJhVy4xXXt1w1BnhVr1isv+pde
         PTJcNHWky02GT2A9NeqtPzgi5Bc1yC6iueTz1ZxDyYFYfn/5DqckNr8IYnENBeeTPz3U
         Sc6krwFv4156frDpnCsiJuTVwODJeV0G2liC9VmZIa/5ZCCqegdD4dmqN+ScnuuqBJ6D
         JJcQ==
X-Gm-Message-State: AOJu0YwxGdETRq+8AW5y7ENs4zNnv+SepgzMOQ7zsk0rIKDYgW0La6mt
	ILwy6iTbPkiJUza78Eb0mhSXiogVuKhptKP9hE2J1EKzV7bWxMgO
X-Gm-Gg: ASbGncuDTexKl4r/cd4EbeKZMIKN2bRTtW4YZP4XAHd5FmkILor1aMi/pWysi/PLQZm
	FZI/8ArQvQsY6XB6HdO6CcbxuggCQTysSf+YvbEBEYb014LGwSEXbpY9qoxjKJKrI8H701TAqCM
	BxESblVOgusxQ6QubYJWlWYAbZaec+DAvmQj2zVHn1AAz//weFGcP65MqxXLmx411Vo2n5Gs5Wr
	nDCVVaAZ1mB8Sf6s4fPnx9oFrWRE2/v47uSchuoxAz/jmFa2drA9CNlaxY2l0mekXoEwgiZMlwe
	N0M0TEy4UH5W
X-Google-Smtp-Source: AGHT+IHptDEpkt40wT0tnn6pEOukALy8TevnNOv5xUDlCBXNLIXcQf/+v5fs8LAwZFUZqEyz2WN3rw==
X-Received: by 2002:a5d:588a:0:b0:38f:2073:14a7 with SMTP id ffacd0b85a97d-38f24526be2mr12758253f8f.47.1739551632605;
        Fri, 14 Feb 2025 08:47:12 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm375019266b.131.2025.02.14.08.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:47:12 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 0/6] btrfs-progs: V2 scrub status: add json output format
Date: Fri, 14 Feb 2025 18:47:03 +0200
Message-ID: <20250214164709.51465-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is a follow-up to the json output implementation sent
earlier this week. It uses the new fmt_print format types (duration
and date-time).

The patchset also relies on the following patches:
[PATCH] btrfs-progs: add duration format to fmt_print
[PATCH] btrfs-progs: change print format for btrfs_scrub_progress struct keys in print_scrub_full()
[PATCH] btrfs-progs: Simplified unit_mode check in print_scrub_summary

Example usages:

1. ./btrfs --format json scrub status /
Result:
{
  "__header": {
    "version": "1"
  },
  "scrub-status": {
    "uuid": "1a7d1bc4-c212-42bf-b05c-73bd313d3ecd",
    "info": {
      "started-at": "2025-02-11 00:27:01 +0200",
      "status": "finished",
      "duration": "00:00:15"
    },
    "scrub": {
      "total-bytes-to-scrub": 84444946432,
      "rate": 4726353100
    }
  }
}

2. ./btrfs --format json scrub status / -R
Result:
{
  "__header": {
    "version": "1"
  },
  "scrub-status": {
    "uuid": "1a7d1bc4-c212-42bf-b05c-73bd313d3ecd",
    "info": {
      "started-at": "2025-02-11 00:27:01 +0200",
      "status": "finished",
      "duration": "00:00:15"
    },
    "scrub": {
      "data-extents-scrubbed": 1507393,
      "tree-extents-scrubbed": 108172,
      "data-bytes-scrubbed": 69123006464,
      "tree-bytes-scrubbed": 1772290048,
      "read-errors": 0,
      "csum-errors": 0,
      "verify-errors": 0,
      "no-csum": 107693,
      "csum-discards": 0,
      "super-errors": 0,
      "malloc-errors": 0,
      "uncorrectable-errors": 0,
      "unverified-errors": 0,
      "corrected-errors": 0,
      "last-physical": 159691177984
    }
  }
}

3. ./btrfs --format json scrub status / -d
Result:
{
  "__header": {
    "version": "1"
  },
  "scrub-status": {
    "uuid": "1a7d1bc4-c212-42bf-b05c-73bd313d3ecd",
    "devices": [
      {
        "device": {
          "dev": "/dev/nvme0n1p3",
          "id": 1,
          "info": {
            "started-at": "2025-02-11 00:27:01 +0200",
            "status": "finished",
            "duration": "00:00:15"
          },
          "scrub": {
            "total-bytes-to-scrub": 70895296512,
            "rate": 4726353100
          }
        }
      }
    ]
  }
}


Racz Zoltan (6):
  Added rowspec struct and neccesary include file for json output format
  Added json output format for print_scrub_full
  Added json output format for print_scrub_summary
  Added json output format for _print_scrub_ss and print_scrub_dev
  Added json output format for cmd_scrub_status
  Corrected a minor JSON string error in print_scrub_dev

 cmds/scrub.c | 307 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 235 insertions(+), 72 deletions(-)

-- 
2.48.1


