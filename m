Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E7264E97
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIJTUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 15:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbgIJPyU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 11:54:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E0B1AA55;
        Thu, 10 Sep 2020 15:54:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6FFCBDA730; Thu, 10 Sep 2020 17:53:03 +0200 (CEST)
Date:   Thu, 10 Sep 2020 17:53:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: Remove unused function
 calc_global_rsv_need_space()
Message-ID: <20200910155303.GK18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, YueHaibing <yuehaibing@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200909135142.27352-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909135142.27352-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 09, 2020 at 09:51:42PM +0800, YueHaibing wrote:
> It is not used since commit 0096420adb03 ("btrfs: do not
> account global reserve in can_overcommit")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Added to misc-next, thanks.
