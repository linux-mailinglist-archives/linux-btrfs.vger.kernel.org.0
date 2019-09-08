Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD11ACBDC
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2019 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfIHJsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 05:48:09 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:39744 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfIHJsJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Sep 2019 05:48:09 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 90D4B416A139;
        Sun,  8 Sep 2019 11:48:07 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 4EC11F015AB;
        Sun,  8 Sep 2019 11:48:07 +0200 (CEST)
Subject: Re: Balance conversion to metadata RAID1, data RAID1 leaves some
 metadata as DUP
To:     Pete <pete@petezilla.co.uk>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <eda2fb2a-c657-5e4a-8d08-1bf57b57dd3b@petezilla.co.uk>
 <94bca1e6-6b6a-10fb-9e44-ae9a2202187d@applied-asynchrony.com>
 <c00a206b-ac20-9312-498f-6fbf1ffd1295@petezilla.co.uk>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <05971f6b-4b4f-c20b-2a1d-fb61a200a16b@applied-asynchrony.com>
Date:   Sun, 8 Sep 2019 11:48:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c00a206b-ac20-9312-498f-6fbf1ffd1295@petezilla.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/8/19 11:18 AM, Pete wrote:
> On 9/8/19 8:57 AM, Holger Hoffstätte wrote:
>> On 9/8/19 9:09 AM, Pete wrote:
>> (snip)
>>> I presume running another balance will fix this, but surely all metadata
>>> should have been converted?  Is there a way to only balance the DUP
>>> metadata?
>>
>> Adding "soft" to -mconvert should do exactly that; it will then skip
>> any chunks that are already in the target profile.
>>
>> -h
> 
> Appreciated.  Fixed it, very rapidly, with:
> 
> btrfs bal start -mconvert=raid1,soft  /home_data
> 
> I think a few examples on the wiki page would be helpful.  As I don't do
> this sort of maintenance every day I looked at the filter section on the
> wiki / man pages online following your prompting and was adding
> 'type=soft' in various places with no success and it was about the 3rd
> reading of the relevant area where I cam up with the above which worked.

IMHO 'soft' should just be the implicit default behaviour for convert,
since it almost always does what one would expect when converting.
I can't think of a good reason why it shouldn't be, but maybe there is
one - Dave?

-h
