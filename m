Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CC52D198
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiESLhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiESLhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:37:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F952517
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652960217;
        bh=I+SVI+10eWx8J2nf/EPE6Od/XRD42oHLcWVZ/vRA8m4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LFQCzNeZTN04UJq20HP7/s3pzXlP58tkCs4tk8Q5z0bSSshPab/NRz9PqVArVniD7
         9KO9dw0zUUue+8DzN40TS0euqs9CbGb2A709YpwRMIl+m5nWdeK6I0ku9+XCttcBwZ
         SYWAymHjIUrtjQIrXxnhGTq/IrVxDDmkaF+O09CY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS9C-1nSzlN3l8M-00kueP; Thu, 19
 May 2022 13:36:56 +0200
Message-ID: <5679bb8d-d0af-187b-1bd0-fd8ccc85a867@gmx.com>
Date:   Thu, 19 May 2022 19:36:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: can't boot into filesystem
Content-Language: en-US
To:     arnaud gaboury <arnaud.gaboury@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QONeARluEgWWZBJAqx9r0FB63sTe0L25ObrilaFDbpEyPht0Xiq
 5jvnO0Yw8jTPfmQzGtEsYRo7j8PUqZCejVaniKrX559D+Y9j6Dy8+Am3N60dISDkCwkJCdi
 OZQbdAEhhDefQPSqBh/CLBkWpWtW3Z9f6tHjlKU46A7hY1O+gW+hnmOgVOAy+M/KUQ9yxf5
 MPf6EorBzxjzlsEUmzmdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VVplkOfupOY=:XvgWyjdoTuRGh+b2IOEPi4
 w2anboL+/sJUSCmbw5Yhj6nf7IBveZB6rZ0y5lrIpe6dIob4REJg8j8lm45f1dbTiYb+ZqVPA
 9/eADZDfqoM4Rjue1zomgWAts6RLlnPAeaYKB+jzjZEdysbVRFsbJCvX1JS6XBisyGSUH8Kzh
 X3sFOZPm1jWLQTUDGE7lPgNsoBaQtrwuxVhX3PW3/Jta6S2R4sef02qGMGgt51u8x5Ts+yfYz
 R4KodM+CyaJFuyvFnk1zjWdiYm5wdt5Rt2zCunQ+HU5IH0h9bBJigoLl9H//0JFZVLGeQdlnr
 cciu5UIMPTI0NjUidUL070KsmUuMss875RuLkur6GFzOYaD2gJfZ54qlgCAnLFw/KZA27VFlQ
 lPEHFPS5kdSaQm11dQj0dr4RxKEhZTY4Cqtg2eRLpt+0/6S4VkNgzcx9oIUzK+ZdNwGrG3vQf
 ak9C6rAYX9iiaZAq9MYes/lgi29vViAYaH1xRyDY/YOFuhAGcY6A43WgBlqXKxmTrJs5FNtfL
 VEiiyie3KYt815GelzgmCn3lU/r7g7t+CvM/pp9BeQpXcaK/KK59lQvl5myXQadAvo0ee1yJo
 xiMstWy3+4WN33NM75Pu0MmsKveiShGJB/bObL+oB9Fo+lg6DvcfUZLXRBBvhMVqQLBUkrD3d
 xd5cDjkxhV0nxNzpPE4yHishyXH0MpJIudZgL5vodWJXcZqhhYvBBJNMQScRJ6880tE4bk6eW
 JJw8BVUk9WT+Ibc0dPa0SrfBPzd3qLmXa/fiTiwt9FXHP3lMfiyUdp7UsS3i2DKaBWjNKwKJK
 lh9JqLW0A1DS1bJUiSO/Is9MB/qlgfc9nNWkAkcQGZigGPwvfX/2MR0mutNc3TY/EgwpNPs8Z
 cxr+pXz+VB0oS4doXBxJ7b0rVXyXrGyhU2IRbRHI79vP6z7VtgQpTFjyu9cKibP8Lk2MrEOG+
 2o2zeKrlLW5Z5jTLIwvLN7Hff+LEn1uUewIZYzjjAFVe5Ux2bewnoiH/hVIQ2nvxhkoluSvEL
 Js0X0cr3cC2RcoT8C4gc0z5w+dcP8hJHWtxizHtj0XWfpMX9XjmiEq5OdiEC9VHLJyWoj3+MA
 JqtVrnGgRlXqC+Z7Ut2OiL6KoAjXbVOlZ4kyZYyZipOa9A/R6+cujMERA==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 17:58, arnaud gaboury wrote:
> My OS has been freshly installed on a btrfs filesystem. I am quite new
> to btrfs, especially when mounting specific partitions. After a change
> in my fstab, I couldn't boot into the filesystem. Booting from a
> rescue CD, I changed the fstab back to its original. Unfortunately I
> still can't boot.
> Here is part of the error message I have:
> devid 2 uuid XXYYY is missing
> failed to read chunk tree: -2

This is the reason, your fs is across multiple-device (like using RAID1
profiles).

And on boot, you initramfs doesn't call 'btrfs dev scan' to let btrfs
scan all devices and assemble the full device list.

Thus it can only detect one disk of your multi-device btrfs, and failed
to mount.

That's why your rescue CD can mount the fs.

You may want to check the manual of distro to make sure the initramfs is
doing proper preparation work for btrfs (mostly just scan the devices).

For example of Archlinux:

https://wiki.archlinux.org/title/mkinitcpio

You need "btrfs" hook, which is doing exactly I mentioned, run "btrfs
dev scan".

Thanks,
Qu
>
> part of my fstab:
> LABEL=3Dmagnolia   / btrfs  rw,noatime.....,subvol=3D@
> LABEL=3Dmagnolia  /btrbk_pool  btrfs  noatime,....,subvolid=3D5
> LABEL=3Dmagnolia   /home   btrfs .....,subvol=3D/@home
> ......
>
>
>
> I am now back to rescue CD. I can mount my filesystem with no error:
> # mount -t btrfs /dev/sdb2 /mnt
> # ls -al /mnt/
> @
> btrbk_snapshots
> @home
> home
>
> I can see my filesystem when I ls the @ directory.
> What can I do to boot my filesystem which is perfectly reproduced in
> the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
> the root of /mnt  when my device sdb2 is mounted?
> Sorry for the lack of formatting and info, but I can't use the browser
> from the rescue CD so I am writing from another computer.
