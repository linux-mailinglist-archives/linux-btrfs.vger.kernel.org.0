Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF0E2DC537
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgLPRVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 12:21:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:50808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbgLPRVJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 12:21:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEAD2AC7B;
        Wed, 16 Dec 2020 17:20:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E097DA6E1; Wed, 16 Dec 2020 18:18:48 +0100 (CET)
Date:   Wed, 16 Dec 2020 18:18:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <damenly.su@gmail.com>
Cc:     dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
Message-ID: <20201216171848.GH6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <damenly.su@gmail.com>,
        Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20201211164812.459012-1-realwakka@gmail.com>
 <20201211164812.459012-2-realwakka@gmail.com>
 <20201211173025.GO6430@twin.jikos.cz>
 <20201211174629.GQ6430@twin.jikos.cz>
 <CABnRu57w3aw=jPBbpSNYfyRKxs1z7onwWzqjg+=r6jQjwNYUXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABnRu57w3aw=jPBbpSNYfyRKxs1z7onwWzqjg+=r6jQjwNYUXw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 02:30:04PM +0800, Su Yue wrote:
> On Sat, Dec 12, 2020 at 3:04 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Fri, Dec 11, 2020 at 06:30:25PM +0100, David Sterba wrote:
> > > On Fri, Dec 11, 2020 at 04:48:12PM +0000, Sidong Yang wrote:
> > > > Example json format:
> > > >
> > > > {
> > > >   "__header": {
> > > >     "version": "1"
> > > >   },
> > > >   "device-stats": [
> > > >     {
> > > >       "device": "/dev/vdb",
> > > >       "devid": "1",
> > > >       "write_io_errs": "0",
> > > >       "read_io_errs": "0",
> > > >       "flush_io_errs": "0",
> > > >       "corruption_errs": "0",
> > > >       "generation_errs": "0"
> > > >     }
> > > >   ],
> > >      ^
> > >
> > > I've verified that the comma is really there, it's not a valid json so
> > > there's a bug in the formatter. To verify that the output is valid you
> > > can use eg. 'jq', simply pipe the output of the commadn there.
> > >
> > >   $ ./btrfs --format json dev stats /mnt | jq
> > >   parse error: Expected another key-value pair at line 16, column 1
> >
> > I've pushed the updated plain text formatting to devel, so the only
> > remaining bug is the above extra comma.
> 
> Another format bug(one extra newline):
> ========================================
> ➜  btrfs-progs git:(314d96c8)  btrfs device stats /mnt
> [/dev/mapper/test-1].write_io_errs    0
> [/dev/mapper/test-1].read_io_errs     0
> [/dev/mapper/test-1].flush_io_errs    0
> [/dev/mapper/test-1].corruption_errs  0
> [/dev/mapper/test-1].generation_errs  0
> 
> ➜  btrfs-progs git:(314d96c8)
> ========================================
> The new line is printed by the change:
> '+       fmt_end(&fctx);'
> 
> and fstests/btrfs/006 fails:
> ================================================================================
> btrfs/006 1s ... - output mismatch (see
> /root/xfstests-dev/results//btrfs/006.out.bad)
>     --- tests/btrfs/006.out     2020-12-16 03:40:19.632039261 +0000
>     +++ /root/xfstests-dev/results//btrfs/006.out.bad   2020-12-16
> 06:25:56.424424113 +0000
>     @@ -15,12 +15,14 @@
> 
>      == Sync filesystem
>      == Show device stats by mountpoint
>     + 1
>      <NUMDEVS> [SCRATCH_DEV].corruption_errs <NUM>
>      <NUMDEVS> [SCRATCH_DEV].flush_io_errs <NUM>
>      <NUMDEVS> [SCRATCH_DEV].generation_errs <NUM>
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/btrfs/006.out
> /root/xfstests-dev/results//btrfs/006.out.bad'  to see the entire
> diff)
> Ran: btrfs/006
> Failures: btrfs/006
> Failed 1 of 1 tests
> ================================================================================
> 
> The new line made filter produce the '+1'.

I noticed the newline but did not think it would break fstests, so it
needs to be removed.
