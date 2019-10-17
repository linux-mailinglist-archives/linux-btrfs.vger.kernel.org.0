Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A24DAED8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437274AbfJQN4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 09:56:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437262AbfJQN4l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 09:56:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D8D7B024;
        Thu, 17 Oct 2019 13:56:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F2E1DA808; Thu, 17 Oct 2019 15:56:49 +0200 (CEST)
Date:   Thu, 17 Oct 2019 15:56:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/8] btrfs: Cleanup and simplify find_newest_super_backup
Message-ID: <20191017135648.GJ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191015154224.21537-1-nborisov@suse.com>
 <20191015154224.21537-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154224.21537-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 06:42:17PM +0300, Nikolay Borisov wrote:
> Backup roots are always written in a circular manner. By definition we
> can only ever have 1 backup root whose generation equals to that of the
> superblock. Hence, the 'if' in the for loop will trigger at most once.
> This is sufficient to return the newest backup root.
> 
> Furthermore thew newest_gen parameter is always set to the generation
> of the superblock. This value can be obtained from the fs_info.
> 
> This patch removes the unnecessary code dealing with the wraparound
> case and makes 'newest_gen' a local variable.

"This patch cannot be applied without an SOB line." --n. borisov

And the rest does not have it either, I'll add it to avoid pointless
resends.

Tip of the day: use 'git commit -save' for every commit, it adds SOB,
opens editor for changelog and also shows the the diff
