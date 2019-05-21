Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C425889
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfEUT7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 21 May 2019 15:59:54 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:57996 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfEUT7x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 15:59:53 -0400
Received: from lass-mb.fritz.box (aftr-95-222-30-100.unity-media.net [95.222.30.100])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id 253CB20BA8;
        Tue, 21 May 2019 21:59:51 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [dm-devel] fstrim discarding too many or wrong blocks on Linux
 5.1, leading to data loss
From:   =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
In-Reply-To: <20190521190023.GA68070@glet>
Date:   Tue, 21 May 2019 21:59:50 +0200
Cc:     dm-devel@redhat.com, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6E217E83-E4FB-489F-BF23-1EA71E20C939@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
 <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net>
 <3142764D-5944-4004-BC57-C89C89AC9ED9@bi-co.net>
 <F170BB63-D9D7-4D08-9097-3C18815BE869@bi-co.net>
 <20190521190023.GA68070@glet>
To:     Andrea Gelmini <andrea.gelmini@linux.it>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Am 21.05.2019 um 21:00 schrieb Andrea Gelmini <andrea.gelmini@linux.it>:
> 
> On Tue, May 21, 2019 at 06:46:20PM +0200, Michael Laß wrote:
>>> I finished bisecting. Here’s the responsible commit:
>>> 
>>> commit 61697a6abd24acba941359c6268a94f4afe4a53d
>>> Author: Mike Snitzer <snitzer@redhat.com>
>>> Date:   Fri Jan 18 14:19:26 2019 -0500
>>> 
>>>   dm: eliminate 'split_discard_bios' flag from DM target interface
>>> 
>>>   There is no need to have DM core split discards on behalf of a DM target
>>>   now that blk_queue_split() handles splitting discards based on the
>>>   queue_limits.  A DM target just needs to set max_discard_sectors,
>>>   discard_granularity, etc, in queue_limits.
>>> 
>>>   Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>> 
>> Reverting that commit solves the issue for me on Linux 5.1.3. Would that be an option until the root cause has been identified? I’d rather not let more people run into this issue.
> 
> Thanks a lot Michael, for your time/work.
> 
> This kind of bisecting are very boring and time consuming.

I just sent a patch to dm-devel which fixes the issue for me. Maybe you can test that in your environment?

Cheers,
Michael

PS: Sorry if the patch was sent multiple times. I had some issues with git send-email.

> I CC: also the patch author.
> 
> Thanks again,
> Andrea

