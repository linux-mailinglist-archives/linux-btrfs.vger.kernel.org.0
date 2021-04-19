Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5003648B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbhDSRFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 13:05:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:38328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhDSRFz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 13:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B259B30A;
        Mon, 19 Apr 2021 17:05:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A6E2DA732; Mon, 19 Apr 2021 19:03:06 +0200 (CEST)
Date:   Mon, 19 Apr 2021 19:03:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     20210419124541.148269-1-l@damenly.su
Cc:     linux-btrfs@vger.kernel.org, l@damenly.su,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH v2] btrfs-progs: fi resize: fix false 0.00B sized output
Message-ID: <20210419170306.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, 20210419124541.148269-1-l@damenly.su,
        linux-btrfs@vger.kernel.org, l@damenly.su,
        Chris Murphy <lists@colorremedies.com>
References: <20210419130549.148685-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419130549.148685-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 19, 2021 at 09:05:49PM +0800, Su Yue wrote:
> Resize to nums without sign prefix makes false output:
>  btrfs fi resize 1:150g /srv/extra
> Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B
> 
> The resize operation would take effect though.
> 
> Fix it by handling the case if mod is 0 in check_resize_args().
> 
> Issue: #307
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Signed-off-by: Su Yue <l@damenly.su>

Thanks, added to devel.
