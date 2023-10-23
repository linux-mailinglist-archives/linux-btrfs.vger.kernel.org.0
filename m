Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4CE7D3812
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjJWNae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjJWNac (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 09:30:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A18210B
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 06:30:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso306195ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698067829; x=1698672629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRJoIZwads+nO8MENW8StdsOtBrARPpfCP3zhmQYmss=;
        b=A1P0mZ0iKLYsXN7+xwGMtF4TFQjWE2OcfjWz4yedv+F89mZknFVJTVMZTJJ0/wKlfO
         B2DMwdp4zIyDBtX7HC02OT0m6E4KnHX4943gZ1kxoDnCmQhlW3dgmxtCxrEFLcRkiYkO
         UV72j/aJG3TCyei4pEjf4Bu8+Y+8bOfd6V9LWjbGqfIGnDIgM7pW9vubNtf3rVCTzJ82
         HWj7+YVhjM1ZTwsS8E8uHvlMDGRVKnNE3Q7oCfZi/4aIKNSl1ClGBBPmTRR6cHdivmWt
         CtUE731knUhwI06HPk1MMbEtHm+9ruFljLoMmb1gHE+7AlktWPfuADB4ny9bTibop7nQ
         Drrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698067829; x=1698672629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRJoIZwads+nO8MENW8StdsOtBrARPpfCP3zhmQYmss=;
        b=VPjnO1x14tIB4c7hJHZ/x0ljv/dyFvraAE7ER/iXAlMhMW+/CkZc6VbKWjmRZk3L+R
         E2iYeFMEw0BmUU3J2pSACzw6F63TeyEaA8T5t3C/O1SmPpThQBJ32p+2SfyT6Z+KL6r7
         xnKab6UwDk/nKd4mbd4nkxkMJMRtl0JnfTyQe74+L3gBFUTayhntfk429XX25FB9Ksvb
         dmZ100L6cZ7rQQ82DOHdpRTxWCfXEonR+B2+KM+ym0FuAO0WuFXN05qtUpB99BLFGB7z
         ITvAPNYUgkmwenveooVXuQm+9JJfiYuAx/XKAKZiRDu00n8GgixjzrigwQc3Npg9BRUw
         vYJA==
X-Gm-Message-State: AOJu0YxdkbF5C2xxOlrNDipLJe14mZZw9rlm49nu58Jxt1VVu5eKKlH2
        4NKQ/99aqAC6Pi1m4p78qpt2FfgWClghYzVmFN46FQ==
X-Google-Smtp-Source: AGHT+IESETBifZ4eSnvOE1cPciShA0cCrQKjMCMyn1hOOR1b3j7Kn4EcGIyWkQnjhcU9/NScE5h0KW2KUsh0yiwRNNw=
X-Received: by 2002:a17:902:ab5c:b0:1c9:e48c:726d with SMTP id
 ij28-20020a170902ab5c00b001c9e48c726dmr573411plb.4.1698067828483; Mon, 23 Oct
 2023 06:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d005440608450810@google.com> <20231023130830.GG26353@twin.jikos.cz>
In-Reply-To: <20231023130830.GG26353@twin.jikos.cz>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 23 Oct 2023 15:30:16 +0200
Message-ID: <CANp29Y4VNqAX0oPiGy557ubwQKjhWVbwjT7xdCBGLricJPJ5Yg@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (4)
To:     dsterba@suse.cz
Cc:     syzbot <syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,PLING_QUERY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 23, 2023 at 3:15=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Sat, Oct 21, 2023 at 07:40:53PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kern=
elci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1557da89680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df27cd6e6891=
1e026
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db2869947e0c94=
67a41b6
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D137ac45d6=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16e4640b680=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/bd512de820ae/d=
isk-78124b0c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a47a437b1d4f/vmli=
nux-78124b0c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3ae8b966bcd7=
/Image-78124b0c.gz.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/d5d51449=
5f15/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com
> >
> > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>
> #syz invalid
>
> This is a frequent warning, can be worked around by increasing
> CONFIG_LOCKDEP_CHAINS_BITS in config (18 could be a good value but may
> still not be enough).

By invalidating a frequently occurring issue we only cause syzbot to
report it once again, so it's better to keep the report open until the
root cause is resolved. There'll likely be a report (5) soon.

We keep CONFIG_LOCKDEP_CHAINS_BITS at 16 for arm64 because (at least
in 2022) the kernel used not to boot on GCE arm64 VMs with
CONFIG_LOCKDEP_CHAINS_BITS=3D18. Maybe it's time to try it once more.

--=20
Aleksandr
