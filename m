Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2226109BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 07:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ1Fas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 01:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ1Faq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 01:30:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E287080
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 22:30:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S4rrhf012630;
        Fri, 28 Oct 2022 05:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Q/nogfRVa9TZNhdx6M2wiQyfsxruFM0x1sYp8Czi1BY=;
 b=RPWul/qzBmJQB2ZIvKX9kCJDu2Az3OZjKRUYrd08Eqzb6FhfcOS1wgndzyTYoESsuwO7
 /eaGetBKF9mw1SyntVlQKqWtF2colZsBV1Hf90bi0B1gUwqnF6jHPzM8mTQfm4teqInH
 FF7sokvJtaY+mOZSa396+wk2R9U4oD8wzjGF6/LTdSfHLD+n5mvd4Uvz1pJx4oL1lAkg
 7nFhXr3x4tlFdaOgZICZvES/V6IqXDg8mj5sRNliOOqmUj/2KX+n+TSms/tF/2mwjzPl
 9cucMSPrKNxU5lWLFHtE3T65gzrybQqnXPy/L/WepeOfys9MFZiCNQIWwkEC9+9TV4ia Tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrv2hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:30:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S2AJEJ012280;
        Fri, 28 Oct 2022 05:30:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagrqu1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRNMBdCCpwD/PVGEGFu7ocQcslC7Uk0F/m8vqfAXBjyAO59ma2Hx665wmpsgSvLBaF+3kZi5rsTfPwB7rM9WF0oyX7zPDZw7yUUQR1/MqcFWjKtET07bVfrFActPXQ/BdZaW1sStf3m08tWKz0Vw4TmHnZ66+jlrg0BiCqFe8PCrIHMiHeww4RNors+K4Vuy3yJ9KXLFI25Y+natWe8zXIofMY7zlV/IQ1g3kjC0VBruN2GOGzHcO+D0IlklCBahJroprlKqe9HhUik2jOV39hWxOBGRsidauVvSu+YvSlj+lblAEae56ocvDDy/pj66PI6BwYCNpRegtsZbqykfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/nogfRVa9TZNhdx6M2wiQyfsxruFM0x1sYp8Czi1BY=;
 b=lZgANv26cjqkVpK9NOh8OVozWUM4H/9GIIGhw6hB3Hlix+4HGThMHWH8ny7gHW4SfRtAiANLzgZTetjaiLfzReaOGNvG6cjq06gseM/1ypQQLTyEN8Qc1ojYJmw0sa+RJPo9lcjfvnVvFYWMGrHPYMBSIZEtUCkleQSgs3LG+AGZjvvQuCRbp6gzgoO120XMLUbBXB+4uGsc0R3f61GVZoIMBwt/wIx98dBnQm/7Khcfas03pqxOBmMt9lTd2vUCsoM+rUO+SZsYlNQx+F48bXwLwKaHHyJOwEZScCjt6phk66sIArsJ3FYOPRhYIHZE17ffBEP2d78Qos7WBQFuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/nogfRVa9TZNhdx6M2wiQyfsxruFM0x1sYp8Czi1BY=;
 b=vh2b+XuRVkiL2wS4Il89U1Rtl6SevmM/p1anyrIECu4ChLlp1XEwWAyc/UUbBmqgXOgJYSrunWw6QRMKog7DaMaLNfZizkSDBEiIFVj0etmp76on6F2YK8ZitCuAguqC7PQgzbGe/NDIElWlsRVcKo7BXD7gS5GJL0V9EFCDVp0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5253.namprd10.prod.outlook.com (2603:10b6:408:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 05:30:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 05:30:39 +0000
Message-ID: <c72991d5-7252-de3d-b684-c54531a9f101@oracle.com>
Date:   Fri, 28 Oct 2022 13:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 08/26] btrfs: move the auto defrag code to defrag.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1666811038.git.josef@toxicpanda.com>
 <dfbb9bb69b5c921607763fa7cd714bb68f52d886.1666811038.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dfbb9bb69b5c921607763fa7cd714bb68f52d886.1666811038.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: b67f9a47-aa64-4d1f-5d21-08dab8a58ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kOCkYLWbSmQsqZYrq96YRYlQyT3ZnAlZxNvakHFyTLSY6qb+8xlieWf71BgYq8JHLi4dc/LjyhJI4mm7rt1pEuE8qZH1Tl3X6wu5Yog2ED16Ksu0n/Dg6uEMvip9GyvXPuSnN5gQJJl455Oy60UMXpVKJV8vabUnyHlIS8eOjKyb8luXkB42lzcvkSj0Y0iWYU7wLqTOT/EXny5qcJGkwQQgNENUY+RNhNl0vsUk2FeAPKphS9pE4/1IECLGaTJtVqSVeq8c3/M4GMgF2xNE5HbeZ4EtvZlvyB1VQKT3ocLRMc9BleW1djvM/G05JmqEmtNcf26W1HLlCj4cyzEVZpS4NqFBLNi0DMvpGKTZDuEZhWyspaVVd+CQ10FQ1cFZ0zqwc5v3v+IDR4EJtlc1zZDOKQiYaFgs8VzEc/KK1wjTcIPBgyYKRSsPj0RxbIyUDPk/H5qxXmCD0onCkLCzqSaLe34+SxwiY21nApuMY9hWq30kiXUshm1Ef6pImeO1NNzPsPCuTzIYRqqgSLJPScb7Z5ZydVtVUVBB9aYcyK8KTVXqf0FDjWAGjqJ0cfPbMpLz6fnwy9WwY3Q8ROuBon4QQYzfU9+H7uiuaSnfcsNsou+rWDpOtZrxbo94hlJhsSIMWj1sXs9zyvM9Sz7tZV253gTTqQlmCu6/M42QSVWwLKP2uWunXfY9cIk8u3MY38x2IDjUNr2oCTznpQramjy7/Ze8DP2adcQ9ikUUjUZvSWRqBFRj5dI858hPOqcYJFOFCAoQaKLV7/bq00FlbzxLHZdfpu4RmnupHnpoV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(478600001)(31686004)(2906002)(44832011)(5660300002)(8936002)(36756003)(558084003)(41300700001)(316002)(66476007)(66946007)(66556008)(8676002)(6486002)(6666004)(86362001)(6506007)(2616005)(186003)(31696002)(26005)(6512007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDYxSXJzRy9PUEdEVEdxZDlMNlpHOUVPbmVRemd3NkJNK2ZKb3U4aHdkNHZ2?=
 =?utf-8?B?dzdZMG1mdHRMT0RPTTNxTjJaODNnY1lneHJuS0d4bGwzNXJZQ0E4azZlSk5K?=
 =?utf-8?B?a2VHckZxQTBuSFZUVVY5MXB5YWhIV3MzbVhVQyt2S24zNkErbk9DZnEwanI0?=
 =?utf-8?B?VHlmZkY5UUhLWUpQVnNKT3lQeXdEK080OGZCYmVJNm5oSS9yZ2QrVlpyUkI2?=
 =?utf-8?B?eTJYbFhBTTdHbWdRY3N1SHNxQll5NzA4NEJuMmtxYm9XQjc3cGRnV2JIVVVm?=
 =?utf-8?B?UE5ZTmtmb0kzT29IQWZIOGlIMitib3J3OHZkendTcy90NE5YV1huLzQxUk1L?=
 =?utf-8?B?VEVyUDdHcElBaUwwRitDekhoOHV4czZNRDl2OC9kNTJLUFVnSnZrSUQvdklP?=
 =?utf-8?B?Y2pQU2NRU0JNRHRCVjFJMzVQZnlHN2k3OUx2aXg0Y2RFVHlnK2FLVktXZmQ3?=
 =?utf-8?B?bGYzRWpBV21BR3cvUjZlay8xWmxVRXdRdHVTeDNVb1QrdEs5TWJqUmFNejZZ?=
 =?utf-8?B?RUlvM3cvU3hsNU1PRmJhQmRmeGdJQXE3bUhQVHhBWW82WTRXZi9jUkt4dFZN?=
 =?utf-8?B?NHF6MmM5NU9LNXl5b3hFT29FaEJpSW5BZi93bHk2bW9naGlwWUE0aFd3dFcz?=
 =?utf-8?B?UjB5bW14RW56clFFRmYrc3lhM1B2NjhEZVdEYklHV3dJQkh2Mnoyc0NUT011?=
 =?utf-8?B?Q2tYQjdBbnNnYnYxRDlTbmlFdjhyYmhFZUpFZUJGdVVwR1ZYNGNuWG5ycXU2?=
 =?utf-8?B?U0RZVXdCZm5zNFJRbExtRzRPQUZqK3ZPdllvQkRXeU1iUWxndlY3MXg2eXRP?=
 =?utf-8?B?S3hPN2RzT0NTK1FVU1JVRUdzRGVTNGpWUWd1TlZtQWxCTVNjNTFjM2R5bUpp?=
 =?utf-8?B?VkkveXZuSXQ3ZVpJNUlGTWdBa0lEdGxhR01SUmxVc1VMNGlXNFIyWnNxakhF?=
 =?utf-8?B?N0Q3OHRKNDFDUzlLSW5kMDgybXRLNEU5QW1VTnFqaVJuNnZqSzFFdUhBZVhR?=
 =?utf-8?B?VmFVV01GWm1tL2taNkFwMGZhVXdhdE9obUtVbXpvRHBpVzArdzRzQktaQkJx?=
 =?utf-8?B?Tm1Ub3cwZ1FPa2VhdENTa2crWEdieDFPNDNQM0NickJjNXZSOEg5MTZzSEZW?=
 =?utf-8?B?VFVRWEU4Nm5lTmtmSkZBNDNRS1VzV2dLU2lzVWduM2lWcHEvd0xoWFU4VnRx?=
 =?utf-8?B?VmtCZmtUNUV3SGNnZi9WQnBKSVhVUjROT1pZQ3RUd1VlcGVocm83V0NUZy9Z?=
 =?utf-8?B?eWZzVkVmSWdzQWhYMmpueVl6YjE5Uno1dEZFNmpzQmlxTzdVckJIdE9SQkpy?=
 =?utf-8?B?ZkhFVXJycWlBUjJJUHg4Um1idVVkTm95NFdRMjhHazB5YjBMNFlweGhxbzht?=
 =?utf-8?B?SC9HSWU0R3pIWmlSQW9mSWJGMDFnKzNRdnRMb0ZZbUM3aVZIM0xLTGx0My9U?=
 =?utf-8?B?MkI5d3h5UGUwdTFnWW8vVHErcDAzNTlvQlZKZ2l5YlMvT3JWWHJYNlFLRk8y?=
 =?utf-8?B?cGI2TW8vc1J4azB3NDJhellwTXUwbTE4eFRoK2VXYkc0TzI1ejU0K09aeldl?=
 =?utf-8?B?NVFnaWtJQmgzNTRPKzhwSkdraVRpU2NVenNtME85aE9WT2hKUXpzVURoWWN0?=
 =?utf-8?B?YkRtRkVzSEtuNmxES050dVhURG1JZnlkVnNsd1FYMTNUZ3l5QW9GbU9WcTVm?=
 =?utf-8?B?cXVEL2U1WHN3S2ZpaGVGS3d3ZVZhZnc2TkFhSEdKZnAxZ2FIWVR5SGR3MFlx?=
 =?utf-8?B?OGF4cW9BQjZXbHVscFBXQTF6cFN0OXdEcUVVODJaTUQ5VmFvV3RQbVJkUW1h?=
 =?utf-8?B?RkR1ZjFGT1hBN1htZU9SOHNydUVQSFFMeDdNVVNKZ05IZzVmSlBHSEU0TTdm?=
 =?utf-8?B?WTFPNWs1MEpza2JxSVl2QSt5SkJaZyt2NFJwUWZZeGE4V0x1V2E3dk9JSkhY?=
 =?utf-8?B?bU1XRFNCRWN0ODZhUjRoVDBoOWE3S2tZK0ZheStzMjVRMDlLTmNOaDVyZ2ZU?=
 =?utf-8?B?SHN1aXZ2NVVWay9Gd0loUExvVld4QXcrSWZkbkpnTGY4aVdjTU8xM1M4NGlY?=
 =?utf-8?B?eWkyUXAxVk5Va3d0bjJ0K04xUlNBVUU4WndSVkNnMHVVQldCdDNLamlUYU1R?=
 =?utf-8?Q?L6Wd9Uw32Y1tV9Jwjo+MVv9pF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67f9a47-aa64-4d1f-5d21-08dab8a58ca2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:30:39.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3icplqdfQKEFtZFdQs8v065mE+tQsW4IoX6SWxn4+x/Tg8hVN/0wvpImhMyEk4/HNOUamlxJwSu9I4PH2qrGsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280034
X-Proofpoint-ORIG-GUID: U9lrvR7ZtW_UPZP2PjWT0825bDKAB36I
X-Proofpoint-GUID: U9lrvR7ZtW_UPZP2PjWT0825bDKAB36I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2022 03:08, Josef Bacik wrote:
> This currently exists in file.c, move it to the more natural location in
> defrag.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>

