Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23AC76F2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfGZQjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 12:39:49 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:45425 "EHLO
        aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfGZQjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 12:39:49 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2019 12:39:48 EDT
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
        id 922295463; Fri, 26 Jul 2019 18:31:32 +0200 (CEST)
Date:   Fri, 26 Jul 2019 18:31:32 +0200
From:   "Stephen R. van den Berg" <srb@cuci.nl>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: qgroup: Don't trigger backref walk at delayed ref insert time (Re:
 Kernel traces)
Message-ID: <20190726163132.GA29895@cuci.nl>
References: <20181210120514.GA14828@cuci.nl>
 <CAJCQCtQxaAKMP9qSF1UnOG7cy8ya=4MckGt9kL0O8oGxD4fitg@mail.gmail.com>
 <20181211115226.GA20157@cuci.nl>
 <CAJCQCtRva5ZrF2pq93pb0_be7P+CE+0no-nJeQTXtEaq-LpfVQ@mail.gmail.com>
 <20181212072614.GA9188@cuci.nl>
 <CAJCQCtSCcM0YTtp0f1i=FmrFigsfJEsr+Excwm=YHx4_wN49gg@mail.gmail.com>
 <20181228092036.GA30363@cuci.nl>
 <9b81647b-66c2-9870-161f-084b7d41af9c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b81647b-66c2-9870-161f-084b7d41af9c@gmx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote:
>It's caused by qgroup, and a dead lock on btrfs_drop_snapshot().

>This is one of the easiest way to trigger an ABBA deadlock.

>Please either disable qgroup or apply this patch to solve it:
>https://patchwork.kernel.org/patch/10725371/

Can anyone confirm that patch https://patchwork.kernel.org/patch/10725371/
(qgroup: Don't trigger backref walk at delayed ref insert time)
is present in mainline Linux kernel v5.2.2 ?

I seem to be getting a conflict on merging that patch with this kernel.
-- 
Stephen.
