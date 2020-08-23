Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB78D24EDD6
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHWPIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 11:08:24 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:15591
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbgHWPIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 11:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:references:
         in-reply-to:message-id:to:from:date:from;
        bh=G3TKRNURoRyMqvLs7vCML3mQVxG4XgslyE9n8YbcXjE=;
        b=VDzU6k/UCS4Ca7gl4OW7Pewl/2bXbvlXqI9b/GYd+ZvQEI+Q78C7x5rF2ebf+MBbpi7X6gaZmXrUP
         RanHrWHlVRhPZO9qkZe7NxRNFlza+MZOaZ21PAoYJdHJFZMvlHepE6m1RQgYSfgZWLS+/BL+3IZQwQ
         KUomJoCXFNkW2qE0LypPsRiz9HkKiRyIvJQlYbbiqCoLZ0x58XtdgB6S8SJmpGd0Nnzz2hiNUs42bJ
         RYJCmwzLFBLZKzs2mPLsN85eP/lHXInxYNLZ622WIQuWrYLgb3p4YAFfkMhJgcDKrc6tcWL/sDlq2U
         iCYpCwgMCRMKz3mpHgme9GroD5Fdkgg==
X-HalOne-Cookie: e65f017fde1d5ab777a7e5060f16fadf41d9fa65
X-HalOne-ID: 79a3eb34-e552-11ea-8889-d0431ea8a290
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 79a3eb34-e552-11ea-8889-d0431ea8a290;
        Sun, 23 Aug 2020 15:08:18 +0000 (UTC)
Date:   Sun, 23 Aug 2020 17:08:17 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Bill Dietrich <bill@billdietrich.me>, linux-btrfs@vger.kernel.org
Message-ID: <19d8936.867cd4c.1741bdced46@lechevalier.se>
In-Reply-To: <1de8d385-4f63-cf84-2a60-9519e55035bc@billdietrich.me>
References: <1de8d385-4f63-cf84-2a60-9519e55035bc@billdietrich.me>
Subject: Re: Minimum size of Btrfs volume ?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Bill Dietrich <bill@billdietrich.me> -- Sent: 2020-08-23 - 15:26=
 ----

> [Noob here, sorry if I'm doing anything wrong.]
>=20
> What is the minimum size of a simple single-disk Btrfs volume,
> and where is it documented ?=C2=A0 I can't find that info.
>=20
> I'm told the minimum size is about 109 MB (114294784 bytes).
> True ?=C2=A0 Is there any way to get around that, at mkfs-time ?
> I'd like to use Btrfs inside a VeraCrypt container, and that's
> a fairly big minimum size for that use.
>=20
> I'm using Btrfs on Ubuntu GNOME 20.04 desktop.
>=20
> Thanks,
>=20
> Bill Dietrich
> bill@billdietrich.me
>=20
>=20
>=20
> -- Email domain proudly hosted at https://migadu.com

I'm not sure what minium limit is, but you can try using mkfs.btrfs --mixed=
. This worked with a 50MiB fs on btrfs-progs 5.7:

# btrfs fi us /mnt/loop
Overall:
    Device size:=09=09  50.00MiB
    Device allocated:=09=09   9.00MiB
    Device unallocated:=09=09  41.00MiB
    Device missing:=09=09     0.00B
    Used:=09=09=09  32.00KiB
    Free (estimated):=09=09  45.16MiB=09(min: 45.16MiB)
    Data ratio:=09=09=09      1.00
    Metadata ratio:=09=09      1.00
    Global reserve:=09=09 832.00KiB=09(used: 0.00B)
    Multiple profiles:=09=09        no

Data+Metadata,single: Size:5.00MiB, Used:28.00KiB (0.55%)
   /dev/loop0=09   5.00MiB

System,single: Size:4.00MiB, Used:4.00KiB (0.10%)
   /dev/loop0=09   4.00MiB

Unallocated:
   /dev/loop0=09  41.00MiB


