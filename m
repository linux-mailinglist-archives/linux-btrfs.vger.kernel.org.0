Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39756070BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 09:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJUHNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 03:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJUHNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 03:13:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C7F1E8B9F
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 00:13:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OvjV019245;
        Fri, 21 Oct 2022 07:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MTfrVxpn6H7kofaBUNV4im21TIeMXAIc99jbk2XfGGY=;
 b=Vy7vmdAkn0JNs1x8m4nFA83IUa2xnlENt91r7nVJxvf+R7R+qX5KA6FTUSopGqKcZEA9
 eIKj/F7VBmsx84aGpk2lxEMp4ky1m0u9JePp0ZEIQm8t66yhwTQb6+BHIcyq6su6uUmZ
 FGar5Jejbpgq5/8LG54ROAQbd0EUWwldPk1nnbvFZLyOAVFD3lrjfoDqO3+GgNMzbg+F
 hrCtHbXtLWCIU8uW01H7yRAbO6KiBYx9VjysnQ7UziYbe9qdmMahchX4emOycUGej0hs
 oqlHIHIHvC7pV0Ndv2c6+PAE7vQDg9JfdGu5eX85e52AvfU4ffyZcC9BZTfLCk6Xim8R zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9awwat03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:13:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L4FA9n016984;
        Fri, 21 Oct 2022 07:13:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8huakmkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwyir4FNkSbPNGKAswZUGfpWo6Nl89dajrARF/iRVu8/mHa3mTkuCabXGigsviWyr8At+d/2787SWjFIqf6/kEVdsqpaC40zRz8lxJ65B/4jl4i+OhslnOZkyayEeP9hcbNPDssL18L+8ixQ7sP6sBFZYK960TGK/OubEeCJpSV/5IKTZl+FQWe0pSTSIWSoOyEzz2pJtDxIaFhZsVJdlEqAZoI/+EitNrW9qIxHwzdfzJtXEeHvvUMfMcldq1FBsyFdmCIJttWdaHx1t/cnvkDspE3g6KT9oMYhT/8HbMrf4ftjagzrnyw9rRxPG6x1EGX8DCKh3XHn0KiSTAij8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTfrVxpn6H7kofaBUNV4im21TIeMXAIc99jbk2XfGGY=;
 b=MjmiFukw/Vmwgpjf4LC9N2s9AfL8ti2IQGAHyPhv7fAqS8FFy0IYaGEBG87FBFEjcHstqiKN8AWKOgmTujPxRkbZFq/a9dWRAKzsqAGtlz2jk+IhDwoQmQtcBPaMWyWmBR3cbCJvGB4TxKj7wKyMnv+1exSXzhkjxiyC3f6Z2IBYo2xDHZ1Y/n8t0P/o5JGxPkYWNfx5WiwAshBIx9yo7oyxneW6Pq1Kd5XYHovCWz/anPBIeog2UjqqDnWAuDXDmzX+FLMo/uzLVnJSgrU5Z3ogrI1f5s70441khXodtd3fk86UmqEG1amfJWg4lreRH2ribu2A2Vc5lCbi0paARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTfrVxpn6H7kofaBUNV4im21TIeMXAIc99jbk2XfGGY=;
 b=qLWGSFyOZ3YWMMPyKoqXwyNSAtq4M7UVnVTFsvviMUvtlndyqVTcRBR55XvZDOcCD12rp7THkLfgjzmanHdhShKyUPT6nMDKDjasLOpYOzzuUujGb/lp4t4XEUriUHz/7fCcaEomFLjCRDomCa4O5mPeeK6SHVebDlaMxn0kR6Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 07:13:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 07:13:39 +0000
Message-ID: <c6bb7795-7efd-7efc-7794-cfba085c11a0@oracle.com>
Date:   Fri, 21 Oct 2022 15:13:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 07/15] btrfs: move mount option definitions to fs.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <9a53b66cecf607e6ccdd9b5ed0a60cf5dac343fc.1666190849.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9a53b66cecf607e6ccdd9b5ed0a60cf5dac343fc.1666190849.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a406a83-121d-43ca-3623-08dab333c6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3UyVwQ8lXUY35a48TLmouKjWcqkprsUD1D0ZkrZmyAXINSOOl9RHZJ8h9FPouczdTU8jM8aNwh9Yh8AYwTQ0mGMH1lQ3LdAGV9ADLpLm3Mbtk/Vur8q8oS/DdtMltvVMDOW+MoxROJvfKydsZYKONUin48Q9TdeBdtTdQfu6oTyGHCvpunU9ir9cWyQmEGjyzz/MsS6sJJHmVb7rZLYO/0/DhOdpUpCXTR6YCN6cf6pFmRkIUTIy0IrAmEU7KtgbQlDEWkJrB/PQ+XKYdlNARS0snSY8O4Syy6CXfGOAF5k3NRr/GR9nOdsSFcbhgBJQuN03+qY1dB0jZLSMVw2ttE2TfdQmYmgwrllIKi25c1HFuCoTxOC2QtJVko8yGl45RJqLQUDnrWWFOoCGbp9HNmgfWgQ7NBjoskp3pvs1nKOaKR0DsmxzUyG16BGE5Zom3XowkTDihbpyOWw/Wc1xvamdUF+Gc1BmUh+uRwKwpiN508cJfCogcYlFeC31ZuO6i1qdeFL3RtJel31M6vyTs9qurtaFVnmv6GUn8VnRkNdVrPpXz4/pi5evic9tI4y8fhKysBnD9nXZ8ReOGEzzzmec61lnB7f2JRZOui0dDz0JyqjS2TaA93gQzK0U8orNs9sSWILhGt8UQhTI03rxdl8nhbh+C32l9/AKsMkn98P7xHBBZvvtcF8pAkjzzc9CdqAXQyBllSnFxoGURwmcPlw//HIm2l3yzs7yL6kBGofQ3G4LOXLUJlmMR+KPlDeHPchVLxc5lF42G4CzDje7ugal4J1RuD/hv6Qi4NZo8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(2906002)(186003)(6486002)(478600001)(66476007)(66556008)(66946007)(4326008)(8676002)(4744005)(8936002)(44832011)(2616005)(26005)(38100700002)(31686004)(6666004)(6506007)(31696002)(6512007)(86362001)(36756003)(41300700001)(53546011)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJsd28ycjFnRXh4QTdiTVpMQ2ZLZ0dzd09NU2tkZnErS1VjcDl6S3c0YjRp?=
 =?utf-8?B?VnZYTlhWVFFGVEtZTFNTdW9KcS80ZmZ5ekFCeC8xcmhwTUU5SDhmQUhUdGRT?=
 =?utf-8?B?MThvWWw4UkpaejlYa0JwZnJlY09IZUpCbGxEWFZUZS8rMlZBakl4VkNMM1Fi?=
 =?utf-8?B?Nmc5eVBvelhEVnBXSXlhQTlkaDM4OW9VRVA4NU9oRWxNQ214dlpGRlJUQ1ZW?=
 =?utf-8?B?QUkvRndkcXpLRW9yQWtkRS96dW15bFRyT1ZkTjVWNXdrRkxqbVI1K2g0dXlt?=
 =?utf-8?B?VHg1L0dydGROU2xZR0JoeGx6bjE5RXptMVRldUxSNnBiWGN2S0NFSHFKNzJz?=
 =?utf-8?B?YnprYmJsWEo3THR4WWNxc0JVVWd2TllOVXd2bjhLMUVmY0lUc1g4M1R5NytU?=
 =?utf-8?B?VHlzbEFhMGhPZUhqQkxRY0FZQkdOSE5xVWludnprVHZ5YlNjZlJXbklYY2g1?=
 =?utf-8?B?TEZqVEdQTG56Nm9WQ0hlbUtVNTBsYmNnYWVNbGc0NDVFRU9xK3Yydks2bVQy?=
 =?utf-8?B?QXNmWHhGNFV2RVRpRm9wL1VzQzJOcnRhQm8zWi9UMGQyR2VJeW0vWlgyOXQx?=
 =?utf-8?B?Y01yOGljVFV0V1ZZU1hwNW1WMVcxeEZNNVdDKzV3d2VCVFFNc2JndVkwQzlq?=
 =?utf-8?B?MmVuTlBDWTRCOGNYRXVwbG01MWtrN3AxNDhXM094ZldtRnlDdjRkTUJON1hT?=
 =?utf-8?B?dDdMQTFMTFNrRHpBR01iZUZiaUFpLzVjcGtkdklvM3VBbStHeDExMGRrZVBm?=
 =?utf-8?B?OFZqQUVPbjgzQnl3LzhWUlErVk1KSWNqeEJXVm44WlRPQ05QN3JSeHI1NFhI?=
 =?utf-8?B?NjZNRWVmSlhKM0lrazZkSmlxOXdIYlhCUmk2Z1lLcWJTbDBTWDMxWG04VW5C?=
 =?utf-8?B?QTVUS0U5MGdUQ29HcnlkNUdIR0pLNE1aSE5jY2czQlQvR29yK05pR29Rcmgx?=
 =?utf-8?B?aWRrcUpaS3dWUGd6Yy9IekRFR1ZqK1Y0QWlPTjQwZ3VKS0s5ZDhFbjNidTZP?=
 =?utf-8?B?QXVWcFZ5Mi93bUJ4c0tPR2M2L0pueEp3WTdBVzQ4TjZBS25MU0JyUld5aG1m?=
 =?utf-8?B?VGpMODFXNUMzT1MxaDlSU3hkUmdHdTU5Z0E0bERyb0FRbGpKdVVqL0k3VllH?=
 =?utf-8?B?MExWc2gydHZJRE5KUEFqM2Y2c0NHcnRaUkZ0Y1E1aXhVNElwZENQZHVscUI4?=
 =?utf-8?B?eDZ6bzY1amhWTmdTS1ZrUGx4MkhLR2lCWVFOYzgzbXp3MUFqdmg5eEp4MWU3?=
 =?utf-8?B?djg4QmZuc3lKYzBEY0dXZ1FXbzUydW1nSFlOKzIzMmRpRkdXSy80NW5KNmI4?=
 =?utf-8?B?d3Bvci9GdGJKTndMd0RIZkhYNUh0dlBUMW02VWV5RmxOaVdFUVcxRW5KWk1I?=
 =?utf-8?B?bTRlNUVmNDFaclBUUlFwTGFJalQ5WlZRejQyTlp6UlJuc3pzRkR0TmtZQW5y?=
 =?utf-8?B?WUxsbXZOOUl2eHMxeVdCbTFCVldtRFloSTJkVVQvN3lJeTMyc2NWRllXWVBE?=
 =?utf-8?B?bXNndExkZEFIMG14L0ZtK01hY2RDeU1NbEJFamhscUs2NTY1WjlRNGc1MlZ1?=
 =?utf-8?B?SUZTeEdEa3R2S1IrSzBKdXRoUlhNcHowbnNMRGFLVEVZS3lxR3EvRExiRmo4?=
 =?utf-8?B?aTRLeitPT3BGS09PUWVnZmhHcEV5WTBORGR5UkU2MytwMlVzblJGQVh2c3lG?=
 =?utf-8?B?UWQxem9yMlFyNndSSW1wbXhpT1U0TmhReDF4RVh0cExWdUx3REROMWJEbTdP?=
 =?utf-8?B?ai9NR0tNWFRwMTY1K3hKTnZ5SWhlRk1PSTk5QTd2d2VCRGQ3UjZCRkhhencz?=
 =?utf-8?B?NGxLVXZBM3VpM0VuMkNGT3JiUWxNbWU0dHlZT1pGQ2ZLNnhRS2dEK0puY3Ix?=
 =?utf-8?B?cGdScEZ0RlRlNFQzRzUxcGhMKzJrSzhkQVI5cnNCUjRuVzVqWXgrVWJBeGdm?=
 =?utf-8?B?Vmg1U1RhQzBNMmVsMWFEWHdqTzgyMTJUTUR1T0RibWJEWXJkUlB4eVJ0OVl5?=
 =?utf-8?B?dGxlbkpJdjFRb21ZdnRJMlc1b2RhNytRU3RkMlFWZ3FOdnZKN01tR2QzQk9X?=
 =?utf-8?B?RDNKTXY1aWJWYi9JeDRUTW9rcWJsVzl6c0xwTVEzd0M2VVpMS3pGcVR2UGJW?=
 =?utf-8?Q?gRvsl0FV0rzYnWzXSSbzXT8kI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a406a83-121d-43ca-3623-08dab333c6e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:13:39.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REjoQRluVgCkqKhiIjG6W/c5vV6f2M/EABeZwhxMdZHFrI1eE0U96sLYZdzqHIhuDZXAy4r7njqOUHcwnuQP7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210043
X-Proofpoint-GUID: 6EZtlC_ZDUJdiCfkgv-HZjQjP6Ml66pU
X-Proofpoint-ORIG-GUID: 6EZtlC_ZDUJdiCfkgv-HZjQjP6Ml66pU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2022 22:50, Josef Bacik wrote:
> These are fs wide definitions and helpers, move them out of ctree.h and
> into fs.h.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Same as v1.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

