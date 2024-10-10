Return-Path: <linux-btrfs+bounces-8758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569E9979E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 02:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C362850BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C87410957;
	Thu, 10 Oct 2024 00:54:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D414293
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521646; cv=none; b=AwvNjmH+kOlhUpHAz362B6+iVUgRMedeMfcbjG6nkSWCIrn7ln4ZfOggs2/fW8hRmjHiJkqrWwBjV4b3m91FBQm0RsBONqsXfk3xCxNSRTMIKYx4O4QfQl9GQJz/SXqbxr0BOY7+jBU52UDRjPvRqLQgJmDEjxbHg6yzSepRVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521646; c=relaxed/simple;
	bh=ZEf+mRMIEtHoQBvWHnPNgW50SBSsa4ahNYSUgssG85s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aJeSgMwdv0VnoFF+lZuGWhbwW31KbRNbkkjE2qhMwUYH876ohEow2jNqD5H9kyteVJ2p6plKFrbA2nVqAUjP4UYTYtjBHBAAD3C3zRbnWBSWw0fcMFY1IyWZENEzeuE17n1Xjtc6fsm5vJPS7zy0BB/+cGSA8VToDHtkNS5TO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so6869635ab.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 17:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728521644; x=1729126444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDd3dVTeMocyMGKsdPEvyYiDAGldatYVwSJW2aFtTDc=;
        b=toqHm/WvtV8MUVsOBG035DziO1PHHDIm+7wHqYMafo9QeJCm+1nJ+LBSiqmoJ8yXmN
         qZ6VaNc2sI2Rvogy7kzmOA81BkBUgDeSJQQbx5y1aWPc1xk1wrtdvXaXIV8LhGPBzod8
         Ky0PrxSo0zKZBVjceo9fsJom5DmL9GHwQsC36MLhn686eYNkI+wj9w2m0tCvWaVdsmZV
         aIsBHQrccaIez7xP3uxpjTJxcXyoVSFfRQqLylePBI3GPRtYgbUCglj/fXn0CmNMnFMm
         a9TfIS9Y987J0xABwgVJ6T+jUkcdANBKGgbIPHePQlSNCNKhzIijU2l+ctLpzoAA3MK+
         W5iw==
X-Forwarded-Encrypted: i=1; AJvYcCUW6gyRs71dejrbMCH+YUe+hOSSf8Z49LlBbUsrJIrVvDM8RRGqbGyhre0miGaVgJAxT2PyryEOa4qfpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCCavXKf699+k8yOyifuXPFWhHHMSXxxj6/L98JTZyVKhKbJz
	CLG9m23Aa0ClojVJxiYEwAjEDgGW70/PTxYrL9JfT9lTrPpKyzZZWD1XnDm4N/esXT5fqu9spQA
	+Z7faWk6HyXFchaK8ilRLZDz1GONv9KruwDWckcNidqsI9TL+W0Qmm/M=
X-Google-Smtp-Source: AGHT+IHEynNFo0ccOZYNcQe1Z/JSsKyZamtEH62XfeNT8qGFQcToW7ZsSSUJBRUZaU358R3SSgLv2XvVLOS4Ht2aT2zy+9yMdjPF
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a397cfa93cmr48447805ab.7.1728521643780; Wed, 09 Oct 2024
 17:54:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 17:54:03 -0700
In-Reply-To: <5278c962-8f78-499d-9723-38a3d6520e19@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670725ab.050a0220.1139e6.0015.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] BUG: sleeping function called from invalid
 context in getname_kernel
From: syzbot <syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com
Tested-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com

Tested on:

commit:         964c2da7 btrfs: make buffered write to copy one page a..
git tree:       https://github.com/adam900710/linux.git subpage_read
console output: https://syzkaller.appspot.com/x/log.txt?x=115d8f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec5955a0d4f6ede
dashboard link: https://syzkaller.appspot.com/bug?extid=02a127be2df04bdc5df0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

