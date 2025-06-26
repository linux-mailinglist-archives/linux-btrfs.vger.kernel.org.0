Return-Path: <linux-btrfs+bounces-14992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3AAE9D76
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560361C233A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81173296169;
	Thu, 26 Jun 2025 12:30:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049F2951CB
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941007; cv=none; b=B3At7nnhTgnmPvlZB6JIWdGmbhv38LXEZwTDWt1nNUv1w8+jgGiDwriHccSqzn383y4uX3L5N03tfhvgc+NW1mSK87TSWUBteUE4b+FNDio0GF++1Wz0WlJ+Tz1McnVaOG4smRbruBq7DuKJkAdF0iQruDjIhT0D6ObuwiYs+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941007; c=relaxed/simple;
	bh=CXStEVJvcv+k2Q2vxM4gbvEwCMVyfWubEkIRfPVOaNY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AmFmFUTOe2KhTzjLP3UK7UC3JcfYM3zyDVvYakWEegeog823oBhZxCqD1+DbddOQT/kI1KYuM/RXYa0PxLOkV1+/iC8c2Up/NTAi5mqGFqy0iQQTdXfR6OyEcAMl6Avg/eRAdx5Imu6s5KJLUDjSjsVYzRbriianCGPZQzd6TZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso9830715ab.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 05:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750941005; x=1751545805;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1o3hxzaUWzzHbBMm9wAarkIlEGX97bbmCARttE5VPQ=;
        b=TTjZN0IycWmnH64aL03GZKsNr9PX9M25gDrK3ZgjeQEN1A3egZ/rgQWZ5IfOCGKZXZ
         Efafwhw5vUhGQujuho9VBjaumXjfhxkn45Wae6xkROe1VYzNwXsNpY13cxg6CoMxgkZd
         DPfx7ZKbFK4qKhQ5MJiQ+eE0xmWmLTsIvq2QSXato1J67L+KSAcJI3oUx+yEuy1YQ/Uq
         pxWAddfGvNOO25pq7Tv0JUC6Q6mboXXeYwojD1ZhfsrRibZgoKhD0/ShctKgx8Vf/9SY
         e8n9LmMVoGLJWk2GGcYbPRf/Ft3Q2Plnd3X7ihXjP30E+NELKMT1lZIArNxEpG82Li8e
         Qj1w==
X-Forwarded-Encrypted: i=1; AJvYcCXuFmOuqHIOPX6+PaNZTOfKsHmIjfATIOStetxb8ynauCjDMpWvMd/yVu5AxzyTMiMUs1krbaR+F6jnbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGG0cH6vcIr/uc7PeSlgV2ja0kVE30So0LtMQp7OoB0y3j88yU
	lF7VQdUsrkJiz1iqAjmRQuOttYI3NP54wOa3iutcYGBosnDr+bSvcm4qs2DOmOxTRMhw01zjx0P
	WFSmrYtRYqui5DImXwrLJCAbLvW3sAZbI4s7KzmngxCOK3KnRZv9lWdWmE2Q=
X-Google-Smtp-Source: AGHT+IFmpFVzPKBoE8YpXAKWX9bRYgOts+wBkYkpz0Rmx1o0jFY1lr//x9Pitxn4d9qLuNlh9BrgPCyx/LGoedvKFAfm45VU3+2p
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c241:0:b0:3de:265a:12b with SMTP id
 e9e14a558f8ab-3df32996d19mr16301395ab.13.1750941004729; Thu, 26 Jun 2025
 05:30:04 -0700 (PDT)
Date: Thu, 26 Jun 2025 05:30:04 -0700
In-Reply-To: <ac0d17a3-34c6-41a4-9bb8-ad9f3900c809@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685d3d4c.050a0220.2303ee.01ca.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_read_chunk_tree
From: syzbot <syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
Tested-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com

Tested on:

commit:         743c198d btrfs: implement remove_bdev super operation ..
git tree:       https://github.com/adam900710/linux.git shutdown
console output: https://syzkaller.appspot.com/x/log.txt?x=13a5b182580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=fa90fcaa28f5cd4b1fc1
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

