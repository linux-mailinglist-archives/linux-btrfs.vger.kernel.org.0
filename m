Return-Path: <linux-btrfs+bounces-5737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BA908670
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF61F23EFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2D19006F;
	Fri, 14 Jun 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="Yc1iEpQN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D1148318
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354238; cv=none; b=bVp423iahnZCulHiQHz70kTyNuOf7eXB206//Uaj+QtGdf5R7SXnH0c+6C2yasMhcyakncfQ5njMzOF117wEUP14AcId74VU7Iz81+WkKr/23Ag/l7qnyxUfSaWaYCm/D0M1UvMHgNCcO1gCxygBAIniVNNeUl5kWuOkwrHqHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354238; c=relaxed/simple;
	bh=liS2PvDO+aOpCoeKpzub0ZtFMu9xnxqgDuiy1eJe9Gw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Kl3pOveYfJuJOORRm7VgfkwkxS40/w4qhKwm2QxDBN4OuTeNhCEfS7NooZqdLRkCgHiii78sstLbv/M7NtqGmLw/BQUHZ59XnpQJD9TEls6deLvuF6h7Nc7buzLpZ4nPSDtdLqDG7kg0jw1aSBLWXDSfa3u6zCgjjll9iZ7cVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=Yc1iEpQN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718354233; x=1718959033; i=massimo.b@gmx.net;
	bh=QL1TfoAavyBX1IkTYZUbnPa2yrNVpzjNT9IZJfkwhEo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Yc1iEpQNzjdZg6wdt38082fNF+zFBkg6JzGWcuC7cjr44n6NnyMTyBjqD7pZLaeS
	 Pf7AJVkNKTGQXup8SnTgRyhr03xZk9m/fNvHIWFVu2R0Xwn2w+YpdxwPvYkAAHF8g
	 C++Jo26RkRVd0lhCwsFyAmgZUjwJOhlCjJsSVydrINvDFhsXvKdlCfZxoS7NVQsSQ
	 tTt+omAI6kaCIksBV1fGM27ZAiPBM56GP45eujfqJKqq2LXysjNHUoMgDP/U9z1Ce
	 9pAEGlk2T7khpaYZIrPhuV0KU8H5vqq0dasm90HwzfxmfqWRb9H0AUgHV5rlmVdm4
	 kbMoC+knz7DuTjPIYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gmb ([176.0.151.7]) by mail.gmx.net (mrgmx005 [212.227.17.190])
 with ESMTPSA (Nemesis) id 1MlNpH-1sfb081HtV-00ffyC; Fri, 14 Jun 2024 10:37:13
 +0200
Message-ID: <2ee4cfef0e51d32420e66ef5ae6e1d731a88e4eb.camel@gmx.net>
Subject: Re: I/O blocked after booting
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <874a2dc5-191f-4e20-9f18-998a107b09a5@gmx.com>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
	 <22650868-6777-41ae-a068-37821929be7c@gmx.com>
	 <47440995279bdba442678e807499fff05ee49302.camel@gmx.net>
	 <94addf02f0eac5e5f402f48f41d16cb80d17470b.camel@gmx.net>
	 <874a2dc5-191f-4e20-9f18-998a107b09a5@gmx.com>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Jun 2024 10:32:12 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.2 
X-Provags-ID: V03:K1:nshoPnkG4hUlRWPWStbf0e7XhN7z18xJV5sSc6FfS5YfJ/hiqvC
 y9rPQ9HEnegF19SqKDKvbOeMW4pITXT2ifWRONEEP9oKhUrP1WvowiR6cA3b6xu/aAnfPD3
 utmJhOcexDOKbu0wXLlM7ncfGPQTa5PNczVoTK0VOMZfOvAhaxIsHPptSp7u2eJqpkA14qB
 3LoWp1tJdZPgFziCW06SA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k+ggSOnISyo=;ZekohLuAqql3RBF6C22Tk0T4ocl
 nEhUEDdzKwcO1JF/iyL1WEifsYJsnZj97ozHzjhMkjkPuDoogoBmPziHx8HvHd9PUxdMznbt7
 piVBDGnOjLMf7rF4hyaqCEKTF0HGoTJ/ACR/kgFGdLch9q/5kbu3h2aJRXpN+Klsv2mkdAB84
 K7N41HKd14a/SAdpU+wRcOuxYxP2kCmcbiOrMAX0az7ckT8Y4EeOn77BxC0UNe5+G0dTV+Ua/
 W7EVGB9p7m2EvLDOr1sBHaY/zqDeKkSMcQ81BYMSWXTDspZaKTw2uExGHs0Fohs2J4iqI2p1j
 9CEu1Ad4EV+cpBj9u2JEugsHRzlAa5rRayliUCzpUKowFwttzL0y2QeB6MhpziUux3OiXXPnv
 kE5fwzquogFD7jCrpfnih5nbrp2Pl4/uTFUsL2aEeAdlYRk9QWinn1AJb1Q+9SjGK4rEYdyFR
 9RyvUKZX4YL0IH5Y/jUpWZo6eugJDIjN7OnNoA5PkmA2AkGtKVx6pdpmzOcxLHDpHF9kVTw5K
 c6LJmOQaI4QJ3rAm0MlDBnqYtFWzIFzYEW85JaWG1xpHzH55fI4mV+YA4+a4Ih/h5uJliI6pt
 JGiSUQJpHG01yR5A2nzHoJIUyboyvnZVHpO8nGQKGax58xx45nxzuehkC3fOQus5L/XtOtwq0
 YscHrZeW1UXovPk6TGxGB+oMaId/GuoBy33KHg5T/1q4tpzEAn23Yy5DZw73tI3Udp+EjQkMc
 Cu7gvhZWPV5zC2jyzROO92fJLdiLef0uSXM4Enwj6ITrxMQhqcR2Iub9m6wfiNwi01VUwxPYD
 ydmUaNPcPLmqkPNv5HoAOhVjVly5a85Ri0lmAZLP03rWs=

On Fri, 2024-03-29 at 06:53 +1030, Qu Wenruo wrote:
> I mean you should not do any fstrim/discard to see if everything works
> fine first.
>=20
> This is to make sure the problem is really from the trim/discard part.

I'm still facing this issue, sometimes after boot and sometimes also after
longer uptimes...

Meanwhile I switched from mount option discard=3Dasync to nodiscard.
I also disabled my weekly cronjob doing fstrim -av.

btrfsmaintenance currently looks like this:

# grep PERIOD /etc/default/btrfsmaintenance=20
BTRFS_DEFRAG_PERIOD=3D"none"
BTRFS_BALANCE_PERIOD=3D"none"
BTRFS_SCRUB_PERIOD=3D"monthly"
BTRFS_TRIM_PERIOD=3D"none"

So there should be no trim or discard happen anymore in the background.
I'm going to also disable the SCRUB now, though I doubt it's related to tha=
t.

But I still run into blocked IO sometimes. It's weird, some commands and ap=
ps I
still can run, some others are blocked, maybe due to cached IO. I'm able to
continue doing builds and system updates by the package manager (Gentoo, em=
erge)
in the background but at the same time it fails to start or stop some
applications. I can't even shutdown the window manager or the system proper=
ly.
All data, root and home are on the same btrfs on luks on NVMe or SSD, just
different subvolumes.

In that situation (kernel 6.6.13, rebooting into 6.6.30) there is nothing t=
o see
in dmesg. Looking at the syslog, the last line always is from last night
midnight before the hard reboot via SysRq is done:

Jun 14 00:00:00 [fcron] Job 'run-parts /etc/cron.daily' started for user sy=
stab (pid 29389)
Jun 14 07:51:49 [kernel] Linux version 6.6.30-gentoo (root@gentoo-m) (gcc (=
Gentoo 13.2.1_p20240210 p14) 13.2.1 20240210, GNU ld (Gentoo 2.42 p3) 2.42.=
0) #1 SMP PREEMPT_DYNAMIC Fri Jun 14 07:43:15 CEST 2024

In cron.daily there is nothing special:
# ls /etc/cron.daily/
1metalog_flush*  disabled/  logrotate*  makewhatis*  man-db*  mlocate*  rkh=
unter*  systemd-tmpfiles-clean*

1metalog_flush only does...
kill -USR1 $metalog_pid	# Set metalog to sync...
kill -USR2 $metalog_pid	# Set metalog to async...
... in order to flush the metalog cached logs.

Again after the shutdown doesn't do anything I start using the SysRq series=
 R E
I S U B and again after the E (SIGTERM to all processes) I see some errors =
about
trim popping on the virtual console followed by a call trace:


BTRFS warning (device dm-0): failed to trim 361 block group(s), last error =
-512
BTRFS warning (device dm-0): failed to trim 1 block device(s), last error -=
512
----------------------------[ cut here ]----------------------------------
WARNING: CPU: 0:PID: 4783 at 0xffffffffffffffa025fed3
Modules linked in: af_alg md5 ....
Hardware name:...
RIP:...
Code:...
...
Call Trace:
<TASK>
...
</TASK>
---[ end trace 000000000000 ]---
acpid: exiting
BTRFS info (device dm-2): last umount of filesystem 1d5.....
INIT: Switching to runlevel: 6
...


Could it be that something else could still trigger a trim in the backgroun=
d?
If trim is really the cause of failure, then I wonder that I have that issu=
e on
all my machines with different hardwares, NVMe but also SATA SSDs. Just the
Gentoo Linux installation is almost identical.

Best regards,
Massimo

