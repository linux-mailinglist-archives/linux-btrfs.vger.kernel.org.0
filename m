Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DBC58C77C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiHHLY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbiHHLYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 07:24:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD93BC0E
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 04:24:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ASrBW006627;
        Mon, 8 Aug 2022 11:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VF/mOR3QvbZQDsrpYxQl09sFGQ0DaAolfuSg2hQ0gZo=;
 b=o2Byv8tB3Yk9o0UJsRXjzxU/IRrpCSADMHk0orfUD+/k9XVThFx0JEwQ69KR0SNbJG6E
 cUxJwJ1jlUfknSDpAmotVxVeUW4m8gAaCPjzr2FocJfM3kqbkUWRChKDdN4nIQdTj0CA
 29irciU1m2j3BP7jSYYVLxLdlXugbm7A9pXHenv64QX63J6QOYkOD2CbhlVhkRrVk56G
 Bhq3sdk8XL8McqY6NWOUc1h6UPepxNXMT0/r1BjduBZNT16sxww2HAzt3YKlGCLL0k2Q
 W9Ljiy7MBTmeveBdf+7R3OGdy4PoUswIza37n8v9GNMRSHxmvxusXhB0boxk214YlcTA 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsew1391t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:24:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278AK2VL027988;
        Mon, 8 Aug 2022 11:24:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hu0n2h6nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab0nr/bBtzWgWf18yxPzuusj20U/cFpcfPrUzLmSymW5FUDSh4aIS0VhLFQBmgBMsCm96O7q79IiPwW0v4henkSXrs43xHnhBKcQz/ZRq5xz6YiAoA7OwVB9xIPYi69kp5WUskj2he1QCjlkIjefIM58+/seOaFYbzZgBN1Fps4XrKrFXzE4l6n8giJTj/PiiC4UHf0kFVx+RgzFfWLHhwLOWxU8cnrRkOXZshZ/jWGJOkyTWRiM4jdXskS43+Wn/0DYPC7PIpqScc3iBuBHpczgFdum13NFpFpcocDfkendeHiCrcHFskMD5SMzUl+ydzPJO5f/SqCK92kWFW3rJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF/mOR3QvbZQDsrpYxQl09sFGQ0DaAolfuSg2hQ0gZo=;
 b=QzHqFlLfpa3LiqoTFETwDKZkgXev6jFBaTyA9wTSkIGnAHUr+kaRtU0I1cn+bRVlz4ZBkP+3RrP805JCPoeTBbUkslowMiSXcb0uwfNLrQabAMrJrwthQR05lO3x2HNAjH04fIx5yLbZgXL7Vb3pYtIZA8wdAtzv0p3gq8m03+1SQccZiBcuPR8wpfBbzIz+6EnhKY1SxEsQTuPkBJ+rsWLqObh3Wr+ZZUQhWrdeMmx0uHW+2K6REWr8742UmaQ8RjF+DEExsgOhC6+hSseI2poGb7FkPAt3AsSiL838BV/y3vg2uGqfuOdnju9dID5CjfkwtUbX8Sr64PipB9ipZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF/mOR3QvbZQDsrpYxQl09sFGQ0DaAolfuSg2hQ0gZo=;
 b=UGlEdBzOwLWjNA4bZYVJDeuJJ65unrCzjLFEoO6jB1IFKmTGRBdShlkyopjm4C8zNu+QJJ44rYZWeA/iw6pGBS+AYxBzGqQyrDZbunuzj1w4pZM/1ASfb/pofQGrBjSkf1aNX6YCD7rEdxEgVN+1O6nI3M0J11f8P3RRkv1Kq1o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5233.namprd10.prod.outlook.com (2603:10b6:208:328::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 11:24:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 11:24:10 +0000
Message-ID: <d60aebfe-1895-12d5-86cb-22111ee0360a@oracle.com>
Date:   Mon, 8 Aug 2022 19:24:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 01/11] btrfs: don't call bioset_integrity_create for
 btrfs_bioset
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-2-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38dc353d-9798-4c1e-71ab-08da793083b2
X-MS-TrafficTypeDiagnostic: BLAPR10MB5233:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOkWQSZRcI69CdaR3pOtrkl30N7rdjF+nY42H92Wyy6YTO3iWIT8CzEdmORleXVAI9oWs5vuU8+3lAm9DR+Uo6CpK55TmVmNKGbAJfOXfo96vcdkX2wQCe3rJGR0YlP7ZnIYKvWAYl68mgivwDiJ/nWSvTQz+PA0rL2AQRJjRBgDMerYv54LPwtj63mJ7C/sY1x99hCsabxc0fPtFmxUPf3nKT/AunMadEYmiHGI3XOVh4sMgs58Qk6vgIfN3BBhdXoaEdffve9dPykCABOF8bBNQ0ni5MBDFL/P0cEibCkrmxm7HaD+NYUYLwcg2m/3df9RLQqiFAC6G9EdAkkVS2lnErNAH5b9g35v440vlgs6JvGqx6KDo/n7etiutH+teXhg3Tb0HdIAdULs4GFnVKVtHb3dBQu5AXJTuxkhFJpeKgdXfi1sfwbH5LMf/7rhzvw260BD9Bt2v7Yr5wREYHhRbsCLPo2m5CkgBmxzSyKEZlYI8zGXwWMFi9AolyDZya8gnLOaBkNnuc58OVJqT8pUYjdR0+4oKVY6piORq2IvrfZs/FET17/6Ympj3IOwXLuLC5uWMvpZmrxUyZRJcTmf65hJLKFGGWsdxCNh54e/tOPb4LRmVPLYQap4JqpxEn3ZTZ5vm8DenElBZLUoS1pfgbi9qMOXH3tlWihyM6ctOizS0YsCev1FbRK3aVVPKuVrx4Bef6aHwsg/cqoeMHGe2cwI3ct6k1qbtT9byjTErIyHVtdbeykeZquEhsVHce53hOrw7qJbR6qthLMGDxjeGysXJ4u6CV4kca74A56pQgLehE+vgE9t85m3vVO0FY3syEcgyLnQcChj5aRVow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(39860400002)(366004)(346002)(6666004)(2906002)(26005)(6512007)(41300700001)(53546011)(6506007)(83380400001)(38100700002)(2616005)(186003)(6486002)(478600001)(4326008)(36756003)(66556008)(66476007)(8676002)(8936002)(66946007)(31686004)(86362001)(110136005)(316002)(54906003)(5660300002)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bURYa3FRRk1tbVZ2Z1Mva2tqdW9OOEdLejJLZXBOQklpZ0s1R2hNR0hUZms5?=
 =?utf-8?B?M0tJWWJjSkVDaEwvSHNGTytmWkUwR0ovTTBCWWRZREE2N2FnMEh3anI1RFFW?=
 =?utf-8?B?ZDVIc3JpaDZCTVNxV1p2d25Xa0FUa0hrUjNWM0F5NjJuRWJ5WjlEcGt4R0pz?=
 =?utf-8?B?STRPc0hqOVBWL3hHR0FMSVpSWUxBNDFPeC9BaE5yaC90V0VTNVJNVGI0K204?=
 =?utf-8?B?d1l5ZjljbjE4RmN3YnJ0UWVWS29zVGZUQnFWek1qZW5GWUU4a3p3MlY2anFk?=
 =?utf-8?B?N0xOcWxxejdFaStUMU8yVXJZMThxQWJWR0R3eGRkM3Rid2ZDTXZQNjBUMjl4?=
 =?utf-8?B?aE8vR2ZmZk5UemlubVkrczFwZkd4TXBqamJhN0p6aGhoWVFYQWVObCtPOGFQ?=
 =?utf-8?B?TkxaS0xNRUkzL2JoVFkvM0c5b1d4VFYyU2U0NGJLamQ2MnhSYzE4RnZHbklJ?=
 =?utf-8?B?bUZubmR2cG40Uk9YWFRseGRMVlF0eVl6ZlpsSnRkUndBdDEyZ01OMnlrT0wv?=
 =?utf-8?B?cVhIcjljUk9zWVhQMUlJYnd2WlozN3RnWGJPRDhTdzIxRmE0bFVUelZ0aGlJ?=
 =?utf-8?B?YTdiV0dBa284UmkwMzF0VWJtWUc5WXJjRC81Y0VELzZ0MFZmaXJKYU85QnNB?=
 =?utf-8?B?ZnUyWVhxalhlUUN2N0wwTUZkQ0JvNzNxUUtxTzdTV0ljdlhqVG9zY0x5ZTJl?=
 =?utf-8?B?ZGdCdCtsdTN4UTlQY00zNnUyNVVsR2J5Y3BCSnJzSmpxb2NUNzBBUnowMG15?=
 =?utf-8?B?RE5nb1RSSTJhbTYwZzJOZVcvUmFjcktsbzJEcndMaW9QZjFkNVpwSS9mSHh5?=
 =?utf-8?B?N01ieUp5MytLMWd5SHdFWlhmczQwWE5IN0lhTnZmY0w0a1paMCthbTcwOExX?=
 =?utf-8?B?RFBqbmptN0tTOFFrSHJVNEpWYVZiaWZBdG5udWJqYytNR09NMFMwSWpNcTNu?=
 =?utf-8?B?bUJ6WkdDRzAyZnBTZEZVR2FzRkhQWGcwakVWRko3czc1dS9LemRjRnFEV2Zo?=
 =?utf-8?B?NGNGSkNha1lJUVQ4SHJVajNTK2xleUlaZWh6TXlKRlQ0NzEwS0xVWXMvVVI2?=
 =?utf-8?B?ZndHYWhaaDkyRk5GSHVCalhBZHBZb2FDc3lGSXk5K0RFK2p3aVM4cVFuSWRx?=
 =?utf-8?B?V3RoYTZ0Z29WUWFoL0c3Zis3QnJOVGRGeWJOSTBBNWJBQm5UaU1ySUZLTDRv?=
 =?utf-8?B?S3B2cWs0WVhZRFIyTThnQWFHRmVISDI1UlpUSEg2ZEJud1QxbnVPdXhNWmNC?=
 =?utf-8?B?bkhZTlMrZlZ1MzhWdTVTWWRQekhPcjRGZmJMYjhGcjhQOXh2VThiVndaSG1H?=
 =?utf-8?B?WWlua3VRWkRUay94dm1yVkQxUlM5ckxlb3g3d0VIdUZNdTdjOUV5ZW02dGZi?=
 =?utf-8?B?Z1VzR2VGaWVXZnBBMWhzdGtaSVY2OTg2dDFsQW1wUTg1Y3Z1c0w2VVUxbG9R?=
 =?utf-8?B?aDlKZTZoWnRNemRDTXdBN2VrWFZadUw2UjZNTGJMajQrQThhVElEc2VkUUEx?=
 =?utf-8?B?a3FRMTBnbFJkVnlkNHJoNWpycmliWmJqOHNLWDRXZmdMTXdGS2hhTUZWbGEr?=
 =?utf-8?B?dkpBKzhFdlJUMyttcEx0NU9UUjZKVmt2cW9vQ0lyampYUHhmY0pteWJKWnJx?=
 =?utf-8?B?ZUxyRHpkcFk3QUpYM0g1b1o3OHF6L0NYUjhvQnl1MTJ5emFkTU9HU2xIdmlx?=
 =?utf-8?B?TGp1YXlrM2UvQVNONDFKNUJ5N25HSkNLL1lkOUkyNnNDYktoWDZMRjgzSzBX?=
 =?utf-8?B?cGdBMUVQUWUzNklvNCtIVmhBc2trK2pma2lxT1JJMjJ6Rnl0QnhSWTlFSmRr?=
 =?utf-8?B?cG5Idk1ZbWZOZE1DMGx4WmxFYTByUFNZVWxQaEl2WDMrT1BRbkNYUE55djN3?=
 =?utf-8?B?N2lIN2RjU1oxNjZmZnQ3S1lUSyttSlYzNUVGYUYvNTI2VWVTK3ROY0NrcVBH?=
 =?utf-8?B?U0VDT0lIUDh6MHZuQndYaVV3eENEeEtubXBRd28yNFhmYXRUREpBUnRSREh4?=
 =?utf-8?B?OElubmR1Mk45aHdNU2s4NkZFS3VVRThrbXhqa3BQTWcwaG9OdTRYNTBKc0VU?=
 =?utf-8?B?cmJ0ZlFBWndlOTBBZlpTSGM2LyswVVFaUkh4WVM1N05FSVlxVEFrV1h3cDhM?=
 =?utf-8?Q?RCugqAsvSqsW+4487vyGgOuAS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dc353d-9798-4c1e-71ab-08da793083b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 11:24:10.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3G/HLEFZxlxzepZLwg9OBkEAQVztWzyprmjagnmdKLptYRk0/7QgT/PXxcue97K0nMdgApD8i9i0DysYH37lNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080057
X-Proofpoint-ORIG-GUID: 7gFykPTTzNbHE27QJzmRIfDrJNcD8CoC
X-Proofpoint-GUID: 7gFykPTTzNbHE27QJzmRIfDrJNcD8CoC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> btrfs never uses bio integrity data itself, so don't allocate
> the integrity pools for btrfs_bioset.
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>



> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6e8e936a8a1ef..ca8b79d991f5e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -255,14 +255,8 @@ int __init extent_io_init(void)
>   			BIOSET_NEED_BVECS))
>   		goto free_buffer_cache;
>   
> -	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE))
> -		goto free_bioset;
> -
>   	return 0;
>   
> -free_bioset:
> -	bioset_exit(&btrfs_bioset);
> -
>   free_buffer_cache:
>   	kmem_cache_destroy(extent_buffer_cache);
>   	extent_buffer_cache = NULL;

