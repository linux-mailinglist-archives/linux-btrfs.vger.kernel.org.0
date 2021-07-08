Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034403BF5CA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 08:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhGHGxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 02:53:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27020 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhGHGxP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 02:53:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1686oUYB014624;
        Thu, 8 Jul 2021 06:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=55egKmtE0xFexBeqENO2UOQhjitw2AMXgxbes/7gNWY=;
 b=DEK1rE2BI6BZbS5TPFMljzhiuhNTbxtnh/XYBXn/QnQE57qjyM64gEICLAyZUOu3JHBm
 LE5gNZ/q54fJskYIAcDnYPKbkSK+iTwTKVtHXj4oByZoAieSvSfVY/7BaFXIkSMaxGKW
 yQFKBqEultBHokd6FfCulgTh9g7hX4aCx9b88Bg6+OpX97Q6TpKMfDEYXi4spXgSjHOj
 kkQswTewKgl+QAuimdt8DISYnX2bk3GKJEm8e8rycGI0wnxXvNckpZ5jG5AWdbivooT4
 U+PKOhLktEz1lzk34aiYlhKq0v8YQFn2k+dVQZAwZRQiJDrQ1AmGtlHi2NUFCkQL7qtF 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nbsxsr03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 06:50:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1686oBI2061101;
        Thu, 8 Jul 2021 06:50:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 39jd14vyrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 06:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIUW3/zF9Y8w6i707CcwCZ9WK3rFI5jG53X4m1ZMFBY7lDIy2Cdzew1iZMNd8DUotBJOtSyZ4FibUPSNKGCilnQzSJeGS66N1TJBX+ALoflYMDzUwKCSmDw9vPWZw74j2RwJn8WtdQetPb3Xyp83stZv3j1YXxs6s+5Xr0aHD9sr59fQKrxTRMKEgdk7IzfOFHw07ynLOjJFaBPreL8X3c6J88ik9+vV0o6XqzdzY0IdnAPbfveX1lyhmj8gquVMZLDpBG5K124XpZ9wOxRH7mN2XBtXFgyKbEsyhqFIYJL3+qQEnArzF7cobzy3GFfPmT3V6P6dXZOIXXQYzamX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55egKmtE0xFexBeqENO2UOQhjitw2AMXgxbes/7gNWY=;
 b=d8ZOqKCV5H4WnFqiR9RJLkcgDFHpNFKF/Je/5hqi4/j1+Gg1JeLphADbSX/xj/vtW50pb1hr0PAJLwIMfRLviHD0mojF8xAx5HvQV9as6tXR3kla375Bs5ytBWJtQbA6VTD0lpDJXMU1VvSaO/x7rhi3uCE2IV7aBc7MGPWb/kPmR2y6tOxEdA9W2Li+6nfSIs1qG77FOXZYVpMAkHewSlZhvWqkfXKfHI6HMIhnWaPt5mbQ1RMvoHGkRrCDSVjRgaGl5n+zKrcjwsnTQ+/W+h6gZpGETne5HkpA+jNsSCA1HemOKTybGqJGnoF7jqUeyy4JmsI949TEM1qRvH2sXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55egKmtE0xFexBeqENO2UOQhjitw2AMXgxbes/7gNWY=;
 b=NIasU/zegQ0LVs5YyTe6XEEqydhcv6W+o8Q9RHtAz9HCOFx2Z682i/kbeSNYhICLKY33yilOZZNucqd6JBuA71V543f8sVBw+2TolFbOtsMsO65YashXTU4ApQHzx7FRQpBOPDzuJZY4IQ96y5oVqwDHJOnmC6kdNmcQS2zKQqo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 8 Jul
 2021 06:50:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4308.022; Thu, 8 Jul 2021
 06:50:15 +0000
Subject: Re: [PATCH v6 01/15] btrfs: grab correct extent map for subpage
 compressed extent read
To:     Qu Wenruo <wqu@suse.com>
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-2-wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3d654aac-a0c5-fb2d-24d7-4508c8080e03@oracle.com>
Date:   Thu, 8 Jul 2021 14:50:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210705020110.89358-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR02CA0025.apcprd02.prod.outlook.com (2603:1096:3:18::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 06:50:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1adae020-9acd-4f00-2c5b-08d941dca3cb
X-MS-TrafficTypeDiagnostic: BL0PR10MB2929:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2929CE6744DEE6077D2FD8BCE5199@BL0PR10MB2929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOgsdLHIudEyXHy5SfOyYr8dWgBwofkg59k4yCY5qrogPh2ab22K3K6VEyR8ebEGPtiz5nO7YGPMVH+dx9cKpW+x6cyBWZRfktPQ8uKkc5kFSeQ3E1DPIx4d/Qq+pQx63O6+3tAeta5Ys9OJwS/GV6wGZBVYHpKcg+pWPIWjnKi3VllzZsGuSpE6qg5Xe/lSb3SaI7NNunjn91DbugNDQEiN1oCo3V924CDd8/XSId4ARUhUXKh2NwKoTVkkyQg9SMWxWLHLokgaD4J8w7suBr7LYn6qtizolYmgaUQPdc+XKsrrJiodkduveopu2m/Ego90ft+al95UXvJDljtjdUvZMNMKo3Yljpk1p+4Bcy2m1cCb0Vlo+zCXldiuTp3Y5NXqXNcyBdXzhEor/uLKZTThMEVh85SdFu+dpziI8WkvUaCtKtemTaVu6HpAxiBg/jBbHVrcZj0Oh9OwsYSdb2BEu5KhJea0ZavppbsmcT5kFLtx6RzcHO1bu16wnQ899RQbuiTlYShTpbNsNP2tkgdrt5OJce9HCOfQeoYCSwZ/siMpKljXln86lQXz+gMWA31N1yUsAcp5DgpCHy67UDWWBkNKgnlnatNkeQ7Xovzo7KJo19xs0LyKcOPwOXf1SM/4FbfjX4chxHO53DZ7XPCoH3DmbfRC1sVorUjCQs2W7Ou1tdA2lm2RrjK/FGbFYJUBcDRZtEmbMtrfNK+vTJenjAJQpqW1yy8sYJWMwsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(136003)(396003)(376002)(316002)(6916009)(83380400001)(86362001)(478600001)(31696002)(4326008)(2616005)(956004)(16576012)(36756003)(8676002)(6666004)(2906002)(31686004)(53546011)(38100700002)(8936002)(5660300002)(44832011)(6486002)(66556008)(66946007)(26005)(186003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmduUU1jYzFpZkIvRnNsODJWeDloMHMwU0JOQmlNYmQ5Vm43blM3WWxkcWRD?=
 =?utf-8?B?K2JKMk5tSjJ6U05IdVBZemJxeVRPTXlOdk9qRWJuNWJhN1VsR1Z5NDBnSHoz?=
 =?utf-8?B?UXlzQTBWcWhnbkg2c1FQOGdvT21uSTZjRWJMczRKQkEvUVZNTlQ0QTRoOGF5?=
 =?utf-8?B?aTlVWmQxb25CRURQaUlyNER3aEpQdWd5V0FrSE5SYk9zeEFsRUlpbHJMY0Va?=
 =?utf-8?B?cmdveVBxU0lMVGZ4djc2RWF3MVVwZnFVeVRWY013eEJNUlBodTM2MG4zV1RF?=
 =?utf-8?B?dE0rdHRpQ2pMemdjb2JFTEk5SzBlMnFlWmRSNWl6K052ejRmMlBRVnhKTHY2?=
 =?utf-8?B?RHFleFRVSTBsMkswWitwa3lKSkFUNDBraGJoemRwc0g4OXhBVWtCQkdWODZx?=
 =?utf-8?B?N2xIa1R0Ui9idWhoMzNvZ3JncCsrUm1zN1VFTDFHSmluTWlTZWczMG12ZXBv?=
 =?utf-8?B?dFVYdGliOUQrb1VGTjk0alE2MloxY1RTeTIrUDBjSG52VTFlYWhQWnpySlZp?=
 =?utf-8?B?NTZBa3lKcEFBVHlzUi9RUW1NZGUrU1ZMNHo3Ukl2cXN5WUZaSVFJdnhYeFYy?=
 =?utf-8?B?MGhUUDlmMmhoaUxJand3QTI0NnFUN1dGSUExYTc5L0ltcFFaUEVzem1uVEh6?=
 =?utf-8?B?UWpGTnppNkZNTzBybEVWQ2ZLZUVWMThXanZqNjhzTlRkQWFSa2ttQ3B0Y1pZ?=
 =?utf-8?B?cG5TRjR4YjRkUGR1dGt2Si9STXNpeERCZzV4UDlDZkZRTmVWeGxDZEVyanFH?=
 =?utf-8?B?VmhRbGliNUZqMDg5L29TMHdwWGo0MTYxd25zN2pWUmhBT0ZLYWtWT0NVQ1N3?=
 =?utf-8?B?VWxsZkViR01scWZVSkxDemo5eXRaTXQ0a284MGFhK1pCVTM5a3BoRDZ2cFpy?=
 =?utf-8?B?RHNEZjBHODVFQUFRZ000dFJyK3JCVC9HMDVTdy80djFub2ZmM2ZNQnJZcHZo?=
 =?utf-8?B?bEFiUk5wcGtOVVIwUW5scStKZGtLeXBxK3QzWkUyMENTUHN6TXRMaFoxY3Nz?=
 =?utf-8?B?MzhGQWZGRmdyeTIxNVFjRkh2ZmFsSzdhZEVTUWZFcld5SVZWdjNsQTdXbmk3?=
 =?utf-8?B?dCthUTdGbStTNm1WMzJrUDFTQWRGYVdxQXhVSUJxaDRKRkt0dDhkSEtFNjdN?=
 =?utf-8?B?YWJIa0h3UUJOdllpVmg2a1cwTzZUa3MrWlRWdmt3c1ZOSjY5c1FpYmcrUDNV?=
 =?utf-8?B?Y0tyL2lKRnB2dktseEVuckwzQm5mallPbFVTNFVYR1g3UGpKTlNFd3RQQ0ww?=
 =?utf-8?B?RHpvUUJYNmwveG5zL2xRcVhHTWNpZ2lhRGIyNmZrUUh2YUFxRnNRYjc3TjJI?=
 =?utf-8?B?RmswYzMzL3VqYWhjcktta1VpTVl6RFA5dVl3THlRN2JTc2xwK2NEc05mbFBY?=
 =?utf-8?B?aEdHaVhJU2NmdlFvNXhBRmY3b3BpY0Q4dUZ4NHk4NlhvY0hyeVpySTEvNUkw?=
 =?utf-8?B?T0VGdnV1ZEo1c2pCV1BJMmt4UlVTUDF3c0t0c0tZR1F0M3A4QTdERU5uT2pL?=
 =?utf-8?B?b2FDQ1d2ZW5iR1pwWU5DUXNkQWFZNFl0QTlWS3pkMFpPRGN5YVpTTTMyUGZu?=
 =?utf-8?B?OCtFZHVlVE1lZTc2VlltaGZuN1J1dHdxcDliRzNKV1Uyd3lDRm5vUjNaaTdu?=
 =?utf-8?B?b243L0wveVo2Y091dUtFV2pDYTFES1pBS3lOcG9JR0l3TDF3TW94T2s0Yi9H?=
 =?utf-8?B?RnN0T2lTZm9EOXBJT3cxU0V3NG14TTlqaFBkYXR5cWM0cVM3YXVGZWE2VzQ4?=
 =?utf-8?Q?U4i71iYmEhZAmM7E39nu/1P7mAG/N6tmQcBFI8W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adae020-9acd-4f00-2c5b-08d941dca3cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 06:50:14.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xK9kl/PvbCMwOnYbnsBSHJQQuRJkDB0SDBhJ/gcSQPme9MC2ELCbo9ScZW8uM/maTepyGyqsP9xhjbtvYviheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10038 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080037
X-Proofpoint-ORIG-GUID: fK8AlQjuB8CxQg6vRLENMDky3v-6aCWa
X-Proofpoint-GUID: fK8AlQjuB8CxQg6vRLENMDky3v-6aCWa
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/7/21 10:00 am, Qu Wenruo wrote:
> [BUG]
> When subpage compressed read write support is enabled, btrfs/038 always
> fail with EIO.
> 
> A simplified script can easily trigger the problem:
> 
>    mkfs.btrfs -f -s 4k $dev
>    mount $dev $mnt -o compress=lzo
> 
>    xfs_io -f -c "truncate 118811" $mnt/foo
>    xfs_io -c "pwrite -S 0x0d -b 39987 92267 39987" $mnt/foo > /dev/null
> 
>    sync
>    btrfs subvolume snapshot -r $mnt $mnt/mysnap1
> 
>    xfs_io -c "pwrite -S 0x3e -b 80000 200000 80000" $mnt/foo > /dev/null
>    sync
> 
>    xfs_io -c "pwrite -S 0xdc -b 10000 250000 10000" $mnt/foo > /dev/null
>    xfs_io -c "pwrite -S 0xff -b 10000 300000 10000" $mnt/foo > /dev/null
> 
>    sync
>    btrfs subvolume snapshot -r $mnt $mnt/mysnap2
> 
>    cat $mnt/mysnap2/foo
>    # Above cat will fail due to EIO
> 
> [CAUSE]
> The problem is in btrfs_submit_compressed_read().
> 
> When it tries to grab the extent map of the read range, it uses the
> following call:
> 
> 	em = lookup_extent_mapping(em_tree,
>    				   page_offset(bio_first_page_all(bio)),
> 				   fs_info->sectorsize);
> 
> The problem is in the page_offset(bio_first_page_all(bio)) part.
> 
> The offending inode has the following file extent layout
> 
>          item 10 key (257 EXTENT_DATA 131072) itemoff 15639 itemsize 53
>                  generation 8 type 1 (regular)
>                  extent data disk byte 13680640 nr 4096
>                  extent data offset 0 nr 4096 ram 4096
>                  extent compression 0 (none)
>          item 11 key (257 EXTENT_DATA 135168) itemoff 15586 itemsize 53
>                  generation 8 type 1 (regular)
>                  extent data disk byte 0 nr 0
>          item 12 key (257 EXTENT_DATA 196608) itemoff 15533 itemsize 53
>                  generation 8 type 1 (regular)
>                  extent data disk byte 13676544 nr 4096
>                  extent data offset 0 nr 53248 ram 86016
>                  extent compression 2 (lzo)
> 



> And the bio passed in has the following parameters:
> 
> page_offset(bio_first_page_all(bio))	= 131072
> bio_first_bvec_all(bio)->bv_offset	= 65536
> 
> If we use page_offset(bio_first_page_all(bio) without adding bv_offset,
> we will get an extent map for file offset 131072, not 196608.
> 
> This means we read uncompressed data from disk, and later decompression
> will definitely fail.
> 


> [FIX]
> Take bv_offset into consideration when trying to grab an extent map.
> 
> And add an ASSERT() to ensure we're really getting a compressed extent.
> 
> Thankfully this won't affect anything but subpage, thus we wonly need to
> ensure this patch get merged before we enabled basic subpage support.
> 

Is it possible to simplify the test case? Why is this not an issue in 
the case of the non-subpage filesystem?

Thanks, Anand

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 9a023ae0f98b..19da933c5f1c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -673,6 +673,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   	struct page *page;
>   	struct bio *comp_bio;
>   	u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
> +	u64 file_offset;
>   	u64 em_len;
>   	u64 em_start;
>   	struct extent_map *em;
> @@ -682,15 +683,17 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   
>   	em_tree = &BTRFS_I(inode)->extent_tree;
>   
> +	file_offset = bio_first_bvec_all(bio)->bv_offset +
> +		      page_offset(bio_first_page_all(bio));
> +
>   	/* we need the actual starting offset of this extent in the file */
>   	read_lock(&em_tree->lock);
> -	em = lookup_extent_mapping(em_tree,
> -				   page_offset(bio_first_page_all(bio)),
> -				   fs_info->sectorsize);
> +	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
>   	read_unlock(&em_tree->lock);
>   	if (!em)
>   		return BLK_STS_IOERR;
>   
> +	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
>   	compressed_len = em->block_len;
>   	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
>   	if (!cb)
> 

