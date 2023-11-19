Return-Path: <linux-btrfs+bounces-189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC57F0791
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 17:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8AD280FE6
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09914297;
	Sun, 19 Nov 2023 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF10C4
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 08:41:19 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 13E6E816F5D
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 17:41:18 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: parent transid verify failed + level verify failed
Date: Sun, 19 Nov 2023 17:41:17 +0100
Message-ID: <4896535.31r3eYUQgx@lichtvoll.de>
In-Reply-To: <9221302.CDJkKcVGEf@lichtvoll.de>
References: <9221302.CDJkKcVGEf@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Martin Steigerwald - 19.11.23, 12:34:44 CET:
> After having used linux-6.7-rc1 almost rc2, git commit
> 791c8ab095f71327899023223940dd52257a4173 in order to test out BCacheFS,
> back on 6.6.1 after two attempts of non working hibernation and a
> strange experience with GRUB presenting its command prompt instead of a
> boot menu=B9, I now got this funny stuff:
>=20
> [ 1849.408572] BTRFS error (device dm-1: state EA): parent transid
> verify failed on logical 1178386432 mirror 1 wanted 538478 found 538901

=46inally recovered.

/ was not mountable anymore after booting into GRML. Made image with dd=20
and restored from backup onto a newly created BTRFS.

/home also had errors. Did not take a chance. Scrubbed it, updated a=20
backup with good old rsync, recreated filesystem and restored from updated=
=20
backup.

Another filesystem with larger files that only sees user space writes when =
I=20
write something to it, has been okay.

I have the following diagnostic data:

1) For /: dd image on external SSD with BTRFS, thus I can snapshot and/or=20
ref-link copy it around and run various diagnostic stuff on it, btrfs check=
=20
output (no repair), scrub was okay.

2) For /home: btrfs check output (no repair), scrub was okay.

3) I think I have some dmesg output from what caused the root filesystem=20
going read only, but I think that is the output I already posted.

SMART status of 2TB Samsung 980 Pro disk okay. I do not assume that there=20
is anything wrong with the device.

On what caused the corruption? No idea. Could be something wrong with that=
=20
6.7-almost-rc kernel, could be some corruption that happened on failed=20
hibernation attempts, could have to do something with BCacheFS albeit I=20
doubt it. Anyway, I am back on 6.6.1 for now and will not touch 6.7 kernel=
=20
again on this laptop before I am confident that it is is safe.

About diagnostic data: Willing to post more after the weekend. Just let me=
=20
know what you need. Of course I am not willing to upload complete dd image=
=20
somewhere, even not with just the operating system filesystem, but I can=20
run stuff on it and provide output. Otherwise you can have any of the btrfs=
=20
check output.

Best,
=2D-=20
Martin



