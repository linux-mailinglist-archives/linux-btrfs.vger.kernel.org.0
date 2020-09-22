Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D327389C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 04:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgIVCdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 22:33:37 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E31C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 19:33:36 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id j185so9402947vsc.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dbp1RdqxFuHJ40Jg/xtckfuG9i7g5Td9TTuUwMqv0YM=;
        b=qlMr4JAaEmVvBX1shL+dDf5SdoJK342BXqa+IsOVfqq51ZUiYgImtA9foUOfNAUh9y
         a9EN/wxdR6v14ESgXbVb4Co39IIsdRyIUheNt0O4vSrtFsFTbfcY5ud+uyQmyOWRMGgX
         cxqdQastXN76IRz932Xww7yklM7pZ1BxfV9LKzHRL2j5OA4nrdmPuqrAzo2uFoBp1XM+
         ZlOZYlW3bBihL1IRq+LzSUREVT60epHzQF/bxVeb6UlbjqP9b2Vd5PF7qpBOUln3DOO0
         eSdexmjJnIEgheEeu7YXUbVGucDXm8lmQD2+Wd9umPsjv4R4+mlVYANkMvjen1/Q5tSM
         wuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dbp1RdqxFuHJ40Jg/xtckfuG9i7g5Td9TTuUwMqv0YM=;
        b=b0//8S4I29G0NQh5OW5ldvhEhJSSLz+LE6GxtZcLRJj5UeQORwGTlUGv9JwPC19Teq
         ct08Y+uSZMAPJ+R8Tw5FUAmAWiath9YvbNysokSTAmmqgdXv3kuQf+OK34CmcL5+LlA0
         F7yR3UFOvT4BEFi1fOPYgGOnps7hTpEPMMv5Fc1ApNuMNTFCkxy6PmFi1CmXSl0patJW
         iE6op/6hT06fU9UafzNGVW7Xn0Ofa1DcC3PSu6miFyrDjvTAv1QtNGzWzScnbmEWPR2p
         5ru+VV8yj2GdnLNNhUlkGOCDPU+Gg1MBXFH3s3dAHD0Or3wDmcf4eal2ogypWSDeUbJr
         GSEA==
X-Gm-Message-State: AOAM533cICGygo3ebpPzDwPa8Ie6I41n1tCbBu1/nwmgA7mrpyoCjqYl
        Le6FbqwvgMPkT1ENpAqzu/4zXFhYcqQ9aRdnZGrf+Tio1ompYtKi
X-Google-Smtp-Source: ABdhPJx4Cz2DlXxhW82A05Ijuv3r7EAa3s3ia9ELIR1MmBd+oYNaJ3vjZ4a0RqbNJNY2OvDAx0x3l66uxJRqxTTJhcw=
X-Received: by 2002:a05:6102:11b:: with SMTP id z27mr2031930vsq.6.1600742015549;
 Mon, 21 Sep 2020 19:33:35 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan N <stefannnau@gmail.com>
Date:   Tue, 22 Sep 2020 12:03:25 +0930
Message-ID: <CA+W5K0qRCPZXR1qW=cg_g2_iufBHL42wV023VEU_Aj-mrLgoOw@mail.gmail.com>
Subject: parent transid verify failures
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

What's the best fix for a handful of transid verify failures?

Overwritten data is non-critical, and in raid5, though it'd be great
to know which files!

A controller cable was dodgy and some writes weren't committed across
at least one disk, but I believe the error output suggests it's
relatively minor damage?

The errors occurred on CentOS 7 running btrfs 4.12 but I was getting
errors running the tools so have been using a live USB of SUSE with
4.19.1 which seems to be having the same issues. Command output
follows below

I can currently mount the filesystem, but it reverts to read-only.
Any solutions would be appreciated.

I coincidentally have two spare disks handy, but was trying to avoid
starting a new array unless absolutely necessary.

Cheers,

Stefan

linux@localhost:~> uname -a
Linux localhost.localdomain 5.3.18-lpl52.36-default #1 SMP Tue Aug 18
17:09:44 UTC 2020 (885251f) x86_64 x86_64  x86_64  GNU/Linux
linux@localhost:~> btrfs --version
btrfs-progs v4.19.1
linux@localhost:~>

[root@rockstor ~]# uname -a
Linux ### 4.12.4-1.el7.elrepo.x86_64 #1 SMP Thu Jul 27 20:03:28 EDT
2017 x86_64 x86_64 x86_64 GNU/Linux
[root@rockstor ~]# btrfs --version
btrfs-progs v4.12
[root@rockstor ~]# btrfs fi show /dev/sda
Label: 'data'  uuid: f17e56d3-cf7b-42bd-9057-a252e7c8ab31
        Total devices 4 FS bytes used 30.90TiB
        devid    1 size 10.91TiB used 10.91TiB path /dev/sde1
        devid    2 size 10.91TiB used 10.91TiB path /dev/sdc
        devid    3 size 10.91TiB used 10.91TiB path /dev/sda
        devid    4 size 10.91TiB used 10.91TiB path /dev/sdf
[root@rockstor ~]#

linux@localhost:~> sudo btrfs check /dev/sda
[1/7] checking root items
parent transid verify failed on 23379494830080 wanted 370310 found 370296
parent transid verify failed on 23379494830080 wanted 370310 found 370296
parent transid verify failed on 23379494830080 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23379501907968 wanted 370310 found 370296
parent transid verify failed on 23379501907968 wanted 370310 found 370296
parent transid verify failed on 23379501907968 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23379594969088 wanted 370310 found 370296
parent transid verify failed on 23379594969088 wanted 370310 found 370296
parent transid verify failed on 23379594969088 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23379605192704 wanted 370310 found 370281
parent transid verify failed on 23379605192704 wanted 370310 found 370281
parent transid verify failed on 23379605192704 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 23379613597696 wanted 370310 found 370281
parent transid verify failed on 23379613597696 wanted 370310 found 370281
parent transid verify failed on 23379613597696 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 64705165721600 wanted 370303 found 370288
parent transid verify failed on 64705165721600 wanted 370303 found 370288
bad tree block 64705165721600, bytenr mismatch, want=64705165721600,
have=64705165656064
ERROR: failed to repair root items: Input/output error
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: f17e56d3-cf7b-42bd-9057-a252e7c8ab31
linux@localhost:~>

linux@localhost:~> sudo btrfs check --repair /dev/sda
enabling repair mode
Opening filesystem to check...
 Checking filesystem on /dev/sda
UUID: f17e56d3-cf7b-42bd-9057-a252e7c8ab31
repair mode will force to clear out log tree, are you sure? [y/N]: y
parent transid verify failed on 23379494830080 wanted 370310 found 370296
parent transid verify failed on 23379494830080 wanted 370310 found 370296
parent transid verify failed on 23379494830080 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23379501907968 wanted 370310 found 370296
parent transid verify failed on 23379501907968 wanted 370310 found 370296
parent transid verify failed on 23379501907968 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23379594969088 wanted 370310 found 370296
parent transid verify failed on 23379594969088 wanted 370310 found 370296
parent transid verify failed on 23379594969088 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23379605192704 wanted 370310 found 370281
parent transid verify failed on 23379605192704 wanted 370310 found 370281
parent transid verify failed on 23379605192704 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 64705165721600 wanted 370303 found 370288
parent transid verify failed on 64705165721600 wanted 370303 found 370288
bad tree block 64705165721600, bytenr mismatch, want=64705165721600,
have=64705165656064
parent transid verify failed on 26602944331776 wanted 370310 found 370296
parent transid verify failed on 26602944331776 wanted 370310 found 370296
parent transid verify failed on 26602944331776 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 63705658638336 wanted 370302 found 370287
parent transid verify failed on 63705658638336 wanted 370302 found 370287
parent transid verify failed on 63705658638336 wanted 370302 found 370287
Ignoring transid failure
parent transid verify failed on 26603323555840 wanted 370310 found 370296
parent transid verify failed on 26603323555840 wanted 370310 found 370296
bad tree block 26603323555840, bytenr mismatch, want=26603323555840,
have=26603323424768
parent transid verify failed on 26602347708416 wanted 370310 found 370281
parent transid verify failed on 26602347708416 wanted 370310 found 370281
parent transid verify failed on 26602347708416 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 63704756502528 wanted 370301 found 370286
parent transid verify failed on 63704756502528 wanted 370301 found 370286
bad tree block 63704756502528, bytenr mismatch, want=63704756502528,
have=63704756633600
parent transid verify failed on 26601476980736 wanted 370310 found 370296
parent transid verify failed on 26601476980736 wanted 370310 found 370296
parent transid verify failed on 26601476980736 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23798875439104 wanted 370310 found 370296
parent transid verify failed on 23798875439104 wanted 370310 found 370296
parent transid verify failed on 23798875439104 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 26600572469248 wanted 370310 found 370296
parent transid verify failed on 26600572469248 wanted 370310 found 370296
parent transid verify failed on 26600572469248 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 23798877814784 wanted 370310 found 370296
parent transid verify failed on 23798877814784 wanted 370310 found 370296
parent transid verify failed on 23798877814784 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 63705612271616 wanted 370302 found 370287
parent transid verify failed on 63705612271616 wanted 370302 found 370287
parent transid verify failed on 63705612271616 wanted 370302 found 370287
Ignoring transid failure
parent transid verify failed on 63705115246592 wanted 370302 found 370286
parent transid verify failed on 63705115246592 wanted 370302 found 370286
parent transid verify failed on 63705115246592 wanted 370302 found 370286
Ignoring transid failure
parent transid verify failed on 65633906524160 wanted 370305 found 370292
parent transid verify failed on 65633906524160 wanted 370305 found 370292
parent transid verify failed on 65633906524160 wanted 370305 found 370292
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=42808083890176 item=294
parent level=1 child level=1
parent transid verify failed on 26601781477376 wanted 370310 found 370296
parent transid verify failed on 26601781477376 wanted 370310 found 370296
bad tree block 26601781477376, bytenr mismatch, want=26601781477376,
have=26601781673984
parent transid verify failed on 26602572496896 wanted 370310 found 370296
parent transid verify failed on 26602572496896 wanted 370310 found 370296
parent transid verify failed on 26602572496896 wanted 370310 found 370296
Ignoring transid failure
parent transid verify failed on 65633913372672 wanted 370305 found 370290
parent transid verify failed on 65633913372672 wanted 370305 found 370290
parent transid verify failed on 65633913372672 wanted 370305 found 370290
Ignoring transid failure
parent transid verify failed on 66607399272448 wanted 370307 found 370293
parent transid verify failed on 66607399272448 wanted 370307 found 370293
parent transid verify failed on 66607399272448 wanted 370307 found 370293
Ignoring transid failure
parent transid verify failed on 66607249817600 wanted 370307 found 370292
parent transid verify failed on 66607249817600 wanted 370307 found 370292
bad tree block 66607249817600, bytenr mismatch, want=66607249817600,
have=66607249752064
parent transid verify failed on 63705652232192 wanted 370302 found 370287
parent transid verify failed on 63705652232192 wanted 370302 found 370287
parent transid verify failed on 63705652232192 wanted 370302 found 370287
Ignoring transid failure
parent transid verify failed on 64705165721600 wanted 370303 found 370288
parent transid verify failed on 64705165721600 wanted 370303 found 370288
bad tree block 64705165721600, bytenr mismatch, want=64705165721600,
have=64705165656064
parent transid verify failed on 26603323555840 wanted 370310 found 370296
parent transid verify failed on 26603323555840 wanted 370310 found 370296
bad tree block 26603323555840, bytenr mismatch, want=26603323555840,
have=26603323424768
parent transid verify failed on 26602347708416 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 63704756502528 wanted 370301 found 370286
parent transid verify failed on 63704756502528 wanted 370301 found 370286
bad tree block 63704756502528, bytenr mismatch, want=63704756502528,
have=63704756633600
parent transid verify failed on 65633906524160 wanted 370305 found 370292
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=42808083890176 item=294
parent level=1 child level=1
parent transid verify failed on 26601781477376 wanted 370310 found 370296
parent transid verify failed on 26601781477376 wanted 370310 found 370296
bad tree block 26601781477376, bytenr mismatch, want=26601781477376,
have=26601781673984
parent transid verify failed on 66607399272448 wanted 370307 found 370293
Ignoring transid failure
parent transid verify failed on 66607249817600 wanted 370307 found 370292
parent transid verify failed on 66607249817600 wanted 370307 found 370292
bad tree block 66607249817600, bytenr mismatch, want=66607249817600,
have=66607249752064
Unable to find block group for 0
parent transid verify failed on 64705165721600 wanted 370303 found 370288
parent transid verify failed on 64705165721600 wanted 370303 found 370288
bad tree block 64705165721600, bytenr mismatch, want=64705165721600,
have=64705165656064
parent transid verify failed on 26603323555840 wanted 370310 found 370296
parent transid verify failed on 26603323555840 wanted 370310 found 370296
bad tree block 26603323555840, bytenr mismatch, want=26603323555840,
have=26603323424768
parent transid verify failed on 26602347708416 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 63704756502528 wanted 370301 found 370286
parent transid verify failed on 63704756502528 wanted 370301 found 370286
bad tree block 63704756502528, bytenr mismatch, want=63704756502528,
have=63704756633600
parent transid verify failed on 65633906524160 wanted 370305 found 370292
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=42808083890176 item=294
parent level=1 child level=1
parent transid verify failed on 26601781477376 wanted 370310 found 370296
parent transid verify failed on 26601781477376 wanted 370310 found 370296
bad tree block 26601781477376, bytenr mismatch, want=26601781477376,
have=26601781673984
parent transid verify failed on 66607399272448 wanted 370307 found 370293
Ignoring transid failure
parent transid verify failed on 66607249817600 wanted 370307 found 370292
parent transid verify failed on 66607249817600 wanted 370307 found 370292
bad tree block 66607249817600, bytenr mismatch, want=66607249817600,
have=66607249752064
parent transid verify failed on 64705165721600 wanted 370303 found 370288
parent transid verify failed on 64705165721600 wanted 370303 found 370288
bad tree block 64705165721600, bytenr mismatch, want=64705165721600,
have=64705165656064
parent transid verify failed on 26603323555840 wanted 370310 found 370296
parent transid verify failed on 26603323555840 wanted 370310 found 370296
bad tree block 26603323555840, bytenr mismatch, want=26603323555840,
have=26603323424768
parent transid verify failed on 26602347708416 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 63704756502528 wanted 370301 found 370286
parent transid verify failed on 63704756502528 wanted 370301 found 370286
bad tree block 63704756502528, bytenr mismatch, want=63704756502528,
have=63704756633600
parent transid verify failed on 65633906524160 wanted 370305 found 370292
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=42808083890176 item=294
parent level=1 child level=1
parent transid verify failed on 26601781477376 wanted 370310 found 370296
parent transid verify failed on 26601781477376 wanted 370310 found 370296
bad tree block 26601781477376, bytenr mismatch, want=26601781477376,
have=26601781673984
parent transid verify failed on 66607399272448 wanted 370307 found 370293
Ignoring transid failure
parent transid verify failed on 66607249817600 wanted 370307 found 370292
parent transid verify failed on 66607249817600 wanted 370307 found 370292
bad tree block 66607249817600, bytenr mismatch, want=66607249817600,
have=66607249752064
Unable to find block group for 0
parent transid verify failed on 64705165721600 wanted 370303 found 370288
parent transid verify failed on 64705165721600 wanted 370303 found 370288
bad tree block 64705165721600, bytenr mismatch, want=64705165721600,
have=64705165656064
parent transid verify failed on 26603323555840 wanted 370310 found 370296
parent transid verify failed on 26603323555840 wanted 370310 found 370296
bad tree block 26603323555840, bytenr mismatch, want=26603323555840,
have=26603323424768
parent transid verify failed on 26602347708416 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 63704756502528 wanted 370301 found 370286
parent transid verify failed on 63704756502528 wanted 370301 found 370286
bad tree block 63704756502528, bytenr mismatch, want=63704756502528,
have=63704756633600
parent transid verify failed on 65633906524160 wanted 370305 found 370292
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=42808083890176 item=294
parent level=1 child level=1
parent transid verify failed on 26601781477376 wanted 370310 found 370296
parent transid verify failed on 26601781477376 wanted 370310 found 370296
bad tree block 26601781477376, bytenr mismatch, want=26601781477376,
have=26601781673984
parent transid verify failed on 66607399272448 wanted 370307 found 370293
Ignoring transid failure
parent transid verify failed on 66607249817600 wanted 370307 found 370292
parent transid verify failed on 66607249817600 wanted 370307 found 370292
bad tree block 66607249817600, bytenr mismatch, want=66607249817600,
have=66607249752064
parent transid verify failed on 64705165721600 wanted 370303 found 370288
parent transid verify failed on 64705165721600 wanted 370303 found 370288
bad tree block 64705165721600, bytenr mismatch, want=64705165721600,
have=64705165656064
parent transid verify failed on 26603323555840 wanted 370310 found 370296
parent transid verify failed on 26603323555840 wanted 370310 found 370296
bad tree block 26603323555840, bytenr mismatch, want=26603323555840,
have=26603323424768
parent transid verify failed on 26602347708416 wanted 370310 found 370281
Ignoring transid failure
parent transid verify failed on 63704756502528 wanted 370301 found 370286
parent transid verify failed on 63704756502528 wanted 370301 found 370286
bad tree block 63704756502528, bytenr mismatch, want=63704756502528,
have=63704756633600
parent transid verify failed on 65633906524160 wanted 370305 found 370292
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=42808083890176 item=294
parent level=1 child level=1
parent transid verify failed on 26601781477376 wanted 370310 found 370296
parent transid verify failed on 26601781477376 wanted 370310 found 370296
bad tree block 26601781477376, bytenr mismatch, want=26601781477376,
have=26601781673984
parent transid verify failed on 66607399272448 wanted 370307 found 370293
Ignoring transid failure
parent transid verify failed on 66607249817600 wanted 370307 found 370292
parent transid verify failed on 66607249817600 wanted 370307 found 370292
bad tree block 66607249817600, bytenr mismatch, want=66607249817600,
have=66607249752064
Unable to find block group for 0
transaction.c:189: btrfs_commit_transaction: BUG_ON `ret` triggered, value -28
btrfs(+0x51829)[0x55bf7a751829]
btrfs(+0x51e39)[0x55bf7a751e39]
btrfs(cmd_check+0x11ee)[0x55bf7a76749e]
btrfs(main+0x8e)[0x55bf7a71ed2e]
/lib64/libc.so.6(__libc_start_main+0xea)[0x7fe97796834a]
btrfs(_start+0x2a)[0x55bf7a71ef2a]
Aborted
linux@localhost:~>
