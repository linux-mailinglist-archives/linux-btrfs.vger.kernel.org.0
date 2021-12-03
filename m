Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C80467F9A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353951AbhLCV7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 16:59:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39986 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353907AbhLCV7r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 16:59:47 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3L6Kkh025831;
        Fri, 3 Dec 2021 13:56:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=y6mLfCSw/JytCmK/V7IP5UAmFMRsVtlUv3f3ADfkO40=;
 b=WabOv6LgT+cGRjlfJLvbojL3dktt+YMhuu/1Cl5Stm7tfOs5CPqzFdReRgh/6xG/HcSP
 2E0hjLSwuYf7k5+NLt77EqqKfUdpNImLluT9VA+FDDysfPmOM9aItUStclzueemzTo5g
 RYsMLWpiDpmvGCCWqxLZwMvpvJFKj97o89o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqhvdmc99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Dec 2021 13:56:20 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 13:56:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDpj4tM9S5qix5JMusr3NBoszQEL7bOP+/hsH7a0g20LhS7VzPOCrm36LoegljTPvjPVayQdIJhx6MUtglmG5YXmYeebG6zblqDLMePwUA9l2J+QFrhMNiYYjY9TafhcVAx4zoBAI2NYEJ7zeXaJ/McQ1U7tlxwCk8JLQxu8nHIuJ1KcbnCiGKiejfS9lisRb/LwNARBbyAtvNh7dR7I0GA7p8prUhTVSib7C4xx7BfqGyno/yhP32wAFQppe0gp0ZTEHf5So/JTBV6oJK5Wdf98x9+n3O+v42hvcInGJmaZ1mCBWSLsHT7eIqWw5/sv7iXlDZKaPmlIAbyNZFDxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6mLfCSw/JytCmK/V7IP5UAmFMRsVtlUv3f3ADfkO40=;
 b=gFvHIh4tJvGYP7ngHXPJWnx7P94yeZ+SgJSuG3edN041GLLRii1KQZTb9E9hSIiFz4bxr4K4arImnqaCvkbpZRwjNsZbsPF8qKnCtyKsBzmCQ3Iatx3Bp9jV0y4yU45i4OnolSAoTCsZ+bAGpTQmx0xpZKOK8IOpaKuNEQbfgk54XWcDoX11BSNlbgyitSn+B5OKaOiTFxciKpEDSM7TQRbPFnzaNT95y7AbEtn51yyexR7BVGHFz55c7CXJuFXG6rmjpps9QpYTvkgTh51dxpu8MKnDENulqmE1In1ZLl8VpN3uNbCNXntpVleBVK/y7z4g70C23EjWC2hsP2zotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MW4PR15MB4618.namprd15.prod.outlook.com (2603:10b6:303:10b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 21:56:17 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f8de:1089:be1d:7bf]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f8de:1089:be1d:7bf%8]) with mapi id 15.20.4713.031; Fri, 3 Dec 2021
 21:56:17 +0000
Message-ID: <01177f24-20f8-4639-0f8d-2ac30716b966@fb.com>
Date:   Fri, 3 Dec 2021 13:56:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v7] btrfs: Add new test for setting the chunk size.
Content-Language: en-US
To:     Eryu Guan <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <20211129195016.1874324-1-shr@fb.com>
 <20211202121205.GB60846@e18g06458.et15sqa>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20211202121205.GB60846@e18g06458.et15sqa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:301:14::30) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::13da] (2620:10d:c090:400::5:834) by MWHPR1701CA0020.namprd17.prod.outlook.com (2603:10b6:301:14::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 21:56:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f92b8e8a-1f81-4c83-e872-08d9b6a7bb91
X-MS-TrafficTypeDiagnostic: MW4PR15MB4618:
X-Microsoft-Antispam-PRVS: <MW4PR15MB46182F6C8CFFF6196D5D2F9DD86A9@MW4PR15MB4618.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXDSskQiqkhxzBmqYN3g8BNe5BU8PG6sYsSPOpyYIuMmJL0HHHhU/HSaEVe45KyZd9q8xUpUA/t2bRBqf1Szdjcic8Ocd4E2KcrSbtWtbjBnGg9quaWQrGvqWR3fZsbuWiWuazgsmHVKXvGaF/VV7wOIOmYFjPO1IM7PIYZGiOJA+p67gsP79dAL8HnvDiISqk/FulJM1XDNu56/DAaawx5UcqElw+Ok+hco9Ip4tOldYjtoofvWnWTZUWYN5E7GKqiW7zJduHoB65hv/LTyKtzqAUnseCoas4TqszjYgnT3xVhO8vscM263xJXozFb2Jns7oyGI8HOVq9CoDM8kenwRmniZGdAIA+U76aF6DPYFGqhi7G9yKpSQwq/7ljrQWhSQ620fklpQ2/krVKd0eGKFlArYLnphYu5/SoewcBAzOAfnB/DWYIm9mDX/qG8+xB0mJ8U6FbRhmR2YwBAcUA+PQMO89SxbLVx323Q2PDSc+ogsVarFdNghABHg04b4BSS5kuAWDGQmp6M8bmBbYzhZQEUwTSDKzrQIxVr4K7rGz4SL3zqvdqM2OqJFmJb6+NO6loFvRsRJfz0r3Ekt9uXcoNsJJBrhUzhecnI+kIDeDDgcEV4pOikwp3KBD3mQktnJbR4uR7GaiE2QGMwbabEsfb3Xruu0Mr2TUDFH6bcRGFMrtvKKVzD+pUHpFSycILBtzH50JVEXDVhec5/fX6ZxU4CwKuJN2kx7J7MfPo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6916009)(38100700002)(508600001)(66946007)(8676002)(8936002)(6486002)(5660300002)(66556008)(86362001)(66476007)(186003)(4326008)(31696002)(2906002)(2616005)(31686004)(83380400001)(36756003)(30864003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmQ0cytwRDliYTJWRS91MkQvdC9zejR0VjhjMWlxY2FOazRSU2grNHh2US9y?=
 =?utf-8?B?Q2oyZGlnWThQd0VCQWhkanloQ0NmazFhbEpJNnlrdlFJYnJWdEt2MlliZy9w?=
 =?utf-8?B?MTFheGlnck5iMTMyZFQzamFQUlRDQmVqdStkbEs3bEZDNy8veGVXeGFMa2Vq?=
 =?utf-8?B?SW9YT3M5dzFtWUJncFg2UU9CMDVsbDgvbktINEt2TGE0WWNGSXA0amZrNmZM?=
 =?utf-8?B?YWpMV0VBWnhQcWJ2SElhQzgzZVljSEVpQmUraEkrN3FSa2JhUzFPejBVTEx3?=
 =?utf-8?B?SlJCUnh3RmpmTmJVS1NGT3AzRzFNeUY1S1ozeFMyZjBiVXgrd1RMeEliR3Jp?=
 =?utf-8?B?NHIyc0dqcUdTSDFieTFtU2R6enhBb0FTTE1GYThqajlkRDExR3VRdnl0R0xX?=
 =?utf-8?B?S1BUM3hsQS84cnVUNWZEd3FEZElwZVNKRkxSRDBBb3BkVVFtVVR5enhrSlJ3?=
 =?utf-8?B?L0tab3pUMkp6UEFDL01yMy9vbWJCZ0ZGOU80U25zR3AzQ1U5OHdlWEhTdm8y?=
 =?utf-8?B?TFEzbFNjYllpcWZLa20xaFFodnd5QTZDU3V1cm9aZmxkVnowdTFOUUJvb1hw?=
 =?utf-8?B?MzJKTDdHOUZWaFNsNWJzZkxXOHcrRkNIRWYyaU1mMGlabVBkcHFmdURHVlRZ?=
 =?utf-8?B?bUN2RlpRdUp5WkVmVzQwR0VKWWtKcU1KdXFnS08randzdjc4b1plZVdOUW9r?=
 =?utf-8?B?V3dOQlRFTFlHd1pZdWdoRjlDejNjdzk1d1Y1eGlBc2pEdk0zM0tZVjJmSXlR?=
 =?utf-8?B?YlduMStGdDQyMHFuRGpPWVI5dTRIeHFYcGpjZG9IWWNTTzV5VGlnVTJPc0Fr?=
 =?utf-8?B?RXYySVNZSUt4WlZWcmhoMU51TkczdnZwS1NuY2dwOEx5dG4rVnprWWI0Q1Ix?=
 =?utf-8?B?M1VVS09VRTNabFVNbDRmaGh6My84dmtlanZ5clQyVWpua3hqbEN0UzFKcktr?=
 =?utf-8?B?Qzg0WndqWXpMZVFiWGJWTGVRODhhbzNFYTZYenF3Sy9nV1lsYkZwR05NNmRD?=
 =?utf-8?B?TVNSOEZ6R1h6NHZ5SjBmcGFiSXRhc01tOVAzdER6R1JaaDdnTVZnY0hHRkc4?=
 =?utf-8?B?eXRBOU9NUlloN3NJRkp6VFpDTUhXTWJrU3lndHBIWllyOGxZaVNSNi9nOThj?=
 =?utf-8?B?dzRtYlF5S1RjY3RXbFBrbVJjWTZXY00zaWUreTVPMmhYVWhKR0MzVGZpaS9o?=
 =?utf-8?B?bWFLV0I5QWFxSVZBYWhMRmRGK21ybld3b2R0MVBhaUhlZnFGNGx1MC9mN2ho?=
 =?utf-8?B?aGJ0RWsrL2pENkJZREhOWlNLYUNrUHNiOUZaWG8vTVZRRExsRFpuWitySE9L?=
 =?utf-8?B?VCtzNlpwSXRzN3lhL3Z6ejhMOEh5TEhTSEUzaDBPc081eDdYdGVIY0xSUDEr?=
 =?utf-8?B?MEw5cllOLzk4aFFiR2h6TjRmWWpJTVkxYjQ4SW52dUZyVWRBSWpUc1JXTzlx?=
 =?utf-8?B?WnNqbWtPR0J3b2lqR3owM0xESHg2TmlBbVFJVXFVZUFwcWFFM2xNZ3ZVenVo?=
 =?utf-8?B?Y2NxTk8wOVRsa1hmVDZmbGNDbFowem1ZQjhOb0c3SG1mQnE2aWxFV25TSysx?=
 =?utf-8?B?c0FWMExadlFXVFdNVDdIZDBQbjhSa0xmME8zalJzN0hJem5zNTFrbzBOalNX?=
 =?utf-8?B?ZElVNUtVeXlMa2ZUaUhjRGRBcEI2Y3VWVUZ6TTNGL1BwMk90ZThGSko1M3ll?=
 =?utf-8?B?ZlpLRjNTeUI2SzFBcnBnVHAxUWVJalRvNndHbVdRQU5FNXVlZEpCNTluQ2Vz?=
 =?utf-8?B?Wm5GUmZsTGNRZ3VaalkybkllUWZuU1FNcHF0bmZVMDNlNkE0cHlMeTdVajdV?=
 =?utf-8?B?MTExMm43VTVVM0NDVzRFK2huQmhQQkRrRU82UG9lMTRJcU9FWVN0T3lmcVcx?=
 =?utf-8?B?QXdzMFI0elV6djhQTzdGTHpZNHIwalZ5MHBiZmhsOXdPeSs2VFREQXZ4MFFs?=
 =?utf-8?B?SEZZTjRubVRMUHBJSWZ5S093aHliaVBaUjVWcnpyaUR1eUxabEY2SEYwZUFH?=
 =?utf-8?B?Y0NrcVlDUzFFYk9DYWVnLzhHdnV5VzVuYWg2WUVwam1mOGFMaFZoWFYzaTlD?=
 =?utf-8?B?aGxseU8xT1VrMFQ4VGJhVnNBU21ZbEpZTENFOXo5RlphZjVNSElzM1F6aVJD?=
 =?utf-8?Q?tBJbsK5jzSKK2Gtji1AppCFQ8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f92b8e8a-1f81-4c83-e872-08d9b6a7bb91
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 21:56:17.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERR4k4nDET+xaGKd8LcJ3laHO5guHIYEhzkleW8Ld3hppSqhReCQgClbJTMHZHFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4618
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: fptVt1UDc6NBRAXWeUj4ZiqNr2iHMReM
X-Proofpoint-GUID: fptVt1UDc6NBRAXWeUj4ZiqNr2iHMReM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/2/21 4:12 AM, Eryu Guan wrote:
> On Mon, Nov 29, 2021 at 11:50:16AM -0800, Stefan Roesch wrote:
>> Add new testcase for testing the new btrfs sysfs knob to change the
>> chunk size. The new knob uses /sys/fs/btrfs/<UUID>/allocation/<block
>> type>/chunk_size.
>>
>> The test case implements three different cases:
>> - Test allocation with the default chunk size
>> - Test allocation after increasing the chunk size
>> - Test allocation when the free space is smaller than the chunk size.
>>
>> Note: this test needs to force the allocation of space. It uses the
>> /sys/fs/btrfs/<UUID>/allocation/<block type>/force_chunk_alloc knob.
>>
>> Testing:
>> The test has been run with volumes of different sizes.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> V7: - fixed whitespace issues
>>     - removed test_file variable (no longer needed)
>>     - removed _require_btrfs_fs_sysfs (check for filesystem attributes
>>       is sufficient)
>>     - Added comment for 10G requirement
>> V6: - renamed test case from 248 to 251
>>     - use _require_fs_sysfs
>>     - use device name in _get_fs_sysfs_attr and _set_fs_sysfs_attr
>> V5: - Modify _get_fs_sysfs_attr and _set_fs_sysfs_attr to support btrfs
>>     - Use _get_fs_sysfs_attr and _set_fs_sysfs_attr
>>     - Remove _get_btrfs_sysfs_attr and _set_btrfs_fsysfs_attr
>>     - Rename local functions to not use "_"
>>     - use $AWK_PROG and $BTRFS_UTIL_PROG
>>     - remove call to _require_scratch_size
>>     - fixes for coding convention
>>     - replace fail calls with echo
>> V4: - fixed indentation in common/btrfs
>>     - Removed UUID code, which is no longer necessary (provided
>>       by helper function)
>>     - Used new helper _get_btrfs_sysfs_attr
>>     - Direct output to /dev/null
>> V3: - removed tests for system block type.
>>     - added failure case for system block type.
>>     - renamed stripe_size to chunk_size
>> V2: - added new functions to common/btrfs and use them in the new test
>>       - _require_btrfs_sysfs_attr - Make sure btrfs supports a sysfs
>>         setting
>>       - _get_btrfs_sysfs_attr - Read sysfs value
>>       - _set_btrfs_sysfs_attr - Write sysfs value
>>     - create file system of required size with _scratch_mkfs_sized
>>     - use shortened error message
>>     - Remove last logging message
>> ---
>>  common/rc           |  27 ++++-
>>  tests/btrfs/251     | 285 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/251.out |  11 ++
>>  3 files changed, 320 insertions(+), 3 deletions(-)
>>  create mode 100755 tests/btrfs/251
>>  create mode 100644 tests/btrfs/251.out
>>
>> diff --git a/common/rc b/common/rc
>> index 0a30a842..bdd29b06 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4401,7 +4401,14 @@ run_fsx()
>>  _require_fs_sysfs()
>>  {
>>  	local attr=$1
>> -	local dname=$(_short_dev $TEST_DEV)
>> +	local dname
>> +
>> +	case "$FSTYP" in
>> +	btrfs)
>> +		dname=$(findmnt -n -o UUID $TEST_DEV) ;;
>> +	*)
>> +		dname=$(_short_dev $TEST_DEV) ;;
>> +	esac
>>  
>>  	if [ -z "$attr" -o -z "$dname" ];then
>>  		_fail "Usage: _require_fs_sysfs <sysfs_attr_path>"
>> @@ -4439,7 +4446,14 @@ _set_fs_sysfs_attr()
>>  		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
>>  	fi
>>  
>> -	local dname=$(_short_dev $dev)
>> +	local dname
>> +	case "$FSTYP" in
>> +	btrfs)
>> +		dname=$(findmnt -n -o UUID ${dev}) ;;
>> +	*)
>> +		dname=$(_short_dev $dev) ;;
>> +	esac
>> +
>>  	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
>>  }
>>  
>> @@ -4460,7 +4474,14 @@ _get_fs_sysfs_attr()
>>  		_fail "Usage: _get_fs_sysfs_attr <mounted_device> <attr>"
>>  	fi
>>  
>> -	local dname=$(_short_dev $dev)
>> +	local dname
>> +	case "$FSTYP" in
>> +	btrfs)
>> +		dname=$(findmnt -n -o UUID ${dev}) ;;
>> +	*)
>> +		dname=$(_short_dev $dev) ;;
>> +	esac
>> +
>>  	cat /sys/fs/${FSTYP}/${dname}/${attr}
>>  }
>>  
>> diff --git a/tests/btrfs/251 b/tests/btrfs/251
>> new file mode 100755
>> index 00000000..11925f5b
>> --- /dev/null
>> +++ b/tests/btrfs/251
>> @@ -0,0 +1,285 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Facebook.  All Rights Reserved.
>> +#
>> +# FS QA Test 250
>> +#
>> +# Test the new /sys/fs/btrfs/<uuid>/allocation/<block-type>/chunk_size
>> +# setting. This setting allows the admin to change the chunk size
>> +# setting for the next allocation.
>> +#
>> +# Test 1:
>> +#   Allocate storage for all three block types (data, metadata and system)
>> +#   with the default chunk size.
>> +#
>> +# Test 2:
>> +#   Set a new chunk size to double the default size and allocate space
>> +#   for all new block types with the new chunk size.
>> +#
>> +# Test 3:
>> +#   Pick an allocation size that is used in a loop and make sure the last
>> +#   allocation cannot be partially fullfilled.
>> +#
>> +# Note: Variable naming uses the following convention: if a variable name
>> +#       ends in "_B" then its a byte value, if it ends in "_MB" then the
>> +#       value is in megabytes.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto
>> +
>> +seq=`basename $0`
>> +seqres="${RESULT_DIR}/${seq}"
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	cd /
>> +}
> 
> Seems there's no need to override the default cleanup function, we could
> just remove this _cleanup defination.
> 

I removed it.

>> +
>> +# Parse a size string which is in the format "XX.XXMib".
>> +#
>> +# Parameters:
>> +#   - (IN)    Block group type (Data, Metadata, System)
>> +#   - (INOUT) Variable to store block group size in MB
>> +#
>> +parse_size_string() {
>> +	local SIZE=$(echo "$1" | $AWK_PROG 'match($0, /([0-9.]+)/) { print substr($0, RSTART, RLENGTH) }')
>> +	eval $2="${SIZE%.*}"
>> +}
>> +
>> +# Determine the size of the device in MB.
>> +#
>> +# Parameters:
>> +#   - (INOUT) Variable to store device size in MB
>> +#
>> +device_size() {
>> +	btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid >> $seqres.full
>> +	local SIZE=$($BTRFS_UTIL_PROG filesystem show ${SCRATCH_MNT} --mbytes | grep devid)
>> +	parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
>> +	eval $1=${SIZE_ALLOC%.*}
>> +}
>> +
>> +# Determine the free space of a block group in MB.
>> +#
>> +# Parameters:
>> +#   - (INOUT) Variable to store free space in MB
>> +#
>> +free_space() {
>> +	local SIZE=$($BTRFS_UTIL_PROG filesystem show ${SCRATCH_MNT} --mbytes | grep devid)
>> +	parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
>> +	parse_size_string $(echo "${SIZE}" | awk '{print $6}') SIZE_USED
>> +	eval $1=$(expr ${SIZE_ALLOC} - ${SIZE_USED})
>> +}
>> +
>> +# Determine how much space in MB has been allocated to a block group.
>> +#
>> +# Parameters:
>> +#   - (IN)    Block group type (Data, Metadata, System)
>> +#   - (INOUT) Variable to store block group size in MB
>> +#
>> +alloc_size() {
>> +	local SIZE_STRING=$($BTRFS_UTIL_PROG filesystem df ${SCRATCH_MNT} -m | grep  "$1" | awk '{print $3}')
>> +	parse_size_string ${SIZE_STRING} BLOCK_GROUP_SIZE
>> +        eval $2="${BLOCK_GROUP_SIZE}"
> 
> Above line uses space as indentions, not tab.
> 

Fixed.

>> +}
>> +
>> +. ./common/filter
>> +_supported_fs btrfs
>> +_require_test
>> +_require_scratch
>> +
>> +# Delete log file if it exists.
>> +rm -f "${seqres}.full"
>> +
>> +# Make filesystem. 10GB is needed to have sufficient space for testing
>> +# block types and chunk sizes.
> 
> Hmm, it's still not clear to me why is 10G needed, this comment just
> says we need 10G but not why.
> 

I rephrased the comment.

>> +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
>> +_scratch_mount >> $seqres.full 2>&1
>> +
>> +# Check if there is sufficient sysfs support.
>> +_require_fs_sysfs allocation/metadata/chunk_size
>> +_require_fs_sysfs allocation/metadata/force_chunk_alloc
>> +
>> +# Get free space.
>> +free_space  FREE_SPACE_MB
>> +device_size DEVICE_SIZE_MB
>> +
>> +echo "free space = ${FREE_SPACE_MB}MB" >> ${seqres}.full
>> +
>> +# If device is a symbolic link, get block device.
>> +SCRATCH_BDEV=${SCRATCH_DEV}
>> +if [[ -h ${SCRATCH_DEV} ]]; then
>> +	SCRATCH_BDEV=$(readlink -f $SCRATCH_DEV)
>> +fi
> 
> There's a helper to do this, i.e.
> 
> SCRATCH_BDEV=$(_read_dev $SCRATCH_DEV)
> 

I assume you meant _real_dev. Changed.

>> +
>> +# Get chunk sizes.
>> +echo "Capture default chunk sizes."
>> +FIRST_DATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size)
>> +FIRST_METADATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size)
>> +
>> +echo "Orig Data chunk size    = ${FIRST_DATA_CHUNK_SIZE_B}"     >> ${seqres}.full
>> +echo "Orig Metaata chunk size = ${FIRST_METADATA_CHUNK_SIZE_B}" >> ${seqres}.full
>> +
>> +INIT_ALLOC_SIZE_MB=$(expr \( ${FIRST_DATA_CHUNK_SIZE_B} + ${FIRST_METADATA_CHUNK_SIZE_B} \) / 1024 / 1024)
>> +echo "Allocation size for initial allocation = ${INIT_ALLOC_SIZE_MB}MB" >> $seqres.full
>> +
>> +#
>> +# Do first allocation with the default chunk sizes for the different block
>> +# types.
>> +#
>> +echo "First allocation."
>> +alloc_size "Data"     DATA_SIZE_START_MB
>> +alloc_size "Metadata" METADATA_SIZE_START_MB
>> +
>> +echo "Block group Data alloc size     = ${DATA_SIZE_START_MB}MB"     >> $seqres.full
>> +echo "Block group Metadata alloc size = ${METADATA_SIZE_START_MB}MB" >> $seqres.full
>> +
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/force_chunk_alloc 1
>> +
>> +alloc_size "Data"     FIRST_DATA_SIZE_MB
>> +alloc_size "Metadata" FIRST_METADATA_SIZE_MB
>> +
>> +echo "First block group Data alloc size     = ${FIRST_DATA_SIZE_MB}MB"     >> ${seqres}.full
>> +echo "First block group Metadata alloc size = ${FIRST_METADATA_SIZE_MB}MB" >> ${seqres}.full
>> +
>> +free_space FREE_SPACE_AFTER
>> +echo "Free space after first allocation = ${FREE_SPACE_AFTER}MB" >> ${seqres}.full
>> +
>> +#
>> +# Do allocation with the doubled chunk sizes for the different block types.
>> +#
>> +echo "Second allocation."
>> +SECOND_DATA_CHUNK_SIZE_B=$(expr ${FIRST_DATA_CHUNK_SIZE_B} \* 2)
>> +SECOND_METADATA_CHUNK_SIZE_B=$(expr ${FIRST_METADATA_CHUNK_SIZE_B} \* 2)
>> +
>> +echo "Second block group Data calc alloc size     = ${SECOND_DATA_CHUNK_SIZE_B}"     >> $seqres.full
>> +echo "Second block group Metadata calc alloc size = ${SECOND_METADATA_CHUNK_SIZE_B}" >> $seqres.full
>> +
>> +# Stripe size is limited to 10% of device size.
>> +if [[ ${SECOND_DATA_CHUNK_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10 \* 1024 \* 1024 / 100) ]]; then
>> +	SECOND_DATA_CHUNK_SIZE_B=$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* 1024 \* 1024)
>> +fi
>> +if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10 \* 1024 \* 1024 / 100) ]]; then
>> +	SECOND_METADATA_CHUNK_SIZE_B=$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* 1024 \* 1024)
>> +fi
>> +
>> +echo "Second block group Data alloc size     = ${SECOND_DATA_CHUNK_SIZE_B}"     >> $seqres.full
>> +echo "Second block group Metadata alloc size = ${SECOND_METADATA_CHUNK_SIZE_B}" >> $seqres.full
>> +
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size ${SECOND_DATA_CHUNK_SIZE_B}
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size ${SECOND_METADATA_CHUNK_SIZE_B}
>> +
>> +SECOND_DATA_CHUNK_SIZE_READ_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size)
>> +SECOND_METADATA_CHUNK_SIZE_READ_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size)
>> +
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
>> +echo "Allocated data chunk" >> $seqres.full
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/force_chunk_alloc 1
>> +echo "Allocated metadata chunk" >> $seqres.full
>> +
>> +alloc_size "Data"     SECOND_DATA_SIZE_MB
>> +alloc_size "Metadata" SECOND_METADATA_SIZE_MB
>> +alloc_size "System"   SECOND_SYSTEM_SIZE_MB
>> +
>> +echo "Calculate request size so last memory allocation cannot be completely fullfilled."
>> +free_space FREE_SPACE_MB
>> +
>> +# Find request size whose space allocation cannot be completely fullfilled.
>> +THIRD_DATA_CHUNK_SIZE_MB=$(expr 256)
>> +until [ ${THIRD_DATA_CHUNK_SIZE_MB} -gt $(expr 7 \* 1024) ]; do
>> +	if [ $((FREE_SPACE_MB%THIRD_DATA_CHUNK_SIZE_MB)) -ne 0 ]; then
>> +		break
>> +        fi
> 
> Use tab as indention in above line.
> 

Fixed.

>> +	THIRD_DATA_CHUNK_SIZE_MB=$((THIRD_DATA_CHUNK_SIZE_MB+256))
>> +done
>> +
>> +if [[ ${THIRD_DATA_CHUNK_SIZE_MB} -eq $(expr 7 \* 1024) ]]; then
>> +	_fail "Cannot find allocation size for partial block allocation."
>> +fi
>> +
>> +THIRD_DATA_CHUNK_SIZE_B=$(expr ${THIRD_DATA_CHUNK_SIZE_MB} \* 1024 \* 1024)
>> +echo "Allocation size in mb    = ${THIRD_DATA_CHUNK_SIZE_MB}" >> ${seqres}.full
>> +echo "Allocation size in bytes = ${THIRD_DATA_CHUNK_SIZE_B}"  >> ${seqres}.full
>> +
>> +#
>> +# Do allocation until free space is exhausted.
>> +#
>> +echo "Third allocation."
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size ${THIRD_DATA_CHUNK_SIZE_B}
>> +
>> +free_space FREE_SPACE_MB
>> +while [ $FREE_SPACE_MB -gt $THIRD_DATA_CHUNK_SIZE_MB ]
>> +do
>> +	alloc_size "Data" THIRD_DATA_SIZE_MB
>> +	_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
>> +
>> +	free_space FREE_SPACE_MB
>> +done
>> +
>> +alloc_size "Data" FOURTH_DATA_SIZE_MB
>> +
>> +#
>> +# Force chunk allocation of system block type must fail.
>> +#
>> +echo "Force allocation of system block type must fail."
>> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1 2>/dev/null
>> +if [ $? -ne 0 ]; then
>> +	_dump_err "_set_fs_sysfs_attr cannot write allocation/system/force_chunk_alloc"
> 
> Why _dump_err here? I think a bare echo should do the work. _dump_err is
> mainly used in test harness to save error msg so the report
> infrastructure knows the failure reason from the test harness' point of
> view. Perhaps we should name it as __dump_err.
> 

Fixed.

> Otherwise test looks good to me now. Thanks for all the revisions!
> 
> Thanks,
> Eryu
> 
>> +fi
>> +
>> +#
>> +# Verification of initial allocation.
>> +#
>> +echo "Verify first allocation."
>> +FIRST_DATA_CHUNK_SIZE_MB=$(expr ${FIRST_DATA_CHUNK_SIZE_B} / 1024 / 1024)
>> +FIRST_METADATA_CHUNK_SIZE_MB=$(expr ${FIRST_METADATA_CHUNK_SIZE_B} / 1024 / 1024)
>> +
>> +# if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne $(expr ${FIRST_DATA_SIZE_MB}) ]]; then
>> +if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne ${FIRST_DATA_SIZE_MB} ]]; then
>> +	echo "tInitial data allocation not correct."
>> +fi
>> +
>> +if [[ $(expr ${FIRST_METADATA_CHUNK_SIZE_MB} + ${METADATA_SIZE_START_MB}) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
>> +	echo "Initial metadata allocation not correct."
>> +fi
>> +
>> +#
>> +# Verification of second allocation.
>> +#
>> +echo "Verify second allocation."
>> +SECOND_DATA_CHUNK_SIZE_MB=$(expr ${SECOND_DATA_CHUNK_SIZE_B} / 1024 / 1024)
>> +SECOND_METADATA_CHUNK_SIZE_MB=$(expr ${SECOND_METADATA_CHUNK_SIZE_B} / 1024 / 1024)
>> +
>> +if [[ ${SECOND_DATA_CHUNK_SIZE_B} -ne ${SECOND_DATA_CHUNK_SIZE_READ_B} ]]; then
>> +	echo "Value written to allocation/data/chunk_size and read value are different."
>> +fi
>> +
>> +if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -ne ${SECOND_METADATA_CHUNK_SIZE_READ_B} ]]; then
>> +	echo "Value written to allocation/metadata/chunk_size and read value are different."
>> +fi
>> +
>> +if [[ $(expr ${SECOND_DATA_CHUNK_SIZE_MB} + ${FIRST_DATA_SIZE_MB}) -ne ${SECOND_DATA_SIZE_MB} ]]; then
>> +	echo "Data allocation after chunk size change not correct."
>> +fi
>> +
>> +if [[ $(expr ${SECOND_METADATA_CHUNK_SIZE_MB} + ${FIRST_METADATA_SIZE_MB}) -ne ${SECOND_METADATA_SIZE_MB} ]]; then
>> +	echo "Metadata allocation after chunk size change not correct."
>> +fi
>> +
>> +#
>> +# Verification of third allocation.
>> +#
>> +echo "Verify third allocation."
>> +if [[ ${FREE_SPACE_MB} -gt ${THIRD_DATA_CHUNK_SIZE_MB} ]]; then
>> +	echo "Free space after allocating over memlimit is too high."
>> +fi
>> +
>> +# The + 1 is required as 1MB is always kept as free space.
>> +if [[ $(expr ${THIRD_DATA_CHUNK_SIZE_MB} + ${THIRD_DATA_SIZE_MB} + 1) -le $(expr ${FOURTH_DATA_SIZE_MB}) ]]; then
>> +	echo "Allocation until out of memory: last memory allocation size is not correct."
>> +fi
>> +
>> +status=0
>> +exit
>> +
>> diff --git a/tests/btrfs/251.out b/tests/btrfs/251.out
>> new file mode 100644
>> index 00000000..f5e16ee8
>> --- /dev/null
>> +++ b/tests/btrfs/251.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 251
>> +Capture default chunk sizes.
>> +First allocation.
>> +Second allocation.
>> +Calculate request size so last memory allocation cannot be completely fullfilled.
>> +Third allocation.
>> +Force allocation of system block type must fail.
>> +_set_fs_sysfs_attr cannot write allocation/system/force_chunk_alloc
>> +Verify first allocation.
>> +Verify second allocation.
>> +Verify third allocation.
>>
>> base-commit: 9f8f0e4d5ae00990bac05fbd69a882255bf7bf9f
>> -- 
>> 2.30.2
