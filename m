Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FAB1304F9
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 23:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgADWqQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 4 Jan 2020 17:46:16 -0500
Received: from dd46828.kasserver.com ([85.13.129.81]:47374 "EHLO
        dd46828.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADWqQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 17:46:16 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jan 2020 17:46:15 EST
Received: from [192.168.179.20] (p5DD71504.dip0.t-ipconnect.de [93.215.21.4])
        by dd46828.kasserver.com (Postfix) with ESMTPSA id 9194D8180137
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2020 23:38:05 +0100 (CET)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Georg_Gro=c3=9fmann?= <georg@grossmann-technologies.de>
Openpgp: preference=signencrypt
Autocrypt: addr=georg@grossmann-technologies.de; prefer-encrypt=mutual;
 keydata=
 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
 I4dOt2DQ+I8=
Subject: timed out waiting for device dev-disk-by\x2duuid after disk failure
 on btrfs raid1
Message-ID: <d081f5fc-7132-6b18-f740-738993fd18e7@grossmann-technologies.de>
Date:   Sat, 4 Jan 2020 23:38:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear btrfs community,

I wanted to use a setup with Open Suse Tumbleweed together with with a
btrfs raid 1 on two disks in my virtual box. I want a system that can
still boot if one of the disks fails so I installed a bootloader to each
of the disks in /dev/sda1 and /dev/sdb1.

I then used /dev/sda2 and /dev/sdb2 for the btrfs raid 1. After
unplugging one disk, the boot process always fails with the message
"timed out waiting for device dev-disk-by\x2duuid". I found a mailing
list here
https://lists.freedesktop.org/archives/systemd-devel/2014-May/019217.html
which pretty well describes my problem. Unfortunately, I can't find an
appropriate solution there. Since this mailing list is from 2014, has
there been some progress in the meantime? Or is this the expected
behaviour and the user has to help himself out manually?

Best Regards

Georg


