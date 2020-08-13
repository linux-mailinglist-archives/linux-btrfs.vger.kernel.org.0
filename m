Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121012433B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 07:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgHMFxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 01:53:33 -0400
Received: from avasout06.plus.net ([212.159.14.18]:54267 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHMFxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 01:53:33 -0400
Received: from selket.lasermount.plus.com ([212.159.61.82])
        by smtp with ESMTP
        id 66B7kh6Rvkvt566B8kvpXO; Thu, 13 Aug 2020 06:53:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1597298011; bh=zIct3q8p3txxsc5bcvdIl37SHTwZ4ueoUPhKc5qZMN8=;
        h=Date:From:To:Subject:In-Reply-To:References;
        b=GwHHnVxj53h7bqGlC6xtyq4yqaGOLaTVrJIj4+r94kOQ6PrvFCbpPHEq/EYUHSAYm
         iFeB+YKFAQ7pj3yf5dLigR44hzdqAdrm2tOqeAYrhjW4Hhgk4vp4CBDN3jzG2vetBo
         2PU8sD7MmFd9tnZQ5iB34ZG0ap97mu83wjGyO+pahUXRKhPdULZo3Qn5HV9vTjiZtU
         6einr9qlDpaOf8eKV+wPSOY0PThJw+8nzEUoI/rMlC9quEF+6NHNcQuMoDAewsG2wJ
         NCGo94x+aOWE85bKu9jTk+chhagiFN5YldGE5nVHusfzpIUJYuxhFsPW1IPYp0Ccwq
         i4chrrMTZTSXQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ENCdL2RC c=1 sm=1 tr=0
 a=cA/d63+uTmAYrZgeUCdC6Q==:117 a=cA/d63+uTmAYrZgeUCdC6Q==:17
 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=VwQbUJbxAAAA:8 a=k3OrJ2MH0CxF0l3HTUgA:9
 a=QEXdDO2ut3YA:10 a=RMblk7DMegEA:10 a=AjGcO6oz07-iQ99wixmX:22
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by selket.lasermount.plus.com (Postfix) with ESMTP id BF5A480068
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Aug 2020 06:53:29 +0100 (BST)
Date:   Thu, 13 Aug 2020 06:53:29 +0100
From:   Spencer Collyer <spencer@lasermount.plus.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Write time tree block corruption detected
Message-ID: <20200813065329.117ef895@lasermount.plus.com>
In-Reply-To: <b8fefd9f-3f95-1d81-95f6-f1424640052d@gmx.com>
References: <20200812144915.488db4c7@lasermount.plus.com>
        <b8fefd9f-3f95-1d81-95f6-f1424640052d@gmx.com>
Organization: Lasermount Limited
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CMAE-Envelope: MS4wfJ/8ooI68OMWnmOfl3XxRWPScW91qjH1U/h4jwOVni7NFTEVHWHWAWVIjgLSQuKK/8X6u1rH1X7I0mfbmqx8U7Y5h/gxbP/ZMmarhjH0C/Q1v70RxYzG
 DKpfwZ9n8ZcrZsQc2xM78GM99AIr0a4ZUx+v4qI7N6lzMptkeaC7HdkEGiwNyA8t8qCHUgH2hjs09C/gPaXuFhl4kExijkgB64k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 12 Aug 2020 22:15:23 +0800, Qu Wenruo wrote:
> On 2020/8/12 =E4=B8=8B=E5=8D=889:49, Spencer Collyer wrote:
> > I have just received a 'write time tree block corruption detected'
> > message on a BTRFS fs I use. As per
> > https://btrfs.wiki.kernel.org/index.php/Tree-checker it mentions
> > sending a mail to this mailing list for this case.
> >=20
> > The dmesg output from the error onwards is as follows:
> >=20
> > [17434.620469] BTRFS error (device dm-1): block=3D13642806624256
> > write time tree block corruption detected =20
>=20
> What's the line before this line?
>=20
> That's the most important line, and it's unfortunately not there...
>=20
> Thanks,
> Qu

Oh, didn't realise that. Unfortunately it has gone from the dmesg ring buff=
er, so I can't go back to it.  If it happens again I'll take a copy of the =
full dmesg output so I can go back to it.

The page I mentioned previously (https://btrfs.wiki.kernel.org/index.php/Tr=
ee-checker) just mentions to report the error to this mailing list. Might b=
e an idea to expand that line to explain what needs reporting.

Rereading the linked page, I notice that it says that if it is a write erro=
r that is prevented then the fs should still be OK, and you can run 'btrfs =
check --readonly' to check that. It is 'btrfs check --repair' that it says =
to not run unless told to by a developer. So I'm going to run the '--readon=
ly' check and if that looks good I'll try re-running the command that cause=
d the failure - does that seem reasonable?

Thanks for your attention,

Spencer
