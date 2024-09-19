Return-Path: <linux-btrfs+bounces-8136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200397CF53
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 01:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA521F22178
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD68E1B2EF9;
	Thu, 19 Sep 2024 23:04:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE309168C7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726787045; cv=none; b=O7hCoAv0mYgFYmpqCIcp7kgmJ8QhxyeKD/fyI2/D6uSepRg8xTNIUw5O6jL5BkWnO1l6rY3KBtKVSHfMCXHuIVkFM/rtzDGoqmeAr92Wojn1k85sEbtp6Mwvy5iumFKQ4lqSkZgOguCchhfKfPNAPwbK7ce+87w2+praQf9EG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726787045; c=relaxed/simple;
	bh=S+xaMHpRzSmwKl+xnSmMA+1rbDdDSSqhrETfd38to5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=deQHNmIpo4ggygxXcgadnypI0cUz+TlrtOXiKStHOTuAbhU6bYqgKN1Q69kdGWPQMIyW/EZzUnIlstAfqQ2bWVHr3GfW4+ITwAQ+legtJD6JpiLOQNywWBv58Occ9kxwrkXHO5jcmJZx8rJLmOz6eGJsgQHB4XP04txytX5H9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a08c7d4273so17801245ab.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 16:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726787042; x=1727391842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWJz9uQb72/vEZbHa2crnNKcS8EkbVeNZXJ4aWGfF1U=;
        b=oMRlNTFElr/ulZZaD57WCskkkqcwaAvsK4Uh3rY2foYnh65/YOKoCO++Z214v+zkge
         8UjHu1ukmjkJcbYI4o4BRf0rVzHf+flc91C5BGIO+vKQcjpTv8gx282zhMe2U7JOQje2
         VnDze5eQReC/pNM5umYI/VSFa6snnjdS33dmx8RKI6b3UfoRo/FIRKD/MOCaGyYnukyq
         2T8hMLCxG/dy29TePjX3ys3slfsbIYpYjJDKnBJKuzpC+sVU8uQ7MH+c+iBG1wVt1Y0H
         JrKN41MOqfEyAnbtN1ZIbUqyVzXXAD2xgZR/ex4y5ANwEasqt9NEI1Xjeh+buFXGfURj
         X54A==
X-Forwarded-Encrypted: i=1; AJvYcCVajVXFRoVVkZ1O1yeJ4rOwCMpm/UeieSnQggMRhLBrX9VEH85hTqFoVmVCW2rBWMSsvCWGmHXXIUWgbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVGQxxAhcywhCEb1RJD4nXhcPYt1KGXVBkzWaGghtrT9xG1rg
	d0hjTSsPV7eOVx88HSxfpzeimxoa8u5YcWJX/Tl9a4wL340HG4RXkGfPa2jicFBLsR8NbQdfu4m
	9xAcYeTdBhZ0/i1ek/3wUwsswL+JK/Znnt+nf/oCA65wSO0il+tYUYL8=
X-Google-Smtp-Source: AGHT+IGUnyFeMqou91gbt1FJ9NiZ111uTDbMyen86xCUbASIebuCzc7eghPfyRyWtoDKYYnqMvMs9h/eGV3ocurQzcFme/qgSaZX
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a0c8cbf020mr12612215ab.10.1726787042095; Thu, 19 Sep 2024
 16:04:02 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:04:02 -0700
In-Reply-To: <d2c7c140-5c07-4071-b9c3-28eab1e3f462@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ecade2.050a0220.29194.004b.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_recover_relocation
From: syzbot <syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com
Tested-by: syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com

Tested on:

commit:         e309734b btrfs: reject ro->rw reconfiguration if there..
git tree:       https://github.com/adam900710/linux.git syzbot_rorw
console output: https://syzkaller.appspot.com/x/log.txt?x=167fb69f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=4be543bf197a0325c7d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

