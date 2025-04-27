Return-Path: <linux-btrfs+bounces-13447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57270A9E413
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Apr 2025 19:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26347AD4B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Apr 2025 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC01E25E1;
	Sun, 27 Apr 2025 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="PiohWGQT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48901DE8A0
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Apr 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745774767; cv=none; b=YGPs4TnHTKrPO++EWoFAQVP0fk3p3F6Mf87tdC/bALHKKwO5yJCpkew0c11BPGQHSxD24bNpvCkObYfoTwwa0bwKOlbKUwqpGPERNZ9qQfq1v/+TfhGeI0tuinZhccKkIXpTtsrMXtH18Cc9Vi+gHpNWDzJUYgRZWr6D7ixYDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745774767; c=relaxed/simple;
	bh=ToFgLf2211rWMmegfVD5CiaVg0uLCmiJsbwKWnDgP9I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DtnF6if65bUZ4Sja/Wcun54enlrlAHlPO7wz91do2lQcBH1YMBJ19J81ehFzBaj/iFvYvwv56anXzcW7NQ6HOdr0oCPHP3hBplhdX50E+pkZ9BtR0nMHgmiQ/JdvhlCl2LzzYp4k+FrRif0rsTDaaXnndNDPVFAzxdS78d9GbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=PiohWGQT; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1745774756; x=1746379556; i=christian@heusel.eu;
	bh=MZQy79vGGjAWsGYsBLaq3zgKVeXl9EqSbxc0acvcdoY=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=PiohWGQTqKYAomf4s+Jbo6caXIDnrmb9nIWwJG+1TjhSIA74jbWIgKuUrJ7Lo98i
	 CEIS0Wh39q2hR4XWle4RYVJa1R/dJDtDCTvSa5VkMWsNMq5PVNovdoJzOSgirS3bl
	 daJ21MUtrKHh5LgfF+Ox8ORS2goMfQ1qhYJCJA8zh3shPqcsq2L5NNmNpK37Jdrky
	 nJYWW1BjXS6I6S9uQvSwrxvIAFMe+gxwBx13O/wFTwFgPTZsLbtjF427mcJffudDf
	 /nrLtmRelZJqYD6C5T4JJRROE8bOzAv1m3/UFeLaoK1vPNula23b/J7OV02grVYSL
	 7Y6JndLO2iKKeYBFBw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.64.187]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsZeX-1uxTcu2bYB-00ujPi for <linux-btrfs@vger.kernel.org>; Sun, 27 Apr 2025
 19:25:55 +0200
Date: Sun, 27 Apr 2025 19:25:45 +0200
From: Christian Heusel <christian@heusel.eu>
To: linux-btrfs@vger.kernel.org
Subject: Stack trace on next-20250424
Message-ID: <c5833b22-d8ea-4077-9283-de9d13f0e4b2@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s4i5v2jwbxm6njkc"
Content-Disposition: inline
X-Provags-ID: V03:K1:Kj//cznl5sbvl05Cld+qC3+EmZx0LbAFFLO5NWNCR0pt0EQF2K7
 XyYmO3f7j3B8Fx5i0etINzbjUQFryUVCJCM9lc2YaDynASbZRAWqu+DlNdOLEfnaMYqsf7m
 V3mnclqo2ZeAIQsSXW3O3uCHwS7EFt4is1fvg2xmMHfmFGq4ZvCrIb0IsLSDlgl4hoO9TWK
 zDHXw83vA1ST4zzEtL5+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DH6spdeejV0=;RM0V6qqFcp+na4V96xDLsWYRMQm
 QUEOgnVuC3uXcabHc9MAsSGm8fnzZlyU/NtVqcSbcPGM0okKgR2EgYqNPkYE1REeLaQ2OaMBr
 /etFUMX/B86E4tWLsM3bByQ5+NgGHra9w5MEC0ZR5c8PBn7T6GX1A1tc1x+oAS0JbGJUyh0WZ
 Qf18xw/2jQaWQaxVj+ZCDD5TkSFoVDtWvIQN9FNiyj1SZNLmvCvcNTCmENxbS1uBCGJsxVK7d
 Q33BxrlfVTtjx4GySSwE9nk5U8DS+E4BwSsAdzZ4vsLMLRc+5CPy2+mkwigNcvh1p+1DSTEL/
 nUZUrqZK8B/rTh6PScGL8bjcOWSOgaNZQyQjzSBc2fadTmymIKyjAwuaM5hiKSDw/cnP6m1je
 M5blRoFC3lqEmaDWhir9p2+ILr+xEjMlIST8zZ8hLJU4Mzxwf8oTMwUiQs90UrlqqGK2rwhfX
 N6TMXpnyNMsCOCT98EXcxbiltzjqWxiwl461GdVYffiEOWVozKf4ZNEdmSV+QMcPum9IE/GS+
 Kj/CdZpHHN0v64tgrrdsesqGNDVRIaPwatTGXGU9Ca+oP4uN3wNEsWCuGhCXIjIkHUN8pFD42
 flv7lTsjDwurGuB1kUnmzOkSKDJEzpfDrY/SU4dSl1itkPv1hRgtGCEhk2mQnQ1cubZhCpBMs
 Kjs/qxfY3YPLJ/7UQDsxcaGy53jCDhjtcm+3XTEo+/TiLxIMAjw+j+2CmGAJs2pMM5AIYQmWW
 PeQFPvF9wcFYr7N1+SVcqEagAdCW4uiX4w/MX2QFSdovq6xL3QFXcg2mOb6BvhvpacSYlDfiV
 W1UrmJKR7jDh1185h3IJexqKkF+Hg+hiRlslOKWl1m0MDVtAdi0uMY2aHOYG9T7T22aVu+LfK
 /T/0j3m3Nq1Nui1z9hwcWm2x9FJcvKtjWi+O+SubmhabC/t3b5AJQbBFdUBf7jjohiLwi4GLN
 15D7AgMN8i9cZBRCwo6LlIsp2tCZkRmFatVSnWqO/CcGzOROUg7ALY2l+nIWz5eqviLJ2I341
 +xY+dTTdbHDy99Zue0Irdy7jz0vt4GW4bPWt9zdc5aebwNuJvS3kQWXUK2FY9P6aoJM+3gJv6
 CBwIjcCwbFXHldxMqVXXJ6Et0a7DUckKWdJhXRH5c5mFQk4gtvufvMJt848DYLmYa7YJ1Lm27
 Vxa0IWZEcK9htgnGoY87lpTKHsNzrf+yCCqIgejHs5nf9Cd8OAI4EaDpDBEPg9JiWGvZ/bqhg
 iJkoASqGcKO18eeYFv9LNNoiLIzIsMJ7+WXu/Ar4jY4+OkxOb17+EaVBOSjyGWSqVwXNDVbR1
 SkwLIQtfQMLCZ+MvcSp4guHxUsxpPS81gzOdhw85IL6JP7nKS3qwoJ20yKHwS4KtiL+HC2Av5
 /t+qcR43o0V3ye8g==


--s4i5v2jwbxm6njkc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Stack trace on next-20250424
MIME-Version: 1.0

Hey all,

I have just test-booted linux-next on the next-20250424 tag and
encountered the following error:

[    5.397970] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[    5.399379] #PF: supervisor read access in kernel mode
[    5.400417] #PF: error_code(0x0000) - not-present page
[    5.401357] PGD 0 P4D 0=20
[    5.401826] Oops: Oops: 0000 [#1] SMP NOPTI
[    5.402555] CPU: 2 UID: 0 PID: 375 Comm: (udev-worker) Tainted: G    B  =
             6.15.0-rc3-next-20250424-1-next-git-06092-g393d0c54cae3-dirty =
#1 PREEMPT(full)  e5bd168551b00ee32e542180030e13fc43de91d1
[    5.405546] Tainted: [B]=3DBAD_PAGE
[    5.406079] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arc=
h Linux 1.16.3-1-1 04/01/2014
[    5.407287] RIP: 0010:alloc_extent_buffer+0x2d6/0x670
[    5.407914] Code: df 48 8b 03 e8 3b a1 cc ff f0 ff 4b 34 0f 84 86 01 00 =
00 4b c7 44 f4 70 00 00 00 00 41 8b 4c 24 08 49 8b 54 24 70 41 83 c5 01 <48=
> 8b 02 a8 40 74 0b 80 7a 40 00 b8 01 00 00 00 75 0d 89 c8 be 01
[    5.410519] RSP: 0018:ffffcbdc81227520 EFLAGS: 00010202
[    5.411176] RAX: 0000000000000000 RBX: ffffee4f040a1280 RCX: 00000000000=
04000
[    5.412171] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8afc3bd=
1d000
[    5.413221] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffcbdc812=
27350
[    5.413222] R10: ffffffff858b8928 R11: 0000000000000003 R12: ffff8afbc65=
d1c30
[    5.413224] R13: 0000000000000001 R14: 0000000000000000 R15: ffff8afbc65=
d44b0
[    5.413227] FS:  000076d75f67f880(0000) GS:ffff8afcb5800000(0000) knlGS:=
0000000000000000
[    5.413228] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.413230] CR2: 0000000000000000 CR3: 00000001083b0000 CR4: 00000000003=
50ef0
[    5.413233] Call Trace:
[    5.413236]  <TASK>
[    5.413241]  read_block_for_search+0x1f6/0x400
[    5.413248]  btrfs_search_slot+0x2f5/0xd50
[    5.413259]  btrfs_lookup_csum+0x70/0x160
[    5.413263]  btrfs_lookup_bio_sums+0x227/0x420
[    5.413267]  btrfs_submit_chunk+0x162/0x650
[    5.413272]  btrfs_submit_bbio+0x1a/0x30
[    5.413274]  submit_one_bio+0x36/0x50
[    5.413277]  btrfs_readahead+0x148/0x190
[    5.413281]  ? __pfx_end_bbio_data_read+0x10/0x10
[    5.413285]  read_pages+0x76/0x220
[    5.413287]  ? __mem_cgroup_uncharge+0x60/0x80
[    5.413293]  page_cache_ra_unbounded+0x1d3/0x210
[    5.413296]  filemap_get_pages+0x133/0x730
[    5.413299]  ? vfs_statx+0x80/0x160
[    5.427505]  filemap_read+0xfb/0x3f0
[    5.427517]  vfs_read+0x2a8/0x380
[    5.427523]  __x64_sys_pread64+0x91/0xc0
[    5.427526]  do_syscall_64+0x82/0x810
[    5.427533]  ? do_sys_openat2+0xa4/0xe0
[    5.427535]  ? syscall_exit_to_user_mode+0x37/0x1c0
[    5.427538]  ? do_syscall_64+0x8e/0x810
[    5.427540]  ? do_syscall_64+0x8e/0x810
[    5.427543]  ? count_memcg_events.constprop.0+0x1a/0x30
[    5.427547]  ? handle_mm_fault+0x1d2/0x2d0
[    5.427549]  ? do_user_addr_fault+0x211/0x680
[    5.427553]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.427557] RIP: 0033:0x76d75f09fe56
[    5.427570] Code: 89 df e8 7d bd 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 =
fc 75 15 83 e2 39 83 fa 08 75 0d e8 32 ff ff ff 66 90 48 8b 45 10 0f 05 <48=
> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
[    5.427572] RSP: 002b:00007ffcb620ad70 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000011
[    5.427581] RAX: ffffffffffffffda RBX: 000076d75f67f880 RCX: 000076d75f0=
9fe56
[    5.427582] RDX: 0000000000000006 RSI: 00007ffcb620adf1 RDI: 00000000000=
00023
[    5.427583] RBP: 00007ffcb620ad80 R08: 0000000000000000 R09: 00000000000=
00000
[    5.427584] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00006
[    5.427585] R13: 0000000000000023 R14: 00007ffcb620adf1 R15: 00000000000=
00000
[    5.427588]  </TASK>

any idea what this is about or whether there already is a patch to fix
it? Also I noticed that the patch is not triggered on every boot but
every few boots it can be reproduced.

I'm happy to help debugging / testing patches!

Cheers,
Chris

--s4i5v2jwbxm6njkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgOaJkACgkQwEfU8yi1
JYWZBg//dP50s5kCnT4uY+a9DMJ1gChoCLPRPB193qRA9XWrEeRMNFMeyZJ6rKK6
Rp2yBwIZPVx51xloPFBSbie6j6AqDzD3091Sg0YVo0NNLPGbXXTPIiGgisxRM4Ro
431Src/ilWmwwqvAPubzCyvsvyJ0vXtAEJisd1odNY/GRd9QkdoYxqyuq2XYM9su
5n97Xvw9G5hWkFJdl5BwczUXPQXctbKBPxvMK8JLvpdUWZepxAFE2xiKSFPAVKze
B4b6J8tHj5n48NqLJLQzivcl+64yh820PHqA0AuvzJMHEUas87yklFvEuHvYvEh0
XuYtBw1qW0BoSYjDKZpmpT763DPEmEBxLyrtoK+Se1jWMWuTuob04lvXUNA6kKp4
x+gTn14ZCYhEpqC5QSpb84udSvhnbKWmpvCyjMocVsS6+BdZ5k5INgLYN1e5D561
eLjdr/cTWZXYCF0A0aOyieNAaA9uZ6NWwoyeJf8FmN5bs6bR18HJERLMYZ0W05Jo
dTEYohY1eyY7eQGSzR0O+Pegrta1EvuhDvMDO+ONcN6bN6SFZCBATl/ILQ7OOwCR
zdHsOUHZ8byXwdUFB49lYKTpuXNCCuUrVAbgNJjXf6ULGivSFvbByOHacrqGqu/i
LVXx37FMpjLFn3lit2k05MG7khpcoxRaaclHh4L3gqvBtzPTKAM=
=Fzf/
-----END PGP SIGNATURE-----

--s4i5v2jwbxm6njkc--

