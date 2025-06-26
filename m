Return-Path: <linux-btrfs+bounces-14976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF2BAE9664
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05761176037
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 06:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B3E235362;
	Thu, 26 Jun 2025 06:37:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF67263E
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919824; cv=none; b=q9eHKxQpBQuWOczks+G51SWm2kuaAujdC7+6lZnglcRD/ZKvTXsz/pqUcALnwcdU73757MLSMZLfppyn0+lBGKj1i0KE8MqKPqxXYqcxC6qLR6pPmEjZA+Xg0Y8QeP89iXSJV1sqlz78OAL+RAoIl0gPQ9D7+Eh3hLBbT5rAS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919824; c=relaxed/simple;
	bh=DmuZkk1aCaprzdgt06WdsoPZO2TDGaBAxPyIIyEyEVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+2JnAqOzpuSdP/FFX44PlvkJ2s77AsRCVQQ1JWvTz3j/7m/3I3eEKSV9GsoNekqmEvmNqxWXlq2Z4DPRfT1Ruzd3teqrQp5oHWUrqGLHt6b8gjw3NyhZ9Yc7bebWv6GGvWXxn4n0o6ApPdDdQzpRo7d6x0f/DfWP/YtoC09AlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddcfea00afso12542355ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 23:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750919822; x=1751524622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0/K4EnAqNHlkESLS+MpoclzvATZKCXAy/CTRmbMi5Y=;
        b=jc/YB9SSAPN6vlJXESs8e3vVf3MHkT0hqYF7bRL2KLx4dWKdFzBgOG2DGmCxgdnq1n
         hg/+XJtxaTohTAtUrKDLoqp0C0vG3c1hXZ9L3aZVC88cbjkH2Mbhll/ijVshTA0VEe/j
         7xAGY6F3BnYgEwxHhkA54Vdicku4QH4cmAwW9q1kUS3fHG1ux9VYVLCyvx3rEs/5RxJS
         MX23Hz8yMDXCdEHP05fp7Fx8KzhXARSK768E3HuH6A4eQyBt8If4pbVVNUP6Nuf4F9JY
         uJNz/bBi4JQb1Mh3AXg9Ce/KT8L3bRzizHgaEjr/W02YuOUsJMiWP81W7oVxNLYMe/qj
         gq4w==
X-Forwarded-Encrypted: i=1; AJvYcCWZh1ZarO33gMSWrc0Ib2N2f08BCbE912RqiOemxypMvvmab8TM3lz67RQzN9CekYIjNWE9SKqrHCmBig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUdYwjhCu2pU6qndbEh52uI9JShOZ0WzYFngZzdO2Eeo0PlfF
	vLVmzLZXCdwRovY/LYoKG2LzRbA6SYecElNciFUwipGPstGKAOsv4LDYD2TtcahNtcqsM+4Fx7c
	OpXQQokeZ5BLgctI6mgqavLR/OYTngZgLD5Jty384XCmFky4nCrcsA/5Hqtc=
X-Google-Smtp-Source: AGHT+IEXxdtHO6gaP4rtT5q9QpCHzaC1rJufXe13EVgrskRPsRpqgUeCD/yNdu9V3Mb917yfLhWq7vRYsfbwLMgYyDdrVd7r4zqG
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:3df:3110:cc01 with SMTP id
 e9e14a558f8ab-3df32a123c9mr74691965ab.19.1750919822221; Wed, 25 Jun 2025
 23:37:02 -0700 (PDT)
Date: Wed, 25 Jun 2025 23:37:02 -0700
In-Reply-To: <197c44ef-aa46-466e-9381-a0edff657762@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685cea8e.050a0220.2303ee.014f.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_read_chunk_tree
From: syzbot <syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/ioctl.c:5417:1: error: function definition is not allowed here
fs/btrfs/ioctl.c:5430:7: error: expected '}'


Tested on:

commit:         86186e83 btrfs: implement remove_bdev super operation ..
git tree:       https://github.com/adam900710/linux.git shutdown
kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
dashboard link: https://syzkaller.appspot.com/bug?extid=fa90fcaa28f5cd4b1fc1
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.

