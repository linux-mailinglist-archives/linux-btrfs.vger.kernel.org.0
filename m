Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9119FFA968
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 06:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfKMFPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 00:15:50 -0500
Received: from mail.rptsys.com ([23.155.224.45]:3831 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfKMFPu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 00:15:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 04D7FC3D19000;
        Tue, 12 Nov 2019 23:15:49 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id egSaQXypxiUr; Tue, 12 Nov 2019 23:15:47 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 79164C3D18DBB;
        Tue, 12 Nov 2019 23:15:47 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 79164C3D18DBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573622147; bh=fyCW/euF8jcmST/A0gcvWSoU6mCVf8ngKi7v47GXGCs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PqwmcykbnP4dMy6ya6temracoqGLbX6P2FLSZu30IB7T3JgMm8k9svyNm06w0MQoo
         w6eZ18gCldXJgqb0mC2eaY5CzMlt3qORkZBS3Qv7QlRKEXfo6JmqqCbUb9fyBdLvel
         50dASueWExkb3kKyrHHXLzIVvqF1AZgrqC+GOd34=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kZ8dijIrF_KA; Tue, 12 Nov 2019 23:15:47 -0600 (CST)
Received: from vali.starlink.edu (vali.starlink.edu [192.168.3.21])
        by mail.rptsys.com (Postfix) with ESMTP id 4D6ADC3D18D75;
        Tue, 12 Nov 2019 23:15:47 -0600 (CST)
Date:   Tue, 12 Nov 2019 23:15:46 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <814596202.25834.1573622146283.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <c3996c5a-477e-b1ee-0455-3366a1b5fadc@oracle.com>
References: <1204250219.669.1573609035591.JavaMail.zimbra@raptorengineeringinc.com> <c3996c5a-477e-b1ee-0455-3366a1b5fadc@oracle.com>
Subject: Re: Potential CVE due to malicious UUID conflict?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: Potential CVE due to malicious UUID conflict?
Thread-Index: Q5cW+ZJ6H+6OlKMLTjEIWNQARstRTQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



----- Original Message -----
> From: "Anand Jain" <anand.jain@oracle.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Tuesday, November 12, 2019 9:41:21 PM
> Subject: Re: Potential CVE due to malicious UUID conflict?

> On 13/11/19 9:37 AM, Timothy Pearson wrote:
>> I was recently informed on #btrfs that simply attaching a device with the same
>> UUID as an active BTRFS filesystem to a system would cause silent corruption of
>> the active disk.
>> 
> 
>> Two questions, since this seems like a fairly serious and potentially CVE-worthy
>> bug (trivial case would seem to be a USB thumbdrive with a purposeful UUID
>> collision used to quietly corrupt data on a system that is otherwise secured):
>> 
>> 1.) Is this information correct?
>> 2.) Does https://lkml.org/lkml/2019/2/10/23 offer sufficient protection against
>> a malicious device being attached iff the malicious device is never mounted?
>> 
>> Thank you!
>> 
> 
>  Corruption of the data is not possible at all. Because when the device
>  is mounted its already been excl-opened for RW and we won't
>  close/replace it unless unmounted. And while the device is mounted
>  if there is malicious device with the same UUID, then any scan shall
>  fail with -EEXIST if the kernel has the commit as in [2] (above).
> 
>  However if the kernel does not have [2], then it will just
>  appear as if the original device path has been replaced, but
>  underneath the RW IOs are still going to the original device
>  and not to the malicious device, so its safe.
> 
> 
> HTH
> 
> Thanks,
> Anand

Thank you, that helps greatly!  I was very concerned when I heard that info on IRC, and wanted to verify here.

Aside from the "interesting" corruption bug we hit on 5.3-rc3, BTRFS has been overall very stable and reliable for us.  I'm glad we don't have to worry about this type of attack (or admin oops, for that matter).
