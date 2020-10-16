Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6827B290981
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409816AbgJPQSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 12:18:15 -0400
Received: from waffle.tech ([104.225.250.114]:54090 "EHLO mx.waffle.tech"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409702AbgJPQSP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 12:18:15 -0400
Received: from mx.waffle.tech (unknown [10.50.1.6])
        by mx.waffle.tech (Postfix) with ESMTP id 90D1B6D807;
        Fri, 16 Oct 2020 10:18:12 -0600 (MDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.waffle.tech 90D1B6D807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waffle.tech; s=mx;
        t=1602865092; bh=g+e059dAp5+y1BT10SBQkD7QSOk8gUZV2NeS+VgUcME=;
        h=Date:From:Subject:To:In-Reply-To:References:From;
        b=lbHBJuuvCV7Ew4JB4S4huHGg2GkJ7QIHnkKpLae5izYsSVoxb6ZC1jXq2J2WrsTM6
         r8XRIJQ7478CDNLaHOQZUTwkz0lKL+J7pwtdUcrsVfA2KK0L/SLCiIdRHO/XbW9NV8
         tmr9S/mkJWb8ibgkWx/lulbUQ+a+6Jtiwh3beE3w=
Received: from waffle.tech ([10.50.1.3])
        by mx.waffle.tech with ESMTPSA
        id cFYUIsTHiV+sZwcAQqPLoA
        (envelope-from <louis@waffle.tech>); Fri, 16 Oct 2020 10:18:12 -0600
MIME-Version: 1.0
Date:   Fri, 16 Oct 2020 16:18:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From:   louis@waffle.tech
Message-ID: <3ac1cd1113ac25f11bbed6c90d814fd8@waffle.tech>
Subject: Re: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
To:     "Nikolay Borisov" <nborisov@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <4226ff1b-e313-2881-0670-965e7e98ce59@suse.com>
References: <4226ff1b-e313-2881-0670-965e7e98ce59@suse.com>
 <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.waffle.tech
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

October 16, 2020 1:15 AM, "Nikolay Borisov" <nborisov@suse.com> wrote:=0A=
=0A> On 16.10.20 =D0=B3. 8:59 =D1=87., louis@waffle.tech wrote:=0A> =0A>>=
 Balance RAID1/RAID10 mirror selection via plain round-robin scheduling. =
This should roughly double=0A>> throughput for large reads.=0A>> =0A>> Si=
gned-off-by: Louis Jencka <louis@waffle.tech>=0A> =0A> Can you show numbe=
rs substantiating your claims?=0A=0ASure thing. Below are the results fro=
m some tests I've run using a Debian 10 VM. It has two 10GiB disks attach=
ed which are each independently limited to 100MB/s total IO (using libvir=
t's iotune feature). They've been used to create the RAID1 volume mounted=
 at /mnt. I've truncated the fio output to just show the high-level stats=
.=0A=0AReading a large file performs twice as well with the patch applied=
 (203 MB/s vs 101 MB/s). Writing a large file, and the random read-write =
tests, look like they perform roughly the same to me.=0A=0ALouis=0A=0A---=
=0A=0AWithout patch=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=0Alouis@=
debian:/mnt$ uname -a=0ALinux debian 4.19.0-11-amd64 #1 SMP Debian 4.19.1=
46-1 (2020-09-17) x86_64 GNU/Linux=0A=0Alouis@debian:/mnt$ btrfs fi df /m=
nt=0AData, RAID1: total=3D7.00GiB, used=3D2.00MiB=0ASystem, RAID1: total=
=3D8.00MiB, used=3D16.00KiB=0AMetadata, RAID1: total=3D1.00GiB, used=3D68=
8.00KiB=0AGlobalReserve, single: total=3D29.19MiB, used=3D352.00KiB=0A=0A=
louis@debian:/mnt$ dd if=3D/dev/urandom of=3D/mnt/test bs=3D1M count=3D10=
24 conv=3Dfdatasync=0A1024+0 records in=0A1024+0 records out=0A1073741824=
 bytes (1.1 GB, 1.0 GiB) copied, 12.928 s, 83.1 MB/s=0A=0Alouis@debian:/m=
nt$ dd if=3D/mnt/test of=3D/dev/null=0A2097152+0 records in=0A2097152+0 r=
ecords out=0A1073741824 bytes (1.1 GB, 1.0 GiB) copied, 10.6403 s, 101 MB=
/s=0A=0Alouis@debian:/mnt$ fio --name=3Drandom-rw --ioengine=3Dposixaio -=
-rw=3Drandrw --bs=3D4k --numjobs=3D2 --size=3D2g --iodepth=3D1 --runtime=
=3D60 --time_based --end_fsync=3D1=0Arandom-rw: (g=3D0): rw=3Drandrw, bs=
=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=3Dposixaio=
, iodepth=3D1=0A...=0ARun status group 0 (all jobs):=0A   READ: bw=3D15.8=
MiB/s (16.5MB/s), 7459KiB/s-8671KiB/s (7638kB/s-8879kB/s), io=3D964MiB (1=
010MB), run=3D61179-61179msec=0A  WRITE: bw=3D15.8MiB/s (16.6MB/s), 7490K=
iB/s-8682KiB/s (7670kB/s-8890kB/s), io=3D966MiB (1013MB), run=3D61179-611=
79msec=0A=0A=0AWith patch=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=0Alouis@deb=
ian:/mnt$ uname -a=0ALinux debian 4.19.0-11-amd64 #1 SMP Debian 4.19.146-=
1a~test (2020-10-15) x86_64 GNU/Linux=0A=0Alouis@debian:/mnt$ dd if=3D/de=
v/urandom of=3D/mnt/test bs=3D1M count=3D1024 conv=3Dfdatasync=0A1024+0 r=
ecords in=0A1024+0 records out=0A1073741824 bytes (1.1 GB, 1.0 GiB) copie=
d, 11.8067 s, 90.9 MB/s=0A=0Alouis@debian:/mnt$ dd if=3D/mnt/test of=3D/d=
ev/null=0A2097152+0 records in=0A2097152+0 records out=0A1073741824 bytes=
 (1.1 GB, 1.0 GiB) copied, 5.28642 s, 203 MB/s=0A=0Alouis@debian:/mnt$ fi=
o --name=3Drandom-rw --ioengine=3Dposixaio --rw=3Drandrw --bs=3D4k --numj=
obs=3D2 --size=3D2g --iodepth=3D1 --runtime=3D60 --time_based --end_fsync=
=3D1=0Arandom-rw: (g=3D0): rw=3Drandrw, bs=3D(R) 4096B-4096B, (W) 4096B-4=
096B, (T) 4096B-4096B, ioengine=3Dposixaio, iodepth=3D1=0A...=0ARun statu=
s group 0 (all jobs):=0A   READ: bw=3D16.5MiB/s (17.3MB/s), 8217KiB/s-865=
2KiB/s (8414kB/s-8860kB/s), io=3D1025MiB (1074MB), run=3D62202-62202msec=
=0A  WRITE: bw=3D16.5MiB/s (17.3MB/s), 8218KiB/s-8698KiB/s (8415kB/s-8907=
kB/s), io=3D1028MiB (1077MB), run=3D62202-62202msec
