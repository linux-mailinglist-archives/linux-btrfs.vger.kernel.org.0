Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3182144D350
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhKKIok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 03:44:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:36279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhKKIoj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 03:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636620109;
        bh=AZ3CiMa3s5RqYUoLPpfvhnK7zklsvu7IILqMY7/7X4U=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=YDxL86QVlAwXvpJWOvW0CPbTcQaBsf7jyRcaHObtIEkgx2aNqB8YS7RtCJrDxGWRW
         lB4EJxjviEjf+X9Rce+VBtCxrqZSQLICzcmLJnop42qN3O7E7ZntL/GQHtGjE+T01Y
         sLmU9RI8cT0CK3rZIJAU/7YQoGdB7t4SJOrk2C9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq2E-1mR5tM41OK-00tCVp for
 <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 09:41:49 +0100
Message-ID: <bebb9da7-2262-b7b5-4bbf-05eb57fdd717@gmx.com>
Date:   Thu, 11 Nov 2021 16:41:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Side project announcement: btrfs-fuse
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yrmvsFGQ/FNW68cwNKGoWfq2WPfjKq72NWbdbsvu1a6Stfq9Oaj
 0qOV1e1YvCh4SiEYE6+fjDXqCvHTlhptA9mc2Ah+im2gilFh1wL/gw3TxgntKs1SX4aWjUA
 7AVfs9TJCYP7Z4kaySIhPQDP10XCeYG04RbG4YxmNHkNIJHLgGr9e/yVE7Aite0ydp546MU
 qwcsPiIwYdPb/iLO5m9Hw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RUC+UB2VvSk=:Gp1A6LkM7PnXkgOUZMiyXw
 V+N6Cvy2HpjvHHf0FR7fIU9JCSGJzNWh87BDg4Ky972L3o+Ogeh2cY85Uq5meMwPnjNF8QdVD
 jLykcqOKmTU5qajJRKneksgsY0GjIa8gvl30Ab9gpGs/LuBj5mEy0hC3KjdB852buMnzxdPJl
 afcP95GYSZvCzb0Fhp+P3e7DDIiGDcUX9eHg7RgGo+K9xyYElW8QzKng+0xE42D7VbKwJRJwv
 EDHrpZBBtPQp0YdNfNP1osswoP3vXdNaNPDPpHUm60/yaLk0lYrgNCfKes2KI4uZkC3k+r2Uc
 ELPvoVlKHtI5/0quwFsqGHrkRP8z61dfCwXKagjFBCS2ryzRCQRuhL2p7jyuRD530M7lk3Yz5
 mdvHFyi+jqBku0Yh8vBFZtg/jq4LrFCCUMPbCe4rENdwpaEdod+R3wh5pLrjggBzrs7IR3uQ6
 7eV6XLrltljLiSmAJM7uS067//nRm+BnNbn+5fzimQ28VydeI1MBpzfMcmnO1nCDaGJW/OKPs
 tPXZfscuVOgYXgO9Jdcs4oMX/uY0iU3xS30PonVjbNaIRJhXNE2p7TyaKQsXNl0oZsS2qqxXM
 2w28XIRyYtK3krW+8ZgN2dPjzrwUdCdFUpo5ISSJqNFbY1BRmglUGo6QqYHCCqIcE2zCQchK0
 JmRwobPgSoJWg/dfQ35uNwxMlBUXJZbyANMfZOjznWu2VzfYv+hy4GzZIUSoaLLxLrJsJ7Cr+
 3j08ASOnTUCGdwtovw+DLkOTxCYC6Evx5rsmc5UJ+BMnHe1vk4WBe+l1SYGfQW/OwIGeEcBBg
 BYYLAv4R1PSJMDRaieXgjZhefgM4a5sivTwJAkUioMHqCD08C5U2sg9V6jrkuAg7EDvswg0lz
 UubbK1uYvB9OjmzMZFooHkA0fXWCbVhLQsrh4BpNXfr4C+/5IC8Q9b1KQy/jX+V9jSv6nBDsP
 161lYYw5UVpXRO01j1uapO5kNIpvhxUXL1M7MRUry8KqpxWm2K9Avkwl4TBb355g8gMM/gldT
 lUmjkfOjfSy76Y5u1Hek4Pkr1oSEj1YpLacaRNPujFDt3hmNHzZXDR+jWRzwjp5w0n3C3ixKU
 GdEf6raeSD3bVc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,

Some may have already noticed that, there is a small project call btrfs-
fuse under active development:

https://github.com/adam900710/btrfs-fuse

I guess it's time to properly announce the project, a FUSE *read-only*
btrfs implementation.

Although btrfs is already mainlined for a long time, there are still
something that even a read-only implementation can help:

- Education
   Good luck if you're a newbie interested in modern filesystems, and
   just start reading the kernel btrfs code.
   It's already over 133K C lines, not to mention the complex
   relationship between VFS and block layer.

   This project only has 3K lines of C code (excluding headers which
   include ondisk format, various compatible helpers).

   With my special educational comments among the 3K lines of C code.

- Better and easier subpage/multi-page support
   I just feel reborn when I don't need to bother page operations in
   kernel.

- For certain bootloader
   In a galaxy not far, far away, there are some bootloader projects
   requiring GPLv3+ license, thus kernel/progs code can not be utilized.

   But filesystem is getting more and more complex, especially for btrfs.
   Without a proper maintained fs implementation, things will get out-of-
   control eventually.

   This project is crafted from scratch with MIT license, only certain
   external libraries are from GPLv2+ or GPLv2-only kernel code.
   (But to make newbie to get familiar with the kernel/progs code, most
    function/structure names are kept the same as kernel/progs).

   Hopes one day btrfs-fuse can be crossported to those projects.


But this new project hasn't yet reach v1.0, as there is some
limitations:

- RAID5/6 read support
   Already working on that.

- stat::st_dev and stat::st_ino
   Currently FUSE will override st_dev, thus no way to use st_dev to
   indicate subvolume boundary, and duplicated st_ino in different
   subvolumes will make tools like `find` unhappy.
   Will explore a different way to represent st_ino.

Currently I'm still testing the project with fsstress (to generate a
btrfs using kernel) and fssum (to verify both kernel and btrfs-fuse are
reporting the same content), which should be pretty comprehensive.
Will convert the tests to a self-test eventually.

Extra tests and contribution are always helpful!

Happy learning btrfs details!

Thanks,
Qu
