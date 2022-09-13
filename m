Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5975B6795
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 08:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIMGBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 02:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIMGBU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 02:01:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091721274
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 23:01:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D3fg9S026998;
        Tue, 13 Sep 2022 06:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xRNURQpGRMRFUOZkmVZxkj+yZeiZEVDIkWRsBcMjKCo=;
 b=J62aVj5OWpc4IEjwToJWm3TXxnufZTz1dFTtWR/3FnNoIn7SzdtXwlNDcngRYmI8h5xj
 6G/yy0mKGyhg0ZkuE6tYlyvBQJkywkpttCjppXBP0DGKp2hYk32HqTyY9yG/+Kouu8kO
 d2Y/JT/5ardhahDQeOTnojzQJRQaswlNRSmcgLjNtRjJsxQiXh7yjTkw4OoQp0jYkYoz
 5jataxDRrq8BLi3yffwzYrJ8ERWrHgFaV9XKoZ2yXjAA5ntzuuyS5RJsykOWqxslagT1
 /09XgGsK3wF1AcoUGxpuPLRAos3Aszdk3ljYcWZYafmBYsuOIv2OxXjKlGRGBzmXVBCM rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jghc2nk9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 06:01:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28D4Gu30025127;
        Tue, 13 Sep 2022 06:01:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh133e4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 06:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuegkiQW3x4wIK7Ccb6HPiTbU/hXAdeBCiGSDPmyF5R35u6ojEsprXyN+6ptCvqfe+LCgy/euKndENPSYJUSqpSNK7d4E03YOQOBKt0qO3RhdkHvH+01LXm8nCm4rr0eqfP3Sj1/JC7BkfGEqHk0e+iPzKhAQfopwjdDVS18o0QXqHIFCvI2Q0GtN0JWR8w9NynEfOOUPevI7DUeK8EmwX6weZtlSFbBs1PwZchb8tNjD7EawWQPqE+j/z7nvPf081otXwmIfjymB648HaDSbG66BNcADmpX68vUfFDQ4gk0KONtgWMipkhYT2NUPbk3+caF1AW1+77sPH2hVuTD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRNURQpGRMRFUOZkmVZxkj+yZeiZEVDIkWRsBcMjKCo=;
 b=KKDGaS8qOwR3DeFbVjKyRaNr45c2EivU2IqSe86UU5m4oPcgdIrnX7w625A23sg5AYv/PlxVSssQ4oXnjXY7q2jfAHrfK3Ox0deM+KrmsmuJEWGR7ihbQWJqafGu2KXGvu0iQUyqQb8NoyyZvmwSNlaoTUhs2axcXCzycQTPR1P13RHgh/T+RC0wZn+4DFRF4ptEnxl0EBunmYPTtdwXk1dBf48X8q3NgRH1p+9cHIPNmAfplIJRKlUOi3HK5iarTQ99R9+55Og+nsRoeWAMLOq6p2Fjqr7izkiSDn09wjtqTEVFISgKxICJiWTSrD1BWNSRLjzBlzv5gMv65xE48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRNURQpGRMRFUOZkmVZxkj+yZeiZEVDIkWRsBcMjKCo=;
 b=s192WMRif/e4M3zpJfS3bI4lPgpsrGPqxcybucFS159SO0Pp31QI65ZtkakAfqjvKzlGeBst2y7NRNpSa136Wtsly3zVHPk3T7UeKVHR2C8pXBJ75PM9UdBR/iWjCqdE9pMXBuXOa1C1/7Ik1MHocaQ2mFA/1wqfZkfLbkNr4Qk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5695.namprd10.prod.outlook.com (2603:10b6:a03:3ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 06:01:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 06:01:12 +0000
Message-ID: <76b5fcde-d189-7bfa-537e-aaf37981ceb5@oracle.com>
Date:   Tue, 13 Sep 2022 14:01:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] btrfs: update the comment for submit_extent_page()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1663046855.git.wqu@suse.com>
 <e348ecdbf6ab68956ba1cd04c51e662ee3589f4d.1663046855.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e348ecdbf6ab68956ba1cd04c51e662ee3589f4d.1663046855.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 3701f5a9-dc17-4fcc-dcaa-08da954d5c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w65w54QvjJVpWHanBwVsSpFuvgDSJHRw8dG2wZy0WJw61u5I8pkEO8nenou7Vv1GXtc0c1jHZcA33AH7bDdth0Briawsl2JkLcVzxC+XzbCzHMmKf28bdebMjIemyO1bmi1/8kZ+RaW8t5egAWwqR18eQB+vz6XMiGRo/mHiaahD/bloyZ7GGeXYwRyJE0olGAdAaUdM0HtWQN3TMvO8iHZapc/ozZx+IEyNyXwvMJCpd4eQab6x8wfmGExDxcCyPkA5/jG4l40g/sZLqZUZZ9Z5veOsrFs3Z0lJ5mURJR3zrrq05bKZxlzpc4+D1qT7GkgDshl5dW9thLGR6c2/HVyaxX17A0l2LluTTUa8Mg+p/341P7Pl4V47OfyC5BBihbOLlDVqeluWaC2IGyLOe3i0VWE0A73T6qTe79z1oJmY0SXJEwFO0Q/PyUz+R0Z+9ErttTJ6QwpyUtGQ+1aQbqxlQhO6J9ZsVYfPcg2VhOAdQCUSeu2gCRj1wHYtUXPtXUnd9qea/mCJwBEm6rJ9U5AFMlyO8C9tXME4eFOp1YXs7S39dYSI34Ayb/wGykgm9jVl3PP829NdmKZkM5Fx7/9SNoReybk0pQB8ZCE88ER5Rh6NkntKJgWb77CVB9NJvGXhHoUSw2WEGLD4n559MDuirC4WhurhSQ+JjTFPgrketI0p5uAi7G7h0MkNl1YnK/yyg7yTjQAkEwLxg6rkJ8SF7SVClHsJkLZo7JUmR5152xBql99i6DYdbIWZD9FuRE/fT/uFQIQpInFZe//SY1E/Jao+jdP0+WsI+HNRP74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(66476007)(5660300002)(8936002)(316002)(66946007)(41300700001)(38100700002)(6486002)(2616005)(53546011)(8676002)(6512007)(6666004)(44832011)(26005)(36756003)(66556008)(83380400001)(478600001)(15650500001)(31686004)(186003)(31696002)(86362001)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJXRHV3YnlVbWQxR1ZqQmQ1RWptZWtDbTY3eVBaSmlYeFUzZVEvMzBUSDEz?=
 =?utf-8?B?QUk3OGRCeHVZaVJEZHo4ME1xSXNOZWxpZGdOdG1PZFlQS2g3SEhFL3RucnVN?=
 =?utf-8?B?TWFxZkFHVndWRHQwNEVhNHRSZzNtVExaL0ZCSk1jL21WTnprWnlUZlBXbEZZ?=
 =?utf-8?B?VXRYenVCcHV2ZUVHbC90eTI4UCtuMXYvZ21FTVN4MStQZENmU0kxaWtKdU1P?=
 =?utf-8?B?QytIT2x5d0hMQmRrYytjbUoveTBkbDZyWHRTNVhBOHRWUGpnYk10ck9iS3RO?=
 =?utf-8?B?N3J2NVNIcHJWTHJZbVFXYncvM1JyZ2FLeUNUOGNpV3hYZittdGRNNlZxYWRJ?=
 =?utf-8?B?SDhaUVZrWk42UUZidXZPY0hEU2VsbzhBNEFCaE1rOEllaG45VjI1V01NMnZB?=
 =?utf-8?B?YzN6a0RXVTAwclVBMkl4bHhGUFBKNXloamVSL2FsOXVpSDdHYlJPV0djNG9N?=
 =?utf-8?B?aC9WY3AyOEJ6REZEcWxCcTJhQWVPdUttR1cwT1haNlFpcUVLczB3NDEybXhK?=
 =?utf-8?B?SWZTTGRxVXZMVFI4NXg5YUdhUkxmMEZSb0wveTB5TFJDRURNcUdCR1FLR2t3?=
 =?utf-8?B?dVY2bVNpdUFLQnN1czZCaStYOFpnOVZRcmZhSkJwT2pIeTkvWEJnMGx1WndM?=
 =?utf-8?B?VU1zSDlyRlcrQkd4WCt2QXhEaGNVckF4amJEN3QzY1NHUmp6TmE2N3RCM2h1?=
 =?utf-8?B?Nk5WUmwzWlh2d05sZVdLV0FOaktNYm9xeXpjSmlrT09YUy9PNWRISjRrWjZ0?=
 =?utf-8?B?dUZKbUUwbWtNZmtGLytmMlVQbEZpalZLZ1IvVlhWeEQxRml6YklyUnljeXk0?=
 =?utf-8?B?ZE9BdUhRSzhiUVU3aTJXWHNsbG5VN2g2U0prVlBCRXNZTmV0bW5rWHA5SFBr?=
 =?utf-8?B?Q1cyTEZ1MnVKODZKMmFLQWtCcjdLVnQzYWtOMGpHdmg2akhIeVJIMlZvTnpk?=
 =?utf-8?B?d0VkZUhKbVA2YlJUclNjYlJjOWNCNitwMHIwd3g0VVVGOWl6dCtUam1TQURv?=
 =?utf-8?B?cysvQmhvWmh4K0ZmWHVxUmdpNmVZalVCOUExWitFVXVNUGpyV1hqdWtFMmhw?=
 =?utf-8?B?Z3NSR0xJcHNUTHFnWTB1QjZOQ0dsNW9vNzhaQnQrVjJFTHhucDZvNlRQc3VI?=
 =?utf-8?B?eS9HZmZ0TUI0b2lUMmxqUGNXMzRtd0VhNllQTWxMVnNpV1pIbkNqRG1aSjJj?=
 =?utf-8?B?T1hXMmRjS2x0MFM0UDBBNmpzaHRPVW1FMGYzWHUvWG5FZmZuSE1KaUxacVo5?=
 =?utf-8?B?NSs3NmNSeGpjQzQ2bm52Y0tLZU5DUVpiazkvditsYW5aVXNyaWF3NVFHTVlS?=
 =?utf-8?B?SGVlMSs3Mlp1VlVnU1FKMjdzTWdaL1pKSXlhTW1iZHNaTy9pQldJamhDMlFw?=
 =?utf-8?B?cUhkcmNlUmdMYmIxT2ZnbkxNaHpuN0M2cXRmQkk5MDl1Wk4xc0kzR2lZK1Vo?=
 =?utf-8?B?eDFSd2Vrb1Zibk1SWkpSZDB1NzhCelJXTkZLRkFQWkwrWXhyK3k2MHlHTDdy?=
 =?utf-8?B?ekFUZUFPSTRFaWRHV2ptUHZ4MmFRSGd1V0FHa3ZJblovaUxTazlKdUJ3dHJQ?=
 =?utf-8?B?QWFrYzJSazNNemtGOEtuZkpPY0RTSFY0RFdjTTR2WkY1bzhyYkZvcWQ5NmE4?=
 =?utf-8?B?TERIc2wveEdLM2xHM0hSNEpkbGVOZVFvRXRiNDgxVVdsRkQxdEttbTdWTEsx?=
 =?utf-8?B?WHdKMTl2aXFRWmhGaC9xc3JaK1J4aHE4S3Qya1FYUmluUjVjaUJyK2RYdGhp?=
 =?utf-8?B?amEwSFVjcGZ3dmc5ZnJETHd0U1Rlb0lwV2NacnlaRnQ3bFdpQ0xvQmI4K0tL?=
 =?utf-8?B?U3E4bktZVU9BVHNLWjU5cDNHZkdMMWplTytLRkNvQkdsL2tENzRDTVR0RFpl?=
 =?utf-8?B?TW5xRFA5UUpWdEd2Tkk0S2s1R0hHZU5DWEJYTFRFZkN0bm1qL0RYMkVCUHNm?=
 =?utf-8?B?dnBQNTdiVncvRGd5YXN2bitjL2laVzVMREx3VXFDdzRQdDIvOVI0SE9DMXd4?=
 =?utf-8?B?L2h4K3RwbWV1UXYyMThoUkJCVnpicnBJc2tiazFOQjg1OGdmczUzN0xsQVg2?=
 =?utf-8?B?d0VwSEtNNGFjWWYvN1BLSFErMlVHKy9ING5lRWdzRkk5WnUyYzM5bmZYUkJ6?=
 =?utf-8?Q?rt1vUTO0Cx6Zbn+UDkmUEiZ1B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3701f5a9-dc17-4fcc-dcaa-08da954d5c47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 06:01:12.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FO5nejxQ+2GLbjl0n6Cioo/6L7bQCbv0JaxAKBOCIXOZ2BcKgkWPKqXDEAE3uH+vpaNOOljslpit7W22oIoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130026
X-Proofpoint-ORIG-GUID: PLFdGHSg6KXIghmJhFkbf3QqcJw8yYl1
X-Proofpoint-GUID: PLFdGHSg6KXIghmJhFkbf3QqcJw8yYl1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/09/2022 13:31, Qu Wenruo wrote:
> Since commit 390ed29b817e ("btrfs: refactor submit_extent_page() to make
> bio and its flag tracing easier"), we are using bio_ctrl structure to
> replace some of arguments of submit_extent_page().
> 
> But unfortunately that commit didn't update the comment for
> submit_extent_page(), thus some arguments are stale like:
> 
> - bio_ret
> - mirror_num
>    Those are all contained in bio_ctrl now.
> 
> - prev_bio_flags
>    We no longer use this flag to determine if we can merge bios.
> 
> So this patch will update the comment for submit_extent_page() to keep
> it up-to-date.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/extent_io.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cea7d09c2dc1..a3e8232c25ed 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3347,11 +3347,13 @@ static int alloc_new_bio(struct btrfs_inode *inode,
>    * @size:	portion of page that we want to write to
>    * @pg_offset:	offset of the new bio or to check whether we are adding
>    *              a contiguous page to the previous one
> - * @bio_ret:	must be valid pointer, newly allocated bio will be stored there
>    * @end_io_func:     end_io callback for new bio
> - * @mirror_num:	     desired mirror to read/write
> - * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
>    * @compress_type:   compress type for current bio
> + *
> + * The function will either add the page into the existing @bio_ctrl->bio,
> + * or allocate a new one in @bio_ctrl->bio.
> + * The mirror number for this IO should already be initizlied in
> + * @bio_ctrl->mirror_num.
>    */
>   static int submit_extent_page(blk_opf_t opf,
>   			      struct writeback_control *wbc,

