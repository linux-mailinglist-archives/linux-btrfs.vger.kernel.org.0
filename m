Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5115C2E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 16:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBMPiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:38:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45254 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbgBMP3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so4619234qte.12
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kodiMKGBjBcSfIvaenwgjSe7A1p4yFG28LJSfaCFuic=;
        b=2NpeZuxUg0a1AYwXittI32Yg7C3dw7ZfDlI5Xg2jj0whfL+PxYOIOaMdTF7jf01VW4
         eh12CQ3urcmnHyzA6sXYiQyh/jlPm6p7RyuzlzcKAETrw6zjmDg3D7a2y6qf9EqCSe1d
         R1zg5AE2JayHJEbNtoDV+LtW1J5GKtGydkJHCecoxrVWKUiJDxGVVjIqZXGCbZNSrLPt
         +Ga7Xae9QFcRPIBEz/B3oR0JfbEWEij5ZYM/iaibSHhZEIfAY8Qe41VUERGyu/VZMgB/
         Go+2cVM54sAMQIf4ZIZGGe25CaVUXFUJorDW4oxrWRUhYEGMx2coFaSGUtbBhhGGw1Sq
         SHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kodiMKGBjBcSfIvaenwgjSe7A1p4yFG28LJSfaCFuic=;
        b=pFhzi/WBKcStU3sWQ6BcLhTUPhXqzVOkFY5ghvwjhZn508rGI/LsxEIUFkOjJRzrYN
         ANzK1T2LAIjhM29Sa+WOqwoLLHJ9lyPTdY30ZaJJ7QAutTBU8d3gXlPBqPuoMmcYH1y4
         73BX8KzzRUloTe9i16fUTw31rZTr0KgQsAV5Ct7XJbxCqqXRd1nre8/ShSBREbUdCnH0
         3ThHlY2Kff9WOccSv7XruJJeZWEih4vnBmiX9/rBgZV0Gz4AF/R3vz+VM5Jzs/MHFm53
         5i2zfbpptZHOmPSEOgIRXNnk66cBvip13mntYlLjND3rufuKyeF9tO5OM6X9IqxU3Emk
         a3rA==
X-Gm-Message-State: APjAAAU3gbfWYTV/Z6XMeF9aWdccewb5Fo3/iD6kSBBoBzpLFzLN4AeB
        7sW6G6HH3xszSUAf8ILhxb8Bs+zpxhc=
X-Google-Smtp-Source: APXvYqzUa+oTYU3CPMpUpT/KeGOdOvzSHl2s17RsqaDmUykAJXr71UMbVKusVLU73FsPk2qrqb3IWA==
X-Received: by 2002:ac8:2b82:: with SMTP id m2mr11927625qtm.161.1581607758490;
        Thu, 13 Feb 2020 07:29:18 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::edcc])
        by smtp.gmail.com with ESMTPSA id 64sm1480464qkh.98.2020.02.13.07.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 07:29:16 -0800 (PST)
Subject: Re: [PATCH 4/4] btrfs: fix bytes_may_use underflow in prealloc error
 condtition
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-5-josef@toxicpanda.com>
 <55467ec8-f966-d4f9-d882-8c5881328f77@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <42fac191-f4a4-ab70-01ce-307c80909905@toxicpanda.com>
Date:   Thu, 13 Feb 2020 10:29:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <55467ec8-f966-d4f9-d882-8c5881328f77@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/20 5:17 AM, Nikolay Borisov wrote:
> 
> 
> On 11.02.20 г. 23:40 ч., Josef Bacik wrote:
>> I hit the following warning while running my error injection stress testing
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 3 PID: 1453 at fs/btrfs/space-info.h:108 btrfs_free_reserved_data_space_noquota+0xfd/0x160 [btrfs]
>> RIP: 0010:btrfs_free_reserved_data_space_noquota+0xfd/0x160 [btrfs]
>> Call Trace:
>> btrfs_free_reserved_data_space+0x4f/0x70 [btrfs]
>> __btrfs_prealloc_file_range+0x378/0x470 [btrfs]
>> elfcorehdr_read+0x40/0x40
>> ? elfcorehdr_read+0x40/0x40
>> ? btrfs_commit_transaction+0xca/0xa50 [btrfs]
>> ? dput+0xb4/0x2a0
>> ? btrfs_log_dentry_safe+0x55/0x70 [btrfs]
>> ? btrfs_sync_file+0x30e/0x420 [btrfs]
>> ? do_fsync+0x38/0x70
>> ? __x64_sys_fdatasync+0x13/0x20
>> ? do_syscall_64+0x5b/0x1b0
>> ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> ---[ end trace 70ccb5d0fe51151c ]---
>>
>> This happens if we fail to insert our reserved file extent.  At this
>> point we've already converted our reservation from ->bytes_may_use to
>> ->bytes_reserved.  However once we break we will attempt to free
>> everything from [cur_offset, end] from ->bytes_may_use, but our extent
>> reservation will overlap part of this.
>>
>> Fix this problem by adding ins.offset (our extent allocation size) to
>> cur_offset so we remove the actual remaining part from ->bytes_may_use.
> This contradicts the code, you are adding ins.objectid which is the
> offset and not the size. This means either the code is buggy.

Ooops you're right, I was getting lucky because we're making the whole 
allocation at once, and ins.objectid was past extent_end so we ended up doing 
the right thing, but for the wrong reasons.  In fact I need to adjust this for 
the other error condition, so I'll fix this up.  Thanks,

Josef
