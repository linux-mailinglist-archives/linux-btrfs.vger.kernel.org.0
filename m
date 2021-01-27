Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAB305DB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhA0N7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 08:59:41 -0500
Received: from lists.nic.cz ([217.31.204.67]:51596 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhA0N54 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 08:57:56 -0500
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 2E7121420C8;
        Wed, 27 Jan 2021 14:57:12 +0100 (CET)
Date:   Wed, 27 Jan 2021 14:57:11 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, matthias.bgg@kernel.org,
        u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] fs: btrfs: Select SHA256 in Kconfig
Message-ID: <20210127145711.44db831d@nic.cz>
In-Reply-To: <20210127134758.GA1993@twin.jikos.cz>
References: <20210127094231.11740-1-matthias.bgg@kernel.org>
        <20210127120146.GZ1993@twin.jikos.cz>
        <5ae76d50-a52d-6f0e-1f23-335cb32f0371@suse.com>
        <20210127134758.GA1993@twin.jikos.cz>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 27 Jan 2021 14:47:58 +0100
David Sterba <dsterba@suse.cz> wrote:

> If it's a series then please mention u-boot in the cover letter, no need
> to change the patches, I'll go check CC if I'm too confused about the
> patch.

I would suggest using subject prefix [PATCH u-boot]
