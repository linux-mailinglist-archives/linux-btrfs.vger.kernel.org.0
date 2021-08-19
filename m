Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB83F15C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhHSJIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 05:08:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhHSJIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 05:08:42 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4853821BDD;
        Thu, 19 Aug 2021 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629364086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTYK0druirEOfQtJd9m156weel8ay2/wOHUG6TNlKyY=;
        b=SJOVuw2MwTkBuCx/aaF27iFOijh1AvFwG2JC3AuZ1hnpKXKGRMr2udEhp9Js9lc/npViJW
        uEtI+5YmvLpZladwBrlfYI86RhSvBkqFQTi+D0U78h6BLIaSS0vX/LaTYf1EA0t/NYM39h
        Xnd3GOdmXabLuWA75RVHEVgCytE7URI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D7A3B1340C;
        Thu, 19 Aug 2021 09:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id DWYsMnUfHmEHJQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 09:08:05 +0000
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org
References: <20210728165632.11813-1-dsterba@suse.com>
 <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
 <20210809091916.GJ5047@suse.cz>
 <a246559d-8eed-7885-d20e-df651d73d146@oracle.com>
 <20210818234838.GB5047@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <2f902c42-fc4d-05f1-7a7a-fe4e3a20e7c4@suse.com>
Date:   Thu, 19 Aug 2021 12:08:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818234838.GB5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.08.21 г. 2:48, David Sterba wrote:
> On Tue, Aug 10, 2021 at 08:30:51AM +0800, Anand Jain wrote:
>>   As in the proposed patch which adds a table to figure out the correct 
>> table to add the attribute, adding to the 
>> btrfs_supported_static_feature_attrs attribute list will add only to 
>> /sys/fs/btrfs/features, however adding the attribute to 
>> btrfs_supported_feature_attrs adds to both /sys/fs/btrfs/features and 
>> /sys/fs/btrfs/uuid/features.
> 
> I can't see it in the code right now, but that would mean that eg. zoned
> would show up in static features once such filesystem is mounted. And
> that does not happen or I'm missing something.
> 

This happens because when initialising sysfs we create the
btrfs_feature_attr_group which contains btrfs_supported_feature_attrs
attributes, which have
#ifdef CONFIG_BLK_DEV_ZONED

         BTRFS_FEAT_ATTR_PTR(zoned),

#endif

Subsequently you define the static feature via
BTRFS_ATTR(static_feature, zoned, zoned_show);

and finally we call:

ret = sysfs_merge_group(&btrfs_kset->kobj,
&btrfs_static_feature_attr_group);


Which merges the static feature to the feature group. That's why the
message about duplication. So one of the 2 definitions needs to go.
