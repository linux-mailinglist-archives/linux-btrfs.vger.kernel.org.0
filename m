Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2E2419A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgHKK06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 06:26:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgHKK0z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 06:26:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EC21ACF9;
        Tue, 11 Aug 2020 10:27:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1ABC2DA83C; Tue, 11 Aug 2020 12:25:52 +0200 (CEST)
Date:   Tue, 11 Aug 2020 12:25:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pavel Machek <pavel@denx.de>
Cc:     clm@fb.com, jbacik@fb.com, dsterba@suse.com, sashal@kernel.org,
        wqu@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jungyeon@gatech.edu,
        stable@kernel.org
Subject: Re: [PATCH] btrfs: fix error value in btrfs_get_extent
Message-ID: <20200811102551.GM2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pavel Machek <pavel@denx.de>, clm@fb.com,
        jbacik@fb.com, dsterba@suse.com, sashal@kernel.org, wqu@suse.com,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jungyeon@gatech.edu,
        stable@kernel.org
References: <20200803093506.GA19472@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803093506.GA19472@amd>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 03, 2020 at 11:35:06AM +0200, Pavel Machek wrote:
> btrfs_get_extent() sets variable ret, but out: error path expect error
> to be in variable err. Fix that.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

Thanks, patch queued for 5.9.
> 
> ---
> 
> Notice that patch introducing this problem is on its way to 4.19.137-stable.

Yeah, I'll let stable team know once this patch gets merged that the
relevant patches can be picked.
