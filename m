Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1257612F6
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 22:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGFUnq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 16:43:46 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:35420 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfGFUnq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Jul 2019 16:43:46 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 24CC29F23
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Jul 2019 22:43:43 +0200 (MEST)
Date:   Sat, 6 Jul 2019 22:43:39 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find snapshot parent?
Message-ID: <20190706204339.GB13656@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190706155353.GA13656@tik.uni-stuttgart.de>
 <1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 2019-07-06 (19:57), Nikolay Borisov wrote:

> > And how can I see whether /test/tmp/xx/ss1 is a snapshot at all?
> > Do all snapshots have a "Parent UUID" and regular subvolumes not?
> 
> Indeed, only snapshots have a Parent UUID.

Not all:

root@xerus:/test# btrfs subvolume snapshot -r /test /test/ss1
Create a readonly snapshot of '/test' in '/test/ss1'

root@xerus:/test# btrfs subvolume show /test/ss1
/test/ss1
        Name:                   ss1
        UUID:                   02bd07bc-0bab-3442-96be-40790e1ba9be
        Parent UUID:            -
        Received UUID:          -
        Creation time:          2019-07-06 22:37:37 +0200
        Subvolume ID:           1036
        Generation:             9824
        Gen at creation:        9824
        Parent ID:              5
        Top level ID:           5
        Flags:                  readonly
        Snapshot(s):

root@xerus:/test# btrfs subvolume show /test
/test is toplevel subvolume

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
