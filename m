Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2500276085
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 10:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGZIPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 04:15:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11529 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfGZIPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 04:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564128920; x=1595664920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VkKIzJq+7U8jxmFSMc0E2oXrCb2hdYr8AaDhljLA4QI=;
  b=EKBg3foMd8yQ/daYSeID3B5YRFrDkUUEOJuD8QPlXU9YZQg8+hGza++e
   zhVCipO6pICUJIVwDKFyXL12yycATTvITpya3STCDCuX7KveASstHTHlr
   cbshtH9zT6u0zYzXfPoY5mfM/Zsh/5ickXpSnkkg/LZVZYF1xIs23tgVn
   rWy0tOKR+NhLBv1k7Hu9obnkzAUNFPnABvW87uojMrYzvy+SxtEaQozQc
   kE+3S5Ln0u1T6okcS3RhbEohKoiJRArmc/GDFh8KEwwHzKJlb71cRj7lT
   7x0+xM36ThfYKi5XuYt0aNqO2bc25Avebod+DqAqWLVFCbeYCFHOmVxMn
   g==;
IronPort-SDR: 10bZR+NoEGPdyWnkEIONXM+kCuJrFXf/2pAp7ehUiNHlUN89U6Cq4NyhrHyzqi6RvkoJL/e7tL
 bHgVuFesJAZJ5a64+oHkunNXP8dn1yxeVLEjwKfFRaXq1/wO/lk5ALaSViZ0YeQVrxyjmxwWIj
 hNJquri30lrgmXYQijCy215uTqiU1nlUxNvTzNJom3HydIoNWrANcB+RLPFlgRcp2UulrmhJhE
 C0omPI6xeXG9kddJ26goAF4FrKG8a9XxAFM1R2LcSa61C8X8Hl0gCHZutUf8qd1LYo3uPfNimc
 bYk=
X-IronPort-AV: E=Sophos;i="5.64,310,1559491200"; 
   d="scan'208";a="118889135"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 16:15:20 +0800
IronPort-SDR: 2e+EgDWxq8EqUY7K5svt/E1RcCx+YLE4A2x2UsRzSa2pKObVSIHJ/HJGwsHh2LRUpoowPskMYn
 PirEtaLefUiOG4v8ummlAl6pNyjJ8VysaiSaNhf4cQqyO2YWQIflc/Rv0+a34DYSc80QJA/H+R
 glRIspPbSvKEWHvf6PVdqqAnV+BVzpc3bDQMzDcGqGxR6t+1LCz597907yNmVVRgvl9avQRCns
 ppib+ftPRqY/fkXWE3bXkAlmjctT2swNdJqrruxNrwHa9R3NB5XDE+DC2ByYjdxH2l0xDrzHYj
 FctLre9cSVLZdWPQrptgF4CT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 01:13:29 -0700
IronPort-SDR: OCgvOK6qKbgd6PVS6MyE6ZgZlOTQsww/TXASZd1Dr1Xbis51aQwkbscoSoyz0l+rLI/4LAXgnm
 0vJdERRVCII/caB2xgalILMEqxyoMIJ93I3iKaaIhcO9Upo3Uuk3JBiciKSjIlsSSl0SNXEjJB
 rP5JY2w2p5cQXb3H/E/7nn95AR+lgQFFJg/5chVEAAxIPzMktzP7eI2mdKd++DhZVysA4Tz7HH
 lz0LmGlD57lm9DPRfwYr6X0qEkHNAxcEpqBOtk4e1zwvS6CWDmv9oeb5/G7kg6hU5hDQRZgEy9
 qsk=
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 26 Jul 2019 01:15:19 -0700
Received: (nullmailer pid 12698 invoked by uid 1000);
        Fri, 26 Jul 2019 08:15:18 -0000
Date:   Fri, 26 Jul 2019 17:15:18 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: fix extent buffer read/write range checks
Message-ID: <20190726081518.ilukyrpdsrioiq36@naota.dhcp.fujisawa.hgst.com>
References: <20190726052724.12338-1-naohiro.aota@wdc.com>
 <d81154a4-dd3f-481f-92cb-25ea32b55900@suse.com>
 <20190726061300.gvwypjd32elqtkhu@naota.dhcp.fujisawa.hgst.com>
 <71f0399e-0719-ca8c-cb7b-aba5de5d0c5a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71f0399e-0719-ca8c-cb7b-aba5de5d0c5a@gmx.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 02:36:10PM +0800, Qu Wenruo wrote:
>
>
>On 2019/7/26 下午2:13, Naohiro Aota wrote:
>> On Fri, Jul 26, 2019 at 08:38:27AM +0300, Nikolay Borisov wrote:
>>>
>>>
>>> On 26.07.19 г. 8:27 ч., Naohiro Aota wrote:
>>>> Several functions to read/write an extent buffer check if specified
>>>> offset
>>>> range resides in the size of the extent buffer. However, those checks
>>>> have
>>>> two problems:
>>>>
>>>> (1) they don't catch "start == eb->len" case.
>>>> (2) it checks offset in extent buffer against logical address using
>>>>     eb->start.
>>>>
>>>> Generally, eb->start is much larger than the offset, so the second
>>>> WARN_ON
>>>> was almost useless.
>>>>
>>>> Fix these problems in read_extent_buffer_to_user(),
>>>> {memcmp,write,memzero}_extent_buffer().
>>>>
>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>
>>> Qu already sent similar patch:
>>>
>>> [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer read
>>> write functions
>>>
>>>
>>> He centralised the checking code, your >= fixes though should be merged
>>> there.
>>
>> Oops, I missed that series. Thank you for pointing out. Then, this
>> should be merged into Qu's version.
>>
>> Qu, could you pick the change from "start > eb->len" to "start >= eb->len"?
>
> start >= eb->len is not always invalid.
>
> start == eb->len while len == 0 is still valid.

Correct.

But then, we can even say "start > eb->len" is valid if len == 0?

> Or should we also warn such bad practice?

Maybe...

Or how about let the callers bailing out by e.g. "if (!len) return 1;"
in the check function?

Regards,
Naohiro
