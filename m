Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16537558E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhEFOYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 10:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:41658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234485AbhEFOYr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 10:24:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35FACAC38;
        Thu,  6 May 2021 14:23:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41297DA81B; Thu,  6 May 2021 16:21:21 +0200 (CEST)
Date:   Thu, 6 May 2021 16:21:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     20210419124541.148269-1-l@damenly.su
Cc:     linux-btrfs@vger.kernel.org, l@damenly.su, boris@bur.io,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH v3] btrfs-progs: fi resize: fix false 0.00B sized output
Message-ID: <20210506142121.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, 20210419124541.148269-1-l@damenly.su,
        linux-btrfs@vger.kernel.org, l@damenly.su, boris@bur.io,
        Chris Murphy <lists@colorremedies.com>
References: <20210420045827.150881-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420045827.150881-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 12:58:27PM +0800, Su Yue wrote:
> Resize to nums without sign prefix makes false output:
>  btrfs fi resize 1:150g /srv/extra
> Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B
> 
> The resize operation would take effect though.
> 
> check_resize_args() does not handle the mod 0 case and new_size is 0.
> Simply assigning @diff to @new_size to fix this.
> 
> Issue: #307
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Signed-off-by: Su Yue <l@damenly.su>
> ---
> Changelog:
> v3:
>   Just assign @diff to @new_size. (Boris Burkov)

Patch replaced in devel, thanks.
