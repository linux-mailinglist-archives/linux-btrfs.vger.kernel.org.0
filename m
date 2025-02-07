Return-Path: <linux-btrfs+bounces-11331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D4A2B91B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 03:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EDE3A8331
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6D1494AB;
	Fri,  7 Feb 2025 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlBurXkO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12816F0E8
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895599; cv=none; b=qLcyviU9evueZwZsVE/9ufHou0uulFEN17+Ug7TCcaLy7KnNz8wT/cSSWcQ27iT3qIR9zYEGcQN6c1pmqcVdtYmwrDI/BsBvT/2bJyMVjtgB8ZqTi/Yj1j2kEoYeS5ETZKnGnOHBbtJAHVUJZFTvi3u+dWSHi5zM3wvgybgQPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895599; c=relaxed/simple;
	bh=hqwEdwfqNl6tO4roYM0QN4EC+EwJ5kvlwcWE6xkmAEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exm+lh6mh/NYUiTNggACRZDbQKCVEYiAxP+3jO9m4PH1DH9V4pQj7/Vo3abvVWw4FLUq8V1oJKg8u6GHQqrfGYuV81sG5yzf4UlPs8NfwbnFHhNzoQNxnplMBG2WCW58uw/NDVYxnWhUZZZLkjQnHu6Mzdyy7D9yFH9q/vso2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlBurXkO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeef97ff02so273149866b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2025 18:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738895594; x=1739500394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkuAYY1bti1nY2VEqNvp51ZpnWROIdMw+YELdrDXBs8=;
        b=DlBurXkOSVn9juFOMKtw8PwYE6+RdJH/V1EdvVPETspq2SjSqKE3Wqqk+crcJWzJLO
         9zdWsd3rjRSPRKXJUBC0/fCr+fAySxp2JAv7CJoI7xHa7IcFknHib9HLXFckmJcMWrdg
         YDlKcQuVs5MCjGXe7Er2u8f6XwPHZSFbYlKSxbvJO4u3Qn6Pf84iiwCBqr5oy6lKGweE
         EDRQyckDTyAtpEzyEhdrlJ2uw5REOCZkU8mHNT3oQav+UxWLDqz41Q4QBQR6bNmEQ0+J
         hipmXKUgjewf1uNytmQYO8DE6KCiYEik+lp/pufat3oP3+XIlxK24tHkzNTHn9pMa6CV
         HEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738895594; x=1739500394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkuAYY1bti1nY2VEqNvp51ZpnWROIdMw+YELdrDXBs8=;
        b=lkW1XdeE30Ke9il8iwQfNnujqft3Zsd/KweSdG6s01ht/qFCtUyYeqlou8h1/97eYe
         duRWZq+MTYEKje1q5gI57uNmqS1/ESXA2j5k3GwqT/ElRwt73aMBnllMsM2iCjzo1ZeN
         ReQ4SeaK3gmT7RG9sLfqn9gl+PsG55/qvHE90YwrZmsk1bT5P6UD/OrneMG35sJLq0kH
         /2UHecChl4ctqg/nWLfGY5ZjLM6AeB6GyTymtKl4HnBCGOv37262bh30Lc9WqcYAXorK
         6XIqw8GWjdCG+UsYL6qxmwIpnaDCm+0Y2R1FqykEf+YsEyi8+3YkzFnxlm5OCRrft3Rr
         w0Ag==
X-Gm-Message-State: AOJu0YxditjmNtv2N9ZoYu5Ax+5MbEw1CqOVXb01ywaEdEIqfG/VDTv5
	o/LKv9nR/PjzJX0FNEFFfCU2OgorF+tUWpo+0Jqg3ev2M9MPRq1X4YS2JQYY
X-Gm-Gg: ASbGncutBGKpDrE92eXAws1HbAnJsfQfc7nQfKUeaRGQ5ed6xNq32mPX5x9mRohEAeV
	E5zjLgmJIypoaLF7/H2nV3XstogP8EfpKXHuoI7CP6t5Ns1w1J/WPrg/2aTBnc54lxa0la9CRRL
	ytuuYA1TLSmUQcxNd/8EiwbN5Jo3x7ImXNu5N7D4DUt9jvT/nkJU816cBI+KP/ioPqGyAQtv1qx
	gZPQdm3lvfUPgX4omA9WJEMVI+WNUC4uDTlvP/l/q4HYIYDa7k+j+lOpfsqhINtb+2PFWw8J4Gc
	x8g1HubygSHqzg==
X-Google-Smtp-Source: AGHT+IHCkzJUpyyyU7/QL26dZm4nVLmFkJQPlVJGGfQ3kLw1tDzClE+eyF/LJj335BvwNgV1cLTKBg==
X-Received: by 2002:a17:907:1b10:b0:ab7:85e2:18bb with SMTP id a640c23a62f3a-ab789a9dbdfmr84467666b.6.1738895593723;
        Thu, 06 Feb 2025 18:33:13 -0800 (PST)
Received: from 192.168.1.3 ([82.78.241.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de379cedc6sm1086752a12.44.2025.02.06.18.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 18:33:12 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 0/2] btrfs-progs: scrub status: add json output format
Date: Fri,  7 Feb 2025 04:33:00 +0200
Message-ID: <20250207023302.311829-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains two changes:
1. Remove redundant if/else statement in print_scrub_summary
2. Add JSON output format for "scrub status"

 cmds/scrub.c | 241 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 185 insertions(+), 56 deletions(-)

-- 
2.48.1


