Return-Path: <linux-btrfs+bounces-2837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF176869085
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 13:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92FDB29B93
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B91474B2;
	Tue, 27 Feb 2024 12:25:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7013A871;
	Tue, 27 Feb 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036735; cv=none; b=LKReg1w6busV9dJdXUh8ArDj6jqV9f062GFCaPCDXNYzVNjrXDa2gdB4/UYwTGujFIUD3h5KK22s4063vWr0OWgFn0wlFU77k2/9bgq3+fY9+3P0NpyUtT/nEdZlvgsoFrf/2kZ3iDa/rYNbgj7/K2mMBojTZvlVGEMBAaEXAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036735; c=relaxed/simple;
	bh=s6VCn/z0+jYYf8daVbNG+1VTEge0AwHJNJCWm1QMJ7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEsmZAlRe/rL0+qBez35eKUq40NvIA6bHyaHx41LDU2zNW0ImCyKEhPKOXAth0gC6cgUJR3A9/5mToiPDPFTzrQuXtjeN8DZhM3CcZXj4cyq7/po+jAkGvRZlPjbMyGE2KnDmv4b5dtxJidCiid9AZGun8m7eDw4Qe5hUdp061M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f1bf03722so451018866b.1;
        Tue, 27 Feb 2024 04:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036732; x=1709641532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hk160t0hpNdsuUo4r/gUPx/Lha/H4yfcNdpgjzciUTU=;
        b=AWYNxgDg1L1ewNlq6eGdoCcTjLYQkDU6Zx+0/6aeOJzLas78ybyOGZZSLSuJl4F422
         9mlXrb2pmWoAxSNF9iixG2BcldIGEyJ1vnWHIBjbGrDCQ4o73SFZ6a4NowGdtdzexPQX
         jjFjgB4zS/oZhump/Af6vgje+cYTWtmBjfz47iy3ehZ+u4RProza8h81XNPOeMozt6bn
         2M85WHQG0LF5GMS+qDVAFgVabN0M72Q2huvG2MEgrrUKglFJJ93TtGU1lYtDCv6pUTrm
         1QhuJ832P4xHUmZcwDnOiPpCDUFWJ5xkwHsSkJmdqow7BWSAuUiri2PHiQyCZ7hx4E8a
         /p7g==
X-Forwarded-Encrypted: i=1; AJvYcCUQLJYVwItrmDkOetZVxK/W2D4u8/UoC5N1NVQGCamjX9POw+0Wy2gsX5o/JowNweo4az3TafKplIlatTZqTqIfSnDtlFCXZWdFWz4tWt8hpnR19ZUHnVgPO54mZRHicvN7DMNQ
X-Gm-Message-State: AOJu0YyurWT2Rqg4nQu1cspbFVlhvB6ENJxExPHIIQbngQf3p6nPE6fJ
	VfX7I3JKF8UUrexCrI7hOexwQbYv4cLPZt5iHjHfvdLQ5HVFiG+qrHCe+zTG+kE=
X-Google-Smtp-Source: AGHT+IFYt4RBTkaFHyPvbfc6qf4Hwprd9wZlb3If88VgqaixF5r6f8OwR0mfRr6OpANL1zJ7Vdk8XQ==
X-Received: by 2002:a17:906:4f91:b0:a3e:b869:11b3 with SMTP id o17-20020a1709064f9100b00a3eb86911b3mr5952118eju.55.1709036732544;
        Tue, 27 Feb 2024 04:25:32 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id vo14-20020a170907a80e00b00a4136d18988sm721938ejc.36.2024.02.27.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:25:32 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 27 Feb 2024 13:25:29 +0100
Subject: [PATCH v4 1/3] filter.brtfs: add filter for conversion
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-balance-fix-v4-1-d22d63972d93@kernel.org>
References: <20240227-balance-fix-v4-0-d22d63972d93@kernel.org>
In-Reply-To: <20240227-balance-fix-v4-0-d22d63972d93@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a filter for the output of btrfs-balance with a convert argument.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/filter.btrfs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 8ab76fcb..ea76e729 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -141,5 +141,11 @@ _filter_stripe_tree()
 		-e "s/bytes used [0-9]+/bytes used XXXXXX/"
 }
 
+# filter output of "btrfs balance start -[smd] convert
+_filter_balance_convert()
+{
+	_filter_scratch | \
+	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
+}
 # make sure this script returns success
 /bin/true

-- 
2.35.3


