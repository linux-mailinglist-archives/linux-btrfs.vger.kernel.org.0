Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECC3CB843
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhGPOCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 10:02:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22288 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240071AbhGPOCM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 10:02:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GDjkhf022991;
        Fri, 16 Jul 2021 13:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yCNeoCVwUtQR7LuZxsVYiZwblZ1TheL83la7RqYwwA4=;
 b=N4/2d+GZRasUii1eq1bKjYaKOBd7Dc2KlL+8cjV4yc8f95LKhZbvF4aO+wv1BB0r0dGb
 cjj5H+MAz3IWLnawzI3nV9N+/dULrwFYWKZToZShquOyFcCp/F+510BZNXobFvolzAex
 Kr7546zb5y9+edqPlkWxT2fGi5Dsj+cdkGFnvSuXVIZBvlySk3mEBsygYlbaS475934z
 JbChb/9NK7uMyxuq4R+/G0peK3dmo0rIW5ZAfIntmE9Mf4eDve4xriXCE61jpl3/vUvS
 aCzxVkCnJdkBD9kJ/IkAqtAM93eURpP4zL7rqB+96zbAWsNdZBcN2y+LT4ao0IBZftqT vQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yCNeoCVwUtQR7LuZxsVYiZwblZ1TheL83la7RqYwwA4=;
 b=Y207mMWXAcxM0YVl/60gTMlJI0froiUeqJyiHqbELnQ/g2cEjSb/0GoLH0Dhh78vwJE0
 2VBQMhw5idXjw83wDDuzjdoan7tFqrBmvjJ+dl4Bi2Cu/B7u39jdbVLGNnhaUR7HY/Xj
 BHdpYgxJidJspNBKw+9iowYM7XV8zfG1YZg/XKyjIJ5wQftHDfazwoerr+cph2OlWr5j
 IDMI8ssFJsAsO4i2djFppF0tSoNxvXFDi7EWxxkPQN2hvP7zzqgQi0uQaByqFPl+xjng
 sl83wF1NVGhfVnUY4XKx24yNoDY0WCIBHwq8wYXOgYdsBuJOXkzlzVjQrfSSO53l/Ur7 tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39tw2w1dwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 13:59:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16GDsqAC097824;
        Fri, 16 Jul 2021 13:59:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 39twngmk84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 13:59:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIei/Koe+VthclSR23zCWO8nMTvRHL+4Yp7gJDObd5EM+kdZhVdR/zuzWRs9c783mc03nAMRC15nayMqVqo7cY1Q0TyQcpWKXfxSCw+bKER1YbL8EPjPr4sVegFWbvELzdcnP1I2ewAZEts9/nVPTKFaJ4INqf8HarILcgjJflUf2jpuuxOcEgQGoU3YQ3uJvLXYrbTNOvvxUvsVA63SaNDJXhzEU9jqB4JXIl/2Y3Dury9ZoqpOih4Kv8Ubdz1T70snpcWHuznMM8cHe1izF68TDmBbgBMKv7renjdM7N7BsyG4IqTLArOkHilCQ/qlB9sFqYOIqu8I29BdPZ9ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCNeoCVwUtQR7LuZxsVYiZwblZ1TheL83la7RqYwwA4=;
 b=VKKZP77sZqaXZkCr4tVs1tsSQaXkAd884JLbLuDYCWEZDzo3m/Y2+sp9pxRhH4229+msvYv+Jb+nr/+ykPEDfLAej1TR5gJ7vnq5Z1QbcZQ5kqTdW0bqQbXo1RdT7fq6SzdR9P8yzC9I49QGeqkgdNmyc3ib2LiIJRUK7IPUD40LU4AOczXQX0rIFw3PYIyu/4qhHJeu3aOuRnZitu5sZ+Ih3kjNv5VFFenpJkfjqosIkHdOSGFF8k9s/FtIv0I3AWAqsi3uMatmTFkTEljVvHxA+gAe4NHjyXWBE5J3q2RPmyilG+JKaoQWmNvSwWpXQ6gd4Dsj0m69qBHCWez/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCNeoCVwUtQR7LuZxsVYiZwblZ1TheL83la7RqYwwA4=;
 b=ba7aRyybxzzAA/bZYqXTWwIDRCQA0OmcjoFg3jQiXwGDmkTwY/s8+jcpwVlm+24VAzZzReZF6ufzV2HkDx3mC9ZAe0yy0vufJC7O3WcLG9Fdq17pR0+e2xfOTwqlSsHkXGzy/qJjMFe+TztkQsoqFcvGItm2N7N+fjUKLKkp8vU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 13:59:11 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::cd3d:1a12:e1da:4cc1]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::cd3d:1a12:e1da:4cc1%9]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 13:59:11 +0000
Subject: Re: [PATCH v7 01/17] btrfs: properly reset @this_bio_flag in
 btrfs_do_readpage() to avoid inheriting old bio flags to next extent
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210712083027.212734-1-wqu@suse.com>
 <20210712083027.212734-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <387125b0-073a-6735-9b77-bb25515c4811@oracle.com>
Date:   Fri, 16 Jul 2021 21:59:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210712083027.212734-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0120.apcprd06.prod.outlook.com
 (2603:1096:1:1d::22) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0120.apcprd06.prod.outlook.com (2603:1096:1:1d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Fri, 16 Jul 2021 13:59:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b8a2dc-deff-45ec-6b7e-08d94861e2e8
X-MS-TrafficTypeDiagnostic: DS7PR10MB4925:
X-Microsoft-Antispam-PRVS: <DS7PR10MB492517C0A9D8228A9F700C24E5119@DS7PR10MB4925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfo5l/4za+XwM24DFqv/CtGF4Vn4dAGQcGFPH3G5mjBgISdTW/wrZlKPL2+KXq/X7l4VOmgI0Q8oH+/5YZ9yNkeYII2DNbsnjzlZKKLj2PtP5KsLErQvk8VXJJJrxKW3n3NzTDNw9nnTmpWe0fjz/f4SSWIWJsJPDj9v4VUqRi9FzdWAajPsDQ7Jpoo305DLlNbBBA6R2IneSYpGsBZ8K6mgIKIpUB0XvfH70SbuwLQgzJkviI7VmRdDt7/gyKBwpqKBN/nm1NyXfLYDAg2AhtVXbg/YW9nQ1YLw8EBT0npJgmhAvE6fFDO1sYroEso6RutbXbI9FskAGXkbZxgceC+cvzpHEuvx9aNX4quAQPH3fTvQLIEotrFH+hk4Y5IzSZdrLscusgujX09g0fVu3ybrnPQeIVTVWwXHvL9L3u4K5/thtpJD8hg+5bnEvHkzVKBWh33kU5xmLYw4ehVE4h5+QDanLu5sichG4cqoiKh9WJCgt/UZ/UXbhmlTCaPSU++SQCygK2Id8nJVpbA+jeRr2t67Hha+UTIN8YH6WLIABQ2aXC1ZVtFnExS0TOqUzfckeBqPkbZvzR+UDkRJFFpP5Yvysh/uLuyF/Fv4LUZmfMB/b5g7e4nNpK220jnMsZrLO2ZMG0Kr6C/ik5rV1O/oMP/wSSxCTj8wpC7E+CM3czJtpjyfRidDD7hDBkZywCrQMHXQ51ct/cV0Ks33puWGTips3WljpPxMvxlDs1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(83380400001)(86362001)(2906002)(316002)(508600001)(8676002)(16576012)(2616005)(31696002)(66556008)(66946007)(66476007)(44832011)(53546011)(36756003)(8936002)(186003)(6486002)(956004)(5660300002)(6666004)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXdONU1KckJpOUgyenJrZXdyYmlOdHJCZlNhaEZsL1F0QXZyZ1JMbU9mWlkw?=
 =?utf-8?B?N3lVb2ZWUHdLcks1ZENoMjRJb2JlZllQM21COHBIb0ozQ0RDclZEcCsycVBK?=
 =?utf-8?B?ckZIdk1NWjV5SnI2UlZMTVZ5VW5qc1FWSGZmeFJhdm8rdGJSUlBhcU9JQ3lW?=
 =?utf-8?B?VHN1ZjZVMFp6Z01pbUFET05BbWltenU5Yk4wRS8vSXV3MU9SWTRROTdCREdo?=
 =?utf-8?B?MDNDNTlWRE03aFhGL0krakJnVjNKMDErRzRIeURZR2lLOFp1TTBjR1k1QjRR?=
 =?utf-8?B?Q2YrYmVaYno3T1k5Wi9Jd20zcFdtbTFqUFdXNGFlSzNXSnQ4TTBYTXo1NHRI?=
 =?utf-8?B?U1RzeWNOV0NmY29rVGV3YTU1ajVnd3JDY3BtWG5sOU5kUWRaYWF5aVViekQ3?=
 =?utf-8?B?d3ZmOFEwTHZJdXp4QlovakI0bkpLcVh3K0pmNUpNZS9tVEJodlFlZjhYNnNh?=
 =?utf-8?B?TWpUa1kvbmRrekhzek1uRUNzaWNURGZiNFRtYnYrSlpkKzQ0QlhCUVhycy9Q?=
 =?utf-8?B?anhaTWlZUjJKTW5lYUxvUUFOT3RDbkZGR3EzbVdMaUJ2M1VNRGYzalloNFdC?=
 =?utf-8?B?S0kyZTNqK3JDTVE4azlWNnUvc0pvQ0R2TW1pWGNBRnE4NUtNS3BTeC9MdS9q?=
 =?utf-8?B?MEFRUm5XOHhxV3JvSzd5UlhhQWt1VlVwTWZxYTE3MkMvQzJEaWtGc2RRNHJI?=
 =?utf-8?B?cWJBd3VOQkhtMS91UGNGc3JKT3dIeklPcFFYM29UbXdGL0diM2hBYUZIUHpq?=
 =?utf-8?B?YWR0ZSs3MnZ0MENOTTZOWXNReEVPdTJ3Vlc3Siswd3c4Z1VXK2grMzRjWXg1?=
 =?utf-8?B?R1RxOE1JVkFYeDNUNWpLWENaUmV5bnlOSlRTVTVaOW8ydzhaZC9ueE5kejYx?=
 =?utf-8?B?MWd3bjM2NjNGcDlDN1h5U05FY3YyZkVzT0N3NmJER3NkTEZxQm12eVlnUm1s?=
 =?utf-8?B?WTRSc1c4L0dFMTRxclJFSCtaZEF5WXdVMUxldTY2NVRsVE5JOGloR3ByOVJG?=
 =?utf-8?B?M1lZTWh0Z2xPTkVpT0xNcW1qZjl4U1FHYml4TnNUbi9YU1RYczAzMzgrM3Fi?=
 =?utf-8?B?TEJJQkVWM1N4UXhnVExaNVF4VVdJY2FmVkJCbGtCZGFmamlUWDc1Mm01YnFB?=
 =?utf-8?B?dCtvc2xFL0QzZCtLUUtrTHpITkI3TGpudWdXbnN5aWpHanpPbCtxK2svdDZP?=
 =?utf-8?B?YzBBNDlMK1loNEN2VGhXYTlRWTlIT0VxUlB2UGFvTE0rRTFZc1pCVlRzQjBD?=
 =?utf-8?B?WXpTelpOREducXR3WTc3VHhGeXVHZzNQYlk0bXNKby9xaFc5MDlIL0tnZXpz?=
 =?utf-8?B?d1k1UGlZeSszZkxsWU4xK0d3Zm5UR3hoZWgxemdXTkJONUJ2SnI0TS9lcnNG?=
 =?utf-8?B?TG9JMjlMRmR4dThETU44T2laYXpSc29XMVI1bjRBVWtaTDI4R0FvY1l3NGl1?=
 =?utf-8?B?OWwrQmNLWFdpLys0dEt4UklPY1h1NmhaR2J0cGNVbHlxMkswQm1uWTlRdit6?=
 =?utf-8?B?eEswOVBvRnl0QUk1QTFmckFvZXZPbjBTN1lpNDVObkpLTFNIYmdIbzYxbW1j?=
 =?utf-8?B?d1VBdEZTTmcwcC9QbmlFU3Vsa0l5cktpSUd5U2dNaFFhajhkdU5XVVlUSDl1?=
 =?utf-8?B?NEpPYSt5M2dQTXNyL1ZlM1RiRnhBeTFOcnI2RFFKc25HRnJOVG9EYzRib2Za?=
 =?utf-8?B?ZTVzL0NUbERrcWp0WGhwSkhRR3RacUZLaG9hMG1Udm9heCtDRFdZS2lHSzlU?=
 =?utf-8?Q?tb3hfoEoY3cau2DZEZZZVWNvrdZldEGGovtsHTg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b8a2dc-deff-45ec-6b7e-08d94861e2e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 13:59:11.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZbFEIK9HumC2FCJk9mqMBXaVCyw1IGH08Oo69v+nJBLyI2B5rVsQyvuGV2mhLFaZ37M9rorTE66aQVd432I0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10046 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107160085
X-Proofpoint-ORIG-GUID: GfQnyB-WDVb9vHZVvF8pfKMAzOJFMLqh
X-Proofpoint-GUID: GfQnyB-WDVb9vHZVvF8pfKMAzOJFMLqh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/07/2021 16:30, Qu Wenruo wrote:
> In btrfs_do_readpage(), we never reset @this_bio_flag after we hit a
> compressed extent.
> 
> This is fine, as for PAGE_SIZE == sectorsize case, we can only have one
> sector for one page, thus @this_bio_flag will only be set at most once.
> 
> But for subpage case, after hitting a compressed extent, @this_bio_flag
> will always have EXTENT_BIO_COMPRESSED bit, even we're reading a regular
> extent.
> 
> This will lead to various read error, and causing new ASSERT() in
> incoming subpage patches, which adds more strict check in
> btrfs_submit_compressed_read().
> 
> Fix it by declaring @this_bio_flag inside the main loop and reset its
> value for each iteration.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1f947e24091a..a834ba61a729 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3487,7 +3487,6 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   	size_t pg_offset = 0;
>   	size_t iosize;
>   	size_t blocksize = inode->i_sb->s_blocksize;
> -	unsigned long this_bio_flag = 0;
>   	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>   
>   	ret = set_page_extent_mapped(page);
> @@ -3518,6 +3517,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   	}
>   	begin_page_read(fs_info, page);
>   	while (cur <= end) {
> +		unsigned long this_bio_flag = 0;
>   		bool force_bio_submit = false;
>   		u64 disk_bytenr;
>   
> 

