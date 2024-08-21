Return-Path: <linux-btrfs+bounces-7363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E8959994
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 13:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316011F21A0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAE20527D;
	Wed, 21 Aug 2024 10:08:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F9205251
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234886; cv=none; b=bNQrE2KjT4zDxl+pK7umW65e3dSbt62K/gd6LJONBALI7Xzr+XVVHevDgbmsJA0Cr4PhkNXphNzFeAtlDVlFI1sknoOlUzQU6gQWPYqLV8nAf84a4LCD/WzBGdzDXUlgD/6JiNQOOykCqJTXQOjdLEh9rKbEcjSaMHwwKT45Kkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234886; c=relaxed/simple;
	bh=bcZTltfrN96IpyEwZ5ov0EAIPhOEfYKK/v9DQ75hgls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OfVWCcYXtqmPnYGHSIAnenVo+9CfBX08SC6JLD5TdbWdWU9B4eAIKe6/wBTfFlQHI3NjDvyPmenRvVYxwTpNAFJOihIqHo64yNPgTDBATJvIKJNaeAtfdBOqoGxQX97Yz+DJbnu+X2x6jrzkseeZfX0E0w1E7hzZv6heZx+asAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fc0896188so631808939f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 03:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234884; x=1724839684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltq4NN1gtmsJ84XbCNBVAWHYj2I60jKYTteZrBL53oY=;
        b=rTK0JforkyEXR/glJffqfPc8muKJMxdjGpXk8+4oYw037BiwPgicmoht8nhCeKds2n
         WcagyLp6VzaXUgrK0IF76jDBHYeQIDLuQDYIU6Zf0uFaupInGs5K2ytvkLS2eYeHJeP9
         ziErzjbw0hkNLW0mnBEThFgHzmktzEEAXph2c/Z+INssMLLB4k+LW0JR4mF5T1VnfIK6
         g/AIvnDbV4v5krYa3ukPA+xZK336lKd09g/MH4Auk4JWi+Mplg3fgzEBzeGu6rYZHhU+
         YEG1muj7ClfG4KMabsNBIb32rrzhjsuSg6975CfoGD6T7dYyiZk6HD/b3o+axn5V3iLL
         sCxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJRE1r1beratuyZlTb1mZI1WzcTEvWc3kHii3Qu4nAgVV+FI8PGWSRmPEQkHQes+di1j0A+zJeLNiPwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3l3WKmTzfydg3WDHXBGWAkb3wGxEINtZ/R3rEy5b9JCLjGL01
	0bPXOQAdZZ2omZ+0JXFztkvImstDXDH0Je4NnxtaIBJhVZMJq9RhMTdZtQFDaOQaZHJSEQiWeEZ
	Hj8kCQJTPU2UwYQuf/bq7pwWuQQy/GvAuUneW7thWSA9/2FlHKEcmCTI=
X-Google-Smtp-Source: AGHT+IEmB9UKevzYR0v8ZXvKnJsY7QyO14fBNAwZNyW12v4IM2oSwrprNKl2vkG2DtSDkY01BRFROBWdEcBatPLKYZqmXfKlaPwb
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1603:b0:824:d658:396 with SMTP id
 ca18e2360f4ac-8252f4bd9ffmr9836239f.3.1724234883914; Wed, 21 Aug 2024
 03:08:03 -0700 (PDT)
Date: Wed, 21 Aug 2024 03:08:03 -0700
In-Reply-To: <9343ba32a457acc4f536120e904a3d7fa9ed0adb.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3eba306202eb72d@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in clear_inode
From: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
Tested-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com

Tested on:

commit:         d30d0e49 Merge tag 'net-6.10-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14fbfe05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=399230c250e8119c
dashboard link: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b31fbb980000

Note: testing is done by a robot and is best-effort only.

