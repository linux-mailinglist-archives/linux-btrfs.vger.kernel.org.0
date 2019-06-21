Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926BA4F0EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2019 01:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfFUXAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jun 2019 19:00:19 -0400
Received: from w1.tutanota.de ([81.3.6.162]:53824 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfFUXAT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jun 2019 19:00:19 -0400
Received: from w2.tutanota.de (unknown [192.168.1.163])
        by w1.tutanota.de (Postfix) with ESMTP id BF5E1FA015E
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2019 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuta.io; s=20161216;
        t=1561158016; bh=M0pJxPgVheW4S7Y9IpSMyJri2WI7fF1Kyv0f0X6JT0E=;
        h=Date:From:To:In-Reply-To:References:Subject:From;
        b=N96Cz2aRFehXQf3lZ360ws1M1CFgcRYpyCz6RQPXtMv01CBuV54QRCdCT1QkPnf/4
         dU6Rv45IIw4O7juCFE+XxDog070V7XGZV/fGlOaEz9FYlHH1F4iRNNHped+ggodEO2
         /dkS9rMJJvQdAjSudAgzFnJps7aGh79RVJTxnRYPN71pUxGQ0BQy+Zx1iD8xDgAdp7
         SRlB99r19lvhIwKmsObD+HjwPnxjRMG8NgyNBQM8bVa5zKxoSXmD9auXIZE3qi4eV9
         DpmyVneOPfrZ1Ptjh2KA7As78PHjaxWVsdduyDNI1JFLkn8iaEQ62b8idrPV9aVOBn
         +wrs0s/b1cfDg==
Date:   Sat, 22 Jun 2019 01:00:16 +0200 (CEST)
From:   <tyomix@tuta.io>
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <LhwGCp6--3-1@tuta.io>
In-Reply-To: <LhwD3kS--3-1@tuta.io>
References: <LhwD3kS--3-1@tuta.io>
Subject: Re: Can't mount or recover! Help! ERROR: cannot read chunk root
  ERROR: cannot open file system
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


[root@TYOMIX tyomix]# btrfs restore -D /dev/sda3 /dev/null
checksum verify failed on 1048576 found E4E3BDB6 wanted 00000000
checksum verify failed on 1048576 found E4E3BDB6 wanted 00000000
bad tree block 1048576, bytenr mismatch, want=3D1048576, have=3D0
ERROR: cannot read chunk root
Could not open root, trying backup super
checksum verify failed on 1048576 found E4E3BDB6 wanted 00000000
checksum verify failed on 1048576 found E4E3BDB6 wanted 00000000
bad tree block 1048576, bytenr mismatch, want=3D1048576, have=3D0
ERROR: cannot read chunk root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 2434007040=
00
Could not open root, trying backup super
[root@TYOMIX tyomix]#


Jun 22, 2019, 1:46 AM by tyomix@tuta.io:

> [root@TYOMIX tyomix]# mount -t btrfs -o ro,recovery /dev/sda3 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda3, miss=
ing codepage or helper program, or other error.
> [root@TYOMIX tyomix]# mount -t btrfs -o ro,usebackuproot /dev/sda3 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda3, miss=
ing codepage or helper program, or other error.
> [root@TYOMIX tyomix]#=C2=A0 btrfs check /dev/sda3
> Opening filesystem to check...
> checksum verify failed on 1048576 found E4E3BDB6 wanted 00000000
> checksum verify failed on 1048576 found E4E3BDB6 wanted 00000000
> bad tree block 1048576, bytenr mismatch, want=3D1048576, have=3D0
> ERROR: cannot read chunk root
> ERROR: cannot open file system
> [root@TYOMIX tyomix]#=C2=A0=C2=A0 uname -a
> Linux TYOMIX 5.1.9-arch1-1-ARCH #1 SMP PREEMPT Tue Jun 11 16:18:09 UTC 20=
19 x86_64 GNU/Linux
> [root@TYOMIX tyomix]#=C2=A0=C2=A0 btrfs --version
> btrfs-progs v5.1
> [root@TYOMIX tyomix]#=C2=A0=C2=A0 btrfs fi show
> Label: 'Extra'=C2=A0 uuid: 23a08cb0-5289-407f-a1c3-192709bb9476
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used =
96.19GiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size=
 107.42GiB used 99.02GiB path /dev/sdc1
>
> Label: 'Data'=C2=A0 uuid: 2bff7854-bbe0-4368-bf46-8f191805d9ca
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used =
171.19GiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size=
 226.68GiB used 223.01GiB path /dev/sda3
>
>
>

