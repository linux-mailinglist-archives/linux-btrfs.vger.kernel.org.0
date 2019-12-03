Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8310F770
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 06:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLCFme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 00:42:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46543 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCFme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 00:42:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so1027193pjq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 21:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=khEWm0eoiYiQYooDJ+9ps3irR0mojWg5jVsvXIMrie0=;
        b=NGvA8QqWOzN8YARSxj9cIzdI7VP38TJ7CMX6L8bR0sFfXCxPuZsFE2Lr4Q+EH3z8v6
         pbqLCg16Fu11/pSM8xqDwvmpAcbiuKfH0vCDko+8uGjMNFmrmbIQfLO6CcNqjLAFcKHP
         VLrUoB3tejlopdfdRj8tnzJrBTkeM2HZoVHe7DVWfFaL1A0f3iIDrxwpRSqSdShnIcoa
         +Ywh/tAFyPdWIQiXsQOC2BRdgue6uE164QVmp5up3LlRBxdv+NAYlccP4xTBtfFNQQlZ
         db/WnlA/WSgenCZtNvfyFRuecbA7gWvsCdGvOVXWjiWaQXqNXP6tkR7nOSqGfXGTh/xP
         ULZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khEWm0eoiYiQYooDJ+9ps3irR0mojWg5jVsvXIMrie0=;
        b=ZpzO0JnlxstxeOyaGkaA/AvgNvjplUsxJx1iVqq4Hl514TVRXa4664sUCQCB+gEvkU
         F8GbD72EGzWXh1ZgREOj2aS1vtd3GyijbHZzHp5pmcg4sW4+g/dolYJ+cpmh0QctyktN
         vaL0b3pMz/ujTvhZ7ewwaSrslaNSN6FcAs1VuHwwaw6cGbbXxVysRfg9hDKcNFg7hg5n
         TnQZPGbsrMBnUiZiIqUNNluYs7h8liwmz2Jfl3ORVr21BN8TckQpIvfzNEWhhsdG5Lir
         6paF2r2qmfVOrI+gvX+r8p4XibjeyLjYlKiLx0ynbt+8TTE1zOb26EOjoCwgkVsjLLHO
         gIEA==
X-Gm-Message-State: APjAAAWoc+fJDxr4R7D+kOhJJQvLYC6vnWc6dVvW3YKT9pFJ+Jf/7A7W
        zZR24XWfrZdLvGPk7t1AaAteEst2ZGg=
X-Google-Smtp-Source: APXvYqyecSelnGjBeOPBzQGdnid2VbarESFSmavgCM3kQQevfvWcxTy8HfdHeExNv80wYasLnnFoWA==
X-Received: by 2002:a17:902:ff04:: with SMTP id f4mr3005619plj.275.1575351753151;
        Mon, 02 Dec 2019 21:42:33 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id c1sm1598860pfa.51.2019.12.02.21.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 21:42:32 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2 2/5] btrfs: sysfs, rename device_link add,remove
 functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
 <1574328814-12263-3-git-send-email-anand.jain@oracle.com>
 <20191126164001.GJ2734@twin.jikos.cz>
Message-ID: <0578af0d-dcd4-36e8-65c3-31707f51c50b@oracle.com>
Date:   Tue, 3 Dec 2019 13:42:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191126164001.GJ2734@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/27/19 12:40 AM, David Sterba wrote:
> On Thu, Nov 21, 2019 at 05:33:31PM +0800, Anand Jain wrote:
>> In preparation to add btrfs_device::dev_state attribute in
>>    /sys/fs/btrfs/UUID/devices/
> 
> But we don't want to add any attributes to that directory, is this some
> leftover from the previous iterations?

No actually. We discussed to add <devid>/dev_state under UUID/devices
here [1].
[1]
https://lore.kernel.org/linux-btrfs/516598e6-4968-4535-cf6b-12402518b7cc@oracle.com/

Looks like you still prefer separate UUID/devinfo directory as you
mentioned here [2]

[2]
https://lore.kernel.org/linux-btrfs/20191118154556.GJ3001@twin.jikos.cz/

?

Thanks, Anand

>> Rename btrfs_sysfs_add_device_link() and btrfs_sysfs_rm_device_link() to
>> btrfs_sysfs_add_devices_attr() and btrfs_sysfs_remove_devices_attr() as
>> these functions is going to create more attributes rather than just the
>> link to the disk. No functional changes.
> 
> I think the function name matches what it does, it really links the
> device.
> 



