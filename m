Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F285B990C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 12:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIOKqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIOKqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 06:46:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDFF6DAE9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 03:45:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7TqqZ012646;
        Thu, 15 Sep 2022 10:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H6Sqb35h0STjiZBtR1dx9tijs0xUYJ688fpZ6FkzNj0=;
 b=WeSKuLtkE3AURWhUTQPA2nRsva8ckTq7NIl8+SdrsgY2pOo+v4feSwUbPRk9wJdXZkYn
 NicQyLX+3BeqG2pPju5pgVsVBqbi9KRE3R/2Phy1L4ntQMRBDzoY4a917P8h4glfBWL6
 9DVWbB2tpYJ2e1d2Enf5kYG0t++0S6T+gsnmGNDLxydkz7pYDTOR0LcK+aAtECGWxny1
 kvn2T55tOKED7VPnWV7UBch5mi1XXsCISsgK+z8X9u4bpXS+PPr74c/NO5qHEO0E5tkS
 rNgGzwklRVA2xKaJLUitL8obNtHlVoGzAamDJPFezeDYqQBh1SW//73JD2WFGI/30NH7 AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydvvf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:45:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qNfE021439;
        Thu, 15 Sep 2022 10:45:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym5qyrk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE+N1IIUR+ux8RL2PgCArJBC0h1IjjzL6wXGcQJpEvr7FDFprdiAOcrSQAHqSicwAm/f99Nont22phhoZNTzqQJMeE/3oVFHBYM0ICPMX6UeZl4X0JdonMGDXUTbWyeAyzsj5pmbyqdhwX08IJOrJk3ivTy2OYW0zTrIXTVXX0tKIvOQOn/yqTb8UVdhso8bxGMcjTZ/WyUOTHlt5QFJc6Q3dX7MwvkW8afq+WX5HQjb1MxtEG/ZxTZcfd+0SKEk13IRXRCPwF1CXWT98SshUQWI3LdwmLF70Gciez8IbNpeFjAnOTjHu7G2aT3e/sBp1UvGGV2fMu5MuSNiDqo+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Sqb35h0STjiZBtR1dx9tijs0xUYJ688fpZ6FkzNj0=;
 b=E6ld65ANMq365OaDnEN0Jgo8wbTH1sE/sND5/tmeJfq7nv+un/fzOewkdsCMU+j+D7v+xA1L8vLavU0kCB5xXYyzhDUV8LhuW3VNNVxaH0NoMm6xqglonxy4rbptGYrJfhmx1WVKTTdH/HeOaC04Z3OGrk/H2aIDEuzOcjiKGxlpyq/uO0/kCz2prG4sjvn6sdnEHcMXEP+J5WXzJnVO7deJoCMrNvG6TeBneuIvXjYCVfFFTJAuLBwN5Cah8pE1YfX4ToiUA+ZdEBu8fIZ6a/G040GpmTpxa3bSSjFsDsQOIC0NSdRhj+HHZpSj+FO48tQjfs/yYJxKU6e4D3WSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Sqb35h0STjiZBtR1dx9tijs0xUYJ688fpZ6FkzNj0=;
 b=LIfbYsF7SaioVKNIA3AKDTzOrJdm7Bw2XNKMxsiUwv1fKbURcCY0f6vSniSrFKssJB/lceO2k8WYY+iaIgrWjkf8jtBlsy4Zk+Wj5kuD5QR+OYf94ukc/UhjxbV5+/VKGXWNCR0L052jC/ycbSBKmnCQ+/9mNDfQDd0xEhGjDNQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6036.namprd10.prod.outlook.com (2603:10b6:510:1fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 15 Sep
 2022 10:45:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 10:45:55 +0000
Message-ID: <d42fb594-456a-206f-bc78-0dcbe455d399@oracle.com>
Date:   Thu, 15 Sep 2022 18:45:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 08/15] btrfs: move fs_info struct declarations to the top
 of ctree.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <9506fef3a36ca9a740283dbf1df1f2d884cb732a.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9506fef3a36ca9a740283dbf1df1f2d884cb732a.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ced174-36eb-4842-ac32-08da9707778e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MORVGYozNqAqyGr+YaNCca/I4EJm6kJij0pF/6y+rq6Y+SnvXJQNdLebC3XrGwYAeETTC17VzdpfbHjzKB62eSDvJhWlKxFjTncDYsCuVrikotW0e0d1BAaBid8gYP9HfvCiYTqH87ZDgRtmzYmSYGkCps7MDcx4V0b7lXhHZFcc5mmEPKXyeKTWpUwixLKti36qjvk3EGzA10nOSjbs5hTLqBjw2+cfrzFZxAjb+0ghgoybJQOMKEGmfv38VtQNYLukRBl3g4b82RI4vWNR7Izbo3mwfZRc3KL/NNhLp+2ls9RVaP4uf+hHziKDtZC+vaVppF5X1FD3U5N3nIQdpcsklwCeJGlQ3lxt3q6QNMG1uVq3xgXGe9R2tukQLQlrhngN57tfm2NomREVQfhyDnbX3k2xLayG8hs7XdEyv15SCjhYFxK9toqUnGIgABWA/2a2q+orEkVng8cTst/u85Hklz0M4akIn3YlC/btVJN5/EOhIMqaPjIL/NNoNe0dqktwZANz0KERwpLkvqw5wI/cT6fmTPiTN/V1i1U2dQJUzLmhy/rEeZYe3H9/CyRXeDNw1XcVVd0j3XIXZ2Y1OyKr7N1p1tcihEkiCOb57I8uPRt9BWF8V/VZKZDNbESdHsJEPX9w5cFQ6ity0N7pCPRk5rboYWym1sYgK0qgaTBQF/j+VRKwUL9DJ4QD7/dIiZNY/mVa9ClkdO3xecZHV8YiFo2shU9tJug0TYYY4QBXpXVLoIDKPlS1mCKT5TlLnEzZW/ow0C0QFww4DQKABfE891hrd8yTtzZbCxyNW/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(478600001)(4744005)(6486002)(8676002)(26005)(83380400001)(8936002)(53546011)(41300700001)(6666004)(2906002)(5660300002)(38100700002)(44832011)(66946007)(36756003)(66476007)(66556008)(31686004)(316002)(31696002)(2616005)(186003)(6506007)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2czUVZWZ1lDdm5neTZ2YzFnMm1SRnIycnkwNFRDR3ZpdVRkU1kza1NpRFI3?=
 =?utf-8?B?ZVRkNHkwZllxQjJlZXh3eElhWXUzQ1pBN3VWKzZSQmxYN08yRUxWU0paUG5i?=
 =?utf-8?B?cW01T0p0eEVJbC91bWNnWmtQaml0U1VJNnRsMnBrOWpUTEVPZzEybXVnMzVr?=
 =?utf-8?B?aTJTeFhCd0paMjB2MU94WjRCek5Md0NtT0paT0w5N2U2ckVPMWdRcTA1Q3Ar?=
 =?utf-8?B?WktDZXJBMjVDdkdUQVRMR2VzMVBiNmRqQ29RdndlZFpJOWJ4cjNhVVppVkNp?=
 =?utf-8?B?Ukl3Wld2K1g2cDNaenZXM2I0YTVKcmpsNnBXTGtSWDlEMkdaZ0tJaytTOFps?=
 =?utf-8?B?ZHl6MDlFNFVkMjRKeHo1MmFJYTByMGlyOFQrdVQ2Y0xwYkx6OC8yK3M1d25O?=
 =?utf-8?B?eUJmdW9SVHNOaUZnbDNEYkxmUjFPaFNCM1pSSW1IV01NMmZSbjBieDBqMUpu?=
 =?utf-8?B?bmRUYnFlV2ZyMEVWNXhRRys2QU9RZzVDRUJaVUJYM1pWNmIwaG42NVU1cExT?=
 =?utf-8?B?NzJkQXR3Ri8xdE5lcFFDd0FPRFhUZVNOMng0OFlISytSRnoxV1R4UEhnVSts?=
 =?utf-8?B?cHB2ZVhSMFMvT05jZU45Y3hHUE43UGozYXRhWWYwZE1jNTU0anVVamFBTDhk?=
 =?utf-8?B?V2pMSWYyMnVwNHVWQkROaytwQWVCL3dJSnhkVkpQTFVwYThvNUZ0QllyMVJw?=
 =?utf-8?B?bkxTYmNwL0h4RTZKdWZBcENkZlpEYkRpdlpyNnlQTVBiT2NtN0hWY09WVmtI?=
 =?utf-8?B?Y2FNOU1leitvM2h3N21CMEVqOUlHWWFpTzZYNENmVUV6ZGtyNVlPaVhlUjFh?=
 =?utf-8?B?OUllL20zS014M0EzeXlSVjI0MHVJdzk0Q2VZaWF4MWw0QVVsK3ZOVXo3Zis2?=
 =?utf-8?B?Mld0ajJaOWV0bDdINHVsdVdFek9Gd0ZsK2VVWkRSam5LZmRhcVJJVEwydjRY?=
 =?utf-8?B?cWZ3Sm81dUlLdkhLRnpPU0l0d3NPUGh5MnRkMnAzQzNEMTROaHh1OS85a2FC?=
 =?utf-8?B?dXhXcEsrV0ZYeWdYTFZQTGpQR1dNZHVmem9pS0w4bGFDVW93WnlmaFdvVFI0?=
 =?utf-8?B?ZHZGWnpWQmZGdVAyVDBUY2d4dGxhMURoTjhBdGpmbHMyRnFNdFByWmFjcmp2?=
 =?utf-8?B?eFJVZ1B6dEdKaDUzYWxGQTRCVE5RVjhLcHZ3THV6ZjNzWnNRZGh4NGtsclhk?=
 =?utf-8?B?aFRHMzk5VDZZUksvcWtzbEFCbE0vbWZxMFdPY2o0a1l5S2xLYjJaSDZ6MEJw?=
 =?utf-8?B?cVEvM3lKeVRwWnV2Yi9IdXQva21iTWd3THhCeHkxNmtMOGV1TXp1OWFUbUNr?=
 =?utf-8?B?aWxjM0wveGxTOVdtMXN3ZG8zbjFkWkFKb2pkVU9Xc0l2MndBeEh0Y2Q3VVFH?=
 =?utf-8?B?N3dRZ0o0U05EYlFac2dyemc0RVk0cE9abFVTSHpkL21hUDNDOVRKdHRrMmNT?=
 =?utf-8?B?SlZ5RzNGMndRU3g0QU9mUmpWZHhCVnQ4Q1FOYkJ1QW1yWmtBd3g5b0tTQ21I?=
 =?utf-8?B?d1h3Z1pSUjlkUmQrczhFSHI4NzU4N1dFWUdtelNxSnM3akliK1BVamVPZUFY?=
 =?utf-8?B?VGVyVVdFYmh4TE54YStuS0VyTlFYUnVQRFBvOVNjT2xUOXNuRkF1bTJRY3U1?=
 =?utf-8?B?OEFlNng2b0NYTWh3dVBaRjZmYkJKQ2VOZnNFS1JjSHduaWFBMXg5RC9NOVJG?=
 =?utf-8?B?Y0VsRWhJOTlPQ2FoMlk4aE0wSThIdEVhVm5ib0Y3YVE4UzM3aFpxZG9CeUQ1?=
 =?utf-8?B?L3UxTzhVUFNGUXF6eGlYWG5uNWpPK0VPN3l3byt2UXJjdG5EOUJ0NHRib0Fo?=
 =?utf-8?B?UUNUbkdXVnJ0cjVlZEVUeWpvOEpiMlB1aWgyUWI5MVVXeHhYaXY4RUpZSGJP?=
 =?utf-8?B?Y0xoYWl3TDNVQWhaUUp0YklPN0dGWG53U3VHejRmRzVBaXBoNTlLYXhlSEhs?=
 =?utf-8?B?cEJEMSt1UUcwcE1MUUROSDZEaFJRT0ltU0ZBdHRVNWRuaHcwYjJWdDNob1h6?=
 =?utf-8?B?NERaMlo5TWc0d1lpcnJDeGlDWUZGNW9SZHhabEFUdGo5ZDYxdHlKdVZqSElR?=
 =?utf-8?B?Q1dXY3ZVaTVDK2doUG16b0N2WVkxWEhhOU55RW4yS0VmKzdnckJJNGxKUys5?=
 =?utf-8?Q?tfpeisg8V9ugf2L+8gvQGQr/g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ced174-36eb-4842-ac32-08da9707778e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:45:55.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4PfDDigdbNGFw0Xq8lOGKrCHijsayJ3tUpxPOwV+Ywprg5q+KJwW7vQ2COozbnz5p0akEA4xBvTIZjdWGhv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150059
X-Proofpoint-ORIG-GUID: kma_AoWxOqpGjGK2yvGuFZEseuuaf-BU
X-Proofpoint-GUID: kma_AoWxOqpGjGK2yvGuFZEseuuaf-BU
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> In order to make it more straightforward to move the fs_info struct and
> it's related structures, move the struct declarations to the top of
> ctree.h.  This will make it easier to clean up after the fact.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
