Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5234F2DC545
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 18:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLPR0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 12:26:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:55272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgLPR0K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 12:26:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B1BDAE05;
        Wed, 16 Dec 2020 17:25:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1B4C4DA6E1; Wed, 16 Dec 2020 18:23:50 +0100 (CET)
Date:   Wed, 16 Dec 2020 18:23:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
Message-ID: <20201216172349.GJ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201211164812.459012-1-realwakka@gmail.com>
 <20201211164812.459012-2-realwakka@gmail.com>
 <20201211173025.GO6430@twin.jikos.cz>
 <20201211174629.GQ6430@twin.jikos.cz>
 <20201211180911.GB456927@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211180911.GB456927@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 06:09:11PM +0000, Sidong Yang wrote:
> On Fri, Dec 11, 2020 at 06:46:29PM +0100, David Sterba wrote:
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
> I've tested devel branch. but there is no extra comma and I also tested
> with jq you said. jq results no error. I think that It's just mistype in
> message.

That's strange because the formatter is buggy, eg. the simplest
fmt_start()/fmt_end() leads to

$ ./json-formatter-test
{
  "__header": {
    "version": "1"
  },
}
---

Which is of course invalid and jq confirms that.
