Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE89297573
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbgJWRCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 13:02:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S464587AbgJWRCW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 13:02:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02A9CAC82;
        Fri, 23 Oct 2020 17:02:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D7F2DA7F1; Fri, 23 Oct 2020 19:00:49 +0200 (CEST)
Date:   Fri, 23 Oct 2020 19:00:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Open code insert_orphan_item
Message-ID: <20201023170049.GL6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201022154046.1654593-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022154046.1654593-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 22, 2020 at 06:40:46PM +0300, Nikolay Borisov wrote:
> Just open code it in its sole caller and remove a level of indirection.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
