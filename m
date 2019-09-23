Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8413BB774
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfIWPFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 11:05:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:41410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfIWPFI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 11:05:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0311AC26;
        Mon, 23 Sep 2019 15:05:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E2821DA871; Mon, 23 Sep 2019 17:05:27 +0200 (CEST)
Date:   Mon, 23 Sep 2019 17:05:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, kernel-team@fb.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: extent_io read eb to dirty_metadata_bytes on ioerr
Message-ID: <20190923150527.GC2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        kernel-team@fb.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190913135407.99353-1-dennis@kernel.org>
 <CAL3q7H5GzhL9CG-zTPK_iVFvp4qThmQS82HaaX7KrOwP12YJHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5GzhL9CG-zTPK_iVFvp4qThmQS82HaaX7KrOwP12YJHQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 13, 2019 at 04:46:09PM +0100, Filipe Manana wrote:
> On Fri, Sep 13, 2019 at 2:54 PM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > Before, if a eb failed to write out, we would end up triggering a
> > BUG_ON(). As of f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in
> > flush_write_bio() one level up"), we no longer BUG_ON(), so we should
> > make life consistent and add back the unwritten bytes to
> > dirty_metadata_bytes.
> >
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > Cc: Filipe Manana <fdmanana@kernel.org>
> 
> Looks good.
> However I find the subject very confusing and misleading.
> 
> "extent_io read eb to dirty_metadata_bytes on ioerr"
> 
> That gives the idea of reading the eb (like from disk? or its content,
> reading from its pages?), and the "to dirty_metadata_bytes" also find
> it confusing.
> Something like:
> 
>  "btrfs: adjust dirty_metadata_bytes after writeback failure of extent buffer"
> 
> would make it clear and not confusing IMHO.
> Perhaps it's something David can change when he picks the patch
> (either to that or some other more clear subject).

That's perfectly fine to suggest updates to subject or changelogs in
case you find them worth an improvement. Patch updated and queued for,
thanks.
