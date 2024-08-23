Return-Path: <linux-btrfs+bounces-7427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F695C4E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 07:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847AC2863BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 05:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C655894;
	Fri, 23 Aug 2024 05:32:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6482433CE
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391125; cv=none; b=mewCumIm2UOAdF1ndDpJbr9sisi5GHvjh1SqMOJ9evBJnko4aVRj3y51CFRFXTk4wNGWSZM4FqTsE7596ImOmYpRHZ6/VZWv3HDROKog35hX/wV5L3xt7NU7CVOmHmeFkkWUYhf7Bmk3ZK0/PKvCcZ0DgnCSyLipUn5YARLWFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391125; c=relaxed/simple;
	bh=tjrQgKnSLxU6gqtQhbFxAS8Cues4EU6rrdqxMr7StuI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ozXqZ5EPPwBbRtPmKdBj9NNorQKv1VTtcv3clXrRDGaUBovQVLyMul51IUElwdjVIbI/e9y0TmyRGywvzHgx8F9UcOOcYPTfvLvS23u75bPgK8+CtbuzEEvF8M4Gc52jY1a6Y0uo+/vbUdzTk8Mcq0jQwxZ3RG4YNkLpJkm0ATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f99a9111fso161759539f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 22:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724391123; x=1724995923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2PVRUYIT6Fc4Ub3JqcZqbEIaTP7rGZEx+EtrUsZTBk=;
        b=cx65GGRvT6UJMyVw6CKHtPmWMQSydBVtcw2bv6q4LOJzCHi2KwVm3/6Vn2NzN8i0Yw
         rhCgqBp9ow1y5DFccn/n/vafcLc1qIbEwYjimv+Mw/NQySCOjp/L1yHZpBWim3aulwfV
         ykvKXIULo4vweDb13+n+2MgLYXmfGBFw+zSYD0q2afxz17iMwYAvwVf2TPJDoSVl6Hkf
         kdncEF1v3uz0ljSFDjuLLHH/Fe0oCyOg4+SQqwP2pbtnzjsMSUkP8kYOJ3BXKH2CW9DD
         +SDE9uZYl7ip5hzLNOjmJfgbxXtBxejv57J767zi3yOi45jsPOhcPQbod4j4fHHkenux
         R+sA==
X-Forwarded-Encrypted: i=1; AJvYcCUhR7k1qOuRrf3weVslkP0Rl8nMjeUSFf4mpfAHCoj0wXOIfgJzyvIR+KB1TyOAkzqeNGBakMabfd5wFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjB+pIKZl4Htkw2uPE+2ozrGbvr8jPgMQO+BzUILuMIwpNoihC
	qVwNnZlzMNx80W4uQifcCz7jfXUlR87cHd7rGN6OWU7By1dSgss5tNYzi8BxccNfSGwSid7VI+q
	fnpO06uI0Z5eddPMIjD8vMwpoFbvMFchRlm77GIuJbE95uSNPX5Z3rbE=
X-Google-Smtp-Source: AGHT+IGxIGinQXrgQeu1aksPsuMqmFhb2nPAuudXA4Gm4V7OxTKgl3xmHX00DpYnL37BZRFpnyg+c5Cac15bGnSmjxGVFZZxOwqf
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6a:b0:39d:300f:e91e with SMTP id
 e9e14a558f8ab-39e3ca0d343mr429575ab.6.1724391123033; Thu, 22 Aug 2024
 22:32:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 22:32:03 -0700
In-Reply-To: <d97aeee7219040e77c575d78995307cb7e87fcf8.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057b4b806205318ab@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in clear_inode
From: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/inode.c
Hunk #1 FAILED at 723.
1 out of 1 hunk FAILED



Tested on:

commit:         d30d0e49 Merge tag 'net-6.10-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=399230c250e8119c
dashboard link: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ae4b05980000


