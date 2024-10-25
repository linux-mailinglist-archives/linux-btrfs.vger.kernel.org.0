Return-Path: <linux-btrfs+bounces-9154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB79AF799
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 04:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260FBB221CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832A18BBB6;
	Fri, 25 Oct 2024 02:44:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20818BBA1
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824246; cv=none; b=KFUzYHVwuLI7fowpELQk+roC2qn+wJpQSCb3g50d3xw33Qx+vB7ugFhXSrATC40O3+d1KrXfgn0LmZKFMUWnQZ7uMUj5cSIBHEJZI5c+J1yWtFiyugOko/wb2GxnG9FNQWqxXPSOHBT/PxuNPrXXg9A3YHzlEfgVPUoRkIPoCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824246; c=relaxed/simple;
	bh=809b/Pdx9nZs4k99B4LNprT67d7N88aPd1zEAnaWSeM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=usktUCW55JnaiIOnr2cDGfui9hnPq9WvsfKmC02uh38Qww7d4vdl17hWN81RGGElm0A97NktW561MMDJkI9L8SpqFRHkztYjqduNldBvvqzP2yXnPc+6wsipwGeo7mpoyTp5rK1cVFzAeAdJEXPsXT8bKSHrpLIvDUh5C9mJ7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e77be28dso329015ab.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 19:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729824244; x=1730429044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rf1NB7CaiBqSkY3iCUMsw6mB4tHAKpKKf4qb08+kcVg=;
        b=wV8nZ772rsbHnnu+JfK1XzgzSOJoqzNFfPrxGdy3tKEBQ6Th0ALf2vN0hFRHYOXyBK
         lb2ShsqJ5xxUFiotVNyVJ+4MJbtKIJdVgScsMjBeGt/VMtOuuUuFAMjZ+LARZ3gjFZyl
         kIWMv+stBn8EXVQtTpzKyrksE2yeLp/8/T+xJHLaXaXvxENhW9eIq6byaiHCblTr9qc+
         vYHqfkgQZTBDWzufJrsyOYRJMlVT0CfltkQ7ys72WC63d5AjmCHZRJs9A9OUkEkmiaxy
         Rbr9ZgdYkZElBCpKVzXzltge/awW4VXDiBNC+5j2khFyxPILXhzLNzMlfXROj9zv6Z+W
         UbOg==
X-Forwarded-Encrypted: i=1; AJvYcCVHCWIxY1a4wpSpfaGhWO3CqnCVRclm+dI6yxkf/cEfA6mb3sshrfCiIesku6o4xMANjnFm8LGCBSkB/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfJ096Lc8hoHdkIsddq/5PheWFgPlwK+GrZHWN0ilsY4DAAfr
	tXtKO0wRKOcahjUS7AjI0NVx1C89qB2zm7I0hiOUysjPK05m7I0zPj7rtZ2f7pl5mMPFgS2aoRR
	21orAEp28ajNJX5xkyrBkFS1e/WvT+Hco2UoG7U4a8Oo4CISKx8UMPoM=
X-Google-Smtp-Source: AGHT+IF9vK7j9JaMv5meiucavo9afosGlNIjCvwwNTF/nwEV2vRqnoIc01V0snq23E6oX1pVIh37G7/2zYKHOOfDteVjrArRaevR
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a4d59df6c9mr99235555ab.23.1729824243965; Thu, 24 Oct 2024
 19:44:03 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:44:03 -0700
In-Reply-To: <20241025022348.1255662-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b05f3.050a0220.381c35.0008.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
From: syzbot <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Tested-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com

Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11823287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169c3287980000

Note: testing is done by a robot and is best-effort only.

