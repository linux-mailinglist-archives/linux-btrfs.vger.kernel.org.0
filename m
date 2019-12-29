Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9070012C30A
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfL2PFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 10:05:23 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:44172 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2PFX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 10:05:23 -0500
Date:   Sun, 29 Dec 2019 15:05:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1577631921;
        bh=WjHwFrtQJFPTB8GkdQi32X379D/63TH1NdSUdgE1iEY=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=bvU4XFEq5/loNyccjCJj0ztI5Fo+jp2PzmfizfBpDZhDAY/5VTzS20NTfV/a1vDHt
         7vlmm9W50ImZ3Scct1w96U/36xT+/FHtXCDZqfmsEY1ssPiqLcM6iRKJwUOJOqgTqQ
         61Cz2pok3CU0IcbUya0jc5FlOlvEyItArKsRwXB4=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Raviu <raviu@protonmail.com>
Reply-To: Raviu <raviu@protonmail.com>
Subject: Cannot mount or recover btrfs
Message-ID: <qxM9wPidCbIA9yMGE4e57cGzc5GkQnFF39Q2h1PLV0XTLpSVZ1nvi9wDfOD3YXIAl3GYyq2wRoG8ncoE692e0MVUah_rmDSRggyZz_trQH0=@protonmail.com>
Feedback-ID: s2UDJFOuCQB5skd1w8rqWlDOlD5NAbNnTyErhCdMqDC7lQ_PsWqTjpdH2pOmUWgBaEipj53UTbJWo1jzNMb12A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
My system suddenly crashed, after reboot I cannot mount /home any more.

`uname -a`
Linux moonIk80 4.12.14-lp151.28.36-default #1 SMP Fri Dec 6 13:50:27 UTC 20=
19 (8f4a495) x86_64 x86_64 x86_64 GNU/Linux

btrfs-progs v5.4

`btrfs fi show`
Label: none  uuid: 378faa6e-8af0-415e-93f7-68b31fb08a29
        Total devices 1 FS bytes used 194.99GiB
        devid    1 size 232.79GiB used 231.79GiB path /dev/mapper/cr_sda4


The device cannot be mounted.
[  188.649876] BTRFS info (device dm-1): disk space caching is enabled
[  188.649878] BTRFS info (device dm-1): has skinny extents
[  188.656364] BTRFS critical (device dm-1): corrupt leaf: root=3D2 block=
=3D294640566272 slot=3D104, unexpected item end, have 42739 expect 9971
[  188.656374] BTRFS error (device dm-1): failed to read block groups: -5
[  188.700088] BTRFS error (device dm-1): open_ctree failed



`btrfs check /dev/mapper/cr_sda4`
Opening filesystem to check...
incorrect offsets 9971 42739
incorrect offsets 9971 42739
incorrect offsets 9971 42739
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system


