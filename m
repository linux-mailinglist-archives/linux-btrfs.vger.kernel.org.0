Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6225548D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 08:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgH1Gef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 02:34:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:48496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1Gee (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 02:34:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9495ACF3;
        Fri, 28 Aug 2020 06:35:04 +0000 (UTC)
Subject: Re: BUG at fs/btrfs/relocation.c:794! Still happening on misc-next
 and 5.8.3
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
References: <20200630221006.17585-1-dsterba@suse.com>
 <20200723215641.GE5890@hungrycats.org>
 <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
 <20200804161626.GN5890@hungrycats.org> <20200828000313.GS5890@hungrycats.org>
 <20200828000822.GT5890@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <720f3ac7-6af5-e171-5947-ed0240d5f5e5@suse.com>
Date:   Fri, 28 Aug 2020 09:34:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828000822.GT5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.08.20 г. 3:08 ч., Zygo Blaxell wrote:
> On Thu, Aug 27, 2020 at 08:03:13PM -0400, Zygo Blaxell wrote:
>> On Tue, Aug 04, 2020 at 12:16:26PM -0400, Zygo Blaxell wrote:

<snip>

>>
>> 	Aug 23 05:04:05 regress kernel: [53458.128928][ T9737] BTRFS info (device dm-0): relocating block group 14939862335488 flags metadata|raid1
>> 	Aug 23 05:04:05 regress kernel: [53458.999342][ T9737] ------------[ cut here ]------------
>> 	Aug 23 05:04:05 regress kernel: [53459.000275][ T9737] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> 	Aug 24 01:23:52 regress kernel: [58662.545914][T17474] BTRFS info (device dm-0): relocating block group 15083978620928 flags metadata|raid1
>> 	Aug 24 01:23:54 regress kernel: [58664.778274][T17474] ------------[ cut here ]------------
>> 	Aug 24 01:23:54 regress kernel: [58664.782182][T17474] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> 	Aug 24 07:17:07 regress kernel: [21068.421134][T29457] BTRFS info (device dm-0): relocating block group 15160784715776 flags metadata|raid1
>> 	Aug 24 07:17:08 regress kernel: [21069.307661][ T5176] ------------[ cut here ]------------
>> 	Aug 24 07:17:08 regress kernel: [21069.309195][ T5176] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> 	Aug 25 18:58:26 regress kernel: [22013.457555][ T2164] BTRFS info (device dm-0): relocating block group 15530051239936 flags metadata|raid1
>> 	Aug 25 18:58:27 regress kernel: [22014.460689][ T4939] ------------[ cut here ]------------
>> 	Aug 25 18:58:27 regress kernel: [22014.461653][ T4939] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> 	Aug 26 03:39:20 regress kernel: [31172.016638][T30882] BTRFS info (device dm-0): relocating block group 15576759009280 flags metadata|raid1
>> 	Aug 26 03:39:21 regress kernel: [31173.329719][T12663] ------------[ cut here ]------------
>> 	Aug 26 03:39:21 regress kernel: [31173.330682][T12663] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> 	Aug 26 16:00:02 regress kernel: [44334.231395][T25917] BTRFS info (device dm-0): relocating block group 15631888941056 flags data
>> 	Aug 26 16:00:04 regress kernel: [44336.800710][T26519] ------------[ cut here ]------------
>> 	Aug 26 16:00:04 regress kernel: [44336.802888][T26519] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> 	Aug 27 15:45:29 regress kernel: [55423.626717][ T5878] BTRFS info (device dm-0): relocating block group 15820229967872 flags metadata|raid1
>> 	Aug 27 15:45:29 regress kernel: [55423.798584][T15744] ------------[ cut here ]------------
>> 	Aug 27 15:45:29 regress kernel: [55423.802581][T15744] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> 	Aug 27 17:35:26 regress kernel: [ 6459.129124][T21053] BTRFS info (device dm-0): relocating block group 15831168712704 flags metadata|raid1
>> 	Aug 27 17:35:43 regress kernel: [ 6475.931029][T25720] ------------[ cut here ]------------
>> 	Aug 27 17:35:43 regress kernel: [ 6475.932403][T25720] kernel BUG at fs/btrfs/relocation.c:794!
>>
>> There don't seem to be any instances of the BUG that did not occur
>> within 30 seconds of starting a balance.
>>
>> The on-disk data is fine.  After a reboot the same block group can be
>> successfully balanced.
> 
> Forgot to mention the failure rate:  8 crashes (listed above) among 1492
> block groups balanced over the same 4-day period.

Since you can repro reliably could you modify the code in
create_reloc_root so it prints what's the returned error value, I'd
speculate it's EEXIST from

btrfs_insert_root
  btrfs_insert_item
   btrfs_insert_empty_item
     btrfs_insert_empty_items
       btrfs_search_slot

But better be sure.

> 
