Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC713209CC
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 12:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBULRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 06:17:14 -0500
Received: from ns2.wdyn.eu ([5.252.227.236]:37848 "EHLO ns2.wdyn.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhBULRN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 06:17:13 -0500
X-Greylist: delayed 63069 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Feb 2021 06:17:12 EST
Subject: Re: Unexpected "ERROR: clone: did not find source subvol" on btrfs
 receive
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1613906217;
        bh=Ryreu3yZKN2Rmi+3cHi/vcYzPG+t2OjnAHMS4izGuDs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=puyDynpiferXHkzXaHSCugtXvXWSEn/GBe0+Zqt1OTp/0blS0TEzyPcCqxC4cY4G4
         RCr72bLHEic+Yrzgxvt1NZSOWBQCWoZTSOimAbJj/NnK28b+OrOR3cwdVEMJbQiAw1
         kcV94vSVpfZ6Pd3NU3JwL6P2ToU3hYVonENR+OyM=
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <41b096e1-5345-ae9c-810b-685499813183@wetzel-home.de>
 <0fcbd697-11c5-0b32-7e08-80cf8d355271@gmail.com>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <0d8ff769-59b3-9bbe-d958-9879e6f34719@wetzel-home.de>
Date:   Sun, 21 Feb 2021 12:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0fcbd697-11c5-0b32-7e08-80cf8d355271@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 21.02.21 um 07:54 schrieb Andrei Borzenkov:
> 20.02.2021 20:45, Alexander Wetzel пишет:
>>
>> # time btrfs receive -v -f test2 .
>> receiving snapshot 2021-02-20-TEMP
>> uuid=120113e6-f83c-b240-ba27-259be4c92ea7, ctransid=206769
>> parent_uuid=d31d553f-0917-3c48-b65c-ec51fd0c6d89, parent_ctransid=195056
> ...
>> write var/lib/mysql/nextcloud/oc_activity.ibd - offset=737280 length=8192
>> ERROR: clone: did not find source subvol
> 
> Unforutnately btrfs receive does not print clone source UUID even with
> "btrfs receive --dump". The best is to modify process_clone to print
> full command including UUID which was not found.
> 

I've patched cmds/receive.c to print out the uuid subvol_uuid_search was 
not able to find:

Basically these I replaced the original error message with:
uuid_unparse(clone_uuid, uuid_str);
error("clone: did not find source subvol si=%i, uuid=%s", si, uuid_str);

With that modification I get:

At snapshot 2021-02-20-TEMP
ERROR: clone: did not find source subvol si=0, 
uuid=d31d553f-0917-3c48-b65c-ec51fd0c6d89

But uuid d31d553f-0917-3c48-b65c-ec51fd0c6d89 is the uuid of the correct 
parent...

The problem here seems to be the zero return of ubvol_uuid_search().

While compiling I also switched to 
https://github.com/kdave/btrfs-progs.git. Same problem.

I then tracked the error down up to btrfs_uuid_tree_lookup_any():

nr_items is zero after the call
ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &search_arg);
(ret is also zero)

So looks like this is a filesystem issue?

Alexander
