Return-Path: <linux-btrfs+bounces-5306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AFA8D0F96
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 23:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E41F22FD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E4715F335;
	Mon, 27 May 2024 21:36:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956F53389
	for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845768; cv=none; b=Y2ncRFzndJ5SGPu+jYPRkAOYdWI87n+eGPvciPOITZZiwnxlTGl25B/gMVJHBJEgbxZ+rsV/XzJZW3tRa1i1LaRrKqSuHQZAiAUzVr4kacxM9GnVmv+IVVoc0TVjpC/Ib6lBttF+jsZ/EGZ/bSO4vFP2LXMOcB/8tKgp+5TyOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845768; c=relaxed/simple;
	bh=xg5p9I+oP40kmJhXADMlxZAPjvXHHTMarEVG/hmd09E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PyzPJmgu301joGF2/UNkArbHFTlubFLRi9BjXWtMecT5AOHh302DDzQmHHo2OuNfUlNoOt2x1ZNcvgmkJRAoivBb7/q1d0cZ5Iofkd/LqrDyY5FX1nP4W23Y+JJ39McWI1SSwny39gh4rDLeMxcuG1hlzXpxiD14k97zpjbNgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eacf25a50aso11905239f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 14:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716845766; x=1717450566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGnBPYhIToM5CvdNlwOkqkKSjA25/rvGdeWcOIlxVBw=;
        b=NygtlvOcCtyb/Q9cEOXNfLw9yMzUNZBECvELthOGWlmF42YjBEasYDZK5wxcBGl9/7
         QspWu/mcGIyu3KI+InmeWPRmFq4rArWD/zJnlRESdgCVaaEAEIwt6lWTA1KG0uOAWm2J
         /j2br0R9ySl00aQWHHglUwranhOQiBUO3lMgvS0rMR+p2XxqJul8UIfKh5GpSFS6GTCl
         uwqMc/ZOMq9K+8Bl6wdjEhWoieniRL5lIv0I3+Fm5ENR92TNxwBBXGDqasCOqLAqxrMs
         C+hYSz1miW/bD9u1pxgsmPqjlbGvd/Gaz9vJSWz9x19OKUNEa9CIeYkYJK6lhPG7IGMg
         bbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2DCDUSkuGSp6JGQlnQeB53L9/fy/tBqlCvTSn755Uk5985MJWkuY94c2C9a7JtRAoOYol+BrTiX3pqDW3BzJg2lrPGksIBJgL6C0=
X-Gm-Message-State: AOJu0YyNJj4AC+9eWL7RyCj8dwyXJv8F1smG7Gf+7NSozu6ywe45A+XZ
	yr+8pn+pueUNpYvHCUaGXKint9W+oIQ9LOBcInJk35jVxsG/hlh/C+VL57c5G9U1KW0TDy2Ve1o
	NP3Ec7tEoeIViD1sI3AxmWs5ZfHf5qX9/ywz0jQLBPw6eUVP5CICNc+I=
X-Google-Smtp-Source: AGHT+IGF5ftlSVDbRXoxRHrscozfUco3U5VmGiqRYnoCeclwuvAWs6L99ygLz4h+7bPaa9AKbhQaDw4qGRY1xtZYUovJp3h9Xpv1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1601:b0:7e2:b00:2239 with SMTP id
 ca18e2360f4ac-7e8c1adbc2amr32193639f.0.1716845765956; Mon, 27 May 2024
 14:36:05 -0700 (PDT)
Date: Mon, 27 May 2024 14:36:05 -0700
In-Reply-To: <CAJfpeguD5jSUd=fLaAGzuYU-01cKjSij6UbQWy72LDpqK1KQfw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003a6e50619764eb4@google.com>
Subject: Re: [syzbot] [overlayfs] possible deadlock in ovl_copy_up_flags
From: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com

Tested on:

commit:         f74ee925 ovl: tmpfile copy-up fix
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=142c4e2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=85e58cdf5b3136471d4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

