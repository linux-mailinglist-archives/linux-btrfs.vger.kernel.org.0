Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B6F7DC362
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjJ3XtR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjJ3XtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 19:49:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02588113;
        Mon, 30 Oct 2023 16:49:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMwudG011072;
        Mon, 30 Oct 2023 23:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2J+EFzFoOkk4LsAzyp8plj+8cbZGtnk+MOWyEBr/x7M=;
 b=Y3XzYcpyAl8Zd8WIhJ/Pfskae6XK2iBA/aYdkyUIEKHBmcO0RXVmi1wd6LolUHMTTU9Q
 myT+hjDyf5yMkBliGrOmF9WA8Ev+yqmc4PB2dtENkf+ikQO9hWNd8GHXIXzYWNlzdfpD
 RNWvFc5u7WVFW/4tLD2NuxuGdWkODJ0lQHtfnlN5H1eMciHsgbipPlEp6SU/D1rePqHV
 Ks/qpvjHxcYrVkRirXyd+0TmtWTSmgfaM3KtnPzL18uvj4/WvR1sZaXcfu1qSEWkQU59
 nnLEfs4IcjmatensKhw75x4Qwpxyuc8BNfkZb9dE8XddL2ANMyibJZeqrFZoPVpLMflF /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdkv7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:49:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULEQLh020302;
        Mon, 30 Oct 2023 23:48:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrb6h77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKj918RJund6ftgcDGtqG8qbm7iUzU4tQyatWrQNrWIaptGkH8MVPjvCBA57tVb6MmcOJZ/ytugahlGr/CzozFvZisOH2+FBhEV1s6bfwyqCPS+bMRAE5raXNa4GusX5eQnVhuUY2HO+mZK6d+6zE/mFjlmgO4zBiNp3pTDl6i5NEbd527geFuJS1TqpEUjtZ2MHBBeIc7aq52idDTv7UKF2m1J6SbXH+9OcSc0s6jNhM+nJ9fuC7etXvZ/j/EgncLzZlByVMqHXvdPF0LK43t91/X7PuApiqJzoQMRdeEuERCfb+lHe5gK58qJ9CrR4RB2C81Mp6R5lXkP1x10/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J+EFzFoOkk4LsAzyp8plj+8cbZGtnk+MOWyEBr/x7M=;
 b=V/AyBzBUswSjgP4doUu11oTG6554u12bQPB6bsvoWM59DnNSU+MNNtGI9dEeD8zuwH4V6srZ66DGlt1pXVc6MAthRWonjvvEXlkuqoVJ32TEtDAC5rqeXRtzWZExvjSMPL0HQQwJIUtFLpG16kPImq0+qMN0zzpi8q1g7Sw3eRwVlaUHF1K75oSjpOXpCYIN0IK4WPf8DORhFLEO5sBYjg4A3Wcvl2XCAHmkBPH0IEwU9UF4D62UUGteAHFRZsjDLcMktyGBn3jLyzOYzuDeDRuAcDJlBWwQimc5EarHRoJ822mdhX8DZ1AW1NcFId8ddaPV6i3rh8HbDEAzZjPA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J+EFzFoOkk4LsAzyp8plj+8cbZGtnk+MOWyEBr/x7M=;
 b=P84Pj6vJMr7CRg9EyrKF0X/JbkCdZ4yRv+zaTJQSHV1F/1bgg2uWjYeQm6cPfVEDNh4OYhbShIcc74zaenMZbE4NLyQgF5HL0HVs4lPx8Q6GI4Cu9lKIabWrgFsmCJGu47cMlq7gfnnfhUbPTpvXNFjBGJD6USQJph/JLVG2t30=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 23:48:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Mon, 30 Oct 2023
 23:48:55 +0000
Message-ID: <6197ae04-5bfa-44e9-a176-47f1d56d8a87@oracle.com>
Date:   Tue, 31 Oct 2023 07:48:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6 v3] common/rc: _fs_sysfs_dname fetch fsid using btrfs
 tool
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698674332.git.anand.jain@oracle.com>
 <6ac586f4697e84c846a36cbc42b005c254b83de1.1698674332.git.anand.jain@oracle.com>
 <CAL3q7H6ia6vg-MyXgR7zGvUOB-hVbFBJvQJmBxpdzojbcF_X7A@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6ia6vg-MyXgR7zGvUOB-hVbFBJvQJmBxpdzojbcF_X7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: aafd4260-1c01-4d5c-cfdb-08dbd9a2c6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vc6czwhfIIekMy5BsQbBqyODJ9flv6MYC/KR6tbInqtU/gphYj4aDE8jSG/jW9nHgKkzvMnCdQgpwl9WLtG7ctG9yxkQAC1DLNLWolwovnds5HXEIGNsLfHBVHIof3RTw5n2Y2u5irF7UzvEfViGCA0S+hZWjI5fn41x129EPy2vT9+XNvK8SCe6Bs4njOTYTfJKkCpoKQbkeEeacdR1wOiroubLilyltUV3ZBHwDpjurb8qdrFBozMDu/ElsUis4NY/2cJzJAF4shrfkrmiEOqBMf7FVq65u67gFmDiHONc51O2hIkoAXTCRRL+VwYrxLw0w/6/2uvseISyM4xijEH2znaYeRsnN8XAboICdh0uJCx2jfHYF0kHBSlY3b0NvHlGYTeUS+tx101nZSGfCmgy3tMULTW2kywZk6yjUIXJiQTRaIQPrR5frvHP3XHadLApTNE2hmTzwFZOr5sLjejKne3UM8piRuxgwAKhxQmLrK5YpWzpKmFTX8PyFrUcuWrLQBgpWOyCzYOTV2x804enwIi1mOUqZQCAIf94ORtcEToR9Z1JDqJ8T1qFX4wNcEk1DV9BmbTFY4o/pw5gDAgDXP5FI/3j68nEyr6L9Jt/ZJF2rDza42sGgTqj9LNGLaJNXYBtUYjneWpZA0uxmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(36756003)(44832011)(41300700001)(5660300002)(4326008)(8676002)(2906002)(86362001)(31696002)(83380400001)(38100700002)(6512007)(6506007)(53546011)(478600001)(26005)(6486002)(2616005)(66476007)(66556008)(8936002)(316002)(6916009)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFPSWdublRDUGQ0cnJCdHNxUEVCbUt2THk5ZTNyWW90ajZRZnFUVTNDZmt3?=
 =?utf-8?B?amg0SzhaR3BScjlMUllGeFNOWDB2QVcrelB1SUN0WC9tN1NuS2RYOUNEeVIx?=
 =?utf-8?B?N0xpMXlNaVZtcyt1NEJMQkZBaytsb1FkYWNvZzdkbmQ3SElJcThNT0s3bFlz?=
 =?utf-8?B?RTgxRGRJTXMwOFJuREhVNXg1U2FGellWUFBDcFJoVCsvT1NwdUN5MnVNR3pr?=
 =?utf-8?B?ZE5vWVZVTy84dzlCUzJHSWVWS0l5bkcyTU1CcnBCQ1BQRVhZek42M3M2emJR?=
 =?utf-8?B?TUg3dDZuS0VKeFVqdUVrd21EcEVIUTRkdjdLWkpNVUdwdURJNGV3Ump1QXc5?=
 =?utf-8?B?ZGtTb0ZGdW0xb2hWSlV5dXVEQWg2REZIcGsyU2dkR0ZmLzErMG9NRVg3NEY1?=
 =?utf-8?B?STJCK3BOU2I4Y3JEVU8wb0xOV1VYYmxlN0sxYStkVTBqL3pQNUtneXZBalFs?=
 =?utf-8?B?TzhDd3dqTWZSay9Sc1lLY2tqclhOcE9kbk4rN0pZcDY4WGIxSFFiZlZTQkVm?=
 =?utf-8?B?Mko3Um5veHdyM011b0RrQ2xmZnQzbzJhRzRUbTJZajRpdkcyc2lGaVVCc0dB?=
 =?utf-8?B?SmZGRFBrTDBkV1BTdkRUY3BzRnJVQzc5My9CZlNQMkxmUDgwSVBidFdINmE2?=
 =?utf-8?B?YnQyVUhEeTBZK2gvRnVlMUwvMDc3ZzMyY3B6blNHSnRKNmV6ZzB5UlkxcTBr?=
 =?utf-8?B?SlhjM2EvYjh2NVlQeHZGRzBjZW1tMnJwVXNWRDN3L1NVd3FVM2J4SzZhajhz?=
 =?utf-8?B?YVZsZ1NoSWhJQ3pvbnJIekdsakoyVEtlbXhhTzl3dEQveUZxbTM0c09KSElq?=
 =?utf-8?B?TDRzZW5BZHBuNU5GWEZJd24yYUxja2NNU2J0S2FRaVBIYTlkODYyRXREalB0?=
 =?utf-8?B?Nk1pbFY2UDZTNlprWFhtUURHQVd3YjEyM1N1ckNieXBPVTFUTHdXS3QzVW1q?=
 =?utf-8?B?Wm1MdElxdC9SM1FTRVpHUTZsazZwYmkzUytHQmprY1pDbk80dUVpeEJETUNP?=
 =?utf-8?B?NmpRMmc1QVVQdFV3ZGxUTTh3WHBrSXo5K2RrSDIzRWk1ZkRaWE9XUWJzSU9V?=
 =?utf-8?B?cXNJbkhSK1Q4V2MwVjRZcG1IVE9FUnIrbVBuNDA5eUtqQ0dsaHVsNTY5K2pY?=
 =?utf-8?B?dUszZC9nQ0o1L1R6YVRHVzc2OTBFN3pGMkRrNlUrRzRuenpPVU84WkJuOVp6?=
 =?utf-8?B?K0ZxMzVWQW5FcDVDQk5ueHhrcG9uQUdObXkwbHU2N1JlSGRjQ0d6b0lVVEhP?=
 =?utf-8?B?UERIc1RDRExDdy9HRHpCMkZ1U0lQbDc0VEZVMXQ5SGxtM0hrcnB3ekF4RzlM?=
 =?utf-8?B?TzdYZ1RHMXFSaE9kTVlNWkEvOWZLVS9yaGxXVUNxZVREZHRMNkpBbmszZVFO?=
 =?utf-8?B?MzVwUHVKcWVGZHhMcHRLYnE2TGZHWkhXbXZ3eWMzUFh1dDd0c0syQUtRUENz?=
 =?utf-8?B?Z1JNcm8rZzY1VDBsTjZBT1l3M2JhamxEQkxncXQxeFRBQUFwMDlXSWlaTkFT?=
 =?utf-8?B?TGVYY2R1a2VaS1pxdWZrMERzMHNianNsQ0NnVk85Y0dCSU5GbHlCWmFIN09u?=
 =?utf-8?B?dFJ0YXRIS044TDQ0UUVldko2YkhUQ1FLTDh3MkdGWEk3eXB2N3lNTGpaWWJL?=
 =?utf-8?B?c2FpeFdTaldMMGdtSjFoYlF6UUFtQ3diVnNkTDFRN21yQTBocmtZaGtuYVRC?=
 =?utf-8?B?MnVCc09abFp6eXRveGxrSWFRSEowYjFYYmFNTjRPcUQ2V0ROSVVRK0xJeEFQ?=
 =?utf-8?B?S0hScjZKanBETXB3Z1JhNkJ1ejY3ZCsvdFNCeWdxMkxFK1M4Q0JMYkswNStz?=
 =?utf-8?B?ZHdXeVJZS08vb3RaSWJkMVlPMHFEa2NJcG9Gb3BiS3ZLYjhndloxditSd29o?=
 =?utf-8?B?dFVkM3BxTTQ5eG9PVXhqSjE5YlBXVGpTV1YvOHY1dkJ3eEIwV3NJeDFGOEYy?=
 =?utf-8?B?NG1hMmU5bnV2ZTRva3gwMGdLZ3pCcjBmOWFSck5uOGZWcjN6c1dIOWlqb2lw?=
 =?utf-8?B?eHdDb3ovWFNBV200cFQvL1lpZU9OTUpWTnAxRS9MKzBHVDZEamRLaHo1WlRm?=
 =?utf-8?B?UXA3RXNyV3VkbDZRT09UN1hldzJ5bUlSZkZmWWJHdXQ1aXJaSzY2UmZsZmlq?=
 =?utf-8?B?U09LdmNwMHdzeGVIcXBCbTFIUnVjUE03NWVTdkcyeDBEWnhjS0hMbk5vaTVh?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lychP/Zdm5qPGmQ9TPThDpVu6HSnVuvPshoLR7jO7nGSg8KhEX3/OITzXVETEEiY/Zl2xtTPqAm1tW7KhpXaOmu2MgqqajeRQnLyQ/1HKRuklW9wW3V/AdSSo3pE+FD7Ycwp4rZbRZ/imx6zBha+mawqaTUiAwVJUlSrLAq1acMBEIH7TMY66pz+SVt45aaYumdveO50axtAMiDupzyh3/vwE/2nMwC6y6nwyZoF6f/HMaLfWUzScZQvgtKFIpA9Ly7Zo50CHNudCoHxa4WhZLkIKJs4j163Mss6pKsfXFOCqnPDfQVGPgJdGHrsfN9IvDP445NLIC6s/vpfUtn4qiVMr7C1V7bJWAnfpNuriXQogLwSzPP9gN2/VK0x2QwaWR6er1I8e7J5ufOFYn38KNIPGuIX/FTBPoKAsBRjhy1iEyBMhqgJjh5CPu9r43qT2UD9Yf4n5p64l8/MHqtAERtgxut7GD39Qzib6ExGWRask6scQt45ekOt7fyXg+fZqaK3mxUk07ZscMUhHjGoPDvLhgy/zjqNIZUUtJqDCT+gKO45BvsiWoIUBZbbB3BNn1OSr0xVo965Gtk1qBSlsip5ZV67WNAjOEbP1Ju4uw1dibBN2d5QHq4rgBHSWBhnBnQDmd8PeXxpIAOkeQKa0KKNdqXYETU9voIKVx9+KTmQhDdnw2hGc55Wan22iMtOp0ltqK3HYZqZdpbAXQ4IBDBoO1c7F7WuHAg4L0UiphZYOq6CmbAHS35wIEH215zYnWDqhxxVSXkzDlJXuRPPfm2HW4/SiShDJhJEqyDjliQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafd4260-1c01-4d5c-cfdb-08dbd9a2c6da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 23:48:55.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2lprgHOeetfiCQCUQvd7SoiXT0hKIfhrFiZcSmOQcqiPKfQV++g2w3ieAnkaqDHyzIx48Yn7+ukWKgheJL0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300187
X-Proofpoint-GUID: ikdK3R-7_HgDr_1hD6O_yxhhnXlGPNRe
X-Proofpoint-ORIG-GUID: ikdK3R-7_HgDr_1hD6O_yxhhnXlGPNRe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/31/23 00:16, Filipe Manana wrote:
> On Mon, Oct 30, 2023 at 2:15 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Currently _fs_sysfs_dname gets fsid from the findmnt command however
>> this command provides the metadata_uuid in the context device is
> 
> in -> if
> 
>> mounted with temp-fsid. So instead, use btrfs filesystem show command to
>> know the temp-fsid.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>> v3: add local variable fsid
>>
>>   common/rc | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 259a1ffb09b9..18d2ddcf8e35 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4721,6 +4721,7 @@ _require_statx()
>>   _fs_sysfs_dname()
>>   {
>>          local dev=$1
>> +       local fsid
>>
>>          if [ ! -b "$dev" ]; then
>>                  _fail "Usage: _fs_sysfs_dname <mounted_device>"
>> @@ -4728,7 +4729,9 @@ _fs_sysfs_dname()
>>
>>          case "$FSTYP" in
>>          btrfs)
>> -               findmnt -n -o UUID ${dev} ;;
>> +               fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
>> +                                                       awk '{print $NF}')
> 
> awk -> $AWK_PROG
> 
> Besides that, it looks fine, thanks.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 

Fixed locally. Thx.

Anand

>> +               echo $fsid ;;
>>          *)
>>                  _short_dev $dev ;;
>>          esac
>> --
>> 2.39.3
>>
