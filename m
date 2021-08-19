Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463073F15F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhHSJPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 05:15:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhHSJPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 05:15:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F21611FD84;
        Thu, 19 Aug 2021 09:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629364484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bzi1cYIIOQevb94AmFXpBvxLXC6V2quOTyAZohKHGrQ=;
        b=tOmcwJP9bPqdw+giR8XU0au8iwgucVI8w4fXLTW3A2xv8/uvqCHthF/2QSZJwPPRYo33vt
        ix9nD4UvrXjdUj/Dopd97L14gab34OMNSii31EJC55nia3djKjflf34ir3gIyD27rEDf2K
        PUjWu5pnpd71mmKRUUfH6WKY3bk3X/g=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 85F101340C;
        Thu, 19 Aug 2021 09:14:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id RiWZHQMhHmEcJwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 09:14:43 +0000
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
From:   Nikolay Borisov <nborisov@suse.com>
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org
References: <20210728165632.11813-1-dsterba@suse.com>
 <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
 <20210809091916.GJ5047@suse.cz>
 <a246559d-8eed-7885-d20e-df651d73d146@oracle.com>
 <20210818234838.GB5047@twin.jikos.cz>
 <2f902c42-fc4d-05f1-7a7a-fe4e3a20e7c4@suse.com>
Message-ID: <941c3ec7-73bb-e64d-dd6d-8c7725ab5f8a@suse.com>
Date:   Thu, 19 Aug 2021 12:14:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2f902c42-fc4d-05f1-7a7a-fe4e3a20e7c4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.08.21 г. 12:08, Nikolay Borisov wrote:
> 
> 
> On 19.08.21 г. 2:48, David Sterba wrote:
>> On Tue, Aug 10, 2021 at 08:30:51AM +0800, Anand Jain wrote:
>>>   As in the proposed patch which adds a table to figure out the correct 
>>> table to add the attribute, adding to the 
>>> btrfs_supported_static_feature_attrs attribute list will add only to 
>>> /sys/fs/btrfs/features, however adding the attribute to 
>>> btrfs_supported_feature_attrs adds to both /sys/fs/btrfs/features and 
>>> /sys/fs/btrfs/uuid/features.
>>
>> I can't see it in the code right now, but that would mean that eg. zoned
>> would show up in static features once such filesystem is mounted. And
>> that does not happen or I'm missing something.
>>
> 
> This happens because when initialising sysfs we create the
> btrfs_feature_attr_group which contains btrfs_supported_feature_attrs
> attributes, which have
> #ifdef CONFIG_BLK_DEV_ZONED
> 
>          BTRFS_FEAT_ATTR_PTR(zoned),
> 
> #endif
> 
> Subsequently you define the static feature via
> BTRFS_ATTR(static_feature, zoned, zoned_show);
> 
> and finally we call:
> 
> ret = sysfs_merge_group(&btrfs_kset->kobj,
> &btrfs_static_feature_attr_group);
> 
> 
> Which merges the static feature to the feature group. That's why the
> message about duplication. So one of the 2 definitions needs to go.
> 

Looking at the maze that btrfs' sysfs code is it seems the decision
which of the two sets to use when defining a feature is whether it can
be enabled or not at runtime. I think for zoned block device we can't
really disable the support at runtime? If so then it needs to only be
defined as a static feature? Just because the kernel supports it doesn't
necessarily mean it's going to be used if the underlying device is not
zoned, right, it should depend on the runtime characteristics of the
underlying device?
