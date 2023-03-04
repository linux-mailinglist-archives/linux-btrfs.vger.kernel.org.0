Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4556AA7DA
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Mar 2023 04:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjCDDip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 22:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDDin (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 22:38:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A513D5C
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 19:38:42 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32426sul032748;
        Sat, 4 Mar 2023 03:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5huIfSB0d506yPEWZYkWoliuyorK0FQGzP0aEJ8Ykp4=;
 b=GMYAqjRegCKhLQXEWw21rt+yrivPVm8EPkYLtRss6C3Ss7SbTw71hIodR8s2YhMgJj3c
 CPIeAfb9Me7XYLge3FvC4LFzUOG2UoyEhuqZgWPFdCXAEJI+AZ+oLowAkGy60IgDbX8Y
 bwnumcV0GeO7uUSHxYdQWaAm7+o7LUh450g2iInAG0kD23G+jmQ3Bh9AmYNcJxrqf9Cs
 aJukxw8RL7tflNlKkRuKtXurprqFHWyvyzQLwhWQkm9GQOKNYLeb0lEfZ6r2fOkDfPyX
 RCiCUHq0oDedOEon8ybtiN4sdn1K9ByZMTkXb+zOEB2yR6AU6QsqfuO7687qkzNCeTST Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p3vwbr1jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Mar 2023 03:38:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3241X9em009625;
        Sat, 4 Mar 2023 03:38:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p3ve22960-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Mar 2023 03:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Re5bLFLRefWe8XhbkOGHx7I3q6xkmbBlkK+f0vG3byKUYh+grI0KV1eXDXbenQi7dFPk7r8Qq+D41GH7lRAWt5II4oMIzA/wUxvd5JlJY8aCnLtRV/1869Q1CfoD+gaaEM0+W431AOyFpNWek/5wC34iUix25BCj8XwAdbkud0Er0J30WnYPMoQzXvtylL9LDJ6UkCNgGQ6VFz+0y4vzgOj8NQ52zl54o33ZbwYTSzCA2AT8maKLgPAD93RK4RaGTk5zjmahT086T4Q7s2LFZnLllJaAfLRMsBt3BNmBvQr5E0xSDuCzT0LokuoARoEHsYQ1M+hpoDFIQBAsCCB0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5huIfSB0d506yPEWZYkWoliuyorK0FQGzP0aEJ8Ykp4=;
 b=ZVbbG5SQkoXpwIkl/KXVyzYuoqIikO2Ljyg+pFflt54HoEfcQ4j0b+8xDEFgbhnVGJSfZwefcyrz3lzUznC/CsAhytacZYD7z0VEg0XVijnoqo3qAGB3hHxXSFeRfX8qZTFgN3jV0MAUrS+bXjUK3cBBx8sCkLoVM07MLpvZIPWFx46sz1o6kLBe9jxoAI0Rw8e/nz7axIkIT02bwSF66bDeVpmdP7Lyv4YZp+el4GuCf/xHP+Px3gNVW6UXObC2o4Mf1tb/S56gE1Pm8qixgEfuAwUGB9f6iUsRg1HphjwBYC1C9YjYdY9UpOh02QWIsjIc0mvUdkUgclFlcXqwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5huIfSB0d506yPEWZYkWoliuyorK0FQGzP0aEJ8Ykp4=;
 b=yP5QqIGq0C/Zgjj2I8f0NCvhYHAdjxOO1j/U4XTyoVcMUqA4Zuo7M1HKPP0sDWl0Ea0Pknwsoi1/EDpg6aIhccg7gjfcNhWGEd72Im3B90YNoNWUiVtSSB5S8Uf5EDrnNKme+A9sn4f99SV8V1ZZcjFmmV1p9pCHCAoddZclhyg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Sat, 4 Mar
 2023 03:38:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Sat, 4 Mar 2023
 03:38:28 +0000
Message-ID: <63200db8-ae7c-61d6-2e82-bdbdad5d1d65@oracle.com>
Date:   Sat, 4 Mar 2023 11:38:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 09/10] btrfs: return a btrfs_bio from btrfs_bio_alloc
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-10-hch@lst.de>
 <73a37af8-01cf-38fd-988c-b72dc41f2a58@oracle.com>
In-Reply-To: <73a37af8-01cf-38fd-988c-b72dc41f2a58@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 116e9aba-160a-4cc8-d14b-08db1c61eaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxqMkOfjrZjWs2ckAQjNfzM2aMtSVTsKPDrm+5sbwV8qpQZczIY3NM1lRfgxSSz/8+4Qp3NszVr1B9dLQW+DmSMuh311OSr/chpew0FW3MPc5WQXf/BXJ+UgeloCog5AXudSc9noKkeaTG/ckTCsrrla8BP322azdGGZBqLRniHdnEKUGwGLk/2VyLq1AzbtiNLqtIVB5ealLYT1OrwwaEXiRGoJaSqfCJSUTn6xELrs1cVZNeRXrYx05Xg4s62tbUDZcb4OsXGqPyhgYAqECY2TAEjMJ2KXyAAHOI+HZFlqA2ayALj9T/97NS2NiPCjaDAj9ZVb2FjiIKbmyf++3NdC5QH9JACzMprpAl65dA2PY+FD7bGvW3flH6xqy394afXGE/Oc9JdSEPG1miJy1fHZWyTfpgkR5gRqv9pBJ80juKFXU0k9Wddq6Dj1qOHsKhQiNITYorRCHlbZWdT1h2AMcLBxsqkYg1pRDuhDZAvMXpJ7f+uZrhGzVnNQQI892ElGxHkMXzyb1NaD9YYTQFIf3d4kjcMMKefPCy4j7JHVIZWOIntshQyi1VVFP7aNfy7t6OkSoZG2icdJaD5I7eVb7KaVU2El/ZFug4ICLQfIRG1LhxBxob0OQPiAtFrtC5/flNo9Hm/rHnhDpAsqFMk2WSO4xa3s9pGXXi4N4PDXVHis8xOV0rGege0uFmBApsNjm0VVmtV0U1bAjTS4o+56EBvE9VoIfog3SBI16vI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(36756003)(478600001)(6666004)(6486002)(2616005)(53546011)(26005)(186003)(6506007)(6512007)(8936002)(8676002)(66476007)(66556008)(6916009)(66946007)(41300700001)(4326008)(2906002)(5660300002)(86362001)(44832011)(31696002)(4744005)(38100700002)(54906003)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pNOVRuYTBDclNrVkFUbWNLN3Vrd1hRYWMwckJnZ3lYNXJMY2trTmlUQ0RB?=
 =?utf-8?B?MnZCRDRlaEZ1ZWZuWjRnUkJ2cFBDZWZ1ellydVI4NWRBUGFYWVhUdkladlZG?=
 =?utf-8?B?QmVxdnQyWjgyVm53TEdRWW5Mb29ka2JneG5lRjg4ZGpncGhxVlkrQ1J6RytP?=
 =?utf-8?B?SU02bk1qWHppRlJaZHd3aGJMT2FhL01QM3FLSExjc05kOUVjQ3BMd2x3OWJV?=
 =?utf-8?B?TDRRbE42cTlsRG9BaGdmVWFvcHJ6Y2x3a1l0RkxaUEk5YXVmRjVLS0pGUW9L?=
 =?utf-8?B?SWhTMlZ1UG54QVUxdXBXQ0JpQWkxdzIyUjhjeEllUVR2bG03bk15N0V6aGJx?=
 =?utf-8?B?aUJoK0ZTOGRJUmtNNnkzdDEzTVBVSklFL3laWTdmR20yZWtZSmJhOGFDSFNV?=
 =?utf-8?B?U0FLdDlvdHByanNFSUk1ZzNyWDZZMTVWTlBYRUxzeGJkWUlqZHpHY3lIK00w?=
 =?utf-8?B?dVVkcUdyL2c1S09yNzJ5MEZ3a1Z4R2RvYnlIaDc4REVMRmlqSUVXMmhiUkRz?=
 =?utf-8?B?eGhxUU01cG9TZ00ycEJVMjJXVGVVT1M0anptclJhclcvam13TFpiODdPMnU2?=
 =?utf-8?B?VzdDcGw1dEZXY0dTNG54VXQ5bERhNzFYcm44RTZlZ3dtWnRCckFhc09jSzJm?=
 =?utf-8?B?UEFtQlNFNncvL09BUU9EMkZjOEREQWlzMGY3N09KNEwva3lMa3c0dUhlOHNW?=
 =?utf-8?B?Tkh5c0JwMXEwMkQ5RCtqRVllek5ZRFgwRTBPY05KMlowWmZTZjdWYVhzSitx?=
 =?utf-8?B?SUFkR3EwYzJGRVErV0JVd3BDZkV5d0hrWXg0bkVudDZwb0diUUVYUGtmT09V?=
 =?utf-8?B?ODNFblF1RGc0bzFYbEhMWS8weklYajA0OW5ndkpic3ZqV3ZCUHlxVFlZZExF?=
 =?utf-8?B?NFFrSmI2bGw0ZEpLSVV0UVJHenhsaDNZVlNEZkxHaTdjb1FKVW1DOWFaWHVm?=
 =?utf-8?B?Q21UOHNMdit2aDBQNVdITkdUdUpPRmR2NnUrZ3NOb25GZWR0RmpkNEJJZmdQ?=
 =?utf-8?B?OHRRMmU3YWpmTll0ZGE1Ny85TURJMk5LNTh0RDR6ZWZDNFNKaGFyRm9Tc21J?=
 =?utf-8?B?WjZ6MEptOXFScGtud0RpSWFZZE9YenUvKzRJUENHVW9OQWRhZ29XK1JxZ2Zn?=
 =?utf-8?B?QXFzVGhxN0VtazAraTZma2djVTBZQm5haHFBR2ZESnppd1hiS09VaDFia0hp?=
 =?utf-8?B?VDNkaGoxZ0VlNENvdkVpTlFNTWZlcHRkcTRGd0hvdUhMdFNFM1FWNEcvN1BX?=
 =?utf-8?B?TEtqeU9PTysrRGhqeGtkYlNWTGU3SEFiTXNhK2NiSENxbVVOdWNZVVBEanZW?=
 =?utf-8?B?UHdUeS91S3dOMmtjakRuNlk5bVVaeEMzY0dFYUdqNU03OU5ydFJJTnc4L3RE?=
 =?utf-8?B?RGIvUVRkSW5CSUlXZ1JiMUJEbnpvWGhUSVdNOGVEYUhQeWJITjJ1d3ZOWnIv?=
 =?utf-8?B?YkpLNlNTUXJFRUU2ZVlHUzZYOU4ybVZLNWV5QzBRUmViRkdyam5JSkhhWmJL?=
 =?utf-8?B?OTZuQmF4VGkxdzdpNDY2YTBaRUZyNFFENStNVnNaVCtlSituaUNPSkMxV29J?=
 =?utf-8?B?bWtnbUU1aEpvVGxqUnJPem1wMGdoMDMrVytJaWVHUjdZbWFpRVZrR04wV0VS?=
 =?utf-8?B?aCswd2d3L1dNNlB2cDdTVlZYbzYwSVhncmxFRXVIWk9GOUR6VUVqMXdWRllV?=
 =?utf-8?B?S2xsSjBqWXBDTFpsVFR6QmNTZ3oweHUyckxqYUNVbVFvWEsvT0FlMUp0dlNF?=
 =?utf-8?B?UVc3ajh6K0RFckV5KzhGVlEwUlJZUnF3UytZOFhYNHRHaWtISkQ0M0NDNGFm?=
 =?utf-8?B?TURnaGw0OC9ZZ2F2SkpPQW0zVFJyVXljSTNEa2svdFZKZkZqV09FbjRlOUwr?=
 =?utf-8?B?RW0vcDFlYVBxNmVYOWJJNEpyMXhibzM2Y2U2c0g3ZmNqYStMU3hYNXVaS3N1?=
 =?utf-8?B?V2pYSDk1dlpVazgvZ1Y4UUJCTVlERVg5UFFDT3A3QlVYZktMKzdVYWltdXlu?=
 =?utf-8?B?bnhhRVVRaTBWelFOcktHaERPR1dyRGZkd25LVVNEaU53QlkybStkWnhCb0RM?=
 =?utf-8?B?dGpmWWk2ZTE4cmtMQllkNFJPMEZPTHF2MXAvOCtidjVBaDQyT1UvSG55aTNp?=
 =?utf-8?B?bW1iQW5McUdkT3JtTHl5dXRTMHVRMzUyaWtsY21ueUx3YTUxdmRyYWcxL1JY?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BOzJ1iPlUl5LSeGKtVAl+WvKpvE6cp0u0LGjkzVe80EB5SZBXIylAtoqx0DnjeyQw53YBi/j9ge8CLhW8TrPQ5h0jVOqVl6E2HTiCUviGvzSLPxyr0erQdmSdWMhDrtCyjy2bH9VMLrMeoYpIO+yG3XFoWp5lkMpAoz/KFgT+69zo7dFSR6bkL3ySKt3do4jtKehcOIZngMEI0CGAxhTexvVboedBLfmMbK+e032Ds9K1ElyIVx3ugH0fsB/D7KRwPgrKPXqWvje/igbov+pnr6ifyfehiCQtlGjsSd1xjVrYAk5+RP8Oc0jEIrW6+F9s+HN+5Go0l85XvIiE2PNfbtydRXB5Yw4DbO93sE+m2dFxKUM2jV/IkssAGOlLp7r6Hv+s+zA94Z2MW2BdrrBnxqSC3ymg9BStP3JUIsIPSCLsoHLSt0kxyhs8raqNT9vPjuEmVxKgWt9sRRTD41FL/W0UtQ91wzxd/7M6xNHJZPFs1zxOxWLlRdTj50Zeqi1Z5pNs1deIUlzJTKdQbiqOfjTgT1etmwMcToT2Alat9XphK3l7mARDEAgdJkZw0LY9f83pfbCSdH1L1mZ0tBsLio5kc+ANssU8kW2e+K0MR3OTSAdNXclEQJ4czG/n5+PZsuePykau3YEz2nfppclIEnff0ly4rC/k8sqdldhMGqGfnZtOuVJ5ve76GiLSf//38YE+qpVDULFeA9N/komCqoB/lueqrnnvU9etHBeOvGdwSfgdhE7VXai+lB35xp6SBOVBLVxgijdp9rBFqOTr6Wjn7x02P4CYZQwJos63TR5ntRuRWVV4pg3LhTrWn/RUl0ESOa/g175ARn5Cs1NcNOfHEgnq9FJ0W3s9gNmovk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116e9aba-160a-4cc8-d14b-08db1c61eaa2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 03:38:28.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a07nfoWtedV20pG2kLuLtxr7PdJIthtvIiSm0VwkomavGaByT/oz/C5EkMJJPB1G7F1Oz5jw9I12aFV8XDVW/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_07,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303040028
X-Proofpoint-GUID: NNsqsiLKkbfwCnlVVn43g-UFCe26TDIs
X-Proofpoint-ORIG-GUID: NNsqsiLKkbfwCnlVVn43g-UFCe26TDIs
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/03/2023 06:48, Anand Jain wrote:
> On 01/03/2023 21:42, Christoph Hellwig wrote:
>> Return the conaining struct btrfs_bio instead of the less type safe

Nit:
s/conaining/containing

>> struct bio from btrfs_bio_alloc.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
> -    struct bio *bio;
> +    struct btrfs_bio *bbio;
> 
> Here, dereferenced for bio from %bbio appears more than once.
> I am curious why you didn't choose to initialize the bio instead.

