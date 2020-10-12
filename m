Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0528AC4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgJLCwO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Oct 2020 22:52:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:8719 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJLCwN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Oct 2020 22:52:13 -0400
IronPort-SDR: SogkLglfTOI448c8gun46fRIloB7Tv+N0KPwHJF683WZ/+KKYfZiiQzDAXjxpcwrr38JvcAD2a
 4e+UOJEUbyIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145547481"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="145547481"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 19:52:12 -0700
IronPort-SDR: 3TnKVbPylH9BSwlAJH1Ov9Njiu7wLWib2Ho9gu9BPc1TY+o5+XOiq5utRuLPPVnNa1ctMk2mPQ
 /52wnoZJ6cWQ==
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="529769581"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 19:52:10 -0700
Subject: Re: [kbuild-all] Re: [PATCH] btrfs: fix devid 0 without a replace
 item by failing the mount
To:     Anand Jain <anand.jain@oracle.com>,
        kernel test robot <lkp@intel.com>,
        linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, josef@toxicpanda.com
References: <944e4246d4cfcb411b2bd09e941931ac7616e961.1601988987.git.anand.jain@oracle.com>
 <202010062208.6rn9cld4-lkp@intel.com>
 <9f78a512-5733-a44b-458e-0453a6a2b479@oracle.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <2358c0fe-3aa5-c395-eaca-8f6cddf86b9b@intel.com>
Date:   Mon, 12 Oct 2020 10:51:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f78a512-5733-a44b-458e-0453a6a2b479@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/7/20 10:07 AM, Anand Jain wrote:
> On 6/10/20 10:54 pm, kernel test robot wrote:
>> Hi Anand,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on kdave/for-next]
>> [also build test ERROR on v5.9-rc8 next-20201006]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url: 
>> https://github.com/0day-ci/linux/commits/Anand-Jain/btrfs-fix-devid-0-without-a-replace-item-by-failing-the-mount/20201006-210957
>> base: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git 
>> for-next
>> config: i386-randconfig-s001-20201005 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.2-201-g24bdaac6-dirty
>>          # 
>> https://github.com/0day-ci/linux/commit/ed4ebb4eb3f213f048ea5f6a2ed80f6bd728c9e1
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> Anand-Jain/btrfs-fix-devid-0-without-a-replace-item-by-failing-the-mount/20201006-210957
>>          git checkout ed4ebb4eb3f213f048ea5f6a2ed80f6bd728c9e1
>>          # save the attached .config to linux build tree
>>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' 
>> ARCH=i386
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     fs/btrfs/dev-replace.c: In function 'btrfs_init_dev_replace':
>>>> fs/btrfs/dev-replace.c:98:7: error: too few arguments to function 
>>>> 'btrfs_find_device'
>>        98 |   if (btrfs_find_device(fs_info->fs_devices,
>>           |       ^~~~~~~~~~~~~~~~~
>>     In file included from fs/btrfs/dev-replace.c:18:
>>     fs/btrfs/volumes.h:455:22: note: declared here
>>       455 | struct btrfs_device *btrfs_find_device(struct 
>> btrfs_fs_devices *fs_devices,
>>           |                      ^~~~~~~~~~~~~~~~~
>>     fs/btrfs/dev-replace.c:161:7: error: too few arguments to 
>> function 'btrfs_find_device'
>>       161 |   if (btrfs_find_device(fs_info->fs_devices,
>>           |       ^~~~~~~~~~~~~~~~~
>>     In file included from fs/btrfs/dev-replace.c:18:
>>     fs/btrfs/volumes.h:455:22: note: declared here
>>       455 | struct btrfs_device *btrfs_find_device(struct 
>> btrfs_fs_devices *fs_devices,
>>           |                      ^~~~~~~~~~~~~~~~~
>>
>
>  Is there is a way to mention the patch dependencies, so that 0-Day 
> tests would understand. As in the patch's changelog, two dependent 
> patches [1] aren't in the misc-next yet.
>
> [1]
> https://patchwork.kernel.org/patch/11818635
> https://patchwork.kernel.org/patch/11796905

HI Anand,

The '--base' option in git format-patch may help, from man git format-patch:

BASE TREE INFORMATION
        The base tree information block is used for maintainers or third 
party testers to know the exact state the patch series applies to. It 
consists of the base commit, which is a well-known commit that is part 
of the stable part of the project history everybody else works
        off of, and zero or more prerequisite patches, which are 
well-known patches in flight that is not yet part of the base commit 
that need to be applied on top of base commit in topological order 
before the patches can be applied.

        The base commit is shown as "base-commit: " followed by the 
40-hex of the commit object name. A prerequisite patch is shown as 
"prerequisite-patch-id: " followed by the 40-hex patch id, which can be 
obtained by passing the patch through the git patch-id --stable
        command.

        Imagine that on top of the public commit P, you applied 
well-known patches X, Y and Z from somebody else, and then built your 
three-patch series A, B, C, the history would be like:

            ---P---X---Y---Z---A---B---C

        With git format-patch --base=P -3 C (or variants thereof, e.g. 
with --cover-letter or using Z..C instead of -3 C to specify the range), 
the base tree information block is shown at the end of the first message 
the command outputs (either the first patch, or the cover
        letter), like this:

            base-commit: P
            prerequisite-patch-id: X
            prerequisite-patch-id: Y
            prerequisite-patch-id: Z

        For non-linear topology, such as

            ---P---X---A---M---C
                \         /
                 Y---Z---B

        You can also use git format-patch --base=P -3 C to generate 
patches for A, B and C, and the identifiers for P, X, Y, Z are appended 
at the end of the first message.

        If set --base=auto in cmdline, it will track base commit 
automatically, the base commit will be the merge base of tip commit of 
the remote-tracking branch and revision-range specified in cmdline. For 
a local branch, you need to track a remote branch by git branch
        --set-upstream-to before using this option.

Best Regards,
Rong Chen
