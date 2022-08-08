Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E367258C76B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiHHLVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 07:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHHLU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 07:20:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E14CF0
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 04:20:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ASwBe032163;
        Mon, 8 Aug 2022 11:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Wg5/6V3AgKWcbW4RdmiSd1mVwJNXYCDhrgTTpT7GRoE=;
 b=cqsq8ZiJGy8g4Uu6vKXmZhKmis7sD2px/tbhEoZemvgtnYx76YDBms3qqa215rPM718P
 EjZ5zmG79O4gDfJkm/RaTJmpj5UUMhakBPL9Iohk/tmSaHNnfFlSmHaJuPa7x8k+AwRJ
 1qwFtvd7GgSEnzEOrAH6FrUyrqFinHcLWpsdiiopk7XNWAt916wsZrg5/78IgtyZXFl/
 RryCAlFNEqsKDBjc+22nFFlkFXnlhsArdLk3kyw4GGPLiKefFMuGyFHmJ223y3jM3aWL
 9AaGRhIhJMz/4mUHDVXPv+BNu8pemD6irVuV6NZyFozhky9xwoFiKG04ep/ow/AztOBk FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsgut368h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:20:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278AK6JT028219;
        Mon, 8 Aug 2022 11:20:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hu0n2h4df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjV5LGUq6noH9faDnrn/MAKlvhgPJe6SY6/ab65iQGMf7eK3SG7vY2Q0q6FOngeej0vxRFhtm5cHhR6Wj8gUdn5+4+tk17CHEZnfMgcyBgKeerADXzy3ZjZUMpaCqWvUDwE/CXhWtzjRTrpUYUemVDqIbegMLvdA2bUlSszcS3CkvZQ+GsgvUubRVCYDNpPVQQa7/CKnEvLaQE0LNyXaoxWgCi7b5mzTl183C9kLhD8fLzjNv7dh7zjSv6CJXxeclp7xoRIWFqA7yD0R+eADgfzPKbIE7qEkvxU3we9n1E5jhOoh3oT+iaX+ZtwrJaZwunKhZLjbP/+nhnMQbMb5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg5/6V3AgKWcbW4RdmiSd1mVwJNXYCDhrgTTpT7GRoE=;
 b=eyUTMwdSBslOKVEeGgEkrE/w6q/lT7BhaR+uPV3fUQqxUoFHAexAc5hYC1AiK2ga3GeHxvL220SQIT7kgFdomnOBCFXAhmxUykMzH5Rga2KK0jEPy6JRCqwfNkp8GN9LaFill0AqKlg/XeANUV3UKG92xmT5sVj9975sdnqizYzxZdaUD+sMujeEN3Eb2qkXpWlzUjG8vY6DS9IOsIrW/iIFKHWmQtvudYfa2MQ0QezskDaK/G1qhyvD85Rh7ya4zzbAlZASkbUp27hbbWKRJ1YIrvOAXtHZ+iwde91IhSkLSM4TAcBnkpxm/m8FuRfCqgBfmoTBQZpltqyty4tiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg5/6V3AgKWcbW4RdmiSd1mVwJNXYCDhrgTTpT7GRoE=;
 b=YEJFYYCDgMMAuUKt2FG5/O7rxAPFfvIRYzi+q+H9rbsaWjFdrlSaR0pFjs3iH+o3CKv8sfUtZnm27TTXLAfODVYV/103lVS4U2luWsnOHV52lj5PimhJJPAODLT8FBMHMQRmckhaLSBRpe67+HOpudlTWZymH0/UDFEjIiRPUX0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5417.namprd10.prod.outlook.com (2603:10b6:510:e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 11:20:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 11:20:33 +0000
Message-ID: <3e0e142d-9866-1806-b1c8-119658bc480b@oracle.com>
Date:   Mon, 8 Aug 2022 19:20:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 03/11] btrfs: pass the operation to btrfs_bio_alloc
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-4-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88741cf6-c97c-4553-3aaf-08da79300277
X-MS-TrafficTypeDiagnostic: PH0PR10MB5417:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gORp1BnDranzUX8Vq2J0w0O61mBDdxZn36F/5k//1GYdxk+nTx2lwzr0N3HeCEZIDRzJgbBurllq/wONC45EMlMRifVhjMNY3s/Wb2bd1qpdRdqXm4aIA8nVJOL6/aRhT9pTK/6xVvvG5Hn/4S+WaDMALrce17VU22dHBRjPyPgfCwbD0xLGVRA9pStALFIWj3hUv2C+1NASrbUHhN1EZQR2IHlf3DI6wnuKhGOGJsaOcfy6lOiH3wUHqovW8bvf4gE+2qwuHBU88e1hJ6Naeo/1Uzjh81AhoSHmgej4jaQF1yMaeoXyJNFP3xz9KdMdjEyjNu3aIEdia9KYgvxSv3ND0iTH79c0iTzbXBHA/ANRNdBX+ItmXajptZZBFx8E+5GMUc/kTWzKemxrdscHqz1mcj7uO3ddHtO9gb1yfb76YlG4C8/D9J+4kGhlP6QSb6LPaJjG3j9nO+WSlOn4M5i5ncmrtnCLbCztEFZ7rK+CshtcCHDkhnWeB77amKkhVbjMX5mkqWV2E88n9/kuzJQyyFMO/r0YRAfTQn1C4rQVK5PHqaAibeB9TrAYZIlXS5HDu/zJaelUp+A3SXbxF2IHWQ3aZejybpi500VQIqjiJ1sSEwI84bXFsiVBfpWTWb48kEdgtAilcOrX5IW8kFB3ss9cRMTJrKEkCmHzI+VZKpIA/kd5p6uuHi+85VKRt/yvB86hYGVGZtgKmr+/63G58DgGwwbHRDYl0lhdYi/uPydytC/Lv69o8UWOGK7loawiXHULXIPtCGsz3wYC1Wh3wn1lW6Yipx2Dk7hi2S2AwZtx7gwhBmKtVqu6o1+QHzLRdUmGJjeTdVF7T2Xm8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(396003)(39860400002)(6512007)(86362001)(31696002)(41300700001)(6506007)(53546011)(26005)(6666004)(2616005)(38100700002)(83380400001)(186003)(5660300002)(8936002)(31686004)(2906002)(44832011)(8676002)(66476007)(4326008)(66556008)(66946007)(54906003)(478600001)(110136005)(36756003)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9GUktlbDFSSExyN1U2MWxoUGtyeXcxdTdaQXZqajZhTW16QW9FZGlyd0Fk?=
 =?utf-8?B?aVF1cjZRK0RsWHNuaERLTFMvSm5aaVdCSFd4S1ZEZmtiQTVCR1RZWGVaaTdo?=
 =?utf-8?B?OVJEY2REeVlZR2VNb2RxWFVNaW5XQUlHNXkxVFBleUljNTRwc3Q4bjVURDYw?=
 =?utf-8?B?M2R3d1M4SFlnYUtlS0xkdXpOdmNmdEpScHpIWUlXd2tlZG1ZaW0xMHpsTWN1?=
 =?utf-8?B?T0FHMlFOeEs0eUlLYmJWalpNYUFRdXZ4aGRIMWdyZnJ3ZUpQOHZ2S0tVcjJZ?=
 =?utf-8?B?dTU2dktTeHB1REN1QlVRM0ZYdjdUd2NrVGUrb2c2V0hPaTlJcFB1ZFN1YUM4?=
 =?utf-8?B?NGxHc05zNWEvd2E1OCtiU2I0RmhBcU9tSklXTG9LSUlRa0FwWEpjb3I1c2VM?=
 =?utf-8?B?VU1EYnBiSVhnbkxXdlg3djBSUzg3TWZJMno0NGdsRXZnK0xrTzN5UkliS2ZU?=
 =?utf-8?B?akVqOGtzcExoU21FcUxVTjl6emIrcGVnbm1PbXNhS0JGdjNzQ09FMXljTHgx?=
 =?utf-8?B?Y3hyQ0Y5cU1YMjRPK3NPb0YrbWtOOTFlUzExOVhFeVRUWVhvTUpKM2plWkhJ?=
 =?utf-8?B?a25GN0poQjNzMDlxb2NVYkVvZTFuN0pydWhIZzN1WWZPN05kVWwvbGw1dXRk?=
 =?utf-8?B?RDNwOUk1VmJsQ25RanJaTnR3MHp6aTg5NG13RVY5d09hNjN1VzVuRkFrQ3Fx?=
 =?utf-8?B?emhsN3ZmSmtWRjNyeVhFM2o3UUk4N0srSWN3NmtJLytEZVlFdm13Q3dVT2J5?=
 =?utf-8?B?RW5NUnBabW1XSjRHaWFkbldxWnhtMDdFM2EwTm5HYkduVm5HZG1wSnlsenJt?=
 =?utf-8?B?UEJ5MVRnV2drbHROL2RsYnFLamt0TjVqWHZpTk9VUjZVbHBpWjdPcXFRd0I2?=
 =?utf-8?B?alo1ZWlQTGpkSWdlaWFKNzhMSVdSQU5rdlVPTUxHZmtSSFpFRC9vM3FpMWFB?=
 =?utf-8?B?d045YmRtdExuZGk1V0VCUTBSME84ZklyRUNmVHdNaTRBVjdsRnY4b2ZiVFp5?=
 =?utf-8?B?em9oUWhwZVc5SlRxSUJCMTBFKzFqM0RFRHJKODc3SytiWFNjMHU1c3I0c3Fl?=
 =?utf-8?B?MUVFeGZIS1MzR3dKSnMza1NnVlVZalQranlaTE1NTmFxUTBzTmRHeDZDNEhv?=
 =?utf-8?B?di82YzB5RGtHOFBiVDRiYkREZmVmdWlzUWlkTWx5Vzl4WE5NcFZDQTUzZDVt?=
 =?utf-8?B?SG1wSGpFcUlGNlZIeHcyYmorbEZiL25oK0xSTFhSRm1ZSTUvNjE5WTVJRnB5?=
 =?utf-8?B?NUxRUXdEbW5vdktiS0VMVVFlQjZuVTYwd3BWQWdQcXFGVGRxM0JvVHdnK29p?=
 =?utf-8?B?MEtFYW1rZi9YNnVQN1MwOEJkTGhwbWxhNmMzc3hLcE5yOUozYW1QTWZlQkxP?=
 =?utf-8?B?bERkZTFJeDZCd214NFlPMkNscmEzaW03eDBLZXpNWkpManVoMzQwTk9YUVZl?=
 =?utf-8?B?SkYyK3VyUzF6a2YxajBGdzdNdmpZemtWK09nUVdYbUhMSVdGQnovRDRXUC9C?=
 =?utf-8?B?OERQSkRTeE9rYlRjYkVBdUVXNEhPQmVrc2RRMHAydlNLVGZES0phWGVwcHIz?=
 =?utf-8?B?N09FS3d2WG9kMlpBZGV3UzBRZXZpclJmOG9iay92eDRtSXQxT2Jsdi84Z0lr?=
 =?utf-8?B?M3Ewdkc2T3orY24vVFZOUjlTRVdMcVdjMEpPYm9MR1pWQlV3S3RydWhYNWsr?=
 =?utf-8?B?TDl6SFlwK1ZNT0lSVjlzaTczbWVyeWNpME0rZjRiSmppSjg5TW44UVAvS3Nz?=
 =?utf-8?B?OGZ1ZmtVcHd6K3VDSmZZQkdsWWRkZ3ZUb09FYVFnRjRFS2lzcDEzL1BDaFJM?=
 =?utf-8?B?aE9EZVh1WDl3R2RWeXd3bnhCdlRpYlBiaGhNQ2p2QUxjVXpTUVV3RENqZzYw?=
 =?utf-8?B?SWVnOXN0VlZvLzk2eks3UHRicG1NQnFNdzlmcjdrOHk2aFFnQi9pSGYwK1JT?=
 =?utf-8?B?ODdJSGZhUXhkR0J5TkRmd0xXUmRrZnFEOE9hdUhmOTBPK1ppeHYzK3grbWNa?=
 =?utf-8?B?SnFvaTNvSElWS1EydVZTQkNZZ3Nmd2Z2NVNKMHpUc1pvQ2s3WE1MbWwzdWhO?=
 =?utf-8?B?VHpkVlJSRngra2d6aDRTTjhWaWVPWG1HU1Z1bUZoTlVBNjdzYk14VDVGN1F2?=
 =?utf-8?Q?LtPDQmDTvOZNcSKiwqPiSYYHK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88741cf6-c97c-4553-3aaf-08da79300277
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 11:20:33.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woqnTi6Fcz6QcPnOulO6iUOfiIkVXB9tI8VXJLrxvTrSLnUjcqMCrWhFiy8qntkZQxdvhO+zPds8gTUCMSEirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080056
X-Proofpoint-ORIG-GUID: kE0y6AtXDe6kCbOkNf6ENlGjLoYJYGTa
X-Proofpoint-GUID: kE0y6AtXDe6kCbOkNf6ENlGjLoYJYGTa
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
> Pass the operation to btrfs_bio_alloc, matching what bio_alloc_bioset
> set does. 
Got it.
bio_alloc_bioset()
  bio_init()
::
	bio->bi_opf = opf;



Reviewed-by: Anand Jain <anand.jain@oracle.com>




> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/compression.c | 3 +--
>   fs/btrfs/extent_io.c   | 6 ++----
>   fs/btrfs/inode.c       | 3 +--
>   fs/btrfs/volumes.c     | 4 ++--
>   fs/btrfs/volumes.h     | 2 +-
>   5 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f3df9b9b43816..e124096eacddd 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -344,10 +344,9 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
>   	struct bio *bio;
>   	int ret;
>   
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS);
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
>   
>   	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
> -	bio->bi_opf = opf;
>   	bio->bi_private = cb;
>   	bio->bi_end_io = endio_func;
>   
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 068208244d925..fae8c1899226b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2626,10 +2626,9 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
>   		return -EIO;
>   	}
>   
> -	repair_bio = btrfs_bio_alloc(1);
> +	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ);
>   	repair_bbio = btrfs_bio(repair_bio);
>   	repair_bbio->file_offset = start;
> -	repair_bio->bi_opf = REQ_OP_READ;
>   	repair_bio->bi_end_io = failed_bio->bi_end_io;
>   	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
>   	repair_bio->bi_private = failed_bio->bi_private;
> @@ -3266,7 +3265,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
>   	struct bio *bio;
>   	int ret;
>   
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS);
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
>   	/*
>   	 * For compressed page range, its disk_bytenr is always @disk_bytenr
>   	 * passed in, no matter if we have added any range into previous bio.
> @@ -3278,7 +3277,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
>   	bio_ctrl->bio = bio;
>   	bio_ctrl->compress_type = compress_type;
>   	bio->bi_end_io = end_io_func;
> -	bio->bi_opf = opf;
>   	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
>   	if (ret < 0)
>   		goto error;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8cdb173331c7c..dc2cf58095c2e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10489,12 +10489,11 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
>   
>   			if (!bio) {
> -				bio = btrfs_bio_alloc(BIO_MAX_VECS);
> +				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ);
>   				bio->bi_iter.bi_sector =
>   					(disk_bytenr + cur) >> SECTOR_SHIFT;
>   				bio->bi_end_io = btrfs_encoded_read_endio;
>   				bio->bi_private = &priv;
> -				bio->bi_opf = REQ_OP_READ;
>   			}
>   
>   			if (!bytes ||
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb614bb890709..a73bac7f42624 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6624,11 +6624,11 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio)
>    * Just like the underlying bio_alloc_bioset it will no fail as it is backed by
>    * a mempool.
>    */
> -struct bio *btrfs_bio_alloc(unsigned int nr_vecs)
> +struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf)
>   {
>   	struct bio *bio;
>   
> -	bio = bio_alloc_bioset(NULL, nr_vecs, 0, GFP_NOFS, &btrfs_bioset);
> +	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
>   	btrfs_bio_init(btrfs_bio(bio));
>   	return bio;
>   }
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index fb57b50fb60b1..bd108c7ed1ac3 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -393,7 +393,7 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
>   	return container_of(bio, struct btrfs_bio, bio);
>   }
>   
> -struct bio *btrfs_bio_alloc(unsigned int nr_vecs);
> +struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf);
>   struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
>   
>   static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)

