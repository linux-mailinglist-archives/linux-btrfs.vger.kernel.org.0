Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE65321E66
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 18:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhBVRnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 12:43:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:44798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhBVRnA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 12:43:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7025AC69;
        Mon, 22 Feb 2021 17:42:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9B3BDA7FF; Mon, 22 Feb 2021 18:40:18 +0100 (CET)
Date:   Mon, 22 Feb 2021 18:40:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] btrfs: ref-verify: use 'inline void' keyword ordering
Message-ID: <20210222174018.GS1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210219065417.1834-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210219065417.1834-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 18, 2021 at 10:54:17PM -0800, Randy Dunlap wrote:
> Fix build warnings of function signature when CONFIG_STACKTRACE is not
> enabled by reordering the 'inline' and 'void' keywords.
> 
> ../fs/btrfs/ref-verify.c:221:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>  static void inline __save_stack_trace(struct ref_action *ra)
> ../fs/btrfs/ref-verify.c:225:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>  static void inline __print_stack_trace(struct btrfs_fs_info *fs_info,
> 
> Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>

Added to misc-next thanks.
