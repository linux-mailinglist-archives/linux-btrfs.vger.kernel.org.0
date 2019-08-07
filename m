Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBD847B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfHGIhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:37:55 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:44386 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfHGIhz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 04:37:55 -0400
Received: by mail-vs1-f42.google.com with SMTP id v129so60145621vsb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IMfBAycAs6OcFvauAxRYvS25jSswGHry63EsEN7MrhY=;
        b=qbPLRoNa9L8mQ22JInoltCq5l+ZPp0khdxPGpLTxTwDjTten+aesds+h/dJikg6m4t
         QFY/JgfT7sMSaAbC+z88A3lStWMuIS3QymSOR6NuefooroKXGz7Vk/d+F7dHd8eZPs5t
         ak7X9Gs2Won92OK069rCnRKvpEfwwCZIrD1AK8DTDakX8J/5LPqAKU7DhjIgnNP1xtB+
         1Pasvq42TLURK1WoqyRKwuOpDrc2N0MvJNq4L+xeQTwq6HrdfwYkDuWC6IUYDBF/fUVC
         SYg2wsK51pcanLdFpEeB4jClBpJY+l1x0O/vlR75Th6O0Nr3o95Pe+wV4hRNIFqcZTTc
         qn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IMfBAycAs6OcFvauAxRYvS25jSswGHry63EsEN7MrhY=;
        b=lU/c08ZJt9g3wHyyN8Xc94i7iVY45Bb9IwTNnNbcMDEYXWEC0/nMVTSH62Ca99zgb0
         /0SdIwnOw5v8QYQn2DdC86ZAI+7qda7ezmoyzvLVGAxPzoxjbW/qAmZewsF3UpABaYbq
         2fxZlHpF1rG3lKYh9T/1pKgsm4a12vpLnRSzEhjed7IP8CC5grqvWJszUBJS8KKB+Gkf
         JnmP+GSDdRUw5MYcDtrL8Tc2JKNP8g6Cmqoc2NOzbPucqocsHzh6LGeYr6+efzzl2eEG
         iyP6XLixx9+BjAU4VLS1jgkuXhYjZk4QyZQrfWHY85p5qRCLR3m0lqY5WRD80SPV9UgD
         cUqg==
X-Gm-Message-State: APjAAAX77NQOsImDq1XYhp2C+kRW/TLqIPLgTqbfXdpOMIoh0UPknq83
        B44t+6FOjuk4UXIc9Dbvp45sSoS/RmY8ecni8LLrpMxe
X-Google-Smtp-Source: APXvYqwM/9D9SqYT2ViJRcYPUJ7yK6/7SvIGvyZJfuxXDu/2Bcw0GOh3mT+il5HEurhUlJACZsjG9ADYsdwTRBAhmxw=
X-Received: by 2002:a67:fb8d:: with SMTP id n13mr4909927vsr.46.1565167074171;
 Wed, 07 Aug 2019 01:37:54 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Ander MB <jonandermonleon@gmail.com>
Date:   Wed, 7 Aug 2019 10:37:43 +0200
Message-ID: <CACa3q1zdz9XHGzkrhyfACo58iRBWMRGPzbQTebaN3aU0HLJxgw@mail.gmail.com>
Subject: Unable to delete or change ro flag on subvolume/snapshot
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!
I have a snapshot with the read only flag set and I'm currently unable
to delete it or change the ro setting
btrfs property set -ts /path/t/snapshot ro false
ERROR: failed to set flags for /path/t/snapshot: Operation not permitted

Deleting the snapshot is also a no-go:

btrfs subvolume delete /path/t/snapshot
Delete subvolume (no-commit): '/path/t/snapshot'
ERROR: cannot delete '/path/t/snapshot': Operation not permitted


The snapshot information:

btrfs subvolume show /path/t/snapshot
/path/t/snapshot
        Name:                   snapshot
        UUID:                   66a145da-a20d-a44e-bb7a-3535da400f5d
        Parent UUID:            f1866638-f77f-e34e-880d-e2e3bec1c88b
        Received UUID:          66a145da-a20d-a44e-bb7a-3535da400f5d
        Creation time:          2019-07-31 12:00:30 +0200
        Subvolume ID:           23786
        Generation:             1856068
        Gen at creation:        1840490
        Parent ID:              517
        Top level ID:           517
        Flags:                  readonly
        Snapshot(s):


Any idea of what can I do?

Regards!

--=20
--- Jon Ander Monle=C3=B3n Besteiro ---
