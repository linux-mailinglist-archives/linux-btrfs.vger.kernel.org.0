Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6666B55
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfGLLFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 07:05:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33401 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGLLFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 07:05:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so9001001wme.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2019 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=akTt68d8/uxGGWF8Wq2eNnsChSZE20zzCayZZbzhVgA=;
        b=aLTZXVNbOHZMYeQdsVvKyE18eLWwc/wsTDcdwdnSdARBZ7KMHMscF0Fo2sqtn9st76
         RVBSnIV7PmeuKtTiuVWDw1uk74mTp5YGI6hM+1jAlvd6xpYVRiGdObd2jpVZME51sgL5
         SYIiDbZYJoszuCLDPHGbure1zVnJoqOPWtNUd8OdNuxKc8/85reVjE+iao3DlCyd1Ijx
         BoYQ2SX3lQskLSqZM4vQy0KTisewGxozqF8Gz/V/IIc5dWgbkaOulTCpe+fIFr38lwSN
         kZw0waM/Pq1UMn6flHuOqKmuIFX7abVvb0HyF3f1BAREYkoWBnolMTPErJ5rfsbC3uyo
         fMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=akTt68d8/uxGGWF8Wq2eNnsChSZE20zzCayZZbzhVgA=;
        b=KeWdy/0WUGQdw2hTpqMGocbLbkKMUZ2TFpcJKq5PGeaSmw/bLr7fLw9aBCwV4zEAIJ
         JK8t60UlVTuuFLg1P2pofWvszTDk1tKAaV1GwzAtlDA2Zgz71/um2Nx/OY9mt8dKoGkJ
         MlJT7b0N6xFprRzG/P4oaaO3u8n5xNdVzcZyX6gqNBNFqMnuvYnW/ruf2r/5TDpALxq/
         FuZhtT7SgjC6bjd8FUCkk1xupQ4amfabCU5mDv0QXG8zv8HIyJ3Z/dc9wV3Iaj6iENmO
         GHszJEINNs8fVvRYpXIqPodXrzRNdSZuFB9w+3aOEwTc2X9D55A7LgA9BvYZye08rhQF
         kI8g==
X-Gm-Message-State: APjAAAWdD5xBeL8wIus8bL5nrUTNq/SexZotvQnkJ/7uAz3bJSkZcP6n
        i9YWOVSjX4gJnZwmHoIb5sqoPq0KLRyrl/iTFtUzNx06Abb7EzuC
X-Google-Smtp-Source: APXvYqz/1z6UdSv5UfC3jJvUDJodbAb0Yysj6LzK0cilBkpHo1mHkHTwan6bF9zT07i8V3WzcKI+xxugpX+0W3iIWN8=
X-Received: by 2002:a1c:751a:: with SMTP id o26mr9271461wmc.13.1562929531187;
 Fri, 12 Jul 2019 04:05:31 -0700 (PDT)
MIME-Version: 1.0
From:   mangoblues@gmail.com
Date:   Fri, 12 Jul 2019 13:05:21 +0200
Message-ID: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>
Subject: [BUG] Kernel 5.2: mount fails with can't read superblock on /dev/sdb1
 (kernel 5.1.16 and 4.19 is fine)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

After updating to kernel 5.2 (archlinux):  2 out of my 7 btrfs drives
fail to mount on boot.

Error: can't read superblock on /dev/sdb1 and /dev/sdc1.

Going back to kernel 5.1.16 (and 4.19 also) fixes the problem. Btrfsck
reports the 2 drives are OK.

What can I do to fix this ?

Thanks.

$ btrfs fi show

Label: 'disk3'  uuid: 37d68257-a2bf-44e4-82e6-7bda35d3af3c
        Total devices 1 FS bytes used 1.77TiB
        devid    1 size 1.82TiB used 1.82TiB path /dev/sdb1

Label: 'disk4'  uuid: 8b72d7bd-603c-41c0-a395-a763ffe0de8b
        Total devices 1 FS bytes used 2.67TiB
        devid    1 size 2.73TiB used 2.73TiB path /dev/sdc1

Label: 'disk5'  uuid: 1728d60b-bdf2-4baa-8372-de7014d85e1d
        Total devices 1 FS bytes used 3.59TiB
        devid    1 size 3.64TiB used 3.64TiB path /dev/sdg1

Label: 'disk7'  uuid: 5e9437b5-bf53-4135-8b25-52539cfc491e
        Total devices 1 FS bytes used 6.66TiB
        devid    1 size 7.28TiB used 7.23TiB path /dev/sde1

Label: 'disk6'  uuid: ce325155-0922-4c62-9f5d-70cbc1726b5c
        Total devices 1 FS bytes used 3.47TiB
        devid    1 size 3.64TiB used 3.63TiB path /dev/sdd1

Label: 'disk1'  uuid: b9c65214-b1dc-4a97-b798-dc9639177880
        Total devices 1 FS bytes used 3.31TiB
        devid    1 size 3.64TiB used 3.62TiB path /dev/sdh1

Label: 'disk2'  uuid: d77e4116-de32-4ff4-938c-9c6eea6cdd42
        Total devices 1 FS bytes used 6.83TiB
        devid    1 size 7.28TiB used 7.26TiB path /dev/sdf1
