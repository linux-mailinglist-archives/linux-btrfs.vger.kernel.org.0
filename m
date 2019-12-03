Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8811043C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 19:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfLCS3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 13:29:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:44766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfLCS3h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 13:29:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28A55B25AA;
        Tue,  3 Dec 2019 18:29:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2555DA7D9; Tue,  3 Dec 2019 19:29:30 +0100 (CET)
Date:   Tue, 3 Dec 2019 19:29:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH v2] btrfs: remove unused condition check in
 btrfs_page_mkwrite()
Message-ID: <20191203182929.GT2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yunfeng Ye <yeyunfeng@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <d0053a0b-7fd0-153a-8a49-a0950005135c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0053a0b-7fd0-153a-8a49-a0950005135c@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 03, 2019 at 04:59:25PM +0800, Yunfeng Ye wrote:
> The condition '!ret2' is always true. commit 717beb96d969 ("Btrfs: fix
> regression in btrfs_page_mkwrite() from vm_fault_t conversion") left
> behind the check after moving this code out of the goto, so remove the
> unused condition check.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Added to misc-next, thanks.
