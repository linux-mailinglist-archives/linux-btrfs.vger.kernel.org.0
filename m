Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54D3FC657
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhHaLFB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:05:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36566 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbhHaLFA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:05:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 438F422205;
        Tue, 31 Aug 2021 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630407844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myOVS0ggbtbfUUqrMphUJhWK2gELvW1hG8oN5dFbiZE=;
        b=ZJo9tsfCjUGCL/PJs0BKUlfkOuNRSWoFkY5VfBVKss90jLXmH8qlmzXbyhY3vjmI4RpAgJ
        CUJeqeS3T+2fTZbaorSfM8OLoSZ52BJSXkF7agq2siTuD8t3LPyYDvkLsQnaf3O3u9BPM2
        56sGY2qaDs9ayO8+ajoNyE4APpRBSx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630407844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myOVS0ggbtbfUUqrMphUJhWK2gELvW1hG8oN5dFbiZE=;
        b=G/BYuDyskR76l4KFk3LnOjTQgucGEMPNE79j3RDhNwtP8ETILcWffZuUx6R62MSLqHUy7o
        u10APup/a202P0AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3D192A3B93;
        Tue, 31 Aug 2021 11:04:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8AEBBDA733; Tue, 31 Aug 2021 13:01:13 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:01:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/26] btrfs: limited subpage compressed write support
Message-ID: <20210831110113.GE3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210829052458.15454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 29, 2021 at 01:24:32PM +0800, Qu Wenruo wrote:
> The patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/compression
> 
> The branch is based on the previously submitted subpage enablement
> patchset.
> The target merge window is v5.16 or v5.17.

I did a light review and one round in fstests, no problems found so I
can add it to for-next after rc1.
