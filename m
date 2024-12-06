Return-Path: <linux-btrfs+bounces-10093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF19E6FC9
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E085D169FD5
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2220B20C;
	Fri,  6 Dec 2024 14:03:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8882066FA
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493785; cv=none; b=ERsBZDN1xnxMl8E7m02ub+A1G4oNkR7rhkSUTjaWxGfN4CUSop9nDdyYQEWpg3jJetaO/rRgOVfgIKn71MocQYoI5TdrsBitYFsd5KxmpbxjFnEEKPmOhQTHXKnQmN0JUnJUQ/CJq1cX57oOSMvB17k2Qx/WXtb640HoKaTN1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493785; c=relaxed/simple;
	bh=6+6Y0OqPjh05gQKta8TJOUEKbsv5T1RD38jiuCnEUOs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lb+JpjlMy408dRO3txziNvbPVu1e1SvGdvhQipr77armAs3kJG0xhsVGX4dpDi1a3f3ibn/3wHFWK7QVrLu0P3U6n1FoLEq+VPIE1hpuiql7lraomGunSTkLdVZWOpedQAypm4HzukBK4o+JPsO3hWovxoxvK7cL5h6Y4s9rMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7bdd00353so20858145ab.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2024 06:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493783; x=1734098583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8XRj9YSdQtdr330AmGTn7DJ03L9ZcrLYg9DzCdnjMM=;
        b=qddZ0sg6qngRK1XMd/L+H1wpeBXUWrtUxi0rdnPBbDncVs0p9k8r21FZAuqlyPwnEL
         AS2oPrPEfo3QYSYREmLWMMC656ohy8eAVRaOOM4k7KG28ZiHSmuKvSNmodbDjSliUxhe
         I+8NaKUU05xkeUem2j4AsXV4ScakCJqhGQUw3ke6fS1C1OVs5dTyRj7aSmkI0at5i0f4
         MBoW31TZnbj8rfgReMpIveoaJRIwa7xr5hLxyFg16ajP9A80dg5Q2B3iJOWJCWWEq4RT
         qXj3UUIprANXZKpNqNDJowakEDkZZAarcZ8qGUgHoirQ5PDiG5X2eIkmeHMIdJOrY5Gi
         YOlA==
X-Forwarded-Encrypted: i=1; AJvYcCVeKNPToiawBDSyiPiDzUvBcoPTurbjVIUHJExX4JwelLzWn0HeCfNP4a3eRuA7HuDxhAtljkJ+Rx8H5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/H0oHXWOlfHFAuKPQsfcE73DyoK786mYBgRHH5/1J88K8VQwn
	ebHurVcZBK9Cua5Gq55mJ02HInEFaSTAZO94P34UzeDcnBU2lmFB+KiSwS8WxsMUFPEzumYXwvb
	HsU8c1gwzTGs+uv7zurVjB6ILTgioscGHUwK7ueL1qVKD+qBSPa9h84U=
X-Google-Smtp-Source: AGHT+IGVHN6Zo+umS1xhBdeJZTO0HWldJUeFVUzM0N8lJkVb3gqmyR4y3mZTYd3UFE9SblLCMVkkJXr0bGzmfD6/YcBGuUhQAB/Q
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a811d776fbmr39008055ab.1.1733493783149; Fri, 06 Dec 2024
 06:03:03 -0800 (PST)
Date: Fri, 06 Dec 2024 06:03:03 -0800
In-Reply-To: <66ec3506.050a0220.29194.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67530417.050a0220.a30f1.013e.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_recover_relocation
From: syzbot <syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3c36a72c1d27de6618c1c480c793d9924640f5bb
Author: Qu Wenruo <wqu@suse.com>
Date:   Thu Sep 19 10:48:11 2024 +0000

    btrfs: reject ro->rw reconfiguration if there are hard ro requirements

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c9d0f8580000
start commit:   d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=4be543bf197a0325c7d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125748a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14440c9f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: reject ro->rw reconfiguration if there are hard ro requirements

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

