Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B848FF00B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfKEPFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 10:05:06 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45924 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbfKEPFF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Nov 2019 10:05:05 -0500
Received: by mail-pl1-f169.google.com with SMTP id y24so9558795plr.12
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Nov 2019 07:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TO94ReUB2LKMFziJRhpU5UgTS/asrjj1UXl1wuAEKU4=;
        b=pI8RymBJz9jzpLpMFcB403IrHRpcmoYH/e6DIlHSwk1wf7GU//tvdOfurl8GkGrf58
         2ur9M37NSRZxOciy1tmzGs1LlyBBbATLCZLcHZy5mi6ZdausU706cTJ7GmpisFedi+Kd
         iBvjZdWSK7KPcmK/DCyL5McKo6U1WxJsowE1ixOZ97urxRn2NzpD4UMPU9Xi0VheuWNX
         pVs31HsvbVtu3LkepL2oMgyHjQFuuowIPRK1HCaAuPr0LU0WmdKCiurr5O6i8O/psZqa
         SkVclAfUitqr0QYAji9o1XBvxpxT5ctNLZGWRqrmuCSmy6aWIebMeEyi0wXqZ8x7RMR6
         l8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TO94ReUB2LKMFziJRhpU5UgTS/asrjj1UXl1wuAEKU4=;
        b=d6jlZGI0CAkwexvzZhS09zDEdvKXoe/aA9PblaAn7k90LSYPSfnt07p1i5flyFiWzV
         vugVGCX0h+bRvbkbkn4dKb/kqbVZr7Dy4oJp2W3NsCQEkAtUJ8KcBeweqpLw/MLv0Ilk
         mWa2PLi8jXelq69hB0egfvCbTgrZHmfa8j0S0SDb3TqBAqxgGbwC19OUbeCUQ6EdeQQl
         9U1TOJOQWjHS55ubZvt1QAAIGHZ3HfxjtpJdNHX5ZUASOLF/nnxqqRQzyHliEeMHd9mf
         pI5hwhfIT3BkQykflc/C94ibq3yK1tK55Veaf4TPMxFDBU7f3xDRfvnREwrNJFUF96Ii
         K8BA==
X-Gm-Message-State: APjAAAXvtYP6ZLTdxqS3NEHf0EYEdBMACgniChsQE9mNSmRCPfAXTh1k
        wQNzILh1uoQMzlUpa9w48Pesv5M9YlXeHQ3hVnrJ+RE1SJqeSQ==
X-Google-Smtp-Source: APXvYqxa6yvjEuJEFOq+MPeDWlLZHBUPquDi8KKjRirPXyXuJUAS6/PhSkNs1idscgN+ryEK55ZuUjf9HcCC7hMWcqo=
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr33103pln.280.1572966304558;
 Tue, 05 Nov 2019 07:05:04 -0800 (PST)
MIME-Version: 1.0
From:   Sergiu Cozma <lssjbrolli@gmail.com>
Date:   Tue, 5 Nov 2019 17:04:28 +0200
Message-ID: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
Subject: fix for ERROR: cannot read chunk root
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hi, i need some help to recover a btrfs partition
i use btrfs-progs v5.3.1

btrfs rescue super-recover https://pastebin.com/mGEp6vjV
btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa

can't mount the partition with
BTRFS error (device sdb4): bad tree block start, want 856119312384 have 0
[ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
[ 2295.301067] BTRFS error (device sdb4): open_ctree failed
