Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D667C4F08F1
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Apr 2022 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiDCLQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Apr 2022 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiDCLQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Apr 2022 07:16:25 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F912ED5D;
        Sun,  3 Apr 2022 04:14:31 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 9so8119338iou.5;
        Sun, 03 Apr 2022 04:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=473YRKNtbTeAAGTBhSk1AVQTddgdw5/IzzZpTy938xk=;
        b=JZ2LGUQyg7n2LEqDZsVb6FmhZIPR7Jdek4r8n842gjkZASB7sS8wnmwjmPX6dgy7cL
         467zHcPNlx5DqYRG7Eowna1rJcAXyDq7Ofa11wUklq0aLRqKV32JgRSjs/MrhKhKGMPM
         lwY2fgzwsCJEE+iELTq5pjEKvxwEBfFZOWRDGpOYsOoc5KMIfnqPKgjTeu55Y7W+bTbr
         +UpjEWvs/mg5j60fpTZZ1fYdWiRq7l84DZtpiCTs4n/qKbwB6UNgvc8XvaOoCvxeyRLa
         rJ415+7mX8Xw6z4H61nnES07M/oEP5zxV8BUE5EEkoXK4yrupRJULdUkneglvsOCUDJv
         Wmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=473YRKNtbTeAAGTBhSk1AVQTddgdw5/IzzZpTy938xk=;
        b=EWEORx2jsjnmJ7wskXkRBj/8dSBTj3T+SE393JrVMxLr5Ir7DHpZB+Txh+IrOuee7L
         zXd1WvqE4YejeOqZ385y046BF1geQQ7o7TeEyl39IizDZljMmKigq0V/qGW08R57BhCI
         5iE8GBxzAPVLcuTJeM+HhPTtYi1tONAmpxGCwsN87Kg3ASk5212KSs/uhnfZ9zj6zBKr
         dlVMsA2WS0yIUGSiYlQPbHoduvCHmyC+2Ycn01LSdyDPkRtsuG23F+nF3EwHja9Cc8v+
         y04ms5Jk2bYDwxf+5uuEZxMxKwqiGwzTdoaSRZsUpSO21wyfI2fwDtopwMSkJDDMXLTG
         XHZg==
X-Gm-Message-State: AOAM533LQMRSW97jxleM8hpQlXyiFO2y7PeYIfQWnZC7CjyCBKOoonMH
        isu6qs6HwWfHFEnp+Zozh0a9OS28RpYgtMWPa+5aTfk+qIOkC1UE
X-Google-Smtp-Source: ABdhPJyigFmotORseRB/b8BQWndmvWIBzrUBHBUJ/2qOYqi2gKeJCYwJDOskmLysypbS1a3/+xHnb1zHZwhcjtVTfJ4=
X-Received: by 2002:a05:6638:a3a:b0:323:5c6d:ae20 with SMTP id
 26-20020a0566380a3a00b003235c6dae20mr9792787jao.80.1648984470523; Sun, 03 Apr
 2022 04:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211109013058.22224-1-nickrterrell@gmail.com>
 <CA+icZUX0t1TzLm_XFEG50pZi_u901TcXP4CZspk6VRUw26vYNQ@mail.gmail.com>
 <EBEC67C0-1CB9-4B24-A114-42F52071F04B@fb.com> <CA+icZUXsjZyajW=pusRxhMYcLm3MgMZg_aHpkc_QFbHAeLzoVg@mail.gmail.com>
In-Reply-To: <CA+icZUXsjZyajW=pusRxhMYcLm3MgMZg_aHpkc_QFbHAeLzoVg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Apr 2022 13:13:54 +0200
Message-ID: <CA+icZUXNxNiKCqbC6+RcO+dLZMd-thOGpNBwnFsqGw3f81ztjQ@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v5.16
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>,
        Jean-Denis Girard <jd.girard@sysnux.pf>,
        Peter Pentchev <roam@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 2, 2022 at 11:31 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:

[ CC Peter Pentchev (Debian libzstd maintainer) ]

[...]

> I wanted to request a version bump to 1.4.10 via Debian's reportbug tool.

Debian now ships ZSTD (libzstd) v1.4.10 in their unstable repository.

- Sedat -

[1] https://metadata.ftp-master.debian.org/changelogs//main/libz/libzstd/libzstd_1.4.10+dfsg-1_changelog
