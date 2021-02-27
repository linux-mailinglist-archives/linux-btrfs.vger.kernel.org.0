Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E854326B64
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 04:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhB0Dfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 22:35:30 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:57376 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhB0Df3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 22:35:29 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 7B6936C007E7;
        Sat, 27 Feb 2021 05:34:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1614396882; bh=4voITOZMM7ix1QEiOM96z+nBxlCSHTJsuDATd6MZdgM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ZlQ/Nxa/AKYCMs9vgIAkOjtkHkaOHTiBGfAJVAdjXKJf5j0IUkktsZGtH/enr9bWj
         MPH5BrXC5oPACV0dn/LW5YXOIgHAdpG2UMhMfRgqJZY4LFlkL0UZNJ252eMOT182lD
         gIrePiQ8xJxguSvbvo5V3r4hkrpoeUcIOsesJMbo=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 6D0126C007E5;
        Sat, 27 Feb 2021 05:34:42 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id lvPrETYCprJm; Sat, 27 Feb 2021 05:34:42 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D304F6C007E4;
        Sat, 27 Feb 2021 05:34:41 +0200 (EET)
Received: from smtpclient.apple (unknown [117.89.173.102])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 520B41BE00AC;
        Sat, 27 Feb 2021 05:34:40 +0200 (EET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.32\))
Subject: Re: [report] lockdep warning when mounting seed device
From:   damenly <l@damenly.su>
In-Reply-To: <CAJCQCtSRLhOmjbz6nQnwvWruUPdcZXbJzFMXk8yXZ8A5tguxLQ@mail.gmail.com>
Date:   Sat, 27 Feb 2021 11:34:34 +0800
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D710DA01-D06F-4CB6-B9B4-4714FA794D3B@damenly.su>
References: <tuq0pxpx.fsf@damenly.su>
 <CAJCQCtSRLhOmjbz6nQnwvWruUPdcZXbJzFMXk8yXZ8A5tguxLQ@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3654.80.0.2.32)
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtE0TYrL+Dm55TE3V0G3GeDUSOFf08TWBmpnGt1U324vCM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Feb 27, 2021, at 09:12, Chris Murphy <lists@colorremedies.com> wrote:
> 
> On Wed, Feb 24, 2021 at 9:40 PM Su Yue <l@damenly.su> wrote:
>> 
>> 
>> While playing with seed device(misc/next and v5.11), lockdep
>> complains the following:
>> 
>> To reproduce:
>> 
>> dev1=/dev/sdb1
>> dev2=/dev/sdb2
>> 
>> umount /mnt
>> 
>> mkfs.btrfs -f $dev1
>> 
>> btrfstune -S 1 $dev1
> 
> No mount or copying data to the file system after mkfs and before
> setting the seed flag? I wonder if that's related to the splat, even
> though it shouldn't happen.

Tried and the splat still exists. BTW, is it reproducible on your side?

Thanks,
Su
> 
> -- 
> Chris Murphy

