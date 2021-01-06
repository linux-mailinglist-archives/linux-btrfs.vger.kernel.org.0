Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E242EC14B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhAFQhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 11:37:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:59524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbhAFQhA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 11:37:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09203AD75;
        Wed,  6 Jan 2021 16:36:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89B6FDA6E9; Wed,  6 Jan 2021 17:34:29 +0100 (CET)
Date:   Wed, 6 Jan 2021 17:34:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs2@lesimple.fr>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: relocation: fix wrong file extent type check to
 avoid false -ENOENT error
Message-ID: <20210106163429.GU6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210104161655.GJ6430@twin.jikos.cz>
 <20201229132934.117325-1-wqu@suse.com>
 <7f932027eebe43b2e63908f1d4889e24@lesimple.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f932027eebe43b2e63908f1d4889e24@lesimple.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 05, 2021 at 06:24:24PM +0000, Stéphane Lesimple wrote:
> FWIW, just recompiled with the patch to be 100% sure, as I still had
> the problematic FS around untouched:
> 
> [  199.722122] BTRFS info (device dm-10): balance: start -dvrange=34625344765952..34625344765953
> [  199.730267] BTRFS info (device dm-10): relocating block group 34625344765952 flags data|raid1
> [  212.232222] BTRFS info (device dm-10): found 167 extents, stage: move data extents
> [  236.124541] BTRFS info (device dm-10): found 167 extents, stage: update data pointers
> [  248.011778] BTRFS info (device dm-10): balance: ended with status: 0
> 
> As expected, all is good now!
> 
> Tested-By: Stéphane Lesimple <stephane_btrfs2@lesimple.fr>

Thanks for testing, tag added to the patch.
