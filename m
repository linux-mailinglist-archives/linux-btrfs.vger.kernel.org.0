Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D91461D7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 19:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbhK2SYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 13:24:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11412 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349796AbhK2SWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 13:22:48 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATH2KCu024548;
        Mon, 29 Nov 2021 10:19:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=q0VM9uHqIbvc9ZELhD21Nm+unTO4d3FRCZvlAHpswQk=;
 b=Euz0pD3aNfQwnBsIjji4gpGhWWUSzRF/eDCoq3OEG4rNW8RcBLsB48bYrnKgMN8f90nk
 /A95M9vkUzpbN8pTNm9t3atMq+AfSWZ+T8dGFVRL5NXPPenOXWME0z2TTfNXiUkaUn+R
 0kuu+1pvkrnUqe92PCRx1WGSGlYprLceJeU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cmrm1mq9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Nov 2021 10:19:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 10:19:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuoX6m91shVL1SP4vxZx2HELOv8ObI9JW8syGB9mHdZur04f2TW+npwFVKZg92mebzoPV8WDi/KnDLQ3+tR09c4+G6gqL8m+WfKkG+z2hWpUmzZaCeHBjlDAOLOrtavx0BsAz6tyBSbl0p76qNLiFjBFZFTEOGvKk4VQHIhHuFama/Ktx+rB8kjR5AlqRGXvJB1b9mayd6i1T8xEwowLeF+2oCzRdWjjtALNCcrE6cLlHkGnjXgbFL5IGhmR+Q1NW0BflWp7BSOY9o/dE9h/KYYMHPuzxCBqrYPMlUUvv+JXTSsrQ35d2L/p2ubRzoCa3EBjFc80SLs4IDK9j8paAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0VM9uHqIbvc9ZELhD21Nm+unTO4d3FRCZvlAHpswQk=;
 b=f5WePihJUlL8aE1EWDygfXXESUjBJGRg8ympk55+iqe+GPEByQi4LdwXQjyDJofBZbEPkJ9JTbb84ZUT5VgsnGjFK7mJtiz2i4kNg3aeZpK11Lk3CLrkR5nl+oMA5ESIdtxR2KMwCw5pq3j2/hdHQpiyh7iAoRcaZkDHaB+jb3yqQrTu3DKvDLicn6b7EeEY4JYAftcQYUDyaPeeYzrsRr4mL2NVmv87s19batg3DXA0wMu3kHCJWms9LPCaRTl7ars9Qt93HxBr3VNC3pSHM/MTjh17lqNBmct1JuSojPVYcIPK7KkwFjHVC8drOloj+2dOPiyDKXiR8QyXD/o1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB4413.namprd15.prod.outlook.com (2603:10b6:510:9f::16)
 by PH0PR15MB4477.namprd15.prod.outlook.com (2603:10b6:510:83::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 18:19:24 +0000
Received: from PH0PR15MB4413.namprd15.prod.outlook.com
 ([fe80::c949:5c18:2d16:e014]) by PH0PR15MB4413.namprd15.prod.outlook.com
 ([fe80::c949:5c18:2d16:e014%8]) with mapi id 15.20.4713.022; Mon, 29 Nov 2021
 18:19:24 +0000
Message-ID: <ac69afe4-1cf6-79d5-dd1e-8d1111372a7b@fb.com>
Date:   Mon, 29 Nov 2021 10:19:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v6] btrfs: Add new test for setting the chunk size.
Content-Language: en-US
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <20211124211230.410473-1-shr@fb.com> <YaOmdyoosHntNc5R@desktop>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <YaOmdyoosHntNc5R@desktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:300:115::25) To PH0PR15MB4413.namprd15.prod.outlook.com
 (2603:10b6:510:9f::16)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::14c4] (2620:10d:c090:400::5:cc9a) by MWHPR11CA0039.namprd11.prod.outlook.com (2603:10b6:300:115::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 18:19:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d18f7405-3696-4d8c-126e-08d9b364c574
X-MS-TrafficTypeDiagnostic: PH0PR15MB4477:
X-Microsoft-Antispam-PRVS: <PH0PR15MB4477180E23C3B7F4C0F9D0F6D8669@PH0PR15MB4477.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxKf3/MIArdRC+wH1z89Adfne6msPWknhHS/q1JVn5hysKSc42Z04B6IsfID20Qv7HH0SMHU/7d2hF90DDvvTQJEp+Yp7lg9Lr0Z6ZQG3Z/2MbNQeyCGYArwgG5hKh97kcm7O/rg9/2lHVkDubHxWUA0rQC0kvY0+fgYl8oSUTExjb2l4H2jpuZRhJMJ2Prb1qVqIOqADyjwDrSbZ8asuIn43pwqS51/X1ovbJ1PRXGpJc9yVPB0W9iWBEevBOGY58r34w/8JKrtDmvNbkYtdskcDDZas3XNoN0CSYbbpTkVwH5iEXNonglsNOPQZ0IhvuG0EKPRQRpfSfpiHbWA5FQEB09SziwjNNRxmPViW95a0v04KXFBT06hUDDnCDvYxKm1CnSp2Dmtr4NOlvpEWt0STuNP5pFka8DlYLff1ee5+Wf7jAMQb2DW77N11QO0bTP3EPY6tVbIjpAjBtuiVodTgCBT5FUi2TVTxn0p/CPxGp0jUpKSH6EBLNyrEvh/2q6uerN7yPL0LLw7wc0AlHiwkIlSVVgx/Oi3VWP7q8KeMBprvuIL6YpOpg13gN5P48MxxF1kjeiQLzG+HuwUr2HgNfeyhMK3hBHJYtqWXJ29cGW0XwnUS01AoA2qC9fOtuLNiRCqEkYX18b/qwBuRqfFvzq2mQ7poOLL1XM7phokKhwOkfvc2VVPK3AYV+srkyObrmbsJP+ZDJFf/yNxC7X3VxSXG9bgl7wmGJURM6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB4413.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(8676002)(83380400001)(186003)(31696002)(5660300002)(53546011)(8936002)(2616005)(38100700002)(66556008)(66476007)(66946007)(316002)(2906002)(36756003)(4326008)(6486002)(30864003)(6916009)(508600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5SUzZlV3o2MTE5VGt0V0N0Y3FBOEJZTEUxM0ZCR2hZT2I2cXhLYjdyOWdq?=
 =?utf-8?B?VWNNZFdpMlA0Q0dNSjhVS1lJeDl6d3c0Y1JzTlJOcTlDUGZlaDVTUXkyYVNV?=
 =?utf-8?B?RDVBS1pYU2JQRFNvT2tEQmpvRVFiVXhza2E4cXppcXI1dS8vOGx3SjYyM3dB?=
 =?utf-8?B?RTB0M25XQkc0WUt3bmtGakZqZWF4cTJyeTZQdTlRRm54RURVc25xbWdCRk05?=
 =?utf-8?B?dytKODhrVDNwMFUwaGZjalVxZUtyVHRqS1E1bDNXR0k4aXlBSkg5NkhTb2NV?=
 =?utf-8?B?SXNLYnRuaGkrU1orK1JxTnovL3ltbmNqVmp1bzFIOWZ4Vkc2SU9naU1CcEFh?=
 =?utf-8?B?aXdjb3J6Y0xsYk9GQTU2bzhCYWdDSE5KZWlpeHI5OEc5QjZVOVNCTHMyTHFI?=
 =?utf-8?B?UXJoTVJNYzBmUHNRUndvdXg1OVh6cGJlUWJreWJHZjNVT2thZ1ZCM0I4YkU0?=
 =?utf-8?B?SllqZGFEY0tGNVB5aVVCcUVoVWl2MW5lS1FyMmJ1MlMwVzRLY3FjcmVGWERk?=
 =?utf-8?B?Z1V0OHFxNGRzRjFLQVFFWGttejRTV0ZKdUcwSkNHT3ViU2tKZUEwUXhyajJu?=
 =?utf-8?B?ZTQxWGdrVjBhbTlaTEFtYkttb0ZoeGxLR2VTbU9iY1hGN3FJcmxmRG4vQUxD?=
 =?utf-8?B?dWUxNDJ4dVUxRk9wUmVJWHBkQ1dNQ2dka2dKUEVVQkpCVUNFcEFkMmhUSWYr?=
 =?utf-8?B?dDFyOEgvajZNYURjRXZOZlEyU3Q2amJ3aWxzV3BVWnlncFQ1ZWdrZ0hDR3ZY?=
 =?utf-8?B?a3lmQnRCQk8wU3JXZlhucmlnNjlZa1dWckpWSXBmN0lsR3Fxa1MxM0p0bzFI?=
 =?utf-8?B?eVUvN2pmODZsWThkRDBkRm5GcTdGVFJ1M0dzbHRRZjJxWmFkTnlrTGszOG5R?=
 =?utf-8?B?L2xxdjg4MWVQMkp3QWFoR2c3L1ZvK1prMzJQQStaZnpEWEw4RktZcUg3SXRr?=
 =?utf-8?B?SUozcGZZRGRCQm92Vlh4WWY5cjI4a3pFMlRvdFhkbTdZcEV2VDgvdE5wbFlF?=
 =?utf-8?B?a3RUQytwWEUrUHMzc243WXVhc21vZXVxZ05TdEV1T2M1YkdUS1pkVGFadStn?=
 =?utf-8?B?ZXBOUGJ2WFVwM1N0V25nMWNmL3hHcnU0M1BlRStoVzBDRWxRalI2MGNrRE1t?=
 =?utf-8?B?c0p4R3NKVGpySkdwVlAzZ1FSeitoZ0ZNaU5SOG9rQTloNGdlazlTYXVGUzBL?=
 =?utf-8?B?SjZ4eTRpbDFjS3FEN2hRUG1HSmJ2T0dTeWpuQUduOURZS2V0WnkxMkR2N3Fr?=
 =?utf-8?B?YkdIOUNPejdJZGhRRTJZMzM5TkQ1K2VTUk9lY1ZsL2VuNXNSTUQ1Q1l0VU0v?=
 =?utf-8?B?RkV5dEVlMVBWZ0tvdytabXBaK0lRaVFOUTU0WVhaVDhmUVFza0EvY0NvaWVx?=
 =?utf-8?B?UVFBdHJ6cEZnZXJFUFpBandLdmcvalJ5c01yR2lwTDFLa2ZualBWVXQ5ejc0?=
 =?utf-8?B?SHoyTGJsVGhEcUpQS2J0UEVJZzNrU3JsQkFSUFdWUkZ2NlNFYU1aL2d6UnIr?=
 =?utf-8?B?UXFSZXZMYXMxVEozZHo3V1c0WnM1YjA2dFBPaGZWMWptNVlNUmpSaUsyUHJW?=
 =?utf-8?B?VVdUeXhnZHQ5K004UExFM2dzdGdBeTRSNnY1U2hXeHlpRVhPVTNyZzBid0I5?=
 =?utf-8?B?YzBVTUxiMVdDbzMxeWxoTll5TFluaVFPTk8xK0xBUEFKRXRkN2pnMzF4VnJn?=
 =?utf-8?B?TFArSXZwWDE3a1ZCL0dQcVdPdUg0R1pURGo4WDIyTWNXVEN3MUcvWkZDMkNZ?=
 =?utf-8?B?Z3A4bnh4SjErKytUc3hrUEpnU2VHT0xQaWRLcGU2UWRxU1gwMERGVjBMOWVr?=
 =?utf-8?B?VWs0cFpOdUlNKzkzZVBkVGpWbjBYaXBVVjcrYjVoa2h2aVYwa0ppTjR0VU1u?=
 =?utf-8?B?UGxQUnl3U2pGcVhiZ1Jzb0VXRUdpckNWZmoyOTBnSWo0UDhVbDJMWjJPa2pa?=
 =?utf-8?B?Qmh3T3A4WGhzL2o5N3lGTjlCdXkyclRSQlRYbm9QemdqR2JmT2h1bjdjY3RQ?=
 =?utf-8?B?ajAzR3hWQ01aTFhHemRxaDdqSnU1VGgwbEY3WE16WGQ3bWd5L1Q3ZVpBYStu?=
 =?utf-8?B?T09DODlMbUpXdmhsbkdUSmFxVHBXNGd6VGhIdlNkK1MzUGQ2TlU4a0xqU3hh?=
 =?utf-8?Q?gM6232DOxZq30Sa07E+xfqEao?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d18f7405-3696-4d8c-126e-08d9b364c574
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4413.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:19:24.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVemgdm316KXY952B6ElW77l7fsKuVa+CBZl5/q2dNrOyVcBGXW7/M/NWRmp4DB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4477
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: sntHdlVZMujWZNhz_wm4H_YtIrBUhROi
X-Proofpoint-ORIG-GUID: sntHdlVZMujWZNhz_wm4H_YtIrBUhROi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290085
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/28/21 7:55 AM, Eryu Guan wrote:
> On Wed, Nov 24, 2021 at 01:12:30PM -0800, Stefan Roesch wrote:
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
>>  common/rc           |  29 ++++-
>>  tests/btrfs/251     | 287 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/251.out |  11 ++
>>  3 files changed, 323 insertions(+), 4 deletions(-)
>>  create mode 100755 tests/btrfs/251
>>  create mode 100644 tests/btrfs/251.out
>>
>> diff --git a/common/rc b/common/rc
>> index 0a30a842..9522ba2e 100644
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
>> @@ -4436,10 +4443,17 @@ _set_fs_sysfs_attr()
>>  	local content="$*"
>>  
>>  	if [ ! -b "$dev" -o -z "$attr" -o -z "$content" ];then
>> -		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
>> +	 	_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
> 
> What is this change? Seems it adds a space between the first two tabs,
> and causes git am to complain about whitespace damange.
> 

Fixed.

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
>> index 00000000..b5c4b623
>> --- /dev/null
>> +++ b/tests/btrfs/251
>> @@ -0,0 +1,287 @@
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
>> +test_file="${TEST_DIR}/${seq}"
> 
> Seems it's not used in the test?
> 

Correct. I removed it.

>> +seq=`basename $0`
>> +seqres="${RESULT_DIR}/${seq}"
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f "$test_file"
> 
> Then there's no need to remove it in cleanup
> 

Removed.

>> +}
>> +
>> +# Parse a size string which is in the format "XX.XXMib".
>> +#
>> +# Parameters:
>> +#   - (IN)    Block group type (Data, Metadata, System)
>> +#   - (INOUT) Variable to store block group size in MB
>> +#
>> +parse_size_string() {
>> +	local SIZE=$(echo "$1" | $AWK_PROG 'match($0, /([0-9.]+)/) { print substr($0, RSTART, RLENGTH) }')
>> +        eval $2="${SIZE%.*}"
> 
> The above "eval" line uses spaces as indentions not tab.
> 

Fixed.

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
>> +}
>> +
>> +. ./common/filter
>> +_supported_fs btrfs
>> +_require_test
>> +_require_scratch
>> +_require_btrfs_fs_sysfs
> 
> Looks like we could drop this require, as _require_fs_sysfs below
> ensures this requirement must be met.
> 

Removed.

>> +
>> +# Delete log file if it exists.
>> +rm -f "${seqres}.full"
>> +
>> +# Make filesystem.
>> +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
> 
> Any reason we need a 10G filesystem? Some comments would be good.
> 

I added a comment.

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
>> +fi
> 
> I don't think we need this check. We could just remove the
> "2 > /dev/null" part from the above _set_fs_sysfs_attr and it will print
> error message and break golden image on error.
> 

If we don't add this, we need to add an error message to the log like:
/common/rc: line 4457: echo: write error: No space left on device

This is pretty fragile.

> Thanks,
> Eryu
> 
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
>> index 00000000..bb7b45d8
>> --- /dev/null
>> +++ b/tests/btrfs/251.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 248
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
>> -- 
>> 2.30.2
