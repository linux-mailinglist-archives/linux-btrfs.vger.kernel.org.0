Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAFD2DCA9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 02:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgLQBkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 20:40:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:35525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgLQBkJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 20:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608169117;
        bh=WgY71TADSYNGgDMbBeD+D8guD5dbuZmm+DoAwswNNcE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q1qMsb5emJUE5afCEStqvanXFT7muyTe6djkwaNE/dmaesHhpp2ydxVDS/me9H5pl
         8Dfpn4ngpUsX19g5/FNKlHICAmOT4AHAZiJgfsApAGkzk5i5GQcoYtDLYWzu7/8BJK
         jHY65jSWqyfqWOEBRguBezMNm8i25HiBv1bIvgi0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6sn7-1k1p7j3Bj5-018NO1; Thu, 17
 Dec 2020 02:38:37 +0100
Subject: Re: csum errors on negative root id?
To:     Ross Vandegrift <ross@kallisti.us>, linux-btrfs@vger.kernel.org
References: <20201216192808.lodnlgbdxefayn2c@vanvanmojo.kallisti.us>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d48ca767-02df-5d86-d6bf-c91054a786da@gmx.com>
Date:   Thu, 17 Dec 2020 09:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201216192808.lodnlgbdxefayn2c@vanvanmojo.kallisti.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bQ6WaWYwk01qr4YVaBpMNzIxktjWr6rHCESzNmR8VrTIdgeQbgg
 XfLreXWzXnveYdl9wSa41SgayIOxd1ytCeJyOaY+WlCztcBwp6VOBkAzEtmDjBQp9wwVU/i
 PKP4KB1o+qF62Gbn5+7TGOuh5gEiwjTKtPxVALUAI/moExrgOuaGq4CpN7D3oipdDITisXb
 y8L2t3XqyPaIHlqoeicyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWbJHofN3Ww=:AqBw2oqDSvtF8P0DAFmerd
 Zopv9fe0fUbEsZYEgpuSCVkxbtGNTrIlQVcApTgEE7DbybwnbiCVQlzMkJTb2vnj3bB+bh3vo
 O257PfZgzBTRDU4Epz+6gS2tPoZoWfLaZscbRSi48xDVoDA48EGEaokFQKFavXEiB7grQXhO9
 K922PfbYHnqECsePTzslxek+GD0fGqEjTvQ/CMckeHR4jgku4FoFe4eaQ6IXIba33HBxCQMUn
 ad19b25L7ZgpAJ2ErmoNXk8GzVYoHgVMjfzVzMjtLliW/749+ZNsZhUZoG8grJZrR3vp2cYZH
 0Kbg0OLAQV4kpgahf1lqknvnlHsEa3K+Fj2fMyks+JTsa+RCJdqG34cD3w7WbAr4EsCu7+YyX
 Qt6+x5hecCb4tYIk/pbR8UK3rQr+KMFac9FsDuLpgyqGtv+ubH8o6WNTmccD+QAgMnsEHtci7
 oJTVJTN0wMA16bxbHlE/PFtok8Lw0XlHypajW7mSf6UF2koFtfFz9zDQRHny27zVjgVDfSoob
 kmFcttfv0xrt6QnZLU+ibf3qkQHJ+8KJ0crbxGKaYP7GE/RgM/meLFpM1O5qWHxxMLlsiDgID
 l0weF1wR/m9ygWO3OlZh1xAGJBfWZO1mFUA7xhlvgd2pYDPu7XON6tyS8ydgRcn7+5g2iMuqy
 Ica+mfp1jYRzdBUNg+5RDsD57wKMJrp+Aq6PAjH+pRZo7Tu78/Vu3YvAmZs+y+7C2gLZakvCn
 iLn5HETTe3cldECeKngdIMdgAycWP1sErCb7J4FiVGX3aN0d8UIPI4TT4oVlv8+KkWE6GrI/W
 PKRKK2UWAlXOHjF6+oJyqTAaBH7zB9efmRcx0gLWT7WCAaby8Hcuk4bcbZb4GRaMcVJGDsdFh
 bw4ip3/4Go1bS3ItQuxA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/17 =E4=B8=8A=E5=8D=883:28, Ross Vandegrift wrote:
> Hello,
>
> I recently saw these in my dmesg, on 4.19.160:
>    BTRFS warning (device dm-20): csum failed root -9 ino 1303 off 0 csum=
 0x47abffd5 expected csum 0xd5f0d335 mirror 1
>    BTRFS warning (device dm-20): csum failed root -9 ino 1303 off 0 csum=
 0x47abffd5 expected csum 0xd5f0d335 mirror 1
>
> I'm confused by a few things here:
> - does the negative root id mean something, or is this a bug?

-9 means data reloc tree. It's not a bug.

> - inode 1303 doesn't seem to exist.

The inode is in data reloc tree, which is not visible for users.

But this means you have a lot of uncleaned inodes in data reloc tree.

> - This is a standalone drive, is this about a dup metadata block?

Nope, just some data didn't match its csum.

Btrfs scrub should also report such csum mismatch.
But scrub would report the file path so that you can remove the
offending file and then continue balance.

Thanks,
Qu
>
> Details on the fs:
> $ sudo btrfs fi show /mnt/storage
> Label: none  uuid: 6a2038fb-a9b4-4720-a441-c084610e4295
>          Total devices 1 FS bytes used 4.66TiB
>          devid    1 size 7.28TiB used 5.72TiB path /dev/mapper/storage
>
> $ sudo btrfs fi df /mnt/storage
> Data, single: total=3D4.68TiB, used=3D4.66TiB
> System, DUP: total=3D32.00MiB, used=3D768.00KiB
> Metadata, DUP: total=3D536.45GiB, used=3D4.95GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> $ sudo btrfs inspect-internal subvolid-resolve -- -9 /mnt/storage
> ERROR: -9: negative value is invalid.
> $ sudo btrfs inspect-internal inode-resolve 1303 /mnt/storage
> ERROR: ino paths ioctl: No such file or directory
>
> Please keep me CCed, thanks!
>
> Ross
>
