Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C06DB5BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441244AbfJQSTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 14:19:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2441262AbfJQSTL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 14:19:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6DFEB089;
        Thu, 17 Oct 2019 18:19:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1902DA808; Thu, 17 Oct 2019 20:19:20 +0200 (CEST)
Date:   Thu, 17 Oct 2019 20:19:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/15] Remove callback indirections in compression code
Message-ID: <20191017181919.GO2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 14, 2019 at 02:22:21PM +0200, David Sterba wrote:
> The series removes all per-compression algorithm callbacks and replaces
> them with a switches. Lots of indirections are simplified and while it
> looks nice from design POV, we don't need to over-engineer it as we have
> only fixed known number of the users and not public API.
> 
> The cost of indirect function calls is also higher with enabled
> mitigations of the spectre vulnerability, so they've been incrementally
> removed from the whole kernel and from btrfs as well.
> 
> David Sterba (15):
>   btrfs: export compression and decompression callbacks
>   btrfs: switch compression callbacks to direct calls
>   btrfs: compression: attach workspace manager to the ops
>   btrfs: compression: let workspace manager init take only the type
>   btrfs: compression: inline init_workspace_manager
>   btrfs: compression: let workspace manager cleanup take only the type
>   btrfs: compression: inline cleanup_workspace_manager
>   btrfs: compression: export alloc/free/get/put callbacks of all algos
>   btrfs: compression: inline get_workspace
>   btrfs: compression: inline put_workspace
>   btrfs: compression: pass type to btrfs_get_workspace
>   btrfs: compression: inline alloc_workspace
>   btrfs: compression: pass type to btrfs_put_workspace
>   btrfs: compression: inline free_workspace
>   btrfs: compression: remove ops pointer from workspace_manager

Added to misc-next.
