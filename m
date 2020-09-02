Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070E825A24A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 02:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBAcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 20:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBAcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 20:32:41 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F79C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lOhKAjRnoFMpn1HuLThLVw8sWCS52X1cODHUdptJOGM=; b=f9fnSE4gZ0Jg3NLto7pYLmT6bD
        Cg3MXdPQE+CKid4LSUH4scgnZqmuTaBxqirJmsauw8Ekq0Sg53naECB9uJwtOKN5VQWYewj2QFLej
        PP/8D7i90TaJRBeeaxocYomtcEiYdTrWVC6yLp70IRiDJJT25QSuT2tTlKZRyWhLw3xI=;
Received: from 2403-5800-3100-142-511-51f7-ef2d-da34.ip6.aussiebb.net ([2403:5800:3100:142:511:51f7:ef2d:da34])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kDGhT-0008Jp-4E; Wed, 02 Sep 2020 10:32:31 +1000
Subject: Re: new database files not compressed
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
 <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <20200831161505.369be693@natsu>
 <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
 <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
Date:   Wed, 2 Sep 2020 10:32:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 6:55 pm, Hamish Moffatt wrote:
> On 1/9/20 3:15 pm, Nikolay Borisov wrote:
>>
>> On 1.09.20 г. 2:50 ч., Hamish Moffatt wrote:
>>> On 31/8/20 10:57 pm, Nikolay Borisov wrote:
>>>> This means the data being passed to btrfs is not compressible. I.e 
>>>> after
>>>> coompression the data is not smaller than the original, input data.
>>> It is though - if I copy it, or run defrag, it compresses very well:
>>>
>>>
>> As Zygo explained - with 16k writes you'd need at least 25% compression
>>   in order for btrfs to deem it useful. If firebird's 16k writes are not
>> 25% compressible then it won't compress. It also depends on whether it
>> issues fsync after every write to ensure consistency meaning it won't
>> allow more data to accumulate.

I've been able to reproduce this with a trivial test program which 
mimics the I/O behaviour of Firebird.

It is calling fallocate() to set up a bunch of blocks and then writing 
them with pwrite(). It seems to be the fallocate() step which is 
preventing compression.

Here is my trivial test program which just writes zeroes to a file. The 
output file does not get compressed by btrfs.


#define _GNU_SOURCE

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

#define BLOCK_SIZE 16384

int main()
{
     unlink("fill");
     int fd = open("fill", O_RDWR | O_CREAT | O_EXCL, 0666);

     char buf[BLOCK_SIZE];
     memset(buf, 0, BLOCK_SIZE);

     for (int count = 0; count < 256; ++count) {
         if (count % 8 == 0)
             fallocate(fd, 0, count * BLOCK_SIZE, 8 * BLOCK_SIZE);
         pwrite(fd, buf, BLOCK_SIZE, count * BLOCK_SIZE);
     }

     close(fd);

     return 0;
}


Hamish

