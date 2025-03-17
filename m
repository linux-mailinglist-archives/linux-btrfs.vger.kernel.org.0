Return-Path: <linux-btrfs+bounces-12324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E78A64C6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BECA1684D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6F236A72;
	Mon, 17 Mar 2025 11:25:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4021A436
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210713; cv=none; b=Rppd0IaXFx3kvhXzdNaJDhQKtB5A1I1Yb6glZY1LglOR9eumvKovGdTpkS+6vvtS7ruTCe9IJK5MdlEbfIbTmGmZXwroweLh+01LBmeNfXbe+RWBHVFP58X/M3CRJzUsNdYHy/AuQaf+TEPtDptxtZrpVcTVoMuftuaUO0IVONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210713; c=relaxed/simple;
	bh=fF6JGNjxMkaadROCzSwC6WbM/fCiRwmpGWNQvbXjheY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NC3CxqAmdEeWMmB1/CpzDxwRLy2xOcTTN62fhAQZ8rG0NuKJb+k008L7CwQRq0sn7M9TtkfHW9cEItuLmyUwkOo/WpVtIsoiDhqRS4B/4f1UM+Y26PefHwNhPAr9y8qQsvp1xVFS9SlxTalcIRGpTcowI6046cwEmbrGce81UX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso12350235e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 04:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210710; x=1742815510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BN/CSka46/sfOGMe7LmICT0w0VyoUG7dp+OHjX4j3xc=;
        b=ZtTH2eX7S7ZFloR8MhQnJuO7HK3GZFFIe2Yf+1WpNqqQdZKuxiAUt3Y5qB+3DYyJJz
         WxMz/CKX/V0NmQI4ibZSOTJnS6wtWcqmThM8AiJ12c9jvMeVoC1bYEhaya9iCktdrtVI
         24ZTjCof3pLH5BWqV6YLM2CxwIG9cSKawrZ9Gy7M8NnZZNoao87k++CHeOyn1eTvWsoW
         RADiboDKDGNElYdK1dS7/RCeACc78yRNUXT1iMt5VqyrAVU96T2R4fvOYr+LUU/Y58Y8
         jBQT78GnolqYenZRbTHPUEgMwHD1ETW/dBnRIk1FQw2pV8MEoCb5tu2LJ2SNYwoHELnj
         QCmg==
X-Gm-Message-State: AOJu0YyzlU1zN118Ho5BACte60nPXWbrrg3Scrtpb9o1NTj6YpujBVNo
	a2eSjKT7z1/cXcDb2xuggCzQDk9GPm7zO0YxV90n89lhFoQsIO0kHZBXDA==
X-Gm-Gg: ASbGncsUv3Pv+YfOj/KvWjwqqA+kNmEQwLLbl9G9QxBSWe24EV8gsqW8USGyCEHJrFz
	4M8elMfoH6aRnayS1JmNuRhX23Mq5a8c3UeVPACejIyefvDUT2vj8V+455qFbxRjxBZZzQZMEKY
	UTGa3H53aqeVl4cLh680skZpsgZRKYJu3O5Bd79FMMow/pI65XVX090OQKPB1RWLAw/vdM1lmFG
	WP6icqVwOivqUhv0SRdIYiiaMddmcmh9Ly1iynAA6ZD3QQiecDtt8HiXvLVrlFPOnf6UCulfIBe
	TqeUNKZo8Wn1TCug+j018ZpEzNiZc5lnMRVKaK4sze+Hcjq9pcX8r/KaI+j/lsZq3Hub9JsIsCy
	a7RNg6AsY/qANfR/PI4MLcxtoMbI=
X-Google-Smtp-Source: AGHT+IF57EI2N+cv1ZMUjiGcieuidVufkwYfA/UBKqWbGDfzzfOxG9VhlwZLyxhTGbFLyeOm3GuYXQ==
X-Received: by 2002:a05:600c:2191:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-43d1805a5b1mr158361355e9.2.1742210709633;
        Mon, 17 Mar 2025 04:25:09 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71d1000fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71d:1000:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad59sm103188675e9.26.2025.03.17.04.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:25:09 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/2] btrfs: zoned: fix zone management on degraded filesystems
Date: Mon, 17 Mar 2025 12:24:57 +0100
Message-ID: <cover.1742210138.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes around ZONE FINISH and ZONE ACTIVATE for multi device filesystems in
degraded mode.

Both times we're dereferencing the btrfs_device::zone_info pointer without
prior checking if the device is present.

Johannes Thumshirn (2):
  btrfs: zoned: fix zone activation with missing devices
  btrfs: zoned: fix zone finishing with missing devices

 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0


