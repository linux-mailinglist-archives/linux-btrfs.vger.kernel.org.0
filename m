Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4DE2F4438
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jan 2021 07:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbhAMGAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jan 2021 01:00:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:22208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMGAJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jan 2021 01:00:09 -0500
IronPort-SDR: WFA/We/XhjR2iICuhamEyirbxyrHmc9lZgfPUnuPPGM2o1y7ico9wNYkg/ypLurQF6B5EL+DHD
 YuCf8zFc3chQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157336076"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="157336076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 21:58:23 -0800
IronPort-SDR: 00jdNjGlZmk0NfEWCPA7W7mk3N5yP1gamiM4n7U/LWJqVLnRU0n2p0jiRDIUHha+IhNN08wyEZ
 TYGNaxV9fyuw==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="381717481"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.30.69]) ([10.255.30.69])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 21:58:20 -0800
Subject: Re: [LKP] Re: [btrfs] e076ab2a2c: fio.write_iops -18.3% regression
To:     dsterba@suse.cz, kernel test robot <oliver.sang@intel.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        linux-btrfs@vger.kernel.org
References: <20210112153614.GA2015@xsang-OptiPlex-9020>
 <20210112154529.GT6430@twin.jikos.cz>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <979aee28-c603-a187-e03f-29957c7b94d6@linux.intel.com>
Date:   Wed, 13 Jan 2021 13:58:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210112154529.GT6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1/12/2021 11:45 PM, David Sterba wrote:
> On Tue, Jan 12, 2021 at 11:36:14PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -18.3% regression of fio.write_iops due to commit:
>>
>>
>> commit: e076ab2a2ca70a0270232067cd49f76cd92efe64 ("btrfs: shrink delalloc pages instead of full inodes")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>
>> in testcase: fio-basic
>> on test machine: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
>> with following parameters:
>>
>> 	disk: 1SSD
>> 	fs: btrfs
>> 	runtime: 300s
>> 	nr_task: 8
>> 	rw: randwrite
>> 	bs: 4k
>> 	ioengine: sync
>> 	test_size: 256g
> Though I do a similar test (emulating bit torrent workload), it's a bit
> extreme as it's 4k synchronous on a huge file. It always takes a lot of
> time but could point out some concurrency issues namely on faster
> devices. There are 8 threads possibly competing for the same inode lock
> or other locks related to it.
>
> The mentioned commit fixed another perf regression on a much more common
> workload (untgrring files), so at this point drop in this fio workload
> is inevitable.

Do you have a plan to fix it? Thanks.
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

-- 
Zhengjun Xing

