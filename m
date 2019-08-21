Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B652C97FAE
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfHUQHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 12:07:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbfHUQHi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 12:07:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D859ADE6;
        Wed, 21 Aug 2019 16:07:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B922DA7DB; Wed, 21 Aug 2019 18:08:03 +0200 (CEST)
Date:   Wed, 21 Aug 2019 18:08:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Vladimir Panteleev <git@thecybershadow.net>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] btrfs: Simplify parsing max_inline mount option
Message-ID: <20190821160803.GD2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Vladimir Panteleev <git@thecybershadow.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20190815020453.25150-1-git@thecybershadow.net>
 <20190815020453.25150-2-git@thecybershadow.net>
 <20190821143526.GJ18575@twin.jikos.cz>
 <CAHhfkvw47KtGgFRbqRQriPe6C-qaFDVZPDZhZNafdA8QdKGKjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhfkvw47KtGgFRbqRQriPe6C-qaFDVZPDZhZNafdA8QdKGKjA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 03:16:11PM +0000, Vladimir Panteleev wrote:
> On Wed, 21 Aug 2019 at 14:35, David Sterba <dsterba@suse.cz> wrote:
> > match_strdup takes an opaque type
> > substring_t that is used by the parser.
> 
> Sorry, how would one determine that the type is opaque?

It's a typedef, which is kind of indication "don't look inside" as the
kernel coding does not normally use typedefs.

> > I've checked some other
> > usages in the tree and the match_strdup/memparse/kstrtoull is quite
> > common.
> 
> Sorry, I also see there are places where substring_t's .from / .to are
> still accessed directly (including in btrfs code). Do you think they
> ought to use match_strdup instead?

You're right, the compression option parsing references ::from heavily.
So for temporary use it would be ok to avoid the allocation, which means
match_strdup would be used only in btrfs_parse_subvol_options.
