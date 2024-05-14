Return-Path: <linux-btrfs+bounces-4991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4206F8C5CAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CEF1C218F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A7181BA9;
	Tue, 14 May 2024 21:13:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8841DFD1;
	Tue, 14 May 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721207; cv=none; b=QJhJ2LlyjLng6ef+NhNGz9mI5HNAZ3CB0nrjmrvx5ygzGYuwmfeMJL1UCGh/COn7Pnd4Ej+pxUpVLMmzeXwnoAf+sRGbT4FJGa5p2wA0F/rAH4iyKK4bZGZqk10G2gjeOtVMBIoNa1kklzOiM/BDKZHtxx54VRxrRKEosyvxJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721207; c=relaxed/simple;
	bh=SqyRgN9yJXCB1hPDQDjovWg0409sYWzhdJrmQ7geNGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=erPO1p5/6Hf7+QTRZdx9auVVQRtRmejUSxNb0Ll/OB4PQJnNn3XLYP7FeVytNx40ZKWP+56yS3DcADEjhutQlrjNJpg7cqacNYK9hwD5AhmySKqo8LNc4IBIskJckFcymeIzLsqGZY/0TpM0feOu7Bc/cb5I7rq/PdixqnGgPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so93175466b.1;
        Tue, 14 May 2024 14:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721204; x=1716326004;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOzSOgRlo+lAzBfpBfmoCWLq0QIm4oZxY1op+56rTOY=;
        b=S9vP8tbw763xkCHmSrA34CZbSMf5/DxJa+qJM13iIRZsdA36jRI7w+uF5WKjAIqk3t
         owmqr900t86M7iV4k4MLeN7hqkF+OIabFiBueUQ1GqFdpDAE/pZvNQrfm2naYTv3ClfB
         +Z+s8DEcevJ+w+tUdf50cZeEMEvQbD4tis0gJVEypay2/IC5gy5+V6hOqxVI+CvdKhVq
         ej/F+tj6z4KSgghWaCtVKxX3nu/Nqh5WgVNbG9Typ8ve1tboEiuZmZYKztIXKgzNJ36t
         dvRKVsn6Kc0cdh/zyiwSrQ4sc6c8f4motd7JxAZtZ/ARjA3txfk2ld3P72++SbUzzrvv
         /O4A==
X-Forwarded-Encrypted: i=1; AJvYcCXc3ykT+Hp9Nxz9a5N5cs0slI2PY5UAE7UXtqJ+yAG7qMe/uzXDihiGOF28QsbrE0O4nap0GOKwWmT52o4vzZMuJGxB2wjUOmN1nyAMTf9ZrwFZ2xKOikb4L9+M33QKCjsMMpw4EYz50FY=
X-Gm-Message-State: AOJu0YzD5dBXauA1FamzXrrsv7xCMzrgtA3s7psolWdGtOFoCZIESseH
	7mcgJrxL7lJFI/tUQwOORVksc3CO5V41nUgrWmdXbTWA9mbhBY45
X-Google-Smtp-Source: AGHT+IFXtjqFmKDi/x/JxbAEq/Dk4FVDC4BfQpl1suXQobDUiPFJAyK18Nzl48rdJkWxxoM/xlE7kA==
X-Received: by 2002:a17:906:6b85:b0:a59:c319:f1dc with SMTP id a640c23a62f3a-a5a2d53af75mr925110266b.4.1715721204006;
        Tue, 14 May 2024 14:13:24 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d73sm760229766b.67.2024.05.14.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:13:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/2] btrfs: zoned: always set aside a zone for relocation
Date: Tue, 14 May 2024 23:13:20 +0200
Message-Id: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDTQ2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0MT3ar8vNQU3fRkXaPkVHNLYxNTy9QkcyWg8oKi1LTMCrBR0bG1tQA
 OuPu6WgAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

For zoned filesytsems we heavily rely on relocation for garbage collecting
as we cannot do any in-place updates of disk blocks.

But there can be situations where we're running out of space for doing the
relocation.

To solve this, always have a zone reserved for relocation.

This is a subset of another approach to this problem I've submitted in 
https://lore.kernel.org/r/20240328-hans-v1-0-4cd558959407@kernel.org

---
Johannes Thumshirn (2):
      btrfs: zoned: reserve relocation zone on mount
      btrfs: reserve new relocation zone after successful relocation

 fs/btrfs/disk-io.c    |  2 ++
 fs/btrfs/relocation.c |  4 ++++
 fs/btrfs/zoned.c      | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      |  3 +++
 4 files changed, 69 insertions(+)
---
base-commit: d52875a6df98dc77933853e8427bd77f4598a9a7
change-id: 20240514-zoned-gc-2ce793459eb7

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


