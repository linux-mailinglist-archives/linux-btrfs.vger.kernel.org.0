Return-Path: <linux-btrfs+bounces-2350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE28531AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 14:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828241C22D7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6160C55E40;
	Tue, 13 Feb 2024 13:22:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82555E42
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830524; cv=none; b=oG/s2vTcBFnMCKwtyG7dzN/tlgMdSgPKcaecKsVlRozz0wG4s4lRD5Hz9l6R+QEo2t1jmVlIY9gOMdRSr4nn1Jx+/sb+aWXWAaROO6iECNDEF9keCzZbLdTnrHLIYM2ORuhO1+Gu7WQ1dWKvaW5iGiT1k2Tt+OQF2UY1C/mpO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830524; c=relaxed/simple;
	bh=WCWqpEWxIIzybG/fHZHmHyhLo+i18DFBT57pGNH7hN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Emk/F4eihXm0+PaYqcgcGiDUWO5H7IRRSw+ycq706vMyqSpd5cGIZ3YQn1KYqz4Z9HrTbbsQqkYyrnju1qJviJVf6QzuK49Swoh2dBWqaMtwtDfoXJtgzDgvZQVFiOO6q3aCAuI3wv8YuUObBrPsOcdgRm9otbfCGfOUSLZLClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so382524639f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 05:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830522; x=1708435322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYC1BcP9cXtmRiUh/zwpL7m1Q5/5Z9cxadj63ttyamk=;
        b=C7sJQVkgr+/N0Q+EjAjBIRx/jsfXaS/HgREt1ujiSwkcSXSbP61RodSCXeoFU8T+Sh
         MXZBsEvXYzyelDRsgWlKlh6nn2k6PiVi9l5A7i8E9/p6ztinN7nNPhrqqBqzRrtCaWDl
         ynvICBb7qfpBP2lt/tbWSDwurZAM0x/MAwU/ZnOIaaz0w6kDJrsp2P4cK6sa0cF+NXJR
         bhmJp+mapfTywdTW+3ZCK+D4a0D7TAzUER81mHR+uWZBxslbOD0jsT9dWJ9Zin/oxHVw
         KmhcnV/dm91+77PCLHFZsoxM/mhks3edpVAnVOEfyFzJzhx4KdCQqpct9Z2Ourakd5zj
         MGuA==
X-Forwarded-Encrypted: i=1; AJvYcCUnIaQFZDRIPk2vZnchNC0FO8FxikiHLI5RhpLWYmIOeR6FlF0GHWLICX17K5IR4nsasbwo4WQKQ2x6Jj77ucs/qCHT08e7aw1P0QU=
X-Gm-Message-State: AOJu0Yx518fC4AJpI5C6aMv9v8orBbk1nuUD9zYtPFxv6CFpv1F2PeVo
	zl2EACoLB/QpH/aF/5RYZGZVAzrDyHKLXYCn6JYjFYm/cqh3LJ1o4ZbcVR/cC0iCg8ehGS8kA+s
	CZIvvY1bGk3xQQ3I6B/i1DYgArvPjv73bcXyMwkyaOAXT+ZNClucbNjQ=
X-Google-Smtp-Source: AGHT+IGXI9Iojtpc1dEyKuCK0zBZZu4EdKWp8NMzR1lQhvbivqq5MzT9OLkVQE3n8Drb6/z7HxEtFBz5mx7G+UHYnIpXgZl/rNDk
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8c:b0:363:cc38:db22 with SMTP id
 h12-20020a056e021d8c00b00363cc38db22mr845029ila.3.1707830522756; Tue, 13 Feb
 2024 05:22:02 -0800 (PST)
Date: Tue, 13 Feb 2024 05:22:02 -0800
In-Reply-To: <0000000000000faabc05ee84f596@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a545940611434746@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_create_pending_block_groups
From: syzbot <syzbot+5fd11a1f057a67a03a1b@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113ba042180000
start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd11a1f057a67a03a1b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17887659280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ac4e93280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

