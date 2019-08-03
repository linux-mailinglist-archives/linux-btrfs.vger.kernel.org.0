Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37DA805A7
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfHCKJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 06:09:32 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:56794 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388371AbfHCKJc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Aug 2019 06:09:32 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 1F9567A60
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Aug 2019 12:09:29 +0200 (MEST)
Date:   Sat, 3 Aug 2019 12:09:28 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs on RHEL7 (kernel 3.10.0) production ready?
Message-ID: <20190803100928.GB29941@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have RHEL 7 and CentOS 7.6 servers with kernel 3.10.0 and btrfs-progs v4.9.1
Is btrfs there ready for production usage(*)?

I will not use any btrfs RAID modes, because I have hardware RAID.
I just want to use (some few) snapshots.

The filesystem will have 50 TB and the server (VM) has 8 CPUs and 8 GB RAM.

Any recommendations?

(*) A (web based) file server, see https://fex.rus.uni-stuttgart.de/

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190803100928.GB29941@tik.uni-stuttgart.de>
