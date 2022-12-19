Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81C6515AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 23:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiLSWpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 17:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiLSWpo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 17:45:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4D20E;
        Mon, 19 Dec 2022 14:45:42 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1ob58a2QHL-00cUYA; Mon, 19
 Dec 2022 23:45:32 +0100
Message-ID: <97c625a9-3b5a-c3ae-d69f-cfb71266cd30@gmx.com>
Date:   Tue, 20 Dec 2022 06:45:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20221216065121.30181-1-wqu@suse.com> <Y6Ch1Qq9op2tmB1U@magnolia>
 <Y6Cz+trxF6JtubwN@mit.edu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fstests: report: always save the dmesg as system-err if
 KEEP_DMESG is set
In-Reply-To: <Y6Cz+trxF6JtubwN@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YM5LP1rZ0LfanaXkJT4lR9BJ4jSiYdnu7tsY995Uif/W15jbJjH
 b7RJRotf35Sk1PozR+yuvADEr4Z/Ei1P0B0TDSYrWDmQBFKG9UfagLc0inR/DtFZ2TiYDCH
 9W/CpMrAnTqYdAWG8O/v2I+rAZPWxKH3yiXRKCfcPVgbWiyECJzTr2lv5JRbFW1Uiu+AkRR
 sE+E5mH9AnS4yfAWAjqOQ==
UI-OutboundReport: notjunk:1;M01:P0:KC1UXrqWlWE=;UWedlzgeQqb51wsmmACFhoAUF+m
 gl25yK5DMo+OOa86RAwuyze5zd4fnVi7LgKo/sKVmSJlusIyTWIfIf4LZ5UdiBHBMsKLv0fpN
 aYyHJdGtnIrFmpDbsHtmy1APHnErnzOAngFfA2QUfX+jPTIiKWD+qnFboHtE8g6R3glpaojxS
 pY6cc9+hUiYgNTaLerO2Zsl04dVbpX41CGBxzR0a9dO6zpPV0C5T/50KwO1SbeIrKnJVGCK3x
 2GOYxjmZzRkyuX0cKdTUURd7gLxcidJKraj3ro3rMdXEcHOoUGKwX9D3twlxqXnlWFuqX9xIv
 a3hd5LZR56W7uzdCL1F2cIo9UxwYxlLoSHm44Y1d1kL1+Qg07mE436A5HyF+k8ZC5FoSJPNNs
 ESKX7dg+DlKJYlMvSjShTyhZkcrUGkez55DV81jOiO0WOdp4ECiAdK9K3oMz22vYh4moETnoG
 tBVPISk+f3boddVu3AFTNbvb3T1sVJxv98M70ZxJbj1HDUrzsmVBQdES7Me4FO31swoBmAnDJ
 S6mRnTylgI9cShECzdst47KLHtHcTesVpcaLsnIU3A2LX+hqD9N2wDyixPyVEOVMH7QgkggPs
 AwVUGFKCFweNP3Wp8xEBYLG57ZUPsxDBVAh0dEEv5pMr76+yL8Y5E4HPwM4ncotvyJ84pHXCg
 rw5yV5eO4iYZ3d8+i10rAtQYAjR5W1vyYtP6r9P7EWL0tvoIxOqJWSjepwGrfWSJrLOfpp9RA
 2GTuMn0afCS4On477TJT5xpKEqQJhVhIrlC3MzEo5crMKa7nS+onKxRO+JlX022pTHVv4E5jK
 gBvEzO1zcEZc4aOx/usTQZTvJhr7w8UBbwjszMqOKqfbm30QaXUAKOmOj7OHky0fd8VyCTFNU
 P9yy67jMOEiVvUodKFvlYCU8vQn06x6aNVXrfn2AmzeC0N9k04JtLydBT+wfR3A2YYdic5p+n
 NP0qbRcgMocAbnEZkqOOpjPfnyc=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/20 02:56, Theodore Ts'o wrote:
> On Mon, Dec 19, 2022 at 09:39:33AM -0800, Darrick J. Wong wrote:
>> On Fri, Dec 16, 2022 at 02:51:21PM +0800, Qu Wenruo wrote:
>>> When KEEP_DMESG is set to "yes", we will always save the dmesg of any
>>> test case (no matter if it passed or not) into "$seqnum.dmesg".
>>>
>>> But this KEEP_DMESG behavior doesn't affect xunit report.
>>>
>>> This patch will make xunit report to follow KEEP_DMESG setting.
> 
> This may be dangerous; if the XML file is too large, the XML parser
> may end up rejecting the whole XML file because otherwlse a too-large
> XML file can trigger a denial of service attack[1].  (This is why I
> implemented "xunit-quiet".)

I guess your concern is correct.

Although during my auto run, single dmesg are not that large, the 
largest three are not MiB level yet:

108K    btrfs/187.dmesg
80K     btrfs/072.dmesg
64K     generic/311.dmesg

But the total dmesg sizes already go MiB levels, 2.6MiB.

> 
> [1] https://gitlab.com/gitlab-org/gitlab/-/issues/25357
> 
> So if you are running a large number of tests (e.g., "-g auto") it
> might very well that adding dmesg for all tests might very well end up
> bloating the XML file to the point where it will be unmangeable.  For
> example, this is the size for my syslog file after running "-g auto"
> on the "xfs/quota" config:
> 
> -rw-r----- 1 tytso primarygroup 10316684 Aug 25 10:35 ae/syslog
> 
> The syslog file for all of the xfs configs are 9-10 megabytes each.
> If I combined the 12 xfs configs that we run into a single xunit JML
> file with the dmesg output, this would be *guaranteed* to blow out
> most XML parsers.
> 
> Personally, I find that a better solution is to use the syslog daemon
> to save the dmesg output for all of the tests into a single file.  I
> prefer this for three reasons:
> 
>    * The single file is more compressibls compared to having it broken
>      out into separate $seqnum.dmesg files.
>    * By keeping dmesg and other test artifacts separate from the xml
>      file I can archive the xml file for a much larger period of time,
>      (perhaps indefinitely) while allowing the much more volunumous
>      test artifacts to be archived for a shorter time (say, 3-6 months).
>    * When there are test isolation issues, it's not uncommon for a
>      previous test to fail with some kind of global or cgroup-specific
>      OOM-kill, or when I'm testing on bare metal with real hardware
>      where hardware failures is a Thing, being able to look for unusual
>      kernel messages before the start of a particular test can often be
>      quite revealing.

On the other hand, separating dmesg from its test cases means extra 
parsing to bind the log section to certain test runs.

In fact, I'm not even sure if possible to do that.
E.g. on the same host with different kernel/fstests configs.

One reason I want to keep the dmesg bound to each test case is, we had 
cases in the past that some btrfs specific error messages are not (and 
should not) caught by fstests, but can still be some clue of bugs.

Thus if we have a proper paired dmesg with kernel/fstests configs and 
test case, we can determine how affected the bug is.

Any better idea to relate them? Or is this really too niche?

Thanks,
Qu
>      
> Cheers,
> 
> 						- Ted
