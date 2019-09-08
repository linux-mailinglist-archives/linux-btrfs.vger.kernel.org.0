Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3A4ACBC4
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2019 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfIHJTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 05:19:33 -0400
Received: from know-smtprelay-omd-6.server.virginmedia.net ([81.104.62.38]:33180
        "EHLO know-smtprelay-omd-6.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfIHJTd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Sep 2019 05:19:33 -0400
Received: from phoenix.exfire ([86.12.75.74])
        by cmsmtp with ESMTP
        id 6tM4ilRCuzHXx6tM4ixBqG; Sun, 08 Sep 2019 10:19:32 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: 
X-Spam: 0
X-Authority: v=2.3 cv=B9mXLtlM c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=J70Eh1EUuV4A:10 a=moJ9HeBjuReny5jBbMQA:9
 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by phoenix.exfire (8.15.2/8.15.2) with ESMTP id x889IaP0023143;
        Sun, 8 Sep 2019 10:18:37 +0100
Subject: Re: Balance conversion to metadata RAID1, data RAID1 leaves some
 metadata as DUP
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <eda2fb2a-c657-5e4a-8d08-1bf57b57dd3b@petezilla.co.uk>
 <94bca1e6-6b6a-10fb-9e44-ae9a2202187d@applied-asynchrony.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <c00a206b-ac20-9312-498f-6fbf1ffd1295@petezilla.co.uk>
Date:   Sun, 8 Sep 2019 10:18:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <94bca1e6-6b6a-10fb-9e44-ae9a2202187d@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfADsPFjFWVSwZUZz26yKW3OAhXHQPqiy7IcJTPUCPysoYYyor34UGoJubh4OfN7Db4XvoI0DGg4BSyO8iPd1GyeELWVVyvt6EMtMhPjXlaD18ztKcHAh
 czsTW/jnbfpv4dPQ0rjOAb9lblr2Z4XTXg1H+fdS16Ut/gSF4oQe6MntECvrEYJIo2AQioN6tTV8p0wZn9WN+YiY5o+XK6tgyP+8Pe6KdinzLQ498Z/O+U6l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/8/19 8:57 AM, Holger Hoffstätte wrote:
> On 9/8/19 9:09 AM, Pete wrote:
> (snip)
>> I presume running another balance will fix this, but surely all metadata
>> should have been converted?  Is there a way to only balance the DUP
>> metadata?
> 
> Adding "soft" to -mconvert should do exactly that; it will then skip
> any chunks that are already in the target profile.
> 
> -h

Appreciated.  Fixed it, very rapidly, with:

btrfs bal start -mconvert=raid1,soft  /home_data

I think a few examples on the wiki page would be helpful.  As I don't do
this sort of maintenance every day I looked at the filter section on the
wiki / man pages online following your prompting and was adding
'type=soft' in various places with no success and it was about the 3rd
reading of the relevant area where I cam up with the above which worked.

Pete

