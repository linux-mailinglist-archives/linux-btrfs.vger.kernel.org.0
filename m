Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6C3C213B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGIJKS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 05:10:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34066 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhGIJKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 05:10:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B3DD220FC
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625821654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhuRgY1jCwxfT8jcftby982EWUK0VRHZyFkS6dUUZ+o=;
        b=gtILIO5aBN7SNY5uyvzIvWaCOVc1rvuTMgoMS+toKv7LfJVXz4VmdKBckUskFYZVzMDuOC
        jY4AKIwhYxphmy4rOvQGMya5f/T0JG5agEATkDwZmCntE/zcINVlqDHT3ssW+fNxL2zedW
        QAtFNYCLe1jIck1HHntozl0QPTYJF78=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E844C1333A
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id exoMNdUR6GBtHQAAGKfGzw
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 09:07:33 +0000
Subject: Re: where is the parent of a snapshot?
To:     linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
 <20210709074810.GA1548@tik.uni-stuttgart.de>
 <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
 <20210709084523.GB1548@tik.uni-stuttgart.de>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b3d67963-7bb5-2fbf-f8a0-d7712925855a@suse.com>
Date:   Fri, 9 Jul 2021 12:07:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709084523.GB1548@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.07.21 г. 11:45, Ulli Horlacher wrote:
> On Fri 2021-07-09 (04:09), Remi Gauvin wrote:
>> On 2021-07-09 3:48 a.m., Ulli Horlacher wrote:
>>
>>>
>>> So, where is subvolume uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2??
>>>
>>
>> btrfs subvolume show /mnt/spool   will display what you want.  It seems
>> as though the subvolume list does not include the root subvolume.
> 
> root@unifex:/# btrfs subvolume show /mnt/spool
> /
>         Name:                   <FS_TREE>
>         UUID:                   7f010d85-b761-45e7-8d4a-453f81bb10b2
>         Parent UUID:            -
>         Received UUID:          -
> (...)
> 
> Ahhhh!
> I was using the wrong command!
> 
> root@unifex:/# btrfs filesystem show /mnt/spool
> Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
>         Total devices 2 FS bytes used 209.81GiB
>         devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
>         devid    2 size 14.55TiB used 100.00GiB path /dev/loop1
> 
> The filesystem has different uuid than the root subvolume?!

Yes, it's been like that forever.
