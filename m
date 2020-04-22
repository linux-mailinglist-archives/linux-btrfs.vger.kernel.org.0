Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B01B47B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgDVOto (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgDVOtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 10:49:43 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BEFC03C1A9;
        Wed, 22 Apr 2020 07:49:43 -0700 (PDT)
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id C771814133A;
        Wed, 22 Apr 2020 16:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587566980; bh=K82WD5SMGnPO0Iqk/V4GNqrcK3kJVchQaCY5P8RgEl0=;
        h=Date:From:To;
        b=xmRkQL58Xu4frKEQ/Z71X4L4j1YlimJ9gZTs8o1Ik9gZH3N1veqcuyfg2UyfW1l/m
         WVfUeAQFjIYjZM8eOKhvrWXBcoEYwjZgGxqbW6sO1kjygUyv0DtRxPhamuQA24ruRM
         0/KZ2CtOi8sitTxnOV8bSN9hPbcGpqe4lgu/jzz4=
Date:   Wed, 22 Apr 2020 16:49:40 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Su Yue <Damenly_Su@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 18/26] fs: btrfs: Implement btrfs_lookup_path()
Message-ID: <20200422164940.2d8e32d7@nic.cz>
In-Reply-To: <tv1binqc.fsf@gmx.com>
References: <20200422065009.69392-1-wqu@suse.com>
        <20200422065009.69392-19-wqu@suse.com>
        <tv1binqc.fsf@gmx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 22 Apr 2020 22:44:43 +0800
Su Yue <Damenly_Su@gmx.com> wrote:

> Looked through older codes, should be "symlink_limit - 1"?

OMG yes :) without this it can break :)
