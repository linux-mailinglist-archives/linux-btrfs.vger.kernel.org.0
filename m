Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07659123E7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 05:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLREYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 23:24:24 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42624 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfLREYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 23:24:24 -0500
Received: by mail-yw1-f68.google.com with SMTP id x138so306798ywd.9
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 20:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:subject:date:mime-version
         :content-transfer-encoding;
        bh=lRp1uZzAcgESnrszNq9wvM4YgfSecdgZCPNIt3qs+14=;
        b=GhI77sMFrKsHaIbnzCFNpZC4nIEovQyWjdtQYA0WaZohEWkHP7SBPX0k+n/RoPgPgq
         eFUJfc5UD/2K0MP9+f0VyEM0eDVTwoMRPQ31VzHUsCrsNgdFtm1/2ngpPQ4br/T8vjfV
         bF29zitMrOwGoVAQuXsrn060/uCcEqAJvZgO3TEpO8l/Sly6hvphh7wyDBpFsTI1x2sM
         xts2niypuCFevlks790hHyMFJHvo8M1mEQeE92QfGeVS3w7rF3eVhRNi2XHkJ/GColxx
         4WDh635hoAueCTcWiJpLoOQtUnaFgW80m5Vo2V9C6O9ki/n3ZpWk4xFmQIr822yaoNr2
         s7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:subject:date:mime-version
         :content-transfer-encoding;
        bh=lRp1uZzAcgESnrszNq9wvM4YgfSecdgZCPNIt3qs+14=;
        b=rcbDCqd4hvLMndlRmNgkUFb9gRZTXk004kngs2xP7KYe3betQmSJj2ojzRHVv7nApd
         ON+wOhiXGuBhAtMdZ7curmwMz/1w1UuNrj8Cwg1fbD0P3HGjwPR8y8LO3c4w2KTo7lY0
         ORT08pGO68OXmRTPW0UmEkPdZZ30ROzCAr6MkEo1my0XLcfrVvGaYGL0LMuseAmlwgex
         jouTpKktDf8F6xaWchRwMsgCfzl1H4Cmj0pzXXBKh7PLIKv7ctTzjKTB4OPvCR/FeI19
         /I4zCRoCfjVNWuJRCdhdY1TxaPWxhCGv1OwcfAkjDTUDFmP7zt9FvvV5NkwKETN2MIlg
         6A7g==
X-Gm-Message-State: APjAAAWwQfd36bVx9WA+zCBILJuq5Lv8ER6EV06fkig2aIUeXuFSTZC+
        ihbJQv+jxaHxo83vnTyqkScSHRHM
X-Google-Smtp-Source: APXvYqzYLh+TmZNfRBTEeNmkVsC/+A3mVNrqikOdGWwmYm3KzqRae0s8jx3e1fIE7X36GviC6numgg==
X-Received: by 2002:a0d:d84b:: with SMTP id a72mr494269ywe.33.1576643062795;
        Tue, 17 Dec 2019 20:24:22 -0800 (PST)
Received: from [0.0.0.0] (184-169-119-27-dynamic.midco.net. [184.169.119.27])
        by smtp.gmail.com with ESMTPSA id 205sm478680ywm.17.2019.12.17.20.24.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 20:24:22 -0800 (PST)
Message-ID: <20191218.042312.688.36@[0.0.0.0]>
From:   "Rob" <captinlogic@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Filesystem Degrades to read Only
Date:   Tue, 17 Dec 2019 22:23:12 -0600
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: POP Peeper Pro (4.5.3.0)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel: 4.19.0
btrfs-progs: 4.20.1
Attempts to write data to the filesystem end up with the system being =
degraded to read only.
dmesg shows this:
[14544.006701] BTRFS: error (device sdi) in __btrfs_free_extent:6800: =
errno=3D-2 No such entry
[14544.006703] BTRFS info (device sdi): forced readonly
[14544.006706] BTRFS: error (device sdi) in btrfs_run_delayed_refs:2935: =
errno=3D-2 No such entry
[14544.726934] BTRFS warning (device sdi): Skipping commit of aborted =
transaction.
Ran a btrfs check:
[2/7] checking extents
ref mismatch on [18366485364736 16384] extent item 1, found 0
backref 18366485364736 root 2 not referenced back 0x56417a8551f0
incorrect global backref count on 18366485364736 found 1 wanted 0
backpointer mismatch on [18366485364736 16384]
owner ref check failed [18366485364736 16384]
ref mismatch on [18366487035904 16384] extent item 0, found 1
tree backref 18366487035904 parent 2 root 2 not found in extent tree
backpointer mismatch on [18366487035904 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
Should I run a btrfs check repair on the system?
