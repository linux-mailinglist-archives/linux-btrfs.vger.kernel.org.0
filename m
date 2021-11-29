Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3919461C4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 17:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347839AbhK2RBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 12:01:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54478 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbhK2Q7n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 11:59:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C97E21FCA1;
        Mon, 29 Nov 2021 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638204984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q01rjQmKFRwTQbrR6fyH8ITOs/AVEUDJnN/TZDaiaak=;
        b=yPLcoU0R9wTS+MwzckYroa7MPCyUz3gerloVted8OH4em8sgLQlcKpBVhJC327Vb6ydT6N
        Q0EzWfFA8GLK0Sy6V43gfxl/tz81gxPxU+mQQKyIQ+WlWSikaWykHGJpV9PmrBF6GcllaA
        nSRXEl1lglIHqVz5HSWQqfi14yEOfQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638204984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q01rjQmKFRwTQbrR6fyH8ITOs/AVEUDJnN/TZDaiaak=;
        b=ztibUgaAyys5Bv1+KZPfHGz/VeV0sjPdmxq/F/dPeFzaUYSbrSPUYVbMHT9qLwcg+hLY6n
        pbY9Uc/7YYZxTDDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0FF1A3B84;
        Mon, 29 Nov 2021 16:56:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A178DA735; Mon, 29 Nov 2021 17:56:14 +0100 (CET)
Date:   Mon, 29 Nov 2021 17:56:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 0/3] Metadata IO error fixes
Message-ID: <20211129165614.GF28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1637781110.git.josef@toxicpanda.com>
 <68f6c31a-72a7-726a-4eba-eb1fa5395278@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68f6c31a-72a7-726a-4eba-eb1fa5395278@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 25, 2021 at 11:12:53AM +0200, Nikolay Borisov wrote:
> 
> 
> On 24.11.21 г. 21:14, Josef Bacik wrote:
> > v1->v2:
> > - I was debugging generic/484 separately because I thought it was data related,
> >   but it turned out to be metadata related as well, so I've added the patch
> >   "btrfs: call mapping_set_error() on btree inode with a write error" to the
> >   series.
> > 
> > --- Original email ---
> > 
> > Hello,
> > 
> > I saw a dmesg failure with generic/281 on our overnight runs.  This turned out
> > to be because we weren't getting an error back from btrfs_search_slot() even
> > though we found a metadata block that shouldn't have been uptodate.
> > 
> > The root cause is that write errors on the page clear uptodate on the page, but
> > not on the extent buffer itself.  Since we rely on that bit to tell wether the
> > extent buffer is valid or not we don't notice that the eb is bogus when we find
> > it in cache in a subsequent write, and eventually trip over
> > assert_eb_page_uptodate() warnings.
> > 
> > This fixes the problem I was seeing, I could easily reproduce by running
> > generic/281 in a loop a few times.  With these pages I haven't reproduced in 20
> > loops.  Thanks,
> > 
> > Josef
> > 
> > Josef Bacik (3):
> >   btrfs: clear extent buffer uptodate when we fail to write it
> >   btrfs: check the root node for uptodate before returning it
> >   btrfs: call mapping_set_error() on btree inode with a write error
> > 
> >  fs/btrfs/ctree.c     | 19 +++++++++++++++----
> >  fs/btrfs/extent_io.c | 14 ++++++++++++++
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> > 
> 
> 
> This is stable material as well, right?

Yes, tags added.
