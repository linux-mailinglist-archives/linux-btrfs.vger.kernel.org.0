Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B866E402174
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 01:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhIFXZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 19:25:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24590 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhIFXZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 19:25:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 186MTIhB017572;
        Mon, 6 Sep 2021 23:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=v8l7iAwixS3xhc/qW2uXlFwvFiFWYt7CDxIMklOaR6Y=;
 b=Mg71Y+SwsAQLfeovdMlcm5w9fM86iYb6TZNwweGDpL1F54Mkv2bByN72KQuvUiQfSG9t
 SztPeuitIqwM0452Upl1rvvdGT4n3BzAgQxrSploI0SQpe/U/xaujuzRFCE4MTpaTo03
 WL0bH3I8dApkpJA3pPCibKuqokXBII57Zke0s8w4+vcz+c9EXIc+rh9bj7lo7JBy0ZKq
 t/DxQNmsv03l3us51wpG9la04Og7sc2cSnZhMRdxQodymrajL2BWyRYGfw+RyG+vZCTX
 cqJtrUqs03CWZXIodREm3aAgHgAhIXirfrVkDSmPKsssVnBVWOrLKszM7fizsWoqzp+H cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=v8l7iAwixS3xhc/qW2uXlFwvFiFWYt7CDxIMklOaR6Y=;
 b=agCwfQMny8ExjyJd6SF8W9gFmB21GrYE7f19+7yT5extd/Wu3Lo04IDIDOiha/F0mW6C
 BRLqoz09oKqT1O7LAuMdC/mL+4OwGIy0w65hkbKUhz+Q6zRwZGbAkTEFM1+gOiice3+x
 3FAGwxjAXj2HDQksuuFK3saj/I5wqXA/9HgqR0FLiZoCOZQJyxed+qeTCKwBkSecrueJ
 oeUqmorv3aIA++SS15OLcOhZu0c81sNdtlKLNYTBU4loJTLXCwRdXTLCQruGnrcwPnv3
 UJKXj1jFdYFwST34P5RNd+3ZXux2h4W9dXqSKol5oSoS/xqNOAfPPtdeuUHGj+kMCjZM dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29gaj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 23:24:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 186NA6BY050374;
        Mon, 6 Sep 2021 23:24:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by aserp3030.oracle.com with ESMTP id 3auxucsmjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 23:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amO0vzBsfrLWYXa3tOoY/mxStNeq6fnZFVGZALLAZzVOHD0VFKsr1+2HUE12sK6F0JSRxwrYAPyrxVtvejw2/s3KjKwUNl0kD6BZsmpvG37FzA+6BHOcuT2GAZZJF7CKbgXG64VuvNbm3gyxsqwb7oTM8XXhzuWq8amLHJG/NdTNphhI8fhbyULRWejh1GDuGwizAENnKBViONCSoWQ9AAONb+nqwr1W5JYr0L70NPWpAadFdcu7RUTVDowWvmC/ZERdtm25dHU+oYqhvD20wNPUaIMIlYcVmLx6g0gfXkyu4rQFp/g5EBI9DNoLt8/IxUSu4kBIDzzJ3e8b3iBQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=v8l7iAwixS3xhc/qW2uXlFwvFiFWYt7CDxIMklOaR6Y=;
 b=ZrdvtMi00+dd7ZFyFjSPhEwlTpBomDDP2X+EV8e9JfaF2IUoQ9SIx7kLHeY5ymDeSliXuPZsodRbWok0vUX3+6vBuVu2a1TS93n0GI0FHFJolKClfaOhnnQl8Si4xZNG0K9YHBBpqI3S5ow1gttcy8RXA+PnQy+divAl58NgWZ+p7PPbV78mt1VC1n/tPFWXYQMHsgcnPWQGZzenOQqfBbStXGio+/xObiqAF+UCT31BFYrPsI0w5814WTWz1N9NHbgnPkkPXy+djt8cZi8gF6FcrCA2zkzojpghvfKkuCqoEU9DWpB7RwoKIJRpufwIMNQX2gnZdwYbKgjAeSL4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8l7iAwixS3xhc/qW2uXlFwvFiFWYt7CDxIMklOaR6Y=;
 b=DfqV0GHTIEaNWFH+R1J4LL25SfpKY0iDNJEUmkvg3CzHCohANMGt9WuXr90AaSLpM6Fqq6frVVOMxmpBoyjlqyIIfIREYllQ+BhkrFdOeKtUY5ZQ7PPvBBUmeSXZ7ZLO1Lp+YEmCw5WQ6EMW+SwXl4FxVLJq0euuJALoUBJsIoo=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3840.namprd10.prod.outlook.com (2603:10b6:208:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Mon, 6 Sep
 2021 23:24:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 23:24:30 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Nikolay Borisov <nborisov@suse.com>, g.btrfs@cobb.uk.net,
        David Sterba <dsterba@suse.com>
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
 <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
 <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
 <4da2f41d-c1e0-1da9-e4c9-bfe87067a6af@suse.com>
 <b5dba5a6-256b-ee5c-57f2-84e9875e6c0a@gmx.com>
 <757eb738-a9f0-0c6b-a713-dc89122eb5f6@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <15572659-80dd-cf3b-a89c-75db2dd79e5d@oracle.com>
Date:   Tue, 7 Sep 2021 07:24:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <757eb738-a9f0-0c6b-a713-dc89122eb5f6@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.1 via Frontend Transport; Mon, 6 Sep 2021 23:24:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da6a8da3-6e2e-413f-13a4-08d9718d7a3a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3840:
X-Microsoft-Antispam-PRVS: <MN2PR10MB38403812C576E0AE32B27565E5D29@MN2PR10MB3840.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vtmx9nOQmMif7erNl3hL6zWdB/CCUHuoAQ99NlsJ1ZD5BUhMH3NuZt079UDI1Q2E4k3Ww8qxk3w/IGYh10yqAEVRX0TOksWFylKxBdbXqssUMo/Tzf8p6qq64YTcx3tNKMpDru6cZQgRA8asURrAKBJFsXijk4TbSw5iPHzeXj46tMbXa99gzi9lZtJz5T86C2psA34itxZHuvzuHJpYqgAvm4/E4FKLgUi/706VYoVN6jt/vwmaCk1+o91D3PyaVudDUqp55HU2w4zmnej1tButT5FzoB9lL1eto4DbTDd5GS6fA5h6aYn6BpPZM0TYWWjsnX305CXw56QgnxwyOW6dBGgtPHceJODYsA9COuhXC/fzrT80yS0saJPOLx3HzDvglBDdpfBswHdEfHl7+SI1IpSuhZs5N6ZZ45uxFlRg2WtYhybBFbF6Wj4xwizR9EOtyDHI6iW0xwjITPCLXb/0FPUR+ja/U6SGV4eLhlZtzRLS33skvO0EX1TGRmKWNaEdo63G6azRTbH6XvmcwsV+QShWxe7nHjPEubUQ5WozP+KMsC5IHk+DHhoQ9H0KaqnhSmTG8otbslEhIUS66mPgqiIglyv3T+P09ZIbvQ0DjeywhUipZvi67kHx8myKuS7d38b00zeCPd9YCzWMSiEWxn+n2rzRSkprDkxET1oJaK1yzqPlFx7inM3UF1FZyQKIFYZC+PSX7ci6kRd/PaHY2QrZ2VbFa2FJHiIxito=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6666004)(53546011)(956004)(5660300002)(8676002)(2616005)(186003)(8936002)(508600001)(38100700002)(6486002)(36756003)(4326008)(31686004)(66556008)(86362001)(26005)(16576012)(110136005)(66476007)(31696002)(66946007)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRDcE9lbkFIRXhhd2hhZ0xYRWRDNm5tbVdJTW51QkRrL2tIU1dHWnZqamZr?=
 =?utf-8?B?aFE0TTFkdlRnQndJbkE4TjhDclVBMHd4bUVkNDMwVkppODljVlpOWGVGRzNv?=
 =?utf-8?B?eDUzWGV1bnk2a0V6MUZnNXZWMFJIQVpJYmFBUkEzY0NuN1c1NEE5MkwrNlJW?=
 =?utf-8?B?SjhvVDM0d2pqeEFPZ2xqbXcxdDdneXExMXBRMVo3SnQ0dks1b0xhbFA4QWNX?=
 =?utf-8?B?NjJscFp0YVdiUXY4bnJuc2FPU0JEM01CbE9jd01HbEFnaUNWeTA4TWZtT2Vv?=
 =?utf-8?B?OFN6ZmNUMVhSczZPU2hodEhYYzNKdHJya0xsL2tqSEZZRVQya0VWUDM0VGFH?=
 =?utf-8?B?UW93WTQyaDlTU1NmZGsveVMzOGFCaXVNNTN5RytrL3BJNXYwbUdkWlBCbFlN?=
 =?utf-8?B?d2hSenh0TEZyQUZ1SVZudnppZUZuUURwakZ5aUs1eEQ4MDFuZFVYMHZKdy9z?=
 =?utf-8?B?VHdvaVA5bXgxYWtVMUFZWkVkVTJiQUtaQWtidDlxY2laWmJpa0ZkVFpaMTZy?=
 =?utf-8?B?SDlJazFLU2ZDZjhYTHBzbGJ3MFlnNU52YU1pb0hBTGVTdlR0eDhwMHI2V2xS?=
 =?utf-8?B?WmVqTEFoSllxUlFOMmVmd2J0WnZoaE1MbVd1c3dJekNjRW5LeFNoOXp4Wkli?=
 =?utf-8?B?VTJ6RWpoR25vS0djSDlIVTE1UUdtbUV4YnF2Um9qR2dwZUJIaE1GbXp5eFcv?=
 =?utf-8?B?c01vSElQNVVQeHFoTHJpeVBEbGZVY3Z1cTlIV0t1L1dhd2hxQ3N5OGJOeXhY?=
 =?utf-8?B?aW0xZHdGZ3VuWUpUTytxSFhHTDhxS1pJbHduTzNETDk1cndPb2FMZE9kbWF6?=
 =?utf-8?B?RkVJOTMxbHRUQ3JodG14b1BIL1I3VXMzOHJzaXFCUEdTa0JldFFTRUFyODFO?=
 =?utf-8?B?dWlhL0VVRU4wY1pxektEODRYRDdMVmVWbVB6TllwVUFNMVI3V0YyNlRkNHVk?=
 =?utf-8?B?MlpDWVBLdTFTdGVoMU9RS3ZtQTJ0eFFZc0ZVWEo0U0JNOXcrdkpCczRRdDJT?=
 =?utf-8?B?RlR3OGVWSjl3TVM4SFA4Njg5R0xaajRBZEM0M1VZa3orYjdIWTRlR1QrWlBk?=
 =?utf-8?B?bk9wa2duQklYNSs3VXpQZjhtNWVxdkZXYmxuYllrVThuT3lOc0xjNjNmQ2tX?=
 =?utf-8?B?RHZqaGxRbjVYcXJySGtyRXVnK1l6WDg5d0laV0hnRnZmME4yU1lFMGEwOW9L?=
 =?utf-8?B?RC8vZ2gyRlJLZVdhR0dUcnlpU3pGZTJGTUxUNTBQKzlEcHg3Tk56bkNzU0hU?=
 =?utf-8?B?VWxrMXlzVDJkYzFDMEZGT2E1MmtPNjZlQkllSW1Tdy9sUDUyMUVlRTJPaUdB?=
 =?utf-8?B?NnJoaW9FLzhlV2lQb01NNEJFWkY1V1RZSmtDODVmRW5NaEdVdnJLRTM4M1lu?=
 =?utf-8?B?UkVEMjA0Y1J4YkZYNmM4eGQrTm1vdUhocGlIeFRhUk1BT0luWUpOTVdRRDNK?=
 =?utf-8?B?MTBrUlZBM1BxV1RDMk5Xa2VmSFpqR3JXQlFDMldWQnpkWGllY2FzM2EwdmRX?=
 =?utf-8?B?bUpwaDRYWjB1d2xaZnFzVDZ3VnlER2Z0Wk40N3MxMzY4RXFCTHpUcm5qTFVu?=
 =?utf-8?B?S2c3WXpSZ0NLMFpRV2FCeDVZMG1hSFFqbENaazBtbVo2eGFScm9zKzNIU25q?=
 =?utf-8?B?bElObWM4NHhaM0E4TmVoVTNnOENOWXRCYnExc2hFVzB3QXhjRjJRMlJabmxW?=
 =?utf-8?B?Vmc1RjFHYnBBZW5tMURMZzM5K0JXRGp1WnhtNVBPaEs0MEpzRmZjdWVxMzhR?=
 =?utf-8?Q?pjNF/s6C+lntbKr8+GUqOl847UM+tmX8Uhp7YF/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6a8da3-6e2e-413f-13a4-08d9718d7a3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 23:24:30.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSrqB7rlbNMCIEThmCSc5BAHq/H5/Ignwt9gfZowujMESSJ6zyq3KPRNXx/GvO3oBkCQueN8xUFObU/sy4sosA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3840
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109060147
X-Proofpoint-ORIG-GUID: w9PXWNx5wiU5pYF3fqFynGjJS7VBO6hN
X-Proofpoint-GUID: w9PXWNx5wiU5pYF3fqFynGjJS7VBO6hN
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/09/2021 00:47, g.btrfs@cobb.uk.net wrote:
> 
> On 02/09/2021 13:17, Qu Wenruo wrote:
>>
>>
>> On 2021/9/2 下午6:59, Nikolay Borisov wrote:
>>>
>>>
>>> On 2.09.21 г. 13:46, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/9/2 下午6:41, Nikolay Borisov wrote:
>>>>>
>>>>>
>>>>> On 2.09.21 г. 13:27, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/9/2 下午6:06, Nikolay Borisov wrote:
>>>>>>> Currently when a device is missing for a mounted filesystem the
>>>>>>> output
>>>>>>> that is produced is unhelpful:
>>>>>>>
>>>>>>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>>>>>>        Total devices 2 FS bytes used 128.00KiB
>>>>>>>        devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>>>>        *** Some devices missing
>>>>>>>
>>>>>>> While the context which prints this is perfectly capable of showing
>>>>>>> which device exactly is missing, like so:
>>>>>>>
>>>>>>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>>>>>>        Total devices 2 FS bytes used 128.00KiB
>>>>>>>        devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>>>>        devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
>>>>>>>
>>>>>>> This is a lot more usable output as it presents the user with the id
>>>>>>> of the missing device and its path.
>>>>>>
>>>>>> The idea is pretty awesome.
>>>>>>
>>>>>> Just one question, if one device is missing, how could we know its
>>>>>> path?
>>>>>> Thus does the device path output make any sense?
>>>>>
>>>>> The path is not canonicalized but otherwise the paths comes from
>>>>> btrfs_ioctl_dev_info_args which is filled by a call to get_fs_info
>>>>> where
>>>>> we call get_device_info for every device in the fs_info.
>>>>>
>>>>> So the path is really dev->name from kernel space or if we don't have a
>>>>> dev->name it will be 0. In either case it's useful that we get the
>>>>> devid
>>>>> so that the user can do :
>>>>>
>>>>> btrfs device remove 2 (if we take the above example), alternatively the
>>>>> path would be a NULL-terminated string which aka empty. I guess that's
>>>>> still better than simply saying *some devices are missing*
>>>>
>>>> Definitely the devid output is way better than the existing output.
>>>>
>>>> I just wonder can we skip the path completely since it's missing (and
>>>> under most case its NULL anyway).
>>>>
>>>> Despite that, I'm completely fine with the patch.
>>>
>>> As you can see form the test I have added this was tested rather
>>> synthetically by simply moving a loop device, in this case the device's
>>> record was still in the fs_devices and had the name, though the name
>>> itself couldn't be acted on. So omitting the path entirely is definitely
>>> something we could do, but I'd rather try and be a bit cleverer, simply
>>> checking if the name is null or not and if not just print it?
>>
>> Oh, I forgot the case where the stall path may still be there.
>>
>> In that case your existing one should be enough to handle it.
> 
> I realise this comment might be too late so feel free to ignore it if
> so. Could this path name potentially conflict with a (new) device using
> the same name? For example, could someone have created a new /dev/loop1?
> Or could a USB disk /dev/sdf1 (say) have been removed and a different
> disk inserted and acquired the /dev/sdf1 name? Or would that be
> prevented in the case where "the device's record was still in the
> fs_devices"?
> 
> If so, I think this could be very confusing to the user trying to work
> out what has happened. Maybe the output needs to change to something like:
> 
> devid    2 size 0 used 0 last seen as /dev/loop1 ***MISSING***
> 
> "last seen as" could just be "previously". Or, to make it even clearer
> that this is just a hint to help the user understand which device is
> missing, maybe something like "(last mounted as /dev/loop1)".

  Yeah. I agree. We found devid (only) was important in this bug report.
  Either 'last seen ..' or completely removing the device path will work.

Thanks, Anand

> 
> Graham
> 

