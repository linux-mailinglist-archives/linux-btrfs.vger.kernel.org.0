Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87B380D12
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhENPb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 11:31:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhENPbZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 11:31:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81F99B0D7;
        Fri, 14 May 2021 15:30:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A9FDDAF1B; Fri, 14 May 2021 17:27:42 +0200 (CEST)
Date:   Fri, 14 May 2021 17:27:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: disable space cache using proper function
Message-ID: <20210514152742.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210514020308.3824607-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514020308.3824607-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 11:03:08AM +0900, Naohiro Aota wrote:
> As btrfs_set_free_space_cache_v1_active() is introduced, this patch uses
> it to disable space cache v1 properly.

Can you please describe what problem is it fixing, of if it's a problem
at all? The two functions do have quite different effects, resetting
generation is simple but the new function starts transaction and
iterates over all space inodes. That's beyond obvious so this needs an
explanation. Thanks.
