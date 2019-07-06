Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852346133C
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2019 01:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfGFXYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 19:24:51 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:58847 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfGFXYv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Jul 2019 19:24:51 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id A8F5D6F9E
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jul 2019 01:24:47 +0200 (MEST)
Date:   Sun, 7 Jul 2019 01:24:44 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find snapshot parent?
Message-ID: <20190706232444.GA22299@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190706155353.GA13656@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706155353.GA13656@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have now implemented "btrfs_subvolume_list", example:

root@xerus:~# df3 -T
Filesystem     Type    Mbytes      Used Available Use% Mounted on
/dev/sda1      ext4    20,029     4,482    14,507  24% /
/dev/sdd4     btrfs    53,247       101    51,052   1% /test

root@xerus:~# btrfs_subvolume_list
rw /test
ro /test/.snapshot/2019-07-06_2236.test <- /test
ro /test/snapshot_1 <- /test
ro /test/ss1 <- /test
ro /test/ss3 <- -
rw /test/tmp
ro /test/tmp/xx/ss1 <- /test/tmp
ro /test/tmp/xx/ss2 <- /test/tmp
ro /test/tmp/xx/ss3 <- /test/ss3
rw /test/tmp/zz2 <- /test/tux/zz
rw /test/tux/test
ro /test/tux/test/.snapshot/2017-12-02_1341.test <- /test/tux/test
rw /test/tux/test2 <- /test/tux/test
rw /test/tux/test2/test <- /test/tux/test
rw /test/tux/zz

<- means: is snapshot of ...

Note: I have deleted the subvolume parent of /test/ss3

Sourcecode is available under:

https://fex.rus.uni-stuttgart.de/fas/framstag@rus.uni-stuttgart.de/linuxtools/anonymous@fex.rus.uni-stuttgart.de/k5JuaCkGRqGOYeFUHuB47S35rhs3vBZo

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190706155353.GA13656@tik.uni-stuttgart.de>
