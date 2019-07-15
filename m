Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB0A6883A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfGOLdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 07:33:37 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:61033 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbfGOLdh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 07:33:37 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 9FF9E88C5
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 13:33:34 +0200 (MEST)
Date:   Mon, 15 Jul 2019 13:33:34 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find subvolume directories
Message-ID: <20190715113334.GA17669@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712231705.GA16856@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 2019-07-13 (01:17), Ulli Horlacher wrote:
> I need to find (all) subvolume directories.
> I know, btrfs subvolumes root directories have inode #256, but a
> "find / -inum 256" is horrible slow!

At least, I want to exclude non-btrfs filesystems to speed up the find
run, but find cannot detect snapshots (as part of btrfs):

root@trulla:~# find /opt -inum 256 -printf "%p %F\n"
/opt btrfs
/opt/.snapshot/2019-07-10_0000.daily unknown
/opt/.snapshot/2019-07-11_0000.daily unknown
/opt/.snapshot/2019-07-12_0000.daily unknown
/opt/.snapshot/2019-07-13_0000.daily unknown
/opt/.snapshot/2019-07-15_0000.daily unknown
/opt/.snapshot/2019-07-15_1200.hourly unknown
/opt/.snapshot/2019-07-15_1300.hourly unknown

root@trulla:~# find /opt -inum 256 \( -fstype btrfs -o -fstype unknown \) -printf "%p %F\n"
/opt btrfs
root@trulla:~# 

root@trulla:~# btrfs subvolume list -o /opt
ID 14930 gen 2276304 top level 259 path @/opt/.snapshot/2019-07-10_0000.daily
ID 14957 gen 2277856 top level 259 path @/opt/.snapshot/2019-07-11_0000.daily
ID 14981 gen 2279354 top level 259 path @/opt/.snapshot/2019-07-12_0000.daily
ID 15005 gen 2280891 top level 259 path @/opt/.snapshot/2019-07-13_0000.daily
ID 15052 gen 2283953 top level 259 path @/opt/.snapshot/2019-07-15_0000.daily
ID 15064 gen 2284721 top level 259 path @/opt/.snapshot/2019-07-15_1200.hourly
ID 15065 gen 2284788 top level 259 path @/opt/.snapshot/2019-07-15_1300.hourly

root@trulla:~# stat -f -c %T /opt/.snapshot/2019-07-10_0000.daily
btrfs


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190712231705.GA16856@tik.uni-stuttgart.de>
