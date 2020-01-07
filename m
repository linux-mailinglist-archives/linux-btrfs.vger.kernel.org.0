Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3C132C4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgAGQz7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:55:59 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:43363 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgAGQz6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 11:55:58 -0500
Received: by mail-qk1-f182.google.com with SMTP id t129so43249733qke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gXoK0j6o5JMcVa6rZu5k16rvrIE/2wM67CpZGa0A70w=;
        b=mh76TA6szGegbJMJftVFs8SSnfbLS+kjaZbQE5vtxITNfg3zcpV+zR2DUunrgcppup
         WH8wGdDjsucews/RpfIy6kUCNsu+v4n70zBRaDetne6uX2telD8VAHpqChr7RmnDDsxw
         nmTV0Af88gkPJLXJsXwsveLh6KWkoGU1dsZs7tqteyCWwAKEQ1T/45N5vX7Cb3wth446
         XgrCX/yYdYDrBuc74C3sjV/ulebSJrBq2Xb9EUCxFeY4tAbwkz/H9XP/lyW3AiC2K4D8
         MWSZCZ0sXKeUNRXLTCd/fd1W1CIeeh2Uaozsz0cLSAwQpdYzINLU3heIB5kto8KbqEEZ
         S9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXoK0j6o5JMcVa6rZu5k16rvrIE/2wM67CpZGa0A70w=;
        b=EtPUdJ3oFpH72kkb9T/Vbb5c3NptpfP/VGxOin3k8Mc8ZYa3EUyaGEz1Nt8IZkaxWy
         AlnCzoILM435DFTHIPK3Ta2Qe4iJHMX+IigJhdlCqhSjcR5h578pvzQRSWVACr+Q7Qak
         HNxt4qd1CxA714m8nHr6+2fiz+0ta6hEeqCLwoA+lwXV9ksAWpmVdFirWpPNRa+AvfJ9
         mX2po5BigFBD2A5qd21jzDvOngGYJ3j4ykqwk3BBC/9uXr7rfVhuFZhsuYFJmYfTet+s
         d+sjNlW01w2PL044gewho0lLv3QQOiL5vuocf/h4jmXFusYbDnS6qEA3Ed8OCxUSR6L0
         J/4Q==
X-Gm-Message-State: APjAAAUh4QJfEM9BMazr2Qat+oZ1Pr5Hiyw/p6G7jfZOdd2PXtd+KWM+
        eGmXPL6FOeehIZsOy9DodWbhfA==
X-Google-Smtp-Source: APXvYqx76gODgKza9G1xWw0hxZZoueyXVB3me0nCe36i347x1O3tYBfNZRA0coNc4HWkn8ugPkl4wA==
X-Received: by 2002:a37:4792:: with SMTP id u140mr286706qka.100.1578416157490;
        Tue, 07 Jan 2020 08:55:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r80sm49391qke.134.2020.01.07.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:55:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] generic/521: add close+open operations to the fsx run
Date:   Tue,  7 Jan 2020 11:55:42 -0500
Message-Id: <20200107165542.70108-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107165542.70108-1-josef@toxicpanda.com>
References: <20200107165542.70108-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was fixing a issue with i_size setting in btrfs and generic/521 was
what I used to reproduce the problem.  However I needed the close+open
operation to trigger the issue.  This is a soak test, so add this
option to increase the coverage of this test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/521 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/521 b/tests/generic/521
index e8bc36e4..f0fc575e 100755
--- a/tests/generic/521
+++ b/tests/generic/521
@@ -52,6 +52,7 @@ fsx_args+=(-r $min_dio_sz)
 fsx_args+=(-t $min_dio_sz)
 fsx_args+=(-w $min_dio_sz)
 fsx_args+=(-Z)
+fsx_args+=(-c 10)
 
 run_fsx "${fsx_args[@]}" | sed -e '/^fsx.*/d'
 
-- 
2.23.0

