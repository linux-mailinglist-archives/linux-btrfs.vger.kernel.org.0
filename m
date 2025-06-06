Return-Path: <linux-btrfs+bounces-14531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E70BAD04EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619CD7ABA66
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD64289358;
	Fri,  6 Jun 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ILBlLr5p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554413EFF3
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222526; cv=none; b=UwlhVAY/vrepFX/zmju/tDFOiYL3KB0r5RU8fyZXdwChZ8wXVh9dGKgcklCfRmdEvmiSK/N+/0ZorqKZCIGho+FLaK/duo0C0mZX5TAm3lahht3SUSQcXX3IWmjQrRBNjGVqZkKekMQW+G8g5M6zx+PN48UsrWjvgcUly9Mqs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222526; c=relaxed/simple;
	bh=pepjY5xKZ4fEv2+SN5UsSQWNrv5UM4mrl1RpgeXSbOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mx3fnB7+pF89tYb/5VHtRtX9ZYOULE2NrwnMw9eTQXi7G/tjNM8w+qSV0ZssmKioIDzY5D8ZS+0joYXx9i1ltkxr8XMjFflQ8Mos3BjEEySDH0mcr3BiWhLvRH5u45qYllqTOKoE4u09GYrwaiYrxMEsHq1ttXgEvYVhLMZ2Hok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ILBlLr5p; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-450ce671a08so14280015e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Jun 2025 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749222521; x=1749827321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rB0ICY/LvIpbLKgQXqwr6YVTHGk6wZMao/twt+FPWBg=;
        b=ILBlLr5pnGyOrScy1qOvyNDqfeA4/rmaDYg1R805VxF33imwTwg43opI/XgEN6yC4+
         1L7hOtEGydvjn7FaZ0J70IWqn3s2EEuFRmkNIN7MPB/naDa816lor+Jpfqoz7yrEL4T6
         B5qDcfugNf0q1NUapjw6nMTu2OGTJIglAGgm7EkfNJ6A5zMRJAtLOC7Y7c077AN1Gg1C
         yC85CKmm4OmDPjttCwPOKITR8q+xY6mCcwOhOmwkCUzHWRbSQNHWYv9xTnpodX+JTqHA
         MbskafkgyIO2Ekzqn/bAK8xx+SYgjhTbQuir1gryjP/VjM1LQmsZSLDvDkWE+oabvdxh
         Q6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222521; x=1749827321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB0ICY/LvIpbLKgQXqwr6YVTHGk6wZMao/twt+FPWBg=;
        b=aPHEIdgCViFn/U7WseNkwp11HdRETcnNELmb5qd9e23VB20oLEAGaZpohd0esr83lK
         fR87SjAHVkXpwfwshhrGoN4fiNuBXEF/GPKnZTOnyTPtYONsHGs1C/pJkc68or9os9n7
         l1buOugWXMvfrd1eghtNWvz7/ROdD3IAUNnrDb87mhPl8d4kv6JSIOr2GGgFlzEcaOoY
         gq1zoSZ1BHQQmPbZSY29Uaw6eNN4XhumLnIG8RmU8oAezPeynWMGRGtsCS2SkIwLg6Mf
         uPQMDt8H4raoRP6ILErD1Ni1iD+orhgY0jmdszF320Uh+pqfwGY7IbVi+3odMsrS+a3u
         sKwQ==
X-Gm-Message-State: AOJu0YwsL9BajvfPrz7Aejh4W789Lw5FlXPIpqBRwN7DoOC9IuV88UzI
	wpUEPj7JEc5DpqGLMlbsy/smJdLEqLmHU65JBz73KgQzVN+IQJt2QS0BuK3oWRGxq6DqE4+W/El
	9Dr6AiI3bgg==
X-Gm-Gg: ASbGncuzUufCrQLYt99rtC3Z/4zPDN0k9v6sHWJlSolhGUkNs/1ypKj5YdRaEqxoHjq
	maoVASjS7fwuHI+DEWe/GNyuRuyQahxQQ1Dl4+McJDI4SqR2zjyDNcgt75d+cr2BEaCamPE88gh
	LCN6acRs8NvfsDgR69vOX8L3JvQrCli8pmV0eFwrA/SzGbQb+pfYqSJ2jmjWWR8bHU6WqUd7RKN
	qLnAJtzKm1TZyg50LRwQlWwDafEtEFnOA3Tr9Ig7+uMzefxjfchAD5+sl7SG6SdhDpn7TRA7E9I
	RJdpZjDIoB/ilvfOz4mmGxejQPsC4iBS8DE6y/mDyjvjWZJ1msStAHVze5iz025ZWx4sFHkiRMK
	EytXs7oAuihGZfXE=
X-Google-Smtp-Source: AGHT+IFJ6EY0d+ZRObGIsrZZMb+VHocfjZNIlGmsBIkWsN+F8sVn86mE56yeWtWeouHYuiMRif1vbA==
X-Received: by 2002:a05:600c:a08d:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45201373d52mr37366655e9.6.1749222520748;
        Fri, 06 Jun 2025 08:08:40 -0700 (PDT)
Received: from daedalus.nue.suse.com (115.39.160.45.gramnet.com.br. [45.160.39.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5322aa3c0sm2129036f8f.22.2025.06.06.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 08:08:40 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: mpdesouza@suse.com,
	wqu@suse.com,
	dsterba@suse.com
Subject: [PATCH] btrfs-progs: filesystems: Check DATA profile before creating swapfile
Date: Fri,  6 Jun 2025 12:08:26 -0300
Message-ID: <20250606150826.119456-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://github.com/kdave/btrfs-progs/issues/840
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

I'm not sure if it would be better to just add a new helper method to check
for profiles, please let me know if you would like to have a helper instead.

 cmds/filesystem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 64373532..21ff4d7a 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1718,12 +1718,21 @@ static int cmd_filesystem_mkswapfile(const struct cmd_struct *cmd, int argc, cha
 		return 1;
 
 	fname = argv[optind];
-	pr_verbose(LOG_INFO, "create file %s with mode 0600\n", fname);
 	fd = open(fname, O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (fd < 0) {
 		error("cannot create new swapfile: %m");
 		return 1;
 	}
+
+	ret = sysfs_open_fsid_file(fd, "allocation/data/single/total_bytes");
+	if (ret < 0) {
+		error("swapfile isn't supported on a filesystem with DATA profile different from single");
+		ret = 1;
+		goto out;
+	}
+
+	pr_verbose(LOG_INFO, "create file %s with mode 0600\n", fname);
+
 	ret = ftruncate(fd, 0);
 	if (ret < 0) {
 		error("cannot truncate file: %m");
-- 
2.49.0


