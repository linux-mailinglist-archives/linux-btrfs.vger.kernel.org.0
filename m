Return-Path: <linux-btrfs+bounces-354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231387F87A7
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Nov 2023 03:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B30281B9E
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Nov 2023 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E11D15BD;
	Sat, 25 Nov 2023 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D20A198D
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 18:08:09 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so2495184a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 18:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700878089; x=1701482889;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNkBRv3dxo8+jS8LEe0BK6vmtXGRWkVZVRCHKdCvNKQ=;
        b=SmTOj8F3V1JD6eJdifLqaxGC6cgzvBacog7XXa5Ztu0Y+/ZTS4W+lWkRk0tK38PIBj
         c2jIU0h9VCD9sp/3+mVbOJv3Vv+8pBczYZsXXKN3d0i7BmE33eESRF0xgJiFVhuP6oyy
         i8qpDIhiPOF/7ghshaCVWPdLkGzbP8Rgj938X2btt2FMpcb7/huImmL1AGg+mgKl8Eye
         V5H765XEa/R9jvdhHmX4gIIcg1EhWRIw7xjUkpfdm+3bGLybsZVF1In6p27JXw6ZHlL3
         VQ2q2hrUjmC4l4p4SjW9XwbiS6BL+qYcDOZunBpCbf4g/KweI+Cy7kOmlh7+dqXPh8Yv
         kK9w==
X-Gm-Message-State: AOJu0Yy0Hfol6f+uuBXteKGA1r3sOzLVX/JNcoGDb1skmKsqlu02k4Gm
	xWMY3qZHyRCV+eFyVZRxKwiJYhZdE1GucvVsC2ouRhcaglkL
X-Google-Smtp-Source: AGHT+IHezmfVmKgu+sXTqtsDDbIynvslt6vTpPoQdO5MRY6A1ValnCSH6ckI5vBf2Pheekdw13oh+cvOUpANaNczH9AvcSsG8WNO
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:d12:0:b0:5b8:eaa4:c6d8 with SMTP id
 c18-20020a630d12000000b005b8eaa4c6d8mr713970pgl.1.1700878089010; Fri, 24 Nov
 2023 18:08:09 -0800 (PST)
Date: Fri, 24 Nov 2023 18:08:08 -0800
In-Reply-To: <00000000000092672f06042b7711@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d4716060af08a45@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_use_block_rsv
From: syzbot <syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot has bisected this issue to:

commit a5b8a5f9f8355d27a4f8d0afa93427f16d2f3c1e
Author: Anand Jain <anand.jain@oracle.com>
Date:   Thu Sep 28 01:09:47 2023 +0000

    btrfs: support cloned-device mount capability

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1446d344e80000
start commit:   d3fa86b1a7b4 Merge tag 'net-6.7-rc3' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1646d344e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1246d344e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=10d5b62a8d7046b86d22
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1431040ce80000

Reported-by: syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com
Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

