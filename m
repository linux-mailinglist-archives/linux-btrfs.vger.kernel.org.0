Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD940D967
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhIPMCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 08:02:53 -0400
Received: from lists.nic.cz ([217.31.204.67]:46678 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238705AbhIPMCx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 08:02:53 -0400
Received: from thinkpad (unknown [172.20.6.87])
        by mail.nic.cz (Postfix) with ESMTPSA id D473B14238C;
        Thu, 16 Sep 2021 14:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1631793689; bh=0JOjZV8kgnDm+oUPfdGBJ7fGSgcQHkKaD1FLAfF1Meg=;
        h=Date:From:To;
        b=Fat1YObBk4e/wsYEktvP/w6JyBhj9Hl/RDxTaQo4t9Ug+fzGcA/KPcmqc9Og/xp+W
         sa3xZBmhuhLNY6UqFNviEolFYysal73RNVLH5XJIxfD/yo4Uvfy6Uc6LmlNK3mFSCu
         1eRpOJkZggtIiFSWta0ou1fcE0zZDQQru4dLMOrQ=
Date:   Thu, 16 Sep 2021 14:01:28 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fs: btrfs: avoid superfluous messages
Message-ID: <20210916140128.4f4fbad9@thinkpad>
In-Reply-To: <20210916080245.42757-1-heinrich.schuchardt@canonical.com>
References: <20210916080245.42757-1-heinrich.schuchardt@canonical.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 16 Sep 2021 10:02:45 +0200
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

Heinrich, Simon already sent patch
https://lore.kernel.org/u-boot/20210818214022.4.I3eb71025472bbb050bcf9a0a192dde1b6c07fa7f@changeid/

Tom, could you apply Simon's version?

Marek
