Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E763246696
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgHQMpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:45:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgHQMpd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:45:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3702AAC7;
        Mon, 17 Aug 2020 12:45:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F471DA6EF; Mon, 17 Aug 2020 14:44:27 +0200 (CEST)
Date:   Mon, 17 Aug 2020 14:44:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        dhowells@redhat.com
Subject: Re: [RFC PATCH 0/8] btrfs: convert to fscontext
Message-ID: <20200817124427.GD2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, dhowells@redhat.com
References: <20200812163654.17080-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163654.17080-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 01:36:46PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> These patches aim to convert btrfs to new fscontext API. I used the approach of
> creating a new parsing function and then switching to this new function, instead
> of creating a huge change patch. Please let me know if you think this is a
> better approach.

A huge patch would be unreviewable, incremental addition of the
callbacks and then 1 patch switch is what we want. Also we want the
whole series to be bisectable, I'm not sure if adding the callbacks like
.parameters will not take some path in the fs context and mixing it
together with the previous mount way.

This could be avoided by adding all the callbacks first and then
switching just the callbacks, without any other changes. The way you do
it in patch "btrfs: Convert to fs_context" feels too much. Temporary
code duplication is ok, removing unused functions as post-cleanups is
preferred.

> The most notable changes come form the fact that now we parse the mount options
> before having a fs_info, in the same way that David Howells did in his POC[1]
> some time ago.

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=Q46&id=554cb2019cda83e1aba10bd9eea485afd2ddb983

Adding David H. to CC.

> Marcos Paulo de Souza (8):
>   btrfs: fs_context: Add initial fscontext parameters
>   btrfs: super: Introduce fs_context ops, init and free functions
>   btrfs: super: Introduce btrfs_fc_parse_param and
>     btrfs_apply_configuration
>   btrfs: super: Introduce btrfs_fc_validate
>   btrfs: super: Introduce btrfs_dup_fc
>   btrfs: super: Introduce btrfs_mount_root_fc
>   btrfs: Convert to fs_context
>   btrfs: Remove leftover code from fscontext conversion

Please change the subjects to "btrfs: fs_context: ...", this is not
about super block.

I'll reply with more specific comments under the patches.
