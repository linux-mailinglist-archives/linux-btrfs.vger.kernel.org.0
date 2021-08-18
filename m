Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6132A3F0E20
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhHRW2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 18:28:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39302 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhHRW2V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 18:28:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5678422077;
        Wed, 18 Aug 2021 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629325665;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5d9Wvj7jiJjU1b/YIcWHetbUT5XlBRCmx5mkVz8Iz0M=;
        b=3JXVkiGZk4AHwr2bJHmM1esi2MPVPcHVMPJMvvfCwNqXNYHQ9BKUyDf0IZWcA83SVHbwR0
        rHqfr4evRF3aA1B0fDpiUaFP+sS6thp9hdy991HVYAU9DhAb29FuYduqZGfTsk1s0Zq/aq
        83wsk1rV6jy42HjXrhCoRmluwDeRQts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629325665;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5d9Wvj7jiJjU1b/YIcWHetbUT5XlBRCmx5mkVz8Iz0M=;
        b=oxgC69miP91eBWNW/NZqBagj/3HIec77lKKqt3Cz99+2XBwpCkmU8Or4pz7rbEYkri1shy
        55wXxCxEPBZIxlBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 508CDA3B9A;
        Wed, 18 Aug 2021 22:27:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4212DA72C; Thu, 19 Aug 2021 00:24:47 +0200 (CEST)
Date:   Thu, 19 Aug 2021 00:24:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflink: Assure length != 0 in btrfs_extent_same()
Message-ID: <20210818222447.GX5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210818160815.1820-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818160815.1820-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 04:08:15PM +0000, Sidong Yang wrote:
> btrfs_extent_same() cannot be called with zero length. Because when
> length is zero, it would be filtered by condition in
> btrfs_remap_file_range(). But if this function is used in other case in
> future, it can make ret as uninitialized.

Do you have a specific future in mind? Adding the assert won't hurt so
ok.
