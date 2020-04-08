Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE21A27DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDHRUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 13:20:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbgDHRUX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 13:20:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0130DAB5C;
        Wed,  8 Apr 2020 17:20:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D5860DA730; Wed,  8 Apr 2020 19:19:45 +0200 (CEST)
Date:   Wed, 8 Apr 2020 19:19:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] Btrfs: remove pointless assertion on reclaim_size
 counter
Message-ID: <20200408171945.GA5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200407103858.31029-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407103858.31029-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 11:38:58AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The reclaim_size counter of a space_info object is unsigned. So its value
> can never be negative, it's pointless to have an assertion that checks
> its value is >= 0, therefore remove it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
