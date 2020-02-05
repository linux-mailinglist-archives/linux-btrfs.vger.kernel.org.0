Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317B615367B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 18:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgBERaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 12:30:22 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:44164 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBERaW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 12:30:22 -0500
Received: by mail-io1-f42.google.com with SMTP id z16so3011609iod.11
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2020 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/2VtFM99rBJ4F25aTyuRHSIAtqEfcsV0ozhPb5k4ZUU=;
        b=C1/e19G9YE1iLZNoMX85emwkcPcJtrE/zAL+6NsQdZjmCDymgjXiP5jajoySPEU2HV
         UNEHGU03siKmFjSxBvzZWuwM5WQBcAuhQ6pJNg+57JoghFwgAgScJvEeedu5vDds0NmT
         w3wKnGDUc6SV/V33lGxAsyWJ2Jp5kaeKwwYeMeTJUVZT/1IrRPGFsQa4xvnVJ3d79bJj
         ShWgCLCUw0/t8xEgUCKh3GrsE+hcOqdxuBm/70JW6ms99zNTYBrs6jb1AZpYlK+KMbbn
         vXZme7JcNx50u2y2aPiXGoDmamEn7ZahTN8mEjtmlvGaHcJLulO9D72WJNFs6A9Yb5kA
         7QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/2VtFM99rBJ4F25aTyuRHSIAtqEfcsV0ozhPb5k4ZUU=;
        b=EYBLJwmRWHkSQF/OznTPKGOCgQr3hbL0AcRd7vT9koh2EC7BGb/HlkJPuWIqbhLotT
         lp4ycXmVRUx12WILM/8lGpfHBXfSmyXg+tSZZ/2t9GdTmlRUzO2xthlmJSSHBRK81mOT
         XcYlAEUXuPU/UoDNvJYBQfVQlr7Sf5LVNSJyAUFPjoVl198OU+tcLaRuVM3OcR4N9N7K
         qHRorS37ldufua3G5gG5IVT7jQymUa1j+17sJxtfx3pcVFTlFzSn6P/mMDg2tP7g4RAX
         EECG8WSyBulLIpL3Fs3OxpkkLQ6Vy1aElSfYt42WJXmUa65bOx1VsU4BDRo9OlneOpEC
         hfAA==
X-Gm-Message-State: APjAAAWqe9JiRWDk8Mt5Pn2v14YF2vP5f1lwFog8syazbSPF5+1UqxPl
        L0g/B42/xzU6XUvlVks5AupDUsLJRxmsnv7XF5laFQ==
X-Google-Smtp-Source: APXvYqxoWUG4RYq44tZCuYX0fQ9ZppIDYklIb/wakMjbSWH4fCoygS3yYiFGng4TJjzUb5g2OwnOSo7qWhGSGP5xIi8=
X-Received: by 2002:a6b:b745:: with SMTP id h66mr28234915iof.128.1580923821232;
 Wed, 05 Feb 2020 09:30:21 -0800 (PST)
MIME-Version: 1.0
From:   Steven Clark <davolfman@gmail.com>
Date:   Wed, 5 Feb 2020 09:30:10 -0800
Message-ID: <CAOCvsSkuMLsZJssA1ae2LC=qN9d+HjQ_Ou9+RsdxHQ7gTjCL=w@mail.gmail.com>
Subject: What determines the inode-number bit width of a converted BTRFS volume.
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was reading through the mount options and the man paragraph on
inode-cache seemed pretty ominous.  My question is: what determines
whether a btrfs-convert, created volume has 32 bit inode numbers?  In
order of assumed likelihood: Is it the compiled architecture of the
btrfs-progs package? Is it the architecture of the kernel? Is it the
inode width of the ancestor filesystem?

I'm likely to see a fair amount of churn (for a desktop) on the
contents of volumes once converted with a pretty long term support
period.  I'd like to head off this concern before implementation.
