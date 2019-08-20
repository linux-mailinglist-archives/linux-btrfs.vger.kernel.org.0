Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5457896C86
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfHTWrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 18:47:01 -0400
Received: from phi.wiserhosting.co.uk ([77.245.66.218]:35308 "EHLO
        phi.wiserhosting.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbfHTWrB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 18:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yDl2QElw7x/kGYV46vdUu3PM89AaTPuRDEgnGpC4y4k=; b=Vu5+2EIseHZ31G4epZz1H3waLb
        AAF/cU4blnxOdkQ+wkS7zAqtY8aordDnnwoO1YklMY2tjz0uRx0NB1UqShwWy72/iP9Ik8zBFC4EW
        XBgsjpmbbHCk1zrMpqKbFHbPY6xTVIaJ4XwJ75VtwEUdouvgyXXVc9VoHaX7sPpD6iJBLk4RKmV4g
        1jTUP/9IKiNVJz3HpGFMqtgdaBc4gw6+SGEPmpJDnCCaW621e/gVE/faC7T1aDGcPTtY1qn3c5HpM
        1ynotuhQGVdooMN3/xC4ENTet6MAfbiZnlc0rj9UVssKPZZq57Of3XoDv+/F/ijModRElXre079Dr
        0h+FPNXA==;
Received: from cpc75874-ando7-2-0-cust841.15-1.cable.virginm.net ([86.12.75.74]:57800 helo=[172.16.100.107])
        by phi.wiserhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <pete@petezilla.co.uk>)
        id 1i0Cu2-008DbI-7D; Tue, 20 Aug 2019 23:46:59 +0100
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
From:   Peter Chant <pete@petezilla.co.uk>
Message-ID: <1359d6d8-38a4-14d4-ddb1-1de64cd29c19@petezilla.co.uk>
Date:   Wed, 21 Aug 2019 00:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - phi.wiserhosting.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - petezilla.co.uk
X-Get-Message-Sender-Via: phi.wiserhosting.co.uk: authenticated_id: pete@petezilla.co.uk
X-Authenticated-Sender: phi.wiserhosting.co.uk: pete@petezilla.co.uk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/20/19 10:59 PM, Chris Murphy wrote:
> On Tue, Aug 20, 2019 at 3:10 PM Peter Chant <pete@petezilla.co.uk> wrote:
>>
>> Chasing IO errors.  BTRFS: error (device dm-2) in
>> btrfs_run_delayed_refs:2907: errno=-5 IO failure
>>
>>
>> I've just had an odd one.
>>
>> Over the last few days I've noticed a file system blocking, if that is
>> the correct term, and this morning go read only.  This resulted in a lot
>> of checksum errors.
> 
> That doesn't sound good. Checksum errors where? A complete start to
> finish dmesg is most useful in this case.
> 

I've just booted, degraded, and the file system went readonly quickly.
Is it good to post the dmesg to here, it is 1341 lines?  I can do it
with all disks if that helps?  (or I could run it through grep, but I
suspect there is good reason for not doing that.)

I'll look at the sysrq stuff, but I'm not likely to hit that right this
moment as the system is not really usable in this state and I'm assuming
I'll do more harm than good soldiering on.

Can't do anything with the systemd stuff as I'm running slackware which
does not use it.

Also, this is really bad timing, so although I can do stuff with the
system for the next day or two I'll need to step away from it for a
short while.

Thank you,

Pete
