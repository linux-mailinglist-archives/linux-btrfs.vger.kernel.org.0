Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D249956F15
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFZQrF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 12:47:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfFZQrF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 12:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2938EADD5;
        Wed, 26 Jun 2019 16:47:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97258DA8F6; Wed, 26 Jun 2019 18:47:47 +0200 (CEST)
Date:   Wed, 26 Jun 2019 18:47:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: RFC: btrfs-progs json formatting
Message-ID: <20190626164747.GY8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org
References: <20190625160944.GP8917@twin.jikos.cz>
 <02db4af2-eb76-7319-8cab-d18d37c4db58@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02db4af2-eb76-7319-8cab-d18d37c4db58@knorrie.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 25, 2019 at 08:07:25PM +0200, Hans van Kranenburg wrote:
> Hi,
> 
> On 6/25/19 6:09 PM, David Sterba wrote:
> > Hi,
> > 
> > I'd like to get some feedback on the json output, the overall structure
> > of the information and naming.
> > 
> > Code: git://github.com/kdave/btrfs-progs.git preview-json
> > 
> > The one example command that supports it is
> > 
> >  $ ./btrfs --format json subvolume show /mnt
> 
> I think for deciding what the structure will look like, it's very
> interesting to look at what tools, utils, use cases, etc.. will use this
> and how. Taking the bike for a ride, instead of painting the shed.

Geez bike shedding mentioned in 2nd sentence?

> E.g.
>  - Does the user expect the same text as in a current btrfs sub list,
> but while being able to quickly use specific fields instead of using awk
> to split the current output? -> a field flags with contents like
> "foo,bar" or "FOO|BAR" might be expected instead of an integer.

The idea is that the default output is for humans, but if there's need
to parse the output, json is the format for that. Cutting out the
information using 'awk' is not expected here.

So the information provided by the text and json in a single command is
almost the same, with json some enhancements are possible to allow
linking to other commands, eg. not just the subvolume path but also the
id. Something that you suggested below.

>  - Does the user want to write another tool that actually
> programmatically does more? In that case the user might prefer having
> the number instead of the text of flags which needs to be parsed back again.

Ok, so bitfield values can be exported in two ways, one as a raw number
and one as the string.

> > The test tests/cli-tests/011-* can demonstrate the capabilities.  The
> > json formatter and example use are in the top commits, otherwise the
> > branch contains lot of unrelated changes.
> > 
> > Example output:
> > 
> > {
> >   "__header": {
> >     "version": "1"
> >   },
> >   "subvolume-show": {
> >     "path": "subv2",
> >     "name": "subv2",
> >     "uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
> >     "parent_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
> >     "received_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
> >     "otime": "2019-06-25 17:15:28 +0200",
> >     "subvolume_id": "256",
> >     "generation": "6",
> >     "parent_id": "5",
> >     "toplevel_id": "5",
> >     "flags": "-",
> >     "snapshots": [
> >     ],
> >     "quota-group": {
> >       "qgroupid": "0/256",
> >       "qgroup-limit-referenced": "-",
> >       "qgroup-limit-exclusive": "-",
> >       "qgroup-usage-referenced": "16.00KiB",
> >       "qgroup-usage-exclusive": "16.00KiB"
> >     }
> >   }
> > }
> > 
> > The current proposal:
> > 
> > - the toplevel group contains 2 maps, one is some generic header, to
> >   identify version of the format or the version of progs that produces
> >   it or whatever could be useful and I did not think of it
> > 
> > - the 2nd map is named according to the command that generated the
> >   output, this is to be able to merge outputs from several commands, or
> >   to somehow define the contents of the map
> 
> In what example use case would I be combining output of several commands?

Well, that's always an issue with usecases. I don't have immediate use
for that but as the format will be set to stone, additional flexibility
can pay off in the future.

The util-linux tools support json output and that's what I'm trying to
copy for sake of some consistency, as the 'btrfs' tool is sort of
low-level administration tool very close in purpose.

Check eg 'lsblk --json' or 'lscpu --json', that print "blockdevices" or
"lscpu" as the name of the map.

> > Compare that to a simple unnamed group with bunch of values:
> > 
> > {
> >   "path": "subv2",
> >   "name": "subv2",
> >   "uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
> >   "parent_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
> >   "received_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
> >   "otime": "2019-06-25 17:15:28 +0200",
> >   "subvolume_id": "256",
> >   "generation": "6",
> >   "parent_id": "5",
> >   "toplevel_id": "5",
> >   "flags": "-",
> >   "snapshots": [
> >   ],
> >   "quota-group": {
> >     "qgroupid": "0/256",
> >     "qgroup-limit-referenced": "-",
> >     "qgroup-limit-exclusive": "-",
> >     "qgroup-usage-referenced": "16.00KiB",
> >     "qgroup-usage-exclusive": "16.00KiB"
> >   }
> > }
> > 
> > That's a bit shorter but makes validation harder. I assume that the
> > output would be accessed programatically like (python pseudo-code)
> 
> What about having structures that are result-data-oriented instead of
> command-oriented?

The commands give different level of details and retrieving some of that
can take longer. Eg. the quota information query the tree for the
limits, so this might not be suitable for the 'list' command.

> E.g. something that shows a subvol or lists them could have a bunch of
> "subvolumes" in the result:
> 
> {
>   "__header": {
>     [...]
>   },
>   "subvolumes": {
>     5: {
>     }
>     256: {
>     },
>     260: {
>     },
>     1337: {
>     }
>   }
> }
> 
> Then subvol show 260 could return the same format, with just one of them:
> 
> {
>   "__header": {
>     [...]
>   },
>   "subvolumes": {
>     260: {
>     },
>   }
> }
> 
> Now I can also combine the result of a few targeted subvol show commands:
> 
> subvols = sub_show_260_json["subvolumes"]
> subvols.update(sub_show_1337_json["subvolumes"])
> list(subvols.keys())
>  -> [260, 1337]

I think I see what you mean, perhaps more commands need to be explored
to see if we can find some common structures to avoid the per-command
output. Something like lightweight-subvolume and full-details-subvolume,
with some way distinguish that programatically or just leave it to
try/catch.
