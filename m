Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1093316493B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 16:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBSPwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 10:52:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgBSPwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 10:52:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id c188so546477qkg.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cm1/LXE7Ytqr2T/AcQs7X0yH22gIRdeSD8EBnupx4P0=;
        b=se6Dwo30Xq8bdgqxAMe6EBsQ4g0CEAyvq2gXmbME9QSDW3lHg/QTskcyun2+HIN3Uq
         mSthDABr9d7kinF2NsK+6640qwPAToK2hP6Q+wh4RLsZ6Zyo+lbQMuPzKmyF1iTu+i9B
         TUatoasxtSg+RejtbzWQPFnwsIM9utW/I+XZVctnVYKrbnLCARS0gu2kR6dHAnn/Wj4n
         DIgyg/XNDq8K5AM52MEGamSkSEkepdubcz8kxC64m5ig6j0LrJvpmt7YHXuSn5ic+MrU
         CrtUynbW/cgrVyOlqUTjGKtA3rtAcvhb2FksKRXghdRDd84/wTgAC+K3QRwt9Tb++cda
         uu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cm1/LXE7Ytqr2T/AcQs7X0yH22gIRdeSD8EBnupx4P0=;
        b=mZzswruBB3ys6K7uq+X29BDn9F5TxN3NNPpe3GGDxhJ8iBU812pxt62elkyEEIkGs/
         zN9np1i8bvuFjHYjXkfCefLRlP4FF8hdoay9ipQS5ZtZLXrnaK5hlldF+3S0DsDUby6n
         dmVdF6TXfpZzIzNS1eIPJXkd1JlOgv8JXFgUv34RQV1D/iICmN6m8CdX7d72XmyDT1Z1
         CLf6q+Fp6IA4SXYjRTyRUrK3LCPjSx//Rdv141wQfkkojCBhPPM1qvCZJ2oqCH+gnIxu
         o5tRP0rp2sdESRmKHNWDlpvsuRdTOkZIJzNLZ23m+xn50maNu3IoK6klN3EmC+9MeniU
         EArA==
X-Gm-Message-State: APjAAAWECn1/QgWOo2eCsb+gxOwp22JmUfhxWXRPeFQVCTgrLD5+DVWB
        uZzXcDCsBP2SdXPzG0t/klhQtIHRm24=
X-Google-Smtp-Source: APXvYqwp0I6dcRiCUwBY/gjCoR75OmXyJwXj/Dj9zSRkfFPT6PDjM8w6YeCN3UHaVBfA664xc9rUkQ==
X-Received: by 2002:a37:2710:: with SMTP id n16mr24557650qkn.235.1582127565007;
        Wed, 19 Feb 2020 07:52:45 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::3b69])
        by smtp.gmail.com with ESMTPSA id d3sm41183qkl.0.2020.02.19.07.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 07:52:44 -0800 (PST)
Subject: Re: [PATCH][v2] xfstests: add a option to run xfstests under a cgroup
To:     Brian Foster <bfoster@redhat.com>
Cc:     kernel-team@fb.com, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200218152712.3750130-1-josef@toxicpanda.com>
 <20200219154850.GF24157@bfoster>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7e7476f4-3edd-3bff-657d-3ab627b0a75f@toxicpanda.com>
Date:   Wed, 19 Feb 2020 10:52:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219154850.GF24157@bfoster>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 10:48 AM, Brian Foster wrote:
> On Tue, Feb 18, 2020 at 10:27:12AM -0500, Josef Bacik wrote:
>> I want to add some extended statistic gathering for xfstests, but it's
>> tricky to isolate xfstests from the rest of the host applications.  The
>> most straightforward way to do this is to run every test inside of it's
>> own cgroup.  From there we can monitor the activity of tasks in the
>> specific cgroup using BPF.
>>
>> The support for this is pretty simple, allow users to pass -C <cgroup
>> name>.  We will create the path if it doesn't already exist, and
>> validate we can add things to cgroup.procs.  If we cannot it'll be
>> disabled, otherwise we will use this when we do _run_seq by echo'ing the
>> bash pid into cgroup.procs, which will cause any children to run under
>> that cgroup.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v1->v2:
>> - Changed it from a local.config option to a command line option.
>> - Export CGROUP2_PATH for everything, utilize that path when generating our
>>    cgroup for the scripts to run in.
>>
>>   check          | 24 +++++++++++++++++++++++-
>>   common/cgroup2 |  2 --
>>   common/config  |  1 +
>>   3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/check b/check
>> index 2e148e57..df33628e 100755
>> --- a/check
>> +++ b/check
>> @@ -72,6 +72,7 @@ check options
>>       --large-fs		optimise scratch device for large filesystems
>>       -s section		run only specified section from config file
>>       -S section		exclude the specified section from the config file
>> +    -C cgroup_name	run all the tests in the specified cgroup name
>>   
>>   testlist options
>>       -g group[,group...]	include tests from these groups
>> @@ -101,6 +102,10 @@ excluded from the list of tests to run from that test dir.
>>   external_file argument is a path to a single file containing a list of tests
>>   to exclude in the form of <test dir>/<test name>.
>>   
>> +cgroup_name is just a plain name, or a path relative to the root cgroup path.
>> +If CGROUP2_PATH does not point at where cgroup2 is mounted then adjust it
>> +accordingly.
>> +
>>   examples:
>>    check xfs/001
>>    check -g quick
>> @@ -307,6 +312,7 @@ while [ $# -gt 0 ]; do
>>   		;;
>>   	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
>>   	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
>> +	-C)	CGROUP=$2 ; shift ;;
>>   
>>   	-*)	usage ;;
>>   	*)	# not an argument, we've got tests now.
>> @@ -509,11 +515,24 @@ _expunge_test()
>>   OOM_SCORE_ADJ="/proc/self/oom_score_adj"
>>   test -w ${OOM_SCORE_ADJ} && echo -1000 > ${OOM_SCORE_ADJ}
>>   
>> +# Initialize the cgroup path if it doesn't already exist
>> +if [ ! -z "$CGROUP" ]; then
>> +	CGROUP=${CGROUP2_PATH}/${CGROUP}
>> +	mkdir -p ${CGROUP}
>> +
>> +	# If we can't write to cgroup.procs then unset cgroup
>> +	test -w ${CGROUP}/cgroup.procs || unset CGROUP
>> +fi
>> +
> 
> Do we need to fix up generic/563 to use this new $CGROUP value, when
> set? That test explicitly moves tasks to new/temporary groups, but looks
> like it resets back to the top-level CGROUP2_PATH group. I'm not sure
> how much that really matters since presumably the next test should move
> back into $CGROUP. Otherwise this looks reasonable enough to me.
> 

Wtf I had an explanation for this in my commit message, I must have exited 
without saving.

I tried to do this actually, and it ended up spewing because you cannot change 
cgroup.subtree_control for a cgroup you are currently inside of.  We can fix 
this by just making sure all controllers are enabled in our test cgroup, and 
then fix 562 to not bother messing subtree and just assume everything is 
enabled.  But since it's just one test and I wasn't sure if it would create more 
wonkiness I just left it as is.  I'm open to either solution, I just opted for 
the less change route.  Thanks,

Josef
