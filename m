Return-Path: <linux-btrfs+bounces-18811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C4C42957
	for <lists+linux-btrfs@lfdr.de>; Sat, 08 Nov 2025 09:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96494E40BA
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Nov 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603572D97AF;
	Sat,  8 Nov 2025 08:13:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3822068A
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Nov 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589584; cv=none; b=mWAThMzvM/3MjxqbZ+HNTQvHOCjfbQznqjy0PbfxpM8PKCI1YGHSukvr16HWwcS8X4ftAVp+TjeceqaJrIGO7WSY8gFZRDy43X/kNyrBQhnfL2XhZK3pNK0tKSJR7wJoUgb+0Kom1FEtme2RxVjeW5CEmKjgdGxoTaJmnFyIrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589584; c=relaxed/simple;
	bh=27JXSn/FBRW2GWWhywQw7CZlC2js8f9iBI6IWFIG0tk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gbKWxoEgraW4N4VthbQYUAUkcHbOb/yvr5+ddlv8IdcpLSbARF0Erb3dpKYcDwjzZ6RLS9szpGUXuygJ2i2glSQOaopzf3GigGDPGOb7PP5r28WkPKCUXZ3XlH1EEXg9fKFabqLacxPJfXIK0csTt3VWEMN9sdn7mAR2anKW9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-432fb58f876so51742785ab.1
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Nov 2025 00:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589582; x=1763194382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW27Sc9fO2weGnerMih3oS1yEbLnA7HebxJJHprHAhc=;
        b=fsJuwOlkjlmtebm9lpG9KrOaoNwbaDwo+vod6JcU9JXq6yYL9oOIwD84vNUCdUt00D
         Wib1pYEKuYWtoF0K2PmP1jAZ8AJYnsd/fmH2bIjmPFX3d98Xl/S90dnHtZxR86BhoDKU
         69rlM1bn2vDsmnenZulPsW3Akn3SLiKQtQrCtgHsnuaOftH9BKi9rA01vGlitz4GXyzB
         KWXbdqM+i90oCrRI4BLsjvCUBoSu07vLDFLz4x0oJ0oZsLuT+/HIPOAW2teR81K0LKkt
         t3KgFcIAE3ugI68ECm4Ql/zlsRaoqoPpr9aFDC3oFssxKrX+jDeZ+jnafkHT1IchGa64
         hdYw==
X-Forwarded-Encrypted: i=1; AJvYcCVEs9a4Ro7zxg56p3+jfyLJqX5tbgxrhh6W8vPvkABPSWNWXAIQUrEaZTapqb8PkTEy9IWQMwjB7DPkTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qChZBF+35/bgOCcABLryl9Lfy/9JuUhU7ZZTQyxD6DGSjq/S
	rAnjMqD1m5m/vSc7I6z0mFZrDpixlp1P+abSUwZwd97Y05r4+NmWky9qj1IPnPCJaWJuNy/EvKh
	UNmpJs8qFTx7kjw9I1DdEpoByRlSELDhRRWRDEl5Rmuqye6LjBcfxUfsvzpE=
X-Google-Smtp-Source: AGHT+IFnp/37Mpq8a8szLmVV/9YQFU9jISxAaCqlFsMaQG6x6vkpfEZwfoq3bYpJkjNB3QYSI1u9ruzE6EnypNJOJc6nxR7MJG4l
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:431:d721:266d with SMTP id
 e9e14a558f8ab-43367e7e207mr28896035ab.31.1762589582719; Sat, 08 Nov 2025
 00:13:02 -0800 (PST)
Date: Sat, 08 Nov 2025 00:13:02 -0800
In-Reply-To: <000000000000804fb406009d9880@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690efb8e.a70a0220.22f260.0078.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_finish_one_ordered
From: syzbot <syzbot+6e54e639e7b934d64304@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 736bd9d2e35866a07f32d9884019e0431b0b50d8
Author: Qu Wenruo <wqu@suse.com>
Date:   Fri Jul 4 09:38:03 2025 +0000

    btrfs: restrict writes to opened btrfs devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ecb812580000
start commit:   374a7f47bf40 Merge tag '6.5-rc5-ksmbd-server' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=da6e201fec031cc0
dashboard link: https://syzkaller.appspot.com/bug?extid=6e54e639e7b934d64304
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eef89da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147c2fa5a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: restrict writes to opened btrfs devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

