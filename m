Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B46E0499
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfJVNK2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 09:10:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387624AbfJVNK2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 09:10:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A55B1B2DE;
        Tue, 22 Oct 2019 13:10:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80D4ADA733; Tue, 22 Oct 2019 15:10:39 +0200 (CEST)
Date:   Tue, 22 Oct 2019 15:10:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/2] btrfs-progs: Setting implicit-fallthrough by default
Message-ID: <20191022131039.GX3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191022020228.14117-1-marcos.souza.org@gmail.com>
 <028a15c3-2395-34c5-f761-5782e851d933@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <028a15c3-2395-34c5-f761-5782e851d933@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 03:45:38PM +0300, Nikolay Borisov wrote:
> 
> 
> On 22.10.19 г. 5:02 ч., Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > While compiling btrfs-progs using clang I found an issue using
> > __attribute__(fallthrough), which does not seems to work in clang.
> > 
> > To solve this issue, the code was changed to use /* fallthrough */, which is the
> > same notation adopted by linux kernel.
> > 
> > Once these places were changed, -Wimplicit-fallthrough was set in Makefile, to
> > avoid further implicit-fallthrough cases being added in the future.
> > 
> > Marcos Paulo de Souza (2):
> >   btrfs-progs: utils: Replace __attribute__(fallthrough)
> >   btrfs-progs: Makefile: Add -Wimplicit-fallthrough
> > 
> >  Makefile       |  1 +
> >  common/utils.c | 12 ++++++------
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> > 
> 
> Overall the patch looks good, it just changes the fallthrough to the
> least common denominator which seems to be a simple comment. In clang 10
> the currently used attribute method is also going to be supported.
> 
> But we'll get most value if we just enable it now, so
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Agreed, I've added the note to the first patch. 1-2 in devel. Thanks.
