Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F11B4CE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 20:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDVSwM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 14:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgDVSwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 14:52:12 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F2CC03C1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 11:52:11 -0700 (PDT)
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id AA8D2140BC2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 20:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587581529; bh=UrsPs8jNrsz7Px784nikxDT36F/VadRKL4cR/cg8sxo=;
        h=Date:From:To;
        b=R8hBWsm+pEkxyuMMipr/JdAM1I2tcW+YQW3vDflBpVAhSGya7DF2cNcGI/Uh3qZdN
         dBGQhSMcBpzvlQx/dXP/cY/NMp5go4vYkna7/ioq0vAWLEKmnCHCl0vGBfmlcChXyU
         bAhMV5z85+1g+IYSVIqwVF2yERefD58HF9o1OGJs=
Date:   Wed, 22 Apr 2020 20:52:09 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     linux-btrfs@vger.kernel.org
Subject: when does btrfs create sparse extents?
Message-ID: <20200422205209.0e2efd53@nic.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

there was a bug fixed recently in U-Boot's btrfs driver - the driver
failed to read files with sparse extents. This causes that sometimes
device failes to boot Linux, since the kernel fails to load from
storage.

So when does kernel's btrfs driver write sparse extents? Is it always
when it finds a PAGE_SIZEd and aligned all-zeros block? Or is it more
complicated?

Thanks.

Marek
