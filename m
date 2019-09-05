Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3AA9810
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 03:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfIEBgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 21:36:45 -0400
Received: from mail.windriver.com ([147.11.1.11]:35123 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIEBgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 21:36:45 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x851agER017249
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 4 Sep 2019 18:36:43 -0700 (PDT)
Received: from [128.224.162.188] (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Sep
 2019 18:36:35 -0700
Subject: Re: Bug?: unlink cause btrfs error but other fs don't
To:     Josef Bacik <josef@toxicpanda.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <49edadc4-9191-da89-3e3b-ca495f582a4d@windriver.com>
 <20190904104841.nrdocb7smfporu7m@macbook-pro-91.dhcp.thefacebook.com>
From:   "Hongzhi, Song" <hongzhi.song@windriver.com>
Message-ID: <853d3a5e-6e65-a7d8-df52-e293cad17600@windriver.com>
Date:   Thu, 5 Sep 2019 09:36:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904104841.nrdocb7smfporu7m@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.188]
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 9/4/19 6:48 PM, Josef Bacik wrote:
> On Wed, Sep 04, 2019 at 04:02:24PM +0800, Hongzhi, Song wrote:
>> Hi ,
>>
>>
>> *Kernel:*
>>
>>      After v5.2-rc1, qemux86-64
>>
>>      make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc
>>      use qemu to bootup kernel
>>
>>
>> *Reproduce:*
>>
>>      There is a test case failed on btrfs but success on other fs(ext4,ext3),
>> see attachment.
>>
>>
>>      Download attachments:
>>
>>          gcc test.c -o myout -Wall -lpthread
>>
>>          copy myout and run.sh to your qemu same directory.
>>
>>          on qemu:
>>
>>              ./run.sh
>>
>>
>>      I found the block device size with btrfs set 512M will cause the error.
>>      256M and 1G all success.
>>
>>
>> *Error info:*
>>
>>      "BTRFS warning (device loop0): could not allocate space for a delete;
>> will truncate on mount"
>>
>>
>> *Related patch:*
>>
>>      I use git bisect to find the following patch introduces the issue.
>>
>>      commit c8eaeac7b734347c3afba7008b7af62f37b9c140
>>      Author: Josef Bacik <josef@toxicpanda.com>
>>      Date:   Wed Apr 10 15:56:10 2019 -0400
>>
>>          btrfs: reserve delalloc metadata differently
>>          ...
>>
>>
> I meant to reply to this but couldn't find the original thread.  The patches I
> wrote for this merge window were to address this issue.  Thanks,
>
> Josef


Ok, thank your, I will try to search them.

--Hongzhi


>
