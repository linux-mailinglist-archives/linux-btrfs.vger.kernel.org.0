Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77928AF80C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfIKIft (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 04:35:49 -0400
Received: from mxc2.seznam.cz ([77.75.77.23]:15606 "EHLO mxc2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfIKIft (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 04:35:49 -0400
Received: from email.seznam.cz
        by email-smtpc10a.ng.seznam.cz (email-smtpc10a.ng.seznam.cz [10.23.11.45])
        id 5ea1c8164e29722a5eabe557;
        Wed, 11 Sep 2019 10:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1568190941; bh=QR/6LpZDvOr2oqvF7qvMavwyf/ncsCcqwo//h1Ku9/w=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:References:
         Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding;
        b=E7bjs1OhoXtl/0Tr8eqJeo8kr/Yr5+Cl561hxVCpPQlSHcLxP4hqnbveu4fIzqf6X
         ZC02dccIkMZZC3DwaeuVq6I2/fb/Ktz6iQm9NOj5fHHTilcnGmEmHv5dd28UW/3lG9
         RcATU/3Y8QQckn2Enp8A0YGamNhF/6DHaDzEVprk=
Received: from unknown ([::ffff:62.24.65.155])
        by email.seznam.cz (szn-ebox-4.5.361) with HTTP;
        Wed, 11 Sep 2019 10:35:38 +0200 (CEST)
From:   "Zdenek Sojka" <zsojka@seznam.cz>
To:     "Nikolay Borisov" <nborisov@suse.com>
Cc:     <linux-btrfs@vger.kernel.org>
Subject: =?utf-8?q?Re=3A_possible_circular_locking_dependency_detected_=28?=
        =?utf-8?q?sb=5Finternal/fs=5Freclaim=29?=
Date:   Wed, 11 Sep 2019 10:35:38 +0200 (CEST)
Message-Id: <Hue.2yoN.5452lXisyg7.1TUB7Q@seznam.cz>
References: <GZb.2yo4.6GbOlvQ7LF7.1TUAXC@seznam.cz>
        <ec419309-2903-aeed-8776-065920e65e7b@suse.com>
Mime-Version: 1.0 (szn-mime-2.0.45)
X-Mailer: szn-ebox-4.5.361
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

---------- P=C5=AFvodn=C3=AD e-mail ----------

Od: Nikolay Borisov <nborisov@suse.com>

Komu: Zdenek Sojka <zsojka@seznam.cz>, linux-btrfs@vger.kernel.org

Datum: 11. 9. 2019 10:16:49

P=C5=99edm=C4=9Bt: Re: possible circular locking dependency detected
 (sb_internal/fs_reclaim)





On 11.09.19 =D0=B3. 10:54 =D1=87.,  Zdenek Sojka  wrote:

> Hello,

> 

> this is my fourth attempt to post this message to the mailing list; this=
 time, without any attached kernel config (because it has over 100KiB). I =
also tried contacting the kernel btrfs maintainers directly by email, but =
they probably also didn't receive the message...

> 

> I am running kernel with lock debugging enabled since I am quite often e=
ncountering various lockups and hung tasks. Several of the problems have b=
een fixed recently, but not all; I don't know if the following backtrace i=
s related to the hangups, or if it is just a false positive.

> 

> $ uname -a

> Linux zso 5.2.11-gentoo #2 SMP Fri Aug 30 07:18:03 CEST 2019 x86_64 Inte=
l(R) Core(TM) i7-6700 CPU @ 3.40GHz GenuineIntel GNU/Linux

> 

> The kernel has a distro patchset applied (which should not affect this, =
but you can never say that for sure) and I am compiling at -O3 -fipa-pta -=
march=3Dnative instead of default -O2 (gcc-8.3.0).

> 

> Please let me know if I can provide any more information.

> 

> Best regards,

> Zdenek Sojka

> 

> The dmesg warning I recently triggered:



> This already received a patch in [PATCH] btrfs: nofs inode allocations=


> It's just not reviewed/merged yet. Care to test that patch if you can

> reliably reproduce this?


Thank you for the reply, I missed that thread.
Applied, and I will start testing.

Best regards,
Zdenek Sojka
