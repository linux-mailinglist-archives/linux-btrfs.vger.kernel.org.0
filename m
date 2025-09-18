Return-Path: <linux-btrfs+bounces-16907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B107B8260F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 02:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5797C7BAD1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878C189B80;
	Thu, 18 Sep 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elpo+UIu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD649620
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155594; cv=none; b=CJ9zmtJDIzN/ELYirMZjBvkdO3s8C6Oc4HAp8bHReMs0nlc9FmSDw4xNXeNfCbVcZ3TqcIwzokbhmqiRIHJpVnRoaSsIXayOo6PKieHZE5LqFI6IpzGRuWVsue98gAoD6b5SX2EN7bUpBnH3rtL9lT6LwKMuA1ZJPFPuKaOFIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155594; c=relaxed/simple;
	bh=LBHsxbf0yEzYNkoHJumaByDJptxOyyGVYFYOK6nPeMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWw4O/4xIa8MK5uzOwRw+KrPCWrtNKPz6OYPXf7acIwvieBAZv0E6OhZf9rghayoiHX0TqIcNAeNrNsTM0Z92AmMfLczqZ7f94Yri0/VtSN6yIg2Nc/btIGXzqZY3X0uF/UPBjecH1vhkrmZHFNr9mTOI2tV3NN5hn+hTbprVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Elpo+UIu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so378266a91.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 17:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758155592; x=1758760392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alNEDHkYj4UwgFJfpZtNe+JoOQZl0DKS0Hbg9hD5I0M=;
        b=Elpo+UIuVLGcZ3/4nlO/b2OYOemgtuM5qx0rOfc+DA195vvog7IZjYX0nJctVUTX1e
         u8mgtquYOt9J9Eq6p/X5WvX7nwM02bEGZMFqPrEtElwbM7TZwWio+8PHG8oYe0yg77Yt
         f/znvUisRB59YaSf+PMSUL110IRXtv8T079lTLd43dmlHH+KBRzZ/c2y2ZrML0N52Sdj
         WKUNViRnwBmdPU52ifUz9Fhev67aZvWTCVWpMSSUzD6H78DX9o6NfFiN86efamAHFLg6
         0wB52hZT5fN9ouiIouOsyJe0fwSParOfQ5fHMcmU5/+7rRRxMFOvbRTd4DEuXdZCyCPz
         DCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155592; x=1758760392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alNEDHkYj4UwgFJfpZtNe+JoOQZl0DKS0Hbg9hD5I0M=;
        b=AAkIS3U6jhn2ipsZLd4qOSlxSyCKnV/8g9Bhy25t1jJd45dx4d3uhjrp6LkGu86n+l
         3GqFbPdZGz5n4xCragxVrk147sKX09w8obPOPhZ/2G+9sPC3QVux/knOE/PhSDxqOphP
         64erj3W7W+6bVgXzKosXb4Z7jnOhAyukvJJqmn0akBClFWLpGCHtZS7D2vnXSkVj7vkv
         EM3YqsvHf1P6tD3sLF7BEiKpmd8tf8/I47QfEmxDl0WcwxXfurVWvy7oOval9SMWSPm5
         07o8+rfNTImaXZL8rqIYb2ehgGsQjuxbJFGR3AInUuw1elLvGV7pobkf0K0M0qOENay7
         EdbQ==
X-Gm-Message-State: AOJu0YyDgGfdFJNzMWRsycIU2dQgs7xunapssbnpXsMoL3DMviZ7cGoK
	8UlpNRu6E0CtHqearN5WgOMaH1l/8PmOKlk4pvKl4arLN//V0SFdWVWX
X-Gm-Gg: ASbGncszyaTYTP98hPP9MPxcuCW9eeU5xbf+ujefhrpK9Zpvz5K1MUzIinSAGE4TOGN
	cSUpuyzlsmYQE2bEbkDcj4zR2cC5IPuxfjVhaHvZiPCWhMqSFkqGsMxOcEcbFbEQP+ed732wR7K
	E/FADb28Izo4gpw7VfEcm8V1/KfVRrKLgOHUUXPGEE/8PvCuhnd/YZwopFOSozn9GS37HM2c1GQ
	Jf37JFvoeqsUFONvPR03CgUc7J/2G4QD6EwobG0EaffiMgP52uf5nwfojWRpGA7OTeBg6T3GjVT
	k3AL7faMRiYu3Tz0FY5AgFp4OHKNVTyadQ0CRKyejXWdiTs/yx3DkXtfNsL3vdOxLBd0ywql+zm
	vaO8jEgSFA2bBQ+Kt8tCnMZZRtwS6uU+jLLxf+sU7AaeQKyGjMU8ohmAeIGFG5t0JWZLSv5gRhA
	==
X-Google-Smtp-Source: AGHT+IEf7CfdL2G0zgOr4lOe+v0GOFpLZOn2lEtSrXOhRsCbbXct6YA3vr3/ZGxOalR+XN4LYliqcg==
X-Received: by 2002:a17:90b:1b0d:b0:330:4604:3ab6 with SMTP id 98e67ed59e1d1-33046044ab3mr3518295a91.18.1758155591957;
        Wed, 17 Sep 2025 17:33:11 -0700 (PDT)
Received: from feddev.blackrouter ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607b1f5esm644428a91.17.2025.09.17.17.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 17:33:11 -0700 (PDT)
From: Anand Jain <anajain.sg@gmail.com>
X-Google-Original-From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fstests: test device reappearance with new maj:min
Date: Thu, 18 Sep 2025 08:32:45 +0800
Message-ID: <cover.1758148804.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

Tests filesystem behavior when a device reappears with a different
MAJ:MIN after a block layer transport failure.

Anand Jain (2):
  common/rc: helper functions to handle block devices via sysfs
  generic: test case for reappearing device

 common/rc             | 26 ++++++++++++++++
 tests/generic/809     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/809.out |  2 ++
 3 files changed, 100 insertions(+)
 create mode 100755 tests/generic/809
 create mode 100644 tests/generic/809.out

-- 
2.51.0


