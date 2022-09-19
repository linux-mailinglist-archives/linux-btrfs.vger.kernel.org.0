Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CB5BCBC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiISMZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiISMZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:25:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76FDFB8
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:25:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBxCOo032717;
        Mon, 19 Sep 2022 12:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ki4OFhSBOnHhHDaksAl/Kz4OAIOyIIbDDKbDUnquYZQ=;
 b=dDolmUR4CADPP81zPAQ+YM4HndvakRoKD1uIKoDcu7fV7mbBiNBKKg5Xu34O1uMuXlIM
 Hw6vtxpaw4eQQ0SNHsjhTDbG98wTnebBoquq8SnylOZG4if/EVVgenCk1fYd+o9QmJET
 hWUBbXioBhq2Ual5bk1OQNRjjpYVOZ0X4/4XdDdd/kT8FeqFKs30zErxkYlXFEZaCscg
 MUTeJlpCbLLHsbfqTDC2KJ+gqCb5qRHOtxRDhRtrJnH38lbFMdENPdQSnnEMvYZ2ZESw
 tG0yfQaFcdZ1hubiqEjZNL9wer63pgj/kTmEWQnEcZQ38XTCdGtA1w/bmn8RtufNTL41 pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6f0bk8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:25:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBQdeS035810;
        Mon, 19 Sep 2022 12:25:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39hua1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBRn98CRQSLPxIWMUDLmVDHbv9nG6xRkNnZlUP6n6VLzjQOlz0rZT10rIEXEs17NeYiOglVLmnr94iK3yk8H7QoeLy0NAt59WTRKboX5uceMYwzm2BW5otq/6Uf8F0//TuB3ddf9k4J269mPEAQnQIvbVb9Kbd5XBebwYRF6Nx/WJ7sqIf6qETUtmzQvlGVys5o6pEemmMQhof4l7nTFMmiqqltOG5e9ZPsSM0ehbr0HFvaxd86zMlwBKaJJBrOmU5+VpLfeYhjR3Re9T8l9nW9qwrK5evSX0uqBFgLSodo1JUrMNA1+THWiSdA8eW+vP7M5dm6TbCZS/4mXsHdWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki4OFhSBOnHhHDaksAl/Kz4OAIOyIIbDDKbDUnquYZQ=;
 b=dD3PZgmFrlp2wPqW23enHHL2uFlMt6dN+LZUX7/Hu/xoY+UOLE8UCyKxom9rcwjH+I1t7vtaWyx+8zkh6DTrF3BXe6LRkHg5a0PToppzlzOmR1Vt5MJzATMaedyQaK07OOaET7Fnp5uSAjcxLgEtDgKez/asD2WSm0eODfM01xkvZ9+YAZ3MhoMIrUU/RQ/mWVi1WwbcHCexNWP60eYzniqDBETEL26DTOhM5yra0C9NFyouEpNevn2J9dVlab3sKFYxFnzP6Odgi6fTptFhVioHCv7ImUKVilWEQBpL7nKQnFZb4K2CePBnbOxqwes/kXOCkFoUoS5Ehy5TTzhC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki4OFhSBOnHhHDaksAl/Kz4OAIOyIIbDDKbDUnquYZQ=;
 b=thXNrvEkh0azSr/Mk/9QYcnk3vUliAbXa1Q5ae22YEnyhd4UZSjm5zenRVGyQ7HZADHzmw0dbmFP0SB8LIqPhXIIE3zVkYU1VyX6gtusY6dtU3h2aKwlNN4zo1LTTFglPzGu0ujvsZqPLUqOrpZTPIiRRS2zQ52FNjpsEYfDLbY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 12:25:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:25:04 +0000
Message-ID: <28d014f7-21b3-bd33-e987-48ec5dc8f98a@oracle.com>
Date:   Mon, 19 Sep 2022 20:24:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 06/16] btrfs: push printk index code into their respective
 helpers
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <ddcbbcbb41a182baf036d39a6a70e51bbe599f26.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ddcbbcbb41a182baf036d39a6a70e51bbe599f26.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8819d29b-aa40-4eb0-ed4d-08da9a39fac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Z9GGr6yo2dhPSLcYv8EKWSKUa5knSpHvD017VaX/6rfjyCEdqgR7w4Njh0ByfsM3zvk/TXHeLTM8db3mUGuP4NiGmnMDZIZPjlOUziFMVUC6ATvNPqVuJEqzEewlDOddVcN+sG7JkHKPV2kW6F4Gbs965vHEeHfagmX57EMZOmNe0NEmpWksauTxyYxwX7cDGkNhSUjJ/hqS1t9NS/7LDdrh6i0qb6XkitZTheSsQtBDuxuP657GFbkDgDlRhVGI0kEcweDlpGqYQKoDAw/SsQ+JyRlc9PzUamZZIBsIYChL/Ry2lVX/4xakarWejUIGdb4jPMLpmWge8/NHuOI8h/pm1r1SvJLsLWhC7sNO5p+f7y8NrET67Il1ghOeDmB7XInoDn8A6WgbgAzCqepaHRWP2IslCo2hQOIiTOTWpr/cA9tlJ6xFqWUSt7IkiR2G8o0y0keybalQBGbrs8Uep4oyyFsZPBtz9U/ozD3Q8fh138ydUfz22zz0UWy3lrbUIrzJxw1yb7FudEY09ZkcgPaH4mbcUzhldQrvw/uAdtMQHqc6QTztJITKFKZevO3jUyN5XXAZzHoR9orYoWxMpqUif7pJSOyMi2Ie515sow5T87EyGvLGnTrEZ8/ifip9VpHfU3mrlmQIZpIXwlVvkQrCKIFOZISt1WMz0VhOy8VJ38tIac+QlJRxJ/+UQ/Z2VaGlT9sD7RB5sVX8BNbWn2v9XlKWST9gq5eTGtTWZkGjvJ1JfZcrBHCiYd+FrPnvoC+Z8D6twbm3vtqA2hPKsFj5srxmARfwlEfCUrM0Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(38100700002)(41300700001)(2616005)(8936002)(186003)(6512007)(2906002)(26005)(478600001)(6486002)(316002)(36756003)(66476007)(66946007)(66556008)(6666004)(6506007)(53546011)(8676002)(31696002)(86362001)(44832011)(4744005)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JoMGZtMmtiM2xmZWhENDA5R1FlaXNqUjlKbXg3RTY2VVlTQWg1eGlFZ25i?=
 =?utf-8?B?VElYN0poNUxWOUhaVjR0RXEzbjZPdjBjS01zUHdyT2JhMHhLSXpZT04vUU9o?=
 =?utf-8?B?YjE1cnROdzUvVXdQV2twVWVpNDR1SzYxUjdleWtxNC9RcVhiTDUycTBlZk5k?=
 =?utf-8?B?cklpZXlZWHZ5amlnaTZHN1BoUlJyMU9MNVVVUkh4NDJyc29hZ2NDZ2FIcTJh?=
 =?utf-8?B?RmxPNHVoVUVqcGJ2eCszZTMrUjYzdzh5OVI4c0tWT2xEOEUxYnlUN2xtUGE3?=
 =?utf-8?B?N1BXOWxGMWxEVktYY0RnVVNWRkVOTmhCbjhwUjR2ZWNOL0tJdzhEcVVuOGxP?=
 =?utf-8?B?dmM2SklkSlBXOTZkaFlHSktYVXlPeE0zbklidWxEQ0ZvSkRUMnlEcnZrV3ox?=
 =?utf-8?B?ZUJHV2pNMFV1M3l3THdyVnF6ZFdBYk9iMzZWQXdTZm9KZzhkTzlSOGZQU1Ez?=
 =?utf-8?B?MDdoSnlKS3FabkR4OVlmRWlrRkdFenNwOFdYNkFBLzJFa1llMTRZU2Njbkxk?=
 =?utf-8?B?QjQyNGVqVllycnFHa3pSMkZNOXhUd3B4K0xINjhjUFR3akZOSFNDZVdWODR1?=
 =?utf-8?B?ZThOL0daSFNnUG5VV0NNWmxsaG5mc3A3T2lMc0Q0WUV0aFRpMlhncGhEeUpQ?=
 =?utf-8?B?L2dRdXN3U0pMVnl3WDUyZTJhdUU5ZDQzSXVVY3hZUUhBMDFmbWI2cTFuZ1pI?=
 =?utf-8?B?eHFNUThURWtNRC8xbCt2NjU5aFBzYWRTZFBZb3JCV2NUMzNMMXdaNXpzR2lp?=
 =?utf-8?B?THdiSFc0d2JKV0lUNlV0U29NNUxFa1BkcFluV1MzMGhYUUZjRklPb2RQYUE0?=
 =?utf-8?B?WVlSbHdXNURMK0VIM3MwNy9lLzdTcmNDMTlDN2xncmdUczdrNGUwa3o5a1Vp?=
 =?utf-8?B?YjdaRmdZN295bkovVkIzcGRXYlphU0lPTExQaVhsUEhZbEIyLy84K1ZzUWY1?=
 =?utf-8?B?UVBtclVoMEFBd1VuRDlxamhhMVhKN0I2dTdTaFY5eW5hcCtrMk9GazVyMEto?=
 =?utf-8?B?QkpyR21kQ016cTNBMkZlWWpYaGd6UlhUL1ZHaDErWm54bWhYSzYycDUzcGYz?=
 =?utf-8?B?YjdmZGN2ZUd6emNJekpLUCtHZmcvZURpc0wyY1oxSDVEd1hNNkJhOFBVa0Ir?=
 =?utf-8?B?MFhWMkY4UTNTcWpkY2NmeVhiTmlMZXpzN3Z1L0lEcDVpWHRjQm5JNXJxTzY3?=
 =?utf-8?B?S2ZPeE5iTkkxVUZjSG40eHV5aGRlYjZOUXlhNXgwcjRVWTJ0Rm9EVFhqNDZL?=
 =?utf-8?B?Vmgyc1hDajQ5NTF0TnpVTnBYdHJKRHdOWDdMN0NHR2MxSGdHVGhuV3FUaXor?=
 =?utf-8?B?SjNjSWVHazJ4dHNUWmticVc5cFVwYURpSS9uVm5ZMUJFdlhWMHoxMzRRWmZW?=
 =?utf-8?B?NmI5RzllbVQzMDZCOW9UUkprcG5aQmRIUVloNjBMaytTTkFZTHY1b1pWVW5h?=
 =?utf-8?B?U1ljMzNHT2NCL2pJUHRyTnp1TTd5M05pV1E0TFRMNU5mbFdlby9yRnNLVVFV?=
 =?utf-8?B?UDNCK2tJTkl3SjdDNVBuQ3V1cTdibG5EWnZ6UjcvQnFUbVBnVHg3b2Q2dmpk?=
 =?utf-8?B?Ykc0ZzhyRlBzR05rWGNLS3c5QTMwd3lWLytXUVVCaVNIaGt3YjJJR2o1cnRQ?=
 =?utf-8?B?LytRQi8rSEVZRzVpWnlBRDRyd3VJbWdoV01RemlGd1Y5Yzd6TlNhVEdLa2th?=
 =?utf-8?B?eHdIa29ZVW9Wd2VZWFdKNGpKMS9aODk1L0ZuQ3RKd3NPK3N6L1BXL2thcFNJ?=
 =?utf-8?B?QmtHZlVZbzB2SG9KY05DWk5XYzcrRU95aDJ0N2t6VmYwVXFKRkhsR2FsOWti?=
 =?utf-8?B?cDhSSXo5R0tyQmVDbC83dyt4aHNSRDU2YXE4RkNKR1UySngyRFRTM1ZLWjZH?=
 =?utf-8?B?cm1YbitzWVBvRU1IaEdGOG0yaDFWZ3FYYlpDVzB0am9HMEs3NFJ5RjZZaW1L?=
 =?utf-8?B?VnVoL3F4R05QaSszUFVjNVl1eG5aTHpoZTVQaWhodC82VnhtaUN4OFNzWmFP?=
 =?utf-8?B?eVZFUFg0clJpb0ZLQWZjUmNRaXVTL0ltNktuQWZqUTdyMGhrZkZhaXBXZ0Q3?=
 =?utf-8?B?eThFa3RYZDZKLzBuWEU4bEUwKzVWd1F4MUM0V1hBeFhzS0pOcGE0aW9BSGlI?=
 =?utf-8?Q?yVNJcDbGHJP/vtqnTGKOnflcp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8819d29b-aa40-4eb0-ed4d-08da9a39fac5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:25:04.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37Ho3NT9UDNnPJG/80gpBjuSfsIdlEv2B0sVowUL7DWtWKKgeKR5WZ3w1d7kuRcEz/hSBYSk7euwVqcDiyXK/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190083
X-Proofpoint-GUID: Ev2O6Uu_op01jga55gPzrVL5rliLOdgN
X-Proofpoint-ORIG-GUID: Ev2O6Uu_op01jga55gPzrVL5rliLOdgN
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/22 01:18, Josef Bacik wrote:
> The printk index work can be pushed into the printk helpers themselves,
> this allows us to further sanitize btrfs-printk.h, removing the last
> include in the header itself.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



