Return-Path: <linux-btrfs+bounces-7292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12957955383
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 00:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56462B22F5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43D145B2D;
	Fri, 16 Aug 2024 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="envPEIER"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCA13C80F
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723848607; cv=none; b=iC7j9QGE3cO26pYi1MGlMc2XXBEsaHLLF/bsQ68LcvwsHjVx4EwVI4B61G+ns7KjYcQA5qX7B3PabTOr26Ybhrz8GI/nMwsfkLAm7tfkmPhsjE0fR8BPAIjBNmuQ7C+BXO5+1g86K6hdXiLfNVDg+rQgqZo5YYyO6nIqHreNV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723848607; c=relaxed/simple;
	bh=CoYGVRSPbj3vLpPiLJXsyQqPfRC39o3qEP3ZAo4ZV5E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dh+Nl7Pl9s6AlRlRGrNPwxF+W1n3/zpmBLamgbuH3kP8/Fe1b/Ylmnkk0PfjZpggT6JZAxJqj2/OVEwc2K7pjIUKDbOKxyzJgz4oIzca6/XOU4SppjG5uz/jL2iDqbIoSdsnt2m1VhmR7V+unCuU+FCM6FSswW6euQJ4u+zJUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=envPEIER; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7106cf5771bso2181199b3a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 15:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723848605; x=1724453405; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WUpRi6DprrWg85jmmqTARRCehk6gVmqCr+IGneJ4g90=;
        b=envPEIERg1kKcl18UNZxdUETdaeFVif1xAuMAKgQGeRZ5ic/2+jT3AOSBR3NqYVSWb
         /VP+QRN+S8T0V7lduSG/vdW8YjxCwe7aBKZpEyBiZo9/T2RgUIP/p9MkoIk6J8XxeGDE
         FfevFIkAnlkvDuV5LXIyy8V1rxiUlZ0cZFjoLnIYbWW15nJA3E5wiWhvcY+m7RP9iRtc
         PtNcz+meS1XoTdBsEJb+rZONtqRghH4Z7ouC97+I/5i6gT6424PFQAuDu0+8U4sYxufy
         ziKYi3Ee2iDVIkXgHKJbv90jZkGd3j8gMeC/98ULm4XAl7poeh9sHDZPk26OxHq0mJQp
         nTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723848605; x=1724453405;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUpRi6DprrWg85jmmqTARRCehk6gVmqCr+IGneJ4g90=;
        b=Ocw5m1ap57u1rEUiEqJvXjHbzJ4OScevyNwP0A14mKzM4CtVCRLEiXw6P5oCZLpSvY
         wsXada80r7ea/ugTwEKNo/j5kthrtGN5lGAX4LZIQdPpuEd5wGG7Lls08fEjQfK7uRos
         jmSVpwJ+5M5eggwnSi+Kghip44KfrHspPj3BrzK7wF31NVdlvKI6YjGT92B7ltNYFWYl
         QIJxiWdQobqq0i0xFGPS8ftxvchi5U6Sn6c5nV7cK6Yllf4/QIhicHcCMiqKqBgMj5oP
         6V0l6TrAieY+Zv8MD1gGQRc4FScZHcCJ4s6eqBLLsPFfDE37pxrPEMegg6MtytON8Erb
         7bfg==
X-Gm-Message-State: AOJu0YxgwW+3Jwu5P6OapnScvMT8lI68l/cDjg3eHyk5HlVIFNPUIYUj
	XD4FS7Ymey+DCWNuNZokEobgGHA2PP5TYRj4ARj7sWae5Ow8V943fkIFaQrzBgQg1d9yZWYna8q
	65PNejOriroe2YbvgnqQMAFJof73SYlj9
X-Google-Smtp-Source: AGHT+IGRlljRozDCwZ0PGa5M8NfUWsalBkWiIW0bkG+xBgz9/GJKuO6EpQHoy3Bo/xoJE0mQr72bywRPjwKvejhl0JQ=
X-Received: by 2002:a05:6a20:d50c:b0:1c6:fc79:f9b7 with SMTP id
 adf61e73a8af0-1c905063993mr4972232637.48.1723848605027; Fri, 16 Aug 2024
 15:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cody <codeology.lab@gmail.com>
Date: Fri, 16 Aug 2024 18:49:53 -0400
Message-ID: <CA+Zc76WnsF2jZn35tAhtdqapem5W3bJeHd17SZ4dsRHCf1bxHw@mail.gmail.com>
Subject: btrfs-transaction generates high disk write
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

The process btrfs-transaction generated 440MB writes within 3 hours on
an idle machine running only the "iotop -a" command in a Bash shell.
On another occasion, it generated 4.86GB (gigabytes) a day. Is this
level of writing beyond normal? Does that hurt NVMe lifespan?

* Specifications
OS: Fedora 40
Kernel: 6.10.4-200.fc40.x86_64
Storage Device: WD BLACK SN750 NVMe SSD, 1TB

* Disk layouts and mounting options
iotop screenshot: https://postimg.cc/nCyQdY97
lsbk screenshot: https://postimg.cc/FfmkvrZH
findmnt screenshot: https://postimg.cc/2qwb8scF

Text-based output below:

[root@fedora ~]# lsblk /dev/nvme0n1
NAME              MAJ:MIN   RM    SIZE      RO   TYPE     MOUNTPOINTS
nvme0n1          259:0            0    931.5G     0      disk
=E2=94=9C=E2=94=80nvme0n1p1 259:1            0      600M      0      part  =
   /boot/efi
=E2=94=9C=E2=94=80nvme0n1p2 259:2            0          1G      0      part=
     /boot
=E2=94=94=E2=94=80nvme0n1p3 259:3            0   929.9G      0      part   =
  /home

                 /
[root@fedora ~]# findmnt
TARGET                                        SOURCE
            FSTYPE                      OPTIONS
/
/dev/nvme0n1p3[/root]           btrfs
rw,relatime,seclabel,ssd,discard=3Dasync,space_cache,subvolid=3D257,subvol=
=3D/root
=E2=94=9C=E2=94=80/dev                                          devtmpfs
                 devtmpfs
rw,nosuid,seclabel,size=3D4096k,nr_inodes=3D4079012,mode=3D755,inode64
=E2=94=82 =E2=94=9C=E2=94=80/dev/hugepages                    hugetlbfs
        hugetlbfs
rw,nosuid,nodev,relatime,seclabel,pagesize=3D2M
=E2=94=82 =E2=94=9C=E2=94=80/dev/mqueue                         mqueue
        mqueue
rw,nosuid,nodev,noexec,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/dev/shm                               tmpfs
              tmpfs
rw,nosuid,nodev,seclabel,inode64
=E2=94=82 =E2=94=94=E2=94=80/dev/pts                                 devpts
               devpts
rw,nosuid,noexec,relatime,seclabel,gid=3D5,mode=3D620,ptmxmode=3D000
=E2=94=9C=E2=94=80/sys                                          sysfs
                    sysfs
rw,nosuid,nodev,noexec,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/selinux                       selinuxfs
            selinuxfs                      rw,nosuid,noexec,relatime
=E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/debug                 none
         debugfs
rw,nosuid,nodev,noexec,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/tracing                tracefs
           tracefs
rw,nosuid,nodev,noexec,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/fuse/connections       fusectl
       fusectl                         rw,nosuid,nodev,noexec,relatime
=E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/security               securityfs
         securityfs                    rw,nosuid,nodev,noexec,relatime
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup                       cgroup2
          cgroup2
rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate,memory_recursiveprot
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/pstore                        pstore
             pstore
rw,nosuid,nodev,noexec,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/sys/firmware/efi/efivars       efivarfs
        efivarfs                       rw,nosuid,nodev,noexec,relatime
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/bpf                            bpf
                 bpf
rw,nosuid,nodev,noexec,relatime,mode=3D700
=E2=94=82 =E2=94=94=E2=94=80/sys/kernel/config                configfs
          configfs
rw,nosuid,nodev,noexec,relatime
=E2=94=9C=E2=94=80/proc                                       proc
                    proc
rw,nosuid,nodev,noexec,relatime
=E2=94=82 =E2=94=94=E2=94=80/proc/sys/fs/binfmt_misc     systemd-1
   autofs
rw,relatime,fd=3D37,pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,direct,p=
ipe_ino=3D18546
=E2=94=82   =E2=94=94=E2=94=80/proc/sys/fs/binfmt_misc   binfmt_misc
  binfmt_misc               rw,nosuid,nodev,noexec,relatime
=E2=94=9C=E2=94=80/run                                        tmpfs
                    tmpfs
rw,nosuid,nodev,seclabel,size=3D6535660k,nr_inodes=3D819200,mode=3D755,inod=
e64
=E2=94=82 =E2=94=94=E2=94=80/run/user/1000                    tmpfs
            tmpfs
rw,nosuid,nodev,relatime,seclabel,size=3D3267828k,nr_inodes=3D816957,mode=
=3D700,uid=3D1000,gid=3D1000,inode64
=E2=94=82   =E2=94=9C=E2=94=80/run/user/1000/gvfs          gvfsd-fuse
      fuse.gvfsd-fuse
rw,nosuid,nodev,relatime,user_id=3D1000,group_id=3D1000
=E2=94=82   =E2=94=94=E2=94=80/run/user/1000/doc           portal
         fuse.portal
rw,nosuid,nodev,relatime,user_id=3D1000,group_id=3D1000
=E2=94=9C=E2=94=80/home                                    /dev/nvme0n1p3[/=
home]
   btrfs
rw,relatime,seclabel,ssd,discard=3Dasync,space_cache,subvolid=3D256,subvol=
=3D/home
=E2=94=9C=E2=94=80/boot                                      /dev/nvme0n1p2
          ext4                           rw,relatime,seclabel
=E2=94=82 =E2=94=94=E2=94=80/boot/efi                              /dev/nvm=
e0n1p1
        vfat
rw,relatime,fmask=3D0077,dmask=3D0077,codepage=3D437,iocharset=3Dascii,shor=
tname=3Dwinnt,errors=3Dremount-ro
=E2=94=9C=E2=94=80/tmp                                       tmpfs
                   tmpfs
rw,nosuid,nodev,seclabel,size=3D16339152k,nr_inodes=3D1048576,inode64
=E2=94=9C=E2=94=80/var/lib/nfs/rpc_pipefs            sunrpc
         rpc_pipefs                  rw,relatime

