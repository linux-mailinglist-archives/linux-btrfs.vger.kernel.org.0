Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBAA219DAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgGIKZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 06:25:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:40044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGIKZ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 06:25:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8293ADFE;
        Thu,  9 Jul 2020 10:25:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0319ADAB7F; Thu,  9 Jul 2020 12:25:05 +0200 (CEST)
Date:   Thu, 9 Jul 2020 12:25:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: relocation: review the call sites which
 can be interruped by signal
Message-ID: <20200709102503.GG28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200709083333.137927-1-wqu@suse.com>
 <20200709083333.137927-2-wqu@suse.com>
 <20200709095413.GF28832@twin.jikos.cz>
 <76a28b23-f1f6-1dbe-05f1-f642747564f9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76a28b23-f1f6-1dbe-05f1-f642747564f9@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 09, 2020 at 06:15:09PM +0800, Qu Wenruo wrote:
> On 2020/7/9 下午5:54, David Sterba wrote:
> > On Thu, Jul 09, 2020 at 04:33:33PM +0800, Qu Wenruo wrote:
> >> @@ -4135,7 +4135,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
> >>  	mutex_lock(&fs_info->balance_mutex);
> >>  	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
> >>  		btrfs_info(fs_info, "balance: paused");
> >> -	else if (ret == -ECANCELED && atomic_read(&fs_info->balance_cancel_req))
> >> +	else if (ret == -ECANCELED  || ret == -EINTR)
> > 
> > Why do you remove atomic_read(&fs_info->balance_cancel_req) ?
> 
> Because now btrfs_should_cancel_balance() can return ECANCELED without
> balance_cancel_req increased due to pending fatal signal.

Ah right, I misread it as || which would remove one reason for
cancellation.
