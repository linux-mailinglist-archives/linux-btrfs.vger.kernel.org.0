Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577A59D48C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfHZQ4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 12:56:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729335AbfHZQ4m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 12:56:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFAB3AD18;
        Mon, 26 Aug 2019 16:56:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 84918DA98E; Mon, 26 Aug 2019 18:57:04 +0200 (CEST)
Date:   Mon, 26 Aug 2019 18:57:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     dsterba@suse.cz, Vladimir Panteleev <git@panteleev.md>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: balance: check for full-balance before
 background fork
Message-ID: <20190826165704.GY2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Vladimir Panteleev <thecybershadow@gmail.com>,
        Vladimir Panteleev <git@panteleev.md>, linux-btrfs@vger.kernel.org
References: <20190817231434.1034-1-git@vladimir.panteleev.md>
 <20190820143258.GS24086@twin.jikos.cz>
 <447e353b-a2c8-efbe-bead-5d27656cba8d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447e353b-a2c8-efbe-bead-5d27656cba8d@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 20, 2019 at 02:46:49PM +0000, Vladimir Panteleev wrote:
> Hi David,
> 
> On 20/08/2019 14.32, David Sterba wrote:
> > On Sat, Aug 17, 2019 at 11:14:34PM +0000, Vladimir Panteleev wrote:
> >> - Don't use grep -q, as it causes a SIGPIPE during the countdown, and
> >>    the balance thus doesn't start.
> >>
> > This needs -q, otherwise the text appears in the output of make. Fixed.
> 
> What of the SIGPIPE problem mentioned in the commit message?
> 
> If using -q is preferred despite of that, then probably the note about 
> it should be removed from the commit message, and the "cancel" 
> afterwards should probably be removed as well (along with its note in 
> the commit message too), as the SIGPIPE will prevent the balance from 
> ever starting.
> 
> Perhaps redirecting the output of grep to /dev/null is a better option.

Agreed, I've updated the patch to remove -q and add the redirection.

>  > Applied, thanks.
> 
> Not a big issue but for some reason my email address was mangled 
> (@panteleev.md instead of @vladimir.panteleev.md). Looks fine when I 
> look at https://patchwork.kernel.org/patch/11099359/mbox/.

Hm, strange. I'll fix the patches from you so they match your
expectations. The mangled domain name does not appear anywhere in the
mail headers, I wonder what's going on here.
