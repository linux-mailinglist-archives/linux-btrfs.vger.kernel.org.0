Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4341B5BFCCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIULMD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIULMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 07:12:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2328B2DE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 04:12:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28L8C9Sj015066;
        Wed, 21 Sep 2022 11:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OTGDjJimzDUQGiMlzmpQqV7ss0jm9nopMy+c7nmSibc=;
 b=hJPbAOxpDJkk3KQJvAeyckB7uSHKMRNqW68zgVh9bplSPokUCfUO0r89RVfLp3rgTJw5
 eDft5c4AiaYGxhprsTvNdjDdsFGVolm8PijyfETqYSwM94BvByR/LjXeOBoYzl4Hp2xZ
 iuJdo0Avi3XLeqsfmthoKJen7MxYPYuLnKWm9gbY1Faj9bKMsbWwzWVFBd+Nz1UaXW/H
 TVxssTr5aUFyLjOqThMPEBdn9ul9yWG4B/SaoiMIiQ5VUD/aO5WuK5I2bBi6shdVmZKT
 HFT1gEEOGGhURouZM89/H2DLoR6Pclt1/8md/54Yv/5V8viX+pBqgNQ6pJSIRiNOpaFg BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688hpwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 11:11:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28L9Fn0q007952;
        Wed, 21 Sep 2022 11:11:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39mbct8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 11:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SICtxErRWr+pwLpBnWVxiMXNM4JPag71+tc+kWMGA7Y3UR20Nx/lEGZ7o6xeZlrO9ruj01i8VQ/IgpWS6wz1x+tu6otFj4AwvOnQQjMqgjnfQn7HgrcxEupQFowtL8VsPvBiUEuZxwtp5EQln1fAOjPU8Ha5bPm8cS3WydsRrbYQbOK91mDLPmtwaeho7ip7FJZt3DitnYLKSkE0x2CC4WY+nILjhWBMP1LGuwqHjXUsrVbp1LyvFzIoj2ja35A9EYubw84lmNdyvglOlRmj5uIM1Z/RwMcIFiE3KJUJOGQCA23hybrV02zYZLUd8smuDT5QanejoDmR83D/Nt8HgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTGDjJimzDUQGiMlzmpQqV7ss0jm9nopMy+c7nmSibc=;
 b=KL6T0IHNj+HzPO1/WyEVSISdeAzje+90EzzE5IEejd9wjwWtgCEwVfdevcVZ0Jc+4gnQ2dWjiEPG0DgDgnMzm/Vc6D1DzCAigQZ3kuAeIum/b5LpoBasx6jpcX86ULv+e0ItZyudtXRSUkEYWYT0FJKbZUFWSwJYVSJZWfoKl+pzxBvSNQC7t7ZRyk1D0ieg+KYxDq8dI3AgRqeLBagceAYc7gHr7lSXoz+tqlCvqUtFbITTVC3z7/SSbSQpWGAmVlyTfudfYLY5MhLeTK13KRXch4K4ZzIHja9B107LmLCO561Mki55PPH2UIxAqOSdNCE/yT+BbLJUKS3NmM2uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTGDjJimzDUQGiMlzmpQqV7ss0jm9nopMy+c7nmSibc=;
 b=jpENdob+DXJRuFSYk0Lg76Bb1CEW/MdJkBRYS9HnKK7eEbx6h1PGTJ+mizU3DE7JRgztKspgjK8jnUpOiy5pXcQpjpyEUMnPsiLHkDmtlxGufy7qWff+lHtnyJKr9ZJAgZzhj6M1c4oOxdoxDbGQd1UeaOdVLKbVw3D6g/vu8Sw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 11:11:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Wed, 21 Sep 2022
 11:11:46 +0000
Message-ID: <61a6fa98-8e16-da51-0d96-88debd9105fd@oracle.com>
Date:   Wed, 21 Sep 2022 19:11:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/13] btrfs: fix missed extent on fsync after dropping
 extent maps
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1663594828.git.fdmanana@suse.com>
 <25d72acc3215f74fbb885562667bf12401c214e9.1663594828.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <25d72acc3215f74fbb885562667bf12401c214e9.1663594828.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: cc06c5bb-6c21-409c-b976-08da9bc21283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2/p/v6oJP2LgEzJx1xA3jDMgFk18oPO+liW6flpxTobWV2Z4Hs6V1iGZdyBwHtC7vETbKRkP4/s94fDtUq2CxON/IFc70cUt9+PTiOwES9E6CAiSrjoJ5nRhXoBgjGHozta2VgQAfdMWCZ65E6kVXlYVWdtkTrULvrNi310C65D83VOvluSxii0oIFwKApzFAD8GfJ9ry8x8CTjk2gkEzMJZdApLY50Ff8WkxTbH60zrd+El+Xygz/8tV60WmpFOHb9p2ib63Iy3EDoCCiNPy4Px7IG95UEy0x7NuXdFL/oNxz9pnRk5b1r/wGBHcwceZ/7gx2GJhdUpZ9JgIffSpNtxvbFJ9Gd9BBEXQL/VtGLSo4f6hKCQzaf8V/Krl1mOvBxVWpOZ20hlBdxgRsoZmsfhb2T2Uhdl0BZLxbjMNIuBhHzulrH6sN9z0uqHbqfR8rwdoh/7QaLs33FLkktrBrbuhqQi0Gm6cRKHfBhWmAn79dQ69mDm/sQ+1oTr/5r2HPtqMLEDmTw3fGim74T3decGF4cqGPE2MJ20L5DB5ymHJRSLxSzCbNxifaXBeM1Q1093SqRzo+by1I18Umtldo7XUTgp+gAOF9G+ffxA73g9P5GZlPDDny6nAfmii0FFfzltXVAMWx4SRgL5MTMgrn5dWqfUhX3yNLRkh8gsKvcLUAxKYVz+1jUtuMJ/muGS33Atg97OgQHY8evV2KknKH88fplSnjFET7++n49bHnG3IcoB6ie9GBLTEEZn+hwL7Z97IOsTK59twVU8oPsHrUQzyU+UNkSicJVXrvoVHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199015)(5660300002)(2616005)(186003)(316002)(44832011)(31686004)(26005)(38100700002)(86362001)(6486002)(8936002)(6512007)(36756003)(6506007)(41300700001)(66556008)(53546011)(478600001)(31696002)(83380400001)(66476007)(8676002)(2906002)(66946007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFYycnNEU3hFYXJCZzFXQW5RU09hajlwb0hrNVRlZmhaTEdRWTF5MFRhL3FX?=
 =?utf-8?B?NEY3YlNySlQvYXVaNlFMSktQKzcwQTVydHFncEN3dFpwWnlFQzZaeEtNZXcr?=
 =?utf-8?B?RTFKM2lic0tSR3R5bGRMa0JTQ1p6YTczOWMwUkQyVkRObmR6clBTZUJKTlNL?=
 =?utf-8?B?a1lKOTYxYWtYWlhzVWdMZU1Gc0g2US9FMXBOeDVMQUFONytJMWpyOHNYVkUz?=
 =?utf-8?B?V1BHSmEzdGRKNXJxNTMyM0grZmFZU25TMWR6Qzg4KzBkQTNxcThDOC9rNWxi?=
 =?utf-8?B?MGpJSzUrMnpzVXBFTFRneTRZQ3pqdGttSk9qMWMvQTBFR0lxeGxEdnNEczhP?=
 =?utf-8?B?R2c5TTAyNjVmeFc1UGJKQnc5S0lXLzczdmdVTy8rU1JhL0lqR3BJdjBRU3B1?=
 =?utf-8?B?cTJIQUlqT0tEakpVL25OQzNMRFYySVBXVlI4TmY0U3RFeS8wWGEwWit1NHVw?=
 =?utf-8?B?MW5mR3gxRHJIeUdWMWZhZ2VORktNT2NvcnVIU29WdFhHVlhqNU9NMWlpYVlr?=
 =?utf-8?B?RjBKaHpXYXNXRFFMaHpWR2IyZjQ5cUl0R2pHMGdKQ1JaRVhPclc3TUQ1NUt3?=
 =?utf-8?B?VWgveDg3bDNRSE9rRFBVM3Jsa1g5Y3VVNVJ6LzlPdW9kUlhiVmJIVlNycHFI?=
 =?utf-8?B?WHlXVVhlSk12Y0p1MjBCeTFGajVYZmVSWklXN0YwLzhycFEzQVRxTGVIcmFk?=
 =?utf-8?B?NXJQWERNalQvVXR6ME9oN1ZEUG50am9GSE81Smc2eTEwZE0zbENJMzVWVUcr?=
 =?utf-8?B?Ukl2UmVwSXc5cHdUbFI0b3pRMHVmMFhwa3BXQS9RSldzOEVaTkQ5MzQ2eWxo?=
 =?utf-8?B?L29YU2w0UXhGdkJSV2J0QnpXN3FwWUpFRkNpREgxcDU0QjQxbHVUVkErZ3ZO?=
 =?utf-8?B?RGRPQjQvbzF4Szd1QkhwOFA3K3R2T3NEQkJBYUJTUytWNjMwby9tTzZPYjJL?=
 =?utf-8?B?YldHdEdsUHh2RVp6MFI3YjB2UytDZTBsNndqRmtnS1ZwRkFHSkh6MnJKdDRx?=
 =?utf-8?B?RzJHVWd3OFRMbnRlQUNYQ0F0MExHVzVFcXdqY0N0YjZzcXp2c2J1ektISDZR?=
 =?utf-8?B?UU0zQy9PZ0RuZG00aW8yNEhoOXpyQzFqamI3WWZsMld1NDdHRVl6TkdiaElW?=
 =?utf-8?B?dXZ4clBhVFBsWW0rbFhIa3pabWVLeFVhSWkvKzlQZURxNk9OQmJlYWtqNG8y?=
 =?utf-8?B?aytrY1ZxSEdyS2FXVVB6M0pHNkFROVVuSHJpVkFjcmM5ODJTVEhwVUVwRW9h?=
 =?utf-8?B?aEJQSm9WY3F1MDZwR0h3TFBza1FZU2JRVmx0Vm9DbGM0RDNvVDM1dEw0YzNn?=
 =?utf-8?B?SmorNDh2bDFYdXVaYS9NZmo5QTQ4MWtGczVaRmMvUVZUdGF4Q3V6bWVTUVJr?=
 =?utf-8?B?aWVycnVmeFA2SXJPbkN4T0o2eEs2d0FsK2lNeEc4emVTWnNreEh5TUZiaFRR?=
 =?utf-8?B?YjZBZ0szOVpJRjIvWVEyWDJFWWJ4Z3gvWHNNYm5tMmpXWU81em9xQWZaVGxp?=
 =?utf-8?B?N1M5bk80QUt2VG16OVhxWlc4a2lSUW5vZWhNS0VEVTRZdStGK1NPR1hrOGs0?=
 =?utf-8?B?dVh3elZLUDNiUVRjNEl6QzdzTkxJMjRBQW9Gc3VaTUNBaEtaN1EzemRNRXls?=
 =?utf-8?B?d1kyamkvc2lUNWdCVDUwQVhOcFZwZnZWN3BVYk45MDdTOW53MHRNQUxBenVk?=
 =?utf-8?B?SGdHZERHZ1dqN01Cbzl6SDRDd3YySkdXSFAyTEF1MkJYYmhMR0g5K3U4OW85?=
 =?utf-8?B?MUNiQWhaMGNWcUtGdHVnajIyZlg3d3dhazZKNGl5bDY1OGxlWTdxWnZBS1dP?=
 =?utf-8?B?K1ZxNC8vYmFJZHRWNWZvMzV1WEZyYWdYM3NGYTM3NTRCMzdVTTdPZWRhQTdV?=
 =?utf-8?B?ZzB1MFYvL3V4cHJZSlRJZi8yZFRZRlZBUVpFS2JvQWtIRmNuUnBXUHFhcHZ3?=
 =?utf-8?B?WFBWNUR6RUZUSkJEWUNJQmpxMENOZmoreXNCQjNvY0hGdFhCV2ZhUVYyNW43?=
 =?utf-8?B?b2tVUUgzUkd5VW9RSkN3cmU1NnRwNEloQXpVeWc4ZGFQQ1M0dEpLM3M1RkpO?=
 =?utf-8?B?TzhxdlVKS21qd21qVW8vR29iMlpabUZvbFVtZnQrQVBnVHUrRUh4dGZ4ZlJV?=
 =?utf-8?Q?FcNjGokM/kJWHdhcJEOiPdRQp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc06c5bb-6c21-409c-b976-08da9bc21283
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 11:11:46.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeryV3SoPHd9Lzcp7ThuwR9XgaQjjGGRgR8pdW4dKGFlvjtfk3oLxaJGoQnXXcwq12kZJsL8VfNY3AvdOsIE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210075
X-Proofpoint-GUID: 2woiOf7wRMSwODHwDXUlBw0ov9V06Jrz
X-Proofpoint-ORIG-GUID: 2woiOf7wRMSwODHwDXUlBw0ov9V06Jrz
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/09/2022 22:06, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When dropping extent maps for a range, through btrfs_drop_extent_cache(),
> if we find an extent map that starts before our target range and/or ends
> before the target range, and we are not able to allocate extent maps for
> splitting that extent map, then we don't fail and simply remove the entire
> extent map from the inode's extent map tree.
> 
> This is generally fine, because in case anyone needs to access the extent
> map, it can just load it again later from the respective file extent
> item(s) in the subvolume btree. However, if that extent map is new and is
> in the list of modified extents, then a fast fsync will miss the parts of
> the extent that were outside our range (that needed to be split),
> therefore not logging them. Fix that by marking the inode for a full
> fsync. This issue was introduced after removing BUG_ON()s triggered when
> the split extent map allocations failed, done by commit 7014cdb49305ed
> ("Btrfs: btrfs_drop_extent_cache should never fail"), back in 2012, and
> the fast fsync path already existed but was very recent.
> 
> Also, in the case where we could allocate extent maps for the split
> operations but then fail to add a split extent map to the tree, mark the
> inode for a full fsync as well. This is not supposed to ever fail, and we
> assert that, but in case assertions are disabled (CONFIG_BTRFS_ASSERT is
> not set), it's the correct thing to do to make sure a fast fsync will not
> miss a new extent.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

