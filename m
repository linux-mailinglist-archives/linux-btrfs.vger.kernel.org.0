Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC507F98B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 19:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKLSe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 13:34:29 -0500
Received: from smtp02.belwue.de ([129.143.71.87]:64178 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfKLSe3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 13:34:29 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 116A86C42
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 19:34:26 +0100 (MET)
Date:   Tue, 12 Nov 2019 19:34:25 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs based backup?
Message-ID: <20191112183425.GA1257@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I need a new backup system for some servers. Destination is a RAID, not
tapes.

So far I have used a self written shell script. 25 years old, over 1000
lines of (HORRIBLE) code, no longer maintenable :-}

All backup software I know is either too primitive (e.g. no versioning) or
very complex and needs a long time to master it.

My new idea is:

Set up a backup server with btrfs storage (with compress mount option),
the clients do their backup with rsync over nfs.

For versioning I make btrfs snapshots.


To have a secondary backup I will use btrfs send / receive,


Any comments on this? Or better suggestions?

The backup software must be open source!

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20191112183425.GA1257@tik.uni-stuttgart.de>
