Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF8A65678A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 07:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiL0Ggc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 01:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiL0Gg1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 01:36:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86E38A8
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 22:36:26 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQMp0jh026861;
        Tue, 27 Dec 2022 06:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QqEWEu1eFTMY/7etAdZrT8j/PEAJ+IzdKPtrqTwNwCY=;
 b=NLr2Kp4VmImgLR81Fb+fhLG+7ZbKq8+2rffiqCA+sVgzvTKqIFt9cYqJHUQY4s6eXQXG
 xZw2T2+Alh1/wB40uoUj+i/WyE+4QGmXX/vSyOvGTWvWF10WIk0s1p/3TnLo8VcKpG9n
 HCmstqpr0OJ3rfd0MxZYa1UyAnn9Un8uAvmLRkFXvF6gtF4LlChc/d2bEhA4/eMKeSp5
 BWJqutazgiQroZteDlkNF9ScFMAzgZT3/cEYnkUlhbvsFPam1jCQQroFdU2psCVVfcHM
 VcupRxr02sJeR/rZ+7qVDkvkVhA+pGhJoXxmqgydHhXfwArhsRPzdZC+/6U+RiqruoMc xQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mnsyt3cus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Dec 2022 06:36:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BR4cGSS034163;
        Tue, 27 Dec 2022 06:36:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mnqv47yac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Dec 2022 06:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRqChb4f5Jmbpfyp/jVE6upaneVT5ZRPdsct5zb6UCnIUbDG1AmhDWkybC+PQnnS0jDC66Jay7SKVlT/r4thPxcCt6eMDpD+q1OhiFLyRtA8LU2Q9Q4KaHJNBfD63F9vaoW5d9lP1wmOWlRvgvpFH53gFXP8L0ahNHlUedwvhUYmqRfxUxXj6nUqkTcWqUPHNmX6pd85XWudzfn1IyJ30j0fCYEWZt+r/6ReoTiSYtKrNurC/Dtk1Bhpqcb2IWzrQyG4clZOV4+RQVRiRFYtQOtxP3nKyRbQthczhveTjq44GSPMopYGL4tWDrOoSNv9Ksp/ht+4FYiHEnHT7D312g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqEWEu1eFTMY/7etAdZrT8j/PEAJ+IzdKPtrqTwNwCY=;
 b=fuU6DoiPtFKzq9GNEmMfU1byc/1YruvzdEN49SQ9u4sIEOLLnEFSvugCqZJWjy9BTs0dAvdMHUhJtOMvo+M927xH1/noibCmjB89cVmhgV3FPc2C/QXcqaqvz+U0xG34N7ufx7E+MgqrOgYp7XW0OHLupVxVzwIPKBZCcXyboTdGFV6/PVbnxA0I0JuJn8hOJ8i6jll50Gg2/YA+b1e7BLhbMPmFOJbtxAJWG8inpH6l6Isr2XYc7akxg4IHHnxkrCO118igVMo1Lekmc11QLFdZfxm0byC1VNT5H6mLXPNP99dEY1YuFNfL33c0yT/wTwEi9d4JF9ZX0tSLklJ2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqEWEu1eFTMY/7etAdZrT8j/PEAJ+IzdKPtrqTwNwCY=;
 b=IB4hslkMX5ZWVp1M1YmmN/V1J0NTSY9cB/L4ymcGZJFuxa0HaBAQEbXbxEqkGiyDFeFXj6WSOE0lTAmFnpYYubRu72TYZos9/qmzeXT13ELtCfTxhKHSGj6XcHFzOUiljz5efV+nxllxGPBUF/MYJMUfJFE6WPIBoyv5qSV0/2k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 27 Dec
 2022 06:36:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5924.016; Tue, 27 Dec 2022
 06:36:20 +0000
Message-ID: <3c0d5582-2d06-ed68-2f96-a689607cc95b@oracle.com>
Date:   Tue, 27 Dec 2022 14:36:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/2] btrfs-progs: fix the wrong timestamp and UUID check
 for root items
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1672120480.git.wqu@suse.com>
 <fd138f8678808717635a145832c1b13320ce6cd2.1672120480.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fd138f8678808717635a145832c1b13320ce6cd2.1672120480.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN4PR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0729ac78-ac67-41cd-9538-08dae7d4aa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRGCySh0aGjm5axnU3OHLOMbgqGl6HY70tKJUOZLrECpvoiMTPH7Gl2d9rW8QtqcsL1jLViKIvaX41jcrzD5N0Pk+bhWW0TnfM8q+t/LZfeVjw7jNP/4CoRNUyP/3ZM4RqxFHh1rdZU3Z5xzEoaPWwDzQf562/3kVMrYCiFB2LcIErzlHFVK4f92fqahzgfdtkOSc/lbYwbgSCecUNXv+SiYpUrQ1kGxg0djiA1ErXv8c7BomtD0EcZ9t9LlG0QTyRehMmWbhPy4LApWWGd80GZ2UzPFtIi5XObIxw/FjjvAwdZtHpRziODqkgoVkw5WAw+gNLwL2SNwjhmIe+CnUhbs5LfXBiM8i8xoAp0S9cQC2HDu6XZc0qOk58FRMJjOXCzxT6DBLc4JDfBlumPYrcWvvtqi8i+y63x/X+CtYimmHLBteJfsDP6Q7hsnVLEgG1ViBuJlKUu5j4N0d38lU4YC3xRlsSZK0s1pNc+C38Q31zSbPVFt1EVTggUUKoGA3R93wUl/2JDeKNWJcOvgSYKDkMIWJdtBXJ+W9iQywF2xlVzXObSuZ1iE/w1uXtYpK7d3BCJprYKW2YqG2P0UvOo+6TU+LgsgmtL2g9z23Z08Yz440i5BYEVg/MAZYQs+8oNl0FcNbNXmGFODGMyBrdLLTFn9A9dEChfmrlyyR1ndutAOsnHd3s859720QfKSq9CUSKtB9oJGVUXXKZrVisW2mLOVxNre2xgaITvklRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(6506007)(41300700001)(66476007)(86362001)(316002)(5660300002)(31696002)(66946007)(66556008)(44832011)(8676002)(8936002)(2906002)(53546011)(186003)(26005)(38100700002)(36756003)(6666004)(31686004)(6512007)(2616005)(83380400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5ER3AraFRlZXcxWk93YnhZL2U4NTMwRWNIZ3UxMTNYcUd4MkpuL2dLQWhz?=
 =?utf-8?B?b3lnNmZzU1JGWW0vR3FoblJ6cE9vZDl5TER0NXlQT2NkZFg2c0ZTRmxpNzI2?=
 =?utf-8?B?NHRMaG9XUXhCdVNMaklBTXloQWxwNHc2MjJNeXVSdkJjZ2g4UzFmNFpnai9U?=
 =?utf-8?B?QmprTjR2NWM2dE5MSDR1TWpEQUQ1KzQ5YUR4REJGM0tkU0orcVpZRm9uMTd6?=
 =?utf-8?B?SVIxL3czUUYzQm5USmN4bkw2U21RbXE3S1FYdGYwUk5pZVN4bXIva0JFYTRQ?=
 =?utf-8?B?WGU3aDk0d0hXL3QraER5STFyZlAwYjFwWWs5OTVsYnZPMVJzbUxwWXc5d3lp?=
 =?utf-8?B?RHZlVmkxNTB3UVU4WklwekhsOUdlUHdTU0pjZDFKRW13YXN1MmJlem5xMDg4?=
 =?utf-8?B?VnFBQlFFVVIrSnVIbnM1eHJpOS9INmRLWVRvTXVOQkQyblFaZVhCVktJK2Fy?=
 =?utf-8?B?NklBanB3NlIrdno3WFFrZTJ0ZnBLT0FPcEFoczhvdGlmbXBKQXRYeS93b1NK?=
 =?utf-8?B?VnlxaVRSM3QvbkZWTURya1Z0ZmgvYzlvU0NjYXpTOGpXMG9RSW5RTkoraGNp?=
 =?utf-8?B?b1hlMnF6VzRta09nY1h4a3pCbTl0Ujc5dWRKT0ZaaTZYOHgxalo2SVlrMzU2?=
 =?utf-8?B?Z0l2QkczVWdNVWhYWnFVa3dPRHdPWmVXM2M1RWdqSDFmNDFxY0NtSENGMUpG?=
 =?utf-8?B?YkduaFBWemQwRjN2MjVBcitKcXgveWxhVmUvUWVsdW5FbzFYdVdxMnhkcDlY?=
 =?utf-8?B?Ulk4ZGd6K2huRWV0MWd1bTVDc29GSEhvR2VZa3hXQ0NIakFiclZ6aXk3V1NI?=
 =?utf-8?B?VG1SWnlhR1FOYzlsRE1YdjNwTTNGUWxGRktHakkyTXFqcmNyYXorS1FHK2tX?=
 =?utf-8?B?eVB3S0d3b3NGaWg1TkNtS29Ec3g2VXlKbGVTR2ZWcU9mOWxDVVhDMkw2Z0Zv?=
 =?utf-8?B?djlWYzhKMldlUkREZlVoMitISyt0WVpUeW9qTWF4MXNRRHUwU1duWG9ocnhu?=
 =?utf-8?B?cjF1WmM2QjUyYlVRQWkxZUpDTnlLQWZLL2VuUXpnTkJ4Nkl4ZXh2clFvSXBw?=
 =?utf-8?B?SGFpOXpRUzVISHpIU2hnbjdhc0R3Umovb296c1JWVlpKMXErVCtNQmxuUmNG?=
 =?utf-8?B?OVQrUU45YkM3MlZQb1pmNmcrdnZ0a0FYektOejVNQTRSQ1FHbDdsVVRqb205?=
 =?utf-8?B?VUdVaEoxNExiUGtWcFg1MnRRTjBzNDJSWENPVjBCQUlCZkc0eVNZaEdzbVNn?=
 =?utf-8?B?dG40YUN6Ump4RGpxRklTUmd3S3J5WENmTGhta2JSSld4blpnbVJZOEp3dE5v?=
 =?utf-8?B?TCtLWkgyQ3F4ZlIvaCtKcDVTMWMwN0s5VnEvQUxsOG1NM3VDdlhLcm13Nkw2?=
 =?utf-8?B?V0dpUW0vYVh1QnJFNmFMSHJsbHZlY2Y5N21iMWZxc25MVDVOOHVFbjF6NFR4?=
 =?utf-8?B?QlcrY0JJdjVvbVRuanBNUnR3SitielN2enNuWjBQcEtod29uczN1TlNGZ3d0?=
 =?utf-8?B?ODRUaStxWm9OckphVFN3end5M25Rb1Z0dGgzZFZEQTZnb2xveXYvd1dkUWxX?=
 =?utf-8?B?K0E2bG85Sm5iRDFSREFtMkhDRGlLN2lVMHFJZTZpVWZzN1dISFBhL1dnSmJv?=
 =?utf-8?B?dUpmTXRHUFppdS81SElUUFRYdS9zYStsUi90Z1dZNlc5TG9aT1N0NW5mVnBp?=
 =?utf-8?B?NnMyUTFtZXJERUk3U0I0QXpQbkZvQ0V3MWdOU0dvenQ1eHJMM1JMMnNjeUJD?=
 =?utf-8?B?dzRqdFN1WkRmakJnZEVnYnVVa1lsVXI3SFlOaVZnbDZKcVdOUll3OEhyYlpG?=
 =?utf-8?B?TmV3aUNQMGd0U2JmQ0w0bGE0TVlhakdGcFRqd2ltV3Y2UUxId1I2NDk0Nk5O?=
 =?utf-8?B?MVNlMktvREM1Ylo2aHViUFd6dHRPNTlUcUt0TWlYTWZPUU1kWnhKcGhVYXcz?=
 =?utf-8?B?WnFaa3JoTEZkSE4wemNNc2pJc1hxZG40THJxUDJQa2ZvR3NWN2huakd2K08z?=
 =?utf-8?B?NUNDdmdnNGo5MG04dGNyZnNxdC82TkhpMjI3S0NiQ2dPWnVXS2ZsMmlXVko3?=
 =?utf-8?B?MTNUQ3k1RXpTY1dmaHlGRGp0MmxUY0l5Snk3QjdZT0F5eFZWRDViakt2VlhL?=
 =?utf-8?B?azJKSHJ5RHloUFg1S3Y5RSs3eWVBVzdBM3R6OTdvZVluZUFMSXR2ejRIajBB?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0729ac78-ac67-41cd-9538-08dae7d4aa44
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 06:36:20.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w68N3DH+a9yeoffrS6RZzqyog6CXp+etrh/t+PT4dpMQhXJDVxSW1G4RlxxddNFDpN2Cqu6TgxL5zGX5mr9lyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_02,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212270051
X-Proofpoint-GUID: xkWFZAB5c56hfbqdhDYP6CZeCGAIthxF
X-Proofpoint-ORIG-GUID: xkWFZAB5c56hfbqdhDYP6CZeCGAIthxF
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/27/22 13:55, Qu Wenruo wrote:
> [BUG]
> Since commit d729048be6ef ("btrfs-progs: stop using
> btrfs_root_item_v0"), "btrfs subvolume list" not longer correctly report
> UUID nor timestamp, while older (btrfs-progs v6.0.2) still works
> correct:
> 
>   v6.0.2:
>   # btrfs subv list -u  /mnt/btrfs/
>   ID 256 gen 12 top level 5 uuid ed4af580-d512-2644-b392-2a71aaeeb99e path subv1
>   ID 257 gen 13 top level 5 uuid a22ccba7-0a0a-a94f-af4b-5116ab58bb61 path subv2
> 
>   v6.1:
>   # ./btrfs subv list -u /mnt/btrfs/
>   ID 256 gen 12 top level 5 uuid -                                    path subv1
>   ID 257 gen 13 top level 5 uuid -                                    path subv2
> 
> [CAUSE]
> Commit d729048be6ef ("btrfs-progs: stop using btrfs_root_item_v0")
> removed old btrfs_root_item_v0, but incorrectly changed the check for
> v0 root item.
> 
> Now we will treat v0 root items as latest root items, causing possible
> out-of-bound access. while treat current root items as older v0 root
> items, ignoring the UUID nor timestamp.
> 
> [FIX]
> Fix the bug by using correct checks, and add extra comments on the
> branches.
> 
> Issue: #562
> Fixes: d729048be6ef ("btrfs-progs: stop using btrfs_root_item_v0")
> Signed-off-by: Qu Wenruo <wqu@suse.com>



> ---
>   cmds/subvolume-list.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
> index 6d5ef509ae67..7cdb0402b8e5 100644
> --- a/cmds/subvolume-list.c
> +++ b/cmds/subvolume-list.c
> @@ -870,14 +870,21 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
>   				ri = (struct btrfs_root_item *)(args.buf + off);
>   				gen = btrfs_root_generation(ri);
>   				flags = btrfs_root_flags(ri);
> -				if(sh.len <
> -				   sizeof(struct btrfs_root_item)) {
> +				if(sh.len >= sizeof(struct btrfs_root_item)) {
> +					/*
> +					 * The new full btrfs_root_item with
> +					 * timestamp and UUID.
> +					 */
>   					otime = btrfs_stack_timespec_sec(&ri->otime);
>   					ogen = btrfs_root_otransid(ri);
>   					memcpy(uuid, ri->uuid, BTRFS_UUID_SIZE);
>   					memcpy(puuid, ri->parent_uuid, BTRFS_UUID_SIZE);
>   					memcpy(ruuid, ri->received_uuid, BTRFS_UUID_SIZE);
>   				} else {
> +					/*
> +					 * The old v0 root item, which doesn't
> +					 * has timestamp nor UUID.
> +					 */

  Reviewed-by: Anand Jain <anand.jain@oracle.com>


>   					otime = 0;
>   					ogen = 0;
>   					memset(uuid, 0, BTRFS_UUID_SIZE);

