Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1B43C202A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhGIHuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 03:50:54 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:59324 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhGIHuy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 03:50:54 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 710F4C1F9
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:48:10 +0200 (MEST)
Date:   Fri, 9 Jul 2021 09:48:10 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: where is the parent of a snapshot?
Message-ID: <20210709074810.GA1548@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709073731.GB582@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


And an example of a new snapshot:

root@unifex:/# btrfs subvolume snapshot -r /mnt/spool /mnt/spool/.snapshot/2021-07-09_0944.test
Create a readonly snapshot of '/mnt/spool' in '/mnt/spool/.snapshot/2021-07-09_0944.test'

root@unifex:/# btrfs filesystem show /mnt/spool
Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
        Total devices 2 FS bytes used 209.80GiB
        devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
        devid    2 size 14.55TiB used 100.00GiB path /dev/loop1

root@unifex:/# btrfs subvolume list -aqu /mnt/spool
ID 30428 gen 194535 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 7f044b92-d928-2f44-a880-e453feaa551d path .snapshot/2021-07-09_0000.daily
ID 30435 gen 194686 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid eeace077-5f22-c541-8fb4-f0523fd76c9e path .snapshot/2021-07-09_0700.hourly
ID 30436 gen 194715 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 70fc8ced-7c13-f947-bab6-5354eb71483f path .snapshot/2021-07-09_0800.hourly
ID 30437 gen 194756 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 254fcaba-9549-0244-8467-baaa3d68cb7b path .snapshot/2021-07-09_0900.hourly
ID 30438 gen 194793 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 5c6ade10-39ee-de47-a1f8-321953e397fd path .snapshot/2021-07-09_0944.test

So, where is subvolume uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2??

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20210709073731.GB582@tik.uni-stuttgart.de>
