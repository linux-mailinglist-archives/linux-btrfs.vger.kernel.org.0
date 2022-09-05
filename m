Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423C25AC8AE
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiIECGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 22:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiIECF6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 22:05:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CB1C134
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 19:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662343539; x=1693879539;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5OBFEXkZyv++Ys9uG6f4UnqNH2cQ3CpT5s8Vbpex7SA=;
  b=N/KykghiFhgWnNv6v72YyJe9t7IQ+FXIlo8e/x+TcS6mHEFdEYvwe2+y
   0grVyR4LmDNd/O18CxqPlhLY0YlqGcrUsCNLY8zEM55k12HkWiV6VlzaW
   43yB8DIwDQ0q7bEf/yBiErW+vG4YxkEDbqd8hhUPydiQOMEZq8NtTW8fg
   OSQUWwh5/5zj5ALPn1SASJj4TV3mAYMbqgtac+Iy7g+YaKpVSnsM84p7w
   JwLZ0BK1L4qqww2mIsyv+E33LJH7k8p8FpslpdjHejl0HKFwQRIxn9GHG
   M+99q++9fnu7XUxrBYIxvRpuw7rRXE/gs6kCuqK0r3N5LuBHlkgN33U9u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="382589150"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="382589150"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 19:05:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="643624020"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.208.118]) ([10.254.208.118])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 19:05:15 -0700
Subject: Re: [kbuild-all] Re: [PATCH PoC 1/9] btrfs: introduce
 BTRFS_IOC_SCRUB_FS family of ioctls
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
 <202209031916.ybFIwbdf-lkp@intel.com>
 <c456663a-3c92-1ba8-2524-508d8bf7d0b5@gmx.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <9b0d8c67-5c72-7211-41c8-84618de3344a@intel.com>
Date:   Mon, 5 Sep 2022 10:05:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c456663a-3c92-1ba8-2524-508d8bf7d0b5@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/3/2022 7:55 PM, Qu Wenruo wrote:
> 
> 
> On 2022/9/3 19:47, kernel test robot wrote:
>> Hi Qu,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on kdave/for-next]
>> [also build test ERROR on linus/master v6.0-rc3 next-20220901]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    
>> https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-introduce-a-new-family-of-ioctl-scrub_fs/20220903-162128 
>>
>> base:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
>> config: x86_64-randconfig-a004 
>> (https://download.01.org/0day-ci/archive/20220903/202209031916.ybFIwbdf-lkp@intel.com/config) 
>>
>> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>> reproduce (this is a W=1 build):
>>          # 
>> https://github.com/intel-lab-lkp/linux/commit/8f7e2c15c08dc87518d12529e5b5cba0a42b5eb1 
>>
>>          git remote add linux-review 
>> https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review 
>> Qu-Wenruo/btrfs-scrub-introduce-a-new-family-of-ioctl-scrub_fs/20220903-162128 
>>
>>          git checkout 8f7e2c15c08dc87518d12529e5b5cba0a42b5eb1
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from <command-line>:
>>>> ./usr/include/linux/btrfs.h:329:15: error: expected declaration 
>>>> specifiers or '...' before 'sizeof'
>>       329 | static_assert(sizeof(struct btrfs_scrub_fs_progress) == 256);
>>           |               ^~~~~~
>>
> Hi LKP guys,
> 
> Is this a false alert from your tools?
> 
> This seems solid to me, and my compiler doesn't give me any error about
> this...

Hi Qu,

Sorry for the noise, if you can't reproduce it with the linked config, 
it's possible that the bot applied the patchset to a wrong base branch.

 
https://download.01.org/0day-ci/archive/20220903/202209031916.ybFIwbdf-lkp@intel.com/config 


Best Regards,
Rong Chen

> 
> Thanks,
> Qu
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
