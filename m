Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB76F558C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjECKEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjECKEI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 06:04:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA9A10F3
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 03:04:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34376fmq014458;
        Wed, 3 May 2023 10:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IQI1vrclzGWzBZYc6eE4fRQAYsynFT2vLfjl0rGWIcw=;
 b=HPF3n9fZENJELXPqqaF2qlaGNN/JkrPYRYM/Z3u1DKK05PzOPojuDer2TuS97m1fkkZm
 O50JZ0XbwFRM6zPqfVL0wxmHFQC5DDSkIqenkQ1BkluUMTXIdHGg/Ih66LXWtoyAedi/
 RgSwKS6lzoRQedOPuHcDcbqTPfwFmuzo/y8jBQZmSeEpbTFDqoZ1TY61yEm9k1NdLdtY
 wi6gkdrW6uA7dKc4UGPdltJ6crvMa7MGiNxZku79gZ6IV+R7jXnZyhIovvcvhqXX2Kws
 0dNH5+Wud1mn/MkBdtQ0d66qFco1f1zROjwu6IrxrKfjRQ3zwTvYmk3J42VSWIWk/7Ek jA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8tuu6wby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 10:04:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3438NZof020834;
        Wed, 3 May 2023 10:04:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp6x1sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 10:04:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfl11tzFLHVFnKdbpRD8lEjoo8Yrv1lMCYwz02WmiqZNwmfgeaQn6aRvRP19stYMkkOpRRRMqbeoqBE8Mwgz1bxanwPdJpD6EPDBpiTvC5Z9x1T1rtRWwjEcidVml7a8yqx0kjEVaMAmOo/Hj12OT/pobVL2xoivgE+rrxnN2QoQvyRiwhYap3825limDFpKeVM+zdZvfV4jH/FW+KoO1J37l0IHXuYRqsJ/LVp7LY8Kprzm1oW/0qlMTfczDefs4cdVncL+EOpLRWz62wh4DjpvURPqgYGNOKX/7yJzuW5fOwjDs0tGpQXHsACB5SPTmqdK9iA+y7QdsWVdHrCMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQI1vrclzGWzBZYc6eE4fRQAYsynFT2vLfjl0rGWIcw=;
 b=I6Pt1cKE4aEwHwkx2th/wbZOKlFY3mmahwcvKE5CvFJN6g0as6BXB1GeAPI98KE0Db3pwmV+Pc6JdELMxfBcFjNVBatGGCIz/IqNFvBTXEMJJAjk84gn0GnNFOBphl3OyUX7hRHpr6Fa/Uq0fSJru7USkCgf3mvwbBBHqsAAMm2qdQagMsjysws1QQgyLpQZXnwbeOnFCdofnDSfMX02iLxmodWSo9eBJWFS/kqrttXhlS3tCCDyl0ic1lbVVq09YjPxtQkkGPPtMHxkbniioblxxv8fX1io+Gqsr8XEcTUUOAG+rFhVJ5Vgxz/2zahr9nhWWnwSX62d34cURpWmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQI1vrclzGWzBZYc6eE4fRQAYsynFT2vLfjl0rGWIcw=;
 b=gPaAw0Z1DuxA2eWfh4proY2CA4S9Vr2srXP1klkGQXHXWjrcFBQAgsFyIaYl0RN7KZA33zoTeDc9FO9sE1aTkqBpOvUZFzpIx6gc1VwAux8jS7BXsLbPUeCD6rUioJCrrcsrvOsr0VZq/UNmwrqRmj93pbdZPUBui6ncwY5dDI0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 10:03:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.030; Wed, 3 May 2023
 10:03:58 +0000
Message-ID: <391bfc93-e95d-7e46-8376-5af042fd5ded@oracle.com>
Date:   Wed, 3 May 2023 18:03:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] btrfs: output affected files when relocation failed
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <ad4e1c92f8d623557458d1968d76f755264e050e.1683088762.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ad4e1c92f8d623557458d1968d76f755264e050e.1683088762.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 618a0f04-cca1-479f-5e07-08db4bbdb606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhInBkF5u2kjlVZNGW6ydEAJBnk0eo0lNWPLiKeXZITzpcwBy4Uo/Hj3Kvq1JZDPWpQW+e3N1sJHLf9yaZ5uU/NHSzUgSi40BvLm4pVBBL7dD5pow8L4m92PjbZ/gwO/WbDhI7O2Am8qjAVTqCg+wTElUPtvI/33Ta5JkeF25pGRKJyT89DvFc/mdegGSN6GDhDQKCkZyHe01Ry4EQr0a8ajwiEa8Pv2fxUQDNK3njsX1yE1OpADjgHqmKb/FNouXfPpsA1RSJPjonKn+DWBiGp8y868N2KMzszP+goddzr2xZqlndLM3wD+x+/SzSqc0IbTn21MlpSlhURqCaBdFDxIUPLbqIZqBnRMoPAS8i9llQv4JH3fPu3uT0kjRqX3wO0LWlz2rWC5YLnRBsHimKofGFRAuVMuNXB8nbkHB7q9YWbhnBcHzd/QfoSCsmFNro7W0df9NA7X77Q2D7ovVJDje55urLzQ2UUPiwSmK7eLXuj4clRUcwO+uJKkRr/SKDdpNroCgIpetypcqGGFM5R4sA1tOAFAR1lOL9PYpN1tpaCr5kUULgFhZu568FO+INTyH1tfHBXgpgB+K/ER4yd0BWOF0LAGOq68+6hrqcLKMzNp2zJk4zjmRX+ksAN3jIRV3MHJ9T4yG40Gdpbncw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(38100700002)(6506007)(26005)(6512007)(36756003)(6486002)(2616005)(83380400001)(53546011)(186003)(2906002)(31696002)(66476007)(41300700001)(8676002)(5660300002)(478600001)(6666004)(44832011)(66556008)(66946007)(8936002)(316002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZPWk9DbDYvR24vTDkxWFBXTVgvR0pvMDltNmZDa1VxMlA0eXhvZlg5a1Va?=
 =?utf-8?B?OGpZbGRPU3pWcFltNk9vZDBQdDljbVlram1tVUtwWTZuZGFkTzhhUExlN1Jy?=
 =?utf-8?B?UFNrOVpEWUlvWlFjNnViMGVNMEY3ZEdSSDhTY1cyM0J0enBTYlEzaEJkcXcy?=
 =?utf-8?B?OVdYODFlOE1vR0RYam9TQmVTSEVNOS9aZXRySXBiZWZBTTNteVRaMHp5anZx?=
 =?utf-8?B?WlBRM1BKYzZPcjk1b2hFMkxIMVpHNHFiNW9FMXYzYk1nMmt6Ui9Kc2l5Tk9a?=
 =?utf-8?B?dEgrZXUyMHRDc3BFK2NTcStqeXBzdWltVGowTi9aRi9xbmFSeFlvRkNDWDA1?=
 =?utf-8?B?MjV0eEpDaVFrNXZlSndkd3R5REtoMEgwcDNVNVA4bWNRZkNtRnVFUHZveWVp?=
 =?utf-8?B?M2REVERHOWsxM3dFckROWkczMWN1dDZMYlJGeHJWTnJ0dXVERUVRVWp5WSto?=
 =?utf-8?B?Y2hrMG9UaHhra0JpTnhjdjYrU21KemFmNGh6S2lUVGZja20wVFZKb3RWSG9K?=
 =?utf-8?B?N3dLbjJpOGxaZ3gvQUY2UG1aZ2E3MUIwZzJpNzNBd3p6cWYrYTFBWDZma1dP?=
 =?utf-8?B?WDBzZ1dmOE9tRHN2N3Zoa3p0NGkwWTVZS2U0ampESm1od2xsSW4wcEU3d2py?=
 =?utf-8?B?dXdHNi9LeVRMRVpHbktxYW1TcUMyNTVvVCt3K3g5T0FzQ1Bka1NKTlExQ3ln?=
 =?utf-8?B?Z3FMcXQrbXliUGIwSkRIM3J0YVBOUUxwNTIyRW9jVW8rR25mS2RQNUFoS0Q2?=
 =?utf-8?B?U084OE5kbW9CcjNIWWR1TFBKTk90NEZleXJ6M0k5YVJodXhkS3dxUndZMmRD?=
 =?utf-8?B?S2lkaHRRVnEzMlMwWXpORmx2TmRFejNkejB3aTRkREZRc1YzeUFDRHVjZitr?=
 =?utf-8?B?dHNNbEhtWTdOSDZVb3RKU0xTUHF2N05aeU1sUk5wNDJxRlgwd0dLWkhBNjJG?=
 =?utf-8?B?L2lzaVJqWjkvWDlTNFBTc1p4NTRFeEZhVmNaMlQ0SGZXci82ekdpTnMreEUy?=
 =?utf-8?B?dEFNZTRMRVkrZmpEUS82V2pZb3FKQzlXM2FETjdVQ1ZqSERXZ3YyczhaeFpV?=
 =?utf-8?B?d0ZQT2RodW5TMXFwMlpQTkxaSnV2cFlpeVQ0cjZNN3lvQTNoWmVDQkVwc1lp?=
 =?utf-8?B?NGpvd1l0bUpSaTljVEV0dDh4MWRxOUNzQnEzZ3RhcElZc3lab3FsK2xsNVl1?=
 =?utf-8?B?MCtPTUJlSGxZMkpLNmlLYUJOMGwzcVJQREhXWFJLYlF2MWpIVjVOK2VjQWVC?=
 =?utf-8?B?R2VuNDhEeCtDRUxXZEJRZjlNNFVwS0sxR3hFd1hDNzR6QngrWWNQejNTNnQv?=
 =?utf-8?B?N1lxRHpBMktrb2RIOXo3a3RBQTJmSjV5aTNqZ2YrTXBYdTJVVHFucjFRL05C?=
 =?utf-8?B?NnUyV3NQTWkvNzE5UUpNenZ3Zk4xRDE4ZkIyS1ZHTkUvTUxJVGhLdGhqbW5B?=
 =?utf-8?B?ZzZaYlJtdFpSZ3NlN25IRjdQMkFtTXNpQkc2ZHlRdjBPeFlCRUhQVW9qaW51?=
 =?utf-8?B?dHlha3dHS3ZwdWpSaXlicXFCaUsrbDVubG1xL0RTeEdjTi9DOFFtQ2VIbE1L?=
 =?utf-8?B?L1kzM3BycHA1eERVMnFadUZZeENWRHo5a200QmFLZlozNUR6aE5PRnhkUTFK?=
 =?utf-8?B?WndTeUZUWkN2NS9WV0U0dDJ3NHZLamIxNCtLOVhMVHFnQnkzbmZpQ0FJb0hV?=
 =?utf-8?B?c3dsNndkeFZmTGxqYTlrdno3T1VGOUlkeEVxZFlxeXZHR0R0NjFSaWFJRGVo?=
 =?utf-8?B?VnRacm53bzBUbHdBU2pXUnZ5clBkM3JjVU1ubit5MWtvWlozMExRc1FuOXVY?=
 =?utf-8?B?QjIyVnF6WmE3ejJGTy9yRVJiZVlhN3FCMXlzTjFiZGE0bXEzWFFrY1NFQTFC?=
 =?utf-8?B?Ym1WUEppRlZIUkkvNGtuT2FRdHNyajNrb1BsUWtvc1cxMjE5Sng4eWQ2cEcz?=
 =?utf-8?B?K3pjUW1ydVRyMTZpSDBKVDY4cHNJa2JmcEVUYVFQUnlFSlhhVHVwRDMvcDNS?=
 =?utf-8?B?YW5RdW4yeW0wdDNiKzdVVmpqdEl4TEJiNEoxMmJXeVBHWUkrN3dYTWVrZjZL?=
 =?utf-8?B?c1hzRHFDcDZnR2Q1VmNrc0VIbkIrakVNYXgyL0R2Ukd5NU1aWk4yUWxaZjVC?=
 =?utf-8?Q?6v2HANOy4kKdTyzJqzFG6oT+u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZZ62wk3MSEalOgbwxerjGBBT6bqU4F4ZbqC9QyBtKEM9QFSumcPZ0l+cmfLucD9yNlWn6eYDGBNgAUKj8upQ2WlVrBJZXE87WpVMaYnkv4j/sb+eu7HT+BqlOjtbP4j4IadxwQJ99w1jhVL6nDEjrWg4Apn31o0b2w5AKk+vAnDD1u1fkc+n5G0NlbyTHml5UYd6l3/4QXI3WXa5PFAlCayK2T6wA9waR5XBQTsJO6Uf+5z2NSqX4xf6g/taqm4uPOTCty5EuC3TVSV/yzV4tY/UDt2wN+sBLbaiA10laGNX/AdvtSE3knp4Zhvm9Z/nNoxWHUi08HGDqtfh64he3YrIik+bOkj/PqTh9zTgo6507zRyDyv7hvavlZVq04pIB3LMkJe6xFNTPlgQ4rDfcn7pxXAKrPnWQmxUOQFs1O5vBnNCrn+OSb+9vHZEJYCzvVjWsvAXAreqHtajwsJj6bX0kt82IsXt82q9vbwrp1zMEpzfxbldIchFpO1ae4lvtM0vFpeOtGLdwIQbBTNS79g7OqlYZlxCO/doyZlDEOO2CeSC7DsDy3wmK8cO35fgjKjxV0I6tv5du4QhCvxLYKuNhFS2txI6OCwx3+1LT5N3YevP4SPYWvEdut2cZQdPm9Ke+fJ4rBUEfEjzhuf6Oz6TkCgZXTeKSJCXhgS0Vy1uwz2tXYhZpxIdzC6kirTu7MT7FyP+5uGVJ4v6Wg+s1JDP2+lmoJy+cRZJLrOQ69XJJZsoj3gdnW0DH+7mD8M3zYauBNmV57SVKrf5Mr17mFW8Y2O5Tfl7EnITJ9St4Xc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618a0f04-cca1-479f-5e07-08db4bbdb606
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 10:03:58.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StNPcr9EvrgNuPgXWQivOZXeN4Bo1hzIk3sIXEF0TWsIi8gaxTK5u2A65BOrvehh7az8nvRDCRIoOQlB51gwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030084
X-Proofpoint-GUID: 3vOTO6aI5x91EwaB_QHWeWN1IOwrHQgy
X-Proofpoint-ORIG-GUID: 3vOTO6aI5x91EwaB_QHWeWN1IOwrHQgy
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/05/2023 12:40, Qu Wenruo wrote:
> [PROBLEM]
> When relocation failed (mostly due to checksum mismatch), we only got
> very cryptic error messages like
> 
>    BTRFS info (device dm-4): relocating block group 13631488 flags data
>    BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>    BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>    BTRFS info (device dm-4): balance: ended with status: -5
> 
> The end user has to decrypt the above messages and use various tools to
> locate the affected files and find a way to fix the problem (mostly
> deleting the file).
> 
> This is not an easy work even for experienced developer, not to mention
> the end users.
> 
> [SCRUB IS DOING BETTER]
> By contrast, scrub is providing much better error messages:
> 
>   BTRFS error (device dm-4): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>   BTRFS warning (device dm-4): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>   BTRFS info (device dm-4): scrub: finished on devid 1 with status: 0
> 
> Which provides the affected files directly to the end user.
> 
> [IMPROVEMENT]
> Instead of the generic data checksum error messages, which is not doing
> a good job for data reloc inodes, this patch introduce a scrub like
> backref walking based solution.
> 
> When a sector failed its checksum for data reloc inode, we go the
> following workflow:
> 
> - Get the real logical bytenr
>    For data reloc inode, the file offset is the offset inside the block
>    group.
>    Thus the real logical bytenr is @file_off + @block_group->start.
> 
> - Do an extent type check
>    If it's tree blocks it's much easier to handle, just go through
>    all the tree block backref.
> 
> - Do a backref walk and inode path resolution for data extents
>    This is mostly the same as scrub.
>    But unfortunately we can not reuse the same function as the output
>    format is different.
> 
> Now the new output would be more user friendly:
> 
>   BTRFS info (device dm-4): relocating block group 13631488 flags data
>   BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 logical 13631488 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>   BTRFS warning (device dm-4): checksum error at logical 13631488 mirror 1 root 5 inode 257 offset 0 length 4096 links 1 (path: file)
>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>   BTRFS info (device dm-4): balance: ended with status: -5
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Output the ino number using %llu
> - Add a description for the new data_reloc_warn structure
> - Use new comment format for the copied comments
> - Use a less serious output message if we failed to resolve filename due
>    to -ENOMEM
> - Replace btrfs_warn_in_rcu() with btrfs_warn()

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

>    As that RCU usage is from scrub output which grabs the device, but
>    for balance we don't need that RCU usage at all.

Thanks, Anand
