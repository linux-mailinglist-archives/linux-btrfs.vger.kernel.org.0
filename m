Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8916442F9BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbhJORL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhJORL5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 13:11:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B66C061570
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 10:09:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n8so44234723lfk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=AdC+HYXPAt1MtXQg1u7VfCXfu9OkJltt3XzWDaSaSv0=;
        b=digvj+JVslQ5pKDxrgCz4WCXTtu6jDMYu/hvSh/efYFe7gWKzuDIxv5Rl7w8G2IR3f
         1E8hYNWKq6q7okjguud6j+4zgqpFc2vlR7dAKWwEhEy9G2gLt3flSJeZMrSvJPrbeaeK
         41likJZykaw3q5Z6a2EJS6DnvJe/bPf3awbg5rrCpu653FHVYcFJaO0sqaKqBToi8iRc
         2bc7MoPqVuvAlQIzjuzw7fxNZjxaT6gu0zhSj+4uJCoZiNzZboZUYmOPiR/wQ4rJT0S0
         NAfY2J/T241DlqNOYIhvIyahHChSRtkRjQXfOpJeiG7TmdfTZYzII78LnWDBa6pV8u9e
         Fz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AdC+HYXPAt1MtXQg1u7VfCXfu9OkJltt3XzWDaSaSv0=;
        b=0rawaFdnX0DtEDtqr41Gq4ZcG66+igQa0vsGhRdXixarxklhUEiayXGOCWafRqc0/g
         jjytdPFeD7J4kknh/Zb4sfLjP+oqOlzlXiB19y2Z/aR13eENYaBSQOvPq/7MvvBq09oZ
         Y5vblxlbM5H9AhNLCRYBB+qzRIGUeG7r6ARyji6eTG8afZVV68U6gLa+DtcX4++RtYaE
         WGugjpOLjS/kLknSOHXanUYFaHG5dg8miP4UxAH+0TzXtLlkqAVc1isUb8u17iRmT/vY
         HXAokuZt6N4/bNi5zElycxGbaqZtqLjM9bvoQDbN6OXznXa8kqQ6Ps22dSH1KHeBsdnn
         EDPQ==
X-Gm-Message-State: AOAM532opN2cy48t1rDzDPOu94lEhJnvMGwbZt+1xRRftSVoua+hbHgz
        pkz5CtBs2V5Wp+PJHibLD2hbhPSU7dIpZlUSVAKUs1MM
X-Google-Smtp-Source: ABdhPJwpBgPidPPoamLi4hILzx2KrPWc/1RsBWX8E/sOdWA2pEuKs3j164ShWED1sH3zqGDEbSWPTv1LAX9mRgeMH0c=
X-Received: by 2002:ac2:59ce:: with SMTP id x14mr12424935lfn.522.1634317788312;
 Fri, 15 Oct 2021 10:09:48 -0700 (PDT)
MIME-Version: 1.0
From:   Jim Davis <jim.epost@gmail.com>
Date:   Fri, 15 Oct 2021 10:09:37 -0700
Message-ID: <CA+r1ZhgCPB0JYyfC=pRK3mP0_xXGfTW9YpYV0RtYZ_pDMdYCOg@mail.gmail.com>
Subject: Ubuntu 21.10, raid1c3, and grub
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been trying some experiments with raid1c3 on a qemu virtual
machine running Ubuntu 21.10.  Choosing btrfs initially as the root
file system during installation works just fine.

Adding a new virtual disk to btrfs root file system and running btrfs
balance with -mconvert=raid1 and -dconvert=raid1 works too -- the vm
reboots with no problems.

Adding another new virtual disk to btrfs root file system and running
btrfs balance again, with -mconvert=raid1c3 and -dconvert=raid1c3 and
then rebooting doesn't work: the vm drops into grub rescue with a
cryptic

error: unsupported RAID flags 202

message.  Any ideas?

-- 
Jim
