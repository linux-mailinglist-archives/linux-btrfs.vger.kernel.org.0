Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBC4898CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 13:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbiAJMo1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 07:44:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:52033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245632AbiAJMo0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 07:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641818659;
        bh=Rzbgfh0ENSqqOIROvnyC7FtPSQEmrnARdAiNWE8fMak=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=DyWi8L6neuh8DUu929ZZb+ZKEhQtEFT7LHhc9GbWbLOpxUcvad6Om5sU8SZxPZb5j
         A3UNzl6B2oS2INA68cjYZtW5Gmczmo+4+XZqlCXFyCmkIFTvgFz2iREBY0iMTCYFNb
         QoVgV0fEuvsZ+iPXNrXD/aTR4VPk5PlLnf6Sx44M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1nBYrS05L7-00Db0K; Mon, 10
 Jan 2022 13:44:19 +0100
Message-ID: <7769bb16-39ae-73f7-e0e6-6a37c7d70dba@gmx.com>
Date:   Mon, 10 Jan 2022 20:44:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220110112848.37491-1-wqu@suse.com>
 <YdwfNDsgEGmTL6bY@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs/011: handle finished replace properly
In-Reply-To: <YdwfNDsgEGmTL6bY@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:STF+t0e7ZcmhGLtOW++2RCiAgQdujPi6K+iP0I1f36dBwCIwuYv
 P1PRdI34Ya+cFteGJanCvfV+yYoWjMkPd5nd6VUoCYVPf2LVzbDC5K1BxOr7Zkk026LTeMk
 1QcMmU0cHo0LcoO/sFNnY5my5Pma//JF1sjJ9a3H0guR/IUXMHkGZbiSgTVNxQnnEtGPojp
 XUCXBiw1JMWaX8mGJmqyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LxUwbC5XHwQ=:TmCaGNPI1RtVQlu3Xjr4sa
 cGjW7p+icLkrN7G6uCCPrThaX8d7WTcN2Nu7QxVh9mFyhcTzrxpgfXDYgxh/BeIcLlwjZWu5D
 pSf9cpCj7X/XQPQx9QnCCm8/Dw55pq4Vis4U3D6kfhFCJeHRi7fMhc2bMvPLi3PpRp8J/9Nbq
 rBpGRm4ql+GkAd5oq93ghp+ZslpYS1gkSi56YisW5cUqCWyzr2YiBEyv0Fdh0HuOxZwKccOA7
 fn2SlAaOhTwRw37SR/pUoj4LgLCsVtYCJcwXQQ7d4HzGTjAC/6vpT5kEOxTKKWvX7zA0MZGIa
 9wVq104fyrnAJEF964SB6TY19Lspeagcrr6vQA53OipB+l+wZg/4zw3U4ZbYOR4VjCyaEUPpw
 WQXoJwtrw5OyXxBc7hGmIM4S6mlhicG+4iwlgP2XRugLTiRMJm+3I2SU03Pn5RtGuFQmDOYbR
 mclH3lvJAI6EwQ5PfjKk+Qu6Vejcv9kmYbiT0ZKpzEeDmxdvTH+zRLHbhe/u7lEdTSse1ZB7Z
 ZZdnGOnMsiyy11TYd+CPfgPGxFTTWvwoFjnaSXyFSrCZDs1mjg5Z1Y7wUvVDik7HCjO09MzEz
 249y73jpo5+N2ZFOsWVH0QQju/J5scz4iaOT6ufEBnJRN093eo9YCgO9tQWHyy+L7vUAbePap
 2vGyYA/zcnxJ7WmRboB3sSTDA1o3wzmzFOaq1DHUsT+hoOD12daGPqUyYqhXDnk/NAFggbuYR
 m87rhDD2jjJZK8vW94jjc1usEJwLYOHMzPW9xEjicMmub+lMHkXVauhfisWyX6jcTEyAvRRoR
 IaAVuUb/rlD8/U3MvQbsjncXZNWR7jU6u3RRVNuspW487KnSu1bY7KmTouEEESbWJAV0SRGy9
 Fl6E/oNuD4pOJ7KBRle7WhvTKxO+UqhUTTRnQ7iX5dbpa+7adv101OaEsiEA5b86ip6a7+0SR
 wIhP6bVVoR2P3dVK0keqnMLF7XPOidTNkW6wsWZohxVYQvvHV6T0KgagUV3orCJ4ATzTuCXRc
 808rWJS1pmYzYbVzpq14CfBmA4jZO1/t0GqFV5WqjhdzdFuFcUjmWEztE0y1p4kjQ2RW3ovU9
 FVBSAYdTQ1Y5YE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/10 19:57, Filipe Manana wrote:
> On Mon, Jan 10, 2022 at 07:28:48PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When running btrfs/011 inside VM which has unsafe cache set for its
>> devices, and the host have enough memory to cache all the IO:
>
> Btw, I use the same setup and the test never fails for me.
> It's quite of a strech assuming that using unsafe caching and having
> enough memory are the only reasons for the failure.
>
> I use a debug kernel with plenty of heavy debug features enabled,
> so that may be one reason why I can't trigger it.

I guess that's the reason.

For most cases I only enable light-weight debug features for regular runs.
The heavy ones like KASAN/kmemleak are reserved for more tricky cases.

>
>>
>> btrfs/011 98s ... [failed, exit status 1]- output mismatch
>>      --- tests/btrfs/011.out	2019-10-22 15:18:13.962298674 +0800
>>      +++ /xfstests-dev/results//btrfs/011.out.bad	2022-01-10 19:12:14.6=
83333251 +0800
>>      @@ -1,3 +1,4 @@
>>       QA output created by 011
>>       *** test btrfs replace
>>      -*** done
>>      +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>      +(see /xfstests-dev/results//btrfs/011.full for details)
>>      ...
>> Ran: btrfs/011
>> Failures: btrfs/011
>> Failed 1 of 1 tests
>>
>> [CAUSE]
>> Although commit fa85aa64 ("btrfs/011: Fill the fs to ensure we
>> have enough data for dev-replace") tries to address the problem by
>> filling the fs with extra content, there is still no guarantee that 2
>> seconds of IO still needs 2 seconds to finish.
>>
>> Thus even we tried our best to make sure the replace will take 2
>> seconds, it can still finish faster than 2 seconds.
>>
>> And just to mention how fast the test finishes, after the fix, the test
>> takes around 90~100 seconds to finish.
>> While on real-hardware it can take over 1000 seconds.
>>
>> [FIX]
>> Instead of further enlarging the IO, here we just accept the fact that
>> replace can finish faster than our expectation, and continue the test.
>
> If I'm reading this, and the code, correctly this means we end up never
> testing that the replace cancel feature ends up being exercised and
> while a replace is in progress. That's far from ideal, losing test
> coverage.

Yep, you're completely right.

In fact for my environment, only around 10% runs really utilized the
cancel path, the remaining 90% go finished routine.

But...

>
> Josef sent a patch for this last month:
>
> https://lore.kernel.org/linux-btrfs/01796d6bcec40ae80b5af3269e60a66cd4b8=
9262.1638382763.git.josef@toxicpanda.com/
>
> Don't know why it wasn't merged. I agree that changing timings in the
> test is not ideal and always prone to still fail on some setups, but
> seems more acceptable to me rather than losing test coverage.

My concern is, it's just going to be another whac-a-mole game.

With more RAM in the host, and further optimization, I'm not sure if 10
seconds is enough.
Furthermore 10 seconds may be too long for certain environment, to fill
the whole test filesystem and cause other false alerts.

As a safenet, we have dedicated cancel workload test in btrfs/212, and
IIRC for most (if not all) bugs exposed in btrfs/011, it's in the
regular replace path, not the cancel path.

Thus I want to end the whac-a-hole game once and for all, even it will
drop the coverage for super fast setup.

Thanks,
Qu

>
> Thanks.
>
>>
>> One thing to notice is, since the replace finished, we need to replace
>> back the device, or later fsck will be executed on blank device, and
>> cause false alert.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/011 | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>> index b4673341..aae89696 100755
>> --- a/tests/btrfs/011
>> +++ b/tests/btrfs/011
>> @@ -171,13 +171,24 @@ btrfs_replace_test()
>>   		# background the replace operation (no '-B' option given)
>>   		_run_btrfs_util_prog replace start -f $replace_options $source_dev =
$target_dev $SCRATCH_MNT
>>   		sleep $wait_time
>> -		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
>> +		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $seqres.full
>>
>>   		# 'replace status' waits for the replace operation to finish
>>   		# before the status is printed
>>   		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>>   		cat $tmp.tmp >> $seqres.full
>> -		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) =
failed"
>> +
>> +		# There is no guarantee we canceled the replace, it can finish
>> +		if grep -q 'finished' $tmp.tmp ; then
>> +			# The replace finished, we need to replace it back or
>> +			# later fsck will report error as $SCRATCH_DEV is now
>> +			# blank
>> +			$BTRFS_UTIL_PROG replace start -Bf $target_dev \
>> +				$source_dev $SCRATCH_MNT > /dev/null
>> +		else
>> +			grep -q 'canceled' $tmp.tmp || _fail \
>> +				"btrfs replace status (canceled ) failed"
>> +		fi
>>   	else
>>   		if [ "${quick}Q" =3D "thoroughQ" ]; then
>>   			# The thorough test runs around 2 * $wait_time seconds.
>> --
>> 2.34.1
>>
