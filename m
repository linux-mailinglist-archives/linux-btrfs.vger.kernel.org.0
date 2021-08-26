Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD89B3F87BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhHZMk1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242485AbhHZMkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 08:40:22 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6DC061757
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 05:39:34 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a50:c000:ace4:a413:6354:110a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 86D892ABE1D
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 14:39:33 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption errors on Samsung 980 Pro
Date:   Thu, 26 Aug 2021 14:39:32 +0200
Message-ID: <2483116.FlZDIz5lkP@ananda>
In-Reply-To: <2925925.e1IPqPlo5U@ananda>
References: <9070016.RUGz74dYir@ananda> <2925925.e1IPqPlo5U@ananda>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Martin Steigerwald - 26.08.21, 12:44:05 CEST:
> Could
> 
> [GIT PULL] Btrfs fix for 5.14-rc
> 
> https://lore.kernel.org/linux-btrfs/cover.1629897022.git.dsterba@suse.
> com/T/#u
> 
> be related to this issue?
> 
> One of the backtraces mention a kernel memory allocated failure that
> could be related to compression.

yeah, but this reverted patch would have disabled compression for 
certain cases, so not related as my kernels do not yet carry that 
revert.

Best,
-- 
Martin


