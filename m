Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A2860BD2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 21:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGETjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 15:39:49 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:48506 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfGETjt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 15:39:49 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 72CAF81D8
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 21:39:45 +0200 (MEST)
Date:   Fri, 5 Jul 2019 21:39:45 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: delete recursivly subvolumes?
Message-ID: <20190705193945.GB23600@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am a master in writing unnecessary software :-}
"I have a great idea! I'll write a program for this!"
(some time and many lines of code later)
"ARGH... there is already such a program and it is better than mine!"

This time I ask BEFORE I do the coding:

Is there a command/script/whatever to remove subvolume which contains
(somewhere) other subvolumes?

Example:

root@xerus:/test# btrfs_subvolume_list /test/ | grep /tmp
/test/tmp
/test/tmp/xx/ss1
/test/tmp/xx/ss2
/test/tmp/xx/ss3

root@xerus:/test# btrfs subvolume delete /test/tmp
Delete subvolume (no-commit): '/test/tmp'
ERROR: cannot delete '/test/tmp': Directory not empty



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190705193945.GB23600@tik.uni-stuttgart.de>
