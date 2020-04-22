Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239CD1B4E75
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDVUo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 16:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUo2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 16:44:28 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ACFC03C1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 13:44:28 -0700 (PDT)
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 9098B141340;
        Wed, 22 Apr 2020 22:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587588265; bh=WDQ42LdzczTenRLuytqjSBvxu5tdbcx8rSz2JcqfxGo=;
        h=Date:From:To;
        b=HXSw9cFamsPGRbInXulRlpStlAksFM9QHPmjJ6m7GsfdtLmRlxD2AOBhTdQ3mkg7F
         KRpYO+VuUWO70tlGfRv+qUKjsBH9W5UnU2VjL1lNrvqjW10R3txytk79UTedYNHMAs
         jqRmU+snHnzpO7euU6r50FG+tv+aG5uD88EvlOTQ=
Date:   Wed, 22 Apr 2020 22:44:25 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: when does btrfs create sparse extents?
Message-ID: <20200422224425.7f2c6459@nic.cz>
In-Reply-To: <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
References: <20200422205209.0e2efd53@nic.cz>
        <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
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

On Wed, 22 Apr 2020 14:26:31 -0600
Chris Murphy <lists@colorremedies.com> wrote:

> But I wonder if other sources of this sparseness has been considered?
> Maybe the build system is creating or preserving sparseness? e.g. `tar
> --hole-detection` or `--sparse` is used.

I don't actually know how the kernel is copied into the /boot directory
in this case.

> Another possibility is Btrfs supports two kinds of holes in the
> on-disk format for sparse files. Maybe uboot only supported the
> original (current default) type, and the bug really fixed the newer
> 'no-holes' feature version?

No, U-Boot did not support holes at all.
