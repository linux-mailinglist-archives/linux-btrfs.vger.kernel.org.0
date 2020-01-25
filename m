Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA53149521
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 12:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgAYLRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 06:17:03 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:51846 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgAYLRD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 06:17:03 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jan 2020 06:17:02 EST
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id DA58F150;
        Sat, 25 Jan 2020 12:08:38 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1579950518;
        bh=NNkr9jbB5fh2jpm17bFMSPiKMhS1ioYYj8AHDG4DoUo=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=basdBhwpHSY+yfBLDOediOt66TlMNds/m7/w02YzOzN2/TCkWjNbWouTPyRWKZAhd
         CDxEemDd9NLfSiVqMqwM7ufAZlxHXXbuUbBaz7sfIQQ5CJRkP8tDGWA9xG3pGe06pb
         6buWqwNz2FDuuPBHJNrLfPMfBCOOEM6D3dq292mM=
MIME-Version: 1.0
Date:   Sat, 25 Jan 2020 11:08:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <8254df450ca61dd4cbc455f19ee28c01@lesimple.fr>
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
To:     "Craig Andrews" <candrews@integralblue.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
References: <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
 <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> ERROR: failed to clone extents to var/amavis/db/__db.001: Invalid argum=
ent=0A=0AIf I may add another data point here, I'm also encountering this=
 issue on a 5.5.0-rc6, with the btrfs-rc7 patches applied to it (so as fa=
r as btrfs is concerned, this is an rc7).=0A=0AOn the first time, it happ=
ened after sending ~90 Gb worth of data, and aborted (as I didn't specify=
 the -E option to btrfs send). Then, I retried with btrfs send -E 0, and =
it encountered the exact same error on the same file.=0A=0A# btrfs send -=
v /tank/backups/.snaps/incoming/sendme/ | pv 2>/dev/pts/23 | btrfs rec -E=
 0 /newfs/=0AAt subvol /tank/backups/.snaps/incoming/sendme/=0AAt subvol =
sendme=0AERROR: failed to clone extents to retroarch/x86_64/cores/mednafe=
n_saturn_libretro.dll: Invalid argument=0AERROR: failed to clone extents =
to retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argument=
=0A=0AThe send/receive is still going on for now, currently around the ~2=
00 Gb mark.=0A=0ABees is running on this FS (but I stopped it before doin=
g the send/receive).=0A=0AI can test patches if needed.=0A=0A-- =0ASt=C3=
=A9phane.
