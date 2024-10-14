Return-Path: <linux-btrfs+bounces-8914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48D99D5A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 19:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4831C2326C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9D1C302C;
	Mon, 14 Oct 2024 17:34:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090561AC448
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927245; cv=none; b=ruO8LZcIF74gcqFixhuMrZu/cn9akZNrt5cybYnw75YObbEy+WmKh6WDknwzbQ2tQq+xo0VMTk1FRHoGlDfZZcnxg6DXezajTi7vHZ3ekdGPIuoUUwAEZT3qdYhNK19pSGeYxKU68YJAK95ORzc1eYdfx3QW8x0dkwd7BUGV3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927245; c=relaxed/simple;
	bh=hVJROpK94N+N0CbGBD+w/8HK/Ot9QUak+hyhoEqDJw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nkK6pERNF4YZHoISjFm3f9b7XytTSL5k4lyCyZC/yjIQZ6chJvr9wYwluC3i+PrCGusdR01Sb5D3h0oKBqb9yanAb0nuO+gpmKjSYrLzY+Eq3fGS98r98YHWyUqW/QQW9ZfJ8kfjTD1lni7L87lr7mGK+hO8is3DRRrudRyaWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so11106655ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 10:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728927243; x=1729532043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIz6aeA35Dtdd+gzrdbE7pqbjuTVS8L8sDpKqV/lA8Y=;
        b=olrALvp0FA0AHhCyrvO/ShaBjSxb/UYPOdxKULsGDh89lUBQxJdK0KJDGQ7OSnV30u
         N+75tYyNQ46X+31Mxc7yYnTjcib5s2Pl7pAUKN2s2tIUlbG5K9iD92ZXAbW2cWHp0BJJ
         fc9XVQKHxw1YSA3RrZhzxq7nMqc+UGib1EQz1Wq284C6zdIfOBbEQBdD1N7SzKVRjwUN
         2V0GIXmX6wcw8J1CK7S9b8r7dOCo2P9C+Z8mo4hCuJr65ldbafeJWwaHwQm+14qG27Hi
         EzhLfOLvIscOH9Vqmh2oC1hUUG1YUjNZy2s1sLHhoBOWn5kWT/KH9bW+haX6fgRMLIp1
         LkVw==
X-Forwarded-Encrypted: i=1; AJvYcCVdv5n4Y5zUdvM76LmHUD3TqHw3flOTBoCOOTW6qGoYuP+8vFo0pkW3+ElP5SBoGvrvIV3ugx913Yl8ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYj2co23nSXZeiXA16dV43NumJmHOPHkRZGQRCD8SZtqAOkyp
	bNdyStc+dyonMIiGX5qJOfvAlEh5ixZaHqLUIPDgqMXRXS+jgNxJSBYS4zptcdjBrY6Z3ekrgbB
	3CfllJkge8AcY//siyNs15fYzOHcoDiT5HADJEyoMnWQMpo5u1KFn8aE=
X-Google-Smtp-Source: AGHT+IFptQUwr0vWB48z5MQA+lS055fW8KzC0Z/W0lDTudEaSMJjoJ1IOd4t4h9R8987EX2vPCMiQLHfteJkx5Pp1+5r9pczYkFY
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b28:b0:3a0:8f99:5e00 with SMTP id
 e9e14a558f8ab-3a3bcd962cbmr67041665ab.4.1728927243134; Mon, 14 Oct 2024
 10:34:03 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:34:03 -0700
In-Reply-To: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d560b.050a0220.4cbc0.004e.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in add_delayed_ref
From: syzbot <syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3aad8f4f5d9d9a977ee5be32b07bcc083cc8d28
Author: Filipe Manana <fdmanana@suse.com>
Date:   Tue Sep 24 16:12:32 2024 +0000

    btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14596887980000
start commit:   d61a00525464 Add linux-next specific files for 20241011
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16596887980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12596887980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8554528c7f4bf3fb
dashboard link: https://syzkaller.appspot.com/bug?extid=c3a3a153f0190dca5be9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1266c727980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ce9440580000

Reported-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
Fixes: a3aad8f4f5d9 ("btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

