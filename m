Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE59948BDD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 05:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350579AbiALEOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 23:14:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41922 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbiALEOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 23:14:15 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BMJQbB030467;
        Wed, 12 Jan 2022 04:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sdgr28kIhQE5/hNgVMZGBs/Ef/QIk+PbJgcRyIWqaVw=;
 b=wXvMUozlVS9gYJUu8CKjCfvW2AUaV4fLWM9u6B+sZrVrniI9BMfkEDwT+Qimr54nJvKA
 9iRK1NxamBKtio28Q/VKfYFmXO1MTeVvLCtsrtIlOjoc3ErH5yKVozxHTG8aKnPZH4sD
 N1BQkzEGCdc8jWoyGh2e0zfGubwNZ8EGRu6Ar3+cKCCWp9O3lHjL7VMWEHAjy6VLN9a3
 bhdFu6BartIPYZh04s/BKz7VxF2cEy3FPXzcvTMn8TtmWifV4gZtUjREK3kQdJZ1ss7j
 /luGk+xabs2aMNvOZQMbB+zrviZ7049JHTz2R10wZB1a5AnIyosqdHMvkhzOdD3Ugp2P DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbwb39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 04:14:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C4C1UP068760;
        Wed, 12 Jan 2022 04:14:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3020.oracle.com with ESMTP id 3df2e5q7d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 04:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay/nFAIUru790Wrl027l3maOYI6uey/nL9+9xhM/9IgB17CZoSAxHqVuyGDpjbfL8iiN15HfExFNhN8Kpoo7mvlPN/gwQqJecvnh/Daqt7hWIKyC+j/zKHmeqP+THytO/wcxtGB8AP1V/0JFKWfLgt8S1UAb7xto6OJVdZQUZR6aQ0G45UkSp7HrJfJcCpPQj4WgD2ZzkZsmtI1dD22nO2a6GGjJHJZkljW/ARJ6f8Wyht2DajuCFShTGjWvw5tPOBXoUTERrkeeKJGrIxK2gdt9ykcF7G4lLSTSZYW5dLoYw8WiX2JZ/bYI0F9eXfo+AWbkFwl6MdTl/VQv8IuPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdgr28kIhQE5/hNgVMZGBs/Ef/QIk+PbJgcRyIWqaVw=;
 b=M9eyTgJ+0qTg0e9oRnPPTwWmJ1VGwSb0Farmgl5kPo1DINNPjqCVB6i4HxtIPL9scNxySe9zA11koYLn5pFK2Sl6B2EkrTBw6ssnnF0ZWLEnonDVNaW/BORksARKRsfrpe5oGEnLtzohlKhi74+CScVjAPOcUmXpzuh1X/iqlIOJExfzRbHR9OH75e54XLnVOxyNtcXhwXdC671ZydL/B76I1KozRy5OtjZ1p5ZHbv9kKQLX5YfQOhf4vCm8u2jnTnTqr2Z706qU5z9+kUrWMLKNXMo+kXCr30wnbYXVnwfUR38ezFSt9FX5nHfoF1eIK8Gug75LDSaeh524hfOr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdgr28kIhQE5/hNgVMZGBs/Ef/QIk+PbJgcRyIWqaVw=;
 b=KK+4VBaEgomuQLGxLlh9ptipb5ljuqMXN8L1xzk7zKrGgA+/SP2F/BhX4JfCwoZVGt9LN24hn4UijlaqJckOtlIQmjFYCdMIhOiMwZ5jutTyMVZZOuu5/hZKFCR4nDBYm2rcCCK9Y2qa0OdJG385W4bdCJ7A4O4MkeY6AVJbxP4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 04:14:06 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 04:14:05 +0000
Message-ID: <ac636e17-9c46-b21c-a45a-994a8c3272ad@oracle.com>
Date:   Wed, 12 Jan 2022 12:13:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [External] : Re: [PATCH v4 2/4] btrfs: redeclare
 btrfs_stale_devices arg1 to dev_t
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
 <df5e06aa-5ed4-0df2-9210-ea8d19069cba@suse.com>
 <5656e466-7950-2dd0-11f0-2dadcc191f7c@oracle.com>
 <8050ed8f-200c-5adb-34e6-012100b2e913@suse.com>
 <b7ea8da6-91e4-2af3-333c-dea16af756ec@oracle.com>
 <935ddfdf-b79c-b424-6e7d-74286834cd29@suse.com>
 <660a46b7-1a59-9f77-02e8-be1535781e84@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <660a46b7-1a59-9f77-02e8-be1535781e84@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40fef475-9126-46ca-71d4-08d9d581f907
X-MS-TrafficTypeDiagnostic: BL0PR10MB3425:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3425DB05387697A34E0701EBE5529@BL0PR10MB3425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANdWY+r1J3pGM+OumNvk3nOcVsZ6J9Srf/JUr1aeW5G1JwA0MROdXj4ksZGvOaeu1bkJ5wbcOZXkT5bswzEFodNlvp9g26irTZ1y7MjWCDSnmjwCcOY0kRVL/r4JhuhOmc0TZs+KL6ZA1bb1wVucPwhgdukJY8Mc1hQonsORmEcUtCJH3yONDZkPJe0BJzNW7iC1pyXZPP7PmIkHRcvjRokq+SwdS5FHRPQ3lmhZwzNuGwMDt+OkorzCTSpbkFUxG7adBZqBoAeeF3gc42WzN3vBizMZhusZT7vz3MkZATFCiJdK2ZZcT+Q3S04WtRAXozNf0Jgq3SAlIioYGLYT9xrsutsyux6j0n580Yba7Abaibj1Y0UFaqJNEOw5B/rVkDXtw/3cl2B9+fpTMyS54aujLMRtcK6xSGueFWDhcFR2O5xAWMbmQnmaUq2cCxjEkoXB/C/8AxjD9tms+VkO1gfoCQ902+CZU8h6gyz2Pr7+Ta6WakFkTse3jpsLcY9Vbq9UYzDl1N0bHqpZ1pe65Aw6GmsZG//yGZabmPIfXJvRxFUHGcctSvY5qe6sirW9y9GQhf5cybZ54tnWc+92hkhKKoeNpJ9tCx12n/HBv5rqobtI5oAHk8dudr/OlebmuNFO54lLJXpfxUSpTFDOjDubdRG6S2gRXlRH3RLMqna5zH9Q+D1OE2hJJNzaUcGbwQ9Jsy7B2I3fM4Af8pgBo1weVog+sQL+wGjg5IGOkoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(2906002)(508600001)(4326008)(6506007)(66946007)(66476007)(44832011)(6666004)(186003)(26005)(5660300002)(36756003)(66556008)(2616005)(8936002)(316002)(6512007)(8676002)(6486002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRKL3V1RFlmaHF2QWhhdmNuOXY1M2M0TUMvRHhVd0Qra0FYaTNkQlZjdTZN?=
 =?utf-8?B?VGxGUGVlQU53TDYveXdYM0Jscno4RDU4alVmU0RSaHN4NWxXYzhSSXZ2Ulor?=
 =?utf-8?B?S1laajRTQ2tuY0x4WExOMGFGU0JHaU82Y2JMZVdsd2pGR1ZqR01OS3VEaVl6?=
 =?utf-8?B?MWhjTFA1YmgrNExEeFB6ZTdIaHFhcHdiQWJjN2ZVS1Y1ZUF6NzlWY2xxVkdq?=
 =?utf-8?B?L3VRZWJDc0kxZ1VuNHdzTDYrakhuQTVyZzh0dXBOU1dnOXY5V1ZmbFQzdUM0?=
 =?utf-8?B?UkcwVVVBYUxETTRSMmNlMUpmZ2ZySmU0VHBRWmNWYmVzVzJRT0pPeFJKaExl?=
 =?utf-8?B?TEpiNFQ1eGF2KzlLSDA5eVl2QjhsNnpBaGNoeHFFRW1UbnkrTFdmbWdINTBa?=
 =?utf-8?B?MUsvY3ZZbkZnQXZ3TmRiVjlVSmRsam9CaFhndUV4MXY1MzZOdnBYdERVOS9t?=
 =?utf-8?B?Mm4vdGxOZTNlUmY3YlUyM1p4eFk5eGdJeWU5OEQ2RGs5L0NjMDB4WmJXYzdi?=
 =?utf-8?B?OEtCdXZmaTlxekkwYUV0Y0hjK3JHaGNRRTVCSmFWcVYyZk95Y0FoRmorUWhN?=
 =?utf-8?B?aElNdHd6bi92VWZseFIxZ08xN1llaUVwaXUxdHVFeGFwdGlYRFhiV3I1dCs1?=
 =?utf-8?B?cWNrbmlqeVR2TEluSk5iRlRUaWx0ckRPdVV3NlhnMlFRMHBIN01Bdkh3Rit4?=
 =?utf-8?B?eVMyNjZzOXMzWHhaajRoNWhNT2YwRFJQN2JQTG55bDcxWGZjdE1GTVRLSDRi?=
 =?utf-8?B?Y3JLODhpdGhmN29uOWV6QVFuZmptQVViM1E1RG4xMUZGcW1PRE00SERwbDFm?=
 =?utf-8?B?Y1pEZk1Vc3VSWE4zMmZSK2tKNmJNcHFFcmE4SmVxU2dGTU5rQTUrUVZDMGtw?=
 =?utf-8?B?TDY5VktYV2xGZWk0dENIQ1lNV1o3cXJHb2hDQ2tEaG1FOWNnQjJJV1V5NGIz?=
 =?utf-8?B?SGlkYWI0dkJ3NGltL3BzQlU4cjVRaVIwNkx2TVFRREFsMGxZWEZFdmZBaUhT?=
 =?utf-8?B?OXFsSFlUczVDNTd2ZlZ6M1N4cHhpQmNtVUVITGFUZjE1d3MxenR0R3VEdVBF?=
 =?utf-8?B?SG9SS1hwSy80WncyVzd5RGhSaFRCZkFOZGhqR1ovbXZvcWlJditwUkJlNEFL?=
 =?utf-8?B?ZkNqOUFnTzlSc2dFdjlDL0I3YU1mSjNmM1ZTVkVOVUw2dFU1Tk5XN3lyaVdz?=
 =?utf-8?B?Zlg4cjI1OEpOdWg4ekMvakZhNEw3RUV3OFZwNXRINkhxb1BsMkRCdzJrdU45?=
 =?utf-8?B?STZ0MzFVY2dUTWdtL2RySExhK3FFSVhXMGVuNFYzOTk0d0lkUk4yb1dzZld1?=
 =?utf-8?B?OUF1VW1reGcrSnhtRk51WVVBSzQraHRjSEhlYXdrbm9oQTlrWC8xbGVyRE8y?=
 =?utf-8?B?bGtzbGJnRGNuRzE5YmgxRmNrU3VSOU5EYm1XYnJEZHpnUHhVcnBrRE9rOXFW?=
 =?utf-8?B?eUxJSEdYZVBLZXg5OWhXUnVBS3ZMTXNJTGJVV0dLeDZBMENxam95WUx4VzU2?=
 =?utf-8?B?NUJKVDlyMTlaVngzNHlXNUZSTy9VSjlsMzNiZE84VlRFdEQwNTFBVWY1VDFS?=
 =?utf-8?B?NmZiUWJoWmRYaTFJVXdlM3JUcFpoSGpINGZtWjF0NmZsQkUrSFFTTVF1TnpJ?=
 =?utf-8?B?K2NVWllJc3oyNVkrVHFEa2tDbG1Kc0txZTYxc3ladDBVRndVY080Z1NOMm9R?=
 =?utf-8?B?STNocXZrQVB4VEZkSCtoNi9RcUV0Q05WL1JHMi9GZlZEVUdKK1QwL1JKWm9C?=
 =?utf-8?B?bCt5eDNMelJvQjdkUEtNWXdyZy9udGlHNGNDVEdBamJPZFQwRDhiOHRjR25C?=
 =?utf-8?B?SjAyK3B4WnU4ZlUrVzl4a3hHdnlacWVsZmoxQUNja3VMYnVnVmNJZFcvc25Z?=
 =?utf-8?B?dFMyaGpQSGs5dE5qS3hyazB4WlBVVHNtQXI3V1h0TWN3ZTNiSGlwYjlMY2Ra?=
 =?utf-8?B?bklteUE1dTdyR1VtaElVVHNKaEN3YmJnMWZzbGl0LzBGOTB1ZEg3UDFvR0Nv?=
 =?utf-8?B?SlBnYjFvaDExZ25TSlZOMkQ5aVB2MUczVyt6RWRsdEFQZ2pFQ0MyUzdveGN3?=
 =?utf-8?B?TWdFR1FRKzhodkJacjhJYVhydjJINjM1SEkwcGE5OUk0dWdzSGJBOC9qZDFW?=
 =?utf-8?B?aUt2YzVSK1lPTlpnNGRYUnZ3cWxKT1Y2YnIwckk0SkVDY2RZR3U3VVEvdHJ6?=
 =?utf-8?Q?MtINf0r4tP4nnojC+0hp1xQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fef475-9126-46ca-71d4-08d9d581f907
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 04:14:05.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNnwyjuOFQStVFd1wOBvYgqkM6Tgx4/T5pNB3v4Rj1oupqAvL4xN8E1S/05A735BSyDVti3RrLqJAIdScJl2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=861 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120022
X-Proofpoint-GUID: 4vidZHR361IeJ4Gxdo8uIjNBLSVOH5iG
X-Proofpoint-ORIG-GUID: 4vidZHR361IeJ4Gxdo8uIjNBLSVOH5iG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>>>>>> @@ -604,14 +599,14 @@ static int btrfs_free_stale_devices(const char
>>>>>>> *path,
>>>>>>>                          &fs_devices->devices, dev_list) {
>>>>>>>                 if (skip_device && skip_device == device)
>>>>>>>                     continue;
>>>>>>> -            if (path && !device->name)
>>>>>>> +            if (devt && !device->name)
>>>>>>
>>>>>> This check is now rendered obsolete since ->name is used iff we have
>>>>>> passed a patch to match against it, but since your series removes the
>>>>>> path altogether having device->name becomes obsolete, hence it can be
>>>>>> removed.
>>>>>
>>>>> We have it to check for the missing device. Device->name == '\0' is one
>>>>> of the ways coded to identify a missing device. It helps to fail early
>>>>> instead of failing inside device_matched() at lookup_bdev().
>>>>
>>>> In this case shouldn't the check be just for if (!device->name) rather
>>>> than also checking for the presence of devt? Also a comment is warranted
>>>> that we are skipping missing devices.
>>>
>>> I think you missed the point that %devt is an argument there? It implies
>>> and frees the device with that matching %devt.
>>> IMO it is straightforward that if %devt present then skips the devices
>>> without a name.
>>> I will add the comment.
>>
>> Precisely, how is devt related to the name of the device? Before your
>> patch the path argument was directly related but now ?
> 
> Ok, so ->name is used in the device_match function. But when it's gone
> in patch 4 I think this check could be removed altogether as ->name is
> no longer used.

I have moved the whole check into device_matched(). So it goes away in 
patch 4.
