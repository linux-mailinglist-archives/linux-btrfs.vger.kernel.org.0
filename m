Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C162B1DCC15
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 May 2020 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgEUL1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 May 2020 07:27:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:34329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgEUL1d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 May 2020 07:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590060452;
        bh=hK2C3ORyCD0Tr2/PIrg1lvZ3WybHgchElY31AG/ILxk=;
        h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
        b=AVNqT/PZY3A+a5w7q8x1ne+GWJYOFjI+CoQ1x6J85op2GVqVsBatw0VaoL+8hf1KV
         U9ACfiln0vKBiXZq0WQbjnLyv00QSVJMM2E1vEEBBRLJYQoMb0QcLsRecS0ved9vGY
         Zfz1J4t4bKsbdaH/sExB8EisYQS2QXFcpFUEeXhI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mail.gomer.local ([77.185.50.222]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1jZBCi3x2h-00XxTy for
 <linux-btrfs@vger.kernel.org>; Thu, 21 May 2020 13:27:32 +0200
Received: by mail.gomer.local (Postfix, from userid 1000)
        id 4B2D9453C9E1; Thu, 21 May 2020 13:27:31 +0200 (CEST)
Date:   Thu, 21 May 2020 13:27:31 +0200
From:   =?iso-8859-1?Q?J=F6rg?= Ebertz <joerg.ebertz@gmx.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Tree-Checker-Error on vServer-Directory
Message-ID: <20200521112731.GC1838@ehud.gomer.local>
References: <20200520155428.GA1810@ehud.gomer.local>
 <f4ef60a7-df8b-71dc-5679-1628c0dda2ea@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ef60a7-df8b-71dc-5679-1628c0dda2ea@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:rj24uY08X0OZRWTVwG+VrgMLuHJJejiRXuleNPAX8TmkTxbPg2M
 7jzTHKomA/VgWNakJ7JxJH0KtgeKoLEOR6IHaO9n7+v0tkWnfLCVIgf/497K42vj/jzyMy5
 9SBZYVM3YCO7SanpBd6qBHn1heNMPEQ/Q9fbrkMKa+RQCCxRKJT8NYqAkeZxvlytUFDNbaQ
 gsV4NbN3Htf61uYOzKzsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JLKCqBRqaX0=:cI0+mlwrJ2whYKIMUtzGMN
 MEwedqoFMZfHvVoukhza2ODSaQVvXc9OYzMlXQUYXK0im9FM6dK2GYuNN0n6WSnyK6SMw6K/5
 5kqMXfvaHOk03BDmBRNpRUtqK7NdNS+Mv06c4bj2kQOd4Pp8tiWQkv8TJ1BMsGZ991FDH50Gp
 eJ0m8KgWRmtb6DGk29lIKCOhKiSJdHuClR2uodS24wLB3Nm201jnSta1kGTaUFRYLD3IeBQYD
 GxwBCwoa3z374ZPDaEdQZwn61QikQqmoCbm9HvO83d1xkJj5dYJSgH3+8ap+4ifOzp4D+rQ6D
 MPFvUlVCoE+36sUA69rPyndtkh1nvwSL3G46Xz4ZIx4D8LVNLCY/q2kMBaVfKAJ6bfO4+V/KF
 BuhqkNmDKkZkrhtRMSz7/lx1+Nn4XI1rC1+hjykxMz5LI57cvHZyFrd/vx6z+GPxM8AaH0660
 0Mxd0AD5IdVhdmuLfmHq5L+KGJp8g98U/0ryzvqDj5YNKcl3o+Dn1F3VtD5jMcvBDkqDYONcZ
 u8AU8aZwPfVB31l+SLk8491MGG3PXPpwiSvc1IYGi5WvVrSzSCKi/p1PxwCYF0b+T4Wy5yLKR
 ix0IeG02S7UupnvZJcN4Z+4EBG1KBkr8RTWSf/To15CZcqUhPs8MH+o4kAoUeqte72D3S0me1
 RZM4IBiLRYdVccj6lgD+pcT5y0nzHcxCukzPpvVFeYGM2XMwfXpiPTIg+L2RTqF4H+IrN12JW
 adTkKtK1fQec8gnLDt5OXHxA5O6ch5VqTgCSg7bVpnK6lcGirT4C589weIBjhLhSQikYOZw3b
 xvl642mxLilqi80XlO7SO+EsHnRwRgUoXPAW1M5Z3+4V2ho4fnFu1G0uni0BVGREQJqJq003d
 OTa683Aildmel4fmXJqNExfHR1BGf+nP54pI5MBYrq41sQVETVFFQFsrCucavPWDRHMbRAOui
 O/FllsvrLoW9Edr4ayA3ppznjWlxAiobDS7emMZydXd3usXujnyJ84feWeSPvRx7RTxW4Lu55
 623J1Wn/KSo1LcVqWRoTrWLOzRW/gKRJnIt2WB5TRmjsK++0OwPY3XeLghxK3+xyJDnUKeNhb
 VGUP6Cilzh6Jp03eGCkG8gsM/sbk5cGth8VGoP06kuKUHN1TZjvOf4NMknKI6LM0ujwK7sKdS
 Z6qYUaqLhl6Cv4oxo3tyWONipFJhJT9l0v1JovfF5eu/hr4OTxeaD4a7RIz4PbJfltJFNxxO4
 dQoap7WY2fBkyryky
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-05-21, Qu Wenruo wrote:

> Btrfs check hasn't add such restrict check yet, and btrfs scrub doesn't
> check the tree contents.
>
> Furthermore, from the bit, it looks like a memory bitflip, and it is
> definitely caused in older kernels which doesn't has such comprehensive
> check.

Running rsync on the entire file system should trigger tree-checker, if
there are other damaged inodes, right?

> If it's a memory bitflip, it's highly recommended to run a full memtest
> to ensure your memory is OK.

I'll do that.

> To recover your data, it can be done by removing the offending inodes
> with older kernel.
>
> The inode can be located using the inode number provided in the dmesg.

  sudo find / -inum 55495 -print

gave me

 /vserver

To remove the inode, I run

  sudo mkdir /vserver2
  sudo cp -a --reflink /vserver /vserver2
  sudo rm /vserver
  sudo mv /vserver2 /vserver

correct?

Joerg
