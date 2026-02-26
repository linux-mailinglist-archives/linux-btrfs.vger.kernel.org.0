Return-Path: <linux-btrfs+bounces-22026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLiPIUK6oGmbmAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22026-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:25:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2C1AFBEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F335300FB42
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1413E8C54;
	Thu, 26 Feb 2026 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1hI6M/d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B533343B
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141099; cv=none; b=aUpyI2nuCK2RrKwldkEdFlg7zuH9aR8mk2Rx3uNcRKRQc9+Iq/V8q7cISLDQ4vkAZhFBghm1vboU/CEPhqwF1xcHRSQ9fUVuub200LMg2zsxOJgHwB5+E/uyeGp3dKOoe3OvFlB6KO8mAv6sudjYi14g9QW+OQGTYEnzCi4Slug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141099; c=relaxed/simple;
	bh=EhEjG3nW33wraLWk6WmqzDyYE7DJLz+9GwGAVuoyP3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9/Mw3IvuCJiY+8jh4yEG33mIm39pgv180Epx8xxKJ4S4gtCwzoSQ0pQyxb8P8MJUuA35KbxrwaxhSE7HgLb/aCWFNfPXcArpH7kw5wqKb9BW78l8PofXnReSSDk6yWsalFpBFyiJod6CKmjlYOhpmTaPHTOiHQIS+NhTDTrigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1hI6M/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE4BC116C6
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772141098;
	bh=EhEjG3nW33wraLWk6WmqzDyYE7DJLz+9GwGAVuoyP3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L1hI6M/d3oSOJeAskaULOHWsifTwlrY4Qm0QvQ+OqFHgJa+peIAn/iDK2FiU3Oy6R
	 cx7YJcpSYdRY3QG2+mK/USTruSeMokNozLvxxMjoBTQkujBDxJ2De4/I2KnjGoDF+O
	 yy9ka/QWHTPSyIerjgmLHW3/hablX0WpHgc8LN8UHRSJJwwd7haQJETFs0ceTjsP03
	 2R7Y/Ejb0HWzGa0C7hetU1pWzQpppY0jlT3zDJiCR4fs5kBPwzTdwQ7rHOtqAUI6FO
	 xWbNdqhl5FKvu6OF5whuzFMLvFQMqDU4+GiOvNVlP1RwizzBDypzm9FUymebVHVJmh
	 eV7ReiMI2K1kg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65be78011c8so1819352a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 13:24:58 -0800 (PST)
X-Gm-Message-State: AOJu0YxHLlS7W6FLUuvkOA1NKIfshkQrZ9ex+NxUw0dUWrXtX3qpqs5P
	sa6VZcU+5M8KZfvkbsQ3XbeKRL6M/Hp/NPtAqGqKDQFuXyZYtBy1te9CPq3433n0pIdeZ1eBEu8
	Z2iLHzPN7Lm0ZgBAVrH4NfcCHeHQLAXA=
X-Received: by 2002:a17:907:3e86:b0:b87:6f2:a486 with SMTP id
 a640c23a62f3a-b93764cf192mr23346466b.31.1772141096870; Thu, 26 Feb 2026
 13:24:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772105193.git.fdmanana@suse.com> <3f0538466b8a6d7d00c0a8256c76dbdcf01980a0.1772105193.git.fdmanana@suse.com>
 <20260226185506.GA2996252@zen.localdomain>
In-Reply-To: <20260226185506.GA2996252@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Feb 2026 21:24:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7L6_hy6KAyZfEdcUEAxxJ6+=h50YW+DF19jGKJr_=Wig@mail.gmail.com>
X-Gm-Features: AaiRm53ocXjdKH9TzkNpe2vZhLYLME_gRDYDmT-rvHZOhA29rg63eRdSOUddtU0
Message-ID: <CAL3q7H7L6_hy6KAyZfEdcUEAxxJ6+=h50YW+DF19jGKJr_=Wig@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: fix transaction abort on file creation due to
 name hash collision
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22026-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85E2C1AFBEE
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 6:54=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Feb 26, 2026 at 02:33:58PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we attempt to create several files with names that result in the sam=
e
> > hash, we have to pack them in same dir item and that has a limit inhere=
nt
> > to the leaf size. However if we reach that limit, we trigger a transact=
ion
> > abort and turns the filesystem into RO mode. This allows for a maliciou=
s
> > user to disrupt a system, without the need to have administration
> > privileges/capabilities.
> >
> > Reproducer:
> >
> >    $ cat exploit-hash-collisions.sh
> >    #!/bin/bash
> >
> >    DEV=3D/dev/sdi
> >    MNT=3D/mnt/sdi
> >
> >    # Use smallest node size to make the test faster and require less fi=
le
> >    # names that result in hash collision.
> >    mkfs.btrfs -f --nodesize 4K $DEV
> >    mount $DEV $MNT
> >
> >    # List of names that result in the same crc32c hash for btrfs.
> >    declare -a names=3D(
> >     'foobar'
> >     '%a8tYkxfGMLWRGr55QSeQc4PBNH9PCLIvR6jZnkDtUUru1t@RouaUe_L:@xGkbO3nC=
wvLNYeK9vhE628gss:T$yZjZ5l-Nbd6CbC$M=3DhqE-ujhJICXyIxBvYrIU9-TDC'
> >     'AQci3EUB%shMsg-N%frgU:02ByLs=3DIPJU0OpgiWit5nexSyxZDncY6WB:=3DzKZu=
k5Zy0DD$Ua78%MelgBuMqaHGyKsJUFf9s=3DUW80PcJmKctb46KveLSiUtNmqrMiL9-Y0I_l5Fn=
am04CGIg=3D8@U:Z'
> >     'CvVqJpJzueKcuA$wqwePfyu7VxuWNN3ho$p0zi2H8QFYK$7YlEqOhhb%:hHgjhIjW5=
vnqWHKNP4'
> >     'ET:vk@rFU4tsvMB0$C_p=3DxQHaYZjvoF%-BTc%wkFW8yaDAPcCYoR%x$FH5O:' > =
    'HwTon%v7SGSP4FE08jBwwiu5aot2CFKXHTeEAa@38fUcNGOWvE@Mz6WBeDH_VooaZ6AgsX=
PkVGwy9l@@ZbNXabUU9csiWrrOp0MWUdfi$EZ3w9GkIqtz7I_eOsByOkBOO'
> >     'Ij%2VlFGXSuPvxJGf5UWy6O@1svxGha%b@=3D%wjkq:CIgE6u7eJOjmQY5qTtxE2Rj=
bis9@us'
> >     'KBkjG5%9R8K9sOG8UTnAYjxLNAvBmvV5vz3IiZaPmKuLYO03-6asI9lJ_j4@6Xo$KZ=
icaLWJ3Pv8XEwVeUPMwbHYWwbx0pYvNlGMO9F:ZhHAwyctnGy%_eujl%WPd4U2BI7qooOSr85J-=
C2V$LfY'
> >     'NcRfDfuUQ2=3DzP8K3CCF5dFcpfiOm6mwenShsAb_F%n6GAGC7fT2JFFn:c35X-3aY=
woq7jNX5$ZJ6hI3wnZs$7KgGi7wjulffhHNUxAT0fRRLF39vJ@NvaEMxsMO'
> >     'Oj42AQAEzRoTxa5OuSKIr=3DA_lwGMy132v4g3Pdq1GvUG9874YseIFQ6QU'
> >     'Ono7avN5GjC:_6dBJ_'
> >     'WHmN2gnmaN-9dVDy4aWo:yNGFzz8qsJyJhWEWcud7$QzN2D9R0efIWWEdu5kwWr73N=
Zm4=3D@CoCDxrrZnRITr-kGtU_cfW2:%2_am'
> >     'WiFnuTEhAG9FEC6zopQmj-A-$LDQ0T3WULz%ox3UZAPybSV6v1Z$b4L_XBi4M4BMBt=
JZpz93r9xafpB77r:lbwvitWRyo$odnAUYlYMmU4RvgnNd--e=3DI5hiEjGLETTtaScWlQp8mYs=
BovZwM2k'
> >     'XKyH=3DOsOAF3p%uziGF_ZVr$ivrvhVgD@1u%5RtrV-gl_vqAwHkK@x7YwlxX3qT6W=
KKQ%PR56NrUBU2dOAOAdzr2=3D5nJuKPM-T-$ZpQfCL7phxQbUcb:BZOTPaFExc-qK-gDRCDW2'
> >     'd3uUR6OFEwZr%ns1XH_@tbxA@cCPmbBRLdyh7p6V45H$P2$F%w0RqrD3M0g8aGvWpo=
TFMiBdOTJXjD:JF7=3Dh9a_43xBywYAP%r$SPZi%zDg%ql-KvkdUCtF9OLaQlxmd'
> >     'ePTpbnit%hyNm@WELlpKzNZYOzOTf8EQ$sEfkMy1VOfIUu3coyvIr13-Y7Sv5v-Iva=
x2Go_GQRFMU1b3362nktT9WOJf3SpT%z8sZmM3gvYQBDgmKI%%RM-G7hyrhgYflOw%z::ZRcv5O=
:lDCFm'
> >     'evqk743Y@dvZAiG5J05L_ROFV@$2%rVWJ2%3nxV72-W7$e$-SK3tuSHA2mBt$qloC5=
jwNx33GmQUjD%akhBPu=3DVJ5g$xhlZiaFtTrjeeM5x7dt4cHpX0cZkmfImndYzGmvwQG:$euFY=
mXn$_2rA9mKZ'
> >     'gkgUtnihWXsZQTEkrMAWIxir09k3t7jk_IK25t1:cy1XWN0GGqC%FrySdcmU7M8MuP=
O_ppkLw3=3DDfr0UuBAL4%GFk2$Ma10V1jDRGJje%Xx9EV2ERaWKtjpwiZwh0gCSJsj5UL7CR8R=
tW5opCVFKGGy8Cky'
> >     'hNgsG_8lNRik3PvphqPm0yEH3P%%fYG:kQLY=3D6O-61Wa6nrV_WVGR6TLB09vHOv%=
g4VQRP8Gzx7VXUY1qvZyS'
> >     'isA7JVzN12xCxVPJZ_qoLm-pTBuhjjHMvV7o=3DF:EaClfYNyFGlsfw-Kf%uxdqW-k=
wk1sPl2vhbjyHU1A6$hz'
> >     'kiJ_fgcdZFDiOptjgH5PN9-PSyLO4fbk_:u5_2tz35lV_iXiJ6cx7pwjTtKy-XGaQ5=
IefmpJ4N_ZqGsqCsKuqOOBgf9LkUdffHet@Wu'
> >     'lvwtxyhE9:%Q3UxeHiViUyNzJsy:fm38pg_b6s25JvdhOAT=3D1s0$pG25x=3DLZ2r=
lHTszj=3DgN6M4zHZYr_qrB49i=3DpA--@WqWLIuX7o1S_SfS@2FSiUZN'
> >     'rC24cw3UBDZ=3D5qJBUMs9e$=3DS4Y94ni%Z8639vnrGp=3D0Hv4z3dNFL0fBLmQ40=
=3DEYIY:Z=3DSLc@QLMSt2zsss2ZXrP7j4=3D'
> >     'uwGl2s-fFrf@GqS=3DDQqq2I0LJSsOmM%xzTjS:lzXguE3wChdMoHYtLRKPvfaPOZF=
2fER@j53evbKa7R%A7r4%YEkD=3DkicJe@SFiGtXHbKe4gCgPAYbnVn'
> >     'UG37U6KKua2bgc:IHzRs7BnB6FD:2Mt5Cc5NdlsW%$1tyvnfz7S27FvNkroXwAW:mB=
ZLA1@qa9WnDbHCDmQmfPMC9z-Eq6QT0jhhPpqyymaD:R02ghwYo%yx7SAaaq-:x33LYpei$5g8D=
Ml3C'
> >     'y2vjek0FE1PDJC0qpfnN:x8k2wCFZ9xiUF2ege=3DJnP98R%wxjKkdfEiLWvQzmnW'
> >     '8-HCSgH5B%K7P8_jaVtQhBXpBk:pE-$P7ts58U0J@iR9YZntMPl7j$s62yAJO@_9ea=
nFPS54b=3DUTw$94C-t=3DHLxT8n6o9P=3DQnIxq-f1=3DNe2dvhe6WbjEQtc'
> >     'YPPh:IFt2mtR6XWSmjHptXL_hbSYu8bMw-JP8@PNyaFkdNFsk$M=3DxfL6LDKCDM-m=
SyGA_2MBwZ8Dr4=3DR1D%7-mCaaKGxb990jzaagRktDTyp'
> >     '9hD2ApKa_t_7x-a@GCG28kY:7$M@5udI1myQ$x5udtggvagmCQcq9QXWRC5hoB0o-_=
zHQUqZI5rMcz_kbMgvN5jr63LeYA4Cj-c6F5Ugmx6DgVf@2Jqm%MafecpgooqreJ53P-QTS'
> >    )
> >
> >    # Now create files with all those names in the same parent directory=
.
> >    # It should not fail since a 4K leaf has enough space for them.
> >    for name in "${names[@]}"; do
> >         touch $MNT/$name
> >    done
> >
> >    # Now add one more file name that causes a crc32c hash collision.
> >    # This should fail, but it should not turn the filesystem into RO mo=
de
> >    # (which could be exploited by malicious users) due to a transaction
> >    # abort.
> >    touch $MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt'
> >
> >    # Check that we are able to create another file, with a name that do=
es not cause
> >    # a crc32c hash collision.
> >    echo -n "hello world" > $MNT/baz
> >
> >    # Unmount and mount again, verify file baz exists and with the right=
 content.
> >    umount $MNT
> >    mount $DEV $MNT
> >    echo "File baz content: $(cat $MNT/baz)"
> >
> >    umount $MNT
> >
> > When running the reproducer:
> >
> >    $ ./exploit-hash-collisions.sh
> >    (...)
> >    touch: cannot touch '/mnt/sdi/W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5=
Ok_GmijKOJJt': Value too large for defined data type
> >    ./exploit-hash-collisions.sh: line 57: /mnt/sdi/baz: Read-only file =
system
> >    cat: /mnt/sdi/baz: No such file or directory
> >    File baz content:
> >
> > And the transaction abort stack trace in dmesg/syslog:
> >
> >    $ dmesg
> >    (...)
> >    [758240.509761] ------------[ cut here ]------------
> >    [758240.510668] BTRFS: Transaction aborted (error -75)
> >    [758240.511577] WARNING: fs/btrfs/inode.c:6854 at btrfs_create_new_i=
node+0x805/0xb50 [btrfs], CPU#6: touch/888644
> >    [758240.513513] Modules linked in: btrfs dm_zero (...)
> >    [758240.523221] CPU: 6 UID: 0 PID: 888644 Comm: touch Tainted: G    =
    W           6.19.0-rc8-btrfs-next-225+ #1 PREEMPT(full)
> >    [758240.524621] Tainted: [W]=3DWARN
> >    [758240.525037] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> >    [758240.526331] RIP: 0010:btrfs_create_new_inode+0x80b/0xb50 [btrfs]
> >    [758240.527093] Code: 0f 82 cf (...)
> >    [758240.529211] RSP: 0018:ffffce64418fbb48 EFLAGS: 00010292
> >    [758240.529935] RAX: 00000000ffffffd3 RBX: 0000000000000000 RCX: 000=
00000ffffffb5
> >    [758240.531040] RDX: 0000000d04f33e06 RSI: 00000000ffffffb5 RDI: fff=
fffffc0919dd0
> >    [758240.531920] RBP: ffffce64418fbc10 R08: 0000000000000000 R09: 000=
00000ffffffb5
> >    [758240.532928] R10: 0000000000000000 R11: ffff8e52c0000000 R12: fff=
f8e53eee7d0f0
> >    [758240.533818] R13: ffff8e57f70932a0 R14: ffff8e5417629568 R15: 000=
0000000000000
> >    [758240.534664] FS:  00007f1959a2a740(0000) GS:ffff8e5b27cae000(0000=
) knlGS:0000000000000000
> >    [758240.535821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    [758240.536644] CR2: 00007f1959b10ce0 CR3: 000000012a2cc005 CR4: 000=
0000000370ef0
> >    [758240.537517] Call Trace:
> >    [758240.537828]  <TASK>
> >    [758240.538099]  btrfs_create_common+0xbf/0x140 [btrfs]
> >    [758240.538760]  path_openat+0x111a/0x15b0
> >    [758240.539252]  do_filp_open+0xc2/0x170
> >    [758240.539699]  ? preempt_count_add+0x47/0xa0
> >    [758240.540200]  ? __virt_addr_valid+0xe4/0x1a0
> >    [758240.540800]  ? __check_object_size+0x1b3/0x230
> >    [758240.541661]  ? alloc_fd+0x118/0x180
> >    [758240.542315]  do_sys_openat2+0x70/0xd0
> >    [758240.543012]  __x64_sys_openat+0x50/0xa0
> >    [758240.543723]  do_syscall_64+0x50/0xf20
> >    [758240.544462]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >    [758240.545397] RIP: 0033:0x7f1959abc687
> >    [758240.546019] Code: 48 89 fa (...)
> >    [758240.548522] RSP: 002b:00007ffe16ff8690 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000101
> >    [758240.566278] RAX: ffffffffffffffda RBX: 00007f1959a2a740 RCX: 000=
07f1959abc687
> >    [758240.567068] RDX: 0000000000000941 RSI: 00007ffe16ffa333 RDI: fff=
fffffffffff9c
> >    [758240.567860] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
0000000000000
> >    [758240.568707] R10: 00000000000001b6 R11: 0000000000000202 R12: 000=
0561eec7c4b90
> >    [758240.569712] R13: 0000561eec7c311f R14: 00007ffe16ffa333 R15: 000=
0000000000000
> >    [758240.570758]  </TASK>
> >    [758240.571040] ---[ end trace 0000000000000000 ]---
> >    [758240.571681] BTRFS: error (device sdi state A) in btrfs_create_ne=
w_inode:6854: errno=3D-75 unknown
> >    [758240.572899] BTRFS info (device sdi state EA): forced readonly
> >
> > Fix this by checking for hash collision, and if the adding a new name i=
s
> > possible, early in btrfs_create_new_inode() before we do any tree updat=
es,
> > so that we don't need to abort the transaction if we can not add the ne=
w
> > name due to the leaf size limit.
> >
> > A test case for fstests will be sent soon.
> >
> > Fixes: caae78e03234 ("btrfs: move common inode creation code into btrfs=
_create_new_inode()")
>
> This fix makes sense but I have two high level questions if you don't
> mind:
>
> I couldn't actually find the place EOVERFLOW is coming from.
> my best guess is:
>
> insert_with_overflow()
>   btrfs_insert_empty_item()
>     btrfs_insert_empty_items()
>       btrfs_search_slot()
>         search_leaf()
>           split_leaf()
>                 if (extend && data_size + btrfs_item_size(l, slot) +
>                     sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(fs_i=
nfo))
>                         return -EOVERFLOW;
>
> Is that right?

Yes.

>  I am a bit confused how this doesn't get caught by the
> check before the call to split leaf
> i.e.,
> if (leaf_free_space < ins_len) // ctree.c:1951

I don't understand your doubt.
It's because the leaf doesn't have enough space that we call
split_leaf(), and that fails with the above if statement you
identified because the extended item size would not fit in a leaf.

>
>
> Also, would it theoretically be possible to extend the collision
> handling to allow collisions to span leaves or is there some reason that
> is complete no-go?

And how would you do that, without changing the on-disk format with
new keys and/or item types?
We would have to have new keys and the data split across several
items, like we did for extrefs over a decade ago.

Thanks.

>
> Regardless of the answers, this is well reasoned, well tested, and a
> clear imporovement so please add:
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/inode.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b9f1bd18ea62..9a26fc5a5263 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -6635,6 +6635,25 @@ int btrfs_create_new_inode(struct btrfs_trans_ha=
ndle *trans,
> >       int ret;
> >       bool xa_reserved =3D false;
> >
> > +     if (!args->orphan && !args->subvol) {
> > +             /*
> > +              * Before anything else, check if we can add the name to =
the
> > +              * parent directory. We want to avoid a dir item overflow=
 in
> > +              * case we have an existing dir item due to existing name
> > +              * hash collisions. We do this check here before we call
> > +              * btrfs_add_link() down below so that we can avoid a
> > +              * transaction abort (which could be exploited by malicio=
us
> > +              * users).
> > +              *
> > +              * For subvolumes we already do this in btrfs_mksubvol().
> > +              */
> > +             ret =3D btrfs_check_dir_item_collision(BTRFS_I(dir)->root=
,
> > +                                                  btrfs_ino(BTRFS_I(di=
r)),
> > +                                                  name);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> >       path =3D btrfs_alloc_path();
> >       if (!path)
> >               return -ENOMEM;
> > --
> > 2.47.2
> >

