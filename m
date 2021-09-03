Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567983FFAC6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347344AbhICG73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 02:59:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47428 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346599AbhICG72 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 02:59:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A01622438;
        Fri,  3 Sep 2021 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630652308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUTPPiNN7whwHdYJvlqC1v0mpiNtpk27zghbErwMkxM=;
        b=lG3VE7MNkl5X8X0yMI+aK5uBfwvA8wshuoz/psCh/eT2V/CMHGfjOk5qvUAJvhHRJ/1bm3
        sF565E6VmvGsxSoIoOAizIoxxtBuVh7o+JjCgdAbNL2fH5Y+UZtj13n7Y/RO8mmJbvQwCP
        kHCch3pCehBTAhZx3qdsm0xM7CAicUY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D2411136BF;
        Fri,  3 Sep 2021 06:58:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id m4JfMJPHMWEyWwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 03 Sep 2021 06:58:27 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <b2f9ea09-7fdb-dd3f-2e58-3cdfed65cf12@oracle.com>
 <44803fc4-8f7d-2bda-f7b3-06017f6d5b39@suse.com>
 <c3aa7db1-c3ca-2a26-2eaf-c975e2b0af54@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ce6a4a06-ed9d-a8a7-f65c-27f3f33ce10a@suse.com>
Date:   Fri, 3 Sep 2021 09:58:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c3aa7db1-c3ca-2a26-2eaf-c975e2b0af54@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.09.21 г. 8:12, Anand Jain wrote:
> On 02/09/2021 22:28, Nikolay Borisov wrote:
>>
>>
>> On 2.09.21 г. 14:44, Anand Jain wrote:
>>> On 02/09/2021 18:06, Nikolay Borisov wrote:
>>>> Currently when a device is missing for a mounted filesystem the output
>>>> that is produced is unhelpful:
>>>>
>>>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>>>      Total devices 2 FS bytes used 128.00KiB
>>>>      devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>      *** Some devices missing
>>>>
>>>> While the context which prints this is perfectly capable of showing
>>>> which device exactly is missing, like so:
>>>>
>>>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>>>      Total devices 2 FS bytes used 128.00KiB
>>>>      devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>      devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
> 
> 
> This change has to percolate to xfstests as well. I think btrfs/197,
> btrfs/198 and btrfs/003 depends on the existing format. IMO those
> test cases still have to be backward btrfs-progs compatible.

Actually it's only btrfs/197, I will fix it.

> 
> Thanks, Anand
> 
> 
>>>>
>>>> This is a lot more usable output as it presents the user with the id
>>>> of the missing device and its path.
>>>
>>> Looks better. How does this fair in the case of unmounted btrfs? Because
>>> btrfs fi show is supposed to work on an unmounted btrfs to help find
>>> btrfs devices.
>>
>> On unmounted fs the output is unchanged - i.e we simply print "missing
>> device" because there is no way to derive the name of the missing
>> device. Check print_one_uuid for reference.
>>
>> <snip>
>>
> 
