Return-Path: <linux-btrfs+bounces-9755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F2C9D1DA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 02:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1741F223B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133E12AAC6;
	Tue, 19 Nov 2024 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="NI2EkOpg";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="SzFZxTSW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BC2E3EB
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981101; cv=none; b=p+pBmpvrch1hK7MXFqlrd001Keoiye+nkTwKtiif400FzWrPjnk+MgmdHsWLHleHFe3IcDn515xB21/8Bvehl7JsOz+oDqCQDKpncT+NGRxkTH+lUvy9uoEQ78Tjq8DGJnS30TpqBRsyMGS/qJ9PseM2Pjkn6pFM7w7lYWwKndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981101; c=relaxed/simple;
	bh=JNHfWLjmcNh0savSK2dTYj3KRBQ0Qin72jrsTn8ouTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UVBwf9ccVYzXvAg5D7NPLL/Mgt68s2ShR06xgXijX2X8PIysAjNI+a6r80Kwp/ikaSKh2f9cYKwBlTAc1HlCBaUYfqei85l7Tjd/4ZCr+PJ+gv/Xu9vIhq0smwCWjK1+gB10P+MtxsJKC3fAnqpTpnz2ZCK7ZScgpObUtE42Bf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=NI2EkOpg; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=SzFZxTSW; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1731980616;
	bh=JNHfWLjmcNh0savSK2dTYj3KRBQ0Qin72jrsTn8ouTE=;
	h=From:To:Cc:Subject:Date:From;
	b=NI2EkOpg1pWmPyIzDow5t2YlAUb/KLBXBr7VywzN5MimcBSz2xpYOtqSixbkzAbrz
	 clr5Sj1xoiVnUbvIxN03Nl2nmFmQueeehrFlR8MDc6jE+29IGS2ZlsYPRDHdPSvkNw
	 t1MBNyko19Y2ge7MuLnJriBUgB+CVqnHOLnutfJYKdAyzHUWM6QC5o1JfPjFq2GM/g
	 hpP22qq9LGIHqKjaaKnCYWvqYeaGcSbaKszM0XJ940JF533LcyR9V6tLqv8fJKnZCM
	 ZZXtjPBF9vUvIZ7TJhb27ROfnJAYlCxVqe6B2Qy1+8OepwAgQZ0vxS3njYSRfPP4rU
	 sJren50npzNeQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 1C5B8376
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 10:43:36 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=SzFZxTSW;
	dkim-atps=neutral
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id BE5A3105
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 10:43:35 +0900 (JST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e578061ffso5199500b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 17:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1731980615; x=1732585415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THijJwiQduF6cgUftllyIbni04Yo7J8XUSOh6hgdQVk=;
        b=SzFZxTSWOk1szq/3+D9BVdIn0LzJXQsZMIfj4hGwePCz/SwYc6j+zW3DWVZI0S1iVb
         SgHOzhUhxUbrlRkkna6g1HlKu8thie6i/lJ03qf0rjJV7dM7X8GpTbIj3laztnin/0Im
         JQrOIKg1Bb7tJz3ADjZsfmerX/lf/KQTdLsr+wlNrXeYrbRVCSRYYwLipLVVX8D7Tzb8
         6j5iH32fDDVoSJhGWDei2CJhHFZNZc+C0ge+II8vBdoFQrI5oemmt8EWADx07LeXW7zn
         SL7evdUXQnTu6CPK/btwsFSp4VVs8EJoi+8ttTb5a/Z4TTC5S8Ym6a6s9G0wvzCQz1UJ
         3L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731980615; x=1732585415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THijJwiQduF6cgUftllyIbni04Yo7J8XUSOh6hgdQVk=;
        b=dZYl/q5PQqJitM21kjE/CaNWOxBxwmUEDwZpdxtJ7vH6dx7dydd+/HxQdUjI+7DFzq
         PZn3m6z7TNehGf6HI9zltx86nEXTVCjoiUDc/1eYrP0i6ak8qXlK9XyYPYizdbuHRBIu
         UwTToeo6LZwLGZhipUBHUlsYfyycsA7BVsN8r+G8iGVU3aYN3PoABqm1FqVkMEZVwLVO
         Rvvugh3DTbWM0sWDzBR4XHtxNCk4v5cgTv0EAcGeon7pYMLbX4+pRvn3gsqXu03mIBdY
         lX+9x+yERk5JGjC4FCdZKpM5GiAZth8AiD/BLX5PXl7b6ZntmbL7IlhGMWFEgxIbrFRc
         Eaww==
X-Gm-Message-State: AOJu0YxV7l/Iwh8sjJcpDsDyxbXvdqvDEw+D/FBkpETCNemaYTEIclBF
	yU0NvJuxz6tVnWqGWX8/QCOjRx9ro8w7+v60qokhVwdq4RsPIzQyjz6njWuwoT2yHtao2X60Faw
	4uxsGaW6dnLT3sDXB08lHuCwdJ/tIS+/JXyqHTfcrg/MxkBIKnlJyTZ5wCXAePAheB41KAg==
X-Received: by 2002:a05:6a00:3a14:b0:71e:755c:6dad with SMTP id d2e1a72fcca58-72476b72566mr18389363b3a.5.1731980614727;
        Mon, 18 Nov 2024 17:43:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB2D+yfR6MBm+23YTUFiNYPpAqNdOP2NLTLlm5HIF78V6PyLHBkekM1UG/nqv6sPtr4Mo68Q==
X-Received: by 2002:a05:6a00:3a14:b0:71e:755c:6dad with SMTP id d2e1a72fcca58-72476b72566mr18389346b3a.5.1731980614373;
        Mon, 18 Nov 2024 17:43:34 -0800 (PST)
Received: from localhost (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770fa185sm6951004b3a.15.2024.11.18.17.43.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2024 17:43:33 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH] btrfs-progs: device-utils: include libgen.h for musl
Date: Tue, 19 Nov 2024 10:43:26 +0900
Message-Id: <20241119014326.3639742-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

musl 1.2.5 no longer defines basename in strings.h and requires including
libgen.h as specified by POSIX, and builds now fail with this without it:
common/device-utils.c: In function 'device_get_partition_size_sysfs':
common/device-utils.c:345:16: warning: implicit declaration of function 'basename' [-Wimplicit-function-declaration]
  345 |         name = basename(path);
      |                ^~~~~~~~
common/device-utils.c:345:14: warning: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  345 |         name = basename(path);
      |              ^

Link: https://gitlab.alpinelinux.org/alpine/aports/-/issues/16106
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

This was fixed in alpine for a while but the patch never seems to have
been sent (at least a quick search didn't turn it up)

It doesn't break anything for other libcs so probably harmless as is.

 common/device-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/device-utils.c b/common/device-utils.c
index c39e6d6166ad..56924acd7901 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -22,6 +22,7 @@
 #include <linux/blkzoned.h>
 #endif
 #include <linux/fs.h>
+#include <libgen.h>
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
--
2.39.5



