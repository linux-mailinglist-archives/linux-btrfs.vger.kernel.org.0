Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0675455FDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhKRPxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 10:53:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49176 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhKRPxn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 10:53:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2112F2177B;
        Thu, 18 Nov 2021 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637250642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SOH6b64f3mvz/cUl9Lt3RStR0g8Wok3zbS9/V6F1rkw=;
        b=VVeSmyNmJIz9jorssE9f5iYgVYihnnFa/u6Z5ws9+ldhvE/de/7HXtO1r+Ib5x0I3Fleju
        /20r7iuIAqJd4o8lqX+xQQfsRsER+ZQ5dBx2bQv6RYDIEQ1m4o7/dY6v3KhLgcqjHzXD2L
        k9GBoM123XkuG/V1JvCW9Bu+K2Ot8z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637250642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SOH6b64f3mvz/cUl9Lt3RStR0g8Wok3zbS9/V6F1rkw=;
        b=Bk/nHpUfsGvdFO2W1uJZP6getW9AhCd8TjiFlHju7UuN7bE/tYofhJswHxu6PGX1MnpCy5
        KojA8HGCG79GabAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16586A3B81;
        Thu, 18 Nov 2021 15:50:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 71E4FDA735; Thu, 18 Nov 2021 16:50:37 +0100 (CET)
Date:   Thu, 18 Nov 2021 16:50:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 14/17] btrfs: send: write larger chunks when using
 stream v2
Message-ID: <20211118155037.GH28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <051232485e4ac1a1a5fd35de7328208385c59f65.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051232485e4ac1a1a5fd35de7328208385c59f65.1637179348.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 12:19:24PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The length field of the send stream TLV header is 16 bits. This means
> that the maximum amount of data that can be sent for one write is 64k
> minus one. However, encoded writes must be able to send the maximum
> compressed extent (128k) in one command. To support this, send stream
> version 2 encodes the DATA attribute differently: it has no length
> field, and the length is implicitly up to the end of containing command
> (which has a 32-bit length field). Although this is necessary for
> encoded writes, normal writes can benefit from it, too.
> 
> Also add a check to enforce that the DATA attribute is last. It is only
> strictly necessary for v2, but we might as well make v1 consistent with
> it.
> 
> For v2, let's bump up the send buffer to the maximum compressed extent
> size plus 16k for the other metadata (144k total).

I'm not sure we want to set the number like that, it feels quite
limiting for potential compression enhancements.


> Since this will most
> likely be vmalloc'd (and always will be after the next commit), we round
> it up to the next page since we might as well use the rest of the page
> on systems with >16k pages.

Would it work also without the virtual mappings? For speedup it makes
sense to use vmalloc area, but as a fallback writing in smaller portions
or page by page eventually should be also possible. For that reason I
don't think we should set the maximum other than what fits to 32bit
number minus some overhead.
