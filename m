Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40EA6807C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 09:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjA3Is2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 03:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjA3Is0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 03:48:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42794F4
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 00:48:00 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id v17so11997508lfd.7
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TjYrkDsK6yPh84aPbosRJZw6roXrwTWLBrSTolIxuA=;
        b=EOPi1f4PhNW8zMtICF44BKx0E45GpHOXt3JJtGhNl7RHwQaB777/tjHXv340DArSLW
         UOJ7aMsLn9ChCVVwbB4TipfuHXGETdPfw9J0qlGi09p795ccHwVFPUze0Q8hH0eRGbqa
         6IBTs0IGSyOE1s3izidQ6TnRNZpN4VO+YZKAfZzkcIveglXU19dQEnuOtDoYcfT2pnqW
         1C8UpPPYjT8SoDmaRrP/Yq9p8yLS5+HIkkhIRxAZ/xH3H8Qykc6fXhQgGa0cZMZZBSc9
         9HOCzwIaIfJxrNnFPnDbp6vdzKjpkxXpFB4u5tjB8HrAaewj79OxNT9fiQJgdE+AyFpn
         I1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TjYrkDsK6yPh84aPbosRJZw6roXrwTWLBrSTolIxuA=;
        b=2sRqZjXyLXc/7ndUi+i1LH1zY/Z8Nip9iDaX8tYWHZGUEVRdLSwKdQfyA4y2awYsSO
         jylrU22sC/AbdXoAdNyECHO7IRgi+H2XUjjXNq0MC1yBQ5Z33mgNxkHKF+KTihZKWoVP
         xHE95MBuWFP6Cq1PidHHireyuTTqjTm79ebtMcU4o8cU7q5QfqrVEqMbLLlrVmOozsud
         1N39O5ekRhdHYbBPRHgnzxUs3fMv9DyJ+lddfuD1a9IcFz7djztKQ7FUp/krRVOyFMyG
         LsT12e/nrcZ8w036j0GoXwwch/absdRK8zi8RushMtDGI7EoWPaJzWVGn5/iX9w+I3MT
         3TFg==
X-Gm-Message-State: AFqh2kpey0BHVFi741AicOEKK97QBKJ0LPV3y7yr4DQyns2YyNTBRgHs
        2d7az4kdMQL3/WbJYONiE+NfinuS7Ak7L5n1TlhxnQ==
X-Google-Smtp-Source: AMrXdXt7y5vMXZIG9DYJ+X2Yi72vbKoqU45iffpH2rKNAKrqtwPz8QtByBV3oMBVvAdRSJhA4f+cSzfB/zrvXXCz3F0=
X-Received: by 2002:a05:6512:250b:b0:4d4:fcdb:6376 with SMTP id
 be11-20020a056512250b00b004d4fcdb6376mr6074442lfb.218.1675068478212; Mon, 30
 Jan 2023 00:47:58 -0800 (PST)
MIME-Version: 1.0
References: <00000000000076699c05ed7c54a2@google.com> <00000000000091f75805f3627ddd@google.com>
In-Reply-To: <00000000000091f75805f3627ddd@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Jan 2023 09:47:45 +0100
Message-ID: <CACT4Y+bUreYncw=xFEf_qvrKJ8GKgzstv8BF8LBWTD=XOj_vXw@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in btrfs_commit_transaction
To:     syzbot <syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com>
Cc:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 29 Jan 2023 at 09:00, syzbot
<syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b740d806166979488e798e41743aaec051f2443f
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Nov 7 16:44:51 2022 +0000
>
>     btrfs: free btrfs_path before copying root refs to userspace
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e58bae480000
> start commit:   08ad43d554ba Merge tag 'net-6.1-rc7' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=52d708a0bca2efc4c9df
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114d3e03880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1320ea4b880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: free btrfs_path before copying root refs to userspace
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: btrfs: free btrfs_path before copying root refs to userspace
