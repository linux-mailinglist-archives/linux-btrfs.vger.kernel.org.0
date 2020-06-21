Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AE2028E5
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jun 2020 07:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgFUFuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Jun 2020 01:50:03 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:47629 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgFUFuD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Jun 2020 01:50:03 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 01:50:02 EDT
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 9E1FF6197
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 07:42:40 +0200 (MEST)
Date:   Sun, 21 Jun 2020 07:42:40 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: weekly fstrim (still) necessary?
Message-ID: <20200621054240.GA25387@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On SLES a weekly fstrim is done via a btrfsmaintenance script, which is
missing on Ubuntu.

For ext4 filesystem an explicite fstrim call is no longer neccessary, what
about btrfs?
Shall I call fstrim via /etc/cron.weekly ?



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20200621054240.GA25387@tik.uni-stuttgart.de>
