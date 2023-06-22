Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595D739482
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 03:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFVB3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFVB3g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 21:29:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423081BD9
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 18:29:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKGDei003723;
        Thu, 22 Jun 2023 01:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x/hqvaeB5eXaDLU3hupoa2oNxX+gM2pZq8PQfSB55ME=;
 b=uqxdfHNnY1P/ar6+qqCqLBW/g7MsGsaslfsU9YSJxb0NB4IBFVyqEJBTNVqnUruTRcMY
 rmtVyPzoc59kqmtF/+A0S0xiR4Kc+zGg5JZYygvOM1l5tm1k54qr74Ju5JiLftw8f4fF
 f+XJHxM9W/unhSIKKAdCHO+DLZKm0MmWOHJpqv+fNFG9MPR23bc0XCIjZFHeD55XpeKs
 cCHGgUkIY8s74fW2uHBi6ORgxV0y6/osXa7abWixbzNTcaKRqxy6/U60AYHzGSj8suRY
 ojNg054fEDK6/H7v9+3thGkJwoO8kjohuJbyG5tbkcrJog0TDiXfDDvwS5g2RzTTjkRf 6Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu0r27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:29:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LNJwn3007121;
        Thu, 22 Jun 2023 01:29:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w1764fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYvfj+Ohkx/nxWOAn0fzPgqwv5ucEmIWecgPFtzTZiO1GG0iFfwarK15bIgINTdtaftu/nRVkG0Cslsf9hulV8aoiBtLS5DYjR4Kmj0CPs6xX+VBSU+n4cDOUL4NYoz2689cD8s9Sb19lhZc037KnLTFSjTPSdFcOPDqbsIgcITUuS8CztobM528TiiDD/0bOq7zAXOqJXJyG/pIr/Tbjb4xPFRjF341Y/kASAOL/BtQbHuljXWPnY7xeV4WiqvHM9y+jlIt+V+KNPnwUqOUTigZ7AT8crvIAqdQqle0Mluo7t/2NSuAh6s11jqZsyZPuY4Mbyx4wti154YDTfARDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/hqvaeB5eXaDLU3hupoa2oNxX+gM2pZq8PQfSB55ME=;
 b=KpBoV3sl0EI/KCYa3fbQgp72wVoM12Pa6KC55jGpn3SwdGfwX4lj0Q1qbGQkkxCW5WZk45a8zSsJLDNn/zxeJfuYr1rypQIgw1R8TZyxKKa6it/+8xejA2FKBu4Z6YOcTVRLHrbNtdllSSJiZsg9kvTx6VOj8afcnwsIv27Wb41kBAGGLAlGAw08pf047Qu2PIqm93bi+RtYJHLzYFTv5opgrjIdcR8fdAeY9m6iXPwP7EDvgo8o2yhiI30ViQD7IGGm+LBRi+Wid2uC6vXpfalVq5B+fvLaNtJnCd5KL6bED3TuKppoacSaMKv5aQmLHY/DQuRrxvy7J38Y5lAYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/hqvaeB5eXaDLU3hupoa2oNxX+gM2pZq8PQfSB55ME=;
 b=Ln1uFy7cK8MGnbDbjLE2EyU9bMqc72Qaa89sc2ABXWldHFrloSUhnjXD8cBD0pXuJnUQ1+mlKdKIpAnKmwbDRZVaCZbuyQWPIdezcS2ElwuAyPuNw5G4iosWi43Vo29Yr9imRXhx/Y4WlrxzcUW7tzUSVN3HOfua5IkHOTUt6Ec=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.40; Thu, 22 Jun
 2023 01:29:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 01:29:28 +0000
Message-ID: <57c09714-ece4-ea89-0a20-7390c85957b9@oracle.com>
Date:   Thu, 22 Jun 2023 09:29:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs-progs: dump-super: fix read beyond device size
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1687361649.git.anand.jain@oracle.com>
 <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
 <7783c9f4-021b-c323-2992-56e717276e64@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7783c9f4-021b-c323-2992-56e717276e64@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: a789b810-f55d-4b3b-bd55-08db72c01ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agns6hc5xv56UDyeFBJLkhpFAU7ws1u7NBjZy2/fsjlyAApZpmKe8J7NCpEGmTbORVWDEwUwrUObhRedkD5myCf1Dvzt6V2DaQ9iUBh60yvUAAHPpLHgggGdC9igE+spLq59vQo58k5cduR3ge6A9mHLHTUKfqV/BglC9xN+W82kqSF7RDYStyQCr9y442SJT60UxvPtScySD6iAi/h5XhzbZpJdgW2qjBbqqs2b8604WjCMKsl1CF+sWPmbCNE2P0aj2UPShhTULF4IeGDlDxmo8CskHLnxGk1cuvDLbEe+F/sPMQRZOsv33ZxwTxMTtpjohDJx8eJjd0eWeKhjK42Ms2VUL8psSK8GdGp7az0m/7RADHcZ8gyJt6MCUlIlQhmTTg5MJyyi/g/Mx6b2M9I+fFNvMF9NjrHRkDSMZ0+V7K4IBVspSeHq+T8i63oeTXLwHjYbZVirTYc/EAeDp/Bhw3xY2iBDOrcwjqXMt1pauzz112UTA86niH/Ok+CbRc6UPdSZBHbpDNluIhtUgq14YEFmn4/k+MBv+uTkt5maMr4H/EUNtElxd3kWDhXCuidmkzTd19C8JpfwG5lNmPf6pgbhMpg6ef7Fj/A4zTmUz8Q7Trp6Mno82o+FxDebhjAOOUhJn1KJfk3+La7QJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(31686004)(478600001)(66946007)(66476007)(66556008)(6486002)(36756003)(6666004)(316002)(31696002)(86362001)(83380400001)(6506007)(26005)(6512007)(186003)(2616005)(38100700002)(53546011)(41300700001)(2906002)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzQyQUQ3YndOT0pCZ3o0RWFhL3NSVkJMOHRVcTlGZTFZVXBiMERFODVsTDJU?=
 =?utf-8?B?c2pQdEpQSGppOGpoZW91bkRoQWlsM1dOUmVxUFY2SUo4SGxjc2pQYmR1Wmtx?=
 =?utf-8?B?dXMwY2krcGRuaTRab3hORjFDbSt1Z0theE44Sm9OZ3E5c2YwQUZHVzlWU0hw?=
 =?utf-8?B?VmF5aTlsYUFVKzU1Q0JNM0dBcm56RVU5UVA3ajlGdHFTSEwvMnA4NE9wTHVR?=
 =?utf-8?B?bzBTWnZFdmk5czVLYVBTVU5TL0Z4cCtnVkFaN29CUU9YYUx2M3YyMWpScFZh?=
 =?utf-8?B?a0k3MFdGNWk0bEYwbFFCWFptM3R0Uk9TRk1jbkplclpTcDZkTDd2S0gwbkFF?=
 =?utf-8?B?RGV2NTh0b2VSanFacDU0VERJV1prdkFxZ3ViQzlGNDl1bHlNelhEOGtWMzlJ?=
 =?utf-8?B?YlYyRlpzM00yUTdWeFpvK1BJTzBoMHpFbE5iRnB4NytTOGU5UGMreE1WOURv?=
 =?utf-8?B?cC9tMEFLRitNdFMvR1dLclNNalRnbitndjRzYy9HdytoTndYSWQ0SVNUTzN5?=
 =?utf-8?B?NWdRNy9YYVRDeEVGL0U3b2Q2WW1VNzh1c2xpd0k1cUxtVWl0bktRWm5WQUpS?=
 =?utf-8?B?VGdyT3FsQzJqemU1U29lY2IzMnZEZWwrZjdPaC81d0Z0WWpDaVY2ZTVrbGJN?=
 =?utf-8?B?WWRqcnhZQitDRzFTWUduRUNQQ2w0dWw5ZUtQYURUaVdVc0pEbDlGV2cyMzh3?=
 =?utf-8?B?Mnc3WmI4dXBaWUFubjdRQnNOR3RYWmtqYm5MUDdlOUh0M3cvcnJ4Sy9tOTcw?=
 =?utf-8?B?QVIzdEZVdVdibGU2RGMybldhWTFlbnZJdEtKWThsUU5zOVpDYmRhbnEvR3JN?=
 =?utf-8?B?eHU0dWVQdWFvL2p2M3YycWpKMnVMQmZLdzJJaDZhOCtid0lYcWJUcUJvcWx3?=
 =?utf-8?B?eE43VDcrMi95UkRBY3lXeXo5VWtOaVFuVFR3RjdkeXZIWE05YUsxZlJpelJw?=
 =?utf-8?B?YkVYQ2NkTUs2VGZJcWZGUTAwZW1UTGpaZjF4T3BKS1J6V2lPWlRMbkl5Tkxx?=
 =?utf-8?B?d21mazMvcXRvNFVQVEsxUk8zdU5BWlljZ3ZkeXZVWmhmWUU2NU9rSXM0akRK?=
 =?utf-8?B?L2JiTDRHS0l6a21Eb3Qxd0t0Ylp4M010dHM3WjczNitmRzlCMXAzaTF5Z1RE?=
 =?utf-8?B?eHYrTWdoaUJsbWVpbDhvRk9zdktFdVZTelNDL2djbm5KVm01N01YcW5MeXdr?=
 =?utf-8?B?R1dWaFhGRnhSS3d5MVp4V3JvMk0rUU95KzhUTGZuTmYrdG9JQmZDazhacGE4?=
 =?utf-8?B?MEFxZWh2aVUydVAvZjFYeXZGbEpPWEp0UzJ0bjV6Z0xVb202bTJQY3BCU0ts?=
 =?utf-8?B?dVRoSHZtZlVDQUdrNnpFSEFncFZoekVjT1loZVZCSHZ0NXZ3ZC9QMlNMeDBu?=
 =?utf-8?B?cXZsTjU3eExmU0hoRmRlZnBRZlZMajdVQTR3OUNPYXlDbVdSb0dIcklvMW9r?=
 =?utf-8?B?eHFwNFpOQ1pVdDdtbTdpTEVIYWNVMXdtZHNPaFZDU1FEQkNqOWEvdWhiV3VW?=
 =?utf-8?B?YS8xRkZ6aU51QU1jSlU5Nm8zV1hGalIwNkZQdDdsQVVIT0QzVzI1ZXRsN2tH?=
 =?utf-8?B?QzlRNXdlRnRGZGQ0cm5YbnFmVDFhd1ZIWXQ1OFlyWC9xSGtPblpvTVFrcUl5?=
 =?utf-8?B?YTJQc3VXREtFSzBabUFoZGZlRDZsZnNkbE4wSG9pVk1rWElrSmZZMVRjL3Vr?=
 =?utf-8?B?NE1CNzJXRE5RdEY3aFBEdFhlMVJRL0ZTVmQwYjFUK2JwNHNGYzJwcU90Zms5?=
 =?utf-8?B?TVJwMW1MZnIyY1crSVgrbGxPUGlDRzVmaFcvV2I0TFlRdlZYeFlEK09adjE0?=
 =?utf-8?B?a000U1pxbFFwQXBBc2pWMEE0bGZ4KzBOL1FWY3dNcWx0UWhpODdmcFlmWTBB?=
 =?utf-8?B?RGl4L1Q2WjBVZFZtUFIyM2NkbmVoZ1QvbnB1c3pMQXpieURpLy9TVjhWbFE2?=
 =?utf-8?B?N2VQUzJDcDdHbUJqWnRKZHU5V0dLZ0N0UXBUYVZFVkk4UzRNczZnSUpUVlk5?=
 =?utf-8?B?dlBPNWRjc3BuY2NsYWZ6YUR5aEpEZ0k4d3RlSnE4MjN2T0JhRFovT3N4QmRQ?=
 =?utf-8?B?NU1Pd0ZDZXJHK3BmWEN4enU5Y3Vhb01nUCs3Tkg0R3FEb2ZCSEU4YTFCTDMw?=
 =?utf-8?Q?v7Ak2RM91VfS49KALnZIEITIa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +tOR5mHUSrTiLmdRUdShyU7UhIOvnQLsNV7WCAZf9qgWxRpXw2BEEVsObl/wey053xRqca837eEtN4h0BeL2maluBVan5dmrToGM3oa5ZQGOuXWnA0hoppXhFqJr/QBox96r/ApVSAXHioC+2gw0NAp71Kf88ZrDeeKjLiG6UKQvFI4nK0IBSzFWqtQs68TOoU8vhWoGm5PG+y60yInFZoaC4GbJqLwHxers4iL/mC/n9xxcYfYrYZ7ujVpgVkP+TyEW4lUx1F3bg7gt/rSJy4cA3GVGeMjrH24mOlqtC4C9jBZ7hRvwB6hzLghoPvcrzQ8ypKJTYPGBnXZHo4nA/L1M+TaSZFsQyWNIf++mdiRg7ST7fT/m8cCMnjr3DtwAXgM5Lo1fB5BbNSFrXwdP2rsr74PTCpQZgrn9KfZ1T4ZlvKoR+olHFJqr2JqPe5Cmu/S73q0Qtcz3JUvUl5dyDlyLmB4jYDYNAfk9FH2evvPtdqh3Qmhv8/YYsXtjM/QP3yJE1tELWP9RyFhwpFq+84gKi9Fmt+fs2S+qBhdyYelR1C0sen18ENDqPAIVZw1KocsyEqSzEIlixo8773q40tgt693CvXsMHQm0sCSVaNnd9VaVvTFzM9QL9Do9KddA9bxwNQ9x92vKq2rqqytwZyGCX/RUz2hauuyF5QVeBZzb/bXdTZqCezYkDcgK53/DJs08d+RJHwxpzWkHSoqg3CXwXC1P7iukIey3t+YEd33+W1zpWwvQvgCCK9Pnlehhthe2MvR91Paxg71XCoq9p8qx50ere4FUHf0CZpglW/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a789b810-f55d-4b3b-bd55-08db72c01ebc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:29:28.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 555iimi+x4/Bm0o9HYDdDMdsxU6Ee6ieuHcnFCALerILIwOx1QgoDtIag8mPczE804LGTilgJgqHqw27R5+yEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220009
X-Proofpoint-GUID: V89OJbNfR41RnI9ydVeN8W-JRokHcuIe
X-Proofpoint-ORIG-GUID: V89OJbNfR41RnI9ydVeN8W-JRokHcuIe
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/06/2023 09:02, Qu Wenruo wrote:
> 
> 
> On 2023/6/21 23:41, Anand Jain wrote:
>> On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
>> failing because the command 'btrfs inspect dump-super -a <dev>' reports
>> an error when it attempts to read beyond the disk/file-image size.
>>
>>    $ btrfs inspect dump-super /dev/vdb12
>>    <snap>
>>    ERROR: Failed to read the superblock on /dev/vdb12 at 274877906944
>>    ERROR: Error = 'No such file or directory', errno = 2
>>
>> This is because `pread()` behaves differently on aarch64 and sets
>> `errno = 2` instead of the usual `errno = 0`.
> 
> I don't think that's the proper way to handle certain glibc quirks.
> 
> Instead we should do extra checks before the read, and reject any read 
> beyond the device size.

I implemented that in a local version, following the kernel's approach.
However, I didn't send it out because the test case misc-tests/015*
requires dump-super to work on character devices like /dev/urandom,
which is an interesting approach I didn't want to disrupt by modifying
the testcase. Another approach is to check only for regular files and
block devices, but it's not a generic any device solution.

Thanks, Anand
