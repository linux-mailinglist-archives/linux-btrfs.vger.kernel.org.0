Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A541A4889
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDJQds (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 12:33:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:53224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJQds (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 12:33:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DCEDAB64;
        Fri, 10 Apr 2020 16:33:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52844DA72D; Fri, 10 Apr 2020 18:33:10 +0200 (CEST)
Date:   Fri, 10 Apr 2020 18:33:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: Use list_for_each_entry_safe in
 free_reloc_roots
Message-ID: <20200410163310.GO5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200221131124.24105-1-nborisov@suse.com>
 <20200221131124.24105-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221131124.24105-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 03:11:24PM +0200, Nikolay Borisov wrote:
> The function always works on a local copy of the reloc root list, which
> cannot be modified outside of it so using list_for_each_entry is fine.
> Additionally the macro handles empty lists so drop list_empty checks of
> callers. No semantic changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

This is still relevant for misc-next, so I'm applying it to misc-next.
