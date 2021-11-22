Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633FF45960B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 21:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbhKVU1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 15:27:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240451AbhKVU1X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 15:27:23 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMH7ZTZ031542;
        Mon, 22 Nov 2021 12:24:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AdRll3p559NPxSlG8JjsBH7AGR+Bw32dliLF507Qq6Y=;
 b=beqxQ9S6TV1YJEb0sOpZEO96tbPwZPJpQcoMRYWYaiaaC5Oh4fBz4h719wV1BXeUSrae
 UiG/k2bbZh8f+uU4OcNUOJ+uM3CyBXZh6ZkOL/x0PCEFnmBaAa/MXVx02dRQE5x4qdkS
 EaJUa6XDJm1x3yTvLvQEPuku2FllyPF6c74= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cg5gjd4dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 12:24:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 12:24:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqIXr44lt6FJSRgBD3V0WcA4TvUdeScyMUSp/emeKjcLJHXtmeQLQpk+Y1WQ4FHCo1Znu0uuZy3oYdVMByUj4HC+ibUB96YYcZG9LuMT61MhbxE7HFaebOGrbYON6AT8U/AKKu5DhS9xqq4fa26/FNKWYCAOUOOizcc+GtgbCduLFBlXH2VVzlKy28vs1sJ2GdeBCJK7JamNQFaap3AQu7sJRZ6s7qd1rSgGbb+X4kbTRXXtxnAT7xOwlvltqPq3aLw6WrNcsZR97oIR2salJJWTxBRV+WewIsXMpgD238PA+KwPK5PCCJP9MbCa3fo9JD5dyMQ+YxTuhMQQ4UpHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdRll3p559NPxSlG8JjsBH7AGR+Bw32dliLF507Qq6Y=;
 b=ZEA4acOTtwKlcYZ7dWNBu7tO5eocls7ew0SFfNLQiHEwL+jC49ei900q+kzZdtEY2vlSstm5NDc6AuKOViD+r5QqF7/wIOF7rdWD53hScLLKgtHcw17jhOQ6u1l2PXxpV2XGURAn8gF8lMwCOMq32D2U8dZdFWFP3wUNZJ/fekh9VpkguoK+hz47+p7UTnpSfit2Bet7bwwNtWV/XEThK8EzjZxwkMU+9hAf0Mg3SsrWjKYhf6unhYtQKJCBCnPfmDXiS5miRzNR0D/RnCWo/37EdwyQr1FMUEt+gCQD4eKHHFNecKIxNls3CDMYW7naEO5FQs6AMOfxt1yS3jkOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MWHPR15MB1293.namprd15.prod.outlook.com (2603:10b6:320:24::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 20:24:10 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f8de:1089:be1d:7bf]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f8de:1089:be1d:7bf%7]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 20:24:10 +0000
Message-ID: <d74c5392-6105-2e39-6eef-5175fd4ae0df@fb.com>
Date:   Mon, 22 Nov 2021 12:24:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4] btrfs: Add new test for setting the chunk size.
Content-Language: en-US
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20211102212329.3708782-1-shr@fb.com> <YZpbFu9UZp6LyFks@desktop>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <YZpbFu9UZp6LyFks@desktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0051.namprd22.prod.outlook.com
 (2603:10b6:300:12a::13) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::12d4] (2620:10d:c090:400::5:fcbd) by MWHPR22CA0051.namprd22.prod.outlook.com (2603:10b6:300:12a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 20:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89bdd678-0655-4526-5c4e-08d9adf60ab1
X-MS-TrafficTypeDiagnostic: MWHPR15MB1293:
X-Microsoft-Antispam-PRVS: <MWHPR15MB1293AFD8FAFF7A1E83DDD594D89F9@MWHPR15MB1293.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfiXymxoTfIO3aKuQirdS4kR63C4wtVfUNeCjJhsVM+Xs1Sa4GKof1qscvFnV3CwJpmNjwW20SkT67ITezIoHY67LNlFg3CVtA7MJEyv7hMsIi8SGkqMEWgyEOGcqPBfhudXjkTj9x9QfNmv6gVLZ7QESH6bvrnMnWpAZC/EEkYaQdEnOvGGbpf8A/uq2a9ErLiER9U2L6Ykz5YJTKqPgjaK2D/W71Ol1ALgiyCwuRBJl8cCaGrplVRHrM5BqXYm/sfiuKjND21r2/a61LdMHVZnWRwL6X5UJztVr8jtEGKCvfIMn4iKPJ/daNFPU8WsvVzIjQw2PCTeNTjdEL3iAxueuiHq3jzitWRI8tqrWtTrNXaPc7j8OShtsN5kwCdYwPqSYYeZtrfZEqV5OrNhocCwcr3cAGrBkbjYlCkv3BhVTuAKSWKWGEWeYd2N3Zx/kjsCarWspsGWEesXDFi6hN/Cvc1AKzTTTHebXbuNk0D3yhZ+TfsTCEYlaPEy3npcToVQteCZc2V6Z2EkMKDRxEbPHXgezKD8ty6YEN9Ih4X1twEh1usuBSOhHwSYm4yqWIIym2r1cwGJYgPJbX2e8t3J2eEKNfEaTmpBUN9cGe+OgNT6k/bX5w3uzOSS/D9k/VeozaeDz8W89PRLqOqKcZcr6CJx4QzZJT4hAIQ+32tQqanfRc2K/D9FA78y0Gvs31zENF8Z+LmKpxRYoaMeAy+C91n277lh7fVFlYN8sHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(8936002)(5660300002)(8676002)(31686004)(508600001)(66946007)(66556008)(66476007)(4326008)(38100700002)(53546011)(86362001)(6916009)(2906002)(2616005)(31696002)(316002)(36756003)(186003)(83380400001)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VvYTR1Skg1UFpZN0U3UWc3Nng5b0p2SnQ2cHdzM2wwd0YzMWU2a1FHSXpQ?=
 =?utf-8?B?L2YwYjBJSzF1blB1bGpYWFdoWVgyaElVdmVRSmtaVW84bHFXcHlqc0VyaC96?=
 =?utf-8?B?TWdPTnkvZ2RCd2FUS25kWEc3MEpxZGRwc2ZJVUd3aWRFSUp5NmlybTNHbGgr?=
 =?utf-8?B?eWpKV05FaXVRRmtYa3gvdkZPd3hRaXZlWTRWeUZXcWRMY25JU25lSXVpcThv?=
 =?utf-8?B?aFFCR041MjQwM1JLVnhjSW1BbnZpN2h0cWdpcU4xa0F1TGp0QTVIQSsyamx4?=
 =?utf-8?B?RU8xQ2VTei9kNXhWMk9Qa0lmdDZUZ2JUdUFyWUFUMkh5dDJUSGFmR3RGVmZw?=
 =?utf-8?B?NDNrMzZ2VjRxWHBjT3FKRHVKUWZIVWtHVEYzaHhSSzIvaGE0REl5L1dqUVpK?=
 =?utf-8?B?VHlhVkNlSVJ6YTRxOUs1RUZCcmt3dXIwT0VhMEl3VCsybGpRcTV6cENFSVJu?=
 =?utf-8?B?Um45WFhlR0RDWTZoY3UyUnhVVVprWlQ3dVhBZVFLY1JzSEZkZlhYdk9XUWor?=
 =?utf-8?B?WWE1Ry85bTRvT3hweCtpVnk5eFpzM3VidkJjWnZ1UDlQOTlzT0FDNDZiako2?=
 =?utf-8?B?eHQ1TEIrQmhVcFBSNlNJWkFid3IrbEpZSGJFTVVzQ29NT2pPNFRISzdCYWRQ?=
 =?utf-8?B?T1hwZ1oyUCs4V3R1Vk5sS0FNQ2tKRk1UaFRRU2IyTEppVkVCWGdlSEdFZHUr?=
 =?utf-8?B?TFJMSVdMYUZXUWEvR1FhVG1kb2NISU1TMXZqbUFPV1I1cWFkYk5rSE9jNEli?=
 =?utf-8?B?RXFCalZwNUZONXoxNzl6dVVIemNEZk85REdXOWoxQ0pSa3MwMkZsVnQxYWl6?=
 =?utf-8?B?dUVRN0FmQWJDVTRXQXprdlZrdDMrR1crNkZnV0ZkUlUyNmN1bW1jNDZsV29y?=
 =?utf-8?B?ODRZdkdseTVMVWpnRStYeWdKM0ZvQ0IrdWYxeU55Y0FucE9FYnNTdFFVeUxa?=
 =?utf-8?B?Tmp2MWpYemVBcTF6cE1YWHowQk42YkRjOUlMc3lEcFh6V2w1cm92ZTlkTWk3?=
 =?utf-8?B?WmVxNWdHL0VnZ1BPSzhPbUFhTkZ0RnJGMFJ0eVFSWWpvSGFyZXJ6RkVYNWoy?=
 =?utf-8?B?WVd3V0MzbGs2enQ1bUo1OTZsU1ljWWtWYmNwRFZUOEFHdFlzTXp4ODNjN1VL?=
 =?utf-8?B?alhwUXJjVFkrWjQ0VXBBWXRZdW9Ud1Vzb2FzTTdodWVxZVQzSU9rNlJXMXQz?=
 =?utf-8?B?bnBhanZmZzZqK2NOMVp5MmQrVDN3V01RL3h3aFh2OVFOeGxuc25iNmlKM1py?=
 =?utf-8?B?eWVPQWFEaFJEZ2xGTGdRZW1aMFY3MWJtdHp1ME5YOWZKSzRObThFSDg0eTF0?=
 =?utf-8?B?YVdFTGdaNWsvV1dNeWxML3ZFdjdmK0JhZTVFVUR4clUvU2JGaVlUclhVNlNP?=
 =?utf-8?B?bjVmZjk5Nk4vd2p6ZUxuaTZiVStIdHArTVBwdUZLTll1V3A1eGJ5dnlIUC9l?=
 =?utf-8?B?U2pNYWdJYmNsd0F1dnhZUjcwamxPTzBGVG42SnIxdWc4VitlS0Z1MWxITHpj?=
 =?utf-8?B?dzZTR2pLRnBsWmUxeUJSR2tvNHMrUk9aRTNVYVJVWEdpaFdvUDYxWThYVzNE?=
 =?utf-8?B?eFE2MXF6d0FKZS95eWJ4b201UDdSVWMrVjlteHZkZ2xhSGZsK3FqNmhEWFhB?=
 =?utf-8?B?S3pPUEVYazhYNmNNQWpiZzU0cXdDT3M0V1lQUnQ4bEYrcFJ4R2U5WlBuVlNM?=
 =?utf-8?B?WCtXQ0k5QitMeXlOWjRreDJ6MENtUUQ2ZXJndkFLTndZZnJ4aUxEaHRBOXMy?=
 =?utf-8?B?UFpVYWluZ2dlbUVxc0ZPNXVSN00xZlhid0hUT1FsTWVjbkFZWndUMS80UlhG?=
 =?utf-8?B?T0NUbWo5ZUw2MkN6M2dlUHh5RnBCclo1N29SbjMyOS9RYUdqcWZBNTcrVzU0?=
 =?utf-8?B?YndCT0Z4UzJ2aVRRWnNQY0kwTVB1WURsNHJsVTNDNUsxMUtmRlBpcTIxaVRQ?=
 =?utf-8?B?bDZEdkVoTFljUS8zMUp5ejZkeHpoTkN0ZlpBdlNicGFXbXhlRlYrdWI2VlJ6?=
 =?utf-8?B?WFNBbXNaME5JQTcwNFVyZHg0WHpVWmprRTc4am5vMytQa3F5Ykp2amkrNWdM?=
 =?utf-8?B?NnhqQWQ0Rk04aGYwR3dxdGU2TWRRTU5Fa3ZvUjlGUzlDZkpQUUJJNWJXWFFQ?=
 =?utf-8?Q?SFtCNfWUopQuGw/NoByCV+4xk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bdd678-0655-4526-5c4e-08d9adf60ab1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 20:24:10.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wCKbSZET+j6/FD5pAEHSiqq6T3h3cF0VzsKLssNtH3NEB1BllO1zJ3dCW/CYJT5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1293
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: JQR94Z-w1K1sM2LfEDNiGG0x9Y_LtYqd
X-Proofpoint-GUID: JQR94Z-w1K1sM2LfEDNiGG0x9Y_LtYqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/21/21 6:43 AM, Eryu Guan wrote:
> On Tue, Nov 02, 2021 at 02:23:29PM -0700, Stefan Roesch wrote:
>> Summary:
>>
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
> 
> Sorry for the late review.. I noticed some other minor issues below.
> 
>> ---
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
>>  common/btrfs        |  73 ++++++++++++
>>  tests/btrfs/049     | 280 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/049.out |  11 ++
>>  3 files changed, 364 insertions(+)
>>  create mode 100755 tests/btrfs/049
>>  create mode 100644 tests/btrfs/049.out
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index ac880bdd..d6a7585d 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -445,3 +445,76 @@ _scratch_btrfs_is_zoned()
>>  	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
>>  	return 1
>>  }
>> +
>> +# Print the content of /sys/fs/btrfs/$UUID/$ATTR
>> +#
>> +# All arguments are necessary, and in this order:
>> +#  - mnt: mount point name, e.g. $SCRATCH_MNT
>> +#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
>> +#
>> +# Usage example:
>> +#   _get_btrfs_sysfs_attr /mnt/scratch allocation/data/stripe_size
>> +_get_btrfs_sysfs_attr()
>> +{
>> +	local mnt=$1
>> +	local attr=$2
>> +
>> +	if [ ! -e "$mnt" -o -z "$attr" ];then
>> +		_fail "Usage: _get_btrfs_sysfs_attr <mounted_directory> <attr>"
>> +	fi
>> +
>> +	local uuid=$(findmnt -n -o UUID ${mnt})
>> +	cat /sys/fs/btrfs/${uuid}/${attr}
>> +}
>> +
>> +# Write "content" into /sys/fs/btrfs/$UUID/$ATTR
>> +#
>> +# All arguments are necessary, and in this order:
>> +#  - mnt: mount point name, e.g. $SCRATCH_MNT
>> +#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
>> +#  - content: the content of $attr
>> +#
>> +# Usage example:
>> +#   _set_btrfs_sysfs_attr /mnt/scratch allocation/data/chunk_size
>> +_set_btrfs_sysfs_attr()
>> +{
>> +	local mnt=$1
>> +	shift
>> +	local attr=$1
>> +	shift
>> +	local content="$*"
>> +
>> +	if [ ! -e "$mnt" -o -z "$attr" -o -z "$content" ];then
>> +		_fail "Usage: _set_btrfs_sysfs_attr <mounted_directory> <attr> <content>"
>> +	fi
>> +
>> +	local uuid=$(findmnt -n -o UUID ${mnt})
>> +	echo "$content" > /sys/fs/btrfs/${uuid}/${attr} 2>/dev/null
>> +	if [ $? -ne 0 ]; then
>> +		_dump_err "_set_btrfs_sysfs_attr cannot write ${attr}"
>> +	fi
>> +}
> 
> It seems that above two functions are almost identical to the generic
> counter parts in common/rc, the only difference is _[gs]et_sysfs_attr()
> takes device as first arg and uses the short dev name not filesystem
> UUID.
> 
> So I'm wondering if it's possible to extend _[gs]et_sysfs_attr() to
> support btrfs as well, i.e. we sill pass device as the first arg, and
> find uuid by dev if $FSTYP is btrfs, e.g.

Done. 

> 
> 	local dname
> 	case "$FSTYP" in
> 	btrfs)
> 		dname=$(findmnt -n -o UUID ${dev}) ;;
> 	*)
> 		dname=$(_short_dev $dev) ;;
> 	esac
> 
>> +
>> +# Verify if the sysfs entry in /sys/fs/btrfs/$UUID/$ATTR exists
>> +#
>> +# All arguments are necessary, and in this order:
>> +#  - mnt: mount point name, e.g. $SCRATCH_MNT
>> +#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
>> +#
>> +# Usage example:
>> +#   _require_btrfs_sysfs_attr /mnt/scratch allocation/data/chunk_size
>> +_require_btrfs_sysfs_attr()
>> +{
>> +	local mnt=$1
>> +	local attr=$2
>> +
>> +	if [ ! -e "$mnt" -o -z "$attr" ];then
>> +		_fail "Usage: _get_btrfs_sysfs_attr <mounted_directory> <attr>"
>> +	fi
>> +
>> +	local uuid=$(findmnt -n -o UUID ${mnt})
>> +	if [[ ! -e  /sys/fs/btrfs/${uuid}/${attr} ]]; then
>> +		_notrun "Btrfs does not support sysfs $attr"
>> +	fi
>> +}
> 
> I think this could be done by extending _require_fs_sysfs() in the same
> way.
> 

Unfortunately the function require_fs_sysfs_attr does not pass in the device, it uses the environment variable
$TEST_DEV directly.

>> +
>> diff --git a/tests/btrfs/049 b/tests/btrfs/049
>> new file mode 100755
>> index 00000000..780636ae
>> --- /dev/null
>> +++ b/tests/btrfs/049
>> @@ -0,0 +1,280 @@
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
>> +seq=`basename $0`
>> +seqres="${RESULT_DIR}/${seq}"
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f "$test_file"
>> +}
>> +
>> +# Parse a size string which is in the format "XX.XXMib".
>> +#
>> +# Parameters:
>> +#   - (IN)    Block group type (Data, Metadata, System)
>> +#   - (INOUT) Variable to store block group size in MB
>> +#
>> +_parse_size_string() {
> 
> Local functions don't need the leading underscore, the same applies to
> other local functions in this test (except _cleanup).

Done.

> 
>> +	local SIZE=$(echo "$1" | awk 'match($0, /([0-9.]+)/) { print substr($0, RSTART, RLENGTH) }')
> 
> Use $AWK_PROG instead of bare awk.

Done. 
> 
>> +        eval $2="${SIZE%.*}"
>> +}
>> +
>> +# Determine the size of the device in MB.
>> +#
>> +# Parameters:
>> +#   - (INOUT) Variable to store device size in MB
>> +#
>> +_device_size() {
>> +	btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid >> $seqres.full
> 
> Use $BTRFS_UTIL_PROG instead of bare 'btrfs', also please use full
> subcommand instead of abbr. like 'fi'.
> 

Done.

>> +	local SIZE=$(btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid)
>> +	_parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
>> +	eval $1=${SIZE_ALLOC%.*}
>> +}
>> +
>> +# Determine the free space of a block group in MB.
>> +#
>> +# Parameters:
>> +#   - (INOUT) Variable to store free space in MB
>> +#
>> +_free_space() {
>> +	local SIZE=$(btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid)
>> +	_parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
>> +	_parse_size_string $(echo "${SIZE}" | awk '{print $6}') SIZE_USED
>> +	eval $1=$(expr ${SIZE_ALLOC} - ${SIZE_USED})
>> +}
>> +
>> +# Determine how much space in MB has been allocated to a block group.
>> +#
>> +# Parameters:
>> +#   - (IN)    Block group type (Data, Metadata, System)
>> +#   - (INOUT) Variable to store block group size in MB
>> +#
>> +_alloc_size() {
>> +	local SIZE_STRING=$(btrfs filesystem df ${SCRATCH_MNT} -m | grep  "$1" | awk '{print $3}')
>> +	_parse_size_string ${SIZE_STRING} BLOCK_GROUP_SIZE
>> +        eval $2="${BLOCK_GROUP_SIZE}"
>> +}
>> +
>> +. ./common/filter
>> +_supported_fs btrfs
>> +_require_test
>> +_require_scratch
>> +_require_btrfs_fs_sysfs
>> +
>> +# Delete log file if it exists.
>> +rm -f "${seqres}.full"
>> +
>> +# Make filesystem.
>> +_require_scratch_size $((10 * 1024 * 1024)) #kB
> 
> _scratch_mkfs_sized() will check for the required size and _notrun if
> dev is too small, so there's no need to call above _require rule.
> 

Done.

>> +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
>> +_scratch_mount >> $seqres.full 2>&1
>> +
>> +# Check if there is sufficient sysfs support.
>> +_require_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size
>> +_require_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_alloc
>> +
>> +# Get free space.
>> +_free_space  FREE_SPACE_MB
>> +_device_size DEVICE_SIZE_MB
>> +
>> +echo "free space = ${FREE_SPACE_MB}MB" >> ${seqres}.full
>> +
>> +# Get chunk sizes.
>> +echo "Capture default chunk sizes."
>> +FIRST_DATA_CHUNK_SIZE_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size)
>> +FIRST_METADATA_CHUNK_SIZE_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size)
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
>> +_alloc_size "Data"     DATA_SIZE_START_MB
>> +_alloc_size "Metadata" METADATA_SIZE_START_MB
>> +
>> +echo "Block group Data alloc size     = ${DATA_SIZE_START_MB}MB"     >> $seqres.full
>> +echo "Block group Metadata alloc size = ${METADATA_SIZE_START_MB}MB" >> $seqres.full
>> +
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_alloc 1
>> +
>> +_alloc_size "Data"     FIRST_DATA_SIZE_MB
>> +_alloc_size "Metadata" FIRST_METADATA_SIZE_MB
>> +
>> +echo "First block group Data alloc size     = ${FIRST_DATA_SIZE_MB}MB"     >> ${seqres}.full
>> +echo "First block group Metadata alloc size = ${FIRST_METADATA_SIZE_MB}MB" >> ${seqres}.full
>> +
>> +_free_space FREE_SPACE_AFTER
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
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size ${SECOND_DATA_CHUNK_SIZE_B}
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size ${SECOND_METADATA_CHUNK_SIZE_B}
>> +
>> +SECOND_DATA_CHUNK_SIZE_READ_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size)
>> +SECOND_METADATA_CHUNK_SIZE_READ_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size)
>> +
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
>> +echo "Allocated data chunk" >> $seqres.full
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_alloc 1
>> +echo "Allocated metadata chunk" >> $seqres.full
>> +
>> +_alloc_size "Data"     SECOND_DATA_SIZE_MB
>> +_alloc_size "Metadata" SECOND_METADATA_SIZE_MB
>> +_alloc_size "System"   SECOND_SYSTEM_SIZE_MB
>> +
>> +echo "Calculate request size so last memory allocation cannot be completely fullfilled."
>> +_free_space FREE_SPACE_MB
>> +
>> +# Find request size whose space allocation cannot be completely fullfilled.
>> +THIRD_DATA_CHUNK_SIZE_MB=$(expr 256)
>> +until [ ${THIRD_DATA_CHUNK_SIZE_MB} -gt $(expr 7 \* 1024) ]
>> +do
> 
> Please unify the code style as
> 
> until [ ... ]; do
> 	<do something>
> done
> 

Done.

>> +	if [ $((FREE_SPACE_MB%THIRD_DATA_CHUNK_SIZE_MB)) -ne 0 ]; then
>> +	       break
>> +        fi
> 
> Mixed space and tab as indention above?
> 
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
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size ${THIRD_DATA_CHUNK_SIZE_B}
>> +
>> +_free_space FREE_SPACE_MB
>> +while [ $FREE_SPACE_MB -gt $THIRD_DATA_CHUNK_SIZE_MB ]
>> +do
>> +	_alloc_size "Data" THIRD_DATA_SIZE_MB
>> +	_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
>> +
>> +	_free_space FREE_SPACE_MB
>> +done
>> +
>> +_alloc_size "Data" FOURTH_DATA_SIZE_MB
>> +
>> +#
>> +# Force chunk allocation of system block tyep must fail.
>> +#
>> +echo "Force allocation of system block type must fail."
>> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/system/force_chunk_alloc 1 2>/dev/null
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
>> +	_fail "tInitial data allocation not correct."
> 
> No need to call _fail, we could just echo this message and it will break
> the golden image and fail the test. Also, dumping the expected and
> actual value to stdout may help debug failure.
> 
> The same applies to other _fail calls below as well.
> 

Done.

> Thanks,
> Eryu
> 
>> +fi
>> +
>> +if [[ $(expr ${FIRST_METADATA_CHUNK_SIZE_MB} + ${METADATA_SIZE_START_MB}) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
>> +	_fail "Initial metadata allocation not correct."
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
>> +	_fail "Value written to allocation/data/chunk_size and read value are different."
>> +fi
>> +
>> +if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -ne ${SECOND_METADATA_CHUNK_SIZE_READ_B} ]]; then
>> +	_fail "Value written to allocation/metadata/chunk_size and read value are different."
>> +fi
>> +
>> +if [[ $(expr ${SECOND_DATA_CHUNK_SIZE_MB} + ${FIRST_DATA_SIZE_MB}) -ne ${SECOND_DATA_SIZE_MB} ]]; then
>> +	_fail "Data allocation after chunk size change not correct."
>> +fi
>> +
>> +if [[ $(expr ${SECOND_METADATA_CHUNK_SIZE_MB} + ${FIRST_METADATA_SIZE_MB}) -ne ${SECOND_METADATA_SIZE_MB} ]]; then
>> +	_fail "Metadata allocation after chunk size change not correct."
>> +fi
>> +
>> +#
>> +# Verification of third allocation.
>> +#
>> +echo "Verify third allocation."
>> +if [[ ${FREE_SPACE_MB} -gt ${THIRD_DATA_CHUNK_SIZE_MB} ]]; then
>> +	_fail "Free space after allocating over memlimit is too high."
>> +fi
>> +
>> +# The + 1 is required as 1MB is always kept as free space.
>> +if [[ $(expr ${THIRD_DATA_CHUNK_SIZE_MB} + ${THIRD_DATA_SIZE_MB} + 1) -le $(expr ${FOURTH_DATA_SIZE_MB}) ]]; then
>> +	_fail "Allocation until out of memory: last memory allocation size is not correct."
>> +fi
>> +
>> +status=0
>> +exit
>> +
>> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
>> new file mode 100644
>> index 00000000..ae99d6f0
>> --- /dev/null
>> +++ b/tests/btrfs/049.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 049
>> +Capture default chunk sizes.
>> +First allocation.
>> +Second allocation.
>> +Calculate request size so last memory allocation cannot be completely fullfilled.
>> +Third allocation.
>> +Force allocation of system block type must fail.
>> +_set_btrfs_sysfs_attr cannot write allocation/system/force_chunk_alloc
>> +Verify first allocation.
>> +Verify second allocation.
>> +Verify third allocation.
>> -- 
>> 2.30.2
