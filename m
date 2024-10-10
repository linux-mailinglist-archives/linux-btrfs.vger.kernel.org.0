Return-Path: <linux-btrfs+bounces-8783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA3998704
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B376287143
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E91C9B86;
	Thu, 10 Oct 2024 13:02:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731571C6F76
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565327; cv=none; b=VTQapXeiGAFWIphAEaD19mG8PhUEWy/06z1fgCIN846n7Q/8PYeHp77t5RQCoBRF4D1xo2855V3fe6V7HMFk4FaNyBDCQCd3OumycteMBYPvip99HtAObAWLFIIlqAll5Ums5He3xQbakZV+F9DQIu+YyBU/SROMgPxkCCcXz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565327; c=relaxed/simple;
	bh=DvHbgqpLU7ICqGWKCGYvq9HX/D/ooIGNcJAe1yUJKvU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiyKmfyxFfcv7TVC+m64RsZykzhcpVZv+dMKke8nzod1ehZhLIMDHgzs/yuCYLnYvu6nNMb7k9JFnoTwJkiQeuYd51E5g4jKigH4BZFRIkM939GFwEEPrN/M45gM/q9Cu3V9TF71AEGVXg+5ZpA6V9PjR8LuoNP5td7U/2Pj3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so14827865ab.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 06:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565325; x=1729170125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlzEZSa2v6vzclZNmLlH3ROi34p53NpNk/Ushgepg+s=;
        b=mt21M4IgARDByChrpC6kXAFE7CK4x03TMpGSG8aRpcQffj9UfgDtyftBaBwrw/0PQ3
         uGiBGGsMsdYpRtEjn4h3vbBityhSuWXJc0vlZn7dL9zRXeXhstwxDRypnico9lkgSyzY
         MNfHgPL5xgqziKoW13W6DOWEWeKlOX+BcFFsm3EJpI8kT6CMM59u0Z8lkxhWD5JZjEkr
         mz0q2Nymrc25y+6FZ6u2W3UALTEdwe14lpKqpvWZ5G/Gr6xg2yoHS90/hR4g8IZrYFg1
         9omNTYDUB/ycWp9SZsAvKu1zVRW3GimNhIeqWcJKk/T42TPUHng/6UPv+3HgRPtDCpIN
         tEtg==
X-Forwarded-Encrypted: i=1; AJvYcCW6sMjde5mByORB4JLa/glc2+kc0jwwupgxe21xesGrwMfhmHFnav2stGWMZMjnF769ShsP2tFizCrqZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiRbJvV60nnKTRFsPQb/535iD/rD6hwqzORUV052ZjhpD9A3c
	5SVGZBnpeT78bpsYXqEbffRIA8UXqIucI9L8fNhU2yW1QgohdrZgxc3gcnlT57flQJ9K5d1CwJ4
	0G1zcVm/vrCzGajyR2cRyfFRh6Wi/MJMVxcmvn+HNfUmh6j7UUKKsuNM=
X-Google-Smtp-Source: AGHT+IGDoCqqGxhFLcFehZ6h3fw2iBAm6gSU9FwH5FG3zniTPo/8s7tlixDwcVYGQfxFJ0PAMi4iw537YA3Lz5B3IkXuIEvWHz8x
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a397d1d555mr60454095ab.19.1728565325434; Thu, 10 Oct 2024
 06:02:05 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:02:05 -0700
In-Reply-To: <670689a8.050a0220.67064.0045.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707d04d.050a0220.64b99.0018.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] BUG: sleeping function called from invalid
 context in getname_kernel
From: syzbot <syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 94a5b169bf5c7c47d3b1af759cf70bf1ab236ddb
Author: Qu Wenruo <wqu@suse.com>
Date:   Tue Sep 24 03:22:17 2024 +0000

    btrfs: avoid unnecessary device path update for the same device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c96fd0580000
start commit:   33ce24234fca Add linux-next specific files for 20241008
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14296fd0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10296fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4750ca93740b938d
dashboard link: https://syzkaller.appspot.com/bug?extid=02a127be2df04bdc5df0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112f97d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101d4f9f980000

Reported-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com
Fixes: 94a5b169bf5c ("btrfs: avoid unnecessary device path update for the same device")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

