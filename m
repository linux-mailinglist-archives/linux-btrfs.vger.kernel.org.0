Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021AE11E64D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfLMPRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 10:17:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:60732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727642AbfLMPRL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 10:17:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A082ADEF;
        Fri, 13 Dec 2019 15:17:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ABF9ADA82A; Fri, 13 Dec 2019 16:17:08 +0100 (CET)
Date:   Fri, 13 Dec 2019 16:17:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: drop log root for dropped roots
Message-ID: <20191213151707.GX3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20191206143718.167998-1-josef@toxicpanda.com>
 <20191206143718.167998-2-josef@toxicpanda.com>
 <5e60e26f-8993-ca16-2a93-48d5948ed961@suse.com>
 <802950f7-b762-920b-7747-cfc18ff64e24@toxicpanda.com>
 <85a03cbb-d096-bfaf-b841-141d63a4f134@suse.com>
 <9392b4c1-4b7e-b5fb-dafe-0a1a45e0d319@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9392b4c1-4b7e-b5fb-dafe-0a1a45e0d319@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 04:28:17PM -0500, Josef Bacik wrote:
> >>>> If we fsync on a subvolume and create a log root for that volume, and
> >>>> then later delete that subvolume we'll never clean up its log root.  Fix
> >>>> this by making switch_commit_roots free the log for any dropped roots we
> >>>> encounter.
> >>>> +        btrfs_free_log(trans, root);
> >>>
> >>> THis patch should really have been this line and converting
> >>> switch_commit_roots to taking a trans handle another patch. Otherwise
> >>> this is lost in the mechanical refactoring.
> >>
> >> We need the trans handle to even call btrfs_free_log, we're just fixing
> >> it so the trans handle can be passed in, making its separate is just
> >> superfluous.  Thanks,
> > 
> > Actually no because callees handle the case when trans is not passed
> > (i.e. walk_log_tree and walk_(up|down)_log_tree. If passing valid
> > trances changes the call logic then this needs to be explained in the
> > changelog. And there is currently one caller calling that function
> > without a trans - btrfs_drop_and_free_fs_root in BTRFS_FS_STATE_ERROR case.
> 
> Yeah, it's clear that NULL is used only in the error case.  I'm not going to 
> explain the entirety of how the log tree works in a basic fix for not freeing up 
> a tree log when we should be doing it.  Thanks,

Sure you can at least note that the parameter type needs to be changed,
so we don't have to spend too much time looking for the real fix.
