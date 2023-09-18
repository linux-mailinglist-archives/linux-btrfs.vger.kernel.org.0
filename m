Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599927A41C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbjIRHIE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbjIRHHp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 03:07:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1045ED2;
        Mon, 18 Sep 2023 00:07:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38HMNilJ030651;
        Mon, 18 Sep 2023 07:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=h7HZvnNsSNH+lGteXi1rueXi1Pd1ste0io8efxWn3HM=;
 b=WAF/68FclDY/e+xD0R0opFuedBytGH5V5qowGop9jvc8nA12i0dLRGzlc58DEr45dCuN
 ELA33mLVq1Fbb3xpczDXeZ8g/FdnJtO83Tijvmk4mgVfoAVsdd4SFzK3xfzui033RpYc
 knx+EuRLHCCHotEjQrRwovT28nBCb3NgAfqeGaxthSxBp6+y5UkacRXCuV/2n/W+SMYx
 FUP6YE5H1GzMb3myP8OH2dMMR0JkMhK3GIUO/UcoQvgg83+KqS44DCfzUKzdcJmj37Fs
 gl4mQdBlDix5c7S8LfD70ibc9KjrMsvoVeMh2EKfF+Wv6onPV+RTKlXIWORZLg4PH6rx yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu1wwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 07:07:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38I5Vv6i015919;
        Mon, 18 Sep 2023 07:07:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t3ps4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 07:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Xh3NP8UBnmB91YJjGI6CqOTRo9i61dcjBhQ2JGtLTTIS1S44MmHoLfwsiHjux+GoEIAfvf++Jqsgg5df5ov/qMoxf1NmFnk795olep2Gnq4fRh3gXeqSUho1PGoQOrj43p7V7PeeydnjIgj6gWeGOFESYO9yjFrg2/kTH+42To6HwHbLJMThUF1uK9hppgEDcZpa6BdmmPxdqyGSoRRyHWf3itK2QFM7NDjsmDsIJsPXHF4EvIZCZVEBH3w+0ltfjGKtd//nirgm8zd/yDIj5suHy7/fgAuVEfGRvoEtdIH7pmne/3ER/N+LYZgly/XQq7RNjb8KFhSnKPT/mRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7HZvnNsSNH+lGteXi1rueXi1Pd1ste0io8efxWn3HM=;
 b=m9Vadi6UVHiIMJ/3IdtGzCjQJZzvJJ+jfHhIo0kutPVUmo91dOpWXDZVK8lYhih1iBPMrmWRjPC8S9I2KvnGKtU10CbuQ5Ss6HM0HecC5Ys4oYb+RR2uiAuE4gCaTWWiRZaC02VwTHw+9+9aslBxsV5cDJaRsPHUy7Ogg0dHZOiLGc3GbXV9OQLd9uBBtr5odpFwD/43/z2pgwHqpDCmyMzbSLa16RUNDe3ClFPZrrHHo9vM26kaMshqYDEwTyxQ06tae5LyIUCWtocDyfQAztB2GfX7JP0MapTeO5/BEnWrYqxgJDw4wNiaWStJhWar4RTFqKZZdT2a1DXibTFZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7HZvnNsSNH+lGteXi1rueXi1Pd1ste0io8efxWn3HM=;
 b=pZnrK/W5lJPMwcLcp83Amj9yyAIo4quA4+fUGYo/eIdxdrJhY+egRHrHBaZgcj7r46p6LIzyM4sAKmIpGXz9ZNm0/zv6Mmyl5bzUXaeshVjFqV64MR/tE/Etzy9gApLRKJAQvcOjnv4oy1wy6Wsmf4RFuMkOY1S82U1QaGDkNcQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5601.namprd10.prod.outlook.com (2603:10b6:303:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 07:07:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 07:07:30 +0000
Message-ID: <23d3d640-96af-0a57-5b55-a04437cfe2d0@oracle.com>
Date:   Mon, 18 Sep 2023 15:07:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2023.09.03
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     zlang@kernel.org, fstests@vger.kernel.org,
        Linux BTRFS Development <linux-btrfs@vger.kernel.org>
References: <2a2f6e34-980b-2c11-bb07-95e0222f3140@oracle.com>
 <20230918050838.k4uwskcplrxaljc4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230918050838.k4uwskcplrxaljc4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 41763557-7eab-422c-118e-08dbb815ec1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13ShkTsgwsqP5VgItFodzHw13Flma05/Co5znFOe5c/5PPnK+AJHFgRxP9DKFP66IBA9mZb+8K97+2hkbVgwKw5Pul5e/DdtzTf5yEOOzrj3Wcy4wrtS3wuJ6H/0h19B4dTiYnfcOmXTt1nf76oRKdAuq2H59QCz34SDul27g2L8MCC7jCESHAewUiY+u5ZycWCchukJ7XI6BF30FPEbogathUTov7QrGnHZ7KWyix3JRzEtpgJwGuN0yLHzqqfnSWXXn0K3xPWYpJcrkDn306HQbL2i4D25pSoN6kud5UDOn+9izDRN3xiVKi2qkJT0WSWTzV/+bfPCNmJ5uE+Asf+Ekh1x+FxL5XBQQuXiVSK5m+dojdCB24JDUCZuynziNkoJI0We3MF4Scw5Gdnt/oqWTMkVjKzxr5QjTn9QN2oUkhsn4cMTo6kJl0/23+aN3TrNhdqvwhYFPBUF3c9pVA1HddxVdYWf28JI8V0JWNGPM1ECCl8aDu4w5jycfP/n+iUnPOxs7NMgVEz31/cAINXihdiLeN7dVu6tIzKEslhyldt5nDzflJC7cZ4/ZmeXrZxvB2SckFmFrxHhV1QBpV4oRycL2UfjPcpJq3cRRuvdhrlat5h4inIxV02HF3+gVI1qbXi7PbES7LKwobzpuCHxyJ8xpAie2MrrUj145sWXfx61ToEKQcav9tsINv1GhgxIA5ZhF9ybYGIZSgpL2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(1800799009)(451199024)(186009)(86362001)(36756003)(31696002)(31686004)(6486002)(6512007)(6666004)(6506007)(478600001)(5660300002)(316002)(44832011)(8676002)(4326008)(8936002)(6916009)(2616005)(26005)(41300700001)(66946007)(66476007)(66556008)(38100700002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cS9XaEo0SW1EYXE5OXFhK2xXdVZoTmt6eEZPVWhhVU5PeVByZ2FJeVdnN2Z4?=
 =?utf-8?B?Sk9BbHcwdHhocUV1RnVpVXZZZEszNzc3UVE4YnpuUmwyUnJibWhzb1ZiYlAx?=
 =?utf-8?B?alVSWVRVL1JVWGtQaDNFcGIrNHVkdFhFVU9LQjNaUUVucWt5UGFqSElQNmZD?=
 =?utf-8?B?VUlQaVJJSXpLSk9YVTNINTJad1UrTmI4dEEwQ0RHd1B5MFVRTDJiUm1pTmRX?=
 =?utf-8?B?VU43eVF4STkzdFlHejFJcGlsM0tRNG56YmVOS1o5SjVtYmFON0gzU0JPK2FB?=
 =?utf-8?B?d213K0Q1ZWlKbU11UW1hNU1yS1hjVXJ4aUJRbUkvb2xxSStrc1UzcVlma1RP?=
 =?utf-8?B?VWc2QTJ6eHZYaTc2N2FxZzl2NGZTRDZGQklqZ0JEbC8yaldxSGtiVWVHdCtm?=
 =?utf-8?B?TXBYanIxVWpmdU9uREg0VGdDL3J4MUdpZmtZQmpBd3h5VmRCeEN3YklBRnVN?=
 =?utf-8?B?MWw0QjhJdFg1cy8zVlJJMkZ6WTIyUjBCdjlzMGVmbFZxd281a3J3eXRvN2pC?=
 =?utf-8?B?eFJlaURyWms5SVphTHp5c1hTK0h1YVd3Z3ZaQXlqTzlVeGdCVlVWaUVqbVBW?=
 =?utf-8?B?N3FqNzJpR240U25KLzNsclZVWnZpanZFTlJ4aVQxT1I0QmhUdWpScXFaM3JW?=
 =?utf-8?B?N1EwdlZUemhoTlE4cW1ZcmRvaHVqOUZSNlJtdHhibFAvR3htQmx1UGJmN3V3?=
 =?utf-8?B?Z0FUZ1l6eCsybmZLbitVanJxK1l3aUZzeWlCcDhRSTlnYUpYMWpsckI2MjNQ?=
 =?utf-8?B?cFVyOFZ2R2JyU1F5Zm42WkV3ekMvTnl2TnlXMkVHVEZ2aEMwNVBIaGpIZzFt?=
 =?utf-8?B?dlBEd0dpd0pPRU1FUlovRUFmOVFESW9nU055U2JtNU50N2ZoeVJtVGR5ejJY?=
 =?utf-8?B?Mjl6Z1lEUmFkcnVmcHUwTUFmNDJUdkhOY3FWVm5xL2J4b1NSU1NVOW9VSUk0?=
 =?utf-8?B?RjFMTzNCV280S20wa2c1QjV4cjg2WkxDcWtCdUc5MTMwL1F0bStjdlFreTNQ?=
 =?utf-8?B?cUpnblc2WFB1WGFNMUkrZFRTcng3QmdpN2ZvZUg3N1BoSHViY1dFZWFhRGZV?=
 =?utf-8?B?TXRsTmd6WHVIVG5aYStpZjhoM1lUcndwUjBSaFNmVTlVbmFZNm84d3JFVDJE?=
 =?utf-8?B?V0IvM0RMdU1jVzhxTEFJY2FjR0txK0ZabnJ5UXl2bTVqQmI5d3R1MDZCbEJD?=
 =?utf-8?B?NVBIZVVnYnROVDhMWElrNzBHaUhNbmRmUktOY0c2SWlqUWZreHJOekFGWDZH?=
 =?utf-8?B?NVczUVo0dC9KeGJHbFBHYll0aWtZdFJHcXBkVVFFdEh0UDVYS2dkOW54cmtN?=
 =?utf-8?B?QjZCSTh5TElSREVEZlBwb2dUZ3FNTVdpdmh0WmRvRERCUjJQWnhGdXZYQVpT?=
 =?utf-8?B?Ym0xNk1iYW9UR3pPZ2dWUDd1ZUxTSW1PYmtzN3BMNHhtQkM2Tk8weG1UbEph?=
 =?utf-8?B?QkFxVDFoMk1PenB3eEUrVmFDNWJ0Ykc0TjZoeWpJSjZkRDZqa3lQT3FYUW56?=
 =?utf-8?B?YkxiMVg4Z0tNdy9SWjY4YzlGRUFYQW9qTm92eG1WM1IvN2p5bmdhY1BCVG1l?=
 =?utf-8?B?SUJWK21aWGJIQlZ2TUJpMXZ4S2VRbSs1VmZXZnhqT29OUTFaOFZYdGJkNkRP?=
 =?utf-8?B?TllqNUxkR1BWdWNBdUwvakU0WERmOFo3Z3lmc3BHZFB2RzNxd1lZSVdwQnJH?=
 =?utf-8?B?Y2NJdHZqSDZKU3VIajl0QkZXbFN3T1ByQmM2M0FESVhEMTR2SEl4ZW10UHhw?=
 =?utf-8?B?dWE3WHVPNjFZNTg0TTgzams1M2tQZEQ4RHVQWldIUWg3clpIRU1BdnAzK0sw?=
 =?utf-8?B?SXk5Z2NORGJ1V1o3d3prTFlVV3QyTWgvemtyVEF1RUF5eDhNYW1OazIvcTlq?=
 =?utf-8?B?bktWcDM4eERMMnNnTmVycTRYeksxb1pKS0I2MlVlbTB0RHNtR0plRnBURk1r?=
 =?utf-8?B?cHp1ZDhPSVVpeWpCMVhWUFdIYzVEMG5wUHJZcXFpdEVJazhjaWpEVzVlSzBz?=
 =?utf-8?B?dW1BNi8zckw4aWVvZ2FiV1ZmeXgvbmFqc1VTQ013emZXb2JKOE1PeDdUL1lS?=
 =?utf-8?B?cmV6UFJYUE5WYU5NaHlkQkYzWXppcnRNNG02bm16elkrdlliQVRXMWp1REFm?=
 =?utf-8?Q?31pN+K1YURZwrhO5awd7N2Otk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YJtmD3f4A0xD89gfbTBdmoN9YUMqhpZIBgp25Clok1Op0whk02DRUfgMp+H6ekc6VLFH3AYjPIeq7lX6bhCaAUPI/UHuNY2fqGwkVbCS7GEcZVE08DiA/wzKn/VtzsTQVEzX5v5ptXlG1cu26PYNbIlGqnKfkhMt4cDByBUlcPTfLZ8Zjga92QM+hUkryJS5Rbfwx9uh6sc2hhGpPczkCWgIZwDhpt1LrMRTjn2PiJfwcLA4PUCKYt8AZbKIV9qV4dhuGLrgKxvAKAhauMcZlAoYvqKRjn+nNIaZKPHV65T0UMTKsxfE02VVwX635NbGgkuLghX8SoEeHPg0Fr4gIHZO6HNKPP1PALZ0L34T8/4+dz+XrQglSv+NraHYiyOi8nZ69cAbn6qkDkHtvOo1mn4qtOr8readPYKhqcZSsp1pxjgN2adImf6+iv9mnnkXAVkHnvoZlod1UKLNZStjMIvmsG/g1VlKZVrB96W3Zf8dT5r30CFFnn1LkVZ/eO8pjdMbmBicVy59CzxLtKTd78mLJCzEneW0fecMCryJpS3FsaCGXc5oVMvH2DQA87/qiQk6fCPDmBhZ2WDTpkgcKPtYlA8w57pU5WtN7lumj50Sbct8CtoVVrgXrcQsl7jOh/FVWq1hbZVm8obPqw9SJ4RKaGal4Et4kjzOFKL5C+rxEacHs56D/E1HZwZqGlQAvGSx0bdhgn/6jmSmSOwGZ9fEd2agGBFRNMBq1g0JJHis7rZLu4APfLkVnLt8asMzUsbVFLMG/6fm2rYhT8diY9GjNC9dZp5euoW99Sb7FgctXAebURds9bxPly93KD7L
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41763557-7eab-422c-118e-08dbb815ec1a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 07:07:30.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSYsBnOP9WDIxP3xzhnRHgdi0myIiJkjqgSuRQ7D4PO75Pzkwm73eUcLcntFwBq0CL+wjKNOIxl5BDBpFDP6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180063
X-Proofpoint-GUID: pGzfhowQbqYnFGaTOvkO-fQlftdg5rW9
X-Proofpoint-ORIG-GUID: pGzfhowQbqYnFGaTOvkO-fQlftdg5rW9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> [1]
> 5bc43d67 (HEAD -> rh-for-next, redhat/rh-for-next) btrfs: add missing commit ids for a few tests using _fixed_by_kernel_commit
> 38b7cb72 btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel commit
> 6540ed24 btrfs/076: support smaller extent size limit
> 49abf950 fstests: btrfs add more tests into the scrub group
> 7ae7bcb1 common/rc: make _get_max_file_size find file size on mount point
> 0e2055b4 tools/mvtest: ensure testcase is executable (755)
> 39551b4d fstests: btrfs/185 update for single device pseudo device-scan
> 253f54c0 overlay: add test for persistent unique fsid
> 04bbac00 xfs/270: actually test log recovery with unknown rocompat features
> 75adb8f7 xfs/270: actually test file readability
> 8abf8a20 fstests: btrfs/261 fix failure if /var/lib/btrfs isn't writable
> 2da0d269 fstests: use btrfs check repair for repairing btrfs filesystems
> 

The btrfs patches in the list looks complete to me for now. Thanks.

> [2]
> [PATCH] generic: test new directory entries are returned after rewinding directory
> [PATCH 0/5] btrfs: simple quotas fstests
> [RFC PATCH v3 0/9] fstests: add btrfs encryption testing


  Yeah, I'm planning to have them for the local tests. So I'll take care 
of them.

  Also, I've included "[PATCH v3] btrfs: Add a test for the temp-fsid 
feature."

Thanks. Anand

