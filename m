Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9B1E6BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 03:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEOBpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 21:45:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfEOBpM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 21:45:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 059BBAF4C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 01:45:11 +0000 (UTC)
Subject: Re: [PATCH 17/17] btrfs: add sha256 as another checksum algorithm
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-18-jthumshirn@suse.de>
 <e529d2ee-566c-d9f6-d7ed-77616fee2955@suse.com> <20190513071114.GC12653@x250>
 <20190513125437.GA20156@suse.cz>
From:   Jeff Mahoney <jeffm@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jeffm@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1ec5c34e-4119-5f63-5c9f-2b92b7239ead@suse.com>
Date:   Tue, 14 May 2019 21:45:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513125437.GA20156@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/13/19 8:54 AM, David Sterba wrote:
> On Mon, May 13, 2019 at 09:11:14AM +0200, Johannes Thumshirn wrote:
>> On Fri, May 10, 2019 at 03:30:36PM +0300, Nikolay Borisov wrote:
>> [...]
>>>
>>> nit: Might be a good idea to turn that into an enum for self-documenting
>>> purposes. Perhaps in a different patch.
>>
>> Thought about this as well, but I thought I remembered a patch series from
>> David where he turned everything not being an on-disk format to enums.
>>
>> This discuraged me from actually doing the switch. I'd be more than happy if I
>> could just use an enum.
> 
> Enum is fine, but named constants that are part of on-disk format should
> be spell the exact value, ie. not relying on the auto-increment of enum
> values.
> 

FWIW, enum values make it into the debuginfo, so we can see the values
as names when we load up a dump in a debugger.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
