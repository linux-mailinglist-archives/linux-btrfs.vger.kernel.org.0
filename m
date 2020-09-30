Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB9B27DF35
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 06:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgI3EOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 00:14:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35992 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3EOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 00:14:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U4E6QN062853;
        Wed, 30 Sep 2020 04:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SduDrONRiNfJlvkw9TU59P1VPjSuXFtUoGbBQQ5vavY=;
 b=WZDrJkZsOO7kIi8028Q85rwp2XjmtcwEsbY+ozONlhTjUALb0E+XGmNbDScd6kKnaACY
 3vQSi3DpS8qmiliH4p0WLKCQ0GecGR4rahjBVDuKuqPmSZyEFX9TXtEg95fPqZDznNgY
 499ijGqiyF3YOuTbzwISVktgLfZjSVsuinkDWoItlInhJ3JikWwKj+25E2VRLrNwshIZ
 ipTpLnJp8gYEaeRI9eV9tMwY39Vu0wHdmziyFaysG+NiM0SfGPFrTFGt9AjpXRKoLQoj
 zkB6xnIjSDeBeA48qnsrkbJwbWM+8Hv/HA0zmIngOt5z4AA4qiYlvxpG9S4LjwXDl9jc zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33swkkxcbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:14:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U4AUw8169957;
        Wed, 30 Sep 2020 04:14:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33tfhyh8xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 04:14:38 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08U4Eb3w026028;
        Wed, 30 Sep 2020 04:14:37 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 21:14:37 -0700
Subject: Re: [PATCH] fstests: delete btrfs/064 it makes no sense
To:     Josef Bacik <josef@toxicpanda.com>, fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
 <CAL3q7H7QLe6EpK_g1S6MVhOPKaEsaYY9MeAHexdsEO=nz_qubQ@mail.gmail.com>
 <eba12792-b4b0-ca2e-3b78-7648ae60571c@toxicpanda.com>
 <CAL3q7H6qkVXMrJXeDnQWzVa95KS2QTEniKEEQbepEugPKMDrHQ@mail.gmail.com>
 <9dff9883-6275-d92c-e8d1-d5f0ef771613@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a6c80503-df28-f25d-6437-657640bf8ade@oracle.com>
Date:   Wed, 30 Sep 2020 12:14:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9dff9883-6275-d92c-e8d1-d5f0ef771613@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300030
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/9/20 1:26 am, Josef Bacik wrote:
> On 9/29/20 12:13 PM, Filipe Manana wrote:
>> On Tue, Sep 29, 2020 at 5:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>
>>> On 9/29/20 11:55 AM, Filipe Manana wrote:
>>>> On Tue, Sep 29, 2020 at 4:50 PM Anand Jain <anand.jain@oracle.com> 
>>>> wrote:
>>>>>
>>>>> btrfs/064 aimed to test balance and replace concurrency while the 
>>>>> stress
>>>>> test is running in the background.
>>>>>
>>>>> However, as the balance and the replace operation are mutually
>>>>> exclusive, so they can never run concurrently.
>>>>
>>>> And it's good to have a test that verifies that attempting to run them
>>>> concurrently doesn't cause any problems, like crashes, memory leaks or
>>>> some sort of filesystem corruption.
>>>>
>>>> For example btrfs/187, which I wrote sometime ago, tests that running
>>>> send, balance and deduplication in parallel doesn't result in crashes,
>>>> since in the past they were allowed to run concurrently.
>>>>
>>>> I see no point in removing the test, it's useful.
>>>
>>> My confusion was around whether this test was actually testing what we
>>> think it should be testing.  If this test was meant to make sure that
>>> replace works while we've got load on the fs, then clearly it's not
>>> doing what we think it's doing.
>>
>> Given that neither the test's description nor the changelog mention
>> that it expects device replace and balance to be able to run
>> concurrently,
>> that errors are explicitly ignored and redirected to $seqres.full, and
>> we don't do any sort of validation after device replace operations, it
>> makes it clear to me it's a stress test.
>>
> 
> Sure but I spent a while looking at it when it was failing being very 
> confused.  In my mind my snapshot-stress.sh is a stress test, because 
> its meant to run without errors.  The changelog and description are 
> sufficiently vague enough that it appeared that Eryu meant to write a 
> test that actually did a replace and balance at the same time.  The test 
> clearly isn't doing that, so we need to update the description so it's 
> clear that's what's going on.  And then I wanted to make sure that we do 
> in fact have a test that stresses replace in these scenarios, because I 
> want to make sure we actually test replace as well.
> 
> Not ripping it out is fine, but updating the description so I'm not 
> confused in a couple years when I trip over this again would be nice. 
> Thanks,
> 

As of now, we have the following balance concurrency tests.
-----
028 balance and unlink fsstress concurrency [1]
060 balance and subvol ops concurrency with fsstress [2]
061 balance and scrub concurrency with fsstress [2]
062 balance and defrag concurrency with fsstress [2]
063 balance and remount concurrency with fsstress [2]
064 balance and replace concurrency with fsstress  [2]
177 balance and resize concurrency
187 balance, send and dedupe concurrency
190 balance with qgroup

[1]
args=`_scale_fsstress_args -z \
         -f write=10 -f unlink=10 \
         -f creat=10 -f fsync=10 \
         -f fsync=10 -n 100000 -p 2 \
         -d $SCRATCH_MNT/stress_dir`

[2]
args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d 
$SCRATCH_MNT/stressdir`
-----

064 shall test balance with fsstress in the background. The replace 
thread is kept out with the early check of BTRFS_FS_EXCL_OP in the kernel.
I am ok with the 064 headers updated, will send v2.


Also, it turns out that this test case helped to find a btrfs-progs bug.
Its patch [1] is sent to the ML.
   [1] btrfs-progs: fix return code for failed replace start

Thanks, Anand


> Josef

