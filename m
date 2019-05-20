Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D217123015
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfETJU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 05:20:29 -0400
Received: from hr2.samba.org ([144.76.82.148]:29612 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfETJU3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 05:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Message-ID:Cc:To:From:Date;
        bh=61tRybvWVw6jSWyV2+xBCtkqFpMNe0a6dv7/VbKXlt8=; b=VNJ9fGMUUos/HuIjTMUpUNZrRN
        ECq3mivyx1EKyd6VNpnOLKd132lvz4TuE9MojGl1PsE7ejnBGz+rJC22QoRc+KFFXosJCn2r9QO8r
        8t/VEx512JjNMqfjDdL2W9XxUbTm2KcFhC4LxlUyt4/u1+lfAJWaeE2TB3DaZ4ExalmY=;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1hSeT5-00078F-P2; Mon, 20 May 2019 09:20:27 +0000
Date:   Mon, 20 May 2019 11:20:26 +0200
From:   David Disseldorp <ddiss@samba.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Newbugreport <newbugreport@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs send bloat
Message-ID: <20190520112026.385537ca@samba.org>
In-Reply-To: <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com>
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
        <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 19 May 2019 23:06:25 +0300, Andrei Borzenkov wrote:

> 19.05.2019 11:11, Newbugreport =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I have 3-4 years worth of snapshots I use for backup purposes. I keep
> > R-O live snapshots, two local backups, and AWS Glacier Deep Freeze. I
> > use both send | receive and send > file. This works well but I get
> > massive deltas when files are moved around in a GUI via samba. =20
>=20
> Did you analyze whether it is client or server problem? If client does
> file copy (instead of move as you imply) may be the simplest solution
> would be to use different tool on client. If problem is on server side,
> it is something to discuss with SAMBA folks.

Samba supports copy offload via FSCTL_SRV_COPYCHUNK and
FSCTL_DUPLICATE_EXTENTS_TO_FILE, which can be translated to
BTRFS_IOC_CLONE_RANGE via the btrfs Samba VFS module.

Windows explorer and Linux (cifs.ko) are capable of using these
fsctls during copy.

See https://wiki.samba.org/index.php/Server-Side_Copy for details.

Cheers, David
