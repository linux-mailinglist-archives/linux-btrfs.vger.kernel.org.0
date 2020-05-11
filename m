Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219E81CDD28
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgEKO3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 10:29:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKO3K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 10:29:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C4E4AEC7;
        Mon, 11 May 2020 14:29:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 06126DA823; Mon, 11 May 2020 16:28:18 +0200 (CEST)
Date:   Mon, 11 May 2020 16:28:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] Btrfs: fix a race between scrub and block group
 removal/allocation
Message-ID: <20200511142818.GS18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200508100110.6965-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508100110.6965-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 08, 2020 at 11:01:10AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>

> CC: stable@vger.kernel.org
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

1-4 added to misc-next, thanks.
