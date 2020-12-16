Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F0B2DC540
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 18:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgLPRXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 12:23:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:52770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgLPRXo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 12:23:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11CC2AC7B;
        Wed, 16 Dec 2020 17:23:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87278DA6E1; Wed, 16 Dec 2020 18:21:23 +0100 (CET)
Date:   Wed, 16 Dec 2020 18:21:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <damenly.su@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
Message-ID: <20201216172123.GI6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <damenly.su@gmail.com>,
        Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20201211164812.459012-1-realwakka@gmail.com>
 <20201211164812.459012-2-realwakka@gmail.com>
 <20201211173025.GO6430@twin.jikos.cz>
 <20201211174629.GQ6430@twin.jikos.cz>
 <CABnRu57w3aw=jPBbpSNYfyRKxs1z7onwWzqjg+=r6jQjwNYUXw@mail.gmail.com>
 <20201216105203.GA14127@realwakka>
 <CABnRu55J04cu2sbc_f4gR_bOw3_sSMvu1Bs-sGyFhJ=cCRdMuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABnRu55J04cu2sbc_f4gR_bOw3_sSMvu1Bs-sGyFhJ=cCRdMuA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 08:52:08PM +0800, Su Yue wrote:
> > > The new line made filter produce the '+1'.
> >
> > Thanks for testing this patch.
> > I checked the fmt_end() and there is an additional newline.
> > I think that fmt_end() should be used for formatting. so it seems that
> 
> Yes, it's for the purpose of formatting.
> 
> > the only way to fix this problem is to remove the code that inserts a
> > newline in fmt_end(). I searched the code that use the function and
> > there is no code that used this function but this patch. Do you have any
> > ideas?
> >
> I'm OK about removing the "putchar('\n');". It's just a tiny format issue so no
> bother to do extra works.

The way the json formatting works the newline must be printed from
there. The problematic requirement is delayed insertion of the "," when
there are more objects on the same level. But we don't know that until
the next object is processed.

Mixing the textual and json output for the stats makes it a bit more
complicated as it prints the newline for each row unconditionally,
breaking the assumption of the formatter.
