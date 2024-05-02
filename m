Return-Path: <linux-btrfs+bounces-4684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A98BA253
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0771F248D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB371C8FA6;
	Thu,  2 May 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CTrUTW2/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423571C6896
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685226; cv=none; b=CYo7gqNQOH9zSN6JGXo5z51kNLS+EKezBMj8CQYuqnkvHqyhPv8/BfazdmIjNi1//d/yuAO6MDDU8hzLdPx+nMH7tSWr+rPy6oh4zbGrCd8Siz49UN2jPwHZsa9KGrdf8YG9dztyEPakP4yQO2Sdq9dAM8J1vSK1qClIFOtkQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685226; c=relaxed/simple;
	bh=hLVGXgVE5ObK0tQ9rz0YC8wUaiOnh/HqizcBkXbeCvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+286nshPYO4ayC1tkgVZqPQXf7nLZ2rsoUXQVj676ZVRaQtKMLX8YhGtA09NLxliqOmHlyQ5spt4Ha5+0CItcUOYeRXPJoHrgcLsg9EC3YrPtN5ap3l+07b5BdCuZClu1IZGMP4Fa1rVzXWThda9c2ZuazFqbA8FR/jj3t75Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CTrUTW2/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so852534766b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685223; x=1715290023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK+Nr9GDbKVe99LdxHOspcXdSuPveINKp7xXqjsO2YU=;
        b=CTrUTW2/xa299XJj10sjztZN/ygJTDXG0PHhlXkE0uRgduonjhT1GBEtYfqEskFY8D
         GgUfMdP2vtZxhLR8yy2tZwWRBbF8a2NWghhUmaiXAZJGNawul429RmQ1yZ7Y8wJTqDXb
         sWbZLK1SWumMA2jLAei3VWG2Zxef0S9goDwKXMht1vpMjo5eOeLpn0+OS146SejX8H8I
         JhGaQdcUrS6eFCn5zVFsH6fEhIO4DLax855xRR74WzQPDmTVnh85QlmJtIgUT29QEmmv
         CCLoTqdSAa/8II1GHEG2vDqtSZwCo22v66gHezNybnT2GywolAvxfTkS5TuGuOiQK+5S
         vPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685223; x=1715290023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK+Nr9GDbKVe99LdxHOspcXdSuPveINKp7xXqjsO2YU=;
        b=kBOeXGluSshkQYID8ejWZXBgML5Uxmmmkf9zYk7BbDNPiSk4DmFTB0yrNVyDJowpPX
         QRUZP2VXelqgkr11ldC6c+AMcvQcW3wvzsHKNtL2Fl8YMlb9Q44LNmoPfsuol8altAXG
         dpF2qZfgMEROUQ90Pa1lXjbKgSFIMs5SDIBK+K9fETce83Rx2SQVKyHwQzGyYRuGGjWp
         SuXVDKLrpCwkdxnZug7/XVyiJj4piInPmIBlkmf3y12sJbV2x/EUiDs9Cbcu40S5tZUv
         Ya77eUTt4HeQ3hnyU1b/vaajA5HjMzlzFUBYK48Pcv+LENATUekccUGebSpMVIQORrcR
         Lv9w==
X-Gm-Message-State: AOJu0Yzv593Lu+8vWyR/1ggN8jvGO01PqlspX+CIuFAeJDxiNynXuS34
	MXs5KKh3v8F6E6BbufO3uVfC89mdXvaDB9tJhV5fabqR6BlG9LHkI+/JiTWDQFs=
X-Google-Smtp-Source: AGHT+IHBzotw8Ke7fIjVdKa5ibyRzh+WvB5Y+2scCGw1BD2igSpBC2Pxgr1SRQKeUwy8LwjKiKAuPw==
X-Received: by 2002:a17:906:c083:b0:a55:b99d:74a7 with SMTP id f3-20020a170906c08300b00a55b99d74a7mr364245ejz.11.1714685223722;
        Thu, 02 May 2024 14:27:03 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:27:03 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 4/4] crash: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:31 +0200
Message-ID: <20240502212631.110175-4-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/kexec.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 066668799f75..c460e687edd6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.44.0


