Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE527B474
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1S2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgI1S2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:28:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8FC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:28:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c18so1549110qtw.5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=euQIOrsi9FPVEvCIjs63tukkQEoGirlCzRtpjIQcx48=;
        b=T3i02tRj0XjXye48OqltGkYyAU7GYEuofUzzug/cF01sKibAX4XywDkALBpR1PQDbq
         m5tVLX7eKsc5n79VFXFna1WQ5xUURExgCCOfawu+x5/z9iMPPj3fG9QMQfKDT0m2BzNQ
         lxLHAYVvZfh/0Yh3YlOSva2p2vKMcvsm0ydzhcyKds+7D5I78vXWZdBx4IvhNxsILmP0
         MX/fxRY91VZcHxSFeixlSpJDr8SNzYvYODXYGpc1rDgzod5JvdcNnqX5l7ydna2Y3Bt/
         C2KRbzEV3CVbYDa9+JR77tn/M12uer8WGQX/9CIKCx3u7OUw4oJYG1TYNOVhq5n4Ou/C
         Qodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euQIOrsi9FPVEvCIjs63tukkQEoGirlCzRtpjIQcx48=;
        b=PE1x75kvQmospp0GeLnEvOAC8+4lPulTGE9uKFudROgQOSjs8DBvE1f42Ezs5vcxfS
         Iy1ixZiKMIGiL6wcvZDUfDXLz1LtJM0Kp76vmIn0eGkv/bcQ3h2cBUftyHhFRgvmfqyR
         HBtgSRWdZZ22FP5JPfiiSI7jo1+qQQHRpEmnKHm4IW+BFUaxOuEPn91N3Wk3AbI3Ke4g
         H0WBXM+pF3ePIWdAJhq5TkKbybktk7A0hAV0sbAObPf8uldQg7R2LsEUMqIMOOCfwodd
         LTH1r1LWQ2My8S8Q4h5O8/VB3ChTXkamoTrxfGjSMpkyzVS/Y1aDvVuYT0bpPEAapJeJ
         O7nw==
X-Gm-Message-State: AOAM53143eTrY57Jupvps5T+dBdZEKhdJhZ888rBsEWwLZtne0+jbtbW
        QdwepgXWzGNNdePVXUi+AnEL9Q==
X-Google-Smtp-Source: ABdhPJyb79XaaVBLLb+AeFvhxIvgjI2uNgfdNbdwATlMsHjodrWxKPBKxzRdMy/hZANX+G8BUhIugg==
X-Received: by 2002:ac8:743:: with SMTP id k3mr3038102qth.182.1601317713464;
        Mon, 28 Sep 2020 11:28:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 25sm1896767qks.41.2020.09.28.11.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 11:28:32 -0700 (PDT)
Subject: Re: [PATCH 2/5] btrfs: push the NODATASUM check into
 btrfs_lookup_bio_sums
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
 <bdf1bf5c65679fdf39021e16a242094acd71b270.1600961206.git.josef@toxicpanda.com>
 <a3d17402-7e3d-7fb4-9831-2db5be18d5b2@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d208801b-01cd-9b81-a666-b4fa910c6a8e@toxicpanda.com>
Date:   Mon, 28 Sep 2020 14:28:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <a3d17402-7e3d-7fb4-9831-2db5be18d5b2@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/20 8:39 PM, Qu Wenruo wrote:
> 
> 
> On 2020/9/24 下午11:32, Josef Bacik wrote:
>> When we move to being able to handle NULL csum_roots it'll be cleaner to
>> just check in btrfs_lookup_bio_sums instead of at all of the caller
>> locations, so push the NODATASUM check into it as well so it's unified.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> But an off-topic question inlined below:
> 
>> ---
>>   fs/btrfs/compression.c | 14 +++++---------
>>   fs/btrfs/file-item.c   |  3 +++
>>   fs/btrfs/inode.c       | 12 +++++++++---
>>   3 files changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index eeface30facd..7e1eb57b923c 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -722,11 +722,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>>   			 */
>>   			refcount_inc(&cb->pending_bios);
>>   
>> -			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>> -				ret = btrfs_lookup_bio_sums(inode, comp_bio,
>> -							    (u64)-1, sums);
>> -				BUG_ON(ret); /* -ENOMEM */
> 
> Is it really possible to have compressed extent without data csum?
> Won't nodatacsum disable compression?
> 
> Or are we just here to handle some old compressed but not csumed data?
> 

We used to allow it, so I'm content to leave this here.  Maybe at some point 
we'll allow it in the future, but IDK it doesn't hurt anything to handle it 
here.  Thanks,

Josef
