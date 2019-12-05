Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85F9113F0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 11:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfLEKHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 05:07:47 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48188 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfLEKHk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 05:07:40 -0500
Received: by mail-il1-f199.google.com with SMTP id 4so2082353ill.15
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 02:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=SxP9GrkPfQQC4tDhCGJt1wlHuE/aRaP5RHSRZ+Ckw+Q=;
        b=dXqYaFRBgcREP0keCbTvS4++/bxwB/qeyg3FIfvTeayn91RnEtBqAO+MQsRQ7NO6ah
         IvU+oNYl+xxkAHcV3zHK380emXoIlt0FoYbZA9EINiYlk6BK4I3mCpToOhvRM236jWtL
         2Ex2LasJmoYpf5vP9LkzEacYq4iShRVJDulH5UI3+xDwn+J1A55YqzPvEl26vFYU7nfJ
         Y76pe7JPN/VKiL7oSOUmx8sRAxUDVptf/0Yob35Cmc+1vM96h+cxWajx+vcxVFPPlzkC
         HBHn9/BVlkpsPiZ218Cgu/wlfZBT1xFIUXVHuINTbht/GK1erwzAHaYs4OTkZtF8lcUs
         jySg==
X-Gm-Message-State: APjAAAUCoFVTF29EfKDhK7qlRkirpGgSHLS3QwKKGZPhzuOSCCQ8Dv17
        9qGgUMmgB1+yZhswyFrUYiBz5WL5jtR49xvvdQ2Y7xyuD1if
X-Google-Smtp-Source: APXvYqyI0qiEIM2Xg+vWurMbSY2pp8AxImwYfz7h/RUYZn94hy0xxFNRpq6QdrU6UoN+iXtZFAJMNmZkUHXbis3elivcxLBHsTXK
MIME-Version: 1.0
X-Received: by 2002:a92:d84d:: with SMTP id h13mr7691097ilq.180.1575540459510;
 Thu, 05 Dec 2019 02:07:39 -0800 (PST)
Date:   Thu, 05 Dec 2019 02:07:39 -0800
In-Reply-To: <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b266b0598f2196c@google.com>
Subject: Re: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
From:   syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     clm@fb.com, dsterba@suse.com, dvyukov@google.com, jth@kernel.org,
        jthumshirn@suse.de, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On Thu, Dec 5, 2019 at 11:00 AM Johannes Thumshirn <jthumshirn@suse.de>  
> wrote:

>> On Wed, Dec 04, 2019 at 03:59:01PM +0100, Johannes Thumshirn wrote:
>> > #syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
>> > close_fs_devices

>> Ok this doesn't look like it worked, let's retry w/o line wrapping

>> #syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git  
>> close_fs_devices

> The correct syntax would be (no dash + colon):

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git

This crash does not have a reproducer. I cannot test it.

> close_fs_devices
