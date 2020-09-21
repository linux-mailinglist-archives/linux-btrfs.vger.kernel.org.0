Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE466273397
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgIUUdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 16:33:10 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47754 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgIUUdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 16:33:10 -0400
Received: by mail-il1-f200.google.com with SMTP id p10so9107019ilp.14
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 13:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aBPEBUwwc1w0Cg/04GJCTG9lEmPYRUQwQksAFvdmTL8=;
        b=WMc3Fx+ICXhemGJ13TkP7i/9PP+hydTo+fsIS4zRjchBNUEFMNipqriOjuY1MtNO6L
         YSbV5+I/rD86J+Up2YweulvHzSA7O3MKF8GciZxkKwPuNAVVAV9SA+isnzoSNe8r+lgN
         JApHYMSAYViRPvFOGJGVF5QzyIictt/4sfy+9quc0U59HExo70XEhPzCisLEPNJaxq2v
         a5Pzvc1PEuJLs0BO4j3I1DXG7i6YBRttIuEy4gZDsEiLtoHJ1fxCGxGIQY5oOFMg7ALC
         SZOJ7aDunlsfxvnL7FtlVRBe1Gbfo5WoJkeSFt22/hJaIWHE5gIoUP2iMdSdJUDnJS9q
         LofA==
X-Gm-Message-State: AOAM532J57MTl2sAS+SpkVtt6/TWTVuEkttZIAJucjsEXKbWvbp2Qcn4
        2sFbEMX5Ywh7b81CrxLrf0iUf4VWsOuQHj3tV0ElOW4GUo4c
X-Google-Smtp-Source: ABdhPJxAHHhGt8MIcxnImqlS8iOvTg6NNJZCJaGoO7lTAyYbtLszF4Oh4nZpmJIQn9uLM4w7nqwOBzi5iC8i+dCSfoIcmEkSst2+
MIME-Version: 1.0
X-Received: by 2002:a92:4101:: with SMTP id o1mr1537117ila.296.1600720390009;
 Mon, 21 Sep 2020 13:33:10 -0700 (PDT)
Date:   Mon, 21 Sep 2020 13:33:10 -0700
In-Reply-To: <SN4PR0401MB359806224B7D96A1CAB927A39B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b39cd05afd8c21b@google.com>
Subject: Re: KASAN: stack-out-of-bounds Write in read_extent_buffer
From:   syzbot <syzbot+1d393803acac53c985a0@syzkaller.appspotmail.com>
To:     Johannes.Thumshirn@wdc.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1d393803acac53c985a0@syzkaller.appspotmail.com

Tested on:

commit:         d1db82c9 btrfs: move btrfs_rm_dev_replace_free_srcdev outs..
git tree:       git://github.com/kdave/btrfs-devel.git misc-5.9
kernel config:  https://syzkaller.appspot.com/x/.config?x=7885f44dc5918569
dashboard link: https://syzkaller.appspot.com/bug?extid=1d393803acac53c985a0
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
