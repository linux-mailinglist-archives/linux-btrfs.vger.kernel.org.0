Return-Path: <linux-btrfs+bounces-8761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72124997AF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 05:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B99283AF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 03:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428418A943;
	Thu, 10 Oct 2024 03:02:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1B1BDDF
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529326; cv=none; b=mg21M67vl7xSh6dVlVTiy1uD10KHNHMGauDjeGQ+czv9D7QlXihrC09mSX2FIroVLac73qfyWINw9CbyE03DT8z4eYD4ekBVLddg/+uieAKzRsLikF2+3xbu8gbWlFErGxQrugYZS4Yb5sfblgGQrPKmE7mCQJqHOvtcEcwM6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529326; c=relaxed/simple;
	bh=7WCL9cwe+iSQbzMO8XzBhZ1W03SLA5HXprr9Py3FweM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X5vzl/H6zmsX1eguqwX1DBLJerDxVrXsIIBLBfOYlU+LORk6Fd+RglmvypSrbKNf2c+MCKAQ6Am+PgGvSMLGRtWuO0+FStjIFIv8gVgZNmJEd1eHSschLwgM7WtWmrzT41p5egVhxdpBPiZU58MmCXSUYYg1gvqqHaCDtZmuo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a342e872a7so5188005ab.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 20:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728529324; x=1729134124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9sJIKQWOb1Tdfi+vU5X7QaetO8KWr48ZJIV+n0gWeI=;
        b=cYr3RczihplGrdsYqYqBrQxCR6ZJwb95sQWj4E4Bzh2VCIqS7PB/jNj1mEmUy8SC6A
         o6bvWYATTyc0b8nSPwTV+cOKiYvpy10sWNDI7QQ/ZDQQ6fF9irtmccRQoJqXy/p8wXUY
         p1Z9Sywv6XHuIoyXB0VfNjBo6tSEKYUhFsOJY5TbZ67XrzRDdHO8cbWfv1J2eoJwRDAI
         uGf2ibuElHK1HvadElcNVRUmGkz8w4p4dg9gCqVAZV4yiSOgZDD8vw1kFQpmtBhXKirt
         fu51jMbh/gqS1qqTdP3hACC0uKVJ9tcrpMsbn2Y0Dh2r8SynkxcMDGkCJUBc0i1h9IkZ
         EM+A==
X-Forwarded-Encrypted: i=1; AJvYcCUAyF1ECamA5k9gofxu30fc7l6cAnmr8oCl79WG5j0lXWHnwjLx6G2r055ZQEBUbpM6CACr0/tT6ia9TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnzm299mJPDfHSlpSCDMOLfTK4W9ftm2/pZalhCcZYhxxCQ3Y
	B9lg2LNl9bbB4D/Ucv+TsKLwx8W7Y6HyjgcXh4DC6sVcna07BpjL+AQtcQVvf9bQeySFMBIJNMK
	vz5Ef5XgcuQaGWHhNuQy652QRu/sRQ25+7PPcXQ6xleZxe+eoth23ZW0=
X-Google-Smtp-Source: AGHT+IG8UynhjpDyM1sDvMbSwrFver1lRXwHCTzQ0carTWHfsBrgCJ5gvvlld5hbYbTN3xhP2anmLw8dKeQfjfwJ+QTNRP/PQptz
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a397d0fc3emr40497795ab.16.1728529324060; Wed, 09 Oct 2024
 20:02:04 -0700 (PDT)
Date: Wed, 09 Oct 2024 20:02:04 -0700
In-Reply-To: <11876ca8-6104-4f67-a7ac-c1dd7e9a39e0@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670743ac.050a0220.1139e6.0016.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         330f0214 btrfs: handle NULL as device path for btrfs_s..
git tree:       https://github.com/adam900710/linux.git subpage_read
console output: https://syzkaller.appspot.com/x/log.txt?x=122384bb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec5955a0d4f6ede
dashboard link: https://syzkaller.appspot.com/bug?extid=cee29f5a48caf10cd475
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

