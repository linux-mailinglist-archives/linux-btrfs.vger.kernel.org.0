Return-Path: <linux-btrfs+bounces-9292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850439B8B23
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 07:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376171F213DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DE14F9ED;
	Fri,  1 Nov 2024 06:17:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816D14A4DE
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Nov 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441827; cv=none; b=XNtbRMXyjSHoQxHWNO33GeiU3p2m0x0p5dZHDh0SjhSMPaO/6UhkU+K9duTJnIzGa39XG9jLnVsbwZUyJzo6hEaTI8lm8kf/i3uzDTheeY7yqTtE1AFyNZsymprl8xIeUhAQM7wap6XRTCVh6A+krLXunt+eimKy4+hb/NE8Dmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441827; c=relaxed/simple;
	bh=kct3lv/Ay66viC5s5w/Uf4vRn/IFoc64dUXrdFALStc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tHVaRIHaFFyqkMEmo3p1kmzIoP3U5jKuKczCZNJ4HdcxvD0mFdwdDqxmxe1uYR31GQ8ihkQTZW++Ha2g9QJz87r9IvLtvOpbuOjjBMmR33XtglpmS0mx2X0UExLj0kSMGcwXjY+Na8WLsGvGQwEoFgw00OdbtP7xgwm+wwzhFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4daf7174eso16099975ab.3
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441824; x=1731046624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q78wViwnoupvjRhtDfaJkpo7Mm+cH/30Ybplcy1BKGE=;
        b=qT80wcNlzSpFl9ABmKWeQ1XDeJOyh5WNTsu9+iL5cuwxgyNlmMhdyqH7Rjl3F3EdJ3
         FIvZ4aGX1mtuj0fLhmQKg3JImMWM7099iRFMZi1zgXoavgreKily2NPSMRrPJNcAP+RR
         sI9vK/0e9medguy6qbqYDNk1j4mh3R1acx5Lcm03oJG2Cyt193uRMYwJClcykDbALTVL
         0uw+3Qfq9fglAk9m0ENXcL+BAsU/TU+bZHf0Boo2SB1qHavCxdtoQ8pG5M2B7E+AvkkZ
         pCqVadWxW6pjOzFO86rmJvTT7pjI7tYia/wZSwA8+Ar46ZYyrCyFg1keLlpnckY83HNU
         WogQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdqs1LZtKDN3vu2Oc9F5/QFGftDT9zgBZxy8Ua0eslwL0nGpneYf07eRAf8ZzuThzIc5gbP1bWy7Z6LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypBggH/oUF7Zf5I9jeEXAI/oQVH9D3mCYIddEXAjy/AkOE8+TH
	PrBR113baTXlaoCOHi0eyJw5/4W/eEH9dqwNrm7QNkNzGlWdirQk/ZnI9sEHYNAeO5ILZEDoAhn
	U9i4VJBO/n4zZEIr8bWSVldaAP9ZUgo8G+X8qVGvFv8Bs9u3lYMkQU2E=
X-Google-Smtp-Source: AGHT+IG212HZVPaMiStH8AnQ233n3eXJbHVZ97Gl2j8FzrS6/zbgsV6pV/cA9qcBnahktj5Ec3I8r9A/nMFThb2mBcV66LBh63dA
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c5a5:0:b0:3a6:ab82:db5e with SMTP id
 e9e14a558f8ab-3a6ab82e083mr36818545ab.22.1730441823732; Thu, 31 Oct 2024
 23:17:03 -0700 (PDT)
Date: Thu, 31 Oct 2024 23:17:03 -0700
In-Reply-To: <CAHB1NajxyF5mBEqcuhRh6FdizNizoFsdUgBOGu=StFwUoByYAQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724725f.050a0220.3c8d68.0869.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in close_ctree
From: syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com
Tested-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com

Tested on:

commit:         6c52d4da Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f5155f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5a84880eccc01
dashboard link: https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

