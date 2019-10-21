Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E46DEC3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfJUMaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 08:30:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:44530 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728625AbfJUMaj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 08:30:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF32CADCF;
        Mon, 21 Oct 2019 12:30:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD8FDDA8C5; Mon, 21 Oct 2019 14:30:50 +0200 (CEST)
Date:   Mon, 21 Oct 2019 14:30:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Merlin =?iso-8859-1?Q?B=FCge?= <merlin.buege@tuhh.de>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs-progs: small fixes/cleanup in Documentation
Message-ID: <20191021123050.GF3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Merlin =?iso-8859-1?Q?B=FCge?= <merlin.buege@tuhh.de>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20191017045006.130378-1-merlin.buege@tuhh.de>
 <20191018161433.148176-1-merlin.buege@tuhh.de>
 <20191018182331.1786ee9f.merlin.buege@tuhh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018182331.1786ee9f.merlin.buege@tuhh.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 18, 2019 at 06:23:31PM +0200, Merlin Büge wrote:
> 
> 
> On Fri, 18 Oct 2019 18:14:33 +0200
> Merlin Büge <merlin.buege@tuhh.de> wrote:
> ...
> > diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
> > index 6a1a04b7..ee6010fe 100644
> > --- a/Documentation/btrfs-man5.asciidoc
> > +++ b/Documentation/btrfs-man5.asciidoc
> ...
> > @@ -659,7 +653,7 @@ swapfile extents or may fail:
> ...
> > -* device replace - dtto
> > +* device replace - ditto
> 
> I think I may have got that last one wrong, sorry.
> I've never seen it spelled 'dtto', but I now see further references e.g.
> here:
> https://github.com/kdave/btrfs-progs/blob/master/Makefile
> 
> So, feel free to pick v1/v2 which you find the most appropriate!

I've merged the patch as-is, thank. The 'ditto' spelling is probably
more widely used in english texts. 'dtto' is in sources and thus not
visible to wide audience so we can live with that.
