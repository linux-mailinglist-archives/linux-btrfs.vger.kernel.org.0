Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6622011C630
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 08:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfLLHMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 02:12:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41510 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfLLHMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 02:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576134735; x=1607670735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=leUUbHAm4yYX2Qfh1/6M9FqY2HWNEzTi7SfEf1o3LyA=;
  b=J7v3XRpDgwNYB/cEwgWNCPn7MWajIdRy3yYDEvRLC8T85Qx3+CyTCbTc
   Ru3BcE15afWpOlVILU3JydTPqTEvKehYgtj55EdeD7BmdtuKtWAhtDBjf
   OT6xIjnwi2JDtvk1N4u1kkPkcz+jvl+dda17kGoNvjb+pM2PCEodiU5DX
   QVD+9JP8Tv7LVvSSUZkrwDcmH188Vlhbhe8tqlRvjFGTnuGXHSKLxagtq
   hOOLpOY1aaGPIHNU2D72RF5rCshp0gJ7qw+adjM26MEDb4S38KWitaOj/
   n8iOW8agJzJDYoC/3GKuzbGz0wp5accn8/7hGAtFmfXK92hueo/0IlaRp
   w==;
IronPort-SDR: ey7nWG9TVq8DCL0bWwHD2RYj+tjH1DUFr2rzpsgLWKxOIOQxydJyrGYPYy9g4n10wQIY0C1n1a
 MtJ8aVCuGLPIAp8fYbTRCdCiniuNjtqkVc6nFLtkqXT1H1GR2zF7xRC6VgfN8vi+iDS0vcuyGM
 EMoGXmEEkIrELhuf+0w99FgetAnuYR2Otx+eH8KGk62PDeMnsZykfjVcHFae7FAT/5KfJ+afLa
 aLWbYe38hd3PZYdkSevWVinPFl2vLdkKuGAUO+irGIoWenjkHVs2MljkbSSY1H07fFkhtcoRIE
 j8g=
X-IronPort-AV: E=Sophos;i="5.69,305,1571673600"; 
   d="scan'208";a="126783051"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2019 15:12:15 +0800
IronPort-SDR: 1r4ugks7lkN1Cqo6LvOg3aZdMw2z8NCHNxi2H8KGcSpugeExQ0KNaDrNbU9pluTy8PdYhdRHBh
 4XWgiwWXqna3M7djmoFamXRWcKEGLes1A9Pt1Q/WO0xqtqT+0B3DsQh6H3ZbSTWHQVhIa97+8v
 1M9vzWrF6ozXxK9UzSo4CEIYTKADMDwLZ9Qmjqg2k82bNsaKr+9LzLae7qWIq5oznapYEUORIk
 Xc8X7XXvF91oLRgyrhDWeMg3hSrp1Edca+AofPSan9qUa+ulw5vNt+2t3Ov53fTTTrBmtuOpvc
 yEBN0ecmhj/gHkKKLIc4yRT3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 23:06:48 -0800
IronPort-SDR: OF1r0dehefcq21NzMspAjSpraevvTli+po/qJX+Os+2168ZN53SNh5S6bB51eaY1azo4e14s8N
 8JIa0MoEPO7YAD1FsPlkATVeO31nHLlmOiuUT9Dnc+/I1honpqKCAFIR1irR1J3Ki1WP7t9yLu
 IjF/Asiu1mSrmWIg3kak9MA6D+/HRuU6wo5nMuCTsuEC7exSbkeZFEQ3rxqQ+RP9orJzNffRJl
 y4Fat7McRzYXg9upyHUnev7TgrRPBFJflDyrwYKV/aL3EBDULJyiKnFlkfUCI0hDhCfSPXJmnS
 Qf8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 11 Dec 2019 23:12:14 -0800
Received: (nullmailer pid 2149980 invoked by uid 1000);
        Thu, 12 Dec 2019 07:12:12 -0000
Date:   Thu, 12 Dec 2019 16:12:12 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] fstests: btrfs/09[58]: Use hash to replace unreliable od
 output
Message-ID: <20191212071212.x2yypehczdkok5vr@naota.dhcp.fujisawa.hgst.com>
References: <20191212053034.21995-1-wqu@suse.com>
 <20191212053750.vxikimln5pjbaaot@naota.dhcp.fujisawa.hgst.com>
 <8a96e22e-fe5e-6432-0b5c-cab4ecf915c8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a96e22e-fe5e-6432-0b5c-cab4ecf915c8@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 01:54:43PM +0800, Qu Wenruo wrote:
>
>
>On 2019/12/12 下午1:37, Naohiro Aota wrote:
>> On Thu, Dec 12, 2019 at 01:30:34PM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> With latest master, btrfs/09[58] fails like:
>>>
>>>  btrfs/095 2s ... - output mismatch (see
>>> xfstests-dev/results//btrfs/095.out.bad)
>>>      --- tests/btrfs/095.out     2019-12-12 13:23:24.266697540 +0800
>>>      +++ xfstests-dev/results//btrfs/095.out.bad      2019-12-12
>>> 13:23:29.340030879 +0800
>>>      @@ -4,32 +4,32 @@
>>>       File contents before power failure:
>>>       0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>       *
>>>      -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>      +771 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>       *
>>>      -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>>      ...
>>>      (Run 'diff -u xfstests-dev/tests/btrfs/095.out
>>> xfstests-dev/results//btrfs/095.out.bad'  to see the entire diff)
>>>  btrfs/098 2s ... - output mismatch (see
>>> xfstests-dev/results//btrfs/098.out.bad)
>>>      --- tests/btrfs/098.out     2019-12-12 13:23:24.266697540 +0800
>>>      +++ xfstests-dev/results//btrfs/098.out.bad      2019-12-12
>>> 13:23:31.306697545 +0800
>>>      @@ -3,20 +3,20 @@
>>>       File contents before power failure:
>>>       0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>       *
>>>      -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>      +537 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>       *
>>>      -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>      ...
>>>      (Run 'diff -u xfstests-dev/tests/btrfs/098.out
>>> xfstests-dev/results//btrfs/098.out.bad'  to see the entire diff)
>>>  Ran: btrfs/095 btrfs/098
>>>  Failures: btrfs/095 btrfs/098
>>>  Failed 2 of 2 tests
>>>
>>> [CAUSE]
>>> It looks like commit 37520a314bd4 ("fstests: Don't use gawk's strtonum")
>>> is making _filter_od doing stupid filtering.
>>
>> I sent a fix to the list. That commit is parsing od's offsets as decimal
>> which actually is octal.
>>
>> https://lore.kernel.org/fstests/20191212031152.1906287-1-naohiro.aota@wdc.com/T/#u
>
>Oh, that's much better.
>
>Although that _filter_od still seems can't handle hex.

I agree with you that ocatal makes no sense these days. I'm considering to
extend _filter_od to take an argument to specify "oct|dec|hex" so that
callers can use "od -A x" and see outputs in hex (or decimal).

Thanks,
