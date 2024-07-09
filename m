Return-Path: <linux-btrfs+bounces-6315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B4D92B03D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 08:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354D81C21500
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 06:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE913E032;
	Tue,  9 Jul 2024 06:32:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC813C9A7;
	Tue,  9 Jul 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506742; cv=none; b=ndgLXiGTRrGMhKZA7UAIVVN9gAyMvB7K2h0AzZYdKKIGIRChftGuErhj9RHCoar1dwsSLRbF1Izw3dl/LaF35TiBB5vZreM8gCmXqHTA9CZXIeK0BfRDmikeP+vkEZsqum6CL6X9yKPVQnFgNSuIYNvDdlkLoXEl5NDQv5FAi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506742; c=relaxed/simple;
	bh=xz2KncUko0sCQZI6pAuZ/e5WQnudLxeSS664o5+yCGY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=er631P6/FQCstk3eMZUnV2eYoLzRqVQ/PhkRLC2yAXl7Pk45YR0vjsPNTaZ/Ys1mB5TQc9l4AW/dRfpGWNtqJW9ehxz10HB/u/u4jtjTMsbUYZc5dYy1VDzvOswqxleBnyV9JsqOcfVbAjQDPsWMKDu0A/AOgSe6Z2sIl6MtFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3679f806223so2731985f8f.0;
        Mon, 08 Jul 2024 23:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506739; x=1721111539;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXgKdxLj4SsZmogMZUkG2+3pOaQYb4KGAio883FVDNo=;
        b=np/yzbBvA/Ul859wEA8E8X2mQR602lRheH37TFmYiOEro0lycB4fy76NXocypdWKW6
         SgdmIOJoD7Qvfz8io4/4cibEofr8lVypN23s7ToWh7yhocqh6IBvgwfSTtfxsIOsQIyd
         OV5cQkzydUZ0GhFxxPIH4DcFBfJOZI9SIM2v12YwYY2sYdAAuXxDg/tNvv2+75MCOIQT
         sqTVLQxG5vfAcJDHKmIeP4X1FGIae8sn2V6XW4yB8PFSzcubCPCxdQGIXBwTFXhVSKPA
         AxolVtTtGHOOaXW0f3dnzBFdN5sWfpbAud14dW389m+GB80QXyKT6SafxjheaD0SMNe1
         Xs/w==
X-Forwarded-Encrypted: i=1; AJvYcCUQo09QcLNVf3HmoMpt187g4tDpdJQEeck9afzmwkn1+RZbmWq8Qmd3k5zUNUKPqDbFE6ceVWYV6eD6plOPwE6gt2KEpV8I3NfAVxXj
X-Gm-Message-State: AOJu0Yx7ha3Vq3rrs9UszET+dkRQ++qsFqzXRM+VqiZN0FwE/Rm8+ZnA
	u8m985VWwnZCY3ZHNpEJNHHNgyqI1uHoy4WlpnKE1AZc9TA1r+xl
X-Google-Smtp-Source: AGHT+IFw+JkUwNa88ARsZyZofhStCHB/u/p9XPyORf8ch3XyH5GzfIehtfuTnimUxqSRWDNKq/oBDg==
X-Received: by 2002:adf:fc4b:0:b0:367:3404:1c06 with SMTP id ffacd0b85a97d-367d2b591c4mr842718f8f.20.1720506738916;
        Mon, 08 Jul 2024 23:32:18 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm1569239f8f.63.2024.07.08.23.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:32:18 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/2] btrfs: more RAID stripe tree updates
Date: Tue, 09 Jul 2024 08:32:11 +0200
Message-Id: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvZjGYC/x3MQQqAIBBA0avErBswMcKuEi1Sp5qNiWMRRHdPW
 r7F/w8IZSaBsXkg08XCR6zo2gb8vsSNkEM1aKWNGpRFZzBLwTOFpZCgc9YrMtaH3kGNUqaV738
 4ze/7AWXmFCJgAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=jth@kernel.org;
 h=from:subject:message-id; bh=xz2KncUko0sCQZI6pAuZ/e5WQnudLxeSS664o5+yCGY=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaT13CxkmvxWPFjgEs/DN9KvGjhc9bqC7h9Y3H77eNLsV
 ad6r5RFdpSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBE/GwY/rtvviqjF6YeeS57
 aWJgL4dB073P/8qvCDLHiO7W3fScMYXhn5J/0LwcxpD/vwtDtLffNvy8XH5OkQ9L8kqjK0xHc2w
 28wMA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Two further RST updates targeted for 6.11 (hopefully).

The first one is a reworked version of the scrub vs dev-replace deadlock
fix. It does have reviews from Josef and Qu but I'd love to head Filipe's
take on it.

The second one updates a stripe extent in case a write to a already
present logical address happens.

---
Johannes Thumshirn (2):
      btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
      btrfs: replace stripe extents

 fs/btrfs/raid-stripe-tree.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c          | 28 +++++++++++++++----------
 2 files changed, 68 insertions(+), 11 deletions(-)
---
base-commit: 584df860cac6e35e364ada101ccd13495b954644
change-id: 20240709-b4-rst-updates-bb9c0e49cd5b

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


