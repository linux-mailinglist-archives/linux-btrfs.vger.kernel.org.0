Return-Path: <linux-btrfs+bounces-10171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE119E9BBC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 17:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D19218856B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2313D518;
	Mon,  9 Dec 2024 16:34:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC419BA3D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762041; cv=pass; b=XP8ySj+lC9GwkHUkFrgr3tmr4dAz4MCUs5yuHjRLoFhkSpvfkOxpWtOiZBY+wcrl3cJPkrer8CwwrJAXbnOTSRMUDujBwiMo2G4QfFbkZ/ziLCAGTG2qWtCT5k0xhcZEEcC5iObW0NWsM1u1NqWVuTQVt9oWfV1NuLExslhbGIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762041; c=relaxed/simple;
	bh=8UEozKCpw61SnE7vfZJOi+dheElXjbvrR04eQtx6iEw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=LBzGYX2eIN6SDVTwOOqL9FWAe8ZhMpPpij+mdYCBmIjmcR2MOZYlS2tKhb3GQ6eLPpTC90HMclDkJH7qwxK7D7kGohBlngLrS0dHyGnuUChcIiR2gvN2WMlioEAh7XXmYj26A0baGWFdPnfDli76Ye5rhdRrroi3tnMjhF7Js0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8EA4B823742
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 16:33:52 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-101-211-3.trex-nlb.outbound.svc.cluster.local [100.101.211.3])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id DBC66823E98
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 16:33:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733762032; a=rsa-sha256;
	cv=none;
	b=1+jWJLg4GVeeauDc7VUko1UBbJIpkyePsZMCJO7x9k/O9u/rQm8AeVlTvU7XHMyXRMWVJu
	owM/q5QPm31mdmvMsTlQQbe7M5mjZeUWjlrIrnDNbAqCWUe5iFzNpSy5kVICzd6X+5YmyY
	l42f7y5Ou6GlKycmUV+ubZJsBME9v3cAZWQQdtn3xxuzGJvUh2FfmJjktZP7LcFK2SvKgq
	8bFM4tTVewi0W/3V9REnf+L2azGGYZ07mUyfPwE7e34tULb7e82x+FIq+NsOptNYH5gRm0
	CzYH2VzKtYnQK8rNEpLMebFgzykw7oFsBq0HrzpvL6iyIg5R+9/azcGaHToy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733762032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JXylGQtTdmxyzaTLUzOx0ihFdA5MxJOuWxhoa6XzPXE=;
	b=ZpoCXbLEH5yJRWXiTmGbm6kddxvWSVJD7okGIvLIqY8n74l3t1n74EVJjsDjFZbbd0tqVd
	J7gJ1ltdtlHvtjYvy8pGgxyiFOdznIHHUxyG/VrMb9sKGUABGqk48CI7nOTKm/DCGQXHhd
	XFtKwfcGq+Cx5lIDdRQHBfhynrtCkKKsVOqMXaj4EoSMH/urpr48PDfbUpd3gvPMTil2II
	02+jkkL5BOCin8+9peNvB2ZB7vP2KBp8tCrIaOyQE5OqCZOTCvA/iXq7IveGt5qtrpLbet
	5rNCXZFJx042TaYoB3bEMpS6bk1NnO3Ymu7kDyJfeGxfAeEJSvVd241hqumq9A==
ARC-Authentication-Results: i=1;
	rspamd-fc7fd4597-lj45x;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Eight-Turn: 19e949ef53896770_1733762032374_3036714686
X-MC-Loop-Signature: 1733762032374:1984054255
X-MC-Ingress-Time: 1733762032374
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.211.3 (trex/7.0.2);
	Mon, 09 Dec 2024 16:33:52 +0000
Received: from dhcp-138-246-3-122.dynamic.eduroam.mwn.de ([138.246.3.122]:49090 helo=[10.183.183.181])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <calestyo@scientia.org>)
	id 1tKghi-0000000F9ci-1ZLx
	for linux-btrfs@vger.kernel.org;
	Mon, 09 Dec 2024 16:33:50 +0000
Message-ID: <9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org>
Subject: super slow mounts and open_ctree failed
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs@vger.kernel.org
Date: Mon, 09 Dec 2024 17:33:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

Maybe someone has an idea about the following:

We run a cluster of storage servers, quite recent ones from Dell with
24 HDDs that are exported to 15 logical drives (each 32 TiB or a bit
less) by the controller, using (hardware) RAID6.

Distro is Debian stable with kernel 6.1.0-27-amd64.

One one of the nodes, a HDD failed during the weekend (replacement
hasn't arrived yet), but (hardware) RAID6, there could of course fail
even another one.

All the logical drives have btrfs.


Now the weird thing is the following:

When I rebooted the server it mounted a few of them, but after ~5 mins
or so failed to mount the others with:
[   53.184591] BTRFS info (device sdb): first mount of filesystem f915afcd-=
3719-42e8-9969-c3208ac4a169
[   53.195777] BTRFS info (device sdb): using crc32c (crc32c-intel) checksu=
m algorithm
[   53.204542] BTRFS info (device sdb): using free space tree
[   54.237216] BTRFS info (device sdm): first mount of filesystem f10390bd-=
1cef-4e79-8848-64cb9ba035c8
[   54.248601] BTRFS info (device sdm): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.258155] BTRFS info (device sdm): using free space tree
[   54.284450] BTRFS info (device sdn): first mount of filesystem e5eb00fe-=
af60-4560-8de4-23206b276f5f
[   54.296441] BTRFS info (device sdn): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.305012] BTRFS info (device sdn): using free space tree
[   54.490924] BTRFS info (device sdl): first mount of filesystem 465ecad0-=
6f2d-4c82-8a97-534446d53603
[   54.500669] BTRFS info (device sdl): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.508991] BTRFS info (device sdl): using free space tree
[   54.767514] BTRFS info (device sde): first mount of filesystem 6f96fa48-=
93e6-4b90-a94e-c24b899a9241
[   54.776986] BTRFS info (device sde): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.785013] BTRFS info (device sde): using free space tree
[   54.791066] BTRFS info (device sda): first mount of filesystem 04bd35d7-=
97a1-4e02-b8bb-525ca25c5e8e
[   54.791364] BTRFS info (device sdf): first mount of filesystem 1bd9f4a0-=
0d17-4e47-b4f0-9c6089f3d85c
[   54.791552] BTRFS info (device sdj): first mount of filesystem 30a91258-=
8a7d-4874-b260-106d9eba14bb
[   54.791581] BTRFS info (device sdj): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.791591] BTRFS info (device sdj): using free space tree
[   54.800494] BTRFS info (device sda): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.810274] BTRFS info (device sdf): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.810432] BTRFS info (device sdk): first mount of filesystem 4a7ff844-=
2ed7-4ab4-90ea-35ed1f302aad
[   54.810446] BTRFS info (device sdk): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.810452] BTRFS info (device sdk): using free space tree
[   54.810780] BTRFS info (device sdg): first mount of filesystem 0babee90-=
f75e-490c-8a3b-98f77f4410a9
[   54.810804] BTRFS info (device sdg): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.810814] BTRFS info (device sdg): using free space tree
[   54.810812] BTRFS info (device sdi): first mount of filesystem ce70f65b-=
7118-4fa3-8e28-0e2b8028ceb6
[   54.810836] BTRFS info (device sdi): using crc32c (crc32c-intel) checksu=
m algorithm
[   54.810845] BTRFS info (device sdi): using free space tree
[   54.819298] BTRFS info (device sda): using free space tree
[   54.826970] BTRFS info (device sdf): using free space tree
[   55.070783] BTRFS info (device sdd): first mount of filesystem b9fac730-=
ec13-4b70-9a84-78e9f9497cab
[   55.080158] BTRFS info (device sdd): using crc32c (crc32c-intel) checksu=
m algorithm
[   55.088123] BTRFS info (device sdd): using free space tree
[   55.094137] BTRFS info (device sdh): first mount of filesystem d3cde25e-=
b9b3-49c0-81e0-8b18b09f15ca
[   55.094225] BTRFS info (device sdc): first mount of filesystem bd453578-=
8008-428d-ad7d-32f2da5cd7a9
[   55.103561] BTRFS info (device sdh): using crc32c (crc32c-intel) checksu=
m algorithm
[   55.113032] BTRFS info (device sdc): using crc32c (crc32c-intel) checksu=
m algorithm
[   55.120690] BTRFS info (device sdh): using free space tree
[   55.135355] BTRFS info (device sdc): using free space tree
[  267.836887] BTRFS error (device sdj): open_ctree failed
[  268.316577] BTRFS: device label data-a-3 devid 1 transid 231030 /dev/sdj=
 scanned by mount (4175)
[  268.355695] BTRFS info (device sdj): first mount of filesystem 30a91258-=
8a7d-4874-b260-106d9eba14bb
[  268.367263] BTRFS info (device sdj): using crc32c (crc32c-intel) checksu=
m algorithm
[  268.375604] BTRFS info (device sdj): using free space tree
[  270.914917] BTRFS error (device sdk): open_ctree failed
[  271.014560] ens1f0 speed is unknown, defaulting to 1000
[  271.265328] ice 0000:17:00.1 eth0: NIC Link is up 25 Gbps Full Duplex, R=
equested FEC: RS-FEC, Negotiated FEC: FC-FEC/BASE-R, Autoneg Advertised: Of=
f, Autoneg Negotiated: False, Flow Control: None
[  271.285199] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  286.072892] BTRFS error (device sdl): open_ctree failed
[  295.934646] BTRFS error (device sdn): open_ctree failed
[  301.649656] BTRFS error (device sdm): open_ctree failed
[  485.912139] BTRFS error (device sdj): open_ctree failed

No other errors are printed, i.e. nothing from the megaraid_sas driver
or any of the typical block layer errors.

Does it time out?


When I later mount the filesystems one by one, it still takes extremely
long, e.g.:
# time mount /dev/sdj

real    3m45,153s
user    0m0,001s
sys     0m0,640s

but succeeds.
Looking at iotop, mount, during that, only reads with about 400 KB/s.

Now you might argue the RAID controller is simply broken, and reads are
super slow, but when doing:
dd if=3D/dev/sdj  of=3D/dev/null status=3Dprogress bs=3D1M
I get several 100MB/s.

mount also doesn't seem to reach any CPU limits, it's basically always
in IO wait.


btrfs check /dev/sdj also reads just with a few 100 KB/s, but gives no
errors:
# btrfs check /dev/sdj
Opening filesystem to check...
Checking filesystem on /dev/sdj
UUID: 30a91258-8a7d-4874-b260-106d9eba14bb
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 29697098264576 bytes used, no error found
total csum bytes: 28968443996
total tree bytes: 33411612672
total fs tree bytes: 131743744
total extent tree bytes: 218857472
btree space waste bytes: 3789582434
file data blocks allocated: 29663686651904
 referenced 29663503867904

It also reads very slowly first (few 100 KB/s) then, goes up to 70
MB/s... but still all wait IO.


Any ideas why btrfs - in contrast to dd - might read so slowly?

No rebuild or so is going on, so this shouldn't cost performance.


I mean it could still be, that the controller is only fast when reading
sequentially, but breaks in when doing random reads.


Does any of this ring any bells?

