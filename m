Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5115453EF2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 04:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhKQDch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 22:32:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64916 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232890AbhKQDcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 22:32:36 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH1ri6I003477;
        Wed, 17 Nov 2021 03:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gv/lCEhFluRtvjOnvm9PBb7PCGnoeFgfUiFSnF7t8L4=;
 b=gJYWm3iv3iYN6sgd7VHDsJTu38XrnVADtI2U7EVV7ehvWNuZCmgCpL0gMkRqODASXGmB
 ApB89Li8dhaCXDEu0j2I139TSnXd0pAIpZzenUxQZOcH4bbMoJ8yM4HECr2GwYT1BgIt
 HT42BdhhRbTIHtHRUzIfJ1DmPtWRdJcY7a4XomWnCU6erHVHaSbhk04rkdTd4iW8WtgM
 SvFN2mjmfAZZ/miXrmCpBW+8s5ROkPinJxbCaputCrToqz/Xs0t3wcxMMbY/QQoiA4Cj
 CiGs1EjCj4d/wsFX+vOiCnasmqWz/1V41Sgzjmd67Fn5V7td9xvEWNCHXs5mmwIkKPx1 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv5dm7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 03:29:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AH3GfbR078543;
        Wed, 17 Nov 2021 03:29:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3ca566c6c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 03:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnDXVAr9ArmG3dFvx8uxm5DB1bjAu3UDSzfrq6k5vlK0/h3RjaCzr8HHdoNPg9P43L8HEdYBQ9dZdqFUphVgz52YMnwD5Y85Reb6ADjP0Lli2d7VjXZN4XcWXsOa0IxXJnKj859xYyOr0TNYICspU+lKpnW/1Dak6mujMPRLTrYfPZPbMRlRO9QMCKQVYM+Wdq2YQg6Ng3GC8kwzGaLXCURD2eE4BMmgXvLCA8XArfcjdTulyUKyqWIqi4q/lQbUu05+GquYdBCebKtsjeTYaUkYs02/Hz7Qx7EkSWJ7iKXVYcnbNtaVk89aUyyS3k3LoY2X6kSmmohl6rtVgssyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv/lCEhFluRtvjOnvm9PBb7PCGnoeFgfUiFSnF7t8L4=;
 b=dgaNkhwkRnN1/k3H7A44KYYPnIGBr7EJPlxcLz10uNj7sZm5mvMF7i4Kgxmfa0ccAha3NWDOcnfelciRE7vUuN/hSvZMk7PR4QcsE3rb0C8MChjlAZa59kIGGGchmOogzLUNVmNz921/nnp49FovL4Kg/hO3gOoTpIdHqem0Rbd+Ig7usdxLYZUHS5dXEgQQaSmy1tlhq/i3XSNE/tZTxsQgfNauxwqMh36oQCn3MrhAeITYoKszO8o/OwJgUcjVJbVgerJy8y5fLfqjpScU0Va9zyYmxBTj8QTd+RC8J6H7IAFs//gspr75l9Y24dGe1xWXg06EFbIgPVUM0NXaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv/lCEhFluRtvjOnvm9PBb7PCGnoeFgfUiFSnF7t8L4=;
 b=SUb6mmAdaTRC38WPpIwCaSbmaGbc+WGrU/Br6/QWtQR2VETSDmVhaYbBok1KM8geVgAHkakfPVT+p8vRRYwz6IuhPtQ0nAOtR21Y+eRRG3pG/0ZZlBl02m6RDPz3hlQQLAWvtlDjHD60oHBlIw745DRoiFqg/79vU5j94KfGIK0=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Wed, 17 Nov
 2021 03:29:33 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 03:29:33 +0000
Message-ID: <5f269a90-7145-0991-5da4-5f03fc0937fa@oracle.com>
Date:   Wed, 17 Nov 2021 11:29:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid
 from the device
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
 <33e179f8b9341c88754df639b77dafaa1ffec0d1.1634829757.git.anand.jain@oracle.com>
 <20211116171621.GU28560@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211116171621.GU28560@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 03:29:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4188fede-d626-4cb5-660d-08d9a97a78e4
X-MS-TrafficTypeDiagnostic: MN2PR10MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR10MB412527D247E81A7DF9DEADD1E59A9@MN2PR10MB4125.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPm+rOTMBkRVbHaU8Kw1b9DbDcXRycvEMTNfT1Rndl0CYaZ9+jrp26Uwrvv0TzDb7sZgzDzoLq7RjyUAVxvkxyT745XehitNyQPdioYtrycdWED5CUT8UoYy5PoQChFy2WiR2KV8RY2WYCb23XArSrP/LPFz13MoelxGc3qQVOrLbttbxRCkquDfT6wOTijB06RDe4NkOCm40v2sRkUUJ4+usAutv8TZFftHhHM2AjafZDa9rc0VhpLazNxiG+cA/LyIg1BfMU2AogdIMkkViCoRGHgUHuqUM548GaSudgphU/j/1j2hAYeV9YPZ0ZtZqKwl3k03nQEYWoy+QuTi5FIdYTgrNLDg0Sj0EaDztfsKLZKkTY4Hp1Kjn5AFIgJB296mXg+McRICVLCZn5dK2cEm+3RdKz5YCJyXHBM91RxcP1c383QYsMnCTy3PxACFWYllud+kh/QqZyFvddZA85T0glmWbxN7/wDzntsds+saI/YY2B8CQMqmA4FyK2S8E06Sz09rZWMjhLMNP0hAsYvHTZqvv4gapF74zEFCYQ1CVIU9DjMWb1tMMpgh8K2GkSPyfq7uWa1AkCxh43i1EMPSxzq2wevtTOq+p7fkbuYzZNtd3ub/Y/9s1n2mpHyUVi8c/Ynjgy2EGrWVPno8P+ojsRp6l2cy0pFw1RFcIM58gBgxM3/k4yM+heEeFS2dWCpER8yHhofT0Xd9XmNrrKp3o9Y0/WV5s28wW3uQ0J0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(38100700002)(8676002)(53546011)(66556008)(2906002)(6916009)(8936002)(6486002)(66476007)(956004)(86362001)(83380400001)(316002)(6666004)(44832011)(66946007)(2616005)(31696002)(16576012)(5660300002)(31686004)(26005)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklKY2NhZDB0aGlFVEIwY1FiWm9jUWp2SWNOdnErZW5Ta1pJZERLZjVvQTBF?=
 =?utf-8?B?ZFN4dTRMTExnemhBV0tUbTZsTzY0dGdlUkVoMnk5Z3V0dCtDTk9RSnk2YzV3?=
 =?utf-8?B?Rm5oZE9mUFZxelJjUU5pTy9IZzk4ZThkTGxyMmh4T0NCWEVuVWNIS2lFOGgy?=
 =?utf-8?B?YTJ0SGZ1bHNxWHMrRFIxNmtmTkF3MDZtbVd1RUxFb0x1YjJwcWgvK2EyRU5m?=
 =?utf-8?B?U1Z5elUwdWZRTkZoclcyaGkyVXAwSXlESXNyaEVKa2V6Unkxb1R3V3hKUG9n?=
 =?utf-8?B?SzZNbi9uN1o3K01lYllWTHpjbkFaYzdXcVlKQ2lWUkloV1dnZy8rOW1SMm5M?=
 =?utf-8?B?cVkzWHEwbDRockpYV3ZnTGFhREtod2c1L0tPNXdUdlpGTG5JelpYM2RleHlR?=
 =?utf-8?B?Q1l2NnFMYTIyYUdHcFpUMXhQV2M0dmdHZi9PeGxCU3BZejk3RlBBSnZZQS82?=
 =?utf-8?B?aU52UlpKWlhVNTMvUEhyeUt5LzdZeXlKSG5TWXh1S29SQ1RUTG16eDRpL0Qr?=
 =?utf-8?B?eHNBeE9IdFVRYnN1QUVjWkxxZjlSYms0R1BCSmp1RFZxTUttUnZtOWRSOCtO?=
 =?utf-8?B?UXBYVjVIajV6YWI2NWU4ZG1YYnlIS21Cbm50a1MyWUhRQmQzMDRpZnFrWURy?=
 =?utf-8?B?aGViODFvbmxrYzZFSTFoY0NnYWVMQ0p5Y2JSeWsyM2xwVDdYdDQ3QmdVYTBF?=
 =?utf-8?B?alQxUlZML3UxVFRCNnBDS2ozWEhQZDBRcjR3Z3NQUTErcno2bmpwNzNBb2M0?=
 =?utf-8?B?WlkwdEl4cnNTUkJnU2l6dTVuczFQU0pJcEkyZFRBYVA2Q2xqTHdoV1BaejRi?=
 =?utf-8?B?blVEaTk2azA2Z1gvQmttL29IK2RDVE1HOGVlaXlsNGtFR2IwRnJCT0ZBVWhG?=
 =?utf-8?B?SU1ZS0xtRjhMK1duOTd6cUxXWHlSZHRsNVRVbGlwNmI3U3lieElJQWg5QVBE?=
 =?utf-8?B?YllWbFM4aElvVDNoN3ZlV0hUT0Z1RkdVVDhsaFl2SjU4VDFyRHhwSGx5N1hB?=
 =?utf-8?B?b01Gdjk5RkFCbUZJWWNlWkFVZHB2R1ZUeW05d09xVEIwSnAxR0RQWE1PdWx6?=
 =?utf-8?B?NnFTMTk1eFVLQ0pFUmFDMHpvVUN0R2krVXF4WFdWaHpscVppVWdRZWJXSDc1?=
 =?utf-8?B?RHhKWERZckxodmFmdlNDU1hUUlpOZ3Njc1VhbzhrbkFzc0FjMEV0SmV3Ukt3?=
 =?utf-8?B?VWhhYmxuNDNrQUhKY1RPbk1JRTFUR0xBaWhSTTROak9xMURyNEZwQUFYKzda?=
 =?utf-8?B?Q3ZKd3UyMG9GY3BrZFdzNVlNUm5tenhhcWJBbmFLL1dFazFNTy9VaDJhNXpN?=
 =?utf-8?B?TFA2TXVjcHJBbUM3eUwvemVvUTZnR1FWSE5mbVpSQWcyTjQxWERTcTFLbmI0?=
 =?utf-8?B?RHRVSUVqRVpwbitETTFJcmtza251czZpczlVM3ZxaGZEVVVSUVE5UUlCcldX?=
 =?utf-8?B?NWRyclNvZUVkZTdIMFRWQXRRTWhuZ2hCc3FaZ1hpeGlySEtEMXpUSVpnOStM?=
 =?utf-8?B?ZzV2ZUJzZUN1aGVhcmJZclFpaUg0aFhObW16UjNYL1NRSDllVTNqd2lZSVZI?=
 =?utf-8?B?Z1pkMXdjS0s5cTZnQjYzY3VmOFc2MVpZc05kckk2T0RUcDFJaUNwNmZTd2Mz?=
 =?utf-8?B?MWZtb084SWN6YWRVUnV3TGV0ME15Ly9HcmRuajcrcG5KS2l4QnVrdjBRVjhN?=
 =?utf-8?B?YVBDeFpRVVlVUkpyNE51ZFk0NXRjN3BVZ0pqYnkyZUQ1M1pSOUVSWE1nSUFB?=
 =?utf-8?B?MkxQemdhZGxqelgwT0FVUmNQQ0t5UEJnNWtvWTVKZHFPZnh4MWF5WFRNcVZO?=
 =?utf-8?B?WXJaUWVlWUVJclViV0xJNlBOVWdaMkZ3UVhkMzNGUk5vVUNJTFpsTGRYNGZY?=
 =?utf-8?B?b2E3QWdyaDBrdVBRT0JJeXk1cTRoNlBNOTBaOUNPK1pKR2toTXppdGhqd2V5?=
 =?utf-8?B?bFgvSjU0b29FNU1FSGtVSFBHZ0dYSUJjcG9ZYTFlSjJHVEdjSjBjM0VOblV2?=
 =?utf-8?B?ZWJKYnZybjU3ekY3QXlIdTl2ZUhqWnZ6dUpBYnNMdW81c3d0NDhOeFByU0dG?=
 =?utf-8?B?ejBZckd6RlNRU2FaOGp0WFVmNEp5QXdFNFYrdDZJYURFNWVrUXR4bmM1RFRa?=
 =?utf-8?B?UnVIYTRmWUdiMXFtaWg0RHVEWlRSN2k4eC9IdzZJNGxnYURrQmw0NW1ORDlh?=
 =?utf-8?Q?79u441paqb680zDOOKyUbqo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4188fede-d626-4cb5-660d-08d9a97a78e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:29:33.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCx2wICSXw10qy24dSNfYIVnaAwe06x+1fVWa88P7fRxLDIOqH0NJGYU9CUy9c/Sbw3g+/zG64a1RQF7rUKTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170014
X-Proofpoint-ORIG-GUID: DFrcRtY-Ff7wOaSSq3nlhJBHoRj8AMDd
X-Proofpoint-GUID: DFrcRtY-Ff7wOaSSq3nlhJBHoRj8AMDd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17/11/2021 01:16, David Sterba wrote:
> On Thu, Oct 21, 2021 at 11:31:17PM +0800, Anand Jain wrote:
>> In the case of the seed device, the fsid can be different from the mounted
>> sprout fsid.  The userland has to read the device superblock to know the
>> fsid but, that idea fails if the device is missing. So add a sysfs
>> interface devinfo/<devid>/fsid to show the fsid of the device.
>>
>> For example:
>>   $ cd /sys/fs/btrfs/b10b02a5-f9de-4276-b9e8-2bfd09a578a8
>>
>>   $ cat devinfo/1/fsid
>>   c44d771f-639d-4df3-99ec-5bc7ad2af93b
>>   $ cat  devinfo/3/fsid
>>   b10b02a5-f9de-4276-b9e8-2bfd09a578a8
> 
>  From user perspective, it's another fsid, one is in the path, so I'm
> wondering if it should be named like read_fsid or sprout_fsid or if the
> seed/sprout information should be put into another directory completely.

I am viewing it as fsid as per the device's sb. This fsid matches with
the blkid(8) output. A path to the device's fsid will help to script.
So I am not voting for sprout_fsid because it does not exist in the
most common non-sprouted fsid.

Now to show whether a device is seed or sprout, the user friendly
approach will be like for example:
      /sys/fs/btrfs/<fsid>/devinfo/<devid>/device_state
to show all that apply, for example:
      SEED|SPROUT|READ_ONLY|WRITABLE|ZONED|METADATA_ONLY|\
      DATA_ONLY|READ_PREFERRED|REPLACE_TGT|REPLACE_SRC|\
      SCRUB_RUNNING

However, per kernel general rule of thumb one value per sys-fs file,
so it should be for example:
      /sys/fs/btrfs/<fsid>/devinfo/<devid>/seed
0
      /sys/fs/btrfs/<fsid>/devinfo/<devid>/sprout
1

So based on this my patch "btrfs: introduce new device-state
read_preferred" in the mailing list already proposed
      /sys/fs/btrfs/<fsid>/devinfo/<devid>/read_preferred

So to summarize,  I can rename fsid to read_fsid. And, progressively
in a separate patch, we can add <>/seed <>/sprout sysfs files as above.
What do you think?
