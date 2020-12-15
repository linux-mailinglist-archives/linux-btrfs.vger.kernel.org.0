Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A682DB235
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgLORKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 12:10:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:44316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgLORKo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 12:10:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4068AFA8;
        Tue, 15 Dec 2020 17:10:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE079DA7C3; Tue, 15 Dec 2020 18:08:23 +0100 (CET)
Date:   Tue, 15 Dec 2020 18:08:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Overhaul free objectid code
Message-ID: <20201215170823.GY6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 05:32:31PM +0200, Nikolay Borisov wrote:
> This series aims to make the free objectid code more straighforward. Currently
> the highest used objectid is used which implies that when btrfs_get_free_objectid
> is called the pre-increment operator is used. At the same time when looking
> at how highest_objectid is initialised in find_free_objectid it's using the,
> at first looko unusual, 'BTRFS_FREE_OBJECTID - 1'. Furthermore btrfs_find_free_objectid
> is badly named as it's used only in initializaion context.
> 
> With the series applied the following is achieved:
>  * The 2 functions related to free objectid have better naming which describes
>  their semantic meaning.
> 
>  * highest_objectid is renamed to free_objectid which clearly states what it's
>  supposed to hold, also btrfs_get_free_objectid now returns the value and
>  does a post-increment which seems more logical than the previous cod.
> 
>  * Now it's not necessary to re-initialize free_objectid in create_subvol
>  since that member is now consistently initialized when a given root is read
>  for the first time in btrfs_init_fs_root->btrfs_init_root_free_objectid.
>  Additionally in btrfs_init_root_free_objectid free_objectid is now initialized
>  to BTRFS_FIRST_FREE_OBJECTID so it's self-explanatory.
> 
> This series survived xfstest as well as a new xfstest which verifies precisely
> this functionality.
> 
> 
> Nikolay Borisov (6):
>   btrfs: Rename btrfs_find_highest_objectid to
>     btrfs_init_root_free_objectid
>   btrfs: Rename btrfs_find_free_objectid to btrfs_get_free_objectid
>   btrfs: Remove useless ASSERTS
>   btrfs: Rename highest_objectid to free_objectid
>   btrfs: Make free_objectid hold the next available objectid in the root
>   btrfs: Remove new_dirid argument from btrfs_create_subvol_root

Except patch 3 (the assert) added to misc-next, thanks.
