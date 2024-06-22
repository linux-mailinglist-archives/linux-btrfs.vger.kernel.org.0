Return-Path: <linux-btrfs+bounces-5903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B02491360D
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 22:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB460282B90
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBD6BFD5;
	Sat, 22 Jun 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HztTWQKe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B24085D;
	Sat, 22 Jun 2024 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719089387; cv=none; b=T7kGpv5PPTW0Cc6AlXV3T0KJPAOCpg0LrA9rUqvLhkq6ZLA8kQKlhht2UbE8895+somgzW8lQbjBL1wf0zJ8/X7sfFUyRIX0MVlAVikRzeUUezPJfDteROuNEKQTM2nkFT9TR42mkrxEV45Zuz/PJF5WwlsLJHvnfa4o+Z7/vIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719089387; c=relaxed/simple;
	bh=XCPQDSanrClXe4Ydbv8I86HtOLXdoVO8uisB2yorP2s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=e6gl0f8W0BJDnH97fAbDlLsQ/swpO8DzJmCQLgI6Ab4G58Z9TfEFd3yuTUpZr973Ek9MyHSzTcuSO21AIsJQlMA4QNBL/DK3CSz3CYq5PCMSEeMghRWNqrkVCZdUyaBh1ub5kdNmsoqSC4lNvbvWKnAKdEzQQPPA3bsSJ49GEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HztTWQKe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso34685305e9.1;
        Sat, 22 Jun 2024 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719089384; x=1719694184; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nenZtZWRVZKM32sd/mbHx9Zj+PdS5ZrYPf3efuB4i8=;
        b=HztTWQKea1Bre6JMXUf9Sdfgkvwq5hFxcyl6nv/kYCFDaiZsahvU2S81xM/GZzlIeP
         tMiAukp7y39HOL8Z+W+ZNo2kFk5VV1WsvjZHG/DlK0y1VMQVCeKqy/oc6amHS4JKVveH
         bH06IOuhVS6+c5XREGdN/OZqlQOOcV5XSOc8JP7fwBQqsVNAiufOOJRStK4gsjW9gR5W
         qPKyiovxdD0poaG4FLQ6AxSzKBY/ViiRLO7quh2Sd2l75XVo7FdBrlbiYkiZhhsxsp3C
         PWsdK6KCc7UpOSNlHFNrNKM3eHYWxGle3urKt73e71W9QN8PmbZOQupUmbnJhZiVWIsG
         cTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719089384; x=1719694184;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5nenZtZWRVZKM32sd/mbHx9Zj+PdS5ZrYPf3efuB4i8=;
        b=czXpfiI51mYBmlMwhpk5ACzGvwpJb5fr6LStm4WhHTI6oui0FO9EuSdjKbTdDGFaBJ
         /RRKQf/Mc6qOwMIlk0dsMJkujvzvgm2sB8dnsWPYXjN5JCoN1oIWLkVu6ZSC9916OmTh
         547Z5EbTJZyq1EPvYwO3u/XLqCrFWc2StOXpLV8E2fORPNerdWRH0OBSb3HE+vYDwT3B
         mHH0zKFfI9/Se98PjvF5vcWo5AyVwPLDV3RGZA90l8ECSLQzQ41BueqH/tyVx5rJklEx
         hoi4uCZZB06YK7XUOV+KU2SG9YM8pgh9bA7HoUx6T58R79uik73otVYXLq8pfCj8kRGu
         DZAw==
X-Forwarded-Encrypted: i=1; AJvYcCX1tX/GLCgny1U/SPOBbfFcfIgNAWE3+P5yW2grPn+N45QurNNtmyxn8F+XKh0HIHVU/Vk5zgTrVpbXuOVSBrTAPLAoJ+ku+3tY2Ls=
X-Gm-Message-State: AOJu0YwAwti0hHjUWJqs9cO5aogOO2qChSyTneq0k90rtx7UKU+KkGNn
	8x2RcY7gW2dDs4HrdKIFwJNcTpJ+fMZE2oxtJ01aPt+TyU03i6lBxbDTJw==
X-Google-Smtp-Source: AGHT+IGEySX3tG5ZTc1seh3tJS0OrJIdkergANTn58BuRv8a8eenQ0HP8h3RkP64xMra6G5ptWKv8A==
X-Received: by 2002:a05:600c:304c:b0:421:cbb8:8457 with SMTP id 5b1f17b1804b1-4248cc271a2mr6492455e9.16.1719089383850;
        Sat, 22 Jun 2024 13:49:43 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-156.xnet.hr. [88.207.43.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817b53f2sm83516535e9.25.2024.06.22.13.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 13:49:43 -0700 (PDT)
Message-ID: <59b40ebe-c824-457d-8b24-0bbca69d472b@gmail.com>
Date: Sat, 22 Jun 2024 22:49:42 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: =?UTF-8?Q?=5BPROBLEM=5D=5BWARNING=5D_fs/btrfs/ref-verify=2Ec=3A500?=
 =?UTF-8?B?OjE2OiBlcnJvcjog4oCYcmV04oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQg?=
 =?UTF-8?Q?in_this_function_=5B-Werror=3Dmaybe-uninitialized=5D?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Testing various configs with vanilla torvalds kernel I came to this error:

linux_torvalds$ cat > ~/linux/rand/failed-configs/k-KCONFIG_SEED=0xEE80059C/err-msg
linux_torvalds$ time nice make -j 36 bindeb-pkg |& tee ../err-6.10-rc4-randconf-01.log; date
  GEN     debian
dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes -R'make -f debian/rules' -j1 -a$(cat debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 6.10.0-rc4-00283-g563a50672d8a-13
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

real	0m15.723s
user	0m22.371s
sys	0m6.100s
Sat Jun 22 22:34:28 CEST 2024
linux_torvalds$ 

Best regards,
Mirsad Todorovac

