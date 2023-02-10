Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93076920CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 15:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjBJO0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 09:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjBJO0r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 09:26:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E8E71F1B;
        Fri, 10 Feb 2023 06:26:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAndqB002126;
        Fri, 10 Feb 2023 14:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ELhKPgT2OZwhPBqHMWKHrFm5nPKNY2hJHH1bzNCkIy0=;
 b=I+RfOe+U4+4YlPYG9dFF0rnccCDBMjuFrs+b8dosnRmgx4Ydmagd+caTZi6b+HU8aqYQ
 7XsFQ2/X2Uv73EeQR1PAA9aB65RzZSOdzV3XXCZzMrLLsRn0mSnjzPS/av+SwbTiVyin
 c/gff8++B/9hJcMA7a4nrRTd+3mbq8YOpYlw/lR4JW3L7Z/waafr9+22XTcGvX5Wmwc6
 cU7PHSjZlUOfYbujOkEJKWzzYp8evdytVS7i1IcfSLmzU0N8lN0p7FIsuwYWK4JGy/c0
 0oGDqFAtKhdd5UvdcGkUnDPj+Jorp8Q4odNkMVXyAOQS27PsB16xQdVCKioPdkiQIAEa dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwudadc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 14:26:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AECBVM002644;
        Fri, 10 Feb 2023 14:26:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtgvh7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 14:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5OJjXzGtY5CjMWSufZK+YzQUQovjR89rV8L2qeLVCQEHq5TdfXfHJrty0oSCX73O5NfBTlIYZHPXnXEzr8smXujBSNvYF/mHzBi9fPEPMkjpSsX1YoGacaWGBxX6/Ftnz0h8rzNimZxRonXjafVEP7RcgggK/Ty2d+YMjtwaL1sLhUFSkO/O5GZtQ3dfRoVc7sGExA8IdyBrebdMLy+kToVdhJaEV/b/8ZyVpi4rwWqTLvw8d7apOCLqtbviGl1FCGQReMECmsmfD1bo1IhA3rMI7GI22zQS8sN0cDKVrtPzFE0S2sYj/NgaTncd/BDaF38s0imbEaGyyUazFmiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELhKPgT2OZwhPBqHMWKHrFm5nPKNY2hJHH1bzNCkIy0=;
 b=JKJbqNUCzKJ0dCf8CxunjJIpbMs9DodzJh0rKxSKVTJf3NsPcekhQ4jWnmRWGjhTZUpkLrqkYAK7FBlel+jNeo0CBeba74dAaxMRsQTchsIWVKYeCNZbUeyLkXTz0ZzPExevacZ2FoUUfEeYrP5CXWd9eQbq/m1bm8QzsYWNdejl9zIDpQd8VtfhHak91U05SELcV4hnIwAr950+2RUptUkIhyMjSPKiKiOWJbY6bEsy7+8aAaK2NUvZ3wCOa9FnBjssIJ+8yUttuFSI6ND5muW947KjUDvcuxPS6GFjjA27LB/pfGs9RfiTNJdZL6ZseRDSlRVYMjGbvPZNHrL9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELhKPgT2OZwhPBqHMWKHrFm5nPKNY2hJHH1bzNCkIy0=;
 b=okuZFan42JiyZXo7SkA+7u7r3TYbCmMTVqGGwu/9Kd50RaZQRn3bd5wcHy/6Xz7nktg+nN6ZYj1BVxlO1OOx71CSRxVeRQ5ntWYs9ckXAbTe/3qSZ1DxDaJ2wAaRB8qImxet9hYp8f/HRJ78T5mokCesBL3Ai+HI84TUd+FJXe0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6581.namprd10.prod.outlook.com (2603:10b6:303:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 14:26:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 14:26:35 +0000
Message-ID: <eabf8312-c576-1aed-8c2c-6e30197bbd9a@oracle.com>
Date:   Fri, 10 Feb 2023 22:26:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] btrfs: make kobj_type structures constant
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230210-kobj_type-btrfs-v1-1-16d3f33c17be@weissschuh.net>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230210-kobj_type-btrfs-v1-1-16d3f33c17be@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e0c77f-82c2-4e61-150d-08db0b72d07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI0Pm63l/Dt9+g4+yIH9OST3j3uD90O6VraClcFa9R9mUUj+o6GbwLeh1y5j1PPO73jZDoXoOi1IWKDF2Ehssi9ogCbW1Vr3PtjzMhHuaSOKy/VzqCutSfravtfGCYT7aSOZy1fpCKT85lz2Io9UxDwh7iId/ftLralNyx1frlLIQjwoSuCGxZwsKyDgvxZMHwpKPYtpqDTl+MldJjaft0bSz3alTEaEHvNv2bPQHRjsISzhrvAFegpKGVeyV2ea/rw9eNEfSjnK6ReLXShrrhdreyMma86UeW87T7WJ1/6CY5A/gc2cJaWU0covpmdSl137UxulqVekaGU85c/tUEcgvuAcUsbXqOEhkKKzq/JMBuz+hv6KBsdS2I0btj9PUkSIAa6LklD5H2tTqMMcXRUM+QuqHuuxovWujWDk1WSCaOrK0dvrBB3s3AX/yY0YNxMZNcf8XA4CY90+v8Mh3eRkrWQJBjzmlrS61B5RLlmaoJV5EJd9JrBYg2m4VP2mKjxJlukB2y2mwPcDP2sVq+CHdgwaIVeeczqr6yRcDTmi+Y/f7t6QkC4y/4hUvi/LBwp2KP0wJ4OqvTjK+JcyqOC5g1pd8yk9lW6uUue3Ct2M0s1SOQ4RB2Xy7kw5rZ7O44TyI9Pw/DaAKRyVRuoMfDu2F3/IdUXCaigT9f0wYgiZsS1eLdvw7Ym5fof42j+YmXJQ77eIKse0qqZJqiurkTP0AiWdmIGVjH6ZK71TNPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199018)(186003)(26005)(6506007)(110136005)(4270600006)(478600001)(6486002)(2616005)(6666004)(6512007)(31686004)(8936002)(2906002)(19618925003)(86362001)(38100700002)(31696002)(316002)(66556008)(4326008)(66946007)(36756003)(66476007)(8676002)(41300700001)(44832011)(558084003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09lUU5xdVI4eHJGbEtWQlNQZVRCaWNOMU83QXY2TzVwZnliYXZBNkVjWXlq?=
 =?utf-8?B?bUpSdVovbGRhKytYMmZhM3UwMG1GbUYwamhya2x4eGdXUC9kS1lCUXVPZXdQ?=
 =?utf-8?B?eW9JQmtBd01CUGtSMEcvbWZXMVRxQi9wS1AwdWtlOXYvS2JEcnFiS2xpSmZy?=
 =?utf-8?B?eTdEZXkzZEFKSEdnZjJJaEZEeEllajBzRGo4eWpVOU5UNi9kRnRWaHRVSGdw?=
 =?utf-8?B?L0ZWQ3dOcWVkOXdHaWpzeHRYVnUrck5yYUxlRzBNNHVocWVZTDlVNGlFK2RU?=
 =?utf-8?B?N0F1TERwOTNUY2ZuOVUzTXl3OXVHTlozRGR5Ym5UMDVqVy9nU3lHaWwxd0FF?=
 =?utf-8?B?bjRQSXhyaVhKQmIvTEVHekNRbDQrNGRZOTBjaVl6L3JqdHFCaEV1Z01sN0hv?=
 =?utf-8?B?QiswNlNpWWIxNDIrUjJoSk8ydjVaQnNMRGVvSDloaXFrWkhvb0NCMURKdnpD?=
 =?utf-8?B?azFtR3U1RXR5NmhZRXNsa3kzTGtYeFhRUmFFbFNlcnRLRUNwNTh5ZWlsMjhK?=
 =?utf-8?B?enJxU1U0KzMzR3R2RllxM1Q3RTdNaFc0Nkh5SmlKQXQvVDJRWFN0UW02MGYx?=
 =?utf-8?B?bVJHTVNFQVFzS1MxdEFUM2N1dEw0ODZ2Zis2ZVd1WHVCUENMaXllL3FhMlQz?=
 =?utf-8?B?ck1LNHlVSDFsR0ZUbXJoWEE2cTBPdmE2U25TLzZPb3BqdUg0M1ZSL05ZN1VJ?=
 =?utf-8?B?a2FuZjVTRXpBaWVrZDVDdE5IeHRhcWxkNUtNU084Q1RNQXdYVEdVNllMVjBU?=
 =?utf-8?B?ZlFDV0IxMXNaQ3ltTE5tSUJYVkNOQnA0SnAwK3h5VXlQdXJtR01LYnZ1T0V1?=
 =?utf-8?B?YW1QZ1dVUkNWL0NHUHVkNXEwaG40VzlkRnBnUFhwdXYrVUFNV2FySElVTUdr?=
 =?utf-8?B?bkw4TmJPQ2g2YzQwN1dTSTZqY2o2SExkdm53Tm9OZ2RMOG5UTFhscTF0MGJH?=
 =?utf-8?B?VDVNSzh1dXR0MWRqeWJxSGVEb21PM2paL3oxbTB6akhjTlR1YXplUitnQ0Fp?=
 =?utf-8?B?STJtS1NWMzkyY250cU9MalVqWkFLMEt0MlRmbnBIdHlFRW5HeGx0WXhuWVgr?=
 =?utf-8?B?bk9LdEU1NWxqOGc4VG9QdUpyRVVkbmJoamVUZDcxN1ZRK1VVUFpZRUsvYzFy?=
 =?utf-8?B?VFVqd1FNSStyR3QrSHJMMTd0OHp5N2o5d0cwQUM3NW5vWEg5TVBnRXBRQS9z?=
 =?utf-8?B?VTdvRi9jclY4Qm9CVXNXYmFrV2oyTWg2UWRQcGZOWUFJRDVYUzY4akxCSitK?=
 =?utf-8?B?YjVjYWdqUmhGMGtzOGhLVWhQenFlWGhTS3RFdW13NFlkZ2RqRFBOelhldjFm?=
 =?utf-8?B?S0VRVDlWYWMzK1NNVFBqQjR3R1pKNkNFWGliSWhFNHAxcjc0ZCtoblNxTDdH?=
 =?utf-8?B?QlVYc0dUNHpMdUZZSEJteDZhcDZqYXZqU2k1TUVNM0Q0bGN3cGhMWVN4M0cv?=
 =?utf-8?B?ajB0cXF1VElueUVzZUQ3MEJMUkdTZ3IrM2dvMG1VdmZZSjROVStVblE4eWQ3?=
 =?utf-8?B?VWthbXVzc1BtM29QUi9qZDFOZXJ1MVNZWmxpQzNqbmdjSUVFWnlEQ1lLRXhu?=
 =?utf-8?B?cWh6cnBYOCtNb2d6UFlVQW5wRkw2MWx5OFE1QlF1WlY2QTdjVDFVN0VXekNB?=
 =?utf-8?B?bTljMnRNQXFobEJ6d0N6Y2R6SW05aE1BWm8yOVhXYS9kdnRnOW8wYkxLQnhq?=
 =?utf-8?B?djc0aDB0cWdJZXN6WlJRMHR0VEN4VlBLQllDdWlsQkpZbkNPL1lUSUZXMk16?=
 =?utf-8?B?M3JYc1AzcWlVMjgwWUNZYm5SN3I4QkVJMC9pTWFTSzJDMkpoaWg5N3VyYVAx?=
 =?utf-8?B?Z3l0N1AzVVBKeGsvemVua1BiY2RYbEJRUVRaQWVFVXpRc2d1MDVvSEZFSEtq?=
 =?utf-8?B?c3hobEJqMmNzWW5CUEhyZjdNUkxnVjJ4bStyVmw0WDZUZFFPWURoQ0NyWDNs?=
 =?utf-8?B?TzlmSVVSL3g2bXFzS1VaYS91VllKcDVQTDFQNmtRSzQxWm4xV3M1cmxFc3hy?=
 =?utf-8?B?d055OGNzR1AxTEFhVWhzc0RPL0hadk9ic3hXd2Y3SUVuUXFvdVc1UkFRSjEy?=
 =?utf-8?B?VUZqNlpqRkRyRy9JYUtic2t4K2QvNjZrUjJGMC8yM1dvTjlZQlN1VGxCT0Q3?=
 =?utf-8?B?enVJazhCS3BmMlUvSGoyR1g0eTREa0VzNnJSUGRzQ1NHYi81RjhReElMTUNB?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8OzpAIH0KNDd2MRRobIRbr5YEgjoeQoMCI+v4+iyonNZkz7z6nvue4S2CYzIMNZywJIcB9ZsC9PR15U/7fDLxE3JOudmjCBrTSNRbqFABtIhq7/C2P3BqTBck/XV9MQFeu4ZtbvkApnkoIYXkemc/2UMsetUv5NV39S+JxPADgI5k8R6R/RkkomiR8Nb3Au+VHOBtyyH4Q7XH8faTUqOBNm9RgvgLqnE5LcvzphHkGXEYtl3aBVhPqSd9znB0RyaqflVtka7pEEtxs1mayoIa4lAys/yn5rAa8bJou8osIUTtpMzwlsmxDPnj3Ll9NDwAo+hoCH1OEGMf/ou33aoL44EMHWruHVHdsJ5poa31Wdg9K5ZIzbtPS0eUsYSPsgLhnppRfCWBA8A2/fmNvKF0FKTL8MZVvKUHmZ2epuo7kUud82Vr+7r+pqZBuaFyPHZQ9H1ptTpwgEswJPnzT599T4DEnvM2BibZCMtUHxL/tK+39CgTfXuGfrn8xsH3Xl0PoCFthrUAgNsr1xtdhp8ihYsWmMYMtBlDQ6/MOKB1FRzu5wSFDpZHjkwxOz+tl/9hwnJkNxS4rCE15zA0G4Maq3je6TWtPm35WaVL70zvVLbIzb/cMZaCEG1ZJF+14wBqm2wcNd5HIE6yi3RogsFWw/19VpJvHXtSdhDW14g7hQFaWNny5gbpLaRxWrn5WQbq8ild92QbvaWGGOpNEUVYKdpUVZgFPprBE0jRoDjD7Pl6Yn9OFjGH8alEFV0QRqxwiT5s/1D++ftHs7LtgaFzpPOnDtynwTBF7qQb2lRTeyft0CoImbGYeJkWeVYDTA7JcBtEB3jbZD1b6vSJfdLc2J7M3zl1/bcPi2A8Sy3KKAjTMY2PFOnEzHwiMDtRhW4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e0c77f-82c2-4e61-150d-08db0b72d07e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 14:26:35.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er0+mj9P/NFeXFz8vE4rAHI45z4qB+oQHy14zr8W8rAsi48W4+t/O975PzPnp8Jh64JV/O7dX6FBoc91YgszkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_09,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=927 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100118
X-Proofpoint-GUID: KP2mh9TnjFbvNn0naOFKZmOFlyWeXDJC
X-Proofpoint-ORIG-GUID: KP2mh9TnjFbvNn0naOFKZmOFlyWeXDJC
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
