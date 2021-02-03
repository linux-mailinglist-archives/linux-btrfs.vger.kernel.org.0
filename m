Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A130E57C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 23:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhBCWBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 17:01:39 -0500
Received: from mail.mailmag.net ([5.135.159.181]:41274 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232825AbhBCWBZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 17:01:25 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2021 17:01:24 EST
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 76180EC08C5
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 12:54:54 -0900 (AKST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1612389294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ukpt2nE+u8wZDsDewYuTssb/d91wTqgpxvo648xJVss=;
        b=zkYUUW1dZja1xRALag+HczpZ9zwmv67BEnViy+ZkNKUPQfIeReZOk+UC1z5iJ9Ej1zp7KR
        urlAdLfcGjpmO3Ca6Mp7cfmWAcwdK+ofL4IgLjfRb/lNv2d4TxqPp/koeEwP1QWPEdzAgG
        dw36yIbWoGLMDy3DJuQM/bTAVVWsNH8=
MIME-Version: 1.0
Date:   Wed, 03 Feb 2021 21:54:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   joshua@mailmag.net
Message-ID: <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
Subject: Large multi-device BTRFS array (usually) fails to mount on boot.
To:     linux-btrfs@vger.kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1612389294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ukpt2nE+u8wZDsDewYuTssb/d91wTqgpxvo648xJVss=;
        b=TqHZNHKwjEmP7T+RT4/6+zdzG0VV/rvWqQaK80AzgyFWdgNH3+AiJbg4S39tCPpESybaVT
        vaztaJjzYjXvLVscJAgpSXP2+jV9wakcIQVTODvSsQWfoOqTop4h3SfJshhk9BfkUdCjox
        tAexWPy9C8SLoxbv/6WqSNc9qjMwWLk=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1612389294; a=rsa-sha256; cv=none;
        b=Sw+kNFWieomKbHkByfmsyeD6SDFfWd4LCnBjRCsy/WGG8F1CPuzdMubdnR2vtxIxu8ejVr
        CMCHy0wBIWZMVx9fp0tYeIv+xt1pFnC6Wn6WG2aBBQS9TZhhHkgYkA5oR5Iasq7cPTIIUd
        Zn6V4DTiqkdz3YFWpcjtLf91BxNDOvU=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good Evening.=0A=0AI have a large BTRFS array, (14 Drives, ~100 TB RAW) w=
hich has been having problems mounting on boot without timing out. This c=
auses the system to drop to emergency mode. I am then able to mount the a=
rray in emergency mode and all data appears fine, but upon reboot it fail=
s again.=0A=0AI actually first had this problem around a year ago, and in=
itially put considerable effort into extending the timeout in systemd, as=
 I believed that to be the problem. However, all the methods I attempted =
did not work properly or caused the system to continue booting before the=
 array was mounted, causing all sorts of issues. Eventually, I was able t=
o almost completely resolve it by defragmenting the extent tree and subvo=
lume tree for each subvolume. (btrfs fi defrag /mountpoint/subvolume/) Th=
is seemed to reduce the time required to mount, and made it mount on boot=
 the majority of the time.=0A=0ARecently I expanded the array yet again b=
y adding another drive, (and some more data) and now I am having the same=
 issue again. I've posted the relevant entries from my dmesg, as well as =
some information on my array and system below. I ran a defrag as mentione=
d above on each subvolume, and was able to get the system to boot success=
fully. Any ideas on a more reliable and permanent solution this this? Tha=
nks much!=0A=0Admesg entries upon boot:=0A[ 22.775439] BTRFS info (device=
 sdh): use lzo compression, level 0=0A[ 22.775441] BTRFS info (device sdh=
): using free space tree=0A[ 22.775442] BTRFS info (device sdh): has skin=
ny extents=0A[ 124.250554] BTRFS error (device sdh): open_ctree failed=0A=
=0Admesg entries after running 'mount -a' in emergency mode:=0A[ 178.3173=
39] BTRFS info (device sdh): force zstd compression, level 2=0A[ 178.3173=
42] BTRFS info (device sdh): using free space tree=0A[ 178.317343] BTRFS =
info (device sdh): has skinny extents=0A=0Auname -a:=0ALinux HOSTNAME 5.1=
0.0-2-amd64 #1 SMP Debian 5.10.9-1 (2021-01-20) x86-64 GNU/Linux=0A=0Abtr=
fs --version:=0Abtrfs-progs v5.10=0A=0Abtrfs fi show /mountpoint:=0ALabel=
: 'DATA' uuid: {snip}=0ATotal devices 14 FS bytes used 41.94TiB=0Adevid 1=
 size 2.73TiB used 2.46TiB path /dev/sdh=0Adevid 2 size 7.28TiB used 6.87=
TiB path /dev/sdm=0Adevid 3 size 2.73TiB used 2.46TiB path /dev/sdk=0Adev=
id 4 size 9.10TiB used 8.57TiB path /dev/sdj=0Adevid 5 size 9.10TiB used =
8.57TiB path /dev/sde=0Adevid 6 size 9.10TiB used 8.57TiB path /dev/sdn=
=0Adevid 7 size 7.28TiB used 4.65TiB path /dev/sdc=0Adevid 9 size 9.10TiB=
 used 8.57TiB path /dev/sdf=0Adevid 10 size 2.73TiB used 2.21TiB path /de=
v/sdl=0Adevid 12 size 2.73TiB used 2.20TiB path /dev/sdg=0Adevid 13 size =
9.10TiB used 8.57TiB path /dev/sdd=0Adevid 15 size 7.28TiB used 6.75TiB p=
ath /dev/sda=0Adevid 16 size 7.28TiB used 6.75TiB path /dev/sdi=0Adevid 1=
7 size 7.28TiB used 6.75TiB path /dev/sdb=0A=0Abtrfs fi usage /mountpoint=
:=0AOverall:=0ADevice size: 92.78TiB=0ADevice allocated: 83.96TiB=0ADevic=
e unallocated: 8.83TiB=0ADevice missing: 0.00B=0AUsed: 83.94TiB=0AFree (e=
stimated): 4.42TiB (min: 2.95TiB)=0AFree (statfs, df): 3.31TiB=0AData rat=
io: 2.00=0AMetadata ratio: 3.00=0AGlobal reserve: 512.00MiB (used: 0.00B)=
=0AMultiple profiles: no=0A=0AData,RAID1: Size:41.88TiB, Used:41.877TiB (=
99.99%)=0A{snip}=0A=0AMetadata,RAID1C3: Size:68GiB, Used:63.79GiB (93.81%=
)=0A{snip}=0A=0ASystem,RAID1C3: Size:32MiB, Used:6.69MiB (20.90%)=0A{snip=
}=0A=0AUnallocated:=0A{snip}
