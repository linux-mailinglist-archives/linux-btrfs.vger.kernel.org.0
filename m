Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F5E2320D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfETLPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 07:15:12 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:12374 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbfETLPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 07:15:11 -0400
Date:   Mon, 20 May 2019 11:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1558350908;
        bh=eXl8IDsc8nZSaNY0f07eIszd0a3aDF54QdwrudyyNlI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=LY4QGyNj0MDmmpt8YC4pK4WxsLRMW4Gx+oJ/WSRTbHDBCuA180jVbv9JkzUeACssh
         tS9+DRyRbVjJtylZ10bVAZK2aoquWFt6J2kS11uTH3N234qVMSBcI4Y/y7/FLU8FNi
         HdPBIPEBn+O1B0a0s9OIx431aS7E3VubC7hEpRRc=
To:     Patrik Lundquist <patrik.lundquist@gmail.com>
From:   Newbugreport <newbugreport@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Reply-To: Newbugreport <newbugreport@protonmail.com>
Subject: Re: Btrfs send bloat
Message-ID: <ZBp4TxX3BVubLSjbbtXjztW20HT6YFrXCMMV6IX3xamgZbnpU4KJvO5vs0tcF5po8Ay4KdgGyffZ2DHitm4X4Hm0CFMPCjC2g_HHS9CR51M=@protonmail.com>
In-Reply-To: <CAA7pwKM_1uWbu9ECgkqAMXMWTOJm5xH1wvHKFwq+7w=JeQQ7xg@mail.gmail.com>
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
 <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com>
 <CAA7pwKM_1uWbu9ECgkqAMXMWTOJm5xH1wvHKFwq+7w=JeQQ7xg@mail.gmail.com>
Feedback-ID: d6Wm0FJd7i1jFe-FGWugBSsNs-8bq-rQNjTlE-phxxZwlQCWXnoyvi9qcr4gYuV_Fena2XhvJGc4qqroBLRNtw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patrik, thank you. I've enabled the SAMBA module, which may help in the fut=
ure. Does the GUI file manager (i.e. Nautilus) need special support?

Andrea, thank you for the link. bup is impressive but does it work well wit=
h btrfs snapshots? My live drive contains the main volume alongside many sn=
apshots and the associated bloat from moved/deleted files. There's not room=
 for another copy of everything, even if it's deduplicated. Perhaps I could=
 switch one of the backup drives and the cloud to bup, but how well would b=
up work diffing all those snapshots when the backup drive is plugged in?


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, May 20, 2019 10:34 AM, Patrik Lundquist <patrik.lundquist@gmail.=
com> wrote:

> On Mon, 20 May 2019 at 02:36, Andrei Borzenkov arvidjaar@gmail.com wrote:
>
> > 19.05.2019 11:11, Newbugreport =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >
> > > I have 3-4 years worth of snapshots I use for backup purposes. I keep
> > > R-O live snapshots, two local backups, and AWS Glacier Deep Freeze. I
> > > use both send | receive and send > file. This works well but I get
> > > massive deltas when files are moved around in a GUI via samba.
> >
> > Did you analyze whether it is client or server problem? If client does
> > file copy (instead of move as you imply) may be the simplest solution
> > would be to use different tool on client. If problem is on server side,
> > it is something to discuss with SAMBA folks.
>
> Also try the Btrfs module in Samba.
> https://wiki.samba.org/index.php/Server-Side_Copy#Btrfs_Enhanced_Server-S=
ide_Copy_Offload


