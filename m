Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45E5A04E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 01:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiHXX4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 19:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiHXX4L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 19:56:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0455B40E32
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 16:56:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OLFpC9004472;
        Wed, 24 Aug 2022 23:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0aCD8QYryddL5Em6Aaq60QIZxQljcVSbvuFQdDYnxbk=;
 b=b+HfUzuCn1XR3riCb0MyDYL01a2XfmXEXFmZctYMAW2iuOgnHRcDXGFWwaJdlU/JvlFR
 RWu90e+Y+9vnGAh08manKR0XOGBu5pCvgecTxuvk+3m3x40zBClXQhO2anE5p8QvotHu
 g2rfkw5o9jt+qC76M5pjhJfPVOz/e9xwAB+e4wWFmtjTjyo6jK34JNo7rkGbZ5kiCwCz
 8vWrKaAe4eMtzm6OUe3VoWu1K8DimVvsf4pZYZYNfzzB1OlTYlVEv0a09OyF/4omeauZ
 lsOCnuXfH0cTzQH7KWZ4Az9qz/WcFucXWwJ08OgJdtUap3FFrOyYYL9090wGHtXeqpI1 uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nybd5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 23:55:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ONKM8h021760;
        Wed, 24 Aug 2022 23:55:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5nngd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 23:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEPz+FkZoKxMuvZNWNrqMDHJrMspKIrINO8JmD86UpxkWnxLFwwUR0MXn5rc42wOMdNFPyuEeXYUX1AG88ula+ybWLjIDnnw21v+MGYMOVRnyJrTlSmBM2GsSQlmYO3O6VqjsWya91HwLx6hszv8UVP2tAotcQaQtIJBRFVgd7CneSxobZW3DiveOLOGhoneHIvx99jyQt2Fd1++m6aXpVRGWtSKGmVzB2Fc68yv4Ymvnt1Rsgl2pQs/QWJwfCKbwE4HRaJyfBUAtfEbg9SKHy9zgkBiNFNE3EJ79wzgML+FipExMfzbJQDwFepvapeO8XwKvV6RZ7l7TP9bN80pAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aCD8QYryddL5Em6Aaq60QIZxQljcVSbvuFQdDYnxbk=;
 b=hQHBd9vAuJyHSPIUrzFgD83qMCOytz52jmFRCOMBd3DsNxnJbLz31aWINEtTAwHxLSUyY2Tv1wtpvi0Yyf9sE/2XXWaJWtdQk0eniZyimGa7o7byXiwq6RMGnlUd6kigGqlARyWdxuyug7L8NFssSnEoprQ1ImFb5jRKfOQNeQm7ko+tYWLcSHEum+vVyS6Dz9Ab7AK/2gVISQVPT6Ngl1CCa6bGsXnKvYUatR4EWtArIW3adGv+gs5awUi7oA6r2uIibVPkoBlfqlIohb7ea9uhtnKYTO9dRiDUWW0+T85tF/DLeBcNzVvDJljoMzM9x0rk2kNc5xqdeMZKmI7W+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aCD8QYryddL5Em6Aaq60QIZxQljcVSbvuFQdDYnxbk=;
 b=GfOntqNMZeiRFUVhNMMFGMMXCThlzHS9mIsiCHMaJgnxYZ6tzHivKtdsXm4PnS/e9yKAll6AiywKL6K7JqFdyO+Af/jJ5wy/AEbM2dbdbf1a0OlXe7VVz3xQoY6DEWOYQR70JKinUvY4w6LpU8ynX1+4NpP9biO6XYcG2jAt03g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Wed, 24 Aug
 2022 23:55:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd%2]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 23:55:54 +0000
Message-ID: <7a0a875d-c3de-2f65-65c0-9750b6e1d9c1@oracle.com>
Date:   Thu, 25 Aug 2022 07:55:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@libero.it>
References: <e0a051edb23223036ebe21a01dd5d9ab63e54cc9.1661343122.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e0a051edb23223036ebe21a01dd5d9ab63e54cc9.1661343122.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fffe440-1fbd-4448-1106-08da862c2e61
X-MS-TrafficTypeDiagnostic: PH7PR10MB6204:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CChOdhnHZhngTsTZW1Jp8BF91v4GE5HO2Sl3AELILyZZ6IAzpOryZd1utxMEwN7za6THvwhgtV3oAkP75hdAIsXxlmkpOTBvTzRkkesdWtAew7epye+MTdGBub7ogY0SZw63JWsezWCG7ej27cI45PoOk2am0P5sgve1wABViUoNWKh/m0PB+cGMafWHDeFq54wkKfPhRiRTbKSEnhPEBLPUbYifSGFVxobLAjCSvnkrMJZcE7ywzgeZqg3psOsawgwZK5fPZ57/rM6qtZk0IYdCCSLbh0O525m7jguZro2GyqbNAfQakc/uRuIv+p/RsVBG+sFltrfRwlvPVEGDHs/XBKJKbcATBSJi6NSxReGdAdt0G9yTB5kG4bfgD4G7GUuQf29JplXNCQoNEgvCKqjcmXXs0MEJetg1yy1dHlUPJEPxqy16+aHuSgtevFcR8R2VTLUVI07Q7MI8Vm5M4DFq98rB0sp1E7xEkg7OLPuyme6jHqHEYsN+yQ6dJcLaA4jreZuAS7HDU5uijXW+Q1JQsMCF+HCVkI5NNP6qxuPtkRU0gr+y7Zx+XYyyeRlahT1PRr2TkWGIUObztjkwmLSZVpsAT3dbqMBWOyexLNww5WMKDvScbu3MaJoz7LxPon6QhXuLR0siu/0JE4B1hC5h/yhIuXvqIVKVMGLHke1qKP2hZnofrTjNPxGp1nVXablrjGktUgadZlH1NGrM7lfj90SPIcRz5HhNPT2o9QwF9CdaOo9p8aPHRaUFaHzl795FfohTjCjZQCjYiQVI5VkjGd0Teky5RcSLDXa80KyFtlnh351YxHn3gNJH7rjX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(6512007)(6486002)(83380400001)(186003)(966005)(26005)(5660300002)(44832011)(2616005)(8676002)(4326008)(31686004)(6506007)(41300700001)(6666004)(36756003)(478600001)(53546011)(66946007)(86362001)(31696002)(66476007)(316002)(8936002)(2906002)(38100700002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm4zbko5UWhBc2pEYS9jdThhbnhhOXhWa3lsdFp1NUtpMjVDdzJ4cG93WTMx?=
 =?utf-8?B?K2g4cTUwRzZwZ3ptODlwaStFRkNxbndxSkFiSWl4cWY3T1RxUzlqbTMvOUdX?=
 =?utf-8?B?cVZXRTZHYk8yS0lKa0pnNDg3WE1YMEtSa3I3N3dSS1ZkelRZZmpRQVQxaWI4?=
 =?utf-8?B?VzhHTVFEV3dreGkxeFZFbjJNdm9PSUl4TGo5R0x3VWU5WktVNGFta2tHdFp5?=
 =?utf-8?B?U1BNOEVTWDZySHNTZ011MXBXRnRRdUgvcWdudUVQUmFRdG9ManFHcE5lZW1n?=
 =?utf-8?B?OUFKS2FhOFlvNlBJKy9ZK1VFZ3ROMnZLdDlIOXZHSVhERVZ6SWJ2ZXA4Zlk3?=
 =?utf-8?B?ZEcwZkgxYWt5N0g0a2lGdVQ2dWYzL0Y0WllhblFWZmtTN3BMaWVIdjZ1UUlE?=
 =?utf-8?B?VGN2ZVRtOHdoZ2JCb25ETFZVYUQrbGEweWpJT3l0VUtKK0dPVEUvTy9WYlR0?=
 =?utf-8?B?dEtVbG52U3pJYlhLSHIvbzl1TGQ1SnNsL2dYQXR3V1ZyczZXbzdvc1RlRTRG?=
 =?utf-8?B?dG0yMFUrVGlieW5Ea245cG9nc1RZenMvRHBKZnNpY0tWQzAvSDZQZ2hJL1F1?=
 =?utf-8?B?cEY4UDNwclFPUmFVbDFrSVVmM1gra1VLSmZ3bzBYV0VzVVBINFB6MmlIRDBw?=
 =?utf-8?B?L2RFOGZuSHBmNDN5Qlg2YjErQ3hBU0NBbS80MitsZjd0UzA4ZFNZSTE4L1BC?=
 =?utf-8?B?eU50TUV4SEpIOGNNMHJocTl3RXFabzhZMXE1ajdjckk3YS8zK3J1T0ZFdGdm?=
 =?utf-8?B?VVNrUkxpdzk1M0ZIcytBcFNNVkF1VFdBMmgxSjVIRTdNellOMll5aEpXMDdh?=
 =?utf-8?B?VkhwSDNzc2JkcEt4RGVhd3pWaysxRmR2TDJyV1lBUi9PYys3STBTUGhCMDBE?=
 =?utf-8?B?YkdFUUJVVU9RaWhZNFhvNCtsMGZVZmhMQUxxTWVuc1J0b0w0U1ZndlFod1Bz?=
 =?utf-8?B?L0tmZFdydUNzRW5pUFBrYm5admNjMzlucjZ5Q3JwbXVydG5kVGJmbDZYV1kw?=
 =?utf-8?B?UkJkK0dDSEM2SmFSa1pvQlBHNHdsOTFNYW5TdlpBZHhYcXNOeDFCMUl2aGor?=
 =?utf-8?B?akJhaEI3VzVoVmM4cnFhREZVVnlOdnoreEFJYTEvMXJCMDVaYTVZQXpiS1VX?=
 =?utf-8?B?ckl1eGh1YkJTRGVrYmNJRnJ4N2h3T2ozNG01N3l4VVRJOWo1TUlpYmtnQzVK?=
 =?utf-8?B?azkyNnZWTE84N2dQbGhYNW1vZXJidzkxMEpOOWFHYlNrdTVieVp2ZzliY1lT?=
 =?utf-8?B?eVRaQjRnRnlUZ3dkcFZneUtteWJxWUZXZXN5Y0tLS3haNERPYUdPblcrazZa?=
 =?utf-8?B?eXBuRGZwQ0RDdVhDTElwc1hXVTVGb0M0am44bmY0OUVrLytZU0NzVTNKK2ZS?=
 =?utf-8?B?cG0yKzRlSjZBaE9IY09EbkVZaHEwRHoxT2duZWlvei8reEg2VHRkV0wzcmJr?=
 =?utf-8?B?eSs3aHVIY2pZMHA2UE9Dd0NPWjg4UjR2OTJCSFp1OCtqQjczYlpLbytZZzhs?=
 =?utf-8?B?Z05ZYzBBM0pYT2I5enZ0anJ3RHVmK3pXVzB0T2RiWnRhQXRaRmlEOGY3L1VF?=
 =?utf-8?B?L3RLLy9xTk9tdlR0RTRnNDAwZmNMSmJReEg1dm5rRXhwU1REeWRJU1BVTzZo?=
 =?utf-8?B?cEdrUTZIamprRGJSd0ZGVGNlaG5MWkMvQzJjc0xKRGZnQjh1VGZYQStiQ09o?=
 =?utf-8?B?WUhBQmhVUDhnbEdmSFQ2MWlqaE5zcVlyRis0UzRScUxVK0hUVUZnRlU2bFFC?=
 =?utf-8?B?Y01ycm8wUlpuTVpML3I4SEZmYWRyLy8xc2hFeUkrVjZKVjl1NHNSclQxVkU0?=
 =?utf-8?B?OU9PeUs2N09OaXNSWnZLaFNVVERuYk1NT2xQWTgwTXBWN1VxKzA1aWtiQjVX?=
 =?utf-8?B?OGlJNVJLVnZiSVhYVVZWSEhzSllLMGhWYnhaRkhJeWw2aEViWmVwN3YxVTVN?=
 =?utf-8?B?OHlYSE00M3NCczc0RlQ4SU9lbXpnUWlCTDRlRHR5YVMxbmVVL2ZIclVicFJr?=
 =?utf-8?B?Sm1PaS95ajdQejBVZmVSZXVIazVtclBkSm1vRFZQYXBDVFVMcWlrUFNCYzBE?=
 =?utf-8?B?aEcySTJmNmkzTDdpbGtYbXlYQVR6TUVRTUNiZlIwbmRjc0hFQ1lIZ0NiQnNQ?=
 =?utf-8?Q?Ho7S0jSGvzGolBteq7qMhypTc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fffe440-1fbd-4448-1106-08da862c2e61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 23:55:54.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqvrNFWyvn40bxWUggl2u0uDxisV2OSQvFAHsSRPtsXJOB5pFs6aowyreJPdh8/R3o/+3tZPqvrixzXxMpZ26w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_15,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240092
X-Proofpoint-ORIG-GUID: A1uQR9P1AQdL6ZgKFA1GK8bHz0fBfkKm
X-Proofpoint-GUID: A1uQR9P1AQdL6ZgKFA1GK8bHz0fBfkKm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/22 20:16, Qu Wenruo wrote:
> [BACKGROUND]
> There is an incident report that, one user hibernated the system, with
> one btrfs on removable device still mounted.
> 
> Then by some incident, the btrfs got mounted and modified by another
> system/OS, then back to the hibernated system.
> 
> After resuming from the hibernation, new write happened into the victim btrfs.
> 
> Now the fs is completely broken, since the underlying btrfs is no longer
> the same one before the hibernation, and the user lost their data due to
> various transid mismatch.
> 
> [REPRODUCER]
> We can emulate the situation using the following small script:
> 
>   truncate -s 1G $dev
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   fsstress -w -d $mnt -n 500
>   sync
>   xfs_freeze -f $mnt
>   cp $dev $dev.backup
> 
>   # There is no way to mount the same cloned fs on the same system,
>   # as the conflicting fsid will be rejected by btrfs.
>   # Thus here we have to wipe the fs using a different btrfs.
>   mkfs.btrfs -f $dev.backup
> 
>   dd if=$dev.backup of=$dev bs=1M
>   xfs_freeze -u $mnt
>   fsstress -w -d $mnt -n 20
>   umount $mnt
>   btrfs check $dev
> 
> The final fsck will fail due to some tree blocks has incorrect fsid.
> 
> This is enough to emulate the problem hit by the unfortunate user.
> 
> [ENHANCEMENT]
> Although such case should not be that common, it can still happen from
> time to time.
> 
>  From the view of btrfs, we can detect any unexpected super block change,
> and if there is any unexpected change, we just mark the fs read-only, and
> thaw the fs.
> 
> By this we can limit the damage to minimal, and I hope no one would lose
> their data by this anymore.
> 
> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
> Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

A nit below.

> ---
> Changelog:
> v3:
> - Use invalidate_inode_pages2_range() to avoid tricky page alignment
>    Previously I use truncate_inode_pages_range() with page aligned range.
>    But this can be confusing since truncate_inode_pages_ragen() can
>    fill unaligned range with zero. (thus I intentionally align the
>    range).
> 
>    Since we're only interesting dropping the page cache, use
>    invalidate_inode_pages2_range() should be better.
> 
> - Export btrfs_validate_super() to do full super block check at thaw
>    time
>    This brings all the checks, and since freeze/thaw should be a cold
>    path, the extra check shouldn't bother us much.
> 
> - Add an extra comment on why we don't need to hold device_list_mutex.
> 
> v2:
> - Remove one unrelated debug pr_info()
> - Slightly re-word some comments
> - Add suggested-by tag
> ---
>   fs/btrfs/disk-io.c | 25 ++++++++++++++-----
>   fs/btrfs/disk-io.h |  4 +++-
>   fs/btrfs/super.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c |  2 +-
>   4 files changed, 83 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e67614afcf4f..bc94feba2fe3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2600,8 +2600,8 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>    * 		1, 2	2nd and 3rd backup copy
>    * 	       -1	skip bytenr check
>    */
> -static int validate_super(struct btrfs_fs_info *fs_info,
> -			    struct btrfs_super_block *sb, int mirror_num)
> +int btrfs_validate_super(struct btrfs_fs_info *fs_info,
> +			 struct btrfs_super_block *sb, int mirror_num)
>   {
>   	u64 nodesize = btrfs_super_nodesize(sb);
>   	u64 sectorsize = btrfs_super_sectorsize(sb);
> @@ -2785,7 +2785,7 @@ static int validate_super(struct btrfs_fs_info *fs_info,
>    */
>   static int btrfs_validate_mount_super(struct btrfs_fs_info *fs_info)
>   {
> -	return validate_super(fs_info, fs_info->super_copy, 0);
> +	return btrfs_validate_super(fs_info, fs_info->super_copy, 0);
>   }
>   
>   /*
> @@ -2799,7 +2799,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
>   {
>   	int ret;
>   
> -	ret = validate_super(fs_info, sb, -1);
> +	ret = btrfs_validate_super(fs_info, sb, -1);
>   	if (ret < 0)
>   		goto out;
>   	if (!btrfs_supported_super_csum(btrfs_super_csum_type(sb))) {
> @@ -3847,7 +3847,7 @@ static void btrfs_end_super_write(struct bio *bio)
>   }
>   
>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> -						   int copy_num)
> +						   int copy_num, bool drop_cache)
>   {
>   	struct btrfs_super_block *super;
>   	struct page *page;
> @@ -3865,6 +3865,19 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>   	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
>   		return ERR_PTR(-EINVAL);
>   
> +	if (drop_cache) {
> +		/* This should only be called with the primary sb. */
> +		ASSERT(copy_num == 0);
> +
> +		/*
> +		 * Drop the page of the primary superblock, so later
> +		 * read will always read from the device.
> +		 */
> +		invalidate_inode_pages2_range(mapping,
> +				bytenr >> PAGE_SHIFT,
> +				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
> +	}
> +
>   	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
>   	if (IS_ERR(page))
>   		return ERR_CAST(page);
> @@ -3896,7 +3909,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>   	 */
>   	for (i = 0; i < 1; i++) {
> -		super = btrfs_read_dev_one_super(bdev, i);
> +		super = btrfs_read_dev_one_super(bdev, i, false);
>   		if (IS_ERR(super))
>   			continue;
>   
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 47ad8e0a2d33..aef981de672c 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -46,10 +46,12 @@ int __cold open_ctree(struct super_block *sb,
>   	       struct btrfs_fs_devices *fs_devices,
>   	       char *options);
>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
> +int btrfs_validate_super(struct btrfs_fs_info *fs_info,
> +			 struct btrfs_super_block *sb, int mirror_num);
>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> -						   int copy_num);
> +						   int copy_num, bool drop_cache);
>   int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>   struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>   					struct btrfs_key *key);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f1c6ca59299e..0857265ea8d8 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2553,11 +2553,71 @@ static int btrfs_freeze(struct super_block *sb)
>   	return btrfs_commit_transaction(trans);
>   }
>   
> +static int check_dev_super(struct btrfs_device *dev)
> +{
> +	struct btrfs_fs_info *fs_info = dev->fs_info;
> +	struct btrfs_super_block *sb;
> +	int ret = 0;
> +
> +	/* This should be called with fs still frozen. */
> +	ASSERT(test_bit(BTRFS_FS_FROZEN, &fs_info->flags));
> +
> +	/* Missing dev,  no need to check. */
> +	if (!dev->bdev)
> +		return 0;
> +
> +	/* Only need to check the primary super block. */
> +	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
> +	if (IS_ERR(sb))
> +		return PTR_ERR(sb);
> +
> +	/* Btrfs_validate_super() includes fsid check against super->fsid. */
> +	ret = btrfs_validate_super(fs_info, sb, 0);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (btrfs_super_generation(sb) != fs_info->last_trans_committed) {
> +		btrfs_err(fs_info, "transid mismatch, has %llu expect %llu",
> +			btrfs_super_generation(sb),
> +			fs_info->last_trans_committed);
> +		ret = -EUCLEAN;
> +		goto out;
> +	}
> +out:
> +	btrfs_release_disk_super(sb);
> +	return ret;
> +}
> +
>   static int btrfs_unfreeze(struct super_block *sb)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> +	struct btrfs_device *device;
> +	int ret = 0;
>   
> +	/*
> +	 * Make sure the fs is not changed by accident (like hibernation then
> +	 * modified by other OS).
> +	 * If we found anything wrong, we mark the fs error immediately.
> +	 *
> +	 * And since the fs is frozen, no one can modify the fs yet, thus
> +	 * we don't need to hold device_list_mutex.
> +	 */
> +	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
> +		ret = check_dev_super(device);


> +		if (ret < 0) {
> +			btrfs_handle_fs_error(fs_info, ret,
> +				"super block on devid %llu got modified unexpectedly",
> +				device->devid);

We may fail to read the sb if the page does not get brought uptodate, 
read_cache_page_gfp() returns -EIO.

check_dev_super()
  btrfs_read_dev_one_super()
   read_cache_page_gfp()


But, the above error log is misleading.

-Anand

> +			break;
> +		}
> +	}
>   	clear_bit(BTRFS_FS_FROZEN, &fs_info->flags);
> +
> +	/*
> +	 * We still return 0, to allow VFS layer to unfreeze the fs even above
> +	 * checks failed. Since the fs is either fine or RO, we're safe to
> +	 * continue, without causing further damage.
> +	 */
>   	return 0;
>   }
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 95a2eaf8a958..5b2cafafce2e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2017,7 +2017,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   		struct page *page;
>   		int ret;
>   
> -		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
> +		disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
>   		if (IS_ERR(disk_super))
>   			continue;
>   

