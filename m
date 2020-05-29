Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D621E8B72
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 00:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgE2Wjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 18:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE2Wjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 18:39:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16FEC03E969
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 15:39:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t8so2045709pju.3
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=;
        b=nH1QiA+IRSDYm41wzzYncwFaM+lrDNn8Ti2XFcAi4YlaUw9LztwixK0pLNSdeHIyB7
         8bS61hIRSiOulx1iuyKF9nP4gpzLATvREps1+Y8sUHCTsMZ0rY+c1fgY5DukBD+Uegin
         1lLKtDr7RDXHpyWblpi+B9d4Ujuc4xdGVonklbCjbzvYQPtHToJufcxLYyR+p+Kh98lg
         7xb/aOq4xXK0qPSUlE/HFQp1mG3daOYUEb9TuOa7ktkFpy+7p82qFHo7IYkgx6GUZGuH
         8zk1bdAi4lwNOoqsXYgm3MyTYkenX/Q/gJXp2zUQOgLiLCvj9OzabgNt4M4CpTJUiGsP
         5U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3SvGI6+FW1/OhXjcYh+qu+PkvAZr4CU1sl+aHPi5BkI=;
        b=tZCEARMeNDH2WV8qFrQbxRK3IujgA+hgGcQVddSFPs2yjDngQARZC7+4fIAwxZaWWd
         WMfBOocv/V1YDTuuRILDplF7AoSYRYTCfHF52o5QQo+XbSE+M6Ca6ZNSwfxjuZs6yDlU
         A5WXdeK7bhyLeElRrKp0WNzjm/prU4/trMVcp4uqfoFsjX+JcTGbjjcLGMZTHZ1puPKO
         pk1n2TQoYzE4ccCxe+e/CKXCBbHzo5VtT0hVD+yla3qlWaw8QE+ZkPVo+S4SfsPMG4n+
         iSRR6xNH8lRNIJdmlTqlS2ogc2BCO2GO8Ev/D1Qt1u6tziuBhg+xfQFZ512qm2gwECxT
         GyDw==
X-Gm-Message-State: AOAM531svyH2KhqdZtlRAJ6HSH/+GV++aeBgbP7lZcootHCkca8hjQgC
        F3JqC+RBx8AvyK5T+v+FE2p9xA==
X-Google-Smtp-Source: ABdhPJx+EbTbp9drKjVT1SBrBX1rRMhZ6tJHpQZ+IXg2BZcRTR0vnvD5aHP3y5FWcW+eFbCDEyco7w==
X-Received: by 2002:a17:90a:68cd:: with SMTP id q13mr11465889pjj.177.1590791970211;
        Fri, 29 May 2020 15:39:30 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m22sm374695pjv.30.2020.05.29.15.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 15:39:29 -0700 (PDT)
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
To:     Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     hch@lst.de, sth@linux.ibm.com, viro@zeniv.linux.org.uk, clm@fb.com,
        jaegeuk@kernel.org, hch@infradead.org, mark@fasheh.com,
        dhowells@redhat.com, balbi@kernel.org, damien.lemoal@wdc.com,
        ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, deepa.kernel@gmail.com
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <20200529202713.GC19604@bombadil.infradead.org>
 <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0fc36e-fa67-a6b9-cc7a-d86d3f21cf2c@kernel.dk>
Date:   Fri, 29 May 2020 16:39:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/29/20 4:27 PM, Bart Van Assche wrote:
> On 2020-05-29 13:27, Matthew Wilcox wrote:
>> On Fri, May 29, 2020 at 10:11:00PM +0800, Kaitao Cheng wrote:
>>> There is a function named ilog2() exist which can replace blksize.
>>> The generated code will be shorter and more efficient on some
>>> architecture, such as arm64. And ilog2() can be optimized according
>>> to different architecture.
>>
>> We'd get the same benefit from a smaller patch with just:
>>
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1502,15 +1502,9 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>>  	return !(addr & alignment) && !(len & alignment);
>>  }
>>  
>> -/* assumes size > 256 */
>>  static inline unsigned int blksize_bits(unsigned int size)
>>  {
>> -	unsigned int bits = 8;
>> -	do {
>> -		bits++;
>> -		size >>= 1;
>> -	} while (size > 256);
>> -	return bits;
>> +	return ilog2(size);
>>  }
>>  
>>  static inline unsigned int block_size(struct block_device *bdev)
> 
> Hi Matthew,
> 
> I had suggested to change all blksize_bits() calls into ilog2() calls
> because I think that a single function to calculate the logarithm base 2
> is sufficient.

I think this should be a two-parter:

1) Use the inode blkbits where appropriate
2) Then do this change

I'm leaning towards just doing it in blksize_bits() instead of updating
every caller, unless there aren't that many left once we've gone
through patch 1.

-- 
Jens Axboe

