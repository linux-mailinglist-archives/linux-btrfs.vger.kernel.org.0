Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E93207874
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgFXQLq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:11:46 -0400
Received: from lists.nic.cz ([217.31.204.67]:49454 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404235AbgFXQLq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:11:46 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id CC39913FEB2;
        Wed, 24 Jun 2020 18:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593015104; bh=fiz+0qODiihQAGVVn/7mQbNFuN5NKocZrPbhDDV9XOs=;
        h=Date:From:To;
        b=IYBYb+fKE0PSb/clyUHiu5hwphN+D7rdgKKjyg4/7HOg0778J0ftucrKnrDYFF1Yc
         70LWk1q4Dp6wp7VjAH5/HnAvEnuWWpLJbJge3V1f3ZyBZGgbeTn06bTx0M0lu1CzfW
         gOLIQMWEKBOkXWKIsfmwPDv+qTrRzC06efGGEARI=
Date:   Wed, 24 Jun 2020 18:11:44 +0200
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     Alberto =?ISO-8859-1?Q?S=E1nchez?= Molero <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH U-BOOT v3 00/30] PLEASE TEST fs: btrfs: Re-implement
 btrfs support using code from btrfs-progs
Message-ID: <20200624181144.63b50a64@dellmb.labs.office.nic.cz>
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I shall compile for different platforms with and without these patches
to see how much these patches increase the size of the resulting U-Boot
binary.

Maybe it will show us that it is finally time to look into LTO for
U-Boot.
