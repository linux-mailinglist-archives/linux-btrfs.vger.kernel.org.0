Return-Path: <linux-btrfs+bounces-16908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D765B82612
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 02:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2894A4E17
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A901A83F8;
	Thu, 18 Sep 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET0m3/pq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90B18DB26
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155597; cv=none; b=UTxRulKbGjqY8ZtFqFvlFHOypAEYYHwzTp432uyhvQ5MYJKwy2wJ7Y4U53RPtvsIpbUbR5GYKqGo6P0YvJIXJrODcgDt50kyJwKWucpnV9K2Oi8hSaS9vID7Ly6z5CgAytQNEKxm350UiletzJB/c1U4x3u9G6dkt5ABAB4rPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155597; c=relaxed/simple;
	bh=S56k4VPaH+gYIeZLtS2pAw9+CBYHbkyGAJiAFP0N1nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeMl0e+8zsID+Z16joFQF2wzpsJ2v2LBFZzwLayVncIPzaiZ2pnTvWMzN3z1XC79Xr/U7Tej9VmaElidNwTxKZdWIbSCyn9/Q2yDMomjOkzd/C07GwlVQAZ90voCIZv6gB0xYNrAJeWBzmxoUmDpeJYtlR7UzeqQEspJ9KAjdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET0m3/pq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77459bc5d18so347795b3a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758155594; x=1758760394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKAzJ4zzOm4qzuhrKmfm70Ds2VFgXDcQpUBdAlsdf1c=;
        b=ET0m3/pq5hwIgHFS8h53zw6cFQf91ry5C3lPId7n+BHeSSyWOWHYsaYHdySgkKuA69
         cTjsztQTYvsUPsyIrjKUiTM0ugB+f9B5wJCF9FDe91qqrT8cffIUm8j9KYpqv1bSB1Nc
         suWWoH/5YJglRYlh/ft4nte7gsj7ubfZjGm5N1cY3OdXHh3DL+KluFVIi6DMwGic7cJk
         64ed0DeVr7UUGjVrJkBWu3PDYC5oDNT0eY8eiAY075E2IuW3UCJI9rxUnAVT/pnYAtGf
         N9ZHWUpIspKa846lnTzVdtDHS2TT1IpsNo1LnKIomZHCzrTLQvF52g/vgrZjxTzG/NAG
         O7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155594; x=1758760394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKAzJ4zzOm4qzuhrKmfm70Ds2VFgXDcQpUBdAlsdf1c=;
        b=apXNciUKzCJDVCB15BbY830x6XscyKwv9wLxu8CtKJoOjT9JVAG8GwlyKgdPLNjFGq
         aFjx1p8FuX+qhwrBA721fp3yUqIrSQx8IsE/VPoWsTJNqk2bysKY0rutjJ365pJbBYKv
         9P/t2k839rCriyjYSNST8r40lXFBAhAubObPM+TZo/AeMoOqTjVpv+OCYUfoI5GZwRab
         DdRAQUoQu1/pQ6Qn6EnUK+Ubj8bCWPc4sWypZ9Mz9LydDPSIA84fzXfk3A95rpgxi6mW
         /V1XOYLefyMVrV+2247WhHxlghlqyAiwhM2P5KgSyZptxNAq224Zm0/PXhgNjEbBSPY+
         kOBw==
X-Gm-Message-State: AOJu0Yyc2TrqfOWkEjq/57fw2VgXiWtlEiyVN1DUJIq/sGLeji2NEnM4
	q2Bn+/98Gk2i6cWcinxyTRsdItg+MGUFandaY8L/gfnaDrGM6GvNDx7J
X-Gm-Gg: ASbGncs+m7y/e2Nz1XQaIP/0y7x/XEURFZsQcEARnumc8hYnDgNCmI4DQXYbujqAfmZ
	4BjP3KvX2la7tx6ITiDMwAbwjh3rrEtyTHRTPe3luEeF8fb2ByGkwhgEW6nrNJvYrZgPF3h4Ib+
	CDYA0BCsjD2Tt2R+FeLLzuhlsbJYKebGR4RNl0t/dhJJ+Bpf52y1nUs7G6Sn4o45VN9Ucdw+RHP
	O1O/bXRQ9o3WWKijqfUIBFirfnVAL5V5MxYiibyF8KwNV945iL/72wmax0fOmjlgquA08IZaNsg
	XmvTqg8V2Xks1hFzLKJt4cTZZIE3iL6flDvhl4DoGanU0BOWDkn2VMyLqk1Vi6iBV8y6gEsDrlA
	gqydbezlQQ2fNSzQA6NYCty1heDd9l6Vch7czMLz/FgjXsHsgGzK/j1MLQMt1QvAv2gNU/3exDQ
	==
X-Google-Smtp-Source: AGHT+IHrzPJcPNRh+MNIK4sYw3dxRvqkB6woJg3g1U99hYZc4dT1z27QYTALn1wgRQWcRAa97tE5Jg==
X-Received: by 2002:a05:6a21:99a0:b0:24c:c33e:8de5 with SMTP id adf61e73a8af0-27aa1f570a9mr5816411637.35.1758155593487;
        Wed, 17 Sep 2025 17:33:13 -0700 (PDT)
Received: from feddev.blackrouter ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607b1f5esm644428a91.17.2025.09.17.17.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 17:33:13 -0700 (PDT)
From: Anand Jain <anajain.sg@gmail.com>
X-Google-Original-From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] common/rc: helper functions to handle block devices via sysfs
Date: Thu, 18 Sep 2025 08:32:46 +0800
Message-ID: <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758148804.git.anand.jain@oracle.com>
References: <cover.1758148804.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

_bdev_handle(dev)
	get sysfs handle for a given block device.

_has_bdev_sysfs_delete(dev_path)
	Checks if the block device supports sysfs-based delete.

_require_scratch_bdev_delete()
	Test if the scratch device does not support sysfs delete.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/common/rc b/common/rc
index 81587dad500c..627ddcc02fb8 100644
--- a/common/rc
+++ b/common/rc
@@ -4388,6 +4388,32 @@ _get_file_extent_sector()
 	echo "$result"
 }
 
+_bdev_handle()
+{
+	local device=$(echo $1 | rev | cut -d"/" -f1 | rev)
+
+	test -e /sys/class/block/${device}/device/scsi_disk/ || \
+			_notrun "Failed to obtain sys block handle"
+
+	ls /sys/class/block/${device}/device/scsi_disk/
+}
+
+_has_bdev_sysfs_delete()
+{
+	local dev_path=$1
+	local device=$(echo $dev_path | rev | cut -d"/" -f1 | rev)
+	local delete_path=/sys/class/block/${device}/device/delete
+
+	test -e $delete_path
+}
+
+_require_scratch_bdev_delete()
+{
+	if ! _has_bdev_sysfs_delete $SCRATCH_DEV; then
+		_notrun "require scratch device sys delete support"
+	fi
+}
+
 # arg 1 is dev to remove and is output of the below eg.
 # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
 _devmgt_remove()
-- 
2.51.0


