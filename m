Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBF111BB68
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbfLKSQQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 13:16:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:39169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731439AbfLKSQQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 13:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576088173;
        bh=yGINRQU++szqyB2dKBcwmy5FgTVWGIaMocWgfU3OpZk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=WWDt9XZEi3S6SXY5qmL3/enuSGMx15Et6BVrEQs+IRQGXj9cZthRtkn4+8gWtAdYb
         cKndhlhx/yRtHSzlVtO/djyBJpIVOfQDHh7fgntsCppzRrXAdkGXE5mvxgAMyZ2zyd
         B55fM2Gnx+72/qfego3DPJA9mtwLGjuMR8LdhLPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([95.112.79.148]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1iDuSo2uRb-00Yx08; Wed, 11
 Dec 2019 19:16:13 +0100
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: BTRFS with kernel 5.4.1: df -h shows 0 Bytes available but btrfs
 tells me that there are 1.06 TiB free
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9df7f98b-271f-8b1d-f360-00a737d49911@gmx.de>
Date:   Wed, 11 Dec 2019 19:16:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:llQP24DdraPE2rf9G3Iloui7iQfhqHXXiz2KFEC234o1T41SzNH
 CRt1C29WRKe9ykqmHizdeEEZxEdM4CqtFE3AOTHiGH+10PgpBV1e8QP4zZPHup08BqcxPAh
 CEAIWB4zt224HaaynqyPLUC7ds1O78h49OyogMSwyck1DqUdLyQI7GA0+9OjhZ+4vosRdVc
 ELqphhvC9Wtgb1wxOJQlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LlnyD8R28a4=:wHcOfx5faCHxy9BpFpWQCO
 iJFKxmjBZio83qKpv919ODpKtUeB7rViGpC6sD/FSbRMQtUugOsu4wBmLYbkZKToaiT75czbC
 F1Vw80s42iMmLriaEgba5i/PEN/tmt2d1Bfw4lTGU9CkDpq/7veI0IrTdSc7Bcr6Zy4kvfsBJ
 63AwKxY6VREJ2xEUQJaxo2+JIOrgZEHnnA8HsyE3QLkTbpAYTx9/CaFMXAZsznFjhE9usEiyH
 m0/SrmJwjuo+TIuGOYTTgEo61KKxv1hIr3k06k/Z8N9ovu5vRnMZ7mIJK/cYceXeBD9h+lAVK
 +X0lp9PAwwL5adg8MFm++nwEaV4Jue0/s/ikdo+yI+k2sIpaXJ0PnmCs3kg1mzNZVuABExgbh
 TJdfz8PRNKInZVj9F+aznzj+Op8qlMDWJdlTmhArOBBhQF1TMmoQC9ojxOISMTUf/21wgkrXu
 TtbvZ8thDhtf6XAWx0EstsOHYmgUBbnAiMe8LEPS0MlfFUndDyae8UASgnG8gJW4ypD5U/fqM
 jdLJT66QHKpS+WIel3bGg1H9NuQECnk82euQRJv99sfh5x8cFK3csMWzVnnprSho7k5USEjCo
 wf2sl8rW1A+bFUguEt0SNMi7aNAlEPZ0n6ib3RJ1B23CuCHOaDMriaXgfSIfY0HoftvlQL2kF
 aYpnPLpWHfK8/GqpjyztFL+PAvTnjBXvVpvfsXUWT3/aSB1C+r19YWGAX5Ixbaf/vCHsXXucm
 P2ol/BsIfcBGguhdyU5nTsNoh2NYw1pLl68JNudjga6W3IikgEPfXRfeINVbc5A+PrCJHqJjQ
 bsKs2eLQuRvi7aUXeWfEWyMbbJbSkIUdX7OTX8rZKsT3ax8Aqs2rG2GzwMe9cA8lRMsYEfoGT
 k1lB4JVH3oOzd57WUglStyK4xv7cM0WvM0WpJKK07ypbmvluzcV3SC4aViAsYbr5QH/C8Spt2
 5vu5biUp+Nf850EfLkFWvAIs5YXdG+qF4XFBgATGbSYBpwjWEA7tgSHKwhJ2QI0WqNn4CF7sw
 7pDJOj0rxmHczZwIPUfm/765y0MJd3qGfrI3aPZK6UFfWd8zewNg7EHrKHKRQJF80BTioM3+8
 OUzXzn/zDx04+J39FmRHl7dN3UAo06vUzqOAgZCVwLB8ITVVPx0eBLdaTFE/YJ3WWET8sc0In
 g4X++RJsdTeBg2xfI1YA8p5q2Mg9P5dLM8vfC9Y7b9kzlH/qEMBJgPAFNkt2+fCyvs1FlgdU2
 TraoLr3upmoP1pEQOR04TrdxgPwIf+QkECjEXp4va26lg4tChZm73+qftrbc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since 5.4 (5.3.xy was fine) I do get every few days:

# df -h /home/tinderbox/img1
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda5       1.7T  614G     0 100% /home/tinderbox/img1


# btrfs filesystem usage /home/tinderbox/img1
Overall:
    Device size:                   1.66TiB
    Device allocated:            614.02GiB
    Device unallocated:            1.06TiB
    Device missing:                  0.00B
    Used:                        613.38GiB
    Free (estimated):              1.06TiB      (min: 543.50GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID0: Size:566.00GiB, Used:565.50GiB (99.91%)
   /dev/sda5     283.00GiB
   /dev/sdb1     283.00GiB

Metadata,RAID1: Size:24.00GiB, Used:23.94GiB (99.76%)
   /dev/sda5      24.00GiB
   /dev/sdb1      24.00GiB

System,RAID1: Size:8.00MiB, Used:64.00KiB (0.78%)
   /dev/sda5       8.00MiB
   /dev/sdb1       8.00MiB

Unallocated:
   /dev/sda5     542.99GiB
   /dev/sdb1     542.99GiB


This is a hardened Gentoo linux acting as a QA build bot for their package=
s:

# uname -a
Linux mr-fox 5.4.2 #2 SMP Thu Dec 5 01:18:19 CET 2019 x86_64 Intel(R) Xeon=
(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux


I do appreciate hints to overcome this situation.

=2D-
Toralf
