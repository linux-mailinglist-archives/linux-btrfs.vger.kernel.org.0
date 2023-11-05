Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8664C7E142F
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Nov 2023 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKEQBV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEQBU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 11:01:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322AC5;
        Sun,  5 Nov 2023 08:01:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD48BC433C7;
        Sun,  5 Nov 2023 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699200077;
        bh=Y/QGvldsfFeVsm2Z294hSS1CZkKLOo8YmVstYw2sTas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fJyV+lP+JyNfCqDhjQj+PoyTO9m7OKlPTh4uMKsgiJZlDXEZCmDLqwMhPujARm45P
         S8tiixlGitJkHbHUYJv+IS7vCrbdvc1LQmpxeGuI5Gnehq52E52ImsvscSt6p9q+Or
         wktJX5r/LhDKfqqb2+gKgV+OLNK7+TTrFpPjMUko43aHMEapL6avOP8wSKAm9PI78+
         dd4yfHCguC0NfEbC7n0H61rP0iJmbIUs9SV8VqX/sEakuYNx6G30hwigBkk7Lnu+hg
         aP05onphmgGZs1YfJ/+v6d/u1dzgKTNdm8rZzVRUMCPwWHz29LTpFmUUWXy9fcHcn+
         IO6sYJj3HINwg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-54366784377so5952613a12.3;
        Sun, 05 Nov 2023 08:01:17 -0800 (PST)
X-Gm-Message-State: AOJu0Yzeobn/0koBy536CmOBer5WeaMSbqLVKDAmj89R/huqTyGPHEUg
        CoR1wAKC9QCGubIN73zqoB/4ebwkS+ljvN7gduo=
X-Google-Smtp-Source: AGHT+IHRFck0v4TI/RrO/JF0loFnJ7/GPYUUQb85Fh6C/HGpOWDU+A1qDvFTH9poYCn+NVRZw8yyA/xh99BhqKNynU0=
X-Received: by 2002:a17:907:5c4:b0:9d3:f436:61e5 with SMTP id
 wg4-20020a17090705c400b009d3f43661e5mr10811939ejb.29.1699200076401; Sun, 05
 Nov 2023 08:01:16 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a6429e0609331930@google.com> <0000000000001222c4060963af3a@google.com>
In-Reply-To: <0000000000001222c4060963af3a@google.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sun, 5 Nov 2023 16:00:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Ah2U8aR+fPPxLAb7BcHF6qk9JgZhiQYGcQupHvDNuOQ@mail.gmail.com>
Message-ID: <CAL3q7H6Ah2U8aR+fPPxLAb7BcHF6qk9JgZhiQYGcQupHvDNuOQ@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_qgroup_account_extent
To:     syzbot <syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 5, 2023 at 8:40=E2=80=AFAM syzbot
<syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit dce28769a33a95425b007f00842d6e12ffa28f83
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Sat Sep 2 00:13:57 2023 +0000
>
>     btrfs: qgroup: use qgroup_iterator_nested to in qgroup_update_refcnt(=
)
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14f0171768=
0000
> start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kern=
e..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16f0171768=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12f0171768000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4cc8c92209246=
4e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De0b615318f8fcfc=
01ceb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14cae708e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1354647b68000=
0
>
> Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com
> Fixes: dce28769a33a ("btrfs: qgroup: use qgroup_iterator_nested to in qgr=
oup_update_refcnt()")

#syz fix: btrfs: fix race between accounting qgroup extents and
removing a qgroup

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
