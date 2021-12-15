Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3A47651F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 23:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhLOWCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 17:02:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhLOWCa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 17:02:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B0191F3A6;
        Wed, 15 Dec 2021 22:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639605749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RS1lvRU7zavK2/weu87T24yiHFAvxOhu7Rdjf0OTG8=;
        b=CV1/ej8VyVNYGPw6g8gUWdCELOc4I0BGSK4zMiVY+95N3fXdr7dAVX15vtqjwLg4Z8i5yX
        WnYX2PYoSIC/shEHE+T5Tvrgf+BQOQw3xvta+mQQpRVQJgj7Xcc1ZuHjnJE7Z2uKU9EXaO
        I++6ZH5YOgZW0ZJOND5J3a1NE6fKj1k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C876613BBE;
        Wed, 15 Dec 2021 22:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TEbiLfRlumGeEQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Dec 2021 22:02:28 +0000
Subject: Re: [PATCH] btrfs: Create sysfs entries only for non-stale devices
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
References: <20211215144639.876776-1-nborisov@suse.com>
 <b08f828e-6336-fc09-521a-d4cf439e45d8@libero.it>
Cc:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <86e0c499-da7a-2e3a-1782-502d9b1ef944@suse.com>
Date:   Thu, 16 Dec 2021 00:02:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b08f828e-6336-fc09-521a-d4cf439e45d8@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.12.21 г. 20:55, Goffredo Baroncelli wrote:
> Hi Nikolay,
> 
> On 12/15/21 15:46, Nikolay Borisov wrote:
>> Currently /sys/fs/btrfs/<uuid>/devinfo/<devid> entry is always created
>> for a device present in btrfs_fs_devices on the other hand
>> /sys/fs/btrfs/<uuid>/devices/<devname> sysfs link is created only when
>> the given btrfs_device::bdisk member is populated. This can lead to
>> cases where a filesystem consisting of 2 device, one of which is stale
>> ends up having 2 entries under /sys/fs/btrfs/<uuid>/devinfo/<devid>
>> but only one under /sys/fs/btrfs/<uuid>/devices/<devname>.
> 
> What happened in case of a degraded mode ? Is correct to not show a
> missing devices ?

Good question, now I'm thinking if 'devices' show the currently
available devices to the filesystem, whilst 'devinfo' is supposed to
show what devices the fs knows about. So in the case of degraded mount
it should really have 2 devices under devinfo and only 1 under device.
But this also means the case you reported shouldn't be handled by the
devinfo sysfs code but rather the admin should do 'btrfs device scan -u'
to remove the stale device.


I'd say this is all pretty open to interpretation so I'd like to also
see David's and Josef's opinions on this.


> 
> 
<snip>
