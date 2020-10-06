Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D58284934
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 11:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJFJSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 05:18:37 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:52800 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgJFJSh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 05:18:37 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 05:18:36 EDT
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 95FE3347A421
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Oct 2020 11:06:42 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q_5DIVWDKgZH for <linux-btrfs@vger.kernel.org>;
        Tue,  6 Oct 2020 11:06:33 +0200 (CEST)
Received: from latitude (clubwlan-093.fem.tu-ilmenau.de [141.24.40.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Oct 2020 11:06:00 +0200 (CEST)
Date:   Tue, 6 Oct 2020 11:09:18 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     linux-btrfs@vger.kernel.org
Subject: failed to read block groups: Operation not permitted
Message-ID: <20201006090918.GA269054@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently encountered filesystem damage on a VM. During normal
operation, the filesystem was remounted ro suddenly. Dmesg showed me
some errors about parent transid verify failed. I've forced of the VM
and tried to mount the image on the host, but failed with:

[  340.702391] BTRFS info (device loop0p1): disk space caching is enabled
[  340.702393] BTRFS info (device loop0p1): has skinny extents
[  341.815890] BTRFS error (device loop0p1): parent transid verify failed on 152064327680 wanted 323984 found 323888
[  341.831183] BTRFS error (device loop0p1): parent transid verify failed on 152064327680 wanted 323984 found 323888
[  341.831194] BTRFS error (device loop0p1): failed to read block groups: -5
[  341.851954] BTRFS error (device loop0p1): open_ctree failed

A btrfs check resulted in:

btrfs check /dev/loop0p1
Opening filesystem to check...
parent transid verify failed on 152064327680 wanted 323984 found 323888
parent transid verify failed on 152064327680 wanted 323984 found 323888
parent transid verify failed on 152064327680 wanted 323984 found 323888
Ignoring transid failure
leaf parent key incorrect 152064327680
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system

The host is running libvirt with kvm, btrfs with RAID1. The VMs are raw
images, with btrfs too. I've switche this VM from io=native to
io=io_uring, and suspect that this caused the damage. All machines are
running kernel 5.8.13.

I was able to recover most of the damaged filesystem with btrfs recover.
Is there anything I can do for repair it? And why does the damage happen
at all with io_uring?

-- 
Regards,
  Johannes Hirte

