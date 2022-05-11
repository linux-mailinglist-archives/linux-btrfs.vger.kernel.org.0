Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A705229EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 04:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiEKCrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 22:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbiEKCkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 22:40:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DBBBE1D
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 19:40:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AL2nLW019308;
        Wed, 11 May 2022 02:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pz/VnKcXNfgv34KnwTMRBUwqKFYC2buPf7HsXSD46hE=;
 b=fLyxxkAMWKnpmX+eZR2Adkw8XZAukBI+oFp5/+PU8Ye1CyFeAawdflt4JOYMqkG863gP
 KbmgBGugYNln9WZGy2Id3Hs41uv2poX94M/SziZUimhs/PWD974VcahkDW/AXelpOAnL
 nOjXxy6KtSqWD+DyTVqNOC8lXsC3pA0O3x44kIqV0Pd1uU/5lO9I3eu/NhZzpkpPKizf
 v5QI3RoZEHVyccyO6Ph2azSoSpLhgqzepBdWHJl+lx74GeczjtbFBaR7lXns2Kn3/wVR
 RzE2BpktwCUi8QmUf5rHDpNq/Khtq9/BX2Fbkbxz/lTWzzDPlYa4fCrUIFP4RcAh0uBV vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9r3g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 02:40:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B2LPNM006289;
        Wed, 11 May 2022 02:40:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf731u2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 02:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R15tLaDLLYxZwPC4BZ170gv9NWbkIZbYzCONiShtm6SDBLMLDpkvBphNvzwFPA5BtDIp2oIrt6kqs3FcJbeiRVvualBk5MMkIOH7XIrp8YVlL1MSgyaDsHcMEKhi7O6vqHLC57mQmjz9Dg63yvqU1wHfg125KP9lD2Tbi/SnAAUMdvPxugbTDHFEc7MfB7CQWucJYmG2iwGK+BnMGhViF9pGKX97HEc/cw3WYD3pZkRXVrsHkyZfDVunxqeObQSddV3kni7fP3u3HTjZlrY9QJRaK/CT0nIPtI0PCba3FdFlmsvrNZrMhmiPZ6oyHSzUlxzFwiSKrh3ljR6VAH9plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz/VnKcXNfgv34KnwTMRBUwqKFYC2buPf7HsXSD46hE=;
 b=cABeK4hOLisb0va/+BIs/NQOu9TP4JkGypW2SnDLT3LbJwusnZ4T6c/G/R80P+B1LbrHxsIn7WE1T2bxTfY1xKD4skJ4VOLy+D5dIMoc5VJwZRQf9Qf+nj+lLFQBQh+CO9JLDCeVgLWug7jP40yIgu88sMl15P9AL/I0AbaKPNgc5u/X6cR8WIEAv3987in+d8ZhtY0hDnda/npWQFIAGdYjZpfKO/L7vm2OfFOlS6d10r5C032rSLxCff6PfjSjxTlcqLer/+FQoaM3thnlWRBl5sTcMPuLk446OTX0dPwI5UvjGPz9CIxwXQBUz6i5s2fapbOQYYt3XCKtkezbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz/VnKcXNfgv34KnwTMRBUwqKFYC2buPf7HsXSD46hE=;
 b=TN4Q1ivEAX+8p8FoelsHWtMurVBvIkHAKNfttIJ9+xqMeIC9PUGMvxWHcON3BvDV+Mmb2RHLrMTxuWGkje+KdAio99Sfm1lXkdi+rKH+4cqVxE+/JmEGjge/Wa9Hj8J/mJBs3QFS7x3PUL6inuxZ0X7FoxnOw0Ye99t+pfgBzLE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4732.namprd10.prod.outlook.com (2603:10b6:806:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 02:40:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Wed, 11 May 2022
 02:40:18 +0000
Message-ID: <efbf9592-364b-d704-0ad0-5a1664da4e18@oracle.com>
Date:   Wed, 11 May 2022 08:10:09 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/1] btrfs: simplify lookup_data_extent()
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Marek Behun <marek.behun@nic.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
References: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5627d2ad-acfe-4b71-e5ae-08da32f795e8
X-MS-TrafficTypeDiagnostic: SA2PR10MB4732:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4732A6F2391A4C7F6FF509DCE5C89@SA2PR10MB4732.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoyErv7rK2FPC2CaljwD5syLdoh9sSmX9fD8k/hG/mP/SvMf+fLAqGoS9eqZcjFFsEWonEKCah9j6mgnSIEzZ6Sb08PAJuR+mQFTRLji2j52dKPCtV6B/Ddh2I/n2NNIPgST8+2AmxWNAa+8B3L3XPLQBO7jk1EMNMk6J1SCKclPS6i0UEf3FfO8+s1p5RyocCH/EaZJURStSMxc7xDLmnJE1PuLej4senCXbcqkshsLlndFNBbVHWVxLO5aVMFjPHowa+RccOJ8rx75mivBx8qwUzzigbkPXYBLM4Ee7xaba0wdUmHHQJXKAJcAsi7NR677vsrZzotiFqiYkcueaX17WNFhH8dM5DWTRVbGtCcoGZzQiuHJQw+ebJxu3dKCnpdSysToUU2SWVVYHWh0X9iNNeXMKUJ8Buytu76t4yeZhlBGRo9VcOjRnMktcddTQcr5TZa7J4vOCbvZgemwBAe+AIWCzZxWz7WmZ8GVJ6F8EArOcNl/tUuS+laHJvicp+A6+MZQIeitHWjaBoAkPudVSuLaB0i8B+tahT/mPPySzM/Jg45flyA4H8CCk1shh9OPAYm2a+4TbbxcSpdjO0lSm10NnAKiK1KoJvpba3+cgeCmrNwUpLpnnyzlYBmgSz62xgJHDCwa3+p6phpu+WviKyAgOAVpR2eIgUCLSTYmEc6WVcnmzSN2WWkhTnGWrTvbCl0ii0PtXOYxNEMoN4pN4qZcoSqBXH3Vz35cXIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(86362001)(8676002)(4326008)(31696002)(2616005)(44832011)(6506007)(53546011)(6666004)(2906002)(83380400001)(6486002)(8936002)(38100700002)(316002)(508600001)(5660300002)(36756003)(31686004)(186003)(66946007)(66476007)(66556008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkg4SkNNTy85Zjh6ZkhZcTBCdTB2NEhUc2RkdmtCM0thVlk2WU1DLzVTN0pF?=
 =?utf-8?B?Tk40UDFwb0xBVnNRM2w1SXlFcUgrUFZVVGx2bGVDd1JVS2s4cmYxMW9kL09H?=
 =?utf-8?B?UTgwN1J2T0p3R1ZxRHdKK1FFZi9TOHNMVk8zY2x2aU02dVNOSDU1RWpMamo0?=
 =?utf-8?B?WkVGTEVYbUlCck9EY05UWnBYb2J5MUpoS2p6UEVkTVExMHRSVUhRd2J1bXR5?=
 =?utf-8?B?bmh1YktYVk5aWWMxbXRwM09KQXh0S0p0TTA0SnBtWURpYXhqTkZUTnRmT3Fa?=
 =?utf-8?B?M3hlaDJEN1JBNHBuaWRzbklyNXJUMWJtM0o1RHBoVmg5dWpJOUM2ZklKemVM?=
 =?utf-8?B?NEdWYW9JeVJYK0VUZzNxZVY3UDRDU3NRS3k0NEthbFNlaDVIUmM5akZZZTRX?=
 =?utf-8?B?UG5pNGpONkpCYXFpOXc2SEJQaWxmT3FLRWVpaUZOT0pWTXVlQTVCWlppQmZi?=
 =?utf-8?B?ejErYTdXNnI4WWFwVTdqM3lVNGJBWTZibUdsNndJYXhiRUVIWTRrSSs2YWdB?=
 =?utf-8?B?TFNFSkpzNXNxZkhjZzIvcGlxdFRodHJvb2diK1QvWDRNaFJnVSsyVlo2OVJo?=
 =?utf-8?B?QXRwYlJ3cEYxQ3FmVk5SNkMvV3lqSHI1NkdhV3lqZmwyby9kNmtKTzk2S3Z0?=
 =?utf-8?B?dGxKak9GbFhhWHRDR29QSmNZNXhDbWZDUjQ3YjBuQ1p4cG1SQ09XM05SQStY?=
 =?utf-8?B?bkZZYlk0ZG9wcWZPSklxNXFBUityU2UzQWlBbXMyU01vSmxyYnpSM3Zxc3da?=
 =?utf-8?B?Z1B5QlVGRHJWSi9EZW0rVks0bTIxb2N3b3dSMjJ3WGxvYkM5MEV6RzdyNUtG?=
 =?utf-8?B?V0tUalF3eXliYzNPNktJMzFLb2JZK0srdUNPNHg4WTlRK3U4UXlubTNOazhW?=
 =?utf-8?B?aWJ0TFY0djd1Q3NsRDE2ektURWcyWEVYVFRqZFhLd1Vldk56TFN0czFNVTNH?=
 =?utf-8?B?NXM4NEJ3TWlHLzFPWXlYZUlxRnFnRVBJWk1QMnN0b0NTcjNNUUNyS0VJRmV4?=
 =?utf-8?B?VU5FUUNRVkV1L0VKdVBMOXlyUFhJRDFid050ZEJyTWhiUlNhWkpKYUJkY21V?=
 =?utf-8?B?ZnU4S3dVaHZjUmFKOHE0TlNxNGthT0JKQVg5N1RqV2lIdHZJOVYxUmpWeEJU?=
 =?utf-8?B?VE1zdjA0ZXNjQnlITEowckROT2MxamJzRTJoeExiVzU1MXRYenJsMitjQkhh?=
 =?utf-8?B?RW5hckhOZW11dnBha252TlZCN1ROTUcwbVFUSGlaK3JSN1FSNGpFYXUwbVMy?=
 =?utf-8?B?cmJId25YM0I3RFpSWStqd25QMzBlVkY1TXZuQU13ZEduZVhSNGxzUnovNmEw?=
 =?utf-8?B?dVhqN2ZMODBibW9md3JjbC9GN1Uwek5qVlI3SHFpZ2dHczUzK2hXWVkvRkh2?=
 =?utf-8?B?bExvNHp6eFZVOElIM05PWmNOaEZvY25Bb1dDMDVBVFFUMzBoTEdTcFNxYlpJ?=
 =?utf-8?B?SHpLMnhxYWRhMThncEQ5Tjhac2luNHJpaEV3S1NYMklHVEN2ckkzUy9Xa2Jj?=
 =?utf-8?B?eFd6YXRSbGluZU4rd2tuZWc5bXJmWEUxSnMvbmswRDR5a2tHbmgyRFRCR0I2?=
 =?utf-8?B?aUE0NjRXVjNIY3NnWkMyLzM0bHhwMzlxUW5qVHR5ZnpTQTkrdXY1OGl6MTl5?=
 =?utf-8?B?Y09GYlpOai9UeGx0SFlEcjIwY3pqQTk4OWd3cUVjbjlvWGplN2xBREllUUNp?=
 =?utf-8?B?cm5sMWIrLzFJYWFjeTNhUFNwcUovM3JUbHZsNDRtb3lwMnoySXh2ZHBUVlQy?=
 =?utf-8?B?aUcrSHF2cVBEcVZuSW5DUXZDZzUzTk1kSUpoSVVPZ3JxTXYvdm1NbGhwNjd6?=
 =?utf-8?B?dlZiZWJTV1hiUEZlVmVXcEEwdWdBdlZZWXJDT0VVdVVrQVVicFM0YUl1YkNy?=
 =?utf-8?B?UWF4QUU2TmhwVVBhRDM4UWJoTGg5c2JkQ1lSNmc2SHV4ODBLME1FRjJQUkQr?=
 =?utf-8?B?dllpNHFpMTlaUmNrc05ZdkkveUFicEpKd3RjRzNwdisydWVzbGRaSlZjZ1Za?=
 =?utf-8?B?eEV0UmdONW0yTC8yZ0JMc3BuSGpPeDdCMFU4Z3QyL2c0ZWVzUXE4d0VNR3E0?=
 =?utf-8?B?azRqYTZIVXg1N1cyS3dwRjVINUgweTN0ZCtLdk5iZ0M1VVBvNGtFeFQ1TnNF?=
 =?utf-8?B?eXhhUTFTVkJLY1VxekxhbXo5dmZPVUx4RzZSbWF3QlYzUi9MVlpKYkk4VmNv?=
 =?utf-8?B?VGpsV3hxc05lNnQvSU5KOG4vcEFLRytkeGtPVWl6S09aNVE2aUYranBOYTA2?=
 =?utf-8?B?aFYrN0dNejZjUm5VVW05RDdsK05jMUdYSFNpTnpiUy9LUjNITmdXRHNhNVVT?=
 =?utf-8?B?eExUbFpVVDZubU84QUxDRnhqdW96dGt5ZTYyeVkyWUNqbTBtZ05sUkFsYlRL?=
 =?utf-8?Q?yBaXwYNwgTg1dFvCCWfA8FYJhrTB2vZSPCx5wMApVkIfO?=
X-MS-Exchange-AntiSpam-MessageData-1: DjD/mlvtZk3/c6SATOIBDjzz+IktHoyYfKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5627d2ad-acfe-4b71-e5ae-08da32f795e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 02:40:18.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd1khg8q5aaA1vbSOMW5DhwnSPcWrohXk2KqQTGFusV6pfZhO72Q4ujO1etIo4F9jk2MiEn6pl59n99v6tSoIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4732
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_07:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110010
X-Proofpoint-GUID: rh-YJqEzjMB-NYsB75R0vklv7n3e0EYw
X-Proofpoint-ORIG-GUID: rh-YJqEzjMB-NYsB75R0vklv7n3e0EYw
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/11/22 01:13, Heinrich Schuchardt wrote:
> After returning if ret <= 0 we know that ret > 0. No need to check it.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Anand Jain <anand.jain>


> ---
>   fs/btrfs/inode.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d00b515333..0173d30cd8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -546,15 +546,12 @@ static int lookup_data_extent(struct btrfs_root *root, struct btrfs_path *path,
>   	/* Error or we're already at the file extent */
>   	if (ret <= 0)
>   		return ret;
> -	if (ret > 0) {
> -		/* Check previous file extent */
> -		ret = btrfs_previous_item(root, path, ino,
> -					  BTRFS_EXTENT_DATA_KEY);
> -		if (ret < 0)
> -			return ret;
> -		if (ret > 0)
> -			goto check_next;
> -	}
> +	/* Check previous file extent */
> +	ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		goto check_next;
>   	/* Now the key.offset must be smaller than @file_offset */
>   	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>   	if (key.objectid != ino ||

