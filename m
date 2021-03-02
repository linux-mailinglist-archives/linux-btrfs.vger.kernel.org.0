Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF8332A15C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Mar 2021 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347686AbhCBFxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 00:53:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:56067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhCBBUd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 20:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614647900;
        bh=xzHQQXnRWOVAIrfNeKZ6iuMquVzug2ij0ZajqJOV4WA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=cfRDH4+nX3Xj3Gs2RxoDsyrkc4wLcIHCfH8a5JoGY2oNGoa7fTWq1rLR0AJLB5Q5c
         J59Ea79aQJuvlyiwN2zDQ+tLrUiAq4FcHqHRj6wUp22NKGwX5oITqSGAgUG1p0K8Zp
         N513XGfHFKchjSyw6srJ59r+97jdcNq7KRco0g04=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqb1W-1lcmAV1EZ6-00mdul; Tue, 02
 Mar 2021 02:18:20 +0100
To:     =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
 <4744a69e-0adb-7cad-577e-7f17741519be@knebb.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Adding Device Fails - Why?
Message-ID: <6e37dc95-cca7-a7fc-774a-87068f03c16b@gmx.com>
Date:   Tue, 2 Mar 2021 09:18:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4744a69e-0adb-7cad-577e-7f17741519be@knebb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UU+8xm83/ilrWrQ4hl4a3IYbMfl8eFilmYYnZ+Kjhz7h6aB+QKX
 iaipFk8dcI1Geg+GP+tsENbnEHA3B879mHgY+OPESCD2q0mOqdcmFovWGd9xTP894/zAbfn
 BGFbx9MoelatXceYzCySQ4oIVawoi6sHy7mebKNfO/I9CrOH1dF9+qVSwcwwmOGkskHPcDH
 bt/7A0diRbtElRVWNx43g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IzW9SlHAdS0=:xhaqn0tFLcgQesW9rAjUjk
 w0lWLc+521zlXonE0LWnghbOcNe6b53U6PfMXBq4m72lFZUTX0E0lUyJMRuiRzC0y/fyp0KWr
 udCljgDCFWWn4P5UvPkrRM9QDBnIeW05hut3jOJhklsblNABiZ3W2qBUdyVfgZ2+cJLCeKWUy
 xuAH04UoMGDwAUTFopxiS+/elcElDUha02f9DaxmUpwdmzVZxHLT6BcTWCNwA0qoYejupSqVD
 RDMXOH2msAKnzaLTQm+LvV52Ud+qSB1Mp7fb4afWJKPo0r4rvLrXxNFwXmpIMUAYWhkdzvoWC
 JDRMBUkTvnMMB/1ZxuUGTs66es4Isv5Aum5kF363N6vbq/FrRdifc1v+neh9Mv22an5+QDadx
 7VW61/5Yukc/O22FPeeW1buOr9eC9sf1vQdpbke7KGbpZFrJD0dtFq+OYcrcoOFwnMFS9fnhh
 VJyio8WkI88uZP5GAJkmKsgbAiO/G/t00lN6Sy7o5riYmJkHdUv5kwNDEwi24MnF9wZic5eGF
 lbHf2qQKO3braCOqu4Yq/FgignWqDCvbgPXyL0BdxREDuRf+KVThGayuCKCjNidmIN9ZxTRMd
 5DBscvKD3u4ptbVywQXd+y7Slhk6wu4R0c3hOYiV11jTDVimLjYlacTnGLKehO10z+Z1hP/3Z
 35Fjrt7yryTXvTLKU1l1a60tUC67ubA7NrZGQtejJa4Kiy4K2eNJ63bSImk73ilQX9kmWFRdt
 7/FmRru//pBXxzcvohTLygd3g2lp/WoNCvJE6OFlxRBxnVdV5fNc0pvvjHyrGs+xe1gQ8ucft
 ZCkNO89Dw2aazQYOYfcsQhpr7hPL/0MAPKkwI2dHjMdmnUpaIoTcqhadnVrg2Hg4uNE236eXx
 TxkhqxgsK5gmnieZG4bg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/2 =E4=B8=8A=E5=8D=881:24, Christian V=C3=B6lker wrote:
> Hi,
>
> just a little update on the issue.
>
> As soon as I omit the encryption part I can easily add the device to the
> btrfs filesystem. It does not matter if the crypted device is on top of
> DRBD or directly on the /dev/sdc. In both cases btrs refuses to add the
> device when a luks-encrypted device is on top.
>
> In case I am swapping my setup (drbd on top of encryption) and add the
> drbd device to btrfs it works without any issues.
>
> However, I prefer the other way round- and as the other two btrfs
> devices are both encryption on top of drbd it should work...
>
> It appears it does not like to add a third device-mapper device...
>
> Let me know how I can help in debugging. If i have some time I will
> setup a machine trying to reproduce this.

Got the problem reproduced here.

And surprisingly, it's something related to btrfs-progs, not the kernel.

I just added one debug info in btrfs-progs, it shows:

$ sudo ./btrfs dev add /dev/test/scratch2  /mnt/btrfs
cmd_device_add: path=3Ddm-5
ERROR: error adding device 'dm-5': No such file or directory

See the problem?

The path which should be passed to kernel lacks the "/dev/test/" prefix,
thus it's not pointing to correct path and cause the ENOENT error, since
there is no "dm-5" in current path.

Thankfully it's already fixed in devel branch with commit 2347b34af4d8
("btrfs-progs: fix device mapper path canonicalization").

The offending patch is 922eaa7b5472 ("btrfs-progs: build: fix linking
with static libmount"), which is in v5.10.1.

You can revert back to v5.10 to workaroud it.


TO David,

Would you consider to add a new v5.10.2 to fix the problem? As it seems
to affect the end user quite badly.

Thanks,
Qu
>
> any ideas otherwise? Let me know!
>
> Thanks!
>
> /KNEBB
>
