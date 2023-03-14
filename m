Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C426B9028
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 11:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCNKgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCNKfm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 06:35:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C9697FF2
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 03:35:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z42so15444673ljq.13
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678790103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JuELhTJwIN/BuNgCW2HSGunJAg926V+YaVufQMF0Gg=;
        b=ZFxPezWpR621MrKtyfgGxDJNidswYVpeY8UYgp4mL6AEFx9z1GrZ9imF9YQLoBBe8z
         K//TkC/88GrwcomawGWgguWYhzKZZ6XurcovHypOJW5HkWWPw6gD13C8xwcv3mHCzAEa
         gPE6kMDfgYTCfL0jLf3Gj+nzE5LCpd9upa5ryPxETPp3DKDbzhCE3mJS4uMLJLsRUZbH
         3zoGNWehF285X/zN5TUgYiWKtCQT+iLAoJdU0gQgFWPC04sL684OPsn2/9LVIgOUCU5S
         G0NZKN+rHgC/5HMCxLt/vDubJZXF2XUV4VceaIgNftYpdC9SwTjPeQ1vnzT/1htQ1nqf
         0WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678790103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JuELhTJwIN/BuNgCW2HSGunJAg926V+YaVufQMF0Gg=;
        b=V5rX2NIJz9kgBLEw9iQ2NElK2dIvtEzne8HYmRpNnSC1Z+FU8c0zYdRQXwk7Mm6Gu+
         pxJI5xa4BrFXI+HACaFBWfbSuzAmlbYi7M9gAIYGmGqyDo/mNcJ7+8GExi9WlkWXswT6
         +77lMyZCjoBMKyEuhFWD/wzuc1rBpI1RpKoTlz32f/2jEpBqhEjI8Czi1gsR8ufYzOsz
         WjKJhhZ2GPwK+beCywO6UBRYklo60JRswjspFpsXaLzXb2uho55OV1NIArD2w83WeRQ5
         kGlS8KLYIO5jtUXsE2U2EmKqY6St3N0aLX2UvhWfm5amhHkXHKVSLDoDmzOOPtt39cSz
         2I6Q==
X-Gm-Message-State: AO0yUKVcFXANmYxUmmCYBixvtry+mP2EZIOSAJIs0pfMrcRA8vC3RtAP
        4dba6dA0NEJ25P+sO+pBGV79cjOsB0xJ/nljh8sV5w==
X-Google-Smtp-Source: AK7set+nVNpCp2TWhO7HP43nyyaH5wdvrBirwmLwcQrqyn7orb2IeZEwTFAOHCCfYyoJn2y1TsWXi83gfC+mzVSChME=
X-Received: by 2002:a2e:b90d:0:b0:298:7034:836e with SMTP id
 b13-20020a2eb90d000000b002987034836emr6666498ljb.8.1678790102864; Tue, 14 Mar
 2023 03:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c06c405eb318db4@google.com> <000000000000a5202905f6765872@google.com>
In-Reply-To: <000000000000a5202905f6765872@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Mar 2023 11:34:50 +0100
Message-ID: <CACT4Y+YiLoseRKwZBzM6AbR0x=TBV348CkLUGcckrd04QxRjTg@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_run_delayed_refs
To:     syzbot <syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 9 Mar 2023 at 12:57, syzbot
<syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
> Author: David Sterba <dsterba@suse.com>
> Date:   Thu Nov 3 13:39:01 2022 +0000
>
>     btrfs: don't print stack trace when transaction is aborted due to ENOMEM
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1541ad14c80000
> start commit:   98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebdb2403435c4136db2b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4d8ea880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13172832880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix:
btrfs: don't print stack trace when transaction is aborted due to ENOMEM
