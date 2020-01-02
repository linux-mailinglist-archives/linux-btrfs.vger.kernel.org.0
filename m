Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97A12E66F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 14:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgABNS0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 08:18:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:55802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgABNS0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 08:18:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 442ABAD4F;
        Thu,  2 Jan 2020 13:18:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8286DA790; Thu,  2 Jan 2020 14:18:09 +0100 (CET)
Date:   Thu, 2 Jan 2020 14:18:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove unneeded semicolon
Message-ID: <20200102131809.GD3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, zhengbin <zhengbin13@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <1576747534-112105-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576747534-112105-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 19, 2019 at 05:25:34PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
> 
> fs/btrfs/print-tree.c:320:3-4: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Applied, thanks.
