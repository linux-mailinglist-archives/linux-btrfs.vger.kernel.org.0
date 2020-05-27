Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50C31E42ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgE0NH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 09:07:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:33384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbgE0NH0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 09:07:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31820AD5D;
        Wed, 27 May 2020 13:07:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5640DA72D; Wed, 27 May 2020 15:06:27 +0200 (CEST)
Date:   Wed, 27 May 2020 15:06:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 1/3] btrfs: remove pointless out label in
 find_first_block_group
Message-ID: <20200527130627.GC18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
 <20200527081227.3408-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527081227.3408-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 05:12:25PM +0900, Johannes Thumshirn wrote:
> The 'out' label in find_first_block_group() does not do anything in terms
> of cleanup.
> 
> It is better to directly return 'ret' instead of jumping to out to not
> confuse readers. Additionally there is no need to initialize ret with 0.

https://www.kernel.org/doc/html/latest/process/coding-style.html#centralized-exiting-of-functions
