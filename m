Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69318652E1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiLUIxg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 03:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUIxc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 03:53:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75D270D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 00:53:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL8m2lr000693;
        Wed, 21 Dec 2022 08:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OVPPQoWhiDQ+QJcwfxJ/SyrG4WTmZSGLFFyCtzBfbtc=;
 b=oKAa8SGUHq8lhcpnmAyEhTI2Pppi+HRgWbPVeORXacopSNGH2YQgEt81i2r7gZoQzdP3
 HiSTEF/OIfSoe44cA15eeAKUvlvTuVFgaFWoIg/kStr7pIuhfkyG/S7KpICPDFzFJ4CJ
 VJjs6SUTbzZVWJor54zJDaAZc4lq8f7F+Lv8+5hT8RqKpqhMJ0LJsafoPwE1hrf6nZe9
 6SRItjnP8wd11OlRlIVYJq2iak84uYSmwKscTkDm+RGu/OE54cYIDP538nriXTI4p14I
 ZskfYD3CVUX+SZoeScmRNO8zruOf1wIcPsqaGWDKztsaqnIOc/EviskkfLa8zV/wvhhS wA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tm89qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 08:53:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BL7GYf3004671;
        Wed, 21 Dec 2022 08:53:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47cmm75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 08:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly6rzMHavJQSAVjsTK6wcxACHjXXA2YkbQt383j+t5TqzPgryV4fwOHjybfuZ6n2MF9U/h2z0UL7ctSbWlfkn/bBIEtLYxEimLPTrIn2DImsNKDwES3i08htI7USk7/v1Vg0bkoOOEUk3nbiBu2E/qte1c305Ja/aYk5DCM/f3cHf9EAx3xAtJ/JHzsIcdpoDto5uHMaO6TlR4VXC5pPzcF7PmF63JaoFnInGd9xQ0TWChDIAh30955G5nelszV7y7guxcLvH2zF99YeDwy06fzbFIvqWAVRIy5mxw7Y0rUmOiYUla1CjV0n2YtwMqssZzs5A4dmUf35B+mvTsEkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVPPQoWhiDQ+QJcwfxJ/SyrG4WTmZSGLFFyCtzBfbtc=;
 b=EM2Z0mMMdOZqnPVozltG3Iulvyc2LaWGtUnjXlovjsx/JjOj3nxFAZG76TX+XScGxSYbjXDt6MZjGz5Ny2k1ricfK/q1HDMgDYJPaHgT/mAHRKIXbY5y6RVaqGb5WaWQahzjgunyhbBut/1bI3t2qGwUoDX44gnDVIjk1B5UPg57u7TvY2QhwBN/N3XkXKzmsvUb+HyBQP+V/K8kbetTh/BIKflsRhpl9TVKKzL3MWOTmIdbvnI+yYP0GkAByZcBxSQQ/kPUyhfAZ5JA8ZduMeXIv9t0bLFGUU/JaxJ6K6vW616yxuacYb0mcCqWI/aX/UCGhp4wqWpfW+Y71/K2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVPPQoWhiDQ+QJcwfxJ/SyrG4WTmZSGLFFyCtzBfbtc=;
 b=Y7gKsRwwB9vhFqS4gRc5HFhLKYl6JCLhbo5+8FPuRZKYcCLStj/OHKIiazNj9qHV9DYbeg0FC2WYeWRp5PBhhlJUcMjr+1P1ALQS0jMA5VyCM2vU02o3rXBeJHhSUOP8aQAUMbzEz5u+Ep/tlzQNRwFyFvK8Vuv5q5Hpl0v4B70=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 08:53:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 08:53:24 +0000
Message-ID: <5ba6dca9-1975-8814-e213-f98fc1b4784c@oracle.com>
Date:   Wed, 21 Dec 2022 16:53:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: fix compat_ro checks against remount
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chung-Chiang Cheng <shepjeng@gmail.com>
References: <8ab95b9b1469cf773928e720a9d787316dfb44bc.1671577140.git.wqu@suse.com>
 <aba9f83d-76f2-48fe-1819-bc405cb7efdc@oracle.com>
 <a0618e92-ba6b-d598-fa46-29b6f8115b46@gmx.com>
 <a54879d4-a1e3-32f6-fd6b-6b76fc8f0192@oracle.com>
 <4282d330-430c-7efd-4331-d344275e4724@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4282d330-430c-7efd-4331-d344275e4724@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: e985e0cc-f381-437b-15c1-08dae330d171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7iBipt4iwES9dk0sSzpXr8sz36fSFJOkQmh4xrQLYwteQEoyGamCb4DMsu/ozT/1D/PVONXemnQq2s/7AK9j159zPPjWteK2bFXOgDfIiEa/ujkvrjfPiLhwlseIUqtzShXcd/uWvHgDkoo3lvEKIEeR2mkrTvoNX2JMdQOXI3VbLOslxVofpiI350+izemc1VALE2ZIUNI86TMlk+/aw8TqZ32J/ah3dbYZETTeUJPwGRLiLpKP5sTEhM/vRNexphghWqESWxKrwziQN7dbmbi8NqvMGDPT42W+d92qAq9NrChhKx01JT47H2JZhAHVj9/Vepd0cWqiuHR74SJya0ICtzPxm8YDVSkKzMXVb6ypp7ASNTj+MeALZK1blVrmkm1SlKJYMxhEUoKk9LsHc6IlZF9uc0lhwqqvEAuByfVcRCf6vMgQXv75pwUETvte3DgufpmX8CRtGEQ7VRrBa93+QnmcVAAcZbPx6S0bzPn/VjLsS1+OelK7PB6CHcWgVqUFSLP8vf7rEpTujGMsXO6I/bN78MD3sQABQZoQGYxzCxrMNhmE+1P8/jYM5dIL3adwsBfKctGJkm38CL72/iM5RB8LKluDjayhhR9sG/7xIhBLMuNQA28F9myuKWer1ZKw/AxD5LwQxwsNw8ejOb1V3fFF8VtcymROj00EY5d/5TMPXEnlgXxUZYQZMTWr7KOuQOjdiq+NwI2ICj/eRH3vHChpR4QYwjno6fhxU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(38100700002)(41300700001)(8936002)(66476007)(66556008)(5660300002)(4326008)(66946007)(83380400001)(8676002)(44832011)(2616005)(6666004)(36756003)(86362001)(31686004)(31696002)(6512007)(6486002)(26005)(186003)(53546011)(478600001)(316002)(2906002)(110136005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNuTzZSVzRZWjRENUlTaEVSWEVacXU4eFJMMVdCTHE2bFZHUjRyVVVoY3VE?=
 =?utf-8?B?UXMxMms1Y2JTQnAxRG5Ka2JHU2FZeHp4MHBxYkM4cmRFc1B2VG5aYkpLUThY?=
 =?utf-8?B?b1dGcUFPdGFIOWdqM3pQd3k3UUJ6b24xUTVOeU1lSlFWQS9WWXRDS0dYbVl1?=
 =?utf-8?B?aEZYSW9pbHlmN2xVMUNXWGptN0I0N1FsNGxVL1ZmbFZnalBRelVkQzFGYmJk?=
 =?utf-8?B?UkR3MGpyZGVGUHNtQmpjNUxqcXFEQWFxNjhOdVp2R3dtSUo3eTZVazFSMFlS?=
 =?utf-8?B?UFJUSEJGOU9tQW5CZG1Ic2RBVnQrNFNTemdCWUdWblFMUUlnTENLUVRQamVF?=
 =?utf-8?B?bFM4eFpvV29HU29TRTBVSTNIWlgzV3JuYUxrVTY2L3gzaWoxdThZaHFNWjhq?=
 =?utf-8?B?eU1KZDJ6eHhPWnM3R2EzZlhGd1pndnBtbEg4Sk1xSk1KTytJVDBqNExQWE04?=
 =?utf-8?B?MzMyOHdYbmFYLzBUV0YzRDdhQ2tqMnZhaVlrSkd2Tm14NlVDdjZJQVRxSThT?=
 =?utf-8?B?dUdNM2VKRkxnK2NMaFlaeDV1NENLTkxEeTVWSklIT1NCa1NJRkJHdGY3ZHpK?=
 =?utf-8?B?OHBYN29tMUhsOURQTUFwUkpyeS9jdEVFTkJtS3NNUlE3bjlVNDdBcGwza3Ex?=
 =?utf-8?B?OWdpQ1ZVd0tncEhVbkhaWm5wOXNaSUNham1RQU9yenQyTmY3QTB5K21oYUww?=
 =?utf-8?B?dXJRenkrMlF3VjYzakZkSGFGeVFPbDdyUThFaXlOU0ptQWZoYkhxeE9mNG04?=
 =?utf-8?B?NERKY1ByamdOZWE0RWdhVGpuNlRNaEcwZzJQazl5RlNDS09xcHp5SHJrVC9o?=
 =?utf-8?B?NWg2M2tsd05XSlVSUkJoUlpoZXB1OHpOL3VrMmpwdkNTcnVQclR1WjVYVmVL?=
 =?utf-8?B?SFBvZSs5a0lVallwczdubEFNdEN2L0hhWkU2d0lPN3p6bytXN0tOcVRGR0Fm?=
 =?utf-8?B?WWFwOEl3em9VMEN5NkUyenVaempJTjNNZXNtYjNRRktyUFptUzZZbkdhbHpN?=
 =?utf-8?B?R1diZG40WEE0NTlvWmFmRWZtWmZUMHhpOG1pU0ZxU2lJc1JVc3lrTjFDVUt3?=
 =?utf-8?B?Y1pzMHdTem9RbW5pS2xkLzB5d2JRbXJJdFNlc0xrdXBQSmpTS2RBZnFiaUFa?=
 =?utf-8?B?aHBCa3IxYnVCNVBoamlNWUJqdlhlMm1hUmFWZ1ZndW5GUm1SWFphVDUybHlZ?=
 =?utf-8?B?Qk1jdGFObHVIU013c3U5VlczdDV5cTRhN1o5RmR3VGhzZS8vZ2ZnYzNnV1Vk?=
 =?utf-8?B?Ymp2SlJtVlh4dkVFMXpFWmFKZDZ2Rjh6T05xNWY4ajMxeithNFMvUUJuUmJC?=
 =?utf-8?B?VnZmOTdESlk0dTA0cE5pY0g0UXlEMEdka2pLbFBoUG5UY09CcU9wNTdKbXEw?=
 =?utf-8?B?b1A0anhTVlduK3Q0akpqQ29LR2RjNE5RLzRTaTZQSkNoOUZyODRpc3p1TDk3?=
 =?utf-8?B?UXBZOG9JU1FJWGhUQTNabWJQVGRvS0VOQVFLbmM1ZDZRY2dhdDVialVhZ2xT?=
 =?utf-8?B?WE14ZVBzTnh6RFJDQ2Yrc1dNSGYwcUxjQVdvTWkyR0xyR3F0ODY1UStydVVQ?=
 =?utf-8?B?OGIwL05DMEhReDJ1c0VRSnF3c2YzTk9tUEVXSXJMSm41Q1lxODB0QjFMcFRx?=
 =?utf-8?B?bTRMbGlLZlRINkhvRXUzVnY4Y2JQSHlTdXg3cTZBaGlvTm5SQ2c2MUt3Wk44?=
 =?utf-8?B?OTFRODZHNDBDdzhoNE5hMFFmZkYvay91SFk4U05JM2lIcFVuMXllQkJVRUdq?=
 =?utf-8?B?WjJMcWF6WGxyL2hCVHRWcTZLUFlxeXFneUJQSHFHQmwxMjVVSnlJQlNHVVFi?=
 =?utf-8?B?dSszRTB2cUJkZGJSZDFWZEVPaDdBWmQ1Y0doNWdVeUoyRjZRdnhWOUQrWUdl?=
 =?utf-8?B?ZmhHZnFyRStHcFUwM3h5TjdPMmNaaGZ4Tk5NdHFmdDhqVEMzSzdSRUVzeEZx?=
 =?utf-8?B?VUs3eDljcjNyNFk5UnFDc3JhWVF1WmQ4bGJuNlRYbEVOTFVCV0ZKOTZjdUNM?=
 =?utf-8?B?OVJzYzVKS05WN2dmcXBNZ3FMTWJndGVOcHFVS1h1aWRPaERqNTh5bGp4WXRK?=
 =?utf-8?B?MjR1NUFFL21VSVY1TkROUTN4aCsvUDFoTGJqa1ZXbk9ma2xMNEFybnVxWkM2?=
 =?utf-8?Q?i7jcoAP9QgV09daKaZTpBVB4N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e985e0cc-f381-437b-15c1-08dae330d171
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 08:53:24.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJTOPm+bTyh52Nt+UlJ1/AQPTqyprLfKyE+4R/uy1MrobZylfRvQKKfHOAuNb7SCq0lIZ8iy9QbfjsHI7kVPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_04,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210070
X-Proofpoint-GUID: BRJy1xZXz1wD2xMljB_222522sFftudd
X-Proofpoint-ORIG-GUID: BRJy1xZXz1wD2xMljB_222522sFftudd
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/22 16:14, Qu Wenruo wrote:
> 
> 
> On 2022/12/21 16:08, Anand Jain wrote:
>>
>>
>> On 12/21/22 15:59, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/12/21 15:56, Anand Jain wrote:
>>>> On 12/21/22 07:16, Qu Wenruo wrote:
>>>>> [BUG]
>>>>> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
>>>>> flags handling"), btrfs can still mount a fs with unsupported 
>>>>> compat_ro
>>>>> flags read-only, then remount it RW:
>>>>>
>>>>>    # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>>>>>    compat_ro_flags        0x403
>>>>>             ( FREE_SPACE_TREE |
>>>>>               FREE_SPACE_TREE_VALID |
>>>>>               unknown flag: 0x400 )
>>>>
>>>>
>>>> I am trying to understand how the value 'unknown flag: 0x400' was
>>>> obtained for the 'compat_ro_flags' variable. A crafted 'sb'?
>>>
>>> Yes, crafted super block.
>>>
>>>>
>>>>
>>>>>
>>>>>    # mount /dev/loop0 /mnt/btrfs
>>>>>    mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on 
>>>>> /dev/loop0, missing codepage or helper program, or other error.
>>>>>           dmesg(1) may have more information after failed mount 
>>>>> system call.
>>>>>    ^^^ RW mount failed as expected ^^^
>>>>>
>>>>>    # dmesg -t | tail -n5
>>>>>    loop0: detected capacity change from 0 to 1048576
>>>>>    BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 
>>>>> transid 7 /dev/loop0 scanned by mount (1146)
>>>>>    BTRFS info (device loop0): using crc32c (crc32c-intel) checksum 
>>>>> algorithm
>>>>>    BTRFS info (device loop0): using free space tree
>>>>>    BTRFS error (device loop0): cannot mount read-write because of 
>>>>> unknown compat_ro features (0x403)
>>>>>    BTRFS error (device loop0): open_ctree failed
>>>>>
>>>>>    # mount /dev/loop0 -o ro /mnt/btrfs
>>>>>    # mount -o remount,rw /mnt/btrfs
>>>>>    ^^^ RW remount succeeded unexpectedly ^^^
>>>>>
>>>>> [CAUSE]
>>>>> Currently we use btrfs_check_features() to check compat_ro flags 
>>>>> against
>>>>> our current moount flags.
>>>>>
>>>>> That function get reused between open_ctree() and btrfs_remount().
>>>>>
>>>>> But for btrfs_remount(), the super block we passed in still has the 
>>>>> old
>>>>> mount flags, thus btrfs_check_features() still believes we're mounting
>>>>> read-only.
>>>>>
>>>>> [FIX]
>>>>> Introduce a new argument, *new_flags, to indicate the new mount flags.
>>>>> That argument can be NULL for the open_ctree() call site.
>>>>>
>>>>> With that new argument, call site at btrfs_remount() can properly pass
>>>>> the new super flags, and we can reject the RW remount correctly.
>>>>>
>>>>> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
>>>>> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags 
>>>>> handling")
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>>   fs/btrfs/disk-io.c | 9 ++++++---
>>>>>   fs/btrfs/disk-io.h | 3 ++-
>>>>>   fs/btrfs/super.c   | 2 +-
>>>>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>>> index 0888d484df80..210363db3e2d 100644
>>>>> --- a/fs/btrfs/disk-io.c
>>>>> +++ b/fs/btrfs/disk-io.c
>>>>> @@ -3391,12 +3391,15 @@ int btrfs_start_pre_rw_mount(struct 
>>>>> btrfs_fs_info *fs_info)
>>>>>    * (space cache related) can modify on-disk format like free 
>>>>> space tree and
>>>>>    * screw up certain feature dependencies.
>>>>>    */
>>>>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>>>> super_block *sb)
>>>>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>>>> super_block *sb,
>>>>> +             int *new_flags)
>>>>>   {
>>>>>       struct btrfs_super_block *disk_super = fs_info->super_copy;
>>>>>       u64 incompat = btrfs_super_incompat_flags(disk_super);
>>>>>       const u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
>>>>>       const u64 compat_ro_unsupp = (compat_ro & 
>>>>> ~BTRFS_FEATURE_COMPAT_RO_SUPP);
>>>>
>>>>
>>>>> +    bool rw_mount = (!sb_rdonly(sb) ||
>>>>> +             (new_flags && !(*new_flags & SB_RDONLY)));
>>>>
>>>> The remount is used to change the state of a mount point from
>>>> read-only (ro) to read-write (rw), or vice versa. In both of these
>>>> transitions, the %rw_mount variable remains true. So it is not clear
>>>> to me, what the intended purpose of this is.
>>>
>>> If rw_mount is already true, the fs doesn't has unsupported 
>>> compat_flag anyway, thus we don't really need to bother the 
>>> unsupported flags.
>>>
>>

>>> The only case rw_mount is true and we care is, RO->RW remount.

  Confusing statement; Its not the only case it is true.
  as in the table below.

>>
>>   Have you tested the value of %rw_mount in the secnarios RO->RW
>>   and RW->RW? I did. I find %rw_mount is true in both the cases.
> 
> What's the problem? That's exactly the expected behavior.
> 
> We don't want to allow RO->RW with unsupported compat_ro flag.
> 
> The truth table is very simple:
> 


-	if (compat_ro_unsupp && !sb_rdonly(sb)) {
+	if (compat_ro_unsupp && rw_mount) {


           rw_mount  !sb_rdonly(sb)
  RO->RO  False       False
  RO->RW  True        False
  RW->RW  True        True
  RW->RO  True        True

Okay.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



