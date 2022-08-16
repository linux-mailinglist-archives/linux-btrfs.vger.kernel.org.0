Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFF595B68
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiHPMKS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 08:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiHPMIn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 08:08:43 -0400
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 05:01:43 PDT
Received: from mx3.rus.uni-stuttgart.de (mx3.rus.uni-stuttgart.de [129.69.192.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374C4DF2C
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 05:01:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx3.rus.uni-stuttgart.de (Postfix) with ESMTP id 68BBE202BD
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 13:54:37 +0200 (CEST)
X-Virus-Scanned: USTUTT mailrelay AV services at mx3.rus.uni-stuttgart.de
Received: from mx3.rus.uni-stuttgart.de ([127.0.0.1])
        by localhost (mx3.rus.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UsXSCFy3IQct for <linux-btrfs@vger.kernel.org>;
        Tue, 16 Aug 2022 13:54:35 +0200 (CEST)
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by mx3.rus.uni-stuttgart.de (Postfix) with SMTP
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 13:54:35 +0200 (CEST)
Date:   Tue, 16 Aug 2022 13:54:35 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs subvolume list for not mounted filesystem?
Message-ID: <20220816115435.GA15967@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20171218164941.GA22020@rus.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218164941.GA22020@rus.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_40,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon 2017-12-18 (17:49), Ulli Horlacher wrote:
> I want to mount an alternative subvolume of a btrfs filesystem.
> I can list the subvolumes when the filesystem is mounted, but how do I
> know them, when the filesystem is not mounted? Is there a query command?
> 
> root@xerus:~# mount | grep /test
> /dev/sdd4 on /test type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)
> 
> root@xerus:~# btrfs subvolume list /test
> ID 258 gen 156 top level 5 path tux/zz
> ID 259 gen 156 top level 5 path tux/z1
> ID 260 gen 156 top level 5 path tmp/zz
> ID 261 gen 19 top level 260 path tmp/zz/z1
> ID 269 gen 156 top level 5 path tux/test
> ID 271 gen 129 top level 269 path tux/test/.snapshot/2017-12-02_1341.test
> 
> root@xerus:~# umount /test
> 
> root@xerus:~# btrfs subvolume list /dev/sdd4
> ERROR: not a btrfs filesystem: /dev/sdd4
> ERROR: can't access '/dev/sdd4'

Meanwhile I have written "btrfs_list" :

root@fex:~# btrfs_list -h
usage: btrfs_list [-b] [-w] [SUBVOLUME...]
usage: btrfs_list [-b] [-w] [/dev/]DEVICE
options: -b  brief output
         -w  show only writable subvolumes
see also: btrfs subvolume show SUBVOLUME

root@fex:~# btrfs_list -v sde1
# mount -o ro /dev/sde1 /mnt/tmp/sde1
# btrfs subvolume list -u /mnt/tmp/sde1
ACCESS-MODE SUBVOLUME <- SNAPSHOT-PARENT
rw fex
ro fex/.snapshot/2022-08-14_0222.daily <- fex
ro fex/.snapshot/2022-08-15_0222.daily <- fex
ro fex/.snapshot/2022-08-16_0222.daily <- fex
rw sw
ro sw/.snapshot/2022-08-07_0000.weekly <- sw
ro sw/.snapshot/2022-08-13_0000.daily <- sw
ro sw/.snapshot/2022-08-14_0000.weekly <- sw
ro sw/.snapshot/2022-08-15_0000.daily <- sw
ro sw/.snapshot/2022-08-16_0000.daily <- sw
rw tmp
# umount /mnt/tmp/sde1


https://fex.rus.uni-stuttgart.de/fas/framstag@rus.uni-stuttgart.de/linuxtools/anonymous@fex.rus.uni-stuttgart.de/k5JuaCkGRqGOYeFUHuB47S35rhs3vBZo


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20171218164941.GA22020@rus.uni-stuttgart.de>
