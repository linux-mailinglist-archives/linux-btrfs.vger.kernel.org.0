Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6857D8DBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 06:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJ0EVs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 00:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0EVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 00:21:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD231AD
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Oct 2023 21:21:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R0i7gr006668;
        Fri, 27 Oct 2023 04:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vlrKEU4Z71gVufV9Umlo6QkG5C3tX1LiDsIW2OSwn+A=;
 b=08Dw20+3h9Kwm2fsPhkBvUo7Idp04HQBUyQ2i8+0kDHCSXsFJSyp8AR6+1VHbkSGkka3
 9SiimLMfOvkmS30Ptp9lSK6PaPQK+unNUU4TQnQXihHVTVAiYZdjgItmk9EAVVpAsR2D
 XNNd4SFofQQugN/CdjOdZCDBRplS3bg1Sb/HalCki9FhiEzHU4+eaA6DViRHLxCfv1uR
 RTdEk02P6eFdfo824N6YNId1/Cpvq+/6M8uuuryO/etr4HcCSilU2jv4u0+J57QGJx4G
 k//EVtzn25rbrulL8MNPIcv0HPjJxlVPUIbc6WSupKb30dQYzSGhutFv4HKn2s/6AeCo RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3ngk4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 04:21:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39R2ZM31009374;
        Fri, 27 Oct 2023 04:21:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqj77cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 04:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs9HCreGdHeA1VWMLAA+3RW6VbfwgRm+U0jFkyXKkBkDkC9QHbR6KnNGL/w67VcmuJd176kJjVB1eMnYGFSNui5W7BfX45hlpRGiD0MzrQU4QrLvoSLqiDDiNaLlDAqNs1D30GEptE1VDp4Nm4tXFUZDuDSflj4tSesvt7oTQ+LPFKNlyUeuEMPPv3uDxogiDidSQmdDS+6BKbssTZqg0ZT53s3/OO3hTPuRJGF5O961bD8a6puBN7S0e5QCeHGAqYvGMzJQwTr8aOAfWzOOTTN0pYYcFaDtPgmbilWQcyZBqrlmKTTwlxgvQlIK1+3LqY0NAOEhU0KxCXJoWcIhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlrKEU4Z71gVufV9Umlo6QkG5C3tX1LiDsIW2OSwn+A=;
 b=AoBwOqoWvO7XSabsxk+b220j0EqrCCNrtGPcOLSaJujT1Neac4ZMA3CMjb9j+zDIWoH0GCatrJEfyJzCTeKqADPT8uHuFiLxG+koRpy+wRjRQf9uh8TD+OsmAiwkd1HXqNaqADC1R30YHW7bIlXjaKY8ClpuncCCIxDjEJASbzY+VTo7KHnnn6qKXBPxVE8XS3aqpDPFcEWFhwL+VPSQVDyNOgoStP/INSzDLpqqLVh4cMkM8hmI7Yab64O5mFm/g5mY2jK5YOjaSjt2G7931AS9seu7xVtGWW45RShWeYqC0RQt+yHOiKQyMWdxF8fEcFQTTPX889DI2P6SZADAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlrKEU4Z71gVufV9Umlo6QkG5C3tX1LiDsIW2OSwn+A=;
 b=IOy5gm2wzrCIOOPFEo/O44dxBWsTBP0R+Tu919ECnlr+ZtzplpW9QmNLojzIIHPO+XCY/8yYVnKH2quObatNw3qnyC34ZSE5ui6aeG8y5FtTgWUz50GSXAyzkM2xngLMswoewdIGo6QztFZa1Twvq/KFG4GLmMyFEoKfco6iqQ0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 04:21:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Fri, 27 Oct 2023
 04:21:32 +0000
Message-ID: <de06dca2-9611-4fde-a884-0f4789f7b48c@oracle.com>
Date:   Fri, 27 Oct 2023 12:21:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest
 empty
Content-Language: en-US
To:     Roman Mamedov <rm@romanrm.net>, Remi Gauvin <remi@georgianit.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
 <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
 <20231026021551.55802873@nvm>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231026021551.55802873@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad8fbc2-1e95-4f7b-1c09-08dbd6a432b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uk3h2rNBxicfWSciE3LZ+2i3fMPv/gBSZFKOzjzMYE5RqCI2Y899eZPxuByYpzYmVJDZdkMSOcOMjoo8PIqBXlNUdwicZG2muLrtfRPm82Ysf15xcjhgNBD1sMIomHwLwqRvsv6anT0Y2P3sNpQ/uD+TwIkNYhyggsX3Uv9hqt7HWoSah0I8b/ezHcIjogPHvqYx2eClwxiSdUmueZLATC8xrs/SzZWLeABCOQAsWkMMmyaMya5pKpMg7wdgXHnDRQ8K3ivBje7g1V4jwYzrUV9h8+ssDEsNK0DAEZA8EwlWgT3OW5upFtKMH9/OVh9j6I3wUo41vkh/PsmG8OZsoGgQNPTujm3sbeyKT/vsx8NZBzIXoxVPT+XkH3h8NZ7pqsOHRrS6Ggjo/vOjcDI5WGEWsSEgM1TRDJFCQNKEt2ujYpfmTSXAUvuA40PEXk5YBQcTiAvTvqjEuz0ISb2+uT4wvrNFDhyHPpN9Q/631vvrpujc1hWK/DRXK4zNCyXzY2oPvJvrkhB7dX7+rj5RxF50DjHPt9qkGiFIK1kNSSPDzlb/1YySaDV5Wnkfz2PXbWXYJtyBFIaB577SMjNSIfxDWEgvJMyIX9+C9uskSM7jp6rJqqzz1OzxiQ91Jh82+tl4BnEZsoGqCLwFrOk5rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(4326008)(8676002)(8936002)(4001150100001)(2906002)(44832011)(5660300002)(53546011)(26005)(6512007)(83380400001)(6666004)(6506007)(36756003)(2616005)(31686004)(31696002)(38100700002)(86362001)(478600001)(316002)(6486002)(66946007)(66556008)(66476007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxFV1NoN1orQ0Nua3pSZmRiaGVyMWFjVy9TKzdOMzVocndrL3J2UzEvVHRk?=
 =?utf-8?B?R1VxbnBkazU0UzBBR0FTdzUzTGR1WEVPZDhLeGo3N1J0bjNxNW94ZmJyYXdh?=
 =?utf-8?B?Mmd1OWNOOHNoN0YwL1FGTWRKNHlFTFVvNFY4RmE0MTBBOFRzK1pjOFc2a2RS?=
 =?utf-8?B?N3VLd011Z2syZHJkZTJxSEFwQnZ3RW10c05ZQkZRbEl0cTZyMXhudjdoM0FB?=
 =?utf-8?B?ZGFNSk5HMlRUL1RNZU5weHduNEFEb1pDQ3Y3QUhWOHVkNXNlUmtNWFRMdjZ1?=
 =?utf-8?B?MGVBMUVVeThDMllEdEUxOEdtc0FObEtCTkpxeW5yTFRDbzVzRkdvK1dBTUJM?=
 =?utf-8?B?ZW96NjdJdENYdzZZUGRPT2Y4S1FuV2xoeE5saHdJRzNvT1g2U0RwMWpRb1J1?=
 =?utf-8?B?MTAwR2JSMDlIQmZpL1pKMWs0cXFjT2twdWdvc0RUS1lLcEc3K0tpK1IybzFY?=
 =?utf-8?B?UWVtTUl3QVZtM3RRZ29iSGdQN3g4dlk4b3ArTGpEOG5tUDFxd0VjZDZOU2s3?=
 =?utf-8?B?Z1N1SlNuY3dNKzcvL0pVR1F4VHNQWGQ1SnVvQ3VxVFpocTZSeXA3ZlEvUWw1?=
 =?utf-8?B?M25vVGtUVDZpdnBLVnFTRE9SblJ0WVJVRkt4RmgrTlFvaTRsbmJMWUs5eWFG?=
 =?utf-8?B?RmFBcWNJMnJid290cEhoTE4wTU9EazZQUnprdUFuSXFWL2ptUm9QQTZkQWRp?=
 =?utf-8?B?OHRDTkU0R3IzRkViQlFPeVdPVGRvS0JiTVVxZG5MTm9FMWwwS054UlowTjRl?=
 =?utf-8?B?TTh4Z0grYlkrOUlFZk5VN0dRd0lQL3R1WEpjTTZzUEZER1JHbmZLendtR2xY?=
 =?utf-8?B?VDQxTm5UVTU4THl3WVlNR1ZvM0dwblljbHl3Z0RuUGJJT0VvVHhmbnp4ZUtW?=
 =?utf-8?B?N2NLejZyOUJJYloraUtvYUlWbGo3WFdrOCtUakJLQndGT1JSd2lucmp0TzVv?=
 =?utf-8?B?RDMxYkc3aFZSR1N0cVZTS3pVU2JhS3ZIVnFYazZMWHJQL2ZuQTgxMC9Yb2pM?=
 =?utf-8?B?bUN5RWNFV0lHVXM2MTRNQXBwU3RhK2JGcjhUdnZsZVc0a2dhdTMyZWlqL3Rk?=
 =?utf-8?B?eDRDaUJnZUtrNmpMSXg5ZE10alRhWEpVNHpKcEt2RUtmaTM2WFVXckVZeFlM?=
 =?utf-8?B?enlJNDdJeTRCK1VPa0JVYmtDN3dXc05XNlpMeHVXdm9VK3JWS2x1ZXBJcWoy?=
 =?utf-8?B?UG5LZGdwcGZHYVFiSlF6WE15VTZNUVI5YVAzKzFHam9KOEljU3ZJU1I4VWUz?=
 =?utf-8?B?N3crck9BUVRmbGhoYWllWkQ4aFdNdWpiN09HTlZCbGVCOVlPTWVwcXdwd0Zk?=
 =?utf-8?B?amMrcWNKWE1EUWZHbTVWdnd0YWpsc0xkS0xkTGl6SXFYRTJRWWhTUDM5dDJ2?=
 =?utf-8?B?YmpIRFRic0JEaEJFSWxrNlNneVhDL3ZJRmdxRXY2MlN5VkJjYTZkN3hkYU1m?=
 =?utf-8?B?RUJiU2o0VlZnT2JhWGJWWk91ZkdFVnVMSEhXTlBORURubklSajgxUUhRMXhS?=
 =?utf-8?B?WFl6bWVNSHRIT0J0MG5GRXpUQy90bnRGZmh5TDFmMEV2cG9sMzZieWpBeTNY?=
 =?utf-8?B?TU5rcCt6L0V6cEpxNWdjQldSMjJmUFRPaG4xdVVNT2YwakhFSHpoSE1ZNGxv?=
 =?utf-8?B?NUp6ekxaTGttZ1Z2Wm0yanVaS0FxbUE0WWFIR3FzQTVyWEtUZG5xV016VzJU?=
 =?utf-8?B?ellzcGYrKytla3lGYmdBTUtrQURmZGQ5NEtkU0wzZGZWS3Jvc1I2bmoxSmwy?=
 =?utf-8?B?L3dsUjVJV0hQTnZmdVhkQ3E5NGpyWUlTenJaM2NwS0duZWhoUUN5SUtCVHIw?=
 =?utf-8?B?NXBLREFSbVBtOWw2UEtBcE16RUkySit1NlN3NytDMDkzYlcySDhHTTQ5eWNm?=
 =?utf-8?B?R1IyU2VaazdnS0dHMHdLSFJFQWthdzlRTEJsSUtEU1I2OFBaSWVHaXRoT0Z0?=
 =?utf-8?B?Vm16SWF1QWhrbE50Q0NoZEQxcHBGVVRvMUhua0U2U0hIN2UrSlRabHNHMlA4?=
 =?utf-8?B?R0xjdXVDUi9WWnhsTkhIU0NuWWo4a0crM0ZLcTU4L2cyVHV6T0ZuQXlBdDgv?=
 =?utf-8?B?Z0xBVVJ4SExHWkpuM0lMTWpyb3FhaFY3SHlYWXV1Y1UxOG4rY0FlU2c0UWc3?=
 =?utf-8?Q?DyhFyQ8vAhqHGX+S84jG/+Zbh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mn3XyCTOPwUWGn/CB1OsZjbf+0syOlVI+Yp5M7GgNYxhsTqY9FmDe1gwe5dW75ew4oVxbkdpCOuzJ9nYfTBi0mKqTN0ePzAey/g8fzKLXxBFmsV2lQxnWAmFS/MAJip3ofvPv8RPb7BUPGOP1UaTghP9LaPNEUVCqbWuRE5WTrrgBfMwtE6kQMEPwbmR4J1K+bKw/Wm70Uu3X+pjq9S2qfsNMze2HHYmAqKDZXEJWvYAMJpPp/m9z3CPBKJURAUiE/oGNV8csIm9bKm6ljtDCdpWh+dW8VQYyzi7WQeKpdOJ573k3o7ZlOejWP0UkBG1pH3uFt67r0FsmzlDh6VsSPEr+hQmWDMLKouMW1Jz8v5+sOFNnrvnaII0csoIumlsvhQdKv+WD6h/LyHlPz1IQpdqm/wGz6095vrZxKrUvrLzXD+q1CJRhtYiHndoyHTQpdGeQWOoKtf4g3Q/vk4WoAIjyi74LMGPU5cm1aTrvhEMSG4lQMPEzbsfwW1ExBF/CcJPZvZKb/qWY9GR4poigejeMXSIqpxBX4CVRcVT56BC9et4tM6eh4P8GKfQrnpCVyjisBvnbaHLJfY7bP3EisqXczRiuTxxHQFBboidR2e+xh/RzZSCpwWWxyio7+K19WZQ664FIYAUT6WF1yLFLZv4czCc249SOwhF1wRYJZqKM1pe078A1TU8bCSTJs9C7SBRcHITopdlqasfRNUyW+5VL/01YK8ioB7pNOO8avR7RQHmhxGjmA1GClWeEksjKdl2Q7Mzw90z56DIjQlYisLLYvY/G/t7vB2KGao7chTCbIIyjgH0me4s9/jxMXw+6i192YL337rYgvtQWmtRgw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8fbc2-1e95-4f7b-1c09-08dbd6a432b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 04:21:31.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRRJD3OnI9OpYNvAs6kGQaqLhJkK89uAFao+Z22agrNvDO8EQNf++70Z+7LDlw8mHm12NhL4OtEMW4lyYZ5p0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_01,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270037
X-Proofpoint-ORIG-GUID: h5wD6YOk3TuhPYMMSRawH2p1Gld7AUco
X-Proofpoint-GUID: h5wD6YOk3TuhPYMMSRawH2p1Gld7AUco
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/26/23 05:15, Roman Mamedov wrote:
> On Wed, 25 Oct 2023 17:08:08 -0400
> Remi Gauvin <remi@georgianit.com> wrote:
> 
>> On 2023-10-25 4:29 p.m., Peter Wedder wrote:
>>> Hello,
>>>
>>> I had a RAID1 array on top of 4x4TB drives. Recently I removed one 4TB drive and added two 16TB drives to it. After running a full, unfiltered balance on the array, I am left in a situation where all the 4TB drives are completely empty, and all the data and metadata is on the 16TB drives. Is this normal? I was expecting to have at least some data on the smaller drives.
>>>
>>
>> Yes, this is normal.  The BTRFS allocates space in drives with the the
>> most available free space.  The idea is to balance the 'unallocated'
>> space on each drive, so they can be filled evenly.  The 4TB drives will
>> be used when the 16TB dives have less than 4TB unallocated.
> 

Correct. That's the only allocation method we have at the moment. Do you
have any feedback on whether there are any other allocation methods that
make sense?

Thanks, Anand

> Interesting question and resolution. I'd be surprised by that as well.
> 
> Now, a great chance to "btrfs dev delete" all three remaining 4TB drives and
> unplug them for the time being, to save on noise, heat and power consumption!

