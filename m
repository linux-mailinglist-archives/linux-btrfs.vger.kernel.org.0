Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B9376CFDC
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjHBORm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjHBORl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 10:17:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D94272A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 07:17:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so54495e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690985855; x=1691590655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qwGbFPriiBctUTIf5EIt3Ji/aXV3Kuo6I3x1a+UHFM=;
        b=BG89yUNHMkxHF810dZQ2ZbAQDhv1zP8ZVtcAC67c+E/BGxxEfwn4+7QZVaZ2IEU3oA
         dRKokiLUubYgxTgf4Sn1wNsYw6fAD9khqzHlOtRG2LwfWMY+ycelPCDRCbw0mSP+JyLb
         +VOuz9juHYmbJwonRj+vuJwSQ9D/wf5YwXOUWYqZpNjbZxReeLdfs9GRzI59kYWZ/+Zw
         cbc1l3DsrC8fivpFjwhMETPUzPXDKc+Cr3V7cDVhiU64ItLEoj+QCp5Yw6HLZRuCwzAl
         gUXlCMjT+E7TpoT+C3mCINReshqlHXrs+Ui1zIP9CUJLu+27QClyR9Fk0PT8FjGosHSO
         uDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985855; x=1691590655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qwGbFPriiBctUTIf5EIt3Ji/aXV3Kuo6I3x1a+UHFM=;
        b=ccFahtrjNaWLLc5E+q7GvN7f8kxbA6W81BaAqw0WZJd3oX8lc/crYzRAkH0DIAvCLW
         AfZphWic7Y7aViQiigkC4n6ibnAB5S74A5gycvdAfS4k/VNRK+OsOzM57kC7B5LQw10o
         O9l0c5eAIAaolpVSzBhPj65oGUPW8HNaEeMC2eabZV7fZ4jFBOCTHnaYPUo0f+jlryVK
         u0F3afeu+xK4WT8K33qwV4uN0NA2SAvAfjIM9dbzUSSw5rG4oaNDgBFTF2d1ao0cFuhj
         QnpGfh/Ot20RK848DXinSFNrGtrgMI1G/LoSDl7azA7jrDqxp27zFdT3urDZmBKr5Z9r
         ezPg==
X-Gm-Message-State: ABy/qLZkuEkZiKAffFMztdMM1w4mqd1hyhbR6UZH5dTT5z510SbGEPJ+
        TNzlyyS1XrQpM4LIwAEgv5bT3sEOvLJZexmK3pZLYw==
X-Google-Smtp-Source: APBJJlFryeNX8uWaYtlPyiRZrYLoVMke66TACyC12BOcmdmUSt10i7iCuVQR7UWUxyqxD4dPSdQ7ot33jqSSw8snvwg=
X-Received: by 2002:a05:600c:3415:b0:3f7:e463:a0d6 with SMTP id
 y21-20020a05600c341500b003f7e463a0d6mr380986wmp.0.1690985854925; Wed, 02 Aug
 2023 07:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fd151d05ece59b42@google.com> <000000000000261e660601dec2c2@google.com>
In-Reply-To: <000000000000261e660601dec2c2@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 2 Aug 2023 16:17:22 +0200
Message-ID: <CANp29Y5DKbC0oCcxoX-fST0LQ8=0KZ-RK-GXL=2Vw=3y++wtOw@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_search_slot
To:     syzbot <syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com>
Cc:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 1, 2023 at 6:08=E2=80=AFPM syzbot
<syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b740d806166979488e798e41743aaec051f2443f
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Nov 7 16:44:51 2022 +0000
>
>     btrfs: free btrfs_path before copying root refs to userspace
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13015709a8=
0000
> start commit:   eb7081409f94 Linux 6.1-rc6
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8d01b6e319797=
4dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc06034aecf9f5ea=
b1ac1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D124fc309880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D126dfde588000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: btrfs: free btrfs_path before copying root refs to userspace

Looks reasonable.
#syz fix: btrfs: free btrfs_path before copying root refs to userspace

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
