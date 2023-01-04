Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B600F65E0EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 00:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjADXZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 18:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjADXZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 18:25:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973F42E36;
        Wed,  4 Jan 2023 15:17:12 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDnI-1p4zWu1QFi-00CkiF; Thu, 05
 Jan 2023 00:17:07 +0100
Message-ID: <b35e20df-9c9d-04b2-4830-46affac5c48f@gmx.com>
Date:   Thu, 5 Jan 2023 07:17:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: add a test case to verify scrub speed throttle
 works
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230104082123.56800-1-wqu@suse.com>
 <151e5c83-6de6-9950-d1ce-8a375acea356@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <151e5c83-6de6-9950-d1ce-8a375acea356@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NiHrjIYg0ZvA9VMj4KEXZLjpGUJRUQ9CnEdMYiD2r7MjrbxAfIi
 NLqsmqOtgT3gZP4x/kfviBkdrtPs2oGs1EBYXYBJTEBvFXfg46N4Lk2GLpURm6Wa4WFL7f3
 iEK0bQ5oTf1imCuGgm4RBSE3uOsTKQIGWSmb6gX8YwrBwPMtDnTljll0ZefG/IQrrTD+ECt
 Yl/LuQd9uQa1uHLfMJH1w==
UI-OutboundReport: notjunk:1;M01:P0:1jvjkWwhLOY=;xopSx4GQi73M7+8OzhrcD+93L0C
 P0sXAmKv95DlbRxEWamoLl9BPe3Ok3qgR+3E3POsgv24TeJdZXNsNYltUsNL21bfaMZBf5pOd
 fDO2Ngg8AV/omb3qAke16XhFBOUtX6o/HSjRwZmLcyOmZm3UYoFU66bOUaP7RoQBQ7LzlmaIU
 c5kM4MEJtO4q02ksZMtpmWWjddnPEKB2/lkFe+eStFqUFb+3oYcg/mfnZTyHosQ3WKIkfeuqO
 FJxAZJhTGh7sr3ZICakeGEgjxd9bBSvlS6ma19y26wqbKZXNe6p+az+Rm4g1zgYqC8dGrEOoq
 OrTMKzEPCuSdeY4twejHFONXBGk4OTCwwmuy/rqqRpqGyriW7JiponyJKp402cA2yMX+VWB+I
 tpfYsGyUKCEVn7rhC7nL+GUb0znPdl02dDg6Paa+hxNRz5/X0SDJiW68G09OjBHqDpIm4W4Lr
 ZF6WHIhLuL7arX0kXkwJ4Es9z3yUozywlLIBvQLRkXmFcmi0ZGksOhi6YQgM5oSJzHyB0+Vq9
 Y1UssQ8FMKA7RQEEiqUSSaRK/Q5SsEFFOXp+h4SUc5fn1tzbLvsTFQ2x3k+z15ABtWepQFRzL
 kyhkzC0K7jqXP7g89JMkug/8IwxVdyKfFAFDCrlOmpTPxCHdrKblgA93lhRiBMw4ZPlv6NJDq
 NTQfbL0DEzSijc1+IHlwvonlg8+/CI1VCvuaecFkYjIhvn5jwqcejR6yZqdy3u7z/4OI5wGbY
 RchjXmEuShpTUFWtXdK5Ura7gJYsXX0aXQTx92AGppgqUkEz8pk99W6pEnrqMJtKEVS0jnikr
 wDeHhI22l5ln1yM9vpKcipsBbE7AXm2FO/2yenMausnEO5PRKh4QKCizZ/Os63ZF3Ja5nWS64
 GQMMBomqnK12ZMf0AuwjSjdvYf7VHlNRrIHuM13lQ6jHqSKPR628X1Z8gVw4YI7BDmTuTmBce
 E1f7V/9J/FWcWROF7hGHPbrTSnc=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/5 06:17, Anand Jain wrote:
> On 1/4/23 16:21, Qu Wenruo wrote:
>> We introduced scrub speed throttle in commit eb3b50536642 ("btrfs: scrub:
>> per-device bandwidth control"),  but it is not that well documented
>> (e.g. what's the unit of the sysfs interface), nor tested by any test
>> case.
>>
>> This patch will add a test case for this functionality.
>>
>> The test case itself is pretty straightforward:
>>
>> - Fill the fs with 2G file as scrub workload
>> - Set scrub speed limit to 50MiB/s
>> - Scrub and compare the reported rate against above 50MiB/s throttle
>>
>> However the test case has an assumption that the underlying disk must be
>> faster than our 50MiB/s, which should be pretty common in
>> baremetal/exclusive VMs.
>> But for cloud environment it's not ensured 100%, thus the test case is
>> not included in auto group to avoid false alerts.
> 
> 
> Why not scrub the data twice: first to determine the speed, and then to 
> check if it can be throttled to ~50%?

Sounds great.

Thanks,
Qu
> 
> -Anand
> 
> 
