Return-Path: <linux-btrfs+bounces-6024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F791AE4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91AD28DCC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C519AA61;
	Thu, 27 Jun 2024 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzaGOgRJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099454918;
	Thu, 27 Jun 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509791; cv=none; b=r3HsJ3L91OSyeWcXncd6d+ZzI9aX3JARoVIXTlEsKxcCbEpazMok6I874dp8x5BSl8fBWPL2jz57Qjal2u56rbhjP6Eqnl4wijdDp2zZAPkyvNbqF7BpkDM7dW8+4JDhm54h4yiu6d8nCUw02fxJR3CcV1c3sGvq0ZrNSzw0u9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509791; c=relaxed/simple;
	bh=coYaJMIjArGvpQf7g0A/4peXT7vpXorezIIu1Z6s0aI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XS6tnIFybSHkkaavXwmU3Z9rDuu9htpeqvpgMXMdBZKb/vGundJPUTRVGTenyzcOQ0NB0Shu/PrXQ82e82fM4Cg626UtQ+8Wmefh1J8dyEHmMnn33XcmuuBqps/HpYWEldERjWyzQ2TNyC9/hAxz+p+0UHpkpVsNFtLsoeMf6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzaGOgRJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so8349983e87.1;
        Thu, 27 Jun 2024 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509788; x=1720114588; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yk4H1RLJJRoCdj5bfi9m2iP6KRHwo3a2/6FIyuZ1rs=;
        b=NzaGOgRJVp3aMksNUZO8HiGFfQvZDXCYmnH5BJnVkbyXvQmHwEaIcF0ub88hYbLJbM
         Yx7etLm+EZWotlHV2Ts2HNVnYk1ELr+FlL8AgD6tINpKF2t0bZ6E3XlMS75gT8YEl53F
         HO4AVtOpDAfDZWmPJdnvCiVqk7sBDG3PWI3kQ9l9hqJdUtLCigxoCF6g6gROvKsIbaeQ
         k/JoZChOd8fHb34cpm6i+LoGVcpbHPxrALJIpTPvax35i7zgFT37CeHn9YD3zY4xseQk
         SizVA585SVfC2IK7aZmsbEDnWws7l3FlDgHhQHiNTKbeNipMtXiSKQTDhl62CRdWdxvC
         Jkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509788; x=1720114588;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3yk4H1RLJJRoCdj5bfi9m2iP6KRHwo3a2/6FIyuZ1rs=;
        b=rjv/IwZuyb0HDAjb5sG3N+JH7JRFJ237+qVMCbvvFCJITx8xr3pkCCw+DnBWExQ3Uo
         O7ssGiQCnCLiLegToqtKfSFw1kFuhx79sURhFoqDoCPp9s8LZ+u41W2L4d4bHUJQ9Kvr
         RIzpiWUIDVhZtTKHZaJ5a4tkZl8aEW8aJ6SPBsHWX1b2KXlmohk5s5EZCZ8KyZfufJH9
         a7DysbaPomB72bbGJnY7Sd6L+VVP9tmPr+bzYqV+mzzShpt/DuPxT8kZOt50jQZnDuMB
         LL75/6kuiPKa+FUHD7T5Z3He7Wox2cN56vQqrWfc12/toGTRh0es06PpP6rqg5UdAu62
         HL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj0WrN8X9fChIZtU6p3GrIdWOYaIKHdz17B/FL/hXTIcY8YbYFa99bkTnFgGyROGMSMEJIrJX/Vh1zsODLlTRnD6OiHXUiMYmUcF4=
X-Gm-Message-State: AOJu0YztWFF4vmri5CmvlOl3CTROdrhLQ3pJXJTwv5RonYkAtOPYlBch
	IP5iFCMfNHZhSQi6d4xX9jxAdaiiGH9bc/mIbEkBSGCPYM/7NLmIzgagWQ==
X-Google-Smtp-Source: AGHT+IFD6a/P2HZh8/mK6o8zcolkgZvVGoo6nIFU70BTOQq/I5nXvKizgLOvUa/6DxvCFFFkIGrfdw==
X-Received: by 2002:a19:384b:0:b0:52b:c1cc:51f1 with SMTP id 2adb3069b0e04-52cdf7f10ddmr10035006e87.23.1719509785473;
        Thu, 27 Jun 2024 10:36:25 -0700 (PDT)
Received: from [192.168.178.20] (dh207-41-166.xnet.hr. [88.207.41.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d6fdfc5sm80206166b.10.2024.06.27.10.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:36:25 -0700 (PDT)
Message-ID: <76d879d2-200d-4b15-8fab-fcd382a4c3e2@gmail.com>
Date: Thu, 27 Jun 2024 19:36:23 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: =?UTF-8?Q?=5BPROBLEM=5D_make_randconfig=3A_fs/btrfs/ref-verify=2Ec?=
 =?UTF-8?B?OjUwMDoxNjogZXJyb3I6IOKAmHJldOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxp?=
 =?UTF-8?Q?zed_in_this_function_=5B-Werror=3Dmaybe-uninitialized=5D?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

After following Boris' advice in https://lore.kernel.org/lkml/20240404134142.GCZg6uFh_ZSzUFLChd@fat_crate.local/
on using the randconfig test, this is the second catch:

KCONFIG_SEED=0xEE80059C

marvin@defiant:~/linux/kernel/linux_torvalds$ time nice make -j 36 bindeb-pkg |& tee ../err-6.10-rc5-05a.log; date
  GEN     debian
dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes -R'make -f debian/rules' -j1 -a$(cat debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 6.10.0-rc5-gafcd48134c58-27
dpkg-buildpackage: info: source distribution jammy
dpkg-buildpackage: info: source changed by marvin <marvin@defiant>
dpkg-architecture: warning: specified GNU system type i686-linux-gnu does not match CC system type x86_64-linux-gnu, try setting a correct CC environment variable
 dpkg-source --before-build .
dpkg-buildpackage: info: host architecture i386
 make -f debian/rules binary
#
# No change to .config
#
  CALL    scripts/checksyscalls.sh
  UPD     init/utsversion-tmp.h
  CC      init/version.o
  AR      init/built-in.a
  CHK     kernel/kheaders_data.tar.xz
  CC [M]  fs/btrfs/ref-verify.o
  AR      fs/built-in.a
fs/btrfs/ref-verify.c: In function ‘process_extent_item.isra’:
fs/btrfs/ref-verify.c:500:16: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  500 |         return ret;
      |                ^~~
cc1: all warnings being treated as errors
make[7]: *** [scripts/Makefile.build:244: fs/btrfs/ref-verify.o] Error 1
make[6]: *** [scripts/Makefile.build:485: fs/btrfs] Error 2
make[5]: *** [scripts/Makefile.build:485: fs] Error 2
make[4]: *** [Makefile:1934: .] Error 2
make[3]: *** [debian/rules:74: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
make[1]: *** [/home/marvin/linux/kernel/linux_torvalds/Makefile:1555: bindeb-pkg] Error 2
make: *** [Makefile:240: __sub-make] Error 2

real	0m2.583s
user	0m9.943s
sys	0m5.607s
Thu Jun 27 19:14:55 CEST 2024
marvin@defiant:~/linux/kernel/linux_torvalds$ 

This fix does nothing to the algorithm, but it silences compiler -Werror=maybe-uninitialised

---
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index cf531255ab76..0b5ff30e2d81 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -459,6 +459,8 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
                iref = (struct btrfs_extent_inline_ref *)(ei + 1);
        }
 
+       ret = -EINVAL;
+
        ptr = (unsigned long)iref;
        end = (unsigned long)ei + item_size;
        while (ptr < end) {
---

Hope this helps.

Best regards,
Mirsad Todorovac

