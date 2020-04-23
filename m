Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1863C1B5B10
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgDWMGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 08:06:01 -0400
Received: from mail.nic.cz ([217.31.204.67]:60280 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgDWMGB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 08:06:01 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 9ABA1140BD3;
        Thu, 23 Apr 2020 14:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587643559; bh=nxHXBtc17tdr9/PXyViOl0/31Uh145wVFp/rRB2kfdg=;
        h=Date:From:To;
        b=Ja9khifcxhDEoHA3WU7Wqr5IPJRKyLCQaeeGDbwsxLQzl5dKuXtxpeMELL7NsrFcG
         Xcrc/DGUgQoK1dhTgAsnL4HWEqgQ9RnUOUT0hLEVTIVqMiSOkN8dsp4ls9Y39sUA1e
         XfR1/Q4413Far7S18gBlyEekR2mtP+pT9L0UZxQE=
Date:   Thu, 23 Apr 2020 14:05:59 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: when does btrfs create sparse extents?
Message-ID: <20200423140559.2762bb0c@nic.cz>
In-Reply-To: <CAL3q7H41C6do6SdBCfCmA==TT1nPJQ4dB0vTi_jsm0tYuvvsUA@mail.gmail.com>
References: <20200422205209.0e2efd53@nic.cz>
        <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
        <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
        <20200422225851.3d031d88@nic.cz>
        <CAL3q7H7eE4wFi95JaTYRPOrTQiihOSEqV-W4hT1t-9-ptUHGrg@mail.gmail.com>
        <20200423134248.458cd87c@nic.cz>
        <CAL3q7H41C6do6SdBCfCmA==TT1nPJQ4dB0vTi_jsm0tYuvvsUA@mail.gmail.com>
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

On Thu, 23 Apr 2020 12:51:32 +0100
Filipe Manana <fdmanana@gmail.com> wrote:

> There's nothing in btrfs that converts a sequence of zeroes
> automatically to a hole.
> 
> It always has to be done by user space, either by writes that leave
> holes intentionally (e.g. create file, write 64K to offset 0, write 4K
> to offset 128, leaves a hole from range 64K to 128K) or by hole
> punching through fallocate().

Thanks for this information. If you ever come to Prague, let me know,
we can have a beer :D
