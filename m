Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E070DB92
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 13:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjEWLhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbjEWLhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 07:37:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD90126
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 04:37:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6E7Bt024581;
        Tue, 23 May 2023 11:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=46EjvzV28fJ5nzvsoaWWeNCG91OglmsBGw/73LDJOAc=;
 b=lMNlULZj9XPm3WA4cAYFzyVIG9Xr4Rf9dBY3TfEB5RwSeVG1jaCu+eBQ0iAZD6DKgbyD
 MKFBouyINhMYAVBzPAeoPkThnXj4wtArug/r8RsdNfXK4BkzEKDwx6BYyScWaRK2JGFN
 Ag36RxiP4c1kGGqO/EAPiXhnSbq9KEKSAdL++pdlMeG3PUHyGnKJ5w2hJ+w/Ac0RnIGE
 J7XHHfEiHsJaOkk9z7z54QSO8pi8EgoKVDRDa3kaIeFkzB7g9g7YlQlxBwJbdO/3x30+
 CKtlKA996/ViLASGhWrpJtuX3eflSMzFTmcfnJh9q00vqpzQdIwiXpTrRRCR6W7z5Yvd xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp7yvv9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 11:37:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NBBB2h013286;
        Tue, 23 May 2023 11:37:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7epyhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 11:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUFNNuF71Sa5CAjE5YAMLW5Z2PzJDNwXfdXGJCgSlygUXj+vGSKP1GWWTurrV0OirlALBUqetFyoirv97hYRSmxNDhBabFcLzzDddDgmirOmakNb+WPHJM41+8gf4g9xFD0m7eTbQeQ8sd9hdlB8qiifvS7zFN82GMNRpENxjYobVBrxQ5kMFJ/C1mD/k/ngw30Jt5YTWB7ny6DOSKGCTB1hEUKYbxUeK2fkFBZAHdbF8m+cqaoA2QszXGFjaxAYVCdMCqM1AwXULdexLWgrFy7Xg6Lk6GMIF7o+E6M7iYry6aw34lNBysbKgDMi5muoAGPBy7LWwP2knX13xUhmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46EjvzV28fJ5nzvsoaWWeNCG91OglmsBGw/73LDJOAc=;
 b=NNgn+9zQqRb5zJSbqmX+tnVDedYH39uylEgkK4mSNxEisrqo5hMGqu9r63AB1TJV8PoWt8NK/Qbaoh/P+Ne8YfapgnwtIM1Lb3G8IPT6GjU751nl0Og5GOXSwWEdd9ast73QNwcH7Yii1ulEn0Z61iPEqlHNwDgUQpPdcNwNW8IFaDeoj/MKWn4uFhPrZeFLF6c6fsEQ3bhAYIcqqovY0cCFethuinqiNP9YC+ZWuQMp1YghDhhbOZxf9bBl/os9rXw1k9nftxXP2zLhSIAJQ+0nzUpMW1G6Jw3z3AwtUnJaxRvtGGGB8+scWpzM415XAMixwM6u2XMfW2Cp5dK3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46EjvzV28fJ5nzvsoaWWeNCG91OglmsBGw/73LDJOAc=;
 b=Tq/lYFTp0k8+9G3v0zly+YQ3C8GphNQPv7DtlgZ8cxS1W34bwUup5tkj+5U/hndc53W03cUa+mD1HUThxIcgOCnLB0+38sWgzGIzUuh4TR44JRRTEAO5w1LmmUKsCVTDyDNyY8hBuFz19xKhgfS+hhltL+Vtvw9jpe2s8HorO1c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4265.namprd10.prod.outlook.com (2603:10b6:5:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 11:37:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 11:37:31 +0000
Message-ID: <4031cd58-dd4c-a0cb-79d4-38c7f03ceaf3@oracle.com>
Date:   Tue, 23 May 2023 19:37:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] btrfs: fix the btrfs_get_global_root return value
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20230523084020.336697-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523084020.336697-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bb1ec5-3939-40fc-642e-08db5b821871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExPyU66m0ZSxWuXM2PDkKvJb7kPzxGRgq5mPLehlrwwIdMrfHT33kzizQzLdy5Iu/NVStACFk9ri1ZKjU9mpTXP9peRjBoUgxNYH/IgBem16VEPiTsMb6CM1SBbtG55TCFY475RH3f6kZ9NzyrIvZmDrYFSCH2yfP+Y3W+bNA6lc03L6l08+t+6CdlcPmy73llYJdWkwVIWrzyN6v6vg0erjpgJ6yE6X8C/BLRyKEqGgYKR5liJ//wrAxp5WXTkfLauEYNDdLjXn0cx8bON8q0n8t4Y6U/VEATTogscjf4bvenH0rT/km2OsDHd61UawWgRqFIF8ILq3kfhN8fK1+HHqqRbwM244tk8tve+GoRXxgjS0gZxy5VePkzQ18XZM/TPJzArx/Kui0v7pgiGRVJGnyev0xWh7zj7fYIwuSSV4dyod8HYYVthEgp0qrKygm64WVi3AiqimaFniwzr2jRXgrHMxiAMp80rtp68eOul9i2LB3fy+d76eCPEclsXh57DPOB2xyn4Dl5M8e+u7dCC4YyOOhXZnEYjTry71UEbLp81V2e8xDIoDtyUQ9/QFUdM/VmueTmwFIK+jPw6oR4HdGbgZTeYeNoXzFde9qUhcCAQzvNRH2/uIl3MiuFf2Iv/bMucM6asTVMF4CpsVrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(44832011)(186003)(83380400001)(6506007)(6512007)(53546011)(31696002)(86362001)(2616005)(26005)(38100700002)(41300700001)(6486002)(66556008)(66946007)(66476007)(6666004)(316002)(4326008)(36756003)(478600001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em0rbmh0YzVoenZuWlV3QitSSDhKWXUzbGJJWmhrQnduUFU0bUwvYUpjVVVl?=
 =?utf-8?B?dzNhSTdiSVVDY0hDOEFtYXdvNWNjMzlxWWcyMVVKRFRUTllyQzk2UXUzTXhs?=
 =?utf-8?B?YjUyK2xBckJHajNnRlFTSU0rMEVOTDVNbUVqUGQ2SnBBd3BoTnNoV2l0bzQy?=
 =?utf-8?B?eGpQaXhGS3JqOWtlVHVMMGQ5RWlnR0R1bE9VRDY2MXVXNVhDSHBKZ3EvZVZ3?=
 =?utf-8?B?SnZZY2JtVkNXNHhJR1ZzU3VYZGZFcktuUWlpaUZXS1U3d3l4cTMyS0tUWk14?=
 =?utf-8?B?Y2R1Qm10VENhUWVtL0doUm4wSjE1Y2ZkTVh1eFZ6NkE5VjNyNjJJLzJEbVZP?=
 =?utf-8?B?U3NhbFVjRFk2NlkwaXRvRExqK0F5aE0vcWRqa1hNVklRMFBIbU9EZ3gwWU5w?=
 =?utf-8?B?TEdzZG03SkEvWFQyWlB1eCsvZUp4eUZjYklLOW5ZL1hhWjhTZmZzc0J5Sm5z?=
 =?utf-8?B?Nm5rTVNua0FMSWlML3dZbVk1a2UyZkVhMmNKWUpYb2ZQOXNtd3gxeDJyTlp6?=
 =?utf-8?B?WGUvMkdISVJNWEE3bnJoZjhYcXhBQ2NHaDNzVWxKWFZzKzFmclhIcThWWi9O?=
 =?utf-8?B?Qmx5Y2JELzdxR2ZMZ2hYTTd0L2FRMEc4UFRDSFFEYmZ4OFBlS2JQc2NUWm1K?=
 =?utf-8?B?YjEyWlAyUURzZU11SldIeVRLbFA3NUNhQ1VTNjBuY2hPcXYzdXlZYnRGYVNm?=
 =?utf-8?B?T2srcTFZV2xsaXlVWmR6eStCNTNnNm4rOWxoeXdvQnBWeVVMLzBBeFBiV2kw?=
 =?utf-8?B?dytITFRyaUMyMFNRUFRxWUdxWHFhMmtraFFLSlVZUk1HVURvcnpsTTgrSmpt?=
 =?utf-8?B?QmZoNmp2UEFwU3hoVk9CV2JwcUZnNUxZTFhkcHBlVlhqNmNueFNMRUNFUXRt?=
 =?utf-8?B?b2FuMmpKVjNZMkh3TDhBc2RvMmo2cnhkWGZTWDBxU2xxYXd4WjVlMlhMeHNL?=
 =?utf-8?B?b0lHVWhBcVowbnhIWGhmMm9BMUJsQlNPKzArTmpZT3EyclpnSW1kTXYvVFNB?=
 =?utf-8?B?ZDZVOUQ4cVA2L3FPenU2cXcwSDFaaUluMHBpUjVWZmhzOFQ1c09NVUxqUEVw?=
 =?utf-8?B?VmFoWGx5ZVpNNEcrOTYxR2t2RzlmMlhzV0VFMkJ2MkVTZTl3VUY1aWVrREw3?=
 =?utf-8?B?MEV0OGRBN1BCemgwcXdSMVdQR0haYUV1N2Fpb3FWS2puei83bHUvWHJyK2FE?=
 =?utf-8?B?Zkd6RjkzK1BwdlI4c0tsM0FBUXdEQnFkSVpPcjVMRU9xQ0E2VVBxbHJobVJF?=
 =?utf-8?B?VlcrOXRtMGVCSFpXUTBtUGJsdGVtYmgrLy91MVNHR0dsRlBZR21QM0VIbE9P?=
 =?utf-8?B?azh1SlhHK1BvZ2gzYlRJVkhBRFZob3dDYUhJZlc4U0JzSzhUQk9NL0hZdmR0?=
 =?utf-8?B?SHpHT2FQeHlWK2hrOE1TdVZHVzJvZXJvZWt3alNvQmdEeWxUMHYxdGdUMkdU?=
 =?utf-8?B?SVhEVnY4Q3FqS0kwVkY2VGNuY1pxY29OV2lISTVQYWt3QVNyL0tOZnlVbG9C?=
 =?utf-8?B?TVB6dDcyd3Q2VUMwYmwwbzJDTFoxMmRURGc5UDZSdVpRNCs1R1NhVVpMc3pD?=
 =?utf-8?B?RkNHQUZya1AzY1Nvd3NlT3BGRUZydngrSlpTL3JpSlp1eElpS2s1ck4wQXor?=
 =?utf-8?B?RGRONEhIRDF5dlRqWHVrUmdzN21odVlkT2tqWGFjaXdqRzIrWTZaQmdtd3lI?=
 =?utf-8?B?RGpPdVIzZldJeElySjcyajYyN3Z5YWNoTGx0R2pXT0Q1bmY3MnFDM3ZBWUFk?=
 =?utf-8?B?ejZQSm1pMldPSURqMnBsRjZSZmJHN1RjU21BbjZ1MEhNZXZDUG1GQ2dTY0d6?=
 =?utf-8?B?OUM1aXUyZ1AwekNkQnhma1dWUjUwYlZwUUUyMVE5L0J2d25hTnJXcWdSQ1Yw?=
 =?utf-8?B?dmpvL0FJMytTeUJoeXRQY1BLbHJ4NkhQT0JhaGFDYTRlMllqWkV1RWdWTjNV?=
 =?utf-8?B?Y3RqejV6RjBYOG0rSHJtRDcwVE0zMDBqSnIrWC9zTDRnVGFmazFCWHNGNDUv?=
 =?utf-8?B?Tkh6S0FBTWIvc0ZPMDV6WUE1L3VHVXJEWDFnSFlBTmRwbGU3czI3VFdsVkNN?=
 =?utf-8?B?M3pFc0trZmtjS1RVdm1LelB0aDRTY2Y4cDBtVUV1WFBLRVlCejBtQTMyQ21B?=
 =?utf-8?B?QlJtcVU4QnpSVlFjN24yQXNNQW40TFBjZS8vS0ZhR0RkUmZlV2NjdHFJRjJn?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d/XllEHkirXaiuwRSY7geUGblHCJtI1TAeR5bmZVYcvSdrM0l0PZZy0jNkhNSBXTsFr5YDpOEHFaxR38XRji5iPrhlQPh57wInxh/3Vwe9O58ttJylQj8ut1muzfXjS8Y7JkAOmHaKcu2Pl/tGBYyMPxmdn+Zjj4tMViw00fosekVy5s1iJxqjDfkF4K9JygDWcpc95bYT88RX6y5Z2KkUdPI96YSgL8KPHzNVcY0r8KGA+NyRPKzfsDaL3mmyebYbZcTZrxlLHxCMsFsGyapjqcVkxHH8+9O8hUMQc8l2Q+GLMH2qmiveT1lvVwbu+Uq5pcXlBah2MJnN5RP3cmZZGaubFtA7A4SltKm7RJekctxvp5nPzJ0AgSCmQftFUN5dCzvEglNEcf3hxLRBqRCigrbj8SIrPe7ZYEhgWrLzwc6xyso4G9oRtBMUBtD+LkDKFzauS6eZGCLL0mJogGEVxvJq/2iLLikzBkh5Drn0uCIcWJk3VFJX5kn7YWs048KfR9yp50Le3GTP59kIIj+XkGCO9DeUeW0q50GpVadv8s6bZI3GgklBM3+9YIk6YR3hqq2wxDPbg1IPuI0MbPmhP35S98gFN/ojtynuu2pXe4A9E/7s2A+hAA21W/FSVl5F5cf9vP6WILqZbq7EGyh+C7gamGLoGVI9XaQIIxQFyfJBUeWQTI+8H1rQN1SO5T2Hpkkw3NZpYAosoRFBr1nSxkxjmoTLNyP6Ss0wa3Cll1+xrTb7gk8C2sAoNKBPCxUpTEUsN2K8vVReDF/7D5+xxtWK9bXAQvJo0Y7NhjVj01ddmf0mzrc9cacMxDf5H7N+ZY5hzK2045v8FRvFVSyrWkkbJ/+RCUyZicIkxdb1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bb1ec5-3939-40fc-642e-08db5b821871
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 11:37:31.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t/ZjpGVsC1phve34smjEBWI+Ikm/UmwGcG+lEme7ib5szVgsEr68rA73C4rWlGd7vUhU2VhpMm1Rd2rEmfeWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_07,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230092
X-Proofpoint-ORIG-GUID: 2m5bRo1vJFAZbvk_mZGo__hyUafGMZ9l
X-Proofpoint-GUID: 2m5bRo1vJFAZbvk_mZGo__hyUafGMZ9l
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/05/2023 16:40, Christoph Hellwig wrote:
> btrfs_grab_root returns either the root or NULL, and the callers of
> btrfs_get_global_root expect it to return the same.  But all the more
> recently added roots instead return an ERR_PTR, so fix this.
> 

Fix looks good. However, I'm curious about the Fixes commit
you're referring to as the one this fix addresses...

> Fixes: bcef60f24903 ("Btrfs: quota tree support and startup")

btrfs_read_fs_root_no_name() return value used at that commit.

> Fixes: f7a81ea4cc6b ("Btrfs: create UUID tree if required")
> Fixes: 70f6d82ec73c ("Btrfs: add free space tree mount option")

I didn't check these two Fixes.

> Fixes: 14033b08a029 ("btrfs: don't save block group root into super block")

This one is correct.

Thanks, Anand

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/disk-io.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index dc2ad0bf88f84c..5dc5d733ecfa4a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1358,19 +1358,13 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
>   	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
>   		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
>   	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
> -		return btrfs_grab_root(fs_info->quota_root) ?
> -			fs_info->quota_root : ERR_PTR(-ENOENT);
> +		return btrfs_grab_root(fs_info->quota_root);
>   	if (objectid == BTRFS_UUID_TREE_OBJECTID)
> -		return btrfs_grab_root(fs_info->uuid_root) ?
> -			fs_info->uuid_root : ERR_PTR(-ENOENT);
> +		return btrfs_grab_root(fs_info->uuid_root);
>   	if (objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
> -		return btrfs_grab_root(fs_info->block_group_root) ?
> -			fs_info->block_group_root : ERR_PTR(-ENOENT);
> -	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
> -		struct btrfs_root *root = btrfs_global_root(fs_info, &key);
> -
> -		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
> -	}
> +		return btrfs_grab_root(fs_info->block_group_root);
> +	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
> +		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
>   	return NULL;
>   }
>   

