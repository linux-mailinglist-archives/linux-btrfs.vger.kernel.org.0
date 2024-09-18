Return-Path: <linux-btrfs+bounces-8109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783D97BDB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 16:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461E91F2259A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490218B47C;
	Wed, 18 Sep 2024 14:09:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1EF9CB
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668545; cv=none; b=EucCEBD+8wYQibkOIlJHkgkuLv/zu6d3t3YPs98V+tPXmi2RU2YT8EPXw/HqBz+4dV8Y1ffJfamCILJiSpHujvuyrnw8F/KUDMNvWvVNDNybvT4tINla1sm1PjuzJ+dZjQuupziFH4We2YOEAy9Cd64aCONf3amaI4SZ+JD9Ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668545; c=relaxed/simple;
	bh=UH3Plo0Lbe1rDBwhLEf072MeKosG0UTJQVxIz0zwdlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKwgKhWKw0n+rL18qlkl4NJV4FgYYWECLC94MfaWbLOSsF3FXHGbxHxOuSIl+o1roDJGLBhGOoh1WOcayVHY/x8ZlYSkeRMbd6mnhAOFNkt0sQI/mdVq3a+Cm28j9RfnfPbyIYekbBXL6JtNz1WuIJSZ10oodIxijBsilLFX0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f759688444so59425441fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 07:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726668542; x=1727273342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0WcTVdREFx6HUlDdvgLo4JkLKWjf82BVhoO5gJL/ik=;
        b=J/sx71FCLu9MROP2qLlIIh9hMlGMeMRCcGXpcaeu1x2UP5eRyxC/tvCIywF61YdAmQ
         sZ0qJqYi5QR3osoYAfIWHpzEJos0WuuyqCllvlwbyKlLuO6DWHk6WLiE+7qA6vnNGkQH
         c5nXOX8TgNXTFm2ZKXBWHLuy13amhTOg5JpSVIOZ56y2EBMgK34DHSi1pSJkb4v55bAj
         rimzqbWVmn08VO8lE5PMdar1DTaIRH8NmUgRgoXrOStbs1TXhrZYuNaJe/pqhpgdL+1L
         wJ01sIxxJl8WMqRRR15PTlwZE+qBylePSybQadP+quEo8GwYwB5EawsbZZyXruOzEpkR
         +zPQ==
X-Gm-Message-State: AOJu0YySVtmhpd2YkgupMOTv18Rdkr4MyjkYWee0grY86cRdgarDi0FB
	t7h5OGvYwEZBQOy1xyQ+Pj1I3mvArFXfDdiALN7YI9w8A6+Drutm
X-Google-Smtp-Source: AGHT+IEFaTDJAuBbH5W1qASs/ACcoSXea9HTWMfwakZyVs2Ui2+03rf2hW25WTGOj+ivHxgqRjh64w==
X-Received: by 2002:a2e:d01:0:b0:2f7:7f76:994b with SMTP id 38308e7fff4ca-2f78e18c56fmr91961911fa.24.1726668541486;
        Wed, 18 Sep 2024 07:09:01 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f72a2100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72a:2100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704f2698sm18282125e9.24.2024.09.18.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:09:00 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
Date: Wed, 18 Sep 2024 16:08:48 +0200
Message-ID: <20240918140850.27261-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC implementation of Qu's request to be able to
distinguish preallocated extents in the stripe tree for scrub.

It's not 100% working yet but only showing the basic "how it's going to
look like".

I'm not really sure this is a better solution than returning ENOENT
and ignoring it in scrub.

A third possibility would be to do a full backref walk on
btrfs_map_block() error and then check if it's a preallocated extent.

Johannes Thumshirn (2):
  btrfs: introduce dummy RAID stripes for preallocated data
  btrfs: insert dummy RAID stripe extents for preallocated data

 fs/btrfs/inode.c                | 47 +++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.c     | 47 +++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  2 ++
 include/uapi/linux/btrfs_tree.h |  1 +
 4 files changed, 97 insertions(+)

-- 
2.43.0


