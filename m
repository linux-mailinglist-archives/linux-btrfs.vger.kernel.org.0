Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F03FEF73
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbhIBOaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 10:30:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52772 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345492AbhIBOaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 10:30:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF6F722615;
        Thu,  2 Sep 2021 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630592939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jm2AgDp7twhbKkq7PmxYcC7QSqL8y7AMzmsDoDiY9hs=;
        b=rc/nKyI8PDCRUjnDgLoHQNYwKyX/s90DeVT17V88mAvC6jSXmtXem090GkW4+/uetptYL3
        rvd8HUEugq4c5DRrMFyRJqpA1LFZ/mgwlkcsk/StoQBrBDTWHrLKEcVAOkklGVuK5KZbx8
        iDqYxcTmYTar1tRBjljxVE0AM49KfWs=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7A8E41372E;
        Thu,  2 Sep 2021 14:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SCqIG6vfMGF0KQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 02 Sep 2021 14:28:59 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <b2f9ea09-7fdb-dd3f-2e58-3cdfed65cf12@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <44803fc4-8f7d-2bda-f7b3-06017f6d5b39@suse.com>
Date:   Thu, 2 Sep 2021 17:28:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b2f9ea09-7fdb-dd3f-2e58-3cdfed65cf12@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.09.21 г. 14:44, Anand Jain wrote:
> On 02/09/2021 18:06, Nikolay Borisov wrote:
>> Currently when a device is missing for a mounted filesystem the output
>> that is produced is unhelpful:
>>
>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>     Total devices 2 FS bytes used 128.00KiB
>>     devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>     *** Some devices missing
>>
>> While the context which prints this is perfectly capable of showing
>> which device exactly is missing, like so:
>>
>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>     Total devices 2 FS bytes used 128.00KiB
>>     devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>     devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
>>
>> This is a lot more usable output as it presents the user with the id
>> of the missing device and its path.
> 
> Looks better. How does this fair in the case of unmounted btrfs? Because
> btrfs fi show is supposed to work on an unmounted btrfs to help find
> btrfs devices.

On unmounted fs the output is unchanged - i.e we simply print "missing
device" because there is no way to derive the name of the missing
device. Check print_one_uuid for reference.

<snip>
