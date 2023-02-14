Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0678C69596A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 07:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjBNGri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 01:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjBNGrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 01:47:35 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F52EC65
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 22:47:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec0xTLdfxH+P4MuC2iCH1kGHOvFhX3Uh9mQ3S57/81xMySEkYS1B0YzmqnBRnt5u7n03BDl8PXI8UbgjKmxUtKNF0IBpMGyETtO48j6hR272yurSE/O332KmS3mgMtSzKDzzrZBDaXKHdTQVZMn2poWJKR4BfrqSopYIPBJRCsv86L/Sxy9dp+CbKjhyw72BvkZCaI8cMvmI4xr96KNL/t3Y9uOb/I9oO52tYUHtsAV+5wzGesEL7i7+b+lr8jLFManoZmfTG1ymiDN8GBGFG+J7pbVvdnK9gnRahLn1duP33XOHRt3hHIUkykWnoRVSfrvC9Se688xmP3fDM1JPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu9qw/TdRc0/YXYfx1qLdtYJr0vwdjxeRgHhNlnl2Q0=;
 b=VdIBDyi9uyziuCdau71cTwPDKjH6I/TVxUziGs0EUCzK2Ngf4IbW8k33zwJsxUWTab2iVcx4vVlFstqFshwuWylbsd9AzmJJUBVQcQXyzxfIMPeebruLcENrLntgAiejRU1meCtsUywo2zgw/UIhe5BLTy8xgzs/DNtIMOLdg9rMV4cj1+q5u88texY4c3tEYm229fMU1Az1OCflJexusi4jqqaPqJPXgV/tCje3bybekCVQpzoDyMM7cPw3raifEGlFCjBcPfRhjzuxrlZbRchS7SFonVF8jFeu+1LC0QMaWXDnFOv3bjPIzjrUWGfObJg7I903jgdmQrNArhW0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu9qw/TdRc0/YXYfx1qLdtYJr0vwdjxeRgHhNlnl2Q0=;
 b=Rt2kHdPaARb8fd/Md6wdwJwnel7j9vts8ktIXrvOeF5v3mCUDeNjdxvVFoEN6YHpAj/mkp9pKuAMleiOnoQreH7ZMZc3hwy08MsBpl7l16JjMX1Iz6AI1Fd51U2A7DlF8sTvE9PG98Mx3PVCF/Nlb7FMVezCikvHep+WtoM2lnpzSzqpKDoWZZVFLAS6GVe5hjhM0KACCA6gCn/4lEF6sI6CFWfmKpuWhxZ6JwLy/ff7XmpJXlxpOjw2Lhh7HtmFOW0jXEeebxjrhlOjBGy0VHJLkZ1aEomOF/wRKKyfHjhpla14C80Pvz1DAXaYvlf+tyG6K06H+AifJepdxRolyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Tue, 14 Feb
 2023 06:47:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:47:28 +0000
Message-ID: <464fc249-15dd-52ff-9035-e57aaa4b499f@suse.com>
Date:   Tue, 14 Feb 2023 14:47:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
In-Reply-To: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb4a5b6-de15-4484-8d5d-08db0e575653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPTSxEOpTWrLZdm/bqse8v64Jwp5ADJqOz+y68ksVayoGvooAwKDf5KrbIDYgICRTlniCWwPDZpz4jMktlh9wOP/5zHMzPS/jlWprxSyWpN7EfBRRMwA5bD1yccvQF5yHZy4kq+cMvAelBcDHSslRxWg1DxnH437UAnAo4AWL7MuiYQ93OXDkmeVfLval1wwIt9PrgkkU1+DY1tUsOTC6NoJ4sw2VX0lG7kOalgRFMAAuAAkKllqThgL2ZPflGXzo2haIyy3P2Xl4nc7eJg+TQ7a/DisPuyTtJdpKr+FybnC6i17nPJYGXE96cMs6TKZW7ox2DDuUc+BnLKGitl8dzvCapsOOAN9BuTQudJCYaRKmDyeB6KjJneiD0guHHtdYLwtO1BTwq1izqJyr5QA81OhwZpYqz2/45bluIsmlhito3DukubBZgeIyosTCnt+jdX53vBftquWIYOLnZnwU16uLO2bdf3TEy4mbOXkPCq3eHqDFikiZLC9pU5ta5vF7BxQr8Kl+dv4jN/jUFhfJS4F9uHWJoPR4JnIJWDACDOKFjot0svmnIPZzthrLfRHxkMHNViTvJVUTdj75rPoEaPHYFVjW+lP4a50vf3TMVvdxFlKthUpDagtUfX1tBEigo32GKsI/2irWdoRFgbgyKOjaRvrc9TguVjS9c+PPhCMupOfw/kVJnDdp//7eTHegQHUvonoy10AoxnAQEW0J/KxkcD2i1F8HEjlDC5RR/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199018)(38100700002)(316002)(31696002)(6916009)(8936002)(8676002)(66556008)(5660300002)(66476007)(66946007)(41300700001)(36756003)(2906002)(478600001)(83380400001)(6486002)(2616005)(186003)(6512007)(31686004)(6506007)(6666004)(86362001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRIemI0U0JueThjUnA2Z2o4NGY2eTYwcGJWaFhFSzJRR1NxT3ZoS3pONGxG?=
 =?utf-8?B?ajNjT3hDVlkyelNQNUNzZksycjVMMVRieURreTVVaEE0Rkx4YzhER2puRGtH?=
 =?utf-8?B?SmRUWGp2T2k2Y29KR3ZJZEZsdXpuQ2c5bUlWVGV2UTlTc09GdFI4SWxVQ0VU?=
 =?utf-8?B?SGxKZFU0eFJvdUp2a0N2Rm1UUysyenhNSThHcytaNVB2b2ZFT3lBQmdMYlNY?=
 =?utf-8?B?KzNXeUJDaEVjWFFwT0wzbHJBWjRSZjJjZ1NOMTlDcHJ2aFA0aEhXSXJYcXRX?=
 =?utf-8?B?eGJWWmY0NkpLWG4zMzM0VDlqZ0JLUDlENmZ4VGJIcmZYQ3lVSGcraHQyNDFN?=
 =?utf-8?B?UWFpZVdDdGtpck81SFpGTUFGdXl4NTZtMWxzK09zNWh5OURGMVlBTHZMcWJ3?=
 =?utf-8?B?N3ZTUnU1S1JubTRqMUxoSjZvOEZOZ1d4dlBPbk8yS2E3dEc3d1NKY0RWdEY2?=
 =?utf-8?B?U0lkYU5WK29XSHErZlU1UlV3K05jRnZtNnBlY2M4NHBtSS9sZ3Fpb2RaN21n?=
 =?utf-8?B?VmoxaTNTZ28vR3ovY3VWb0JOSWg2VmdGRlNKUGtCSG04UjQybkFLMDR5Q0NY?=
 =?utf-8?B?U3B2aExSV3pnSDMwcmZSM2FHdDdkMzBIU2xHRWxSanE5WGtBRFVSMzMvQnRP?=
 =?utf-8?B?eXRwMm9XaHdwOENqZVJwRlMrQ0h5VVlja09JdEZyT3RVRjkvY2ZMTEcra1V5?=
 =?utf-8?B?MU1RTTU3ZnlqeXFzSkRpR2hKelFJU01VQkMyVEdKUTBIVjNCOCt5UENGMTdG?=
 =?utf-8?B?ZTlOcmZJdFI2eXF1RzBxT1NCRDlYV3RSRGdKRkF2SU1rMkg5UWxIRlFjSm1m?=
 =?utf-8?B?cTVTakJGd0JtWVBsU1BQeGJ2dWRjQy9OdHpnaGdPYjNFeC82SGhyVEhGdjMr?=
 =?utf-8?B?cGoxazhqOWVkeUUvL3J4aFIwcHJrS28xQUNWUHdyU0pLNWhNVEFtMFlyYmYx?=
 =?utf-8?B?UWc1K2g3eFlxemNjQnUwbGNYdERhR0ZCNXlFSzVlQ1F2ZFNuSlhXY3pXRlhQ?=
 =?utf-8?B?Z25QWmZIaC9NR01LL0dQbzEzb3MyUkFPNlJyK0Q5bjFmZEdhTFkydUpiTGl1?=
 =?utf-8?B?M2JYWFNxV3IxVkpsOHlVMDhzNlAwYldoT0J3VjRVRHhQa1pFa3AyR3lRZXlW?=
 =?utf-8?B?NDF5eUJrbHc5eDAybnk2WHZGSUR5Ym1sdDdJUWdPVThHL0ZhVzlUbXZBMmp5?=
 =?utf-8?B?N3ovb09JMXNQOTFRQzl4UFdFVzJmRVdLTFg4WWk5ZVlKaEdiMU0wZTJOTEY5?=
 =?utf-8?B?WC9vUnZrcDdzUC85L0M2MUM5aC9xaGJvaHppVFBvMkxZeU5yT1IyRmpkbFNP?=
 =?utf-8?B?YmlLbm15OTJtRFd6ajNkYTZGZVNRVFJiVzRNTjhvY0wxZWZTUk1ReVFuU3pL?=
 =?utf-8?B?bnVGemJVWDhxQlRmVUIreWNEWDVnSHBlak1ZVm1EdklEbDFUbjZVN2ZSSWQw?=
 =?utf-8?B?QU5ieXlmVmUvb3A4eThZcHlaZjUwUGpGZmNtTldwZGVQSStTR214anVNYmcy?=
 =?utf-8?B?R3lJRitHNkFzak5yano0aFpDTnlnaisvZE5qY3BXYXpMTms0NmRDeEN4V2Jp?=
 =?utf-8?B?emcyc3ZwblRBZVdIbHJKbkxleDJQTW92RS9YYisxR2hsaWRNOEpMcTBKL3dB?=
 =?utf-8?B?cVB2dmx3UUJJcTdvVnJPZml6YTFUdU1hUTdSWldkNWQrTWZMUFNCemVJTmtB?=
 =?utf-8?B?eWJlek5KUWxydG1QNVl5czhZRmRmSTc3Q1FwNDVjRFN3R1hvUHd2MHhqdXo1?=
 =?utf-8?B?c3NsZkh1ZUZJRjA2SklYeDN6ZnA0TUdvQnA5NXpRVFU1VHd1RVloMURlU3N3?=
 =?utf-8?B?V1l3TWxvR0tYT3RSUzRoeERLYjA0aHZHbFA3a1FaNi9hNGtoK2pQMG5UOFBz?=
 =?utf-8?B?TXo5QVhxdzB6aVMrY0RMOHkzdk1jUFE4amMzMzVUVHF5ekZVWkpFTDQxSDAz?=
 =?utf-8?B?MGQzSmVvK0xMVUFBcVJwZkNST3BqKzVXTjFsdThSOWZJbUdaWEUwWkNxM3do?=
 =?utf-8?B?OFJpZ09IMyttRW1KbVEzWWZWaFFZVVNJWW1mbjFJUGxFaERkYkdkeksvOGt5?=
 =?utf-8?B?YVdtZldxSHB3SUVyZmhteFlwaXJlYWM2STNzMjNnTHNmakd6QW1aRTZQUWJO?=
 =?utf-8?B?VFlsYURxSU9NbENFQmRyV2JYVDVRcHQrRXdWdnZ4YXJDVGRIQzRRRDdqQTAr?=
 =?utf-8?Q?22hp8v4HICHG55cS+bDS8/U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb4a5b6-de15-4484-8d5d-08db0e575653
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:47:27.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f9qKJ6tdd4ITUKdKf7Am8FQwWvhnRc8788B/ZtOTpEdLzMNREedtwdxosPOlGFe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any feedback on this?

Whether we get rid of the extra mirror of dev-replace would greatly 
impact how my incoming refactor on __btrfs_map_block() go.

Thanks,
Qu

On 2023/2/9 12:47, Qu Wenruo wrote:
> Since the ancient time of btrfs, if a dev-replace is running, we can use
> that replace target as an extra mirror for read.
> 
> But there are some extra problems with that:
> 
> - No reliable checks on if that target device is even involved
>    For profiles like RAID0/RAID10, it's very possible that the replace
>    is happening on one device which is not involved in the stripe.
> 
>    E.g. a 4-disks RAID0, involving disk A~D, and disk A is being replaced.
>    In that case, if our read lands at disk B, there is no extra mirror to
>    start with.
> 
> - No indicator on whether the target device even contains correct data
>    Since dev-replace is running, the target device is progressively
>    filled with data from the source device.
> 
>    Thus if our read is beyond the currently replaced range, we may just
>    read out some garbage.
>    This can be extremely dangerous if the range doesn't have data
>    checksum, then we may silently trust the garbage.
> 
> Thus this RFC patch would just remove this feature.
> 
> Yes, I know this would reduce the chance we recover some data, if we're
> replacing a failing disk.
> But in that case, if we're really relying on the failing disk, but not
> some extra mirrors, I'd say we have a much bigger problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 124 +++------------------------------------------
>   1 file changed, 7 insertions(+), 117 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3a2a256fa9cd..385fc89b6702 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5754,12 +5754,6 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>   		ret = map->num_stripes;
>   	free_extent_map(em);
>   
> -	down_read(&fs_info->dev_replace.rwsem);
> -	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
> -	    fs_info->dev_replace.tgtdev)
> -		ret++;
> -	up_read(&fs_info->dev_replace.rwsem);
> -
>   	return ret;
>   }
>   
> @@ -6046,83 +6040,6 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>   	return ERR_PTR(ret);
>   }
>   
> -/*
> - * In dev-replace case, for repair case (that's the only case where the mirror
> - * is selected explicitly when calling btrfs_map_block), blocks left of the
> - * left cursor can also be read from the target drive.
> - *
> - * For REQ_GET_READ_MIRRORS, the target drive is added as the last one to the
> - * array of stripes.
> - * For READ, it also needs to be supported using the same mirror number.
> - *
> - * If the requested block is not left of the left cursor, EIO is returned. This
> - * can happen because btrfs_num_copies() returns one more in the dev-replace
> - * case.
> - */
> -static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
> -					 u64 logical, u64 length,
> -					 u64 srcdev_devid, int *mirror_num,
> -					 u64 *physical)
> -{
> -	struct btrfs_io_context *bioc = NULL;
> -	int num_stripes;
> -	int index_srcdev = 0;
> -	int found = 0;
> -	u64 physical_of_found = 0;
> -	int i;
> -	int ret = 0;
> -
> -	ret = __btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
> -				logical, &length, &bioc, NULL, NULL, 0);
> -	if (ret) {
> -		ASSERT(bioc == NULL);
> -		return ret;
> -	}
> -
> -	num_stripes = bioc->num_stripes;
> -	if (*mirror_num > num_stripes) {
> -		/*
> -		 * BTRFS_MAP_GET_READ_MIRRORS does not contain this mirror,
> -		 * that means that the requested area is not left of the left
> -		 * cursor
> -		 */
> -		btrfs_put_bioc(bioc);
> -		return -EIO;
> -	}
> -
> -	/*
> -	 * process the rest of the function using the mirror_num of the source
> -	 * drive. Therefore look it up first.  At the end, patch the device
> -	 * pointer to the one of the target drive.
> -	 */
> -	for (i = 0; i < num_stripes; i++) {
> -		if (bioc->stripes[i].dev->devid != srcdev_devid)
> -			continue;
> -
> -		/*
> -		 * In case of DUP, in order to keep it simple, only add the
> -		 * mirror with the lowest physical address
> -		 */
> -		if (found &&
> -		    physical_of_found <= bioc->stripes[i].physical)
> -			continue;
> -
> -		index_srcdev = i;
> -		found = 1;
> -		physical_of_found = bioc->stripes[i].physical;
> -	}
> -
> -	btrfs_put_bioc(bioc);
> -
> -	ASSERT(found);
> -	if (!found)
> -		return -EIO;
> -
> -	*mirror_num = index_srcdev + 1;
> -	*physical = physical_of_found;
> -	return ret;
> -}
> -
>   static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
>   {
>   	struct btrfs_block_group *cache;
> @@ -6335,14 +6252,13 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	int i;
>   	int ret = 0;
>   	int mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
> +	int num_copies;
>   	int num_stripes;
>   	int max_errors = 0;
>   	struct btrfs_io_context *bioc = NULL;
>   	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
>   	int dev_replace_is_ongoing = 0;
> -	int patch_the_first_stripe_for_dev_replace = 0;
>   	u16 num_alloc_stripes;
> -	u64 physical_to_patch_in_first_stripe = 0;
>   	u64 raid56_full_stripe_start = (u64)-1;
>   	struct btrfs_io_geometry geom;
>   
> @@ -6365,6 +6281,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	raid56_full_stripe_start = geom.raid56_stripe_offset;
>   	data_stripes = nr_data_stripes(map);
>   
> +	num_copies = btrfs_num_copies(fs_info, logical, geom.len);
> +
>   	down_read(&dev_replace->rwsem);
>   	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
>   	/*
> @@ -6374,19 +6292,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	if (!dev_replace_is_ongoing)
>   		up_read(&dev_replace->rwsem);
>   
> -	if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
> -	    !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
> -		ret = get_extra_mirror_from_replace(fs_info, logical, *length,
> -						    dev_replace->srcdev->devid,
> -						    &mirror_num,
> -					    &physical_to_patch_in_first_stripe);
> -		if (ret)
> -			goto out;
> -		else
> -			patch_the_first_stripe_for_dev_replace = 1;
> -	} else if (mirror_num > map->num_stripes) {
> +	if (mirror_num > num_copies)
>   		mirror_num = 0;
> -	}
>   
>   	num_stripes = 1;
>   	stripe_index = 0;
> @@ -6511,15 +6418,9 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
>   	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
>   	     !dev_replace->tgtdev)) {
> -		if (patch_the_first_stripe_for_dev_replace) {
> -			smap->dev = dev_replace->tgtdev;
> -			smap->physical = physical_to_patch_in_first_stripe;
> -			*mirror_num_ret = map->num_stripes + 1;
> -		} else {
> -			set_io_stripe(smap, map, stripe_index, stripe_offset,
> -				      stripe_nr);
> -			*mirror_num_ret = mirror_num;
> -		}
> +		set_io_stripe(smap, map, stripe_index, stripe_offset,
> +			      stripe_nr);
> +		*mirror_num_ret = mirror_num;
>   		*bioc_ret = NULL;
>   		ret = 0;
>   		goto out;
> @@ -6584,17 +6485,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	bioc->max_errors = max_errors;
>   	bioc->mirror_num = mirror_num;
>   
> -	/*
> -	 * this is the case that REQ_READ && dev_replace_is_ongoing &&
> -	 * mirror_num == num_stripes + 1 && dev_replace target drive is
> -	 * available as a mirror
> -	 */
> -	if (patch_the_first_stripe_for_dev_replace && num_stripes > 0) {
> -		WARN_ON(num_stripes > 1);
> -		bioc->stripes[0].dev = dev_replace->tgtdev;
> -		bioc->stripes[0].physical = physical_to_patch_in_first_stripe;
> -		bioc->mirror_num = map->num_stripes + 1;
> -	}
>   out:
>   	if (dev_replace_is_ongoing) {
>   		lockdep_assert_held(&dev_replace->rwsem);
