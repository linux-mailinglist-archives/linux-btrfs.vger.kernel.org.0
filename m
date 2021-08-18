Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99793EFBB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhHRGOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:14:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61402 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240439AbhHRGOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:14:30 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I6AOfe019608;
        Wed, 18 Aug 2021 06:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=evjI4vSJyvLF2JTwZwAKw9hQUSv4lJ1l6KfvZxoEnf0=;
 b=lT8Kl54jdv+nCRtQO8fRz8CX7THdnpq/cD8b8DXuyrreC3KgheDeun6V5E8IUccGYe2o
 kZv6nKmSA1+45j/PUqcpUUm7DAslllefRaYDx1/gd2CQlk/zBJgk9uhQfy0Y1dZAHWUp
 QhogqpjVyxH1KXrBvXW0WoOWmDHSuXZx2dMsMIilJCCgO/ZQm9cir1b9TiinPM9S11iJ
 GD1Ufje5W1SagLcOVC2rOvXPX8oFh9bRLO4MHEz1V9XNHQEk/8suBvg9pG0WiNGofMFK
 iKpTCKjqO7I0Tr2qGZqSHxqHPHO6t31kgksCdLdmY6cdTTDwWabNwAEIEXqSDqy1WtvL iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=evjI4vSJyvLF2JTwZwAKw9hQUSv4lJ1l6KfvZxoEnf0=;
 b=LZO9hB1Yi1koHOF6e46MR6fn8DlC/ADpXa10OWVvGcW5SjGhuaSf+rYyw4XNqHiSoJMi
 hosN3X+RPNAnuBph8d+rGcC3jtSV/0zA0fpKMAdMFD/tELo8Z7Ec/REnLJB+gwA/bOxC
 8jgIRKOAbpbHFw+x4ZGKBMCKJRa086Zmy52K1g3k7oEV2qR3ftTcq4hWyrWR6BEVHQog
 PKJNFj62TUZ2PdUfWRGw8TGMvHQ5sqJbjFmYSDNga3dZJX3FeZGmbdaDODQ9MXH/nX8T
 1d6+zyH8nHUZqKjGqv5qpv8fVpGbKG7SspaRWgb8cKlCkBarmP52Jqc1RYp4s0pQYAx2 rA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mss9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:13:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I6B4kq042436;
        Wed, 18 Aug 2021 06:13:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3ae2y1juy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORqASNMXmTVwvtCkYkEO6cE3vKxKm/BJx8M0z8DDZ7P3vFPTib2J1nargnL1hrFOpB7Cpb+sm16OQTWLGfclc+dWXHHSPy4CcNyNij2hkrAUCL1NfSxeIBVyrXqoRpguavz4ByHp2XYXyrYTHUmafMIjiCz0DQqB1ssm2ijc/UBmZ6XEP+q9ALBhcSA3hTYuJZV9RnXKCdMwNpwW5cOxnr704GOGkPMG/79tKqnqbLIm2sCaBbxt3ui6HNX6Vtvzd1v9/W36PdIn8JMFd42HaaRzz8nN9Qwi59nRb6JR/vhpdef24UkjioBlBl0Iqxjsd2KHcGi+dBe3YQA3sXFDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evjI4vSJyvLF2JTwZwAKw9hQUSv4lJ1l6KfvZxoEnf0=;
 b=UAxPPxvZNmJHRMPJONcmNreC5e0H60/SK+1Ufy91kZALuTXGtUW16m2odRqB5qKLELiStVQLSMwZQhsrpP2QwJbJI1A/TsaYhYt2JrOnOagjaIguV6nPQdchyeUmtZilQ5rELZ2R1o6yhjVu2lzmEw9vYCfkYcr8hOy6DTt0b0yibna0gY/cZymLogCwiRScAQTtdgpFqNNlw9tltsIhBsbIO8jPlvpW/rm6tlJq+rpmoXPvvZLrLmz/jh4JORJiWYB+6DwiLNkLRCpiYf47z3SQlzBczVSV23X9/lQqEV9xyBs9mgBYU5gJ7o0uJeIn5J2k5Dc28t7HjJjTCTUBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evjI4vSJyvLF2JTwZwAKw9hQUSv4lJ1l6KfvZxoEnf0=;
 b=mBExEZEkXvmOYrfaVkN4xdbqCYfRQGk1tBMbGLSOAEP7cxwHlJUcXoRh5rTApj7DNg4AnaTWvAZ8M9Wk6ph84SsZFzQh8q1k7wzXR6qeo7Pv5Xhq03YmmX0roTHv4XeFm6jaZg733Yu/Wzp2W7NRdk3VBuRo6/QV3qqIZJ5mZy8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 06:13:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 06:13:50 +0000
Subject: Re: [PATCH] btrfs: update comment for fs_devices::seed_list in
 btrfs_rm_device
From:   Anand Jain <anand.jain@oracle.com>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <20210818041548.5692-1-l@damenly.su>
 <ce1a0cc1-b616-36e3-8c58-4edde5f924cf@oracle.com>
Message-ID: <a8f575fc-2741-6379-5b89-62353a54cc8f@oracle.com>
Date:   Wed, 18 Aug 2021 14:13:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <ce1a0cc1-b616-36e3-8c58-4edde5f924cf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0238.apcprd06.prod.outlook.com (2603:1096:4:ac::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 06:13:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a57241ca-56fd-4aa9-4d66-08d9620f58a6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4142:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4142BBD0DD6A598ADE2C11CEE5FF9@MN2PR10MB4142.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9wiL1wbrGEeQY4ePAYXchY7OgPMOp5SDd49kpZTjI7PtU628+5zpeA5bhY0/wsmGDx5Tx1bo+Vtvccp/8WdJhEe/zcQqCe9cHfKVZr6iZ6APgRMgNDwqmW53+7XPAoYWXEeb4JX65bV3UfxmQLD8pQhvv5sJswvnXe5uORi9o2B3vB2yXpKcn5K8hmdX4gvUGhDiCzidaSyq4zl6UTi7XjtK/RiOzNDySiDvt+jwgPbIIgDtDKN40tsHcualJmNlcABcyrG0B9TOMoGZsko9vPM6VZxLu2th+KG/4amoz7RusVluY874r3SAoO8vxenXSxoFRx3ok10sm8yzemxrn/PqqAiJXLS5dFR/wkej4kLmAU0Du2wk1TttCejboknNWGIXiS6sy2gvS5gX3sfF3FupskPMvtoNIZ3MMvRJSd8y8WL1+e+IPbamK33yrqrY7Oo+tzGFjivgzUqop+FnhMGfPkNn72CLR5jOYPs/giU5ZVkEtyORHmwZVrjS9WI6lR+c1hNrXhhssyqMoLvcVdFBmWeGMJPTIC+g1pLsOMf3ZdT/k6ebfdsCumfUjEQ5d2O43/LXY82qZzBw3YxxgVMfcLb+MOsPZ4mz8y7745oa2q1jt6guT92b4Jfo0RqDatBvGbZxXYErgK/qIrNS/RAT3b6kBKKybiDtHfMpyPIprBHEPWJep2hPhbIiz1W7h2KnkBAUy5bN/pPWLnkP/QddOK7hRZ2S+E3EHgKFs0wq2OQD1I+J8JvLF0pluF2F1U/Hd9mxpZIL/jMSnYwqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(5660300002)(6916009)(53546011)(186003)(316002)(16576012)(83380400001)(26005)(66946007)(66556008)(86362001)(66476007)(36756003)(2906002)(15650500001)(8676002)(8936002)(31696002)(956004)(4326008)(31686004)(478600001)(2616005)(6486002)(6666004)(44832011)(38100700002)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJqYVhqSFZkLzdaRFJ4SFE3S21FQ3QxTlBzazd2T1BvNDR3elJvSnBKaWJI?=
 =?utf-8?B?UVAwWkpqZUpackkxeU5SYTBFejYzT0ROVDgrMmNibG9uaVhrcHdyWnAraWVM?=
 =?utf-8?B?cVZMa1Z6REhWNG5zS0lta0taMEZGRzhpMG5hQWpCMDlOcy9QcUZMVTh4R0lM?=
 =?utf-8?B?Y291UGxHL2g5MXpRWnc5VjBuWEFBbEdBT3UzS2JMTjFERnhZaEJKU3VSdHZh?=
 =?utf-8?B?U1dRRlgrdGFWWWhKbkcyd3VxZm85VExvb2RncFZrZlBMT3dVRit6Ukl0MWZz?=
 =?utf-8?B?Tk56UjNxblE4YU9NaDVuTUZlQ3ppMmQydzVPcUdaR0txU1JYb3lYQWxtRGdH?=
 =?utf-8?B?YUdVNHY1ZUE2aURTSkFKKzBKTndEM1hIQUFBZlZtZnhKbldHVWZhTlJEU0xi?=
 =?utf-8?B?cndqS1RrL280c1d2NlhtdWxKdU0wMlB3TkJZbXhpMDNwTFQ1Rzl4M1NoM3Jq?=
 =?utf-8?B?QjJQbTRYbmZ2dFBiSGl4M21rRmZrY1g3TlkrM3RuaTRwcVBaUmlPeHhjd2xH?=
 =?utf-8?B?SXRDUHdwUzVUUXhla2RhWnd4VnFXd0h4SWFYWERGWmtXTUJlUWRhYk13a3N2?=
 =?utf-8?B?YU9sRGVxaE9MRy8xTUhpalpnTjFmZzhndHlKdWd1UWttNU0zbkxpL2duU29x?=
 =?utf-8?B?TGdlbDJFd2tyVkJSQmlYRlhhVG1NUWV2b2VvQTI4Um5qc01ETzFCa3dxdm9D?=
 =?utf-8?B?V3ZYaUJzQVNUVHhTTHQ0OHNNRmpUS1NpOTk2ZnJlL3A4QjJGSUsxdXQvMkpQ?=
 =?utf-8?B?elJWQ2JSZXBZSUlzUk93dXFuVExIdmJTZm1Ec3JVUDNKQTRLcmdtU3YyK05o?=
 =?utf-8?B?L2VaWldRWEdlNDNSZm0yYlErUW9Hd2FCMEdkd2txeldrR2plcmZTR08yNWt0?=
 =?utf-8?B?RWRvdllCTi93RkpzMUFySkRpeUMzQjJTS3dEc21MdVpwSFJ4U2NLREdsNm8y?=
 =?utf-8?B?WGtHdUVxVzBkU0d4eXJIMlRIcEd1NTVHN1ZuVzYwS0pBSlVpMm8rckRIQTRS?=
 =?utf-8?B?VlhXaGRtVXhHc3I2YlJWTm0rZjd1NjVId0lNU0V3OW1iYVFmb3N0dHExWHRW?=
 =?utf-8?B?WFZVRmt0VUg4bS9pY1E2M2pjTUpEUWVVMVE2WVI5RmNMZVgvVkJoYWd1cUFD?=
 =?utf-8?B?a21iTjN0UkY5eDZkbDBkUmJBTmNJblI0dVdQVkxsaEZ0TXlRWERWanZTM1FE?=
 =?utf-8?B?RFpNUjI4Ulo2SkN2eTFxcGFLRzFNQjdkUnpJc3lIQkpFSnY5L205aENIMU93?=
 =?utf-8?B?TzRMY1dRS2hqWFA3ZVpqR2Y2TnF3MXpMTHpsSGJmRWJwdXV6QlAzQWhIOXZx?=
 =?utf-8?B?SEZRL1htYzRpVVdIR1pZbUdKRklkc05kU0NWWWhCNlhhVmhwQkoyZkhRa3NE?=
 =?utf-8?B?eFdvZUhSK1oycDFsK1pqeE90RmI0V1dlRXhRZWNjNWI3UnEwSW5Nc2ExVHg1?=
 =?utf-8?B?Nk0xYkp5c0pYSkt5QW5YWElxSG1qcjJTalFCSm91bDRGK0FLaGFLMHJETDNN?=
 =?utf-8?B?TTNQYURySFhscWQ1NnhYNVVsL0RKQktTN09IVFk1Yzk3M21iekw2ejdrbStq?=
 =?utf-8?B?cENjZGVlNlBGR3JKOE43RitPWDAvUnYyTitOT3VnUktza2dPbEhDM1pjTW01?=
 =?utf-8?B?bkJ2VWV2ais2Z3o2UDh3ek9EbVRQV28rODEzdS9wVktmN01qUmYwWksyRTd0?=
 =?utf-8?B?blFlOG9jRDcvQ3ZVKzNtQmFBUHFJRENGeVJRRXg1QzFYbzlpb0d3UENzbS85?=
 =?utf-8?Q?nILeKazoTr1HIe6W3XFIoEH0/TUz4TBbIfbapjU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57241ca-56fd-4aa9-4d66-08d9620f58a6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 06:13:50.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tng0auEwjgOzehZHuORXTgbhnc250P8g9PqOOwwRta8VDw1E4T2/vc20Ip968zMGByOYZX8H8s4i1yCp2vwhwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180039
X-Proofpoint-ORIG-GUID: O0jq6WdgN8dQL5_TR_dhBWYicHeQ_iPT
X-Proofpoint-GUID: O0jq6WdgN8dQL5_TR_dhBWYicHeQ_iPT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/08/2021 12:25, Anand Jain wrote:
> On 18/08/2021 12:15, Su Yue wrote:
>> Update it since commit 944d3f9fac61 ("btrfs: switch seed device to
>> list api") did conversion from fs_devices::seed to fs_devices::seed_list.
>>
>> Signed-off-by: Su Yue <l@damenly.su>
> 


> Reviewed-by: Anand Jain <anand.jain@oracle.com>

  Ah. No. I have remove my RB...
> 
>> ---
>>   fs/btrfs/volumes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 70f94b75f25a..fcc2fede9ffc 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2203,7 +2203,7 @@ int btrfs_rm_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path,
>>       /*
>>        * In normal cases the cur_devices == fs_devices. But in case
>>        * of deleting a seed device, the cur_devices should point to
>> -     * its own fs_devices listed under the fs_devices->seed.
>> +     * its own fs_devices listed under the fs_devices->seed_list.


fs_devices->seed is correct.

222 struct btrfs_fs_devices {
::
257         struct btrfs_fs_devices *seed;

Thanks, Anand


>>        */
>>       cur_devices = device->fs_devices;
>>       mutex_lock(&fs_devices->device_list_mutex);
>>
> 
