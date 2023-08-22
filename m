Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7877838B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 06:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjHVEFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 00:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjHVEFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 00:05:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8E3189;
        Mon, 21 Aug 2023 21:05:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M0NqIp027389;
        Tue, 22 Aug 2023 04:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CmkYM0hndsTk2eBH1ko4OhNdvkT0asAOOzWE/NRTAgI=;
 b=MEaPzWGWzERw4rb9S+s1kb1GyFufOiY6wHqCMtUyySsuGm8+uLB9wWxuj71EFMhYk5Jz
 nG6sBxZc9Dpgelj2N0QEnE+bhJu7yQt9+G5IvuOXenyuHx5bo33sBWNmXGLCqOY1T6Ti
 G9cbJ96buRDeGUXX2KHq1hPcxXV+KF0jMeSEC/7kQAkrUwFs7nPewtDsHJjUBIHZ92tF
 rZ19HIThGrvaxOuwAXCpbQLrzrlkJzBGIaxZ7byAaH0Iwu2ga+Dx3hgio/wtZTXM0uZP
 iASyFV9Nl/zAdifrAzt+hynbIA2yXcdYHFKsnKYVtuUiWT4k5laQRqDW1z6ERbgp5NKb JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmh3cc8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 04:05:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37M1RP8p030418;
        Tue, 22 Aug 2023 04:05:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm64aegd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 04:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWYCTCGyFrv9ifbv+3L+vX6hAbp6B2/t3LB5btcPlpYBzQC8An9Bd7uHtu24m3cKQRouz2Xlhav1AWQ0kCxcMirxEUF0dGiV6WIfRHX6yTaALBhZmJjX7vvWAo56gqz7VE8Fdb1W/p04Xt1wL1N+wKImLbj2I/QAMdl6vdbt17kpSEy0I44vmhrTuJaLKDNRgDy/Fmx2yWlYxpJRiDYH5SnU7R94Zcj6iy1p1Jgu+FRlOI8PBwxI7XAhdZz6ss/w8FwyVrckiHPSVsIWEvL0CY1RhsZ+rXUA9MXldvfMJHnWYd7h1zC/UTT4PLMoggqC5Y6yRGiGrn34bGwIwjOVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmkYM0hndsTk2eBH1ko4OhNdvkT0asAOOzWE/NRTAgI=;
 b=IY2MH4r/1rHra7+g2F5n9+B8C1qUzBSfie6Hnk+qZlWZD3LUoaRGMGh5mSsSi6eyHZUueTVOjziFml+KKDLSJuZNNUSlZVNGcLOTYZci2ojetmR+XXmQxgx8rAPMHF2yZ6bd5pIe1fDU9wTMpfV2kKmmIj8Zy5eAxemUHpzmKVk2XNcD/YPthQyq+3ODh96VRzfJBWjPg6QRNv3O0zJX/1enn3ZNVV6duWG2PhKJe+LciXVlvLIn9EUKe8zL/gm9O29tzhPBqh7KHxKvy55lJ/a8fAkRczW9M3e/VyLQiM57PhcaQ4c1V8T/R2WdenSNc1d0fG9KCPSYI7m722KTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmkYM0hndsTk2eBH1ko4OhNdvkT0asAOOzWE/NRTAgI=;
 b=FD9fwPQBmk19JQ55mziJquL+SwB//rz068cNwg54XZyMG+oqxssXQZkNl88cgfa3ziCB7SVqqyMf8+ZdcI+GFdhVcKNIpR4iRlJBHyLZ/Ij5Lr6fyni+Gbh8hC/rfKjqH2z90smYerCgG5hOptNs3X+U0MGn1LkfSpszAMRaDt4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 04:05:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 04:05:28 +0000
Message-ID: <590727d0-5452-5469-711f-2b8cdff25719@oracle.com>
Date:   Tue, 22 Aug 2023 12:05:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] fstests: fsstress: wait interrupted aio to finish
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20230821230129.31723-1-wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230821230129.31723-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: c035d11b-38cc-4028-8dc9-08dba2c5056a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myluVWvCY0BXVBfUv0uTZIcAv0rHR1sYmTHGUGVcKijqRiFQR983aFRhMCP70YiZ4byu4Q/UpNR0s1XlifLfy8o7n/RiCGeArtxVasQqhEpymQMhCoccpfrJ7Imjb6uqwX3VheGtQF5RNuUjle/psX0uUzBYfMCC29tCHrdiZhBoFAFL1mTHYK7la2hwnfPfi4jVHm0raOT6cS9eXwivL76Wmo+O4XgfWkv+fHbkuEsdS9pRZZH1kLeL2votVJMzqpct1diOqLs3qAirXXhRP7CfzaTc1CTPB4z1U9e0u2xZJ6UbG0PRvEwcrE6SWcXJbODNQ5NcVi/W733FHBrfr84sriA+LDTwf5w1bvZmnmCLG2jr28uKflEYsGaWJ1IMrSB0/T1rKCMd1IBfziVZm4MS5keymsmKzLbXQhr1orHxsiDa/EQd7ITtEMhW8z9/YI1eyMZ9PPjuo0PQM6Z1QHw7gGtTTaQfy0hVeBkxoPwmMf6gNAjX/nXQ+C/a1K3iEZF0O4itoRDG5ukTFzdi7kpF+Q+88jBBd+R1qd2d8aiEsGm6rFAFZpeh+yNdcpWsxPVn/zB0BRvHZY9cYnaeOlZro+/dPNYW0jqY9AKHFZbSW7hCEjyLig3NlIVxZGXPwsRHBdeOgvvDFMkGmldRDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199024)(186009)(1800799009)(6512007)(6506007)(6486002)(41300700001)(53546011)(36756003)(26005)(86362001)(83380400001)(44832011)(5660300002)(2616005)(31696002)(2906002)(38100700002)(8676002)(8936002)(4326008)(6666004)(66556008)(66946007)(66476007)(31686004)(316002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERYSVpiQlhwSnJSV2ZLdFJxZkdKbm9WZWVHK2VoMmlnTUNvekxjZE1CQWY0?=
 =?utf-8?B?NXdZanRYaDMwdWZEVGpQTE9sU1FOa2IwRWRFOThOdldxdDJqbUpWVExwQ045?=
 =?utf-8?B?ZUVaWjBFQmhwYytvR2VmNjI1UHphcHhoeUVKc2xiTGRLSkhWUGo0WW95aVlE?=
 =?utf-8?B?N0hPRUlDZE1yUHdEcER2VGxJN0NOaWxwYTFrdmUvd3hjYWU3MkdGd0Zrd3J5?=
 =?utf-8?B?TEFRZklWNnNHbDByQ3RQQmt6OFZjdUVFYjdaNEIrZFJiNk1zTUJJUHhLZGNl?=
 =?utf-8?B?ZzNERjNGblZHSG4wSUY5eWFsS25oS1NLNlNKUDNDUW1CNTE1aWJsZFgrT1VE?=
 =?utf-8?B?M1Z1cGFkMWZOUVR2VmZFNktrdHlDWVdLV0RhU29lYW9MRER3YjQybWxaay9z?=
 =?utf-8?B?VjlLbEg2T1RhMms5elFXWWpjSzFhcjdMaTB6bk5SVW0wYWt6RWphc0VDNUVw?=
 =?utf-8?B?azhHcTcwMCt1Q0hGM0JpRC9ieVVHNmFlajE3WDVFcjFBWUdWRVBUaUx3L2t6?=
 =?utf-8?B?YUtJM2JOT3hxdXF0ay9reGJoZDhKODVxcXVQSlVqOHZ0NGtBOGpHSU92cktJ?=
 =?utf-8?B?Ym1xOFdCc0hZSEhKV2FCaTdQZndTL1NxYitlaG5FZlgrTy90cXQ4S0FWU3lv?=
 =?utf-8?B?NWRLTGgwY3VqQUV0c1JLV1h5bFlSZnZvbmpVeWhqVFM0a2kxN0ttMHhpQlBT?=
 =?utf-8?B?WnFJT29UYTY1UzdMcVpPTmZnV3hPaU1nUUlCaW5KdEtMQ2M4eE1PWWhrUUp4?=
 =?utf-8?B?L3hycTVYS3RLZml3RXRNR0dHS3RRQm50VDZLZHFNUU40Y1RuZDNJUEFPZWlz?=
 =?utf-8?B?emp2UmdrK3pUUWtYcGVmWjRZU0RncUNvN3NBNUcxQzFYRm43OWg1bmowTnNn?=
 =?utf-8?B?VFNKU2Z4ays3bnN5Zi9GNUJ1N0VBQTM2Uk83K0oycDR5UERCR21GS0FaZFRK?=
 =?utf-8?B?RGQySjRmZVVIRFJOcTRIK1RPMEFGb3VyUXNMRGg4Rk1aZ0ZxTmcwNVJrek5h?=
 =?utf-8?B?SjdsL2dkTVBnS1ZyTU0xd1ZqTmUvR1BXcWowS05zNzFRNnhGS2VOQU9LNnlI?=
 =?utf-8?B?VVpkQjZkUTljZ2RORkxSZFNyMVdwb3BnUnBVYTZ4SlVRYTRhbU1uUTI1TXJJ?=
 =?utf-8?B?eEJMdmQyTlpQTWkzekk1bktMV0RaMVBKZmd6RUJmWGova2VpVVp1QVBwQ3gw?=
 =?utf-8?B?M2RHUzNkbFdONFUxMUsrTzJlcnFqVUxscFF2MUp3cmRYc205eG1Cc0VNUlYx?=
 =?utf-8?B?SkQwR3VvRkdUcFJDQUxvREJVQWd0WDZibXovcXZMeTZCQTh4Tm5rOFh1bERw?=
 =?utf-8?B?R2VzeGlYelVFYzBNSkk0UWNMOTJwcWxGck5OVmVIQi9WbnJGSmFoZFlKcFBp?=
 =?utf-8?B?RktKdGxsdVBQK25aR0dXU0hhTml4ZkxIMGhZRU9NS2srTS9mWFZhNzRuRTJF?=
 =?utf-8?B?eXZlc2ZkMDFhcWN5djFsNmsvdHVJSXVwaHl4ekpQQWpleDZsdC9mUitQU0JP?=
 =?utf-8?B?K2JISko4YWs4VjRtY1lIRW15Njc1VnBMOEgyemVxTVZaeWgwQklpMXJNUXRM?=
 =?utf-8?B?SDQyc3VDK1o2eFM3TDN5QU1NalpGNVRyanhaemN3aXZHU3l3b3RtMG16Q3hu?=
 =?utf-8?B?Sm9uTjBNSU1DeEU4K3phbmE1bnNSaFJKS1JlK0J5cFdKc3o5bEtZSU9xbVJH?=
 =?utf-8?B?YzI5MGlXSXpTSmJNZ3JQWUxhZWxKZWVvRzhBeURhRXhpeUs1T2FINjBjVnJk?=
 =?utf-8?B?dnVrMlhNVTlGZFJ1anlaNitvb3VTbGVIeUU5azMvSFc2ZWY5TVdqY3RjZXRj?=
 =?utf-8?B?QTduOVFMQkpJV3lmOURhaEUzR0k3bHJkblFhQkllZkNsRUY0YUlZZGg0R0Vm?=
 =?utf-8?B?eGJ2bnhUdkpLaVNyd054OWtubnNRcjRHSXlWM1lUQUZKL2hJWWljUnFqQmxT?=
 =?utf-8?B?L3U3ejNqaUQrTG50RTBNU1JGblJVdFBYY0ZyNDNtS1BMaFlVMnBIOGlJUGsv?=
 =?utf-8?B?TEc0SzBUOUcrUFRpd0dlVWxPM3V3azNlS2tEdE51S3lKbkhWMG8yU245Vk9R?=
 =?utf-8?B?QysxOE8zQmNaUlpEUTI3cnNkVHNBQlY4ZU50QjNmUFdGaFpZRmZqVUZoMmQ2?=
 =?utf-8?Q?nL0cx6X+lUqiAOUxD9bH14x2a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MBTDIoAA30QPeyxx3nlW16Q6pcmFIirKs1xSS1p9vHlxlaS0/w1LUMo2ol+kAp5bqI+xm5/RBtQbsMD0g65zUgZdj3NUjN4TkYgAVBK5Lkq4BPX06gWsyDczvWYHj1Ioi4yBPxYTv1SutGl86RfTqf5RqEkxuFmidgTC6F1QVcUBqQXAR6hRdtGruGGjtBQ5mEFy3QFqOiZJ1zBhytcPOFSzXMxFCtyGIwBg+f86w06lX/HCFbmLoUsDQ1V5dEcmtrmk3HjnBvy/2IZieV7EgeilqsEAqRu/vVDSpX13u9sBY8x/pjoBA6NOU7CxdiGRKZVgtxRo/j46Ef1kxZW4++uiKGpt6QqXtPNsQq40PwR1FDiTq04CzXLRes1PLVYvpfLmjwPsN1kO+OkRxfIpGQjvEyTpRHE75sM7lqmfhr/KWTIQcT0NMviEqVRfMcE54uX3hsAKJhBmk75NvNE7LbeqDg/NZ3TNNlZ4Nh3KcJRUBl0s974a/nurob3Wa/Vd8Z3WF4p90jYbLrDm7pxIkP28cObkeVFfk/L19boGhEL3LhMLi4iQRRB5qPjwaQk1vPe4tENtjsTogN1jfXnRZKwedGXHsKNnb4rGZbXffdRW8rLrA0gzViszGw49p7Tfr2I2m9nojTDtKnqmwrCowYfvtWEvtA8SijUS3giRhc95I29HKJBaq4fVRwOH0XfR1A8mV6wBU6Vgh4E8c6pF9lzdJgVFeVEwsujVkDKU4dO7wFpJufF/pMMPeGeZolWA+86EzbRQSNKQma7NB4WeeRbW8BWpq2D5TZwUNwL+deUtCW4SjUKFqMxn8s19ZnU4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c035d11b-38cc-4028-8dc9-08dba2c5056a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 04:05:28.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTLfe4VGhDaavGB1aH1phVJXvnwYXkvrAhkYF4baITPaj05ncU8rcCZTDOAOkVJ0XENa7u9uhUARE5SUGefXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220032
X-Proofpoint-ORIG-GUID: CeU0id8AL9PpSWUC32h1IFG5BpmKWLxI
X-Proofpoint-GUID: CeU0id8AL9PpSWUC32h1IFG5BpmKWLxI
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/08/2023 07:01, Qu Wenruo wrote:
> [BUG]
> There is a very low chance to hit data csum mismatch (caught by scrub)
> during test case btrfs/06[234567].
> 
> After some extra digging, it turns out that plain fsstress itself is
> enough to cause the problem:
> 
> ```
> workload()
> {
> 	mkfs.btrfs -f -m single -d single --csum sha256 $dev1 > /dev/null
> 	mount $dev1 $mnt
> 
> 	#$fsstress -p 10 -n 1000 -w -d $mnt
> 	umount $mnt
> 	btrfs check --check-data-csum $dev1 || fail
> }
> 
> runtime=1024
> for (( i = 0; i < $runtime; i++ )); do
> 	echo "=== $i / $runtime ==="
> 	workload
> done
> ```
> 
> Inside a VM which has only 6 cores, above script can trigger with 1/20
> possibility.
> 
> [CAUSE]
> Locally I got a much smaller workload to reproduce:
> 
> 	$fsstress -p 7 -n 50 -s 1691396493 -w -d $mnt -v > /tmp/fsstress
> 
> With extra kernel trace_prinkt() on the buffered/direct writes.
> 
> It turns out that the following direct write is always the cause:
> 
>    btrfs_do_write_iter: r/i=5/283 buffered fileoff=708608(709121) len=12288(7712)
> 
>    btrfs_do_write_iter: r/i=5/283 direct fileoff=8192(8192) len=73728(73728) <<<<<
> 
>    btrfs_do_write_iter: r/i=5/283 direct fileoff=589824(589824) len=16384(16384)
> 
> With the involved byte number, it's easy to pin down the fsstress
> opeartion:
> 
>   0/31: writev d0/f3[285 2 0 0 296 1457078] [709121,8,964] 0
>   0/32: chown d0/f2 308134/1763236 0
> 
>   0/33: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) d0/f2[285 2 308134 1763236 320 1457078] return 25, fallback to stat()
>   0/33: awrite - io_getevents failed -4 <<<<
> 
>   0/34: dwrite - xfsctl(XFS_IOC_DIOINFO) d0/f3[285 2 308134 1763236 320 1457078] return 25, fallback to stat()
> 
> Note the 0/33, when the data csum mismatch triggered, it always fail
> with -4 (-EINTR).
> 
> It looks like with lucky enough concurrency, we can get to the following
> situation inside fsstress:
> 
>            Process A                 |               Process B
>   -----------------------------------+---------------------------------------
>   do_aio_rw()                        |
>   |- io_sumit();                     |
>   |- io_get_events();                |
>   |  Returned -EINTR, but IO hasn't  |
>   |  finished.                       |
>   `- free(buf);                      | malloc();
>                                      |  Got the same memory of @buf from
>                                      |  thread A.
>                                      | Modify the memory
>                                      | Now the buffer is changed while
>                                      | still under IO
> 
> This is the typical buffer modification during direct IO, which is going
> to cause csum mismatch for btrfs, and btrfs properly detects it.
> 
> This is the direct cause of the problem.
> 
> The root cause is that, io_uring would use signals to handle
> submission/completion of IOs.
> Thus io_uring operations would interrupt AIO operations, thus causing
> the above problem.
> 
> [FIX]
> To fix the problem, we can just retry io_getevents() so that we can
> properly wait for the IO.
> 
> This prevents us to modify the IO buffer before writeback really
> finishes.
> 
> With this fixes, I can no longer reproduce the data corruption.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix all call sites of io_getevents()

Should io_getevents() in aio-stress.c and fsx.c also be using 
io_get_single_event()?

Thanks, Anand


> - Update the commit message to show the root cause
>    Thanks a lot to Jens Axboe for pointing out the root problem.
> ---
>   ltp/fsstress.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 6641a525..abe28742 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -2072,6 +2072,22 @@ void inode_info(char *str, size_t sz, struct stat64 *s, int verbose)
>   			 (long long) s->st_blocks, (long long) s->st_size);
>   }
>   
> +#ifdef AIO
> +static int io_get_single_event(struct io_event *event)
> +{
> +	int ret;
> +
> +	/*
> +	 * We can get -EINTR if competing with io_uring using signal
> +	 * based notifications. For that case, just retry the wait.
> +	 */
> +	do {
> +		ret = io_getevents(io_ctx, 1, 1, event, NULL);
> +	} while (ret == -EINTR);
> +	return ret;
> +}
> +#endif
> +
>   void
>   afsync_f(opnum_t opno, long r)
>   {
> @@ -2111,7 +2127,7 @@ afsync_f(opnum_t opno, long r)
>   		close(fd);
>   		return;
>   	}
> -	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
> +	if ((e = io_get_single_event(&event)) != 1) {
>   		if (v)
>   			printf("%d/%lld: afsync - io_getevents failed %d\n",
>   			       procid, opno, e);
> @@ -2223,7 +2239,7 @@ do_aio_rw(opnum_t opno, long r, int flags)
>   			       procid, opno, iswrite ? "awrite" : "aread", e);
>   		goto aio_out;
>   	}
> -	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
> +	if ((e = io_get_single_event(&event)) != 1) {
>   		if (v)
>   			printf("%d/%lld: %s - io_getevents failed %d\n",
>   			       procid, opno, iswrite ? "awrite" : "aread", e);

