Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D986766AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjAUOPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Jan 2023 09:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAUOPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Jan 2023 09:15:23 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EFB23C4F
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 06:15:23 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h4-20020a056e021b8400b0030d901a84d9so5526131ili.6
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 06:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paJY5nhHrdYdemiU8agJkBG59qRoizHAx2XPFGFJG/g=;
        b=gJs8qJoUrYtiv3nRBeY+02jkE2ScD+CPVAk8uFqTcA7eN745NX1aWPVbpEJDU1szlM
         ryXDy76DogAJOXwAZOy6sStTG2tbrl+zOV2i+j4/FRYf0NIYN5NPNzTavU+2m7E7jygC
         v0rViSLjUXWaSHUAXGE+dHvbiaHgZLHq//3VCAAOyGIGs3QVvgoqQcoqrZ/LP7vySuHK
         kzsEZvjLK4xM8XSBO4dI2HFd+BYXjW/+cUMzN55jiI2yVjZWNeVP6uiMW+xsNIlaWH7l
         xlL8kFssCYVFPfExNZV0RKt+fEzWQHZS8CRKcZ6fjzYLEw1/CrUhGBs4UlKy03VYPtzX
         TAoQ==
X-Gm-Message-State: AFqh2kqJ+SZlix+fnEUgj+M+XitFFWrzO2cf/9F16kxBPOeaiSYcT3u3
        7QJOiyovDB03PmPXov8QT5bv2zd4Q8W5mlEY3vLEMT/E681r
X-Google-Smtp-Source: AMrXdXsOptkks9oF5mPbDx3wVtM1LQyCev+C9tBVMdnZ2thSXc/7ucopJ3J2Rb4WccqUJ8wKsxKwPl2PjeBVtlYFZRPkzmxenTn/
MIME-Version: 1.0
X-Received: by 2002:a92:bf0b:0:b0:30e:fab6:3561 with SMTP id
 z11-20020a92bf0b000000b0030efab63561mr1279963ilh.48.1674310522426; Sat, 21
 Jan 2023 06:15:22 -0800 (PST)
Date:   Sat, 21 Jan 2023 06:15:22 -0800
In-Reply-To: <0000000000000e082305eec34072@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eedc4705f2c6cba6@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in set_state_bits
From:   syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
To:     clm@fb.com, djwong@kernel.org, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 05fd9564e9faf0f23b4676385e27d9405cef6637
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Mon Mar 14 17:55:32 2022 +0000

    btrfs: fix fallocate to use file_modified to update permissions consistently

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17db2ab6480000
start commit:   296a7b7eb792 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=143b2ab6480000
console output: https://syzkaller.appspot.com/x/log.txt?x=103b2ab6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf421741552bc3
dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ec2ab7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dc4613880000

Reported-by: syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com
Fixes: 05fd9564e9fa ("btrfs: fix fallocate to use file_modified to update permissions consistently")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
