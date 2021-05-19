Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2958D3886D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 07:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbhESFnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 01:43:22 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43081 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243219AbhESFlI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 01:41:08 -0400
Received: (Authenticated sender: swami@petaramesh.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8292D240008;
        Wed, 19 May 2021 05:39:47 +0000 (UTC)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Subject: System freeze with BTRFS corruption on 4 systems with kernel 5.12
 (MANJARO)
Message-ID: <a924147d-1403-369b-85d5-a5ba5be662d8@petaramesh.org>
Date:   Wed, 19 May 2021 07:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,

(Please CC: me on replies, I'm not currently susbscribed to the list)

This is to report a bug with Manjaro Linux 5.12.1-2 kernel that
immediately affected 4 different, usually stable machines after update
to kernel 5.12 from 5.11 or 5.10, and went away after reverting back to
either 5.10 or 5.11.

Kernel affected : Linux 5.12.1-2-MANJARO
(Not sure if I tried Manjaro Linux 5.12.1-1-MANJARO)

Kernel not affected : All previous versions up to 5.11.18-1-MANJARO

Symptoms : Under heavy disk usage (such as performing a system backup
onto external USB HD) the machine soon completely freezes and only a
hard power cycle can get it out of it.

After reboot, systems on which BTRFS is built over bcache may show heavy
filesystem corruption.

Happened on :

- HP Laptop 1 (Intel Atom) : BTRFS over LUKS on SSD : System freeze, no
BTRFS corruption after reboot.

- Dell Laptop 1 (Intel Core2 duo) : BTRFS over LUKS on SSD : System
freeze, no BTRFS corruption after reboot.

- HP Laptop 2 : One BTRFS FS over LUKS on SSD, and one BTRFS over bcache
over LUKS on HD+SSD : System freeze, SSD BTRFS was not corrupt but BTRFS
over bcache was severely corrupt, beyond repair and had to be rebuilt
and restored from backups.

- Asus old desktop with AMD Athlon 64 X2 : BTRFS RAID-1 over bcache over
LUKS on 2 HD + SSD : System freeze, heavy BTRFS corruption that could
however be fixed by simply running a “btrfs scrub” after reverting back
to a 5.10 Manjaro kernel.


To be thorough, I also have to report an Arch Linux Intel Celeron
machine running 5.12.4-arch1-2 kernel, BTRFS over LUKS on SSD, that has
been running for a while without showing any such symptom.


Hope these reports can be useful.

Best regards.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
