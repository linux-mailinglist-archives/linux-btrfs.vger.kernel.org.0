Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BBD42C004
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhJMMbu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:31:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50078 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhJMMbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:31:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94EA81FD77;
        Wed, 13 Oct 2021 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634128168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpYAmQWlESBB+CdL1SCxkJ1GyfV364ZphBXGggv9ol8=;
        b=MzhGRV4EgkSbvInVcYSdfBl8mwGHlN0nXZ8MfxWdnkFpJqPxIqqTmhalBQ0bqHN2XQ9IcZ
        VDqgujuEHuCAaNQ1AxqotRigOjDIHYqagt/a5OdUh6Gb+0OzGa4WMC8ciLZGBcKM1eJz35
        IL7Eb61U1af2W1NY96SZlQ7DWMZp4EA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D7A213CEC;
        Wed, 13 Oct 2021 12:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cht0FCjRZmFJDwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Oct 2021 12:29:28 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>, Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
 <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
 <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
Date:   Wed, 13 Oct 2021 15:29:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.10.21 г. 15:27, Chris Murphy wrote:
> On Wed, Oct 13, 2021 at 8:18 AM Qu Wenruo <wqu@suse.com> wrote:
> 
>> Sorry, it only needs the last the stack (submit_compressed_extents+0x38)
>>
>> The full command would looks like this:
>>
>> $ ./scripts/faddr2line fs/btrfs/btrfs.ko submit_compressed_extents+0x38
> 
> btrfs is built-in on Fedora kernels, so there's no btrfs.ko, when I do:
> 
> $ /usr/src/kernels/5.14.9-300.fc35.x86_64/scripts/faddr2line
> /boot/vmlinuz-5.14.9-300.fc35.x86_64 submit_compressed_extents+0x38
> readelf: /boot/vmlinuz-5.14.9-300.fc35.x86_64: Error: Not an ELF file
> - it has the wrong magic bytes at the start
> nm: /boot/vmlinuz-5.14.9-300.fc35.x86_64: no symbols
> nm: /boot/vmlinuz-5.14.9-300.fc35.x86_64: no symbols
> no match for submit_compressed_extents+0x38
> 
> 
>> The modules needs to have debug info though.
> 
> CONFIG_BTRFS_DEBUG ?
> 
> Neither regular nor debug kernels have this set, we're only setting
> CONFIG_BTRFS_ASSERT on debug kernels.
> 

No, debug info is intorduced by CONFIG_DEBUG_INFO

so you need the kernel debug package for fedora i.e vmlinuz.debug or
some such?

> 
