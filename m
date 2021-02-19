Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9F31FE08
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 18:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBSRke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 12:40:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:49084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhBSRkc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 12:40:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D5B4ABAE;
        Fri, 19 Feb 2021 17:39:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8C9ADA875; Fri, 19 Feb 2021 18:37:53 +0100 (CET)
Date:   Fri, 19 Feb 2021 18:37:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Subject: Re: error in backport of 'btrfs: fix possible free space tree
 corruption with online conversion'
Message-ID: <20210219173753.GH1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
        Wang Yugui <wangyugui@e16-tech.com>, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
References: <20210219111741.95DD.409509F4@e16-tech.com>
 <d07905be-f714-3cbd-01c7-d348ea13c07e@applied-asynchrony.com>
 <20210219232049.554C.409509F4@e16-tech.com>
 <20814c8d-a54d-1b4b-cb28-b749afcf9f18@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20814c8d-a54d-1b4b-cb28-b749afcf9f18@applied-asynchrony.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 05:12:12PM +0100, Holger Hoffstätte wrote:
> On 2021-02-19 16:20, Wang Yugui wrote:
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -146,6 +146,9 @@ enum {
> >   	BTRFS_FS_STATE_DEV_REPLACING,
> >   	/* The btrfs_fs_info created for self-tests */
> >   	BTRFS_FS_STATE_DUMMY_FS_INFO,
> > +
> > +	/* Indicate that we can't trust the free space tree for caching yet */
> > +	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> >   };
> >   
> >   #define BTRFS_BACKREF_REV_MAX		256
> > 
> > Both the line(Line:146 vs Line:564) and the content are wrong.
> > 
> 
> Ahh..now I understand, indeed the merge of BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED went into
> the wrong enum. I misunderstood your original posting to mean that it had somehow missed
> a chunk or used the wrong enum value in set_bit.
> 
> Anyway, good catch! I guess Dave needs to decide how to fix this, maybe
> let Greg revert & re-apply properly.
> 
> Can anybody explain why git decided to do this?

Git finds that the patch does not apply and lets the user to fix it.

I did git cherry-pick of 2f96e40212d435b3284 on v5.10.12 and got 2
conflicts:

first was in caching_thread around

	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))

that got resolved correctly, and the second one in the enum, but the
conflict was suggested in the right enum (lines 559+), so all I had to
do was to remove unmatched context and the <<< >>> markers. It's
possible that git version could affect that, mine is 2.29.2. Or stable
team does not use git for the intermediate patches and quilt did not get
it right.

I doubt that the conflict resolution was done incorrectly by hand, the
enums are quite far away so it would not be just a trivial change (like
context fixups) that are in the scope of semi-automatic stable
backports.
