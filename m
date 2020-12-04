Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A262CEF01
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgLDNum (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 08:50:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:56697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbgLDNum (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 08:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607089750;
        bh=Z16/i3nZI10FrcJTomJv8r6posdW0uL8Ak5jLCmhjww=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:In-Reply-To:References:Date;
        b=WAARr0QzSwt9xGBWpRIUEa9PphhiM4KrbHVuZhLD4FxKx9RenFwhFYIY9FN2J/XvD
         c0vTc7EJYjbdUYCQDudLBsxy12+a8nSQK7cU+E869eRU4QJyaXIVUgs7w7VIx3Uvok
         +yASC1wbMPle1jvC9KHLlEYHQRb/ixiM4D8gRAAk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mobalindesk.lan.lan ([95.116.59.52]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1kmYV90CFp-001RxO; Fri, 04
 Dec 2020 14:49:10 +0100
Message-ID: <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file
 or directory
From:   "Massimo B." <massimo.b@gmx.net>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
         <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
         <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
         <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 04 Dec 2020 14:44:09 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8JsvwI1WWx2qsWxYqDXZANU8UobmBqf6lw6768gSonj8og+A1V+
 kwiCfrMIzIju2UJtnRSQltbUUm8qhqeigK9h0y9GZqbZd9l5vXVVdbpwziiUxqRLcCwjhhi
 yQIqEZ3GqnJfQJPgVBo3hV0bPW/21uv54YwoZWhsDGRR3lhTETGJFD+xq1cUl8D5uR3E9IU
 qnoqdNA7wqzb6fxddhQhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GJynN0RZcuM=:IFUckDCc3WKNoeZMP2gGJi
 FEnyUcLBvVgbsUTrVOeQSCxSwwiWey83wk7lqY8+2GXoXG08tg9f4XnDQQG8ykwyD9Nya4yrN
 4RWqlTFjhoag4VSceUvGt+/ctVMGIx3/bpF8c3HxbVD/7Rzld0SAGSD4glRuC8a6Eul705Kwf
 ZcqM5xDcBRqSAf4t1O84d/hbQZa+q6WKUgffArJ5w+NXt7hy5+Pwyj2yu5lmyHMl2u6SBGlnn
 tRZQByHBgOPAHRsOLJ4U796cJhOLJ8Gk0HTZ89mTNSX8n1z34qoSCHAPxUBfy3fpOedfI4d0Q
 gKxI7HxFLDD9Iud3R7bw4ZSNn5KAUOz4TKRlJZ8VVakSc0jmPsMOKOTeZKeSoW7Q6csCIVbCZ
 5dN5v9AF+fnM4XZAtCaBtCS0N1DmOsHkcJ9QU0TcsovhDdE4m07ZhxqeuMPG7PM3PoOyu/XHr
 kD7yvP5+S509Ijii0pN+BIYpGawuObyjXiQsVBTafzi0ZFrgqY0P/NqKokFKLHxFgcSs5xokN
 THZIou6+mtQatKbgB4/EOXPChWmOBI4vYtoKRjdeDqu9jSTkuOyomiPyv+vMcE7MqefZiox5y
 BcxpPmG4CAJIN1HwJiu4dSTj1bbhlRtCUQPKFPeUTh/YZeQHodgNn+CyXrYgkFvy4chPWyIqV
 mqWbbmIaWHx94M31knYyEkdAUY/ulW9GqfJb+p56O82loQIVyYaY+D/NyJY+atXARJ0LKvkgK
 ldQEMJglPb2ICJ8SYqq1EspnYYjkl5UuWBbSTmaq9CUo5D2RVsKqjNv/+h9mmkY1Ni9+kgDJW
 XCapiAVArSrMfdzH90u30t3cGXm8nUnYn1D46YLxqLIjODjR3nRydtsx96WjuAp9W3SaM4Rpd
 4K2GZ9/h24ODzo/kv4pw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-12-04 at 10:22 +0000, Filipe Manana wrote:

> Ah, that's interesting.
>
> There are two different inodes with the same number (257) and
> different generations (359797 and 1571). Are you using, or ever used,
> in that filesystem the mount option "-o inode_cache" (it's deprecated
> for a while)?

No.
Which mount options do you need, the sending or the receiving btrfs?
My mount options on the receiving:

/dev/mapper/localdata_crypt on /mnt/autofs/local/data type btrfs (rw,noati=
me,nodiratime,compress-force=3Dzstd:15,noacl,space_cache=3Dv2,subvolid=3D5=
,subvol=3D/)

Maybe that space_cache=3Dv2 is special.

> Even if not, it's still possible to get two different inodes with the
> same number, just not very common (specially with such a large
> difference in the generation numbers), and send is generally prepared
> to deal with such cases, just not this case, and I think I know why it
> happens. I'll have to see if I can reproduce it.
>
> If I send you a patch, are you able to patch the kernel, build it and te=
st it?

Yes, I will try.

Best regards,
Massimo

