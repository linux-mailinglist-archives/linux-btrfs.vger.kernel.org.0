Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A548B0AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 16:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiAKPTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 10:19:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53832 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiAKPTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 10:19:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D596B2112B;
        Tue, 11 Jan 2022 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641914384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cL+iVWZNdVH97tZMRrGX6PCLmoQZfzMVIrfdg01hXMM=;
        b=dyS1gAGbaFx5x+KZxfe/7URU/eK+2S5Lgzm9mGgdpSy1byKBdgF9B07caGiN7DiE5WwNYN
        zRaYBBeHKRJpd43aiKktm+nrtk5tjebyFH3mHXWEHVpfs+q33sDVzRtXGiVpxik4gMJpKE
        Ggs8EnjmaZc5PW7zFkmahdVDcYlNfIU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 947D513DDD;
        Tue, 11 Jan 2022 15:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4v64IBCg3WEKCAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 11 Jan 2022 15:19:44 +0000
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1634598659.git.anand.jain@oracle.com>
 <98a34772-990c-5e8e-5402-a6d857fc0292@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4a7ddf8e-f283-a2e8-3c96-c67ae4b3bf5b@suse.com>
Date:   Tue, 11 Jan 2022 17:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <98a34772-990c-5e8e-5402-a6d857fc0292@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.01.22 г. 2:04, Anand Jain wrote:
> 
> Gentle ping?
> 
> The related kernel patch is already in misc-next.
> I don't find this btrfs-progs patch-set in the devel branch.

And what about introducing a test case for this change?

> 
> Thanks, Anand
> 
> 
> On 19/10/2021 08:23, Anand Jain wrote:
>> The following test case fails as it trying to read the fsid from the sb
>> for a missing device.
>>
>>     $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>>     $ btrfstune -S 1 $DEV1
>>     $ wipefs -a $DEV2
>>     $ btrfs dev scan --forget
>>     $ mount -o degraded $DEV1 /btrfs
>>     $ btrfs device add $DEV3 /btrfs -f
>>
>>     $ btrfs fi us /btrfs
>>       ERROR: unexpected number of devices: 1 >= 1
>>       ERROR: if seed device is used, try running this command as root
>>   The kernel patch [1] in the mailing list provided a sysfs interface
>> to read the fsid of the device, so use it instead.
>>
>>   [1]  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>>
>> This patch also retains the old method that is to read the SB for
>> backward compatibility purposes.
>>
>> Anand Jain (2):
>>    btrfs-progs: prepare helper device_is_seed
>>    btrfs-progs: read fsid from the sysfs in device_is_seed
>>
>>   cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 42 insertions(+), 5 deletions(-)
>>
> 
