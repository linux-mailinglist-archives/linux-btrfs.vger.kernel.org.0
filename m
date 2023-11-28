Return-Path: <linux-btrfs+bounces-408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75097FBA0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 13:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B23282B94
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8D54F81;
	Tue, 28 Nov 2023 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWcy7SBo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9BD63
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 04:26:03 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-464434e7804so6049137.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 04:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701174362; x=1701779162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zWjEZ/SUQrSUmyqfWuq2eTx6HkHasTKwK0H9S4JJ4Io=;
        b=lWcy7SBow1DtRWWJqH1Kfbp66ON0TDBk0q1ARXZMBJrFRp4KuD566mXnp/mq7+CtQA
         kHR68ejp8ulUGkpOIoKtQuZLH2gyf58AIfGFxDuc3DSyaAs0sEy1AdpUGX0NKvipbe4w
         lesS2ShGh7zb20S4wIN2UmjzAgowOLrXzrcKA3Yjb8Cj7o4IDWbcXN/L2ORdQ1wlxytR
         Cj7GNYCI2tdYbQgDQgY17dyRpSICz1JlmTGNjVg37Dk1XZGd+i+dYkwJUvHiL311MH5g
         mM1dTHWAcyxUPblVzOHM8LNqYnxG6HbtSOIY8ULBzY+Mv6MAWCk+NvGW/VLQ08XFuXE/
         C4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701174362; x=1701779162;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWjEZ/SUQrSUmyqfWuq2eTx6HkHasTKwK0H9S4JJ4Io=;
        b=JvIUgLrME38aqTdxrCFkqDYi3hax4yR5uwV9rxjDGGko1UcTJfDCGsE9jkMxANWCG6
         4sQPdQUD2/u3ebAKQRgTPPBBvg20yY/HhyUSxZaXWOEoEnLRTyS7TxXJ2fKAz01poeu+
         doRZ9ZVj1uEWHKOWeUo3ZJACvHIovj+EE9m9vkPvzU4IVfWBN03RmXs9npeTMSHe4EhL
         FNDtvVm7wvTbXJlXQOA9v8AfoMp76+YFsQI39VD+GImP7lCCj60MjSbYkPKGaKnIZAng
         H+gmN0BzC9ataAD361VQ9AiGF3UAHnsGbtWFjkyAQaDg6iiWzRPXH0l45QI6ElDVMIfP
         mWiw==
X-Gm-Message-State: AOJu0Yxce1yEYq6k6sZAWs9XDr5ZUH8OVn2ovSEVOcRclC3sdeIySgM1
	KxTS06eIZRXJxIJ6/g9uLX7otfv8VIiIsKUfM6XccQ==
X-Google-Smtp-Source: AGHT+IExkbIGK+yxz9Y8kDkIjRByaumTYqTMVx/OaGjw1A52Cq9j2XTHa5tlKE7tPXxeoL5sSv1H+Ge/FeZLf+VtD3c=
X-Received: by 2002:a67:efcf:0:b0:462:a31c:78c3 with SMTP id
 s15-20020a67efcf000000b00462a31c78c3mr13888950vsp.20.1701174362355; Tue, 28
 Nov 2023 04:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Nov 2023 17:55:51 +0530
Message-ID: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
Subject: btrfs: super.c:416:25: error: 'ret' undeclared (first use in this
 function); did you mean 'net'?
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Following x86 and i386 build regressions noticed on Linux next-20231128 tag.

Build log:
-----------
fs/btrfs/super.c: In function 'btrfs_parse_param':
fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this
function); did you mean 'net'?
  416 |                         ret = -EINVAL;
      |                         ^~~
      |                         net
fs/btrfs/super.c:416:25: note: each undeclared identifier is reported
only once for each function it appears in
fs/btrfs/super.c:417:25: error: label 'out' used but not defined
  417 |                         goto out;
      |                         ^~~~
make[5]: *** [scripts/Makefile.build:243: fs/btrfs/super.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/log

 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51BFjRBS06YQ3U/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51BFjRBS06YQ3U/config

--
Linaro LKFT
https://lkft.linaro.org

