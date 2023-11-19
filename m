Return-Path: <linux-btrfs+bounces-188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729857F0606
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 12:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D17280DD9
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC82E568;
	Sun, 19 Nov 2023 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Nov 2023 03:43:08 PST
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD225129
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 03:43:08 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 21FB3816C1E
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 12:34:45 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-btrfs@vger.kernel.org
Subject: parent transid verify failed + level verify failed
Date: Sun, 19 Nov 2023 12:34:44 +0100
Message-ID: <9221302.CDJkKcVGEf@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi!

Have a great Sunday and absolutely feel free to reply at a later time :)

After having used linux-6.7-rc1 almost rc2, git commit
791c8ab095f71327899023223940dd52257a4173 in order to test out BCacheFS,
back on 6.6.1 after two attempts of non working hibernation and a strange
experience with GRUB presenting its command prompt instead of a boot menu=
=C2=B9,
I now got this funny stuff:

[ 1849.408572] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1178386432 mirror 1 wanted 538478 found 538901
[ 1849.408943] BTRFS error (device dm-1: state EA): level verify failed on =
logical 1132724224 mirror 1 wanted 0 found 1
[ 1849.414073] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1178386432 mirror 1 wanted 538478 found 538901
[ 1849.446144] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1204469760 mirror 1 wanted 538478 found 538904
[ 1849.448792] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1204469760 mirror 1 wanted 538478 found 538904
[ 1849.449515] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1204469760 mirror 1 wanted 538478 found 538904
[ 1849.451647] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1204469760 mirror 1 wanted 538478 found 538904
[ 1849.454860] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1204469760 mirror 1 wanted 538478 found 538904
[ 1849.455527] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on 2a006853-bec0-4026-94aa-8ade2e0c3674logical 1204469760 mirror 1 wa=
nted 538478 found 538904
[ 1849.456286] BTRFS error (device dm-1: state EA): parent transid verify f=
ailed on logical 1204469760 mirror 1 wanted 538478 found 538904

Noticed as BTRFS for / went read only.

Kernel 6.6.1 on Devuan Ceres on ThinkPad T14 AMD Gen 1 32 GiB RAM with
2 TB Samsung 980 Pro NVME SSD.

I cannot do a scrub cause despite

WARNING: failed to write the progress status file: Read-only file system. S=
tatus recording disabled
scrub started on /, fsid [=E2=80=A6] (pid=3D31693)

scrub does not seem to do anything.

Will now boot into GRML and recover from backup, also checking the other
BTRFS filesystems.

While focus will be to get to a full working state as quickly as possible,
I intend to do a full dd copy for forensic analysis.



[1] Described in more detail at the end of:

Re: Questions related to BCacheFS

https://lore.kernel.org/linux-bcachefs/2273246.iZASKD2KPV@lichtvoll.de/T/#m=
3fc22fb92f1f2d160f2b3a2387dc1f10d067fb97

Best,
=2D-=20
Martin



