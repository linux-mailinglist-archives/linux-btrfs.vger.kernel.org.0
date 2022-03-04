Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57554CCF04
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 08:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiCDH11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 02:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiCDH10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 02:27:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3D4190C14;
        Thu,  3 Mar 2022 23:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646378786;
        bh=NqKXkVvUMT/lREd1TJUdLOp4Bmywa3tCtNWJu4vdkMU=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=QqKoz6n/DyNnLg1Ei47oIsK3eRW30mhB5WEJvDPNOI/qf33KsGdkMQG8yIenOKQRQ
         Kc2F6CwGhdlCHh8Yokvm+VZXtvp51uPtcy5ip6gqg/+awCeyQL2rGr1n+2Y5snX9mE
         PNHaWlZnbp2iH09MeKbXIu4f/XMd2YTJRaGhZWJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK0X-1oGUOO1o01-00rJHl; Fri, 04
 Mar 2022 08:26:26 +0100
Message-ID: <dbc84dd2-7e6d-95b0-d7bc-373f897a7063@gmx.com>
Date:   Fri, 4 Mar 2022 15:26:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, linux-btrfs@vger.kernel.org
References: <20220301063026.GB13547@xsang-OptiPlex-9020>
 <e55fb58e-bb3a-ce51-b485-6302415b34e4@gmx.com>
 <20220302084435.GA28137@xsang-OptiPlex-9020>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [btrfs] 3626a285f8: divide_error:#[##]
In-Reply-To: <20220302084435.GA28137@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cbta9nrwKme0kZIuJMRnVlotvlqkdK+oliL8I2taUrxgjjH+yRr
 2+W+68vpxfIQ+SnZ0vJSdkn2K9SP0+AVIT4GsDmk/x3cbIwtIggqUVbLdgLbDU1D2JBFPFu
 jdw7WVHARET4bGA68kzMM10GBn2Efu7erfWcLtKk9HMkktB12S/r3FSZrc7yoqGKAJ3obIk
 jrvkzfO9J57GiapuP1t5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:704TzK+CPPU=:78zdMtKNw3igfuKeI7QkaE
 z9SfLG2+Sznoc6dqyNhdQojaNGobPppAFzRtH2KUXScMopX2t3+34xTBL4TJQHX0MpC/5bDJ3
 uLKXh20CZptvFdCOyD0G+jq5ZpGY1YbcnsZ8n/At5VWfRs7vEo1ElSi+v60sKkSphKosonX/C
 cr414HvgkHJ8fFloFir/xN013juxtc6ag657HvdgGNd1EjNxd7l2XKU8zbXVUbEr1HrSAbkhc
 ppObh2Ikaj/ZYck+/nTY0tu32R1ZsqcHSnvgVV43zs5I++b9ggC7piOuE4Ks7kvOyHwKPrcRD
 EdGyDa1qwSjSzNTcOkWoFdTjlSUgXBzznbdr4kGMxxXvoI8eAfbJTUdLpDA595Dufk3G0ZMoC
 4U21QcyOAuRwrMv3DV28DFgqS09zaO3HaGlVR1Jbz5KF34I1jV3rt8NtJCzEZtjjtyS6b8ZN3
 CmOuPE4gslzhVJR/2ySv5+YgOFcRDvIepDeHkCg/6lQeQFpYs/UB6BMe1DDnmWP+G0xvl0XQa
 SV8DFujhouyuNtGVBAkkGFcF0PlFslc5ojZXzwMePn2wZFoPQba9SoEjhM2+G0gQecfzjhBrU
 fcX5bQqJh2FoxvZoUViLVOVH1mu7rqwrVJ5OYQrc+GgiyZhcWPNlDW29s+HDAB9Q4DVzhfiuj
 AKmM/S3GHGehyBs+NhxBqpA60ayJOYAJLCVN0KshxJFUGMJ55EYE/jm+15+augOgKbqOMTslX
 6DzxNeSgTkH01Ntg9jvROnLqwt2szd0cTEKloQfwE7k6oIPk3YtqzMvYcKleJ5LIayS3sgI8b
 edVh+1MwXhS2iVviD63VH+DEdi+9i9Xyudq2NYMOuxB2mOWWpoJ3e8JD4KkSsejqOwvz7FAub
 44zzN9u3SgakMPiEe5BYm5eeX9IK9fapSCOKldIgI4c6C3/ZGR+h58WnGZYRKIuWB7Ag3nFI/
 vq6HP/FQTrXF6bSy5Xis6ntQAYe4t3/Ae/X0r+zCeKJqtXwmhuSLRUtgxKIq+aH+JY5HzJBWW
 Yza2fwf9ivwsD8FCfUO8BUOp4/hnIIz2zi9iPGmQQWU3hzhqhp0FY5HTFfQ7QUFoKzHenIe2i
 bNCtedihW4njA4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/2 16:44, Oliver Sang wrote:
> Hi Qu,
>
> On Tue, Mar 01, 2022 at 03:47:38PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/3/1 14:30, kernel test robot wrote:
>>>
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 3626a285f87dceb4ca649d0ef015d7b295206cdf ("btrfs: introduce de=
dicated helper to scrub simple-stripe based range")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git maste=
r
>>>
>>> in testcase: xfstests
>>> version: xfstests-x86_64-1de1db8-1_20220217
>>> with following parameters:
>>>
>>> 	disk: 6HDD
>>> 	fs: btrfs
>>> 	test: btrfs-group-07
>>> 	ucode: 0x28
>>>
>>> test-description: xfstests is a regression test suite for xfs and othe=
r files ystems.
>>> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>>>
>>>
>>> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3=
.40GHz with 8G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire l=
og/backtrace):
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>> [   65.408303][ T3224] BTRFS info (device sdb2): flagging fs with big =
metadata feature
>>> [   65.415944][ T3224] BTRFS info (device sdb2): disk space caching is=
 enabled
>>> [   65.422842][ T3224] BTRFS info (device sdb2): has skinny extents
>>> [   65.436656][ T3224] BTRFS info (device sdb2): checking UUID tree
>>> [   66.134430][ T3293] BTRFS info (device sdb2): dev_replace from /dev=
/sdb3 (devid 2) to /dev/sdb6 started
>>> [   67.823326][ T3293] divide error: 0000 [#1] SMP KASAN PTI
>>> [   67.828668][ T3293] CPU: 3 PID: 3293 Comm: btrfs Not tainted 5.17.0=
-rc5-00101-g3626a285f87d #1
>>> [   67.837169][ T3293] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, =
BIOS A05 12/05/2013
>>> [ 67.844982][ T3293] RIP: 0010:scrub_stripe (kbuild/src/consumer/fs/bt=
rfs/scrub.c:3448 kbuild/src/consumer/fs/btrfs/scrub.c:3486 kbuild/src/cons=
umer/fs/btrfs/scrub.c:3644) btrfs
>>> [ 67.850976][ T3293] Code: 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 0=
c 11 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 27 09 00 00 41 8b =
5d 1c 99 <f7> fb 48 8b 54 24 30 48 c1 ea 03 48 63 e8 48 b8 00 00 00 00 00 =
fc
>>> All code
>>
>> This is weird, the code is from simple_stripe_full_stripe_len(), which
>> means the chunk map must be RAID0 or RAID10.
>>
>> In that case, their sub_stripes should be either 1 or 2, why we got 0 t=
here?
>>
>> In fact, from volumes.c, all sub_stripes is from btrfs_raid_array[],
>> which all have either 1 or 2 sub_stripes.
>>
>>
>> Although the code is old, not the latest version, it should still not
>> cause such problem.
>>
>> Mind to retest with my branch to see if it can be reproduced?
>> https://github.com/adam900710/linux/tree/refactor_scrub
>
> we tested head of this branch:
>    d6e3a8c42f2fad btrfs: scrub: rename scrub_bio::pagev and related memb=
ers
> and:
>    fdad4a9615f180 btrfs: introduce dedicated helper to scrub simple-stri=
pe based range
> on this branch.
>
> by attached config.
>
> still reproduce the same issue.
>
> attached dmesgs FYI.

Still failed to reproduce here.

Those btrfs/07[0123] tests are already in scrub/replace group, thus I
ran them almost hourly during the development.


Although there are some ASSERT()s doing extra sanity checks, they should
not affect the result anyway.

Thus I pushed a branch with more explicit BUG_ON()s to catch the
possible divide by zero bugs.
(https://github.com/adam900710/linux/tree/refactor_scrub_testing)

Mind to give it a try?

Thanks,
Qu

>
>
>>
>> Thanks,
>> Qu
>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>>      0:	00 00                	add    %al,(%rax)
>>>      2:	fc                   	cld
>>>      3:	ff                   	(bad)
>>>      4:	df 48 89             	fisttps -0x77(%rax)
>>>      7:	f9                   	stc
>>>      8:	48 c1 e9 03          	shr    $0x3,%rcx
>>>      c:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
>>>     10:	48 89 fa             	mov    %rdi,%rdx
>>>     13:	83 e2 07             	and    $0x7,%edx
>>>     16:	83 c2 03             	add    $0x3,%edx
>>>     19:	38 ca                	cmp    %cl,%dl
>>>     1b:	7c 08                	jl     0x25
>>>     1d:	84 c9                	test   %cl,%cl
>>>     1f:	0f 85 27 09 00 00    	jne    0x94c
>>>     25:	41 8b 5d 1c          	mov    0x1c(%r13),%ebx
>>>     29:	99                   	cltd
>>>     2a:*	f7 fb                	idiv   %ebx		<-- trapping instruction
>>>     2c:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
>>>     31:	48 c1 ea 03          	shr    $0x3,%rdx
>>>     35:	48 63 e8             	movslq %eax,%rbp
>>>     38:	48                   	rex.W
>>>     39:	b8 00 00 00 00       	mov    $0x0,%eax
>>>     3e:	00 fc                	add    %bh,%ah
>>>
>>> Code starting with the faulting instruction
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>      0:	f7 fb                	idiv   %ebx
>>>      2:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
>>>      7:	48 c1 ea 03          	shr    $0x3,%rdx
>>>      b:	48 63 e8             	movslq %eax,%rbp
>>>      e:	48                   	rex.W
>>>      f:	b8 00 00 00 00       	mov    $0x0,%eax
>>>     14:	00 fc                	add    %bh,%ah
>>> [   67.870187][ T3293] RSP: 0018:ffffc9000a71f450 EFLAGS: 00010246
>>> [   67.876028][ T3293] RAX: 0000000000000004 RBX: 0000000000000000 RCX=
: 0000000000000000
>>> [   67.883756][ T3293] RDX: 0000000000000000 RSI: 0000000000000004 RDI=
: ffff888129ec6d1c
>>> [   67.891491][ T3293] RBP: ffff8881453682a0 R08: 0000000000000001 R09=
: 0000000000000000
>>> [   67.899230][ T3293] R10: ffff88821534a063 R11: ffffed1042a6940c R12=
: ffff888121238000
>>> [   67.906955][ T3293] R13: ffff888129ec6d00 R14: ffff888145368000 R15=
: 0000000000000008
>>> [   67.914680][ T3293] FS:  00007f2851eb08c0(0000) GS:ffff8881a6d80000=
(0000) knlGS:0000000000000000
>>> [   67.923351][ T3293] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
>>> [   67.929709][ T3293] CR2: 00007ffea4ff07f8 CR3: 000000010a0fc005 CR4=
: 00000000001706e0
>>> [   67.937437][ T3293] DR0: 0000000000000000 DR1: 0000000000000000 DR2=
: 0000000000000000
>>> [   67.945163][ T3293] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7=
: 0000000000000400
>>> [   67.952891][ T3293] Call Trace:
>>> [   67.955992][ T3293]  <TASK>
>>> [ 67.958749][ T3293] ? kasan_save_stack (kbuild/src/consumer/mm/kasan/=
common.c:39)
>>> [ 67.963395][ T3293] ? kasan_set_track (kbuild/src/consumer/mm/kasan/c=
ommon.c:45)
>>> [ 67.967951][ T3293] ? kasan_set_free_info (kbuild/src/consumer/mm/kas=
an/generic.c:372)
>>> [ 67.972851][ T3293] ? mutex_unlock (kbuild/src/consumer/arch/x86/incl=
ude/asm/atomic64_64.h:190 kbuild/src/consumer/include/linux/atomic/atomic-=
long.h:449 kbuild/src/consumer/include/linux/atomic/atomic-instrumented.h:=
1790 kbuild/src/consumer/kernel/locking/mutex.c:178 kbuild/src/consumer/ke=
rnel/locking/mutex.c:537)
>>>
>>>
>>> To reproduce:
>>>
>>>           git clone https://github.com/intel/lkp-tests.git
>>>           cd lkp-tests
>>>           sudo bin/lkp install job.yaml           # job file is attach=
ed in this email
>>>           bin/lkp split-job --compatible job.yaml # generate the yaml =
file for lkp run
>>>           sudo bin/lkp run generated-yaml-file
>>>
>>>           # if come across any failure that blocks the test,
>>>           # please remove ~/.lkp and /lkp dir to run from a clean stat=
e.
>>>
>>>
>>>
>>> ---
>>> 0DAY/LKP+ Test Infrastructure                   Open Source Technology=
 Center
>>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corp=
oration
>>>
>>> Thanks,
>>> Oliver Sang
>>>
