Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC911E8C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfLMQwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 11:52:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39313 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfLMQwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 11:52:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id i12so2780887qtp.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z2qlFHtYeOdEzkWmV7+orI2qPuU1XWKXbXVOxhpcueM=;
        b=idgcZAgHeZgVWTjECPvBp0b0qBPYz1hSSnHlN+3h6+r8GzUo+veIziFe8nnfw/G6gu
         0aOcstCQKbwXOnJ9JlaBrjViP8b7nttNapLE0JWqUu2W/uTj3JZfY0faqZb/TFUO2s5R
         47glWXklNLojnxw1ba6dGGShA8srjcYPL+hTxTMwA9dprqEdFs/b+LsXSm/uGlHjZu+K
         QZvQoKPIMgqKqHsMLGgfV3h4sRWSpypYvQ8OXXEsCcilM7ply9UAE5LCV2Ijc9NBuFLi
         2uGk5BhCX5ftGHOcqDmke0fUSpIDkEBm5hEHCTCV2cYWw8MqPTzcUCsOqZuUeN5yUEQ0
         WJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z2qlFHtYeOdEzkWmV7+orI2qPuU1XWKXbXVOxhpcueM=;
        b=c8T9lS8mIWZYXEI8bnqNE6l4zoM0Q+7H4ArNwEl8tUCaQEc7OIGn9ZTpLNTinNc/9P
         WYNIyOq130mDuEXETQ68kzXecyqQzITBPHyOumFeaB57PgqsuBoyPwR7HD54QmKa//+R
         Lt+1NxTE6Av9m8MOe1yWmYEYlG+35CVM62j3Dvdn5SrTF4PLeQSHcGJZnnJUzyvnEsvB
         owDUFN7v4tamGBSLXBZKV3/BWWWEksfMPws5NJ+hOwtU4u1VdasTh+DTh7G66N9LNe/n
         Dc4OGeGj1Omo1VnDwnUSFSHT+NjSWv3sNaQ0N2ZkirV+4zsgTAeJ9nmqjLUPdz/G5JtG
         jQDQ==
X-Gm-Message-State: APjAAAVilABcxw74aySdtEmrCQQvW5GrkW5qzPJ8r2D1WBrZ14P9T+Mt
        iAeoXR5C8YI1WS3BUL2pSkvegQ==
X-Google-Smtp-Source: APXvYqwmzqeBbRja+jYcNRQC0ics2KUk9Fxj1EFb+yDlJnPafAwvOj6E28yfS5SbNL9p6NxyZHIPTw==
X-Received: by 2002:aed:2103:: with SMTP id 3mr13149411qtc.132.1576255930345;
        Fri, 13 Dec 2019 08:52:10 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id 200sm3007783qkh.84.2019.12.13.08.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:52:09 -0800 (PST)
Subject: Re: [PATCH v6 09/28] btrfs: align device extent allocation to zone
 boundary
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-10-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9e8dcbe8-71e7-0f07-738d-eb2802357444@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:52:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-10-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> In HMZONED mode, align the device extents to zone boundaries so that a zone
> reset affects only the device extent and does not change the state of
> blocks in the neighbor device extents. Also, check that a region allocation
> is always over empty zones and it is not over any locations of super block
> zones.
> 
> This patch also add a verification in verify_one_dev_extent() to check if
> the device extent is align to zone boundary.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
