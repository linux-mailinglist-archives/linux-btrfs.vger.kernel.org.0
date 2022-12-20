Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770E765177A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 01:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiLTA5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 19:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiLTA4z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 19:56:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A917895;
        Mon, 19 Dec 2022 16:56:07 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1oZChT3riX-00aiHv; Tue, 20
 Dec 2022 01:55:55 +0100
Message-ID: <4a8ce34a-c3b3-fda5-8f53-afdac7c5e05f@gmx.com>
Date:   Tue, 20 Dec 2022 08:55:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221216065121.30181-1-wqu@suse.com> <Y6Ch1Qq9op2tmB1U@magnolia>
 <Y6Cz+trxF6JtubwN@mit.edu> <97c625a9-3b5a-c3ae-d69f-cfb71266cd30@gmx.com>
 <Y6D4dUS0Idb2XGYJ@mit.edu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fstests: report: always save the dmesg as system-err if
 KEEP_DMESG is set
In-Reply-To: <Y6D4dUS0Idb2XGYJ@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:y+asaVPFIr1ea9ht8my58gFG/TG03igWMmNm33sDNCJwc/q6Tir
 nhxK3MCRs5JhlIVy2BTLFsPgPgo046qrRo8/kqzR2XYvxmytX5tZTP/M247mev3phujTgZF
 QXzt+RVFXzHZ3PSwzu6hl/4JjpV5VRwfEqp11P7u/99G5J08ZL7iqi1H/ZgZfnb90Kx5/TK
 njB66kC/+5bV+AIhFxf9Q==
UI-OutboundReport: notjunk:1;M01:P0:3ZL7qYdUC0c=;ES/fdGX3AM/dDZTESr13Gwt9+8D
 J8GtdF5KIvvVnER7VGngbidb8dh3F9R7YrELvytWzxtc4oUXypzIWa+KFwoLq2dUHLOh4HSTE
 pQFhLs06DsE9m3/xyhqamQ2Ld23odRpyMzBr5AmX0jrVNk6kpZvSiVdbia9WQWtOnRqXMkL4G
 6kp9r5iQ23twOFmKBLYGJslbEETLwnrFqZpyPqZtJdo9gaMfxzBwsmhdaJWarCUywSWuc1MLI
 CB5GC8M1yfEYiuN7KRXHDCMX3jJKvrGGj/wC1ISSzdYD8VUALq9PZJiJT8oHy7kEy+4mx1WQs
 7vckTj2ZiYZ1LkGK/ZqnM800RWD7NZV6LEPGVmtPT5YV52hAowxwhxp5QUWmNb/eVnzDisBI8
 Q0zkq2Ggft2yjGi41Bfqa/y4kzircQutHphyLndS1QO2VGCH7fpaVlK6SAz7jPm0vQd3IHSpZ
 Ing7DL/mZm3nLwLzkgAR9Lodn8494lsTqxQsr6qKbq3WGatSmmpNu3sySra0Ah3mxTJxuYciL
 UNEJrGAy5G2irBScyofkDZNw41KFwycN31EsAFUvnw2V30Gc6Ms1o+7iH+13yJ42yDRgRiOEw
 ZU+hJ9OduIDmr841l1yKGOgcM07lPea8TsvZQr7H0VuR23+T7DCPvq9p0gg+04l40kUojdAbQ
 kbMpX3A5m+DOKbi4PkswKJ1wBGEWnYAy/ANInHsEe9LsQE6NQchVAC0VqisEJ2e18cdXP4AYh
 JQKSpkXywAZOAVcAz68u4hw+xuwU7KrbuNhS4KOQTaD3HCHjYJbqTPRaf2SimMDKR7KvImu2U
 yZ5TKOHxJowfGZ8P/ju2FbX1vCO+z0sgWac9meuOikkE0+g2rwXRdUdyCZu0m8TxSoF9Qm/IC
 e65nDe8VyrQT881WisWHto6ueelwKj89edHyyCBdVfb/PNS8tAJRI46U5l0zX4kzt9jh7MofI
 sAzMZf8jdq0Ua7TAsEJj0gH0Gys=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/20 07:49, Theodore Ts'o wrote:
> On Tue, Dec 20, 2022 at 06:45:27AM +0800, Qu Wenruo wrote:
>>
>>
>> On the other hand, separating dmesg from its test cases means extra parsing
>> to bind the log section to certain test runs.
>>
>> In fact, I'm not even sure if possible to do that.
>> E.g. on the same host with different kernel/fstests configs.
> 
> Well, I just have my test runner framework drop a file which contains
> a single line[2] in the /etc/rsyslog.d directory, and then kill -HUP
> rsyslogd.  When I'm done, I'll reconfigure rsyslog and HUP it again,
> and then tar up the results directory, and save that as part of my
> test artifacts for that particular test run.
> 
> [2]   *.*;auth,authpriv.none		-/results/syslog
> 
> (This could probably be "kern.*" instead, but occasionally it's useful
> to see what other kind of background noise might be running on the
> test machine that might be disturbing the test run.)
> 
> The /results directory will contain a copy of the current kernel's
> build config file, the arguments to the xfstests run, the xfstests
> results directory with all of the NNN.full and NNN.out.bad files, and
> of course, the syslog file.  I also have things like a copy of
> /proc/slabinfo before and after the run; and I have support for hook
> scripts that can enable/disable ftrace with various tracepoints and
> which will drop the ftrace logs in the /results directory.  (I don't
> have support for drgn or BPF scripts yet, but one of these days...)
> 
> Anyway, my test framework will compress the /results directory and
> save it away (in my case, in Google Cloud Store).  For a full ext4
> test run (twelve "-g auto" runs with different fs configs), the
> compressed test artifact tarball will be about 23 megabytes.  In
> contrast, the xunut-quiet XML file will be about 80k compressed, and
> the test run summary which lands in my e-mail inbox is less than 4k. :-)
> 
> 	      	       	  	 - Ted
> 
> P.S.  This is a recent test run on btrfs using my test environment.
> I'm curious whether any of these test failures look familiar to you.
> (Some of them may very well be issues in how I set up the btrfs pool
> of block devices, which is a relatively new feature in gce-xfstests.
> What are you seeing when you run -g auto on btrfs using the default
> file system config?)
> 
> TESTRUNID: tytso-20221212170803
> KERNEL:    kernel 6.1.0-xfstests #2 SMP PREEMPT_DYNAMIC Mon Dec 12 16:09:40 EST 2022 x86_64
> CMDLINE:   -c btrfs/4k -g auto
> CPUS:      2
> MEM:       7680
> 
> btrfs/4k: 953 tests, 21 failures, 176 skipped, 12135 seconds

That's way more errors than what we see.

Currently what we expect is, at most 3 from btrfs, zero from generic:

- btrfs/011
   If your SSD is too fast, that balance is done before canceling, it can
   caused output mismatch.
   Always reproducible here if using cache=unsafe for VM.

- btrfs/219 (already in your failure)
   The upstream change is not merged, it should be removed from auto.

- btrfs/249 (btrfs-progs bug)
   The fix for btrfs-progs is submitted by still needs some polish.

>    Failures: btrfs/006 btrfs/012 btrfs/049 btrfs/100 btrfs/162 btrfs/163
>      btrfs/184 btrfs/192 btrfs/196 btrfs/197 btrfs/218 btrfs/219 btrfs/235
>      btrfs/254 btrfs/277 btrfs/291 generic/455 generic/457
>    Flaky: btrfs/028: 40% (2/5)   generic/475: 60% (3/5)
>      shared/298: 20% (1/5)

btrfs/012 is convert related, thus I'm wondering if some older 
btrfs-progs is involved in this case.

For generic/455 and generic/457, we need the full out.bad and dmesg to 
determine.

Anyway since our expectation for future fstests runs are really no 
errors, I'm pretty happy to help on any of the failed runs.

> 
> FSTESTIMG: gce-xfstests/xfstests-amd64-202211301035
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests 068bd2a (Fri, 18 Nov 2022 08:38:35 +0900)
> FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
> FSTESTVER: fsverity v1.5 (Sun, 6 Feb 2022 10:59:13 -0800)
> FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
> FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
> FSTESTVER: quota  v4.05-52-gf7e24ee (Tue, 1 Nov 2022 11:45:06 +0100)
> FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
> FSTESTVER: xfsprogs v6.0.0 (Mon, 14 Nov 2022 12:06:23 +0100)
> FSTESTVER: xfstests-bld 920c0e32 (Mon, 28 Nov 2022 00:37:48 -0500)
> FSTESTVER: xfstests v2022.11.27-8-g3c178050c (Wed, 30 Nov 2022 10:25:39 -0500)
> FSTESTVER: zz_build-distro bullseye

Since the distro is Debian 11, I'm pretty sure the btrfs-progs is 
out-of-date.

Mind to add btrfs-progs to the FSTESTVER reporting?
And hopefully to also build a newer progs just like xfsprogs for testing?

Thanks,
Qu

> FSTESTCFG: btrfs/4k
> FSTESTSET: -g auto
> FSTESTOPT: aex
> GCE ID:    1186623270044702885
> 
> 
> 					- Ted
