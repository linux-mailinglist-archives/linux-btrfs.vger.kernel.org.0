Return-Path: <linux-btrfs+bounces-4466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510538ABB39
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FDE281BB5
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119B2561D;
	Sat, 20 Apr 2024 11:05:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060D25750
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611104; cv=none; b=G05n49H5flWd3ASIJ/Ozphho0i3Hd3HyBjRJw58e3/f1eFrP78d3av3jl7QsJDZdc50kIFhhRHpdS2TydnrwlzRXNz4A1rimDwtp7i/P4FnM6F2hU8YGv8T+m5rfCD/LntduN0Ar8grvQF3bY0j3sIsqpXIUxPP1S7TLQltfgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611104; c=relaxed/simple;
	bh=s27xjU6RMPvfYBmkk7ft79miI0KqGUXUlJx7W0BFBWM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qrE/A/zWReF/Qesq14KxtAwWN7vUNAGVrsB5EIObHUl3UV1faLFFA6hO2EmAgZK4xxOZKeabmbSvF/veOSkTTmw+ViaITQoqyKSkEQNmnDGi2y9137XO8yLTr1JU5Y7xz+ePy7+zdpacoCYWus28mOe1/1/cwXEz1RDgd7j/XQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b3b387b4eso37552365ab.2
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713611103; x=1714215903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7yBwfO66aHRa1O9L8HvVyvKH1lIkd1DRxqnowucHIE=;
        b=Dmfptwxn+YEk+QCdLUx94z+xSHTNh7whVtPNsEV6huv85MKgkOc6OUU89CSci0PvjB
         Af7vWu2m82qqIVzR4yRAy+BE5z8u3qwH6TNh4dBm11V9AeacwF6xSpKCZ8eoemdx4eRN
         2F8EkCrB4m1Ppwrn6fqjFC6tXX5oHvix8O/UPrGR8/vJGE6iqQD6Xj0NQSD6Eqi36l4/
         457ks3nHodJ2q10nk+6CvVhN1g+i0kdeURsr3XAdRvDh3HeMmQOqDIEfNcYF+v8cxmHu
         SDnaasafbSFOXb3oquZ+E+D01lIRQzijoOwme7eoVBtQs5LkV+dAT2QX3rtAys+9VQXp
         NkSg==
X-Forwarded-Encrypted: i=1; AJvYcCXgHjimao/UDRfrdSR8Khz9jWkF+W5dP5qrt5TKO+RyvQmNaAzAUFfl+sB0N83R+cn0igAfO1kqDB70E7/8H+DjQddwQCcWetw+Zqo=
X-Gm-Message-State: AOJu0YwJYPu6fF127Qup/a9WbW5BTQG190meJzcSCfGXBZ7BihaFf0EJ
	BwxAJnS6q7V8rE5fyRQGwdmdK0Xx05HcVZrCxpYrnJAJQOV2bKEOXhZkkpvQu5uprPeevon8Q9s
	ZcCi945qeM64q9YWR+5sscyyFnWmQi6dYQSIdUU2mnXvL/Zs6VTUilJQ=
X-Google-Smtp-Source: AGHT+IGB/32niRDTyR/zhkffl/x3qMTy7ZqvWF2/VowCteX1IAeq/8/uNnmDt0iYor7nG+cfLEc0nQ6RnF5XV/gx2fSNQlSWchCP
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2144:b0:36a:fa56:b0fb with SMTP id
 d4-20020a056e02214400b0036afa56b0fbmr316784ilv.6.1713611103032; Sat, 20 Apr
 2024 04:05:03 -0700 (PDT)
Date: Sat, 20 Apr 2024 04:05:03 -0700
In-Reply-To: <00000000000089deb205ee0ddd58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000146a6a0616852ded@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_chunk_alloc
From: syzbot <syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com>
To: alfredidavidson@usa.com, anamartinez@projectloan.org, 
	anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	dvyukov@google.com, fdmanana@kernel.org, franklinozil@usa.com, 
	inquiry@usa.com, johannes.thumshirn@wdc.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123666bf180000
start commit:   82714078aee4 Merge tag 'pm-6.6-rc5' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
dashboard link: https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139f64ee680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da37d1680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

