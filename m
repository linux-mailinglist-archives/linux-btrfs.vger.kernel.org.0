Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6E75A5E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 07:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGTFsu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 01:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGTFss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 01:48:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486EE1724
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 22:48:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K3O0Zt001590;
        Thu, 20 Jul 2023 05:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZwyBYDSpFW58H1PDDDoyBgPGC+Jkj6eP0dUym20E3ZY=;
 b=R+EGpROR06T6WpM148l6Pz0MiUgOyDcNxjUJ5hTmfqNPCr8YAyBfLla6WNhuxuiN/rF8
 yW75LrV26QJVLIQfe+FLjBXcHXygmDz1dNdO4hsvRvBCYzVQxButHcc6xacQhwU6iGP9
 vG6L15WwWewCUFMkeGa6zJjoeUkxCRNuliwnR1KG6/oBJ96zjLk1QRZvhlMKLF28UorJ
 XinNt23EhxAr/o0wLcBqCMTAg1GXi11mGtgDdHHOSeS1qu4Kx4dElDzbWyEaBNr7hZ4Z
 S7tS4cyEn7Ptg0Cdy/YgewFPAESUQWEXj5+4vu/xQbEWN0OvH/oB9uK/DZ2s3GnALNBA ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78gwvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 05:48:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K459IW000760;
        Thu, 20 Jul 2023 05:48:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw82ws2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 05:48:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+GoMSVIeimMHzK9KpekuQd/TtwElUwMojT8aLuBad/eVcea/xpTePAVb66LZmAg/+5AaSUJs40g+9rKHVWe354rglpqPm7mOI9xBBEXR9P+DZ5B3UqNp70yHJOrAuePKSAy5TV/xO6QDX/8V0k3yTHxFIY4KMP+VKKH3ElkKqSuOyS4W5KR7KP1klWvlDVkI3K04JPzLiHux1xdo9OAJN3g2dhbSoy8DsKJBizkr65+0l4l6k6Rzyeo7xDd/OrI5qY47Pl8DGBvpr6SV7i5jIrDk3R/UswCIWhp1dyzgeNNZRSF4/ptpCkuKGHg843mFpnGFnHt8DGWHTvP58dOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwyBYDSpFW58H1PDDDoyBgPGC+Jkj6eP0dUym20E3ZY=;
 b=IbwpXfCR8jd1x3prfp26YwVEE0qbp+KZuTjMMCdXzB1OIasAGx4uDy9XSlQ2UqQ1Wo1W+SoMGZdQomQQBGt1gbuAEsPm5vD4yCv48B/oan9obpG5uDg5BQjwPna6sbsJbucRyQgtB8wfHJwduFizahrfQlv0R42w9uC7wsujlpXVcBizsmlzT8GbsIKi7cjxZhmlzLZZKYfw1OOhPL4Ong/99NNeAGpVM9Xu0EXKnZ3LGZSsmAJufB/jD9rKEvf2bSDfhBF0wCscfyKFP3fAhKS+w3Z2qVY18wvDDv2KexsR9BkB3X+FKp0m9s+d0cDFktPzAWCgghFkxQTbT9q/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwyBYDSpFW58H1PDDDoyBgPGC+Jkj6eP0dUym20E3ZY=;
 b=L68PCiHVSP4QJe0JAy6iD8/94aKuA6XklkFNg9Rj4NppUi0KxpYISBh/h/Su3sz/9OSao2hBScUuY9BILQ/rxPurb98z2CvncXaG1TrShkZWxIIcLCMLqFl1KgP7xN/SiFgdae0bEygha02pcQN4Bl1WTLZVLdtoM6TsBHJj4nE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 05:48:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 05:48:32 +0000
Message-ID: <5b436e82-cdd4-0f84-71af-014c41c3e12d@oracle.com>
Date:   Thu, 20 Jul 2023 13:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: RAID mount fails after upgrading to kernel 6.2.0
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs@vger.kernel.org
References: <B3M2YR.U71TM7CWM1P12@ericlevy.name>
 <b3517b3c-f966-53fe-3c70-8fa787755672@oracle.com>
 <OKQ2YR.1O44EDSAXJ853@ericlevy.name>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <OKQ2YR.1O44EDSAXJ853@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 167ec183-43f4-42d9-8409-08db88e4f31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftsbnraLboN/5Xp8a2FguXMPvUU04cN6w4E24LFUoG3CIayOJIRot4ecQfpCsgBH/4IUTMBWF84h5eCbAnWysaXVJmR4xk6BXZRBlj9kOWJ5lyTGL27F+W/aSPeAdN8N1HL0NYU5pYb1pLU/iCehg2/R9YfyfeBjSO07DAovwPLxwMXhmMmvcfT9kBdcTTSWirmrb1Yh1ENKtfWnyfoP01gd0s3Qh/YIEqpQFgQG52IBx4zPYESy6XPnCeognte2U0KvOQU/a2K0TJtbXQTFwaUYANw4B8wMkwo8jfU9qYFqEHxzI5/L/A6nBFA0UhbPUVBiYJiGj68sg1LnoJSZzLtysz8l9oi9tg2pqlEfS+YWfvpzDbpLen5mSt4v3Up9cZXbqkzF9Gclxic5jxUyNP0rFXS9piH+EDGlp3I7/mjhf2E1UBu2/b2Uj5crO0sTG27WfhVdiOK+1W6ZbpC3+CZDfEZjX7QZ9VzuWdItY4OKr3zkTBU0C6/pNrTqP4jEMgLB9E5U6l+nA0ygv3Mc0ewrAgiP3Vh+CTH3ERGpCo7J0NdfsZNfYVgQiPAi2As3i/mi3Jiz0AvAqALguJ7c0O/gPfFwNj7Pqb1kLnIpQ+GLlWaKBD5a+scgowvf/56mDa8jCJm3nDyjElXSz5g77Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(2616005)(2906002)(83380400001)(31696002)(86362001)(36756003)(38100700002)(31686004)(6916009)(66946007)(66476007)(66556008)(4326008)(316002)(478600001)(26005)(53546011)(186003)(41300700001)(6506007)(6666004)(6512007)(6486002)(8936002)(8676002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUlHc0Qvd2t5Z0x1dmU1cUl3dWlIa1k2NTlGdjBXNGN1WUdoTGZVd3B3SDNu?=
 =?utf-8?B?ZnNLNkF3V203NFlHMEtDQ1BtOHJUbzl1OS9QZlBMeE1LQ2dHWkluNUlFRHBC?=
 =?utf-8?B?cEtnaCtsMW1LY2dQNXE1Zm1VMW5OZ1ZFdXZ4cFRldzA0aGpvN1lteXNZSmU0?=
 =?utf-8?B?MVRsQmx4NnlQY3RxWGk5QzBRN2lZdThFRldZYWpDQndFWUxNQ21GT3BVTHdF?=
 =?utf-8?B?T1UrN20rV0pOeEd6a2FMSE5sRXRpTGRJOTk0YVlHbWh5MGppelRHQWk3ZjVI?=
 =?utf-8?B?NEhyZDlaUmhsZUkwZlRMRmdpLzdJUnFMRUxWVklBei9lMkFMMy9UajBCaUMx?=
 =?utf-8?B?Ti9SMkM1WnVOOUtRdEdwUkFSNTdWbUNmR2o3OGV6cVo1U3R1NGo1SDE0STdu?=
 =?utf-8?B?UE83Q1RiZlF0SU5HSTlldXZOWGRZaHhiblhXdXgrWXlYbWVaMERhb0lKeUVB?=
 =?utf-8?B?UVZmbE5nU3FwbmJTSHJFUUVqSHlJTWZyY1dLV0lKbmpzUVo4Z2pkR0dYejgx?=
 =?utf-8?B?MHVOblJVbmdqWUxrZnE1RXBtaGljUlpQMUJ4azBja1VVYTdzb2QwTmNjanF5?=
 =?utf-8?B?bUlmeXl0dWo0WmMweVpObmRLSDZHYW1jWE1VS0RqNVAxWDJmeXUyRXdrY3p6?=
 =?utf-8?B?Z3E0U1Jscjl4RHM3dmdWejlFT0xmS0k4NnA4c0FRdjJDdk9lZnI0V3hnaUNW?=
 =?utf-8?B?UDl0aHNES1Q0ZU1nZDgreWpzQXpIWnY0K1lZYlV1MHBMM2o5RE4zQnhmd0xa?=
 =?utf-8?B?MWVBbk1KNE80ZUQxc1dyekFoWmRXL3U5dmpKOG1tRkxXWDZFYVJEelh4dlM3?=
 =?utf-8?B?cml6cXYxZFM3RVVIb0FsOEFzTVErUm1SQllDOU1qUzV3WER0a09VVWkwam9U?=
 =?utf-8?B?RlNYQlBKYjRMWkFPOEtiR3RJZjZsbW1rWVJ5ZjRRZjUrWktBSitLZDkwdUZY?=
 =?utf-8?B?RGNHbStzSHErc20vMUVzckU4RTlYM25VaFo1cVFsTUxCNGljemVQOGdqU1pF?=
 =?utf-8?B?N29tbGtmdElKU0xFc0ZDckdVSi9TUWZ4LzRGNVBPSWhETFUxM0xRU3B6d2Mr?=
 =?utf-8?B?Y3pWYnRjRkxPR0t4UFQrSytsNS9rS3k2NHdCaS9ySjJHNVcwV1ZCRkJRTjE3?=
 =?utf-8?B?S2xma2JodTl6U3hrOEppNUhrWk55cEUxbTdPSTZDWWFhM09jQ2dSeHhXRk9D?=
 =?utf-8?B?cjJoVG9TUmpLTmtvTHptbnIzSUxuMXkrY3cvR0ZwL0JZdzdYdDRUOEdQbWI1?=
 =?utf-8?B?bmdBY001QlF5YWdzT284VDRyc3FMem84ZE1NbXJzUzRzd2ZsV3p5TDdBZlla?=
 =?utf-8?B?OWhNd0tMcWFjbzFsclhDWEpjUkp2UlBoSkdhTmZpWmZXSlJYazZnTUNkT2Vs?=
 =?utf-8?B?S0lSRWRLUFR1bGZabWpybFhrV1Y2U0pZa3k3SDNaTkV1NHNuL1ZPTEZ6QW9I?=
 =?utf-8?B?NDFqZ0J4UkVteDdkMXNTa1I1RFVGS2plcDR4bkx5Skl4SDlmcnFMRTQrTXZk?=
 =?utf-8?B?cUtwQ01WQmhvNGE1WXpHZXpLcXF2eUZpd0hUOWRPL1BFSWw1elcrcEk4eVVm?=
 =?utf-8?B?TFJXeUw0czFoSW5KcE13UEJlbDVBQ1ZIUUZzSXg1ZWFCUUc4ZDErUWQzaVpx?=
 =?utf-8?B?cytzVzNOdm9sMlhmQ09KakExVFg3OGE4YXJXWHhhazhiT1R1Y2EyNzM4VUp1?=
 =?utf-8?B?a3ArN0lnMXNvaWJzaVM5YXV6c010YmlidUFLMXU2bytHYVl1bnVyRGlHaGpM?=
 =?utf-8?B?dHY3UTgrNUxVaUEvWTNyd21LN3VvdlNicTNnV0dnVDJhSU9NVmk0Y09oOFlk?=
 =?utf-8?B?ZXdjMXdRdGlYbEZObTNzYlcwOHZncGhYUUJ3NHdBZ1pMLzQzQVF2OUFQTG9J?=
 =?utf-8?B?Mzl1ZjJBODZiTTZWUjFJTDgya3l5Qi9YcWhhSS9zeEl3TGkzTXJGNmcvWkUw?=
 =?utf-8?B?TmN5QUludnhxRUJnMThvQThGZXgxL2VCeldyYXBzdG0zOXJVeVJUVjZrT2Jo?=
 =?utf-8?B?MlNFRTdzUDdWMFh5VENzK3pleXVxU21kNzBqbjNEaS9BaCtyL1ZlTDR1aS9H?=
 =?utf-8?B?cGFqMThQb2xnL3Qwa1BSamEzczAwRWpYRUhndlpWRmZaK0xrRmZNNUE1QzFm?=
 =?utf-8?Q?0Xm05BpN6lFlzIsP0tTJSOoYM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HzJWuzPS16Bp38QA/8o9+MYczE3vIqpW1fh3zbCieGwkDaSC+RsgcA+3goxP5s4FTu4+SQMy/BXpTCE9uP8ufwTtDbntqY3Ag6AXPyIcbc9Qdh+kVdO8lbjZZ7UK8g7Ab4tv2YImqUzNBoT5sY9yPQXhpE+CnDMAqy334u4WYNAS4GhGAqeGa8WCYGD2PmIHpk36cDTmj1FQHmQOUSE17NqLLtraeyMQd/8cBDbM5+6gEEHZAUVSApPdzz9IizdQ/6HpWS+8e+SZUS5FMpbaOxuf8Akg4qOfVyIFRcQN6zFdFStc3MjUMg5pl1akrn07nYpVg7lefORbL41ncF4CNbG2zyh/k4m4uHM/wWmgABMNhKzrB874GkQURDuAiPWIBpcA9znP58T24qxKuGGg4kVayIBCp/feWhN/wUTHZyOnvGtGIr4Wo/mCHCJRzIpj5+6lYn/JG5yGYirA0DclcUXbGLcu2V1WwnQlTwgKoANK7Obzf2/6D1RrLSlIV2Zv7S8p+Dda1fJtu2LIMEPaYyNwHroCbGmHTl1ZlePzakMP9Mj3xyTO26IEeS1JCpbN+USCnE0LiY6LLdh5r7FZKY4GLq+LyHJ+zDKeftBIMNp4m8qiZIAWhdffr4E30uKGaCB3dLgVlGOnVBAqkt4I/fp+YzRdFqyIzuK5rJbGhxtjaVC6dcFT/1TkCUclVOHFd4Erh6zZvX3tg+ryIGJ3t5K+3sEeQBEtwFMU4Bjpx1blBk5G0VpkIQJy4ljndZ7WeVz9x8UZUPAu+CQFlCQbQ/Q+zu08hE1lMpzVkpLKZKU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167ec183-43f4-42d9-8409-08db88e4f31e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 05:48:31.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb7pwc8KQGfZFy6S4QRdDL7xT0FhPOw0DnkVF6OufYtbb4sXOdQJOtBBeU5aAgMrvJZcdm5kKdbOrlpDy5KZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200047
X-Proofpoint-ORIG-GUID: hdD-V2S5T04dxiR5OuzHuWUeysPRc33_
X-Proofpoint-GUID: hdD-V2S5T04dxiR5OuzHuWUeysPRc33_
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/07/2023 10:50, Eric Levy wrote:
> 
> 
> On Thu, Jul 20 2023 at 10:26:57 AM +0800, Anand Jain 
> <anand.jain@oracle.com> wrote:
>> On 20/07/2023 09:13, Eric Levy wrote:
>>> I recently performed a routine update on a Linux Mint system, version 
>>> 21.2 (Victoria). The update moved the kernel from 5.19.0 to 6.2.0. 
>>> The system includes a non-root mount that is Btrfs with RAID, which 
>>> no longer mounts. Error reporting is rather limited and opaque.
>>>
>>> I am assuming the file system is healthy from the standpoint of the 
>>> old kernel, but I may need help understanding how to make it viable 
>>> for the new one.
>>>
>>> Mounting from the command line prints the following:
>>>
>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdg, 
>>> missing codepage or helper program, or other error.
>>>
>>> The following is extracted from the boot sequence recorded in the 
>>> kernel ring:
>>>
>>> kernel: BTRFS error: device /dev/sdd belongs to fsid 
>>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
>>> kernel: BTRFS error: device /dev/sdf belongs to fsid 
>>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
>>> kernel: BTRFS info (device sde): using crc32c (crc32c-intel) checksum 
>>> algorithm
>>> kernel: BTRFS info (device sde): turning on async discard
>>> kernel: BTRFS info (device sde): disk space caching is enabled
>>> kernel: BTRFS error (device sde): devid 7 uuid 
>>> 2f62547b-067f-433c-bec1-b90e0c8cb75e is missing
>>> kernel: BTRFS error (device sde): failed to read the system array: -2
>>> kernel: BTRFS error (device sde): open_ctree failed
>>> mount[969]: mount: /mnt: wrong fs type, bad option, bad superblock on 
>>> /dev/sde, missing codepage or helper program, or other error.
>>> systemd[1]: mnt.mount: Mount process exited, code=exited, status=32/n/a
>>
>>
>> Looks like the fsid is already mounted. Could you please help check?
>>
>>     cat /proc/self/mounts | grep btrfs
>>
>> You could try a fresh scan and mount.
>>
>>     umount  ..
>>     btrfs device scan
>>     mount ...
>>
>> If this doesn't help. Can you share the output of:
>>
>>     btrfs filesystem dump-super /dev/sd[a-g]  <-- basically all devices
>>
>> Thanks.
> 
> 
> The unmount command followed by rescan does enable a successful mount, 
> but the suggestion that the volume was mounted already had not been 
> validated by the dump of the mount table. Based on the mount table, the 
> volume appeared as unmounted even before the command.
> 
> Do you have any suggestions for how to resolve why the volume would be 
> registered as having been mounted?

  As mentioned, dump-super might help.

