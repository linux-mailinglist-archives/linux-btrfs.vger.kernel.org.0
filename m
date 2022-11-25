Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD5638F51
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 18:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKYRtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 12:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKYRtX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 12:49:23 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211162649E
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 09:49:22 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so3162962ila.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 09:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9uBU8s5VCIdHByMxtUe+OwrIeZYs1TZi9TU9WQnEtM=;
        b=Cb3+iwu4uzonI9wl1Hzy6YvT7jmdaIe+AGGyAY8n6cXavod/rlxLtzJ5IRLMSwx0l0
         pQiDuE/HrAxbTz5hnrgjEK645C63XVxpLyr4btEAL/hbktioo1wM369bLYESXHiJX7Jd
         Nd/l1QZ10F/8u7n/G7A7Nk61DI9wmv15/Uc0y86bM/MglFEcO4ZBaQCxUonF0/wxy1sZ
         7jFOPDIpvwraEgGFrHzg2kKJGzxQrP9xtMD0eFV2eGFAvHWEYUI44w/imT6TWUm4CTZk
         qgefi1N9rofXS8e2Tdx6N6tgg43jxQnkUq17gcYa65plvEJD/uhyglOp2igWMyQz0W1x
         phMg==
X-Gm-Message-State: ANoB5pl5P7tD/8iAV7k5O7561giNTH/NXYHOeJhXHR5Bd92RfSdOkz0Y
        WDz0Za1E96Omk3Gqp4n3sVl5bRJbJtLfAC6A/w66mh2xErnM
X-Google-Smtp-Source: AA0mqf5879qp50T0kHMWEYv22lu2q7SWnZD7I/9CRQlfvrei278pacvgl2mxtV/M2hSYf76qTZpZHfEh4L/Sbgr2P9/WkQ2+cwh3
MIME-Version: 1.0
X-Received: by 2002:a02:7122:0:b0:375:d16a:c9e9 with SMTP id
 n34-20020a027122000000b00375d16ac9e9mr18131069jac.75.1669398561510; Fri, 25
 Nov 2022 09:49:21 -0800 (PST)
Date:   Fri, 25 Nov 2022 09:49:21 -0800
In-Reply-To: <000000000000a9ccd705ee4865be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f5a8205ee4f2429@google.com>
Subject: Re: [syzbot] kernel BUG in clear_state_bit
From:   syzbot <syzbot+78dbea1c214b5413bdd3@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, jdelvare@suse.com,
        jiapeng.chong@linux.alibaba.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 4444a06981af66a49cf0cd08fec9759e8dd0a0fc
Author: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Date:   Thu Sep 1 02:23:32 2022 +0000

    hwmon: (emc2305) Remove unused including <linux/version.h>

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161ba58d880000
start commit:   c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=151ba58d880000
console output: https://syzkaller.appspot.com/x/log.txt?x=111ba58d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d9403880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a0d8e3880000

Reported-by: syzbot+78dbea1c214b5413bdd3@syzkaller.appspotmail.com
Fixes: 4444a06981af ("hwmon: (emc2305) Remove unused including <linux/version.h>")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
