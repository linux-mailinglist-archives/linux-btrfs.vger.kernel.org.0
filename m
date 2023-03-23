Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9403B6C695A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCWNSG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 23 Mar 2023 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCWNSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 09:18:05 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C5C5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 06:18:04 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c29so10214171lfv.3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 06:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679577482;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omeepuzGEekd+0DUhsmFHFUb0anAnJEXChN3e4aPK08=;
        b=LTBy0Sw31sTzTfGYoRdjrjWv0zcvDA3XI1nsftYccoIYBFismeXhwNrInosb7XXgcX
         ReYvpThiPtHQWpzjcnbQPoR7aGGhLNc0+SKQGOeLuHRN8xsZx+rq30wzyuQyzcc3tlvi
         2pFHT/SsrXvf0AGfdvaTmFsXoXClc1Uet0e8bPhag+hp2LV0gJnoQxSMTQOuZdKleX7W
         14y1Zm8jVCeQXTMd6Mpq2/Vzd3+qiKlYlweoOkV33cH85vAfJlUB8wk4jijgQGLkiAsI
         xcMF4tb2YxZt8bq23aqePCmi5iXPWmR3Jrz6VbUERC2OZQnbF+F7kwLczucAjoXjymmL
         sCXw==
X-Gm-Message-State: AO0yUKXJcvfMDOOr2pYhU6vkqAIze8F9IvMSY8hkOD+rMPZtKHsmUVpB
        sQrqwXwKkcqZwA4Or/Px7LA=
X-Google-Smtp-Source: AK7set+XegxlfRhRTlBzRjZDsn+Wp7APeqp6gy7fEI7PxIy0jIupjdQ9XOOoX6SeuS8Cmxmrel4V+Q==
X-Received: by 2002:a05:6512:b08:b0:4d8:86c1:4782 with SMTP id w8-20020a0565120b0800b004d886c14782mr1681440lfu.23.1679577482147;
        Thu, 23 Mar 2023 06:18:02 -0700 (PDT)
Received: from smtpclient.apple ([2600:4040:7d3b:c500:707e:7adb:36c4:a4c7])
        by smtp.gmail.com with ESMTPSA id u9-20020a2e8449000000b00293534d9760sm3013502ljh.127.2023.03.23.06.18.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2023 06:18:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Kernel panic due to stack recursion when copying data from a
 damaged filesystem
From:   David Ryskalczyk <david@rysk.us>
In-Reply-To: <ZBwJQcvt2TcqoCRh@infradead.org>
Date:   Thu, 23 Mar 2023 09:17:49 -0400
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2F36C097-7549-49D8-8C70-C254A93FAC74@rysk.us>
References: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
 <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
 <ZBwC7n9crUsk4Pfi@infradead.org>
 <9628f5a7-2752-4f74-70e1-f8efd345bdc7@gmx.com>
 <ZBwJQcvt2TcqoCRh@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> On Mar 23, 2023, at 3:42 AM, Christoph Hellwig <hch@infradead.org> wrote:

> What is interesting above is that it tries to recover from 4 mirrors,
> which seems very unusual.  I wonder if something went wrong
> in btrfs_read_extent_buffer or btrfs_num_copies.

This filesystem has metadata set to raid1c4, so 4 mirrors would be expected.
All mirrors likely have identical damage, as the cause of the corruption was RAM issues leading to bitflips.


> On Mar 23, 2023, at 4:09 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Thu, Mar 23, 2023 at 03:57:57PM +0800, Qu Wenruo wrote:
>> It's metadata, but that's not the cause of the stack recursion.
>> 
>> If you go with the frames with certainty, the stack would look like this:
>> 
>> btrfs_search_slot (fs/btrfs/ctree.c:2225) btrfs
>> btrfs_lookup_csum (fs/btrfs/file-item.c:221) btrfs
>> btrfs_lookup_bio_sums (fs/btrfs/file-item.c:315 fs/btrfs/file-item.c:484)
>> btrfs
>> btrfs_submit_data_read_bio (fs/btrfs/inode.c:2787) btrfs
>> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
>> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
>> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
>> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
>> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
>> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
>> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
>> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
>> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
>> ...
>> 
>> Thus it's still data repair path causing the stack recursion, the metadata
>> is just the unfortunately one triggered it.
> 
> I still think it is a similar issue, and endless recursion trying
> to call back into repair without ever breaking out of that loop.
> 
> The interesting reason is why we'll never hit the
> 
> if (failrec->this_mirror == failrec->failed_mirror) {
> 
> case and break out of the recursion.
> 
> Note that in 6.3-rc with the new repair code we'd at least not recurse,
> although I suspect that whatever causes this endless loop would still
> be present.
> 

