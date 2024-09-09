Return-Path: <linux-btrfs+bounces-7889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88839970C08
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 04:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146D7B2202B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C361A707C;
	Mon,  9 Sep 2024 02:47:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883071A707B
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Sep 2024 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850024; cv=none; b=bcmNttS/VPXXOVR3vgXpQvHFEsk6DaPAHO0CzQ7It9AestfXS64QHg08MXtDoPvIxl2ML5TQhJpx+mCPn0fIL8EDyPbNMNFwNJrkweQ3c62D9Ec6/Q1QpfbgIiYi6tPvys0ySQx0UdEoM/aHXELWyH8T3sxhhZSujxGT7LmhLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850024; c=relaxed/simple;
	bh=6Dcl5uQTWTnrcqamApQn+/k490Oc4eWnS/FLx5/9kio=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ukZFlFpl6Zt9qOnhdphgmwxeaCMzRtGcBJKxuKmpYedVtbfsbQMwS/qY+SwK26HEp6xINL+Tv0ub0bbwTngB1smvym9H+dtXEaTMDSgp52e42/OQNDJ/ciAwP+zUT8eMf0/dXsiVHD+MF1ec1ZYj/GbojvP3uIQkUIBZU4n9S0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cf28c74efso7542439f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Sep 2024 19:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725850022; x=1726454822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c733kRQBOFm8yrm+WXb/6cY5HGwkZ2YjBhAmz1YrOqs=;
        b=TtU4GDnW4PhDQ5jbWDEp/+ZVSw514rxV0nBA0r6aI6zHH2mtjvLOagXUusgYCxQu4c
         b9b2k6W5DfXiS5li/ZVxS4MPPY4RnalnzzmMN8uKJKwrntsgEXkYMvzFydj6K55N8IMQ
         gFy2cRtRxAXDqrqRgkwRRcAv1elUdejRmCHSzKtePQukS5kFjB3gr0Kiv8/LN65eePbR
         mDxkUOWmPxngGH7sNSn515R+fuYRG8UHEireDazu24Aesxxv2khFYWv/hjQguLDX6oy8
         jjB+Pie69qZGtBqL4jhftaMUkAzaMpY4M/2GWwhRnsxVlINn+FmDXnC7igdgTiWDLU+z
         /HxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq9QVWOA5rxqmvSVKAR/BAA7bM3CyMIu41DSWGAA3jt/PL+XLNvmWpzlH23NjobgdDRZDsrUWkqkNtig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjl3qAHT4z9Eu6LOv7EJhRSTt183B2HKESbYY6DdVrs3MHUALR
	6JsL2vPqhHljejNvLOMcBbX2wH5Qsow1R8A2Tlg657VerES/DLOhdJlBxXJ+UDmm0Q8E4bF04vD
	WS0CtwdSXq0SlB1C3g5x6NN4APDiMw/MGLi24GjUa7EV5PwLVRumE4OA=
X-Google-Smtp-Source: AGHT+IHKhzQ8zZDWHdVyt2F1M3k/gEtYCjakknP+L7usaUIc47PwRUYqzbuC7MDerLaI5MErEzVHKFYRmir++9b7o6JdUfFqJNh7
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d09:b0:82a:a693:2736 with SMTP id
 ca18e2360f4ac-82aa6932a67mr440350439f.9.1725850022681; Sun, 08 Sep 2024
 19:47:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 19:47:02 -0700
In-Reply-To: <000000000000a2432a05eea26be6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089b3410621a6c54a@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in insert_state_fast
From: syzbot <syzbot+9ce4a36127ca92b59677@syzkaller.appspotmail.com>
To: clm@fb.com, djwong@kernel.org, dsterba@suse.com, fdmanana@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ed9b50a13edf442f5493603cc54f73bfc6eca1e9
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 29 18:10:31 2023 +0000

    btrfs: cache that we don't have security.capability set

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15514e00580000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12151d1ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e3d95ca80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: cache that we don't have security.capability set

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

