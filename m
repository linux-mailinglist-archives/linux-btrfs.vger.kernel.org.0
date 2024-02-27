Return-Path: <linux-btrfs+bounces-2836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C52869084
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BFD284753
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45613AA4F;
	Tue, 27 Feb 2024 12:25:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25513AA27;
	Tue, 27 Feb 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036734; cv=none; b=CYACRQKLzPri6Zf6lNk6aPqGrj4XjnqruTRpyFfmMZQWweYrl2UK+CO8e//Vz+Np0BjxE/OFbZ0pNFc5sJntD5yAA0dDQS+EF31M/AU3rh+4AQ8H6G7xgAZ4XlOW69GQ3g/+PFul6+NStLQS1dVnnCkaTF9Jvay8pkUAG61BW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036734; c=relaxed/simple;
	bh=pZOadD/KWWg0cHb9AkGGLbQ7I27zKLtUWod91Svvk+8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y66L+6c1fyO47JOcZZK6W5y/hK23F1nXhEXWfSmeuoyF+bXVcScRAJlMyacssGn9tdhPz/jswSyFD8i2oiyxuHOIAWgKGvMy5SYLIwUVvvzU4G9wBdzUiqcTMcom7eQCozKujhHLKfO6WmyNlLgX4j2qhvlBGztOAXdlILqY+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a36126ee41eso505505966b.2;
        Tue, 27 Feb 2024 04:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036731; x=1709641531;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oxlfEl3jnHDk1TGhl+VWFXHptJO2e9pKLBwmkQFg3A=;
        b=mapOn6LsOHjN3net2hD5L2koiWnwlXKyN8BuX08zc1zxxQghfF7+ZcIBU/UO7cG/go
         sLG95aWIy1haRy3uxOqnW7CDPHtofgXH3CQLUP8OclwZmTnWIxRYT2jbgKGiuaMaDahd
         a7S6ECOwAUxYOM430waIB2d/GiVmjJ8akJlC3xCHycjv3jEhjl8q4oy4U4Dj/qK5wIhB
         GkWjqxewzuaXGMoVWHOEYbhomXsMKdj/H87wHKvBRq6bsOMmfLe77sWr/fOSNibUUeuk
         BdSTT3KViO/Vzk+jQeOVYKvohCYVUiNxezZeCD/dX0xAJSGpl/jFwIk35PgRG9/P21zn
         Ievw==
X-Forwarded-Encrypted: i=1; AJvYcCU5+x1xexx4EmS2k28tLSjCmA+b88ZuZVC/Bt+8k/shJ7mQiF4W3kdOXNkUWE8UH8T4gIEI7fsRgLifJoFxisN1U7/z22XosOzcMQ+K7aSnCtw1vmv9ASZtcfzPVDslXxuS+yc7
X-Gm-Message-State: AOJu0YwBARx/lYKTn0n8N55T/OMLT51h/wsLgNCGLLOt+lI+//KUq5m5
	6bmqLG8g+SuQscU6JYXJ4PMLCsqZi9p8PdqQC2RXwHgu/OUhYHvjdsvjErX2u+w=
X-Google-Smtp-Source: AGHT+IHyXJkAaq3bNAzX/sAMnwOn9m9ugHuxfH+UTc3sNkq6goplIbsipry5J411IzpXP9mE4UCWZA==
X-Received: by 2002:a17:906:e257:b0:a41:eba1:d2f7 with SMTP id gq23-20020a170906e25700b00a41eba1d2f7mr6895697ejb.16.1709036731527;
        Tue, 27 Feb 2024 04:25:31 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id vo14-20020a170907a80e00b00a4136d18988sm721938ejc.36.2024.02.27.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:25:31 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v4 0/3] fstests: btrfs: add test for zoned balance profile
 conversion bug
Date: Tue, 27 Feb 2024 13:25:28 +0100
Message-Id: <20240227-balance-fix-v4-0-d22d63972d93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjU3WUC/1XMQQ7CIBCF4as0s3YMpdCKK+9hukAYLIlCA6ZqG
 u4uNm5c/i953wqZkqcMx2aFRIvPPoYaYteAmXS4EnpbGzjjgnE+4EXfdDCEzr/QCtX1dGA9sxr
 qY05U5007j7Unnx8xvTd8ab/rz2nln7N0yHBQ1kkrtRLMnZ7W7E28w1hK+QCFNlu3pAAAAA==
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>
X-Mailer: b4 0.12.4

Recently we had a report, that a zoned filesystem can be converted to a
RAID although the RAID stripe tree feature was not enabled.

Add a regression test for the fix commit.

---
Changes in v4:
- Remove zone reset message in filer
- Update golden output
- Link to v3: https://lore.kernel.org/r/20240215-balance-fix-v3-0-79df5d5a940f@wdc.com

---
Johannes Thumshirn (3):
      filter.brtfs: add filter for conversion
      filter.btrfs: add filter for btrfs device add
      fstests: btrfs: check conversion of zoned fileystems

 common/filter.btrfs | 15 ++++++++++++
 tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out |  9 +++++++
 3 files changed, 91 insertions(+)
---
base-commit: c46ca4d1f6c0c45f9a3ea18bc31ba5ae89e02c70
change-id: 20240227-balance-fix-d4936e8060da

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


