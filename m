Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528011B3B6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDVJdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 05:33:43 -0400
Received: from mail.nic.cz ([217.31.204.67]:48330 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDVJdn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 05:33:43 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id B6FE514088B;
        Wed, 22 Apr 2020 11:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587548021; bh=jpZUacI/skFibwkwrgjZjyr2c6I2G5qlSKhqtPZC/M4=;
        h=Date:From:To;
        b=jeZ0WTTzJRJQnhgHocmak8hv+OT56bowGSQs6KzPwMQbU33CgEDW8SqDxUOXRidEI
         A5DDsfbBBXWdzDNpZX4x5irTx7cYt5d6GKTzUIG9w1dQyRFAByc4iTldEiiOvM4KUq
         0dIH9yzT4M52L0FDhS5sQZ4uMKqRsojW50JF7OOk=
Date:   Wed, 22 Apr 2020 11:33:41 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support
 using the more widely used extent buffer base code
Message-ID: <20200422113341.62880c72@nic.cz>
In-Reply-To: <fa3177ef-c264-2fc0-4793-d35209d05d2b@gmx.com>
References: <20200422065009.69392-1-wqu@suse.com>
        <20200422094607.1797ce2e@nic.cz>
        <fa3177ef-c264-2fc0-4793-d35209d05d2b@gmx.com>
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

On Wed, 22 Apr 2020 15:52:25 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> > do you think maybe btrfs-progs / kernel would be interested if I
> > tried to convert their code to this "simpler to use" implementation of
> > conversion functions?  
> 
> I don't think so, the problem is kernel and btrfs-progs all need to
> modify extent buffer, which make the read time conversion become a
> burden in write path.

:(
