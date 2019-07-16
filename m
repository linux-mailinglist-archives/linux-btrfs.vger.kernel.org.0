Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA76B258
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 01:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfGPXZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 19:25:02 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:58046 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfGPXZC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 19:25:02 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 462348D4C
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 01:24:56 +0200 (MEST)
Date:   Wed, 17 Jul 2019 01:24:56 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: how do I know a subvolume is a snapshot?
Message-ID: <20190716232456.GA26411@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I thought, I can recognize a snapshot when it has a Parent UUID, but this
is not true for snapshots of toplevel subvolumes: 

root@trulla:/# btrfs version
btrfs-progs v4.5.3+20160729

root@trulla:/# btrfs subvolume show /mnt/tmp
/mnt/tmp is toplevel subvolume

root@trulla:/# btrfs subvolume snapshot /mnt/tmp /mnt/tmp/ss
Create a snapshot of '/mnt/tmp' in '/mnt/tmp/ss'

root@trulla:/# btrfs subvolume create /mnt/tmp/xx
Create subvolume '/mnt/tmp/xx'

root@trulla:/# btrfs subvolume show /mnt/tmp/ss
/mnt/tmp/ss
        Name:                   ss
        UUID:                   7732bdde-0485-204e-b41b-833376e791da
        Parent UUID:            -
        Received UUID:          -
        Creation time:          2019-07-17 01:02:48 +0200
        Subvolume ID:           270
        Generation:             60
        Gen at creation:        60
        Parent ID:              5
        Top level ID:           5
        Flags:                  -
        Snapshot(s):

root@trulla:/# btrfs subvolume show /mnt/tmp/xx
/mnt/tmp/xx
        Name:                   xx
        UUID:                   342b2065-1679-8245-bd76-8da598cc33d8
        Parent UUID:            -
        Received UUID:          -
        Creation time:          2019-07-17 01:03:02 +0200
        Subvolume ID:           271
        Generation:             61
        Gen at creation:        61
        Parent ID:              5
        Top level ID:           5
        Flags:                  -
        Snapshot(s):

How do I know that /mnt/tmp/ss is a snapshot?
I cannot see a snapshot identifier.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190716232456.GA26411@tik.uni-stuttgart.de>
