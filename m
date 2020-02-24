Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2116A9D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBXPUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:20:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:45876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbgBXPUA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2019AE46;
        Mon, 24 Feb 2020 15:19:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C494DA727; Mon, 24 Feb 2020 16:19:40 +0100 (CET)
Date:   Mon, 24 Feb 2020 16:19:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/30] btrfs: Add missing annotation for
 release_extent_buffer()
Message-ID: <20200224151940.GW2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jules Irenge <jbi.octave@gmail.com>,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
 <20200223231711.157699-2-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223231711.157699-2-jbi.octave@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 23, 2020 at 11:16:42PM +0000, Jules Irenge wrote:
> Sparse reports a warning at release_extent_buffer()
> warning: context imbalance in release_extent_buffer() - unexpected unlock
> 
> The root cause is the missing annotation at release_extent_buffer()
> Add the missing __releases(&eb->refs_lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Added to misc-next, thanks.
