Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7471F61206
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGFPx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 11:53:57 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:48636 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfGFPx5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Jul 2019 11:53:57 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 08B0F840B
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Jul 2019 17:53:54 +0200 (MEST)
Date:   Sat, 6 Jul 2019 17:53:53 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: find snapshot parent?
Message-ID: <20190706155353.GA13656@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is there a standard way to find the path of the subvolume parent of a
snapshot? 

For example:

root@xerus:/test# btrfs sub list /test
ID 269 gen 9818 top level 5 path tux/test
ID 1026 gen 9804 top level 1011 path tmp/xx/ss1
ID 1027 gen 9804 top level 1011 path tmp/xx/ss2

root@xerus:/test# btrfs subvolume show /test/tmp
/test/tmp
        Name:                   tmp
        UUID:                   5a873eca-9b6c-fc4e-aed5-eb287839d693
        Parent UUID:            -
        Received UUID:          -
        Creation time:          2019-07-04 00:17:11 +0200
        Subvolume ID:           1011
        Generation:             9813
        Gen at creation:        9749
        Parent ID:              5
        Top level ID:           5
        Flags:                  -
        Snapshot(s):
                                xx/ss1
                                xx/ss2

root@xerus:/test# btrfs subvolume show /test/tmp/xx/ss1
/test/tmp/xx/ss1
        Name:                   ss1
        UUID:                   3641bb81-d1fd-4440-8f29-6f17ff9ec4e1
        Parent UUID:            5a873eca-9b6c-fc4e-aed5-eb287839d693
        Received UUID:          -
        Creation time:          2019-07-05 11:13:15 +0200
        Subvolume ID:           1026
        Generation:             9804
        Gen at creation:        9793
        Parent ID:              1011
        Top level ID:           1011
        Flags:                  readonly
        Snapshot(s):

Must I call "btrfs subvolume show" for every subvolume to find the
matching Parent ID/UUID or parse the "Snapshot(s)" section?

And how can I see whether /test/tmp/xx/ss1 is a snapshot at all?
Do all snapshots have a "Parent UUID" and regular subvolumes not?

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190706155353.GA13656@tik.uni-stuttgart.de>
