Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5C13085F
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 15:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAEOHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 09:07:23 -0500
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:40960 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgAEOHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 09:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1578233240;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=QkESTN4COj57kPLtlXdLAx0XOOSks+880Kils+BuF3c=;
        b=jWIUQE3jyQP+FofhcMAjv1loF2WabFwojhxVRXCGRxEJ/2nCvoE+PG9aWqpvLoq9
        fzGIE2SvLV8eJq68GGw2l3Zf4hdImr0cqYYyNMfBO3EOA4oHE3PxUNNH/m0bzsnv+TG
        lQS6QeeipG5hmiaKihKSO3D8ZP6S184GJoOdZqj8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1578233240;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=QkESTN4COj57kPLtlXdLAx0XOOSks+880Kils+BuF3c=;
        b=P05Fv6UCVk8bHlnR396NbX1LLpaJRzza5uOVP3+q6ToxKGmNuuQ4dliZBBT8dCBQ
        11sdI3DkOGCDO0UJ5l1C0nA25wx/ca5w7FcafWfLZQmFs1wZ3rAxK083XtuZLsRvN8e
        T92ejM2TkKWgKtlVB7ErTDLz8mCa1VlwPNqs8TJY=
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <CAJCQCtQmvHS8+Z7=B_8panSzo=Bfo0ymVU+cr_tR5z1uw+Ejug@mail.gmail.com>
 <CE5FDD33-F072-40EE-9ED7-66D5F7F2A5FA@icloud.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016f76081d01-72e2a7ca-3d8e-4238-b578-898fbe7d7bc3-000000@eu-west-1.amazonses.com>
Date:   Sun, 5 Jan 2020 14:07:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CE5FDD33-F072-40EE-9ED7-66D5F7F2A5FA@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.01.05-54.240.4.3
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05.01.2020 14:40 Christian Wimmer wrote:
>> On 5. Jan 2020, at 01:03, Chris Murphy <lists@colorremedies.com> wrote:
>>
>> On Sat, Jan 4, 2020 at 10:07 AM Christian Wimmer
>> <telefonchris@icloud.com> wrote:
>>> Hi guys,
>>>
>>> I run again in a problem with my btrfs files system.
>>> I start wondering if this filesystem type is right for my needs.
>>> Could you please help me in recovering my 12TB partition?
>> If you're having recurring problems, there's a decent chance it's
>> hardware related and not Btrfs, because Btrfs is pretty stable on
>> stable hardware. Btrfs is actually fussier than other file systems
>> because everything is checksummed.
>>
> I think I can exclude hardware problems. Everything is brand new and well tested.
> The biggest chance for being the source of errors is the Parallels Virtual machine where Linux (Suse 15.1) is running in.
> In this Virtual Machine I specify a “growing hard disc" that is actually a file on my 32 TB Promise Pegasus Storage.
> I just can not understand why it runs fine for almost 1 month (and actually more for other growing hard discs of smaller size) and then shows this behaviour.
>
Does the host machine use ECC-RAM?

That Promise Pegasus Storage looks like a simple harware RAID without
integrity protection (like a btrfs RAID1/RAID6 or something like ceph
would give you).

Both of those can cause the errors you posted.


