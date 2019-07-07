Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A11617C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 00:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfGGWSl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jul 2019 18:18:41 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:41638 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfGGWSl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jul 2019 18:18:41 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id BC4DC66A6
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2019 00:18:37 +0200 (MEST)
Date:   Mon, 8 Jul 2019 00:18:37 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find snapshot parent?
Message-ID: <20190707221837.GA15143@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190706155353.GA13656@tik.uni-stuttgart.de>
 <1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
 <20190706204339.GB13656@tik.uni-stuttgart.de>
 <774d3e3d-bf1a-a3a1-b21c-45a3a353e5bc@suse.com>
 <ffa57dd3-51c8-66f8-a53e-be28df79e0d3@gmail.com>
 <8bc57b91-fc13-979b-a25a-b7a16094d09a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc57b91-fc13-979b-a25a-b7a16094d09a@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun 2019-07-07 (12:12), Nikolay Borisov wrote:


> root@ubuntu-virtual:~# mount /dev/vdc /media/scratch/
> 
> root@ubuntu-virtual:~# btrfs subvol show /media/scratch/      
> /
> 	Name: 			<FS_TREE>
> 	UUID: 			80633e8d-fa8a-4922-ac0c-b46d7b2e2d81
> 	Parent UUID: 		-
> 	Received UUID: 		-
> 	Creation time: 		2019-07-07 09:09:15 +0000
> 	Subvolume ID: 		5
> 	Generation: 		8
> 	Gen at creation: 	0
> 	Parent ID: 		0
> 	Top level ID: 		0
> 	Flags: 			-
> 	Snapshot(s):
> 				snap1
> 				snap-ro


root@fex:~# lsb_release -d
Description:    Ubuntu 18.04.2 LTS

root@fex:~# btrfs version
btrfs-progs v4.15.1

root@fex:~# mount|grep /local
/dev/sdd1 on /local type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)

root@fex:~# btrfs subvolume show /local
/
        Name:                   <FS_TREE>
        UUID:                   -
        Parent UUID:            -
        Received UUID:          -
        Creation time:          -
        Subvolume ID:           5
        Generation:             1633457
        Gen at creation:        0
        Parent ID:              0
        Top level ID:           0
        Flags:                  -

No UUID!

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<8bc57b91-fc13-979b-a25a-b7a16094d09a@suse.com>
