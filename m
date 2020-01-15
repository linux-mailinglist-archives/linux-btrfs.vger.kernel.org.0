Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCB13CC6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 19:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgAOSob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 13:44:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35118 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgAOSoa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 13:44:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so16696354qto.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2RHoALpSOBynXpORViIhOl08dHLfSffD2C1i3tQxb+8=;
        b=n9d8Nn2I0V+QTxBbsk1TxkermlqfaB2HRhY2jsu9ER96lWBJw1PY+6SmTMhGWWr4+V
         6opytIeUZEA7kPLu9I+ik6ZFcSUEXKi1Fr3OcVOOVRVA05swoL8e3qmFDHf8yC522jKN
         vuxwM9Tv3/qYt30UTTtGEoNnNNo6IblE6I8ueHDcVetYY7x3SMSr49S1axbus8JmASrY
         W9U9SXNxsEMw+MR+AXiUDdVVDdk/uo4uWA2pTZnPhIU1a30k6dd9tCty/IL0jKfHOeFs
         yR1yJqkZkXp2C0BBRdErjGBtqD9KSbDk6Vs7h+OIn5inK4Vnuiq7m9b7yNOBUWGqu+Rj
         BDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RHoALpSOBynXpORViIhOl08dHLfSffD2C1i3tQxb+8=;
        b=Uxg69V92Ewx4wCCdOHy1CvRkaZB2BJTunGX/OykNVn4j6YzOpXB6rmACGyuObNdyZE
         TtDvumRLoCo2NwFaF0B9qZ+vcBDqCRUW0+f7ck16IjL68JYw2iIekoIZchZKHth9eLTJ
         /z3pu3qo2kePDNhY+RY4RXd3i1cdbQ+Q7OCQEk2tzHdlEhVgRHHWSXsIRVgpjMxzzSdh
         5MtHG5wgU9y3hd1hKRWup7ePupkhoE7jTsT4181kJFceIad/KWa6jH6t0P4Xj3wypYJv
         1k/5CdGZeRC9xmdjzzvGkRUyYWo8pPdhWMrCRMTEs+qu40LTT1tqMTp2rXznJJ3JbzPp
         4iuQ==
X-Gm-Message-State: APjAAAV4jTAhbcY2OIc80OkfFWkW94eO/cGMfkICliwaO8+RxuEbZ04H
        UHS1neSyLG8u4drq2vOON4XhBg==
X-Google-Smtp-Source: APXvYqwd43VSSNau3QNirei5kubeSidRBMupqsDZCXgFj+YAyIy1woiaU6KsBSMYrd/h247vrlSLtw==
X-Received: by 2002:ac8:4504:: with SMTP id q4mr4983570qtn.319.1579113869191;
        Wed, 15 Jan 2020 10:44:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::56ca])
        by smtp.gmail.com with ESMTPSA id s20sm8822067qkg.131.2020.01.15.10.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:44:28 -0800 (PST)
Subject: Re: [PATCH 0/5][v2] btrfs: fix hole corruption issue with !NO_HOLES
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <20200107194237.145694-1-josef@toxicpanda.com>
 <CAL3q7H78JUt0WJCXvzdgatU8fFkdWY0r1Yw0qKn0KYLg+KnqRQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ba1e7d7e-0593-8cbc-05de-aca98fead705@toxicpanda.com>
Date:   Wed, 15 Jan 2020 13:44:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H78JUt0WJCXvzdgatU8fFkdWY0r1Yw0qKn0KYLg+KnqRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/20 12:32 PM, Filipe Manana wrote:
> On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> v1->v2:
>> - fixed a bug in 'btrfs: use the file extent tree infrastructure' that would
>>    result in 0 length files because btrfs_truncate_inode_items() was clearing the
>>    file extent map when we fsync'ed multiple times.  Validated this with a
>>    modified fsx and generic/521 that reproduced the problem, those modifications
>>    were sent up as well.
>> - dropped the RFC
>>
>> ----------------- Original Message -----------------------
>> We've historically had this problem where you could flush a targeted section of
>> an inode and end up with a hole between extents without a hole extent item.
>> This of course makes fsck complain because this is not ok for a file system that
>> doesn't have NO_HOLES set.  Because this is a well understood problem I and
>> others have been ignoring fsck failures during certain xfstests (generic/475 for
>> example) because they would regularly trigger this edge case.
>>
>> However this isn't a great behavior to have, we should really be taking all fsck
>> failures seriously, and we could potentially ignore fsck legitimate fsck errors
>> because we expect it to be this particular failure.
>>
>> In order to fix this we need to keep track of where we have valid extent items,
>> and only update i_size to encompass that area.  This unfortunately means we need
>> a new per-inode extent_io_tree to keep track of the valid ranges.  This is
>> relatively straightforward in practice, and helpers have been added to manage
>> this so that in the case of a NO_HOLES file system we just simply skip this work
>> altogether.
>>
>> I've been hammering on this for a week now and I'm pretty sure its ok, but I'd
>> really like Filipe to take a look and I still have some longer running tests
>> going on the series.  All of our boxes internally are btrfs and the box I was
>> testing on ended up with a weird RPM db corruption that was likely from an
>> earlier, broken version of the patch.  However I cannot be 100% sure that was
>> the case, so I'm giving it a few more days of testing before I'm satisfied
>> there's not some weird thing that RPM does that xfstests doesn't cover.
>>
>> This has gone through several iterations of xfstests already, including many
>> loops of generic/475 for validation to make sure it was no longer failing.  So
>> far so good, but for something like this wider testing will definitely be
>> necessary.  Thanks,
> 
> So a comment that applies to the whole patchset.
> 
> On power failures we can now end up with non-prealloc extents beyond
> the disk_i_size after mounting the filesystem.
> 
> Not entirely sure if it will give any potential problems other then
> non-reclaimed space for a long time (unless the file is truncated or
> written to or beyond the extent's offset), have you tested this
> scenario?
> 
> I suppose the test cases from fstests that use dm's log writes target
> exercise this easily.
> 

Yeah I've run it through xfstests a bunch and none of the log writes things blew up.

Keep in mind that this scenario can already happen, just not as easily.  The 
original btrfs_ordered_update_i_size() would only update i_size if the previous 
ordered extent had completed.  If it hadn't you would end up with a normal 
extent past i_size, and if you crashed at the right time you would be in this 
spot.  This patch only makes that case more likely to happen if you happen to do 
something like sync_file_range() in the middle of the dirty range.  Thanks,

Josef
