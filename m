Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6099F2B1EE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKMPgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 10:36:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgKMPgg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 10:36:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7D84AC91;
        Fri, 13 Nov 2020 15:36:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5DDBDA87A; Fri, 13 Nov 2020 16:34:52 +0100 (CET)
Date:   Fri, 13 Nov 2020 16:34:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: qgroup: don't commit transaction when we have
 already hold a transaction handler
Message-ID: <20201113153452.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20201111113818.137633-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111113818.137633-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 07:38:18PM +0800, Qu Wenruo wrote:

> Link: https://bugzilla.suse.com/show_bug.cgi?id=1178634

Please use Bugzilla: when it's not a generic link but our bugzilla.

> Fixes: c53e9653605d ("btrfs: qgroup: try to flush qgroup space when we get -EDQUOT")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
