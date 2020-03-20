Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65918D87C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 20:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCTTj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 15:39:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTTj7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 15:39:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D35DAAFD;
        Fri, 20 Mar 2020 19:39:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1291DDA70E; Fri, 20 Mar 2020 20:39:27 +0100 (CET)
Date:   Fri, 20 Mar 2020 20:39:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/5] btrfs: restart snapshot delete if we have to end the
 transaction
Message-ID: <20200320193927.GH12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200320183436.16908-1-josef@toxicpanda.com>
 <20200320183436.16908-6-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183436.16908-6-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 20, 2020 at 02:34:36PM -0400, Josef Bacik wrote:
> @@ -5377,6 +5392,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>  			}
>  			if (block_rsv)
>  				trans->block_rsv = block_rsv;
> +			goto again;

This hunk does not apply cleanly and there's no block_rsv around in
current misc-next + this series. I get this as automatic merge
resolution but that's obviously wrong and I don't see how can I fix it.

  3166                 ret = add_to_free_space_tree(trans, bytenr, num_bytes);                                                                                                                                     
  3167                 if (ret) {                                                                                                                                                                                  
  3168                         btrfs_abort_transaction(trans, ret);                                                                                                                                                
  3169                         goto out;                                                                                                                                                                           
  3170                 }                                                                                                                                                                                           
  3171                                                                                                                                                                                                             
  3172                 ret = btrfs_update_block_group(trans, bytenr, num_bytes, 0);                                                                                                                                
  3173                 if (ret) {                                                                                                                                                                                  
  3174                         btrfs_abort_transaction(trans, ret);                                                                                                                                                
  3175                         goto out;                                                                                                                                                                           
+ 3176                         goto again;                                                                                                                                                                         
  3177                 }                                                                                                                                                                                           
  3178         }                                                                                                                                                                                                   
  3179         btrfs_release_path(path);                                                                                                                                                                           
  3180                                                                                                                                                                                                             
  3181 out:                                                                                                                                                                                                        
  3182         btrfs_free_path(path);                                                                                                                                                                              
  3183         return ret;                                                                                                                                                                                         
  3184 }

So I guess it's because of some other patches in your tree. I'm about to
push misc-next with patches 1-4, so you can have a look.
