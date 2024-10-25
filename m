Return-Path: <linux-btrfs+bounces-9159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD8B9AF907
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6CB283750
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADAF18D642;
	Fri, 25 Oct 2024 04:59:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAD2572
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832346; cv=none; b=dNOmLy2S6GAopyCMm/uKXhaRQQEMNxbf5f+NcVGa1XJ6iGhBRsYECUBBjyH1u3ZTHJU636ziqH9fNCtEWiP6zRkVlTfxJXGCBSADnVqN+6ZRW3HTkWnGZgZvbpMwk4UT8bPfJfs5F4o2uWQ7qrqQ//cBw94txZseolj/r4/InRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832346; c=relaxed/simple;
	bh=vY18EJ4z0Op19yBMfQIGh9p7AZkaSMwndll6XWs11e4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k6pRkIEr3cTkyMeHd8XbNZiRqvownmFzZea8BAVT1HTLQiAO7PO4JjzXtBPIGYgsTbzovkWwo7eAnlSwdRNsCSdnUakknMlLilgBZthZBcx8rsSa4+wu2+XZ+eYVqNb+weCq5K9Xwh/5KlT4nSGaGqSr/fE+33HaXPcWqR/Q7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aecd993faso181514939f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 21:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729832343; x=1730437143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XccUVO3qZwbE84EvnjTtajNNpK23t2mWRxb+KvTMwI=;
        b=TQporfHnH1PcB2m/oWJsGm0+cJZlElrtEOLNrkMCkDBFlxMHhijiewgHvmBOc2NLhU
         BO71HDrgrkV+RzZAPnp9pJZ+QPCzAfrpfy6HfbcA4lxDH4xRAfi5f+EhAn/AG476Ap0s
         /V0mqHq81V6aRER1WEksUjnZBrUP5sfbCRYeCof79w+Wc91L7dx/pOfpKeJMn8/Whs+/
         f9JsjWdTGN1W/RgvRGCHCRnEp2PDEv7nCsIhjV67v3L36UMgRbhiulmcXbiqqL2MwrhH
         mz+EPZJgWsYdtRjNY+EQrx7aNDiEZe0K2V/jgPSS8yNfrJbcWoSARtlpaXs3Dwcm5FiZ
         eiWg==
X-Forwarded-Encrypted: i=1; AJvYcCVwxRi1pht1i8wvLedgIRzWvNTF/V5zImccCZVxNRdNG/kMWmZ6NF80DuVrGdJkJJ1QU3gMxrVeXgXhaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhECab/y5Nn4DCdQfAf3dxaHtN1R4WA3Nbs+W204RB15ZfLPvB
	Uz2tGQtU5AiVLCEwrMnV14ZWK1uC+lcX3hDEeUdOSCKURoaSOdH1ABGrPMNFbHQA5ZjdzRnZeYX
	bLaqUU1n8oWjj21u+IWDRI/iPW2JgpCEoalYFYcJD0t1jrShLAZmY56E=
X-Google-Smtp-Source: AGHT+IFFCpZ+t8Bjue0Mc0F+VuEu7hi+JTghqCDgCsAahLm9Yx810/2WUSeF5aYj9VCf/oX2C+3ZvFnLD0+YEl3+I2DS33SQN4iG
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5aa:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a4de685e50mr24788195ab.0.1729832343706; Thu, 24 Oct 2024
 21:59:03 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:59:03 -0700
In-Reply-To: <20241025043848.1981317-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b2597.050a0220.381c35.000b.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
From: syzbot <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Tested-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com

Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129e3287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ca0230580000

Note: testing is done by a robot and is best-effort only.

