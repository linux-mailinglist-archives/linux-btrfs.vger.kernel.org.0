Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965EC5ABED3
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiICL4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiICL4L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 07:56:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581BB120AF
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662206144;
        bh=0xnduJu62wZdE0wYcSNo92/ogLy4z9DBH3yNGoortjk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YJjFtgt5Bc6/d3NXDbb9Zw1ugkPCeq7CKjMD9I7W4t4OYoznysb3Cz0Q8klpbN60G
         oKIUiJ4tqR0bLKpJHqQTfhKLc/3DOnCLTQ7TEaHTskR+g6kSC7zRjaHjTRRD+OjljR
         rMHd0ZS2wojHkB7eMSXtfuoMtWpl8pavZVhc3eb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1p5iRK2sa9-00btxN; Sat, 03
 Sep 2022 13:55:44 +0200
Message-ID: <c456663a-3c92-1ba8-2524-508d8bf7d0b5@gmx.com>
Date:   Sat, 3 Sep 2022 19:55:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH PoC 1/9] btrfs: introduce BTRFS_IOC_SCRUB_FS family of
 ioctls
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
 <202209031916.ybFIwbdf-lkp@intel.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <202209031916.ybFIwbdf-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fOKBJSK28KfR1Wd7+UcFksunyhqmlmHMlCKS3wDldihxU1SG6Ro
 XUd256ZYPqXNlFLGcoGKCeIHPoiU+0ZgM8lOnkwRAbJlqpi4GXGmv5bkrbv9QvTIsX7pq0v
 GoWcEDuOUvWu4v1zqxYbNELWKS3dicfXb1VzPvX666gUw2Na6rpNyOLroZoChqdQ6u62trq
 OYnlEVCaVSmtimErRvrmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7WnJexawKmU=:6Kl5kH5YlPemBm6yugCASj
 Cno9fFFcyeJBA01YMT9vMeLPLwaQMnPpJ78+rRZco/ngR0NCREQoOR+RTXPYc1qEKKpB1iH7w
 0kmFI2rfzqX6NxkxVBYxJ/hMWjtSTOYf9mKkTGJ/U679U6fk+YOaa2KDQ3j5QQbxxFPKttHIY
 bUSXDRX3v5d2roDkSHgjiGX0D38CmiPnfgJWoOzyqi8KaPzDXqxcGug54gR5VL2HUCGhuxQDV
 kDjrJLimOzL+U7wrvQmah8+LhE1dpCzh/w1aS+xVe9uLK0C2kQFIGA3FL9U5x3heWq7JnQ5AV
 fWF2uno+4MpDdFXBeIOkwmHPJ59nCituFSfxf1yjqu/0WkTE2SFRqdH4BSZbm5D1zC1k7NET3
 qsY3fc/DlqbraQpl8BFZhm9mBUWLRvgKlISwmcaBLm+MGiVa9bGK61vQGhg9pL5Gj8lQ8bG8+
 Eo7EUHZUQqYIcOlU52f/czIlKi0jQ82mTiBzEDqm6q8tw18ryQIJerbGZnZYqIhThxGn0X/Nz
 n8e3eSB4TGVbQM9xMz2LKYOYnPEqMIC3avASE9PHUqv1s5pdrtC0gEPW+Cofysw9G0clp0Qw4
 qwlDTHnZXTqW3ZJtH4ESmr3cvtVBrOlR9UnljemG7EamMAJyTfRS7Z0WkTOuw59X/psiF6wzW
 hN+BXH5shnRDFyceAYCjWLmupbXGlfn70JQhA345hVTe0qsh2eHNoWyebg4hoj9Y9YmzUD/rN
 6H2O3jwOkBJ9w5nX+mJuaw7iFPImbSPIT93VB/AEcDqouGMYBGvugam/1KPvc/MhuQj5ksqdM
 qLQVb86WCiNuO4jl6Hu0CXXt6Kn+uWmXxogzmlODT8k0NTGPRJDXcBS2jni7O0fkzmS43A+mY
 8YlzbYPCrOLoozSSsrM3YkzQS+rGBn8B5APjfr4nJ0XwtJN5BOEtQE7uHlLTRmtAEBmQDoRNH
 8fwTJMDNZqRE8FPqVx1xGe61ymsTt6zRPsFfbIS5mJgti/mDcfosDYSpFg+QPJ6Hxvcl6CDEw
 jFNpO7LvOByQpULhC/XbA4h2CRoKLNt/0gqIT9pYF7qmlsBTF5qmfQrAEJocMgyFNhrKClAXz
 3SoUzXhCfUbW80u/vkijwpkwWlDb6b+7t5EaK4tQHvmbcQMLmFoPf6s9QfMBxvNgHl1rtE2GO
 HhnuRMIa90sUSQvM4PtuqzwKpv
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/3 19:47, kernel test robot wrote:
> Hi Qu,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on linus/master v6.0-rc3 next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-s=
crub-introduce-a-new-family-of-ioctl-scrub_fs/20220903-162128
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/=
20220903/202209031916.ybFIwbdf-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=3D1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/8f7e2c15c08dc87=
518d12529e5b5cba0a42b5eb1
>          git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
>          git fetch --no-tags linux-review Qu-Wenruo/btrfs-scrub-introduc=
e-a-new-family-of-ioctl-scrub_fs/20220903-162128
>          git checkout 8f7e2c15c08dc87518d12529e5b5cba0a42b5eb1
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from <command-line>:
>>> ./usr/include/linux/btrfs.h:329:15: error: expected declaration specif=
iers or '...' before 'sizeof'
>       329 | static_assert(sizeof(struct btrfs_scrub_fs_progress) =3D=3D =
256);
>           |               ^~~~~~
>
Hi LKP guys,

Is this a false alert from your tools?

This seems solid to me, and my compiler doesn't give me any error about
this...

Thanks,
Qu
