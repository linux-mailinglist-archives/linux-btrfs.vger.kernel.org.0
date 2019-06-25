Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52186556C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfFYSH3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 14:07:29 -0400
Received: from syrinx.knorrie.org ([82.94.188.77]:49440 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfFYSH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 14:07:29 -0400
Received: from [IPv6:2001:980:4a41:fb::12] (unknown [IPv6:2001:980:4a41:fb::12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 034A74A3E8B81;
        Tue, 25 Jun 2019 20:07:25 +0200 (CEST)
Subject: Re: RFC: btrfs-progs json formatting
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20190625160944.GP8917@twin.jikos.cz>
From:   Hans van Kranenburg <hans@knorrie.org>
Message-ID: <02db4af2-eb76-7319-8cab-d18d37c4db58@knorrie.org>
Date:   Tue, 25 Jun 2019 20:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625160944.GP8917@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 6/25/19 6:09 PM, David Sterba wrote:
> Hi,
> 
> I'd like to get some feedback on the json output, the overall structure
> of the information and naming.
> 
> Code: git://github.com/kdave/btrfs-progs.git preview-json
> 
> The one example command that supports it is
> 
>  $ ./btrfs --format json subvolume show /mnt

I think for deciding what the structure will look like, it's very
interesting to look at what tools, utils, use cases, etc.. will use this
and how. Taking the bike for a ride, instead of painting the shed.

E.g.
 - Does the user expect the same text as in a current btrfs sub list,
but while being able to quickly use specific fields instead of using awk
to split the current output? -> a field flags with contents like
"foo,bar" or "FOO|BAR" might be expected instead of an integer.
 - Does the user want to write another tool that actually
programmatically does more? In that case the user might prefer having
the number instead of the text of flags which needs to be parsed back again.

> The test tests/cli-tests/011-* can demonstrate the capabilities.  The
> json formatter and example use are in the top commits, otherwise the
> branch contains lot of unrelated changes.
> 
> Example output:
> 
> {
>   "__header": {
>     "version": "1"
>   },
>   "subvolume-show": {
>     "path": "subv2",
>     "name": "subv2",
>     "uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
>     "parent_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
>     "received_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
>     "otime": "2019-06-25 17:15:28 +0200",
>     "subvolume_id": "256",
>     "generation": "6",
>     "parent_id": "5",
>     "toplevel_id": "5",
>     "flags": "-",
>     "snapshots": [
>     ],
>     "quota-group": {
>       "qgroupid": "0/256",
>       "qgroup-limit-referenced": "-",
>       "qgroup-limit-exclusive": "-",
>       "qgroup-usage-referenced": "16.00KiB",
>       "qgroup-usage-exclusive": "16.00KiB"
>     }
>   }
> }
> 
> The current proposal:
> 
> - the toplevel group contains 2 maps, one is some generic header, to
>   identify version of the format or the version of progs that produces
>   it or whatever could be useful and I did not think of it
> 
> - the 2nd map is named according to the command that generated the
>   output, this is to be able to merge outputs from several commands, or
>   to somehow define the contents of the map

In what example use case would I be combining output of several commands?

> Compare that to a simple unnamed group with bunch of values:
> 
> {
>   "path": "subv2",
>   "name": "subv2",
>   "uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
>   "parent_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
>   "received_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
>   "otime": "2019-06-25 17:15:28 +0200",
>   "subvolume_id": "256",
>   "generation": "6",
>   "parent_id": "5",
>   "toplevel_id": "5",
>   "flags": "-",
>   "snapshots": [
>   ],
>   "quota-group": {
>     "qgroupid": "0/256",
>     "qgroup-limit-referenced": "-",
>     "qgroup-limit-exclusive": "-",
>     "qgroup-usage-referenced": "16.00KiB",
>     "qgroup-usage-exclusive": "16.00KiB"
>   }
> }
> 
> That's a bit shorter but makes validation harder. I assume that the
> output would be accessed programatically like (python pseudo-code)

What about having structures that are result-data-oriented instead of
command-oriented?

E.g. something that shows a subvol or lists them could have a bunch of
"subvolumes" in the result:

{
  "__header": {
    [...]
  },
  "subvolumes": {
    5: {
    }
    256: {
    },
    260: {
    },
    1337: {
    }
  }
}

Then subvol show 260 could return the same format, with just one of them:

{
  "__header": {
    [...]
  },
  "subvolumes": {
    260: {
    },
  }
}

Now I can also combine the result of a few targeted subvol show commands:

subvols = sub_show_260_json["subvolumes"]
subvols.update(sub_show_1337_json["subvolumes"])
list(subvols.keys())
 -> [260, 1337]

> ---
> rawjson = output_of_command("btrfs --format json subvolume show /mnt")
> json = Json.from_string(rawjson)
> 
> if json["subvolume-show"]["flags"] != "-":
>   print("Subvolume %s has flags", json["subvolume-show"]["name"])
> ---
> 
> so the latter is subset of the former, without one map reference.
> 
> Once the json format is settled, more commands can be easily converted.
> 

Just some random thoughts.

Hans
