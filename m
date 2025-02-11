Return-Path: <linux-btrfs+bounces-11382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E9A3198C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 00:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD7018886B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE9268FE6;
	Tue, 11 Feb 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoPDMAom"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E9267737
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316583; cv=none; b=mjOWaOtmyz4BppOLeUSpzgDlafcsEaaadxVYQsLZPRXAOxw+6pZJvyEDtgRPzPNocPuXDUTDrINc0OoTS4VVsoBxc5uxo/+8Vq1w2YZhjBSTGjpc8D+i4FLbE4VqVhuoTO/1w8xbjQNGELVSgETLwLhh1Yi5c8SvxeoXwXDGAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316583; c=relaxed/simple;
	bh=45UlS66vDmUJhImpZsqIrh57LrPZz607hRkpJ2swtjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmLjIs2IakUFnCqrFkCuPlYXd9igkSIvhNmdJTFgIdCaFNONy+54tDXgmmNFA1BAlXEgSOAbZYQiRGf21+zsXi+seX7QzowlFNKRyK3w+/Yvy9hDyDDGF3Esb3Xu6uHsBda9Lt37fTzyIeUTBlqcvx8POQMAimp9acNUjt6U/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoPDMAom; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso191469666b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739316579; x=1739921379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrCmgRFA7rBq4eEmhuNox1nzS27sbqFrwlhoSwUkCdU=;
        b=ZoPDMAomsvYmLjLOwhlb5Fbrop/l0UzNl4gtNPC9gStBZKDXawqbxLmEiK9SX4o6W2
         BMDa8vdbtopUQbanm9Q88rZLCh+NKAmWam2dNbloIYHUxLWnC9IuAqbFkQZVoiJWrIxG
         E8I3BomnuriAhk363nfeQf6ncbnuCYonlf1NtDDsH4ygRmUq1I17hT7oq/7fhS+TRGeF
         lQPWtAc5+xDgHEvvq7fzi1ffqcBjCcYll2V7LzY9aITTJNyupYaFekNdmvfUhoyAymhr
         BYbLSpyftSLrUIKDz2P0RcgK7ZLGJAxsUrqtEcqTSGsZhAv5tTa/xsUoqqaWuaxyHghs
         x2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739316579; x=1739921379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrCmgRFA7rBq4eEmhuNox1nzS27sbqFrwlhoSwUkCdU=;
        b=XnaG+sF44sURyogjCl8fXzJ50s3V7Ve4ELRV1Swnk6uV4XkKbWXd1InwS8EbtzTjPW
         Li4FKWPJW+BdMi/fn9aEcJDMzIFFbT3ZhSVZb9QNvqpfyfMry0WzG2/XcLV8Bmr20WMe
         NMPt42+CUmg0cOi6e2HnQPGg07NTBoQQDo0NqgRGLECVqMbu21I/1Fa5ASGAcrxAuE6g
         o9ZjnS/Qpv41MPNJph5Mgs8VsekbLyLcvWXVbjzigNYV/00cfL8LFRbJ5HCnyM4Pettb
         T+8KkhkvtwzVr4jlYdrb6jtRBCqs9eYFCEDaAnwPuygMBhs+wUrl+DynSLn9TAJciLbF
         qpZw==
X-Gm-Message-State: AOJu0YzpDxP+hIFbnsk46G4YsfFDAMNvjjCLiOnhtUXC2DSV4XEM2t69
	Gw3w3bfz85jfsvqifU/a1N2m5btkP8sadqm61fIgHhs7B8NJANzNdGdv/A==
X-Gm-Gg: ASbGnctsEBJNSDTrS+qU8os53ArirZvbE+AWWCnbPY0KTG1oK52cCx3fuolE+AKSoIb
	2ESwO16HPaUAfEJ38HXXwY5V0yTVMb6p9mFFdBy8+txFx0xGzTfi/Fpwbb4jaYL3DTF4THzzdHz
	diDYCjMdDcfiqNMF/qEruOGNKaU9/IGtrBzJwXNPLkmLKSpZjbFX/tL9jRazYbDvH/MCr0m/yRW
	iF2U8DvzMB5l0fZ5/aXKIG0RxwhHfGa64zjK2O1TcGPArZiHTtTmSHgqiitELIdSOofd6wYX1Zo
	wJ0RYt0iz6is
X-Google-Smtp-Source: AGHT+IFi9CQTdNJbDO46ezi3GzVNkrdlqHiFez1NSFUAE6edQTe4RPHo7HvrAZfQbyXkXIf+NfDTlg==
X-Received: by 2002:a17:907:3da9:b0:aae:8841:2bba with SMTP id a640c23a62f3a-ab7f339d095mr51566766b.22.1739316578398;
        Tue, 11 Feb 2025 15:29:38 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78a9360a3sm1014252166b.63.2025.02.11.15.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:29:37 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH] btrfs-progs: add duration format to fmt_print
Date: Wed, 12 Feb 2025 01:29:18 +0200
Message-ID: <20250211232918.153958-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added "duration" format in seconds to fmt_print which will convert the
input to one of the following strings:

1. if number of seconds represents more than one day, the output will be 
for example: "1 days, 01:30:00" (left the plural so parsing back the
string is easier)
2. if less then a day: "23:30:10"

---
 common/format-output.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/format-output.c b/common/format-output.c
index 3b333ed5..146f23a3 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -380,6 +380,19 @@ void fmt_print(struct format_ctx *fctx, const char* key, ...)
 		} else {
 			putchar('-');
 		}
+	} else if (strcmp(row->fmt, "duration") == 0) {
+		const u64 seconds = va_arg(args, u64);
+
+		unsigned int days = seconds / 86400;
+		unsigned int hours = (seconds % 86400) / 3600;
+		unsigned int minutes = (seconds % 3600) / 60;
+		unsigned int sec = seconds % 60;
+
+		if (days > 0) 
+			printf("%u days, %02u:%02u:%02u", days, hours, minutes, sec);
+		else 
+			printf("%02u:%02u:%02u", hours, minutes, sec);
+		
 	} else if (strcmp(row->fmt, "list") == 0) {
 	} else if (strcmp(row->fmt, "map") == 0) {
 	} else if (strcmp(row->fmt, "qgroupid") == 0) {
-- 
2.48.1


