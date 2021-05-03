Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88AA3723B3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhECXqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 19:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhECXqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 19:46:24 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1577C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 16:45:30 -0700 (PDT)
Received: from thinkpad (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 141C0140570;
        Tue,  4 May 2021 01:45:28 +0200 (CEST)
Date:   Tue, 4 May 2021 01:45:27 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Simon Glass <sjg@chromium.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andre Przywara <andre.przywara@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/49] btrfs: Use U-Boot API for decompression
Message-ID: <20210504014527.20fcda60@thinkpad>
In-Reply-To: <20210503171001.4.I7327e42043265556e3988928849ff2ebdc7b21e6@changeid>
References: <20210503231136.744283-1-sjg@chromium.org>
        <20210503171001.4.I7327e42043265556e3988928849ff2ebdc7b21e6@changeid>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

On Mon,  3 May 2021 17:10:51 -0600
Simon Glass <sjg@chromium.org> wrote:

> Use the common function to avoid code duplication.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Is this tested? Why only zstd?

marek
