Return-Path: <linux-btrfs+bounces-5584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B99018D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 01:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12675281353
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5675466B;
	Sun,  9 Jun 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ+t9K7Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB01CF9B
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717977225; cv=none; b=cv8Hm/WZBqv9XXJfjezQgDBbIVRh/hmDryDguy8nMle1n7uj7EN/MZ4LNXwfGwg/zHU1dIRC/M/LgdU4JpX59QBnd5/AI6e3eym73vslN9CXYmzkwyOUFKOQ+6z7u29KlMkwkArmOwVDfNf1yU2NVVBOWVfuthstsEdhTG/p3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717977225; c=relaxed/simple;
	bh=DHCLVjTViq/4Qa0xZEg7b2xaB9p23sDy3aCOIFwSSHU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=C8o0mZZLojKEOS/xWDuJkEW/UEltCdiHmyBVcGYX8xbZV5SPMLtKmJQzL5GCHOLCE6OKOjRcVt187/ieToBIWqJ5plM4HFtNt6JRbCb3VhAgxiEEBgA+CI/uBVnZrIgVzZT2VyQkrMKLSTKoyawR955znnQbJUpOMLvu9oneA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ+t9K7Z; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d21b3da741so1063252b6e.2
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Jun 2024 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717977223; x=1718582023; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6K/dwyLc3GlBrYS0nJfbXk/9BAP+79kg8YIblljyJk=;
        b=HZ+t9K7ZDo3LvnU2kmDphdQJMJpMk4DRqV5cyrU8pWrjg/Ad8cL9gCHejEHGhIsy43
         MnIOM4nOlXfMIznrq281criu/IEi1Shjf4HQFJSM8e6knuoXFoWi/G+WNXiURejc7d8j
         +xS0asee/6aBFq0MLwcXvOL2FWlih2FFFbL3HbPuGEzcEGHd+J7I7TSPV/xaskZSQCsT
         djHN2nktm9yUo+ZYJlKHgP3AlrZfQcHl+nrE8hjSNpcvPBsMx+YNGgTKfQKapU44IVZO
         2j4jHOwR/e+vXwLFvfusETR/yFqIJ+SwOepVJjdCdaCx8i6QsMuwHL7k14l00HUnJ2zy
         Z0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717977223; x=1718582023;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s6K/dwyLc3GlBrYS0nJfbXk/9BAP+79kg8YIblljyJk=;
        b=FKwVTYRHl8dBIv2UzRyUJIBHWTedGoPJs639dpuDOJIDXRdB4TSnFC5uFthcHf59yl
         gvIz2bENrfK27c/Hx/xYQJQ1sBIMgnwk4ebtdOcgH04hsmO3QEAnI+TVj8ab0HeDBtZR
         lwaEkXo/NFxlexSJtO5j1pccLkDLBvXQdmT60ZLgcaHXdpSXevwcM9kqhi3Y4qN6i6co
         mYU/cve4G+Eoyf7cTdP843ee+p9llGEOHRO6Nhvuf3G5/8Ij5NDVowtCtd7OHx61UsBg
         iY1jFPuxMTrATuuO+Ign4NAVqJDMOPFuXNDSuP4Ri28dYXuHMl09Ij2A7GvytgicF9EI
         4B7w==
X-Gm-Message-State: AOJu0YwHMottMJWKvx2nLcrKfMiG5QZY5w8hx/AD0RqEiGvREOB5Ja1e
	cqZA341+5KXubUmAYoieCfSb2vqip4lFu84Q3JKKxS6sX48zQLcEBtkgMg==
X-Google-Smtp-Source: AGHT+IEYV138xeh0rGMaG8auggd4vc9XkYw14z+0igByzwzKpgLWTXMs5oIc0OqnBehUziLpCxOYKw==
X-Received: by 2002:a05:6808:2a0c:b0:3d2:13dc:9db1 with SMTP id 5614622812f47-3d213dca0cbmr6570511b6e.10.1717977223269;
        Sun, 09 Jun 2024 16:53:43 -0700 (PDT)
Received: from [192.168.0.92] (syn-070-123-236-219.res.spectrum.com. [70.123.236.219])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b728327sm1455606b6e.48.2024.06.09.16.53.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 16:53:43 -0700 (PDT)
Message-ID: <2f8d2b44-8958-4312-bea2-8c53c2312c7c@gmail.com>
Date: Sun, 9 Jun 2024 18:53:42 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: btrfs-6.9 regression tests fail
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The convert and misc tests fail pretty early for me and I can't figure out why.
The other btrfs tests complete normally.

The significant output for convert-tests-results.txt is:

====== RUN CHECK mount -t btrfs -o loop /build/btrfs/btrfs-progs-v6.9/tests/test.img 
/build/btrfs/btrfs-progs-v6.9/tests/mnt
mount: /build/btrfs/btrfs-progs-v6.9/tests/mnt: fsconfig system call failed: No such 
file or directory.
        dmesg(1) may have more information after failed mount system call.
failed: mount -t btrfs -o loop /build/btrfs/btrfs-progs-v6.9/tests/test.img 
/build/btrfs/btrfs-progs-v6.9/tests/mnt
test failed for case 003-ext4-basic

dmesg gives me:

[ 3807.421836] loop0: detected capacity change from 0 to 4194304
[ 3807.421933] BTRFS: device fsid 4f1a8440-1a8f-45d1-9789-72080ddd9917 devid 1 
transid 7 /dev/loop0 (7:0) scanned by mount (3326)
[ 3807.423458] BTRFS info (device loop0): first mount of filesystem 
4f1a8440-1a8f-45d1-9789-72080ddd9917
[ 3807.423469] BTRFS info (device loop0): using crc32c (crc32c-generic) checksum 
algorithm
[ 3807.423477] BTRFS info (device loop0): using free-space-tree
[ 3807.423911] BTRFS warning (device loop0): failed to read root (objectid=12): -2
[ 3807.424407] BTRFS error (device loop0): open_ctree failed

My related kernel options are:

CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y

and the btrfs kernel module is loaded.

The kernel is version 6.9.3 on an AMD Ryzen 9 3900X

I can format a btrfs partition and mount it.

The system is linuxfromscratch so it may be something I've overlooked, but earlier 
versions worked OK.

Any suggestions will be appreciated.

   -- Bruce Dubbs
      linuxfromscratch.org

