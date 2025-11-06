Return-Path: <linux-btrfs+bounces-18781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F33C3D020
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 19:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70DFE4F88C5
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03A3557F6;
	Thu,  6 Nov 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m++XvFlg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB642354AED
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452084; cv=none; b=EThR1n1QgmPdxFxGSf6JMwPLB0D6RfMYTHQqjqYpn0VKZB2oJb7k2NT22VRNIMK8nkHn+a0WEFXkTSQCszbyJYUc7Rup+S2cUf25uqrchel6w1rfAX8OUnH71qdhyufT+tsOfAWcCkm7vz/BsI4kE0yuP9+TRNTBTOcA+IRrSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452084; c=relaxed/simple;
	bh=ujXfxZ/rw4BEjhU8Wrycg8rg26Ml1Aaup7GlBWzDyZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyDC5cfpvDv+FA5jhSa/Bz98ye9OVLBkcSgumbBdDEm67qoF8whRbOVJ/NX1fc9E5BXMLRQcscOaVloQhkgCuJsfAYD1exJoUiLQA6Ntunkv4MfT9SjqoIsANt6sqvtoOwa9O+VJ6vdOhjd1IY7b2q7H/XVHwYF7EVIZrckLpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m++XvFlg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e9d633b78so215348966b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452080; x=1763056880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=m++XvFlggLYGtWURJpzC7p/1C9rYObR0h2Tyt10Ec5uh4olTmPPwiGdkW7aSmtfKTP
         oPY8EmvSv9mgZsadOVci/gGUfPTND/8BNUtseqRtzFCnH48A5/qigLhDr4UN1Yp44LIW
         Stpto9z0foT6A0HGJ+IJHT9m3ow+9Qy7yNZ/FRrHBjvdw483rCfl5jqAX30+eMfr2yXQ
         vYm7y0Caa7Oescun6lrsyNiTp6LDf/gQfVt9dxsIIh1R3c9ORJXccBgnP4q2hyJeMb2m
         EtN6itT2HacccrUuSD7JohWIyskBJNVZBqFCAh7MWE2YEdn2sS3Z1fVoDlPB+HkHDUVD
         zCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452080; x=1763056880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=KbzO8Dd0sYDotnZN4YMUfdD0Z3mdbZqURbqUmYtavsX8FXxDn+iohxepr9Nf4vM3eV
         kIA6E95UmAzjsO06RGjpl3N9gKJr+n9+o2uTuPiK5BSyPu2jn8ZNG7i9Vrmcnio2+Dm5
         tFrs01s/gdjhJDqx4AZTuuwU+Jf/ipxZImYubgh0xbtonL6TKRivQAu6CITRGf2zIEj1
         ROlp6mxZ/QfBGFU+l6wYsEmjywrvgwbWIjBEu6D3BNkmj3Ukmf6LE5RMWrmOBlazSQps
         xUQlkV/ELBr9NwMRTQ5uzfc95UY5MKK0NPre0VLQ0EddCEoQWJM1B6IuSG0N25FOsc6d
         75pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaCXm3mGKyrjzIdZlg8vuf5GIfyA3XXurlaz55fehUmAoT5aQftKKsSORScGRF6kdnV/o9FRjMmb+yiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OP+F50tSUZa0ktWuWlkcmUsgPCPjuJLiKU1Pqmdt1eCzoRei
	TYz2kZErXTeZu3+Fnxo/HT5uQp0G0I/0h2KH7Edb8KrpJ5Prux8eZEiN
X-Gm-Gg: ASbGnctvOdkZKPJtQPEO8n+FLuTs9+vnh9Sikq70mKht/nT584Qc6WZCvfckx9SEqH5
	uxLiA7+MzdqL4+ZbqbwemTHegpbOKhtKBqbfpFyaQaeibO8oYZoPrbvkcbGcV2M5mBdqsvm+NAZ
	9UHc6UPGoLUKYlz0ot9EbzEWJ56Ig4jGGfJbTzmRbtXi8rnV8XlvSGqXTLBW2C07IygA692i1cE
	8GFjhEiDj54zFT8riicVu7ifpLDd08VnCte/f8X1lGGgwIkovSg+lRNgIuiwFFU40xOnDAl9ii2
	YhLm4ODNTfsqcm91k+kHpLRlj1cFG89Vn1nZE4/zjymHcKLk4PaBslhyBfIFCOV7U75SgIzXtk7
	mY406uStGf1mh4w69TAt0r8qnpIKOVO2J18rXaZwNj8RgJc7GbJ4HcCu3n5thp1+y7T4q3z1PoK
	TjQVB5zu9h1BzCF4ZFRE5JYND2zb2gniIMNTDwxTdIs6KlUc49
X-Google-Smtp-Source: AGHT+IH23Tiy/uzhlQVevCqmAaX2EuxhMCeC/ChKrhzDKky+KjjBLdpLh4g1NTZxdt8W+eURbqVM8g==
X-Received: by 2002:a17:907:86a3:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b72b9550caamr52972866b.7.1762452080227;
        Thu, 06 Nov 2025 10:01:20 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:19 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/4] tmpfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:02 +0100
Message-ID: <20251106180103.923856-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index c819cecf1ed9..265456bc6bf0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3106,6 +3106,15 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	}
 
 	lockdep_annotate_inode_mutex_key(inode);
+
+	if (S_ISDIR(mode)) {
+		WARN_ON_ONCE(inode_state_read_once(inode) & I_NEW);
+		/* satisfy an assert inside */
+		inode_state_set_raw(inode, I_NEW);
+		inode_enable_fast_may_exec(inode);
+		inode_state_clear_raw(inode, I_NEW);
+	}
+
 	return inode;
 }
 
-- 
2.48.1


