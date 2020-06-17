Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512021FD14C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFQPwg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 11:52:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQPwg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 11:52:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62C5DAE91;
        Wed, 17 Jun 2020 15:52:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5D48DA728; Wed, 17 Jun 2020 17:52:25 +0200 (CEST)
Date:   Wed, 17 Jun 2020 17:52:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/5] btrfs: qgroup: detect and fix leaked data
 reserved space
Message-ID: <20200617155225.GM27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200616235955.21385-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616235955.21385-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 07:59:50AM +0800, Qu Wenruo wrote:
> v4:
> - Pure changelog update to co-operate with the dio iomap revert
>   Only the 1st and the 4th patches get updated.

Updated, thanks.
