Return-Path: <linux-btrfs+bounces-12506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26BFA6CDF8
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Mar 2025 07:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CA516B36D
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Mar 2025 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4252010EB;
	Sun, 23 Mar 2025 06:21:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6761F9F73
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Mar 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742710866; cv=none; b=M64reo7P4czwpYmpjK23HzWc/pkXaOMypaQZ6hz7AZtjpt+TsFwzCMj+PsRun2RQQCZk97No14HSPTk5Tor6405BAP9yiKKg7hclRACEXIgqnLALY0h7L2vByhpbM9kxGRdGYtmfDzK2gU7J9antGUtioosPrzH7Kce1Dtv2SMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742710866; c=relaxed/simple;
	bh=fIjikgeQnvCF6m4qacBYM0tGQ43qTup+CcAWexWSxJM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M3LRkp0KU/sdRrwCOWU9H1pKU5gW5aD/0LKOM/XoBMwr25Uk8aiZiM0svKwmPo+c1L1whHWEUBDwce+njwEmv/n1FlW6ZcyPNtg2xbs3bfORpno/nUp0DJhD+/UIGsUu670CBVaM9BxM21px6w6bRLu5BliU4VpeeIITdJt8VeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b3882febso29418185ab.1
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 23:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742710863; x=1743315663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKtFTb08bIbYVi1e3b+r4LgWp1VnGb++rIXGH1+LjFc=;
        b=QPGsC3u3nIlZkR+p1swkyl4nKmVpMbWMlz1kc675Xy3WWg3iEl2UFMkf4TGUe54Bxz
         mKpSTbn/bRTq+t7vvBzevMZSag1jzAWI+rWiNcfTaW0ehLlYByjm3vi6dYzeRnskgmxa
         hsu3quVKnQEcvqhy2nUgTHOMUxASK7a4mt2qQVxb8U53uyNnv1sL7BO5INPO8nEpPaJ7
         cHu1+PRY5yxANit9YSn71J+XAkS2S/V1CQ5Edi1qXg6cEvnU38aUydAMlMrn0q0SmdDE
         mkc8i4JJ4vDaMj2BP48UKMMe83rj3IIlKux0PgbWXK7mixZ0iCa+9KyM+pyCEY2W05OL
         VXew==
X-Forwarded-Encrypted: i=1; AJvYcCW5BbXd1GgacQJ1ol56PZjyQMDJPd4Gzyk8vaT6MsP314f2DPSbpadhHcV2DUyGwm/I6rOgAUGglEhAmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhhbFxjmMI9px/BT8yikodMYgnUAc5DfmPDbxCqDaRFW/3TYE
	/4f1kkajFnHCYdU66XDFs9wiqZ13D6BrDtaAjR+SH12U37ILvfkiXvVcHTxZN/4X4Mmy50I4K5Y
	TBezScQdX02O/hbkiMTd+ht09o7x8CdTraqdHiyNNy2OZnCgBcA3fqOk=
X-Google-Smtp-Source: AGHT+IGPA7Fi5m69oP9shUMeLt/YBnyMDyFwY39TXEP9SiQUAtCQ+3ZkNsPsRUb2svjWb5C/HnXnpmmbKx6KHI8s8AYF+bo7faba
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188b:b0:3d2:b0f1:f5bd with SMTP id
 e9e14a558f8ab-3d5960bf875mr74389585ab.3.1742710863722; Sat, 22 Mar 2025
 23:21:03 -0700 (PDT)
Date: Sat, 22 Mar 2025 23:21:03 -0700
In-Reply-To: <03e95a73-6c8a-47b0-9b72-c1204118be47@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dfa84f.050a0220.31a16b.0056.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in close_ctree
From: syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com
Tested-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com

Tested on:

commit:         70a1072f btrfs: extract the main loop of btrfs_buffere..
git tree:       https://github.com/btrfs/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12875c4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d5d862b4e27dc0b3
dashboard link: https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

