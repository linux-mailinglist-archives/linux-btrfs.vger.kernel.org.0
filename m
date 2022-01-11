Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FF48A962
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 09:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbiAKIaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 03:30:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38342 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348929AbiAKIav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 03:30:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2547B210FF;
        Tue, 11 Jan 2022 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641889850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2fgF3qhLtXvy/d4OZwMKKt3boxVO219Q995RKF205g=;
        b=qxuUYDBLv1KxGI5klh6eJMZhHr29nXc8XoA299Exd4k+vSYGArXX6TVWoK/FAcU1yC0uli
        ycjNogVch/009HaUP+2JnUrvY+Gzu36lhUvo+XEAeN7cWoBuYLg2vVIv33iRcZW5qDns9m
        K8WtvbFreSD2u/BWv7ZLP/SWXCgOZ1g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5A5313638;
        Tue, 11 Jan 2022 08:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ye11KTlA3WG+FQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 11 Jan 2022 08:30:49 +0000
Subject: Re: [External] : Re: [PATCH v4 2/4] btrfs: redeclare
 btrfs_stale_devices arg1 to dev_t
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
 <df5e06aa-5ed4-0df2-9210-ea8d19069cba@suse.com>
 <5656e466-7950-2dd0-11f0-2dadcc191f7c@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8050ed8f-200c-5adb-34e6-012100b2e913@suse.com>
Date:   Tue, 11 Jan 2022 10:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5656e466-7950-2dd0-11f0-2dadcc191f7c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.01.22 г. 6:51, Anand Jain wrote:
> 
>>> @@ -604,14 +599,14 @@ static int btrfs_free_stale_devices(const char
>>> *path,
>>>                        &fs_devices->devices, dev_list) {
>>>               if (skip_device && skip_device == device)
>>>                   continue;
>>> -            if (path && !device->name)
>>> +            if (devt && !device->name)
>>
>> This check is now rendered obsolete since ->name is used iff we have
>> passed a patch to match against it, but since your series removes the
>> path altogether having device->name becomes obsolete, hence it can be
>> removed.
> 
> We have it to check for the missing device. Device->name == '\0' is one
> of the ways coded to identify a missing device. It helps to fail early
> instead of failing inside device_matched() at lookup_bdev().

In this case shouldn't the check be just for if (!device->name) rather
than also checking for the presence of devt? Also a comment is warranted
that we are skipping missing devices.

> 
> Thanks, Anand
> 
