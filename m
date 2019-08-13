Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12938B06C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 09:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfHMHD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 03:03:26 -0400
Received: from know-smtprelay-omd-11.server.virginmedia.net ([81.104.62.43]:42535
        "EHLO know-smtprelay-omd-11.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHMHDZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 03:03:25 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id xQq2hHLA9XaJRxQq3hSHYD; Tue, 13 Aug 2019 08:03:23 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=IZIzplia c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=nxt6yEdAfYn9l88bm4QA:9 a=QEXdDO2ut3YA:10
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
 <9240f2ad-905d-533a-8bb6-55af0aaafbb7@gmx.com>
 <0bc24d6e-2f3f-c0b8-dc0b-59b162653d3a@petezilla.co.uk>
 <cd48f1e8-8fef-9fca-5013-e80909c9801e@gmx.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <8a094eaf-bb2a-255c-59c5-bfd9ed0e64aa@petezilla.co.uk>
Date:   Tue, 13 Aug 2019 08:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cd48f1e8-8fef-9fca-5013-e80909c9801e@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLStWZf7nlaO4igIedNNWTeLX3TdKizgfEPk4bzMjvsUTVsQ39X3UooS9MDsz09J2MP6jky9urgtm+ohwK7hHoSOffvPfR0qKboxPaRr2WvVYziYM/g3
 2USf5MLagMHu0GAp8F4SF3lMy4Idp2ObcBW2GfQgyzDGVOZEgKoTzWYtjDi5gC7wub8LJ80mMt71HsUWotXlmgPBirrtOlAJ2hY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/12/19 1:21 AM, Qu Wenruo wrote:

> The offending inode item.
> 
>> 		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
>> 		sequence 0 flags 0x0(none)
>> 		atime 1395590849.0 (2014-03-23 16:07:29)
>> 		ctime 1395436187.0 (2014-03-21 21:09:47)
>> 		mtime 1395436187.0 (2014-03-21 21:09:47)
> 
> It's an old fs, maybe some older kernel caused such strange behavior.
> 

Whilst tidying up the system I did find some modules from a 3.* series
kernel.


> So the workaround won't work until you delete all those 2014 files.

I left it running to do that.

> 
> I'd recommend to copy the data to a new btrfs using 5.1 kernel.
>

OK.  Its due an update shortly anyway.  Perhaps I'll treat it to a SSD,
as it will make updates quicker.

> Thanks,
> Qu

Thank you.



