Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFCD2F93
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfJJRaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 13:30:04 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:50532 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJJRaE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 13:30:04 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 13:30:02 EDT
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 71DB5B95C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 19:20:11 +0200 (MEST)
Date:   Thu, 10 Oct 2019 19:20:11 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: rsync -ax and subvolumes
Message-ID: <20191010172011.GA3392@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I run into the problem that "rsync -ax" sees btrfs subvolumes as "other
filesystems" and ignores them.

framstag@tux:~: rsync -h | grep one-file-system
 -x, --one-file-system       don't cross filesystem boundaries

How could I tell rsync to include btrfs subvolumes, but exclude
other mounted filesystems?

Do I have to write a rsync wrapper script and find all subvolumes to have
them included? Nasty task...

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20191010172011.GA3392@tik.uni-stuttgart.de>
