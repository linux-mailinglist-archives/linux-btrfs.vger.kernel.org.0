Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2FF7DC322
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 00:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjJ3XaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 19:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3XaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 19:30:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E60E1;
        Mon, 30 Oct 2023 16:30:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMx40x019175;
        Mon, 30 Oct 2023 23:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=h/7XQFzl3wlE1Mp86k1lSjjfzzSFBVETXt1Rt9JT1lo=;
 b=jwHmyzG43FKAHJsDEhMfxZaRFizV9/+fYzVeTY2Ooxeq4NDWP3mdI+Tpj2Fbkl5UxnFk
 0dYWp4z/W5pAD2rM8B08cVqGb4x6plptdKcpSKuivLDUtgPzGEtKBIINuhsvAZMnibYh
 f9Ss6KbFrU7rrvEg5//Xs7OFtrvh6kJPVR7qXfMWzl2hMHdujwuwd2m4wQJos7zF/ibo
 FnNGL3pp8U8c1MyLkkzoIO7zZvvULRdPrM6dVEg8IqdeqnH1JGy6pGFcv6cEbAtuErTJ
 APNSVJ0Ef7JSZlgIHubAr8wiasl0vwy2yQqKdXO0rm9s7Cc0HE10iMkq8LMZSP5P7yQr ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqduym4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:30:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULGxvh020236;
        Mon, 30 Oct 2023 23:30:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr50phv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC8KaLUnckcoPdfh853tSLA1xDnmzjpvHUW+b6CRmuCnDlAETrtR6KV0RqRYdsn9+UNtPPYrWEqejb8fLPklgHbUgZ6ludUfRjsB0//yJ5G4iq5ajFIY9rWz9XZcZzAbtMHAI7oZZxgLSMeXshWf7CYRegOGyAhPLltC3WqRPTvji+3HdsHPeVCvmOjXxXQJ9hHvuQDCBKkaCBwxq05UNB1SqmLSXkkHNBpr7bwUC9fgDE1qG+wTLeU7wBxLtIyeXgM0gXUdgD2kCanLv2i6YJGlclWvPkEjoxmOAnfVWgryr62lMV5aCaAJMgGgzowDcrAfijoomN6sQqtQpOhSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/7XQFzl3wlE1Mp86k1lSjjfzzSFBVETXt1Rt9JT1lo=;
 b=BWoSgWSKT1829W5shK1T0KFZel7TUl+SdleaUIoBvJ6YttpTiLrr4aZhOyp2pVg26H/IovN/XS73OhAkgA04Jmazm8Io/jAV5WhRFKs9bK4j3pgcCl94mtLyWVOx//88iDOu4RxcfPSgIPhO/jANKQ3v825cQAtGadzHOzl2SmURyhwvHRU8YEJwv863JL+MXbEUhno+iCFpCseMoGtI2yNF+/oUyUv1Gm0/HrpgzZ7T38avnPqvbTTKq8zBi4j2uyi9INYm5GSzQ32PHu+5xOrvRlOyilisHryn0orPIdCzIUQoXzAbcZV/LpAwsps/2V2eds8/j66BLjhxLZq1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/7XQFzl3wlE1Mp86k1lSjjfzzSFBVETXt1Rt9JT1lo=;
 b=H1IEhgxJkzUj9PDjCOekSDD2w/GdPWUWl4jhdRQK4iFXTylim8+7JroRTeg0APImH6YKZGQ5jz3u3WgSEU+EZGqmeE/JLVYD/o/187x4z8v3okJZtOI/kmJ5IwLN4ODndvsFRmc3txiMY+PzZufiLsw7uTyiIdCyFvB+W3USsSk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 23:29:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Mon, 30 Oct 2023
 23:29:58 +0000
Message-ID: <3fef3451-2a09-4c1d-a096-5b55a9245107@oracle.com>
Date:   Tue, 31 Oct 2023 07:29:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6 v3] common/btrfs: add helper
 _has_btrfs_sysfs_feature_attr
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698674332.git.anand.jain@oracle.com>
 <077b252e8affc50ad3d7826d57ba42a2a8746d13.1698674332.git.anand.jain@oracle.com>
 <CAL3q7H7zgJ68UpK3+CiJBtFJC5JoUiXGV6rcpEMVg9ae=omByw@mail.gmail.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7zgJ68UpK3+CiJBtFJC5JoUiXGV6rcpEMVg9ae=omByw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: cc48b2cd-ae7f-4fb2-eda4-08dbd9a02189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fbn5IX45YMZn6Pv2Ohpcgv6G52xHX150WUzu3j3xWiAK7+WdqDI7V84TU9rUnEUeXZj/WPHTB00Gd2qDngBCBFXGsuA9G0VL1gYHSix7ZTnC82MPIG0iWXjhZugpinb+CDwibpxvXOwUJoi05PSib9aIQEbxRfsqmWOmToE94twkGF8vWyPB4I4haJDRKdUGTd24oqbwJJWfkPi4Ob6SCfmoFIyqna9ZsdXUe18kf6edbftBwSi+bJR36HhQp6rxO011Jb7+A6NDhi+sRP8+SU+XTBN9PiT/+2w/HF7DoEJntiU6ghSSWzsQ9y1XBSPRf0vHv55Wc+Hbn3YKFbVK1uge4nlcXTcmJsUNpyy94GObBaXaXyIHubJJH1McJkPGLiaQjvFMNTwEo1QRu4SHoxC7h5lvTQKGtC1bhfYObmjMEsFISNm95DDDR6sBtQ38kPLgM7mohOO3Ia6NWwP0vjBZd0drOSF5SC0dz9mS2AkKX/wU69fpIPUlN6X0+xEC6hlkrzWG/UDKYqh2HsM1xlP5go2S2hyUFk9YlDnXLX5jzrXXlj+WPKYl+zvMEoP4DRbtofwiaSYBnLrPl5H0U2Z6cIaNdDD0Q/z9aB4ReWlEBHTTcjwH17N7VCaoce5uDIg/ZLmLJjzUOLGlUsOOKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(4744005)(31696002)(38100700002)(44832011)(2906002)(478600001)(8676002)(5660300002)(4326008)(316002)(8936002)(41300700001)(86362001)(26005)(6506007)(6916009)(6512007)(66476007)(6666004)(66946007)(2616005)(66556008)(36756003)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlQrdloxUE5aOWNzK0NyYmsyOUQ5Z1o0KzNmZzFTMlB3ME5OL2M4SUpEalNw?=
 =?utf-8?B?Y05WYWlMVXgrVk0vV3lzY0x0ZzBlTmtsNWVUVXExbmVFK2h1N1F2K2VsakNI?=
 =?utf-8?B?M0dyT002aER6T1g2QnRMeGl4RHpia3BpRXV4MExNS093RmZRby9vTTAzcTNK?=
 =?utf-8?B?WkgzMHVLeWV1ZVZUNi90TFhocUZUK2ZZaEF5WDB6eTVmcWNMWlJGUGFmUWYz?=
 =?utf-8?B?RkZHZXNWeWFoYXV1M25GZU40NFdKcks5a2ROTGRTTGpTYlEwODM0YXRRR29o?=
 =?utf-8?B?SThiTjJ0M09LRkZvNFlGM1ZmQW9nekhMWEI0c0JiVXFJZ05IQ1dBZ1BYdmxR?=
 =?utf-8?B?dHFOOWFlT25iWUQzV3BnK09XdVhjeENBY1pnRHI3Zjg0VHpwSmFmanc2L282?=
 =?utf-8?B?UHpERFJpMStsTXg4TzRnYkx0ZzhuMHNka0c0MEVIUHp2YkVTWUo1a3ZPUWdr?=
 =?utf-8?B?T21JRFlTQ2VzLzkvRmdxN0ZLclNaaFZXcCtRNGd1dHoxU2kzMGlLWVN5Qk82?=
 =?utf-8?B?RldIUGhjMWRBTGdaSnNPTTVTWWhERW41b2ZqVmpqVDAzOXBBc3UxNzhTZkc4?=
 =?utf-8?B?TVhLdnRncVJ2SnRYcjR4YjNycmlVZmpzMjZPTkpQd3p2cUJZT0kvTVZVdmRv?=
 =?utf-8?B?NHh0eVpBL1NCV0VUZU1aYzVuQ0tjYjZ5dWZ0YWdPTEdQUWVKSWpma1dUUnd3?=
 =?utf-8?B?ZnU5U1lFVzdIQm0xYnVxUTAxSjg4c2gyclhlc2ZJQ092c0ZCdXY5RXVRMTI5?=
 =?utf-8?B?UHZWMzFBZWE1RTFONXdDVUV4bm02a1UwMmNPVm5LWUE3TlUwbHpuaHQrOXhH?=
 =?utf-8?B?M0l6cmNGMlJRTWRqSm1QZWF3SmJKd203RVBrZmJ6VkVCUkFZQ3pBa0JnRHdo?=
 =?utf-8?B?dHQxQjBxWlQ2eGRKbDlnd2dFRGNIR2EraTNEYllqczcvb3FCYm81L09OWjQ2?=
 =?utf-8?B?UGd1N2pRRTZOaFY0SzdmUng0YXB3cEk1ZllrR1JMc0llNXNKRmhxVXFMSXBj?=
 =?utf-8?B?MVJsZi95b2VjaEt0bHF5VnNNbkN4dTFURDA5ODN0S2FpRFF1OW9jRzRudEVB?=
 =?utf-8?B?N3E0VEhPcXRGTFNGNzYrTjJyZVBIWDF3YW54ZXk5bDNvWHkvbmhzQUNoTTNI?=
 =?utf-8?B?bVIzTEQxZUt1OHFUSkNXak9kQkwxckNRUjZnVVBDU0N0TG51N1cvbWN5RVpL?=
 =?utf-8?B?UlpaNUhtME4ySFZNTmcxWmRHd2k1QjR3OFRRZFlzMTljeDl4bCtOWFlNTllq?=
 =?utf-8?B?TERJQkFyOWJKelZYVTN4RXZtUjNkOVVSbzhmOE5lMlZVVEMzVjF3bXF5bE4x?=
 =?utf-8?B?eVNkbG85SzlpT2c2T0F4Y0RPdC95SkRLVUhWbHRWSDZ3TFp5M2FGNUsyY0Iy?=
 =?utf-8?B?NHZXR1pmUlo0Q01BVXRnNDh4Z25PYVhvWUx3bTF6RzcrRW9zVWtxSXU1Zlgz?=
 =?utf-8?B?VnRET1R2ZXFYQVlka000anBiRmphangvTUNwNmNKNkdOVUdPSzZxcGdLL2Qv?=
 =?utf-8?B?b0owazJEcHpQNngxSktnZGY3c0pTbGYvVFNrT2lBMCt1UHF6ZXRWT2Q2TkNR?=
 =?utf-8?B?YnFmRWhvYXRSb3puNnBiRlRiNTJ0SytXRnFkUE55aHlRak52b3BBeHFnYXlw?=
 =?utf-8?B?ZlNTL09VK0g3RFg1c1l4TC9nR0JqVWQ5S3kvb2xSWWdTeUpGSldXK3pkMzRD?=
 =?utf-8?B?QktRRzI1MERrYjN1L3ZqN1YrNDNvVkNTdVFnREQ2MklDYVA5UFJOZkdWY3JM?=
 =?utf-8?B?NTk1allJSVNacGtreVZ1QjZFT05FRjl6OUR1VWhhbDNYM3JvaWNvd1U4V01B?=
 =?utf-8?B?enUyRitYMVBvU1NRTjlVMUp0VFZZYUdMY1ZpQ1JBUkgxa01nVnl6T0VkSGN1?=
 =?utf-8?B?K09pNEVlUndKT29WSEdsNFNmbHVKdDA0dXRwNGNrZ2Q3QnRyaWVMaHZhZUlX?=
 =?utf-8?B?ZW1KRVkzcmFiekhVYnJHcUpOUEFnbXNhYTJiOFNCZGxvUE16cUMxRU5WcEpE?=
 =?utf-8?B?TVhMMVltMEQ3Mnovelg5M0pwMVNUK0VRZUQzVmdad0xUOE1UamxWQllBak5z?=
 =?utf-8?B?ZGFBYTdWRDIwM2xjRWNTZmpNTnFNNC84U0E0YjBDemF3c1RnRFF5Z0dwTWdW?=
 =?utf-8?B?NmZFMjJkQjMwSkNoa0RnNW1JdWFrUURBaG1Ld0k2TE5IZjJhbjRTNlRkVDFl?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fwq5me7CGyufH7VUUUnb3b6jlK/B5GtFrRAlqWHVPdkx1o1Z2IETTU/+6BSv8UvMpe28k/Atk6Rpr7tIdP1lkzAbgpN90guXnMnPqz1j2oWD3ORU1K4AO1pJRojRlkncOlYAbvNaosdGCofvraNq6jX2yGZGV1sZfPDuD9XhF4+Yw6ns7QAMkmt+IGwDTeniQAuaqNwyEmWnQPe0HW1X6ZFfjY3LSKMSkpBauzkGlTxfKjoh8NFX6WBTRRpF8uJ7kZsc+l+K5iM9aIW4X6Ib0E9eR7bxvE1Y45pWocQlxNFiejl/NCWGDc2LC0J8l6Iy01bNsbecS8uS6o2l8JN9NZfiDzDIQb+9MfoSqXeMULU6geW8y0vgcZUBcua0iyKSEnicS8AmAbpTC4LmJILEqXWkzS+aZkiWku5wW0OS6XnPph4JNKUqiDXay0imswqDFvIE/X25pM+2FU9fhV2swg51kMAp3/5vfU8bj85OIMx3OxSD3qyc6gZzeGyL30y4tOLtBxN+agTEgRXCqoX4FmU2EFiebc/1czjPYhnjJ7NtaiYSfUrwyMyg3y97Pz9CQexCgPPz+6RwV39u3oWGMQAeG81Vq7CF1A61HzIeBObcdv9WY4aRGbyCVTcYV5BWcI6gCyW21CBsT2J3oEkRT5qGD+Et/hUX3XRqaBJh09RRrdpqc2ylgl9gkt9vzDv/SjQPSdadLrCfkeTHe3G+A/fWzvrh8XCefegrK7JnxD0d0N/zdY7aiR1C6zvqLAgFgE/1F5+JpIWR30GpDmO4UUGRdNIqRucuakOeGfSBdDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc48b2cd-ae7f-4fb2-eda4-08dbd9a02189
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 23:29:58.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 721FbEygOtYt7eS7booBPYwQQM8t3SA4DESCy3pmEpd0LBdpQWEM53j7VNwxuoZtFR56o51Q4GtZZxRWwB2emA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=907 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300184
X-Proofpoint-ORIG-GUID: EY4HTAdtbIWeoN0-aDOfatxsqPcNYArc
X-Proofpoint-GUID: EY4HTAdtbIWeoN0-aDOfatxsqPcNYArc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> +_has_btrfs_sysfs_feature_attr()
>> +{
>> +       local feature_attr=$1
>> +
>> +       [ -z $feature_attr ] && \
>> +               _fail "Missing feature name argument for _has_btrfs_sysfs_attr"
>> +
>> +       modprobe btrfs &> /dev/null
>> +
>> +       test -e /sys/fs/btrfs/features/$feature_attr
>> +}
> 
> We already have _require_btrfs_fs_feature() to do exactly this.
> Tried it in patch 5/6 and it works perfectly...

I noticed that. But, _require_btrfs_fs_feature() triggers _notrun()
when the feature is absent in the kernel. Given our need to run the
testcase with and without temp-fsid, it is not suitable.

Thanks, Anand

