Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B399EFA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfH0QE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 12:04:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730292AbfH0QEZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 12:04:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2BFAAEC4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 16:04:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4AACEDA8D5; Tue, 27 Aug 2019 18:04:48 +0200 (CEST)
Date:   Tue, 27 Aug 2019 18:04:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Cleanup btrfs_find_name_in* functions
Message-ID: <20190827160448.GR2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190827114630.2425-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827114630.2425-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 02:46:27PM +0300, Nikolay Borisov wrote:
> This series cleans up the calling convention of the 2 function used to search 
> the INODE_REF items for the presence of particular name. Namely, I switch the 2
> functions to directly return a struct btrfs_inode_(ext)?ref. This reduces the 
> number of parameters when calling the functions. 
> 
> While doing the aforementioned cleanup I stumbled upon backref_in_log which was 
> opencoding btrfs_find_name_in_backref hence I just refactored the function. 
> 
> This series survived xfstest. 
> 
> Nikolay Borisov (3):
>   btrfs: Make btrfs_find_name_in_backref return btrfs_inode_ref struct
>   btrfs: Make btrfs_find_name_in_ext_backref return struct
>     btrfs_inode_extref
>   btrfs: Use btrfs_find_name_in_backref in backref_in_log

1 and 2 merged to misc-next, thanks.
