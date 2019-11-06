Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6604F1449
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2019 11:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfKFKsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 05:48:40 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44541 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFKsk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Nov 2019 05:48:40 -0500
Received: by mail-pf1-f175.google.com with SMTP id q26so18542567pfn.11
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Nov 2019 02:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DAczmuw5VQKALP7e0EFoROD98O1F6HdG4Aip6W8htzI=;
        b=LZk2RuZ5aIDYUlQ116uOyJ7RE9MHpXSjpsAZXBZ4xqtZ//xw8Orr1pVbFHNuWknftF
         mVZ73NLSLwqr0yHSg+LLdTi4BlwH3YUEx2xBrPPlpmKDlf0Ki696bGPlIqegYqu8NE0L
         iBxJE0vno4+ge+44l08oybGfvu6HsPPJD8+EX3o8yB888yyuTm+gShRzeWvEJKVufTZr
         z0W2gIMFIeoEhxy+6g7Fuufm8xQd35x8h3PMXnbx5jZ/4vIjORKqTyKp4lXftVuPK467
         J9cz3uqNiHV3pjdXFPUgyEFHogUN1XNP3UP7C6+9wtlha7vfa8b80VnJP4btdbIcGkiH
         yW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DAczmuw5VQKALP7e0EFoROD98O1F6HdG4Aip6W8htzI=;
        b=SCg1j77kk1nGt4EivRB45Yz+p3XX0JiSolU14mzAxlnwNH9fzTq9PuU+MWJBCAVLWu
         70zpMmiAzzZrw4pEV4Ar6MbsxjnORvcyf9TVUVld0mEq9xRN+wjSQiE135dRg6VkeqB2
         ZjdHMLAYgtUKfeMAesVL45R7up9tSWj8lBox1PJV1oddM2URy3JPcO0n452G1Yg110VM
         v8B0Bdm+0YyQWcRzVkloU0/yaF0zq+yRhr68wGrqkRVfmqhDtQzTxR8NRaHv2g0i6+T/
         NCPoHGNmniTTUZYjxyVZhvoEbk93jvr0i9yvtNF61KCmAxVJEd4iNfnx4IwU8wjp1s3f
         oliw==
X-Gm-Message-State: APjAAAX29fIbRxo9elD2nblnjQeOLiPMNTSuBdHQLEXjVGxmEU0M3BTL
        GDY5tfGddo4i1gSkN1zykn4e91RlxaqbaKdlEqYmv7nhyXgqkA==
X-Google-Smtp-Source: APXvYqw8Qa+5UR+LA6khUhEuh6tR/lfrB4Rkz8S5F/cDie+nhWG08H/CwDxQnzgPbLBbjZwjRtC3VcUDtA37xwoCCqE=
X-Received: by 2002:a17:90a:25ea:: with SMTP id k97mr2820579pje.110.1573037319169;
 Wed, 06 Nov 2019 02:48:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
In-Reply-To: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
From:   Sergiu Cozma <lssjbrolli@gmail.com>
Date:   Wed, 6 Nov 2019 12:48:02 +0200
Message-ID: <CAJjG=75NkbJJ+r0zNrFt1KJQpxTyGKinkP-cqj0__wWrzVP4nw@mail.gmail.com>
Subject: Re: fix for ERROR: cannot read chunk root
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

also btrfs check --readonly /dev/sdb4
Opening filesystem to check...
checksum verify failed on 856119312384 found 000000B6 wanted 00000000
checksum verify failed on 856119312384 found 000000B6 wanted 00000000
bad tree block 856119312384, bytenr mismatch, want=856119312384, have=0
ERROR: cannot read chunk root
ERROR: cannot open file system

On Tue, Nov 5, 2019 at 5:04 PM Sergiu Cozma <lssjbrolli@gmail.com> wrote:
>
> hi, i need some help to recover a btrfs partition
> i use btrfs-progs v5.3.1
>
> btrfs rescue super-recover https://pastebin.com/mGEp6vjV
> btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
> btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
>
> can't mount the partition with
> BTRFS error (device sdb4): bad tree block start, want 856119312384 have 0
> [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
> [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
