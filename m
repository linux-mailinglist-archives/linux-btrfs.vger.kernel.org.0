Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8848A4C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 02:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiAKBKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 20:10:50 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:52785 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346113AbiAKBKs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 20:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641863445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2SRwxhKh8vO0XTHaICMnJJXvVjqSSO+gJAwWtYoOzI=;
        b=NqdfPo/q8XnWzhlVU1Mcqxn4943iSZruYKC6Ixfg48K3RVfEgJf6HTkUEXS+g2NHadCwQ2
        2hkvxV68c7FUbtbj448NUN/V31GItjV77NBeaSCdubTSK0Ea9qxtzecw/Q1NjCADz+HjQb
        alAU/JrDiBcrNVIX/kzYvM0ZCV21Jr4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-WmIv7INbNZ2G4OjNGYJQfw-1; Tue, 11 Jan 2022 02:10:44 +0100
X-MC-Unique: WmIv7INbNZ2G4OjNGYJQfw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm7SFrAB/MV24hcWRoHS8sDDa8ELv3aVM95/3XzkHnw7/wSGwn+87VcbOlUCwwzRx53ATvuf4c8O5Y+4bL6AuUnU6pAB6YPlqJDx6NMWyzWIj+7BOaFVtMd8ve9XYg6LOWvnEEBCIUdMxGlRSKKsV3DtOzcM4J6ajmBIybu/xH82Lepq57/ltsQm+3jElxNB+H6Lg9dxM2y+dQZiaYFVBP43WQwr2vBk1RIT4Y1orhwzfl6FHqT/K7nLYE2FJd5XvpOGLbUmiA0MDKVJFH9HltayyDPBbokxZZ6ppnTah2yGn3AuxV6vyKtCww5h4Yw707T4ljPo1BBqta19ebeGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2SRwxhKh8vO0XTHaICMnJJXvVjqSSO+gJAwWtYoOzI=;
 b=DU4BjNOWFNeU4L6Clfjz8Wi1r7tpM/i6QKN47CjcB5PRuYGJtIfkyWsVg+sSMZUfN6BFaXr09inph8X41x0AK0kuDy/2A0YOOYlhrMt8mpeBAx7dRb9lLN/0Cw4312QAWz+Qfyi4l2CSH4tFHSXNrKTn1ld4LBzFWDP3xbsOFGlR32+vVuEYxFxPG5dDxiEsY84ZIxwLHj+j+K8MbF13qaz6Vp3nF96ASA8ZHPEfsbdx/KxTHakZ3PDKhs3v82it/MPn0VQkTtrx8YCWQpQWN7ZPG52hxDUJ9E2eZe/dvRjyRE0mPyRyuyenKv9tJmDcejffLs1T6gFMt3/iEpfQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU0PR04MB9322.eurprd04.prod.outlook.com (2603:10a6:10:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 01:10:43 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%6]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 01:10:43 +0000
Message-ID: <57d67f29-99b7-9190-f120-6cf78febb4dc@suse.com>
Date:   Tue, 11 Jan 2022 09:10:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20220105022812.45698-1-wqu@suse.com>
 <20220105022812.45698-2-wqu@suse.com>
Subject: Re: [PATCH 1/2] btrfs: make nodesize >= PAGE_SIZE case to reuse the
 non-subpage routine
In-Reply-To: <20220105022812.45698-2-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::31) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c41e753b-008d-4631-12a3-08d9d49f30ca
X-MS-TrafficTypeDiagnostic: DU0PR04MB9322:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9322B0C81551F856ABC045BDD6519@DU0PR04MB9322.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpvsMbbFyNKo+6EVlsJGozOSpuYja6Nuc2wcSnilERG+lYNqmA6nXA8No2aRmLzvIa+0aeL93UVMWwZ2V3jD62pHVbjc7ANi10J9nW8DWjbZgcFVSHQCb5SHItFsytqT+sidS+T0sZBqI9/hszlOoDsInETJ/DoEIsFWdaA1Z3SVso5qzdBWosmhc0PUbG5gpW/rxllMumzHTgHV9cMP2BhLz5b4f2eFSKyeyyLIMlRa341tnlWlqUMyKiAykQOQxuige1xsTcCodnPjq7ODKv90qTasRC0p3gAKBRNM+iRfHK9/sHldNDC53LkrqcWBSO1h5epyWVq4dUnuVL3NVo+IJnGfysowGOp37HZBBVLnTtN1ifs02XPgTN+AEBj46QjpU1AmJEevgCCDkI1z4A0dyPWbJYsUxZZNrWFUcYFJDMVFbvLoa2C94ZWKcsUP4VFE8D8ARWsJI0gHzjGM/+vOiaulQrblbe4BUHGo6VWSdwEXTTH7/AWMJ/70FpqmC8P8psS+9M7pkoBqpR0ndpODqUQRbsyV02rATaDwi9U8dWeheeVM43ZpEXkzLCkfIbgKDp30PzQdpKfLRnXNmT1S66FhmqVIPreK0QsqVItZjQXu1OYqxtmT0Rqc4oTasMxUO4+CjsZLakoQZDd402/sFFGnaigSlizJpHlyT9uV5Mr1jEynFqJLhwDsBR+wdY3XpPsKJaeka5VJwgJQH6/MzDs6NMmUW9cQF+p5PU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(6666004)(316002)(66946007)(31696002)(30864003)(6916009)(36756003)(5660300002)(8936002)(38100700002)(31686004)(6486002)(8676002)(86362001)(6506007)(53546011)(2906002)(2616005)(6512007)(26005)(186003)(508600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzN1NW1OajloSCtKTEtSM280RmNsL1Myd0JWV1RGU0t5N3FPYU56MEwvajE1?=
 =?utf-8?B?anlCNUVpa2k1Tzh0RmRaeWJmSHBXSzQ2WnFwdFBIdUxiZEVWUzc0bHlzYlRN?=
 =?utf-8?B?dnhEOEpQK3dpMXF4U2V0R3pnRlBHelhNakhUV3M1eXJ3UDhlMVA3QmoxM0dI?=
 =?utf-8?B?WGt3aVdUc3RoeWhqcDlRM2hsenpJWjNUVlZ0YzR0cFdhYkpJK2F5ZW1oQW14?=
 =?utf-8?B?czR5cEpsZFdDRGQzUXBkaGticm9KL2N3YldOOFhLd2pWSm1qVGwwN2V6MjFX?=
 =?utf-8?B?ODBDeE1TM01lbGs3blNXUkJIUHhMa3FqS29tVzh0Y2pnTjNOU2g4ZUFpSG8x?=
 =?utf-8?B?enlVMjY1RXZqRXlxL2p6Q2dLY2pMQm9lY0swL2wrcHVWTzFLVjgwOFJ2RkF1?=
 =?utf-8?B?QW9IY2pMRlhMZ0I3ZENIdlhrZUV5dEdwRzZlbGxRZXY1enRLZVY0dkNiWW9Q?=
 =?utf-8?B?QmRPWkxJblZobEE0bHJlQTdqTEVHVkk0bkNjR21zdTFjUTVMOEJ6R0ZDREtO?=
 =?utf-8?B?amZsZm1GcytVTmJid2pSUnhJb2p5ZkpyTDNTR2hiMW1RVExXWE5jdENyYlJK?=
 =?utf-8?B?VmtVa1I1WnlGT0FScXUyaTI2akIvR21EQkxrcXNJck5yMXVSeTNhMXBlcVc4?=
 =?utf-8?B?OGNCSnRLZzN5V0l4Wkx3TlBLQnFUMzhxWG5qNlEwSUw1RDJZWWp6Z1l6UUVX?=
 =?utf-8?B?NmpPZ0FsWHRyUkhBOUxZaDk1Y08vRUI3QVJSaVJTaGs0a1d4QVIzZVZGL3Yw?=
 =?utf-8?B?ZWViNDZCOGJPVFE4d0pHMitQdlFsRC84WVhXOGhmY3lqRTNpYkw5YjZBU1ox?=
 =?utf-8?B?QWJieWxkUEx1bFlMZjVOSGJEVHk4anZLN2VyRy80Rjh1a1FZL3duRktIbDBj?=
 =?utf-8?B?bjFNVXdZRWFCUm85U1dsNm9WRTNBMWkyU3U0dmtjSU5aS3V4VVBNOEhFbzlF?=
 =?utf-8?B?dTBGWDRERjVubnd2OWJnaFBOS3JDV05GbnE1THZSN0pobG9lbzdnWWpid2RC?=
 =?utf-8?B?TFIrMmJ4S1hoWGpmQXRwckRVU3A5Z2pkemhBRzZacTFRVXBza1dLZTZHNzJ2?=
 =?utf-8?B?bkRFM3ZvZEo3di9mY0hoTDNkVm9CRkdrbisyai9aenVuZ0dvMWptTHlBWmwr?=
 =?utf-8?B?K3BtbDcxSnFiWVNkZFVPNTl6VDdWRU9CRnkzOGdMK0JrcGgzaFRJNmc1cHFD?=
 =?utf-8?B?ZEl0VktWclJDdm1CUmxSbzBFTHNKQ0RVdTdrUTlVNHcrbFZFVVV6YS93cEVk?=
 =?utf-8?B?R2lnQUlpUFNpWjN4TTArVC9laHdRUXd6eG1HNzRIVjhQR3lFUUNDL2VTeXQ0?=
 =?utf-8?B?SnN1UGJDazg5NHJWcUN3V0dWbG5ieDNrTzR1VnJDMHdKMEtSejhDVFRJME9F?=
 =?utf-8?B?UXJOWlNSUnpsMDBYV0ZNY2hrbUJTcFJIRDNrNDd1N1VGd1VnSEhjY095dXc3?=
 =?utf-8?B?bFpidGJnQlYxTDRka01PaHJQaDN0V1lzdDZvWnRQMEtTK3ozcjVhMTdDc21q?=
 =?utf-8?B?VGZ0N3FvSEt0UDN3K3lzNUVLT2hESUp2eVlVTmlycC91OW5qZFhMK2dzZFl2?=
 =?utf-8?B?ZEwzYk40b2RSa2ZqWWZvc2xTVDdIc0JTODlPRWhHbVd6VS9sbG80RXB0d2sr?=
 =?utf-8?B?aXlJQVFySUFWUFFaM1Q5TWlMQ3ZpZlhyVk9sa1NXWE9mVzVpUW5LN3RyTWRZ?=
 =?utf-8?B?NEUvZDdTWEEzNFM3dHhiekpMZmlaOVRSc2M2KzBBZ05lU1FkNFlzZ3A5bGRD?=
 =?utf-8?B?cVdVSWJSbXlJRFVPTStXdWdKdW9GbkFFRVA0bFNyeUV0RyttWVhBRzRLSUgz?=
 =?utf-8?B?dHg1VWR2U1owRFpaUjJsV1U4Z3d4RjJnaTIzSktLMHVGWVhsM2ZiZE51WDcv?=
 =?utf-8?B?WG5NOE50Z3VtTnU3V08rRThwVUpBTW1GSUxKcG9kU0ZMbitkMzFMSS9wcU1u?=
 =?utf-8?B?Ykd6VURKN2xTL2lSbHlMRDNYVE1JbktWcG1wbjU2blhadEhLVU0rcGdocjhj?=
 =?utf-8?B?MG9pc2VLa3R5VU1ZWmdVWGZZaEh5K09WT0xQZjBaNEFVQzhpV1FZK3dXd1pw?=
 =?utf-8?B?Uy9vVFA2bHdldkkyUGJPMEF3dTk2NDhUWGE1cGJFVk1DNVRiRVF0NXJqUk5W?=
 =?utf-8?Q?RjW4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41e753b-008d-4631-12a3-08d9d49f30ca
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:10:43.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkcz59xfJsGnxwI+i+pUrh4Gk0Tctly67ra2sITAZWZXxh9hys30LmovXrOeLsDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9322
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/5 10:28, Qu Wenruo wrote:
> The reason why we only support 64K page size for subpage is, for 64K
> page size we can ensure no matter what the nodesize is, we can fit it
> into one page.
> 
> When other page size comes, especially like 16K, the limitation is a bit
> blockage.
> 
> To remove such limitation, we allow nodesize >= PAGE_SIZE case to go
> the non-subpage routine.
> By this, we can allow 4K sectorsize on 16K page size.
> 
> Although this introduces another smaller limitation, the metadata can
> not cross page boundary, which is already met by most recent mkfs.
> 
> Another small improvement is, we can avoid the overhead for metadata if
> nodesize >= PAGE_SIZE.
> For 4K sector size and 64K page size/node size, or 4K sector size and
> 16K page size/node size, we don't need to allocate extra memory for the
> metadata pages.
> 
> Please note that, this patch will not yet enable other page size support
> yet.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c   |  4 +--
>   fs/btrfs/extent_io.c | 80 ++++++++++++++++++++++++++------------------
>   fs/btrfs/inode.c     |  2 +-
>   fs/btrfs/subpage.c   | 30 ++++++++---------
>   fs/btrfs/subpage.h   | 25 ++++++++++++++
>   5 files changed, 91 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 87a5addbedf6..884e0b543136 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -505,7 +505,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
>   	u64 found_start;
>   	struct extent_buffer *eb;
>   
> -	if (fs_info->sectorsize < PAGE_SIZE)
> +	if (fs_info->nodesize < PAGE_SIZE)
>   		return csum_dirty_subpage_buffers(fs_info, bvec);
>   
>   	eb = (struct extent_buffer *)page->private;
> @@ -690,7 +690,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
>   
>   	ASSERT(page->private);
>   
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
>   		return validate_subpage_buffer(page, start, end, mirror);
>   
>   	eb = (struct extent_buffer *)page->private;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d6d48ecf823c..f43a23bb67eb 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2710,7 +2710,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
>   		btrfs_page_set_error(fs_info, page, start, len);
>   	}
>   
> -	if (fs_info->sectorsize == PAGE_SIZE)
> +	if (!btrfs_is_subpage(fs_info, page))
>   		unlock_page(page);
>   	else
>   		btrfs_subpage_end_reader(fs_info, page, start, len);
> @@ -2943,7 +2943,7 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
>   static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
>   {
>   	ASSERT(PageLocked(page));
> -	if (fs_info->sectorsize == PAGE_SIZE)
> +	if (!btrfs_is_subpage(fs_info, page))
>   		return;
>   
>   	ASSERT(PagePrivate(page));
> @@ -2965,7 +2965,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
>   	 * For regular sectorsize, we can use page->private to grab extent
>   	 * buffer
>   	 */
> -	if (fs_info->sectorsize == PAGE_SIZE) {
> +	if (fs_info->nodesize >= PAGE_SIZE) {
>   		ASSERT(PagePrivate(page) && page->private);
>   		return (struct extent_buffer *)page->private;
>   	}
> @@ -3458,7 +3458,7 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
>   	if (page->mapping)
>   		lockdep_assert_held(&page->mapping->private_lock);
>   
> -	if (fs_info->sectorsize == PAGE_SIZE) {
> +	if (fs_info->nodesize >= PAGE_SIZE) {
>   		if (!PagePrivate(page))
>   			attach_page_private(page, eb);
>   		else
> @@ -3493,7 +3493,7 @@ int set_page_extent_mapped(struct page *page)
>   
>   	fs_info = btrfs_sb(page->mapping->host->i_sb);
>   
> -	if (fs_info->sectorsize < PAGE_SIZE)
> +	if (btrfs_is_subpage(fs_info, page))
>   		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
>   
>   	attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
> @@ -3510,7 +3510,7 @@ void clear_page_extent_mapped(struct page *page)
>   		return;
>   
>   	fs_info = btrfs_sb(page->mapping->host->i_sb);
> -	if (fs_info->sectorsize < PAGE_SIZE)
> +	if (btrfs_is_subpage(fs_info, page))
>   		return btrfs_detach_subpage(fs_info, page);
>   
>   	detach_page_private(page);
> @@ -3868,7 +3868,7 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>   	 * For regular sector size == page size case, since one page only
>   	 * contains one sector, we return the page offset directly.
>   	 */
> -	if (fs_info->sectorsize == PAGE_SIZE) {
> +	if (!btrfs_is_subpage(fs_info, page)) {
>   		*start = page_offset(page);
>   		*end = page_offset(page) + PAGE_SIZE;
>   		return;
> @@ -4250,7 +4250,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
>   	 * Subpage metadata doesn't use page locking at all, so we can skip
>   	 * the page locking.
>   	 */
> -	if (!ret || fs_info->sectorsize < PAGE_SIZE)
> +	if (!ret || fs_info->nodesize < PAGE_SIZE)
>   		return ret;
>   
>   	num_pages = num_extent_pages(eb);
> @@ -4410,7 +4410,7 @@ static void end_bio_subpage_eb_writepage(struct bio *bio)
>   	struct bvec_iter_all iter_all;
>   
>   	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> -	ASSERT(fs_info->sectorsize < PAGE_SIZE);
> +	ASSERT(fs_info->nodesize < PAGE_SIZE);
>   
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
> @@ -4737,7 +4737,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
>   	if (!PagePrivate(page))
>   		return 0;
>   
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
>   		return submit_eb_subpage(page, wbc, epd);
>   
>   	spin_lock(&mapping->private_lock);
> @@ -5793,7 +5793,7 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
>   		return;
>   	}
>   
> -	if (fs_info->sectorsize == PAGE_SIZE) {
> +	if (fs_info->nodesize >= PAGE_SIZE) {
>   		/*
>   		 * We do this since we'll remove the pages after we've
>   		 * removed the eb from the radix tree, so we could race
> @@ -6113,7 +6113,7 @@ static struct extent_buffer *grab_extent_buffer(
>   	 * don't try to insert two ebs for the same bytenr.  So here we always
>   	 * return NULL and just continue.
>   	 */
> -	if (fs_info->sectorsize < PAGE_SIZE)
> +	if (fs_info->nodesize < PAGE_SIZE)
>   		return NULL;
>   
>   	/* Page not yet attached to an extent buffer */
> @@ -6135,6 +6135,23 @@ static struct extent_buffer *grab_extent_buffer(
>   	return NULL;
>   }
>   
> +static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
> +{
> +	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
> +		btrfs_err(fs_info, "bad tree block start %llu", start);
> +		return -EINVAL;
> +	}
> +
> +	if (fs_info->sectorsize < PAGE_SIZE &&
> +	    offset_in_page(start) + fs_info->nodesize > PAGE_SIZE) {
> +		btrfs_err(fs_info,
> +		"tree block crosses page boundary, start %llu nodesize %u",
> +			  start, fs_info->nodesize);
> +		return -EINVAL;
> +	}

To my surprise, this part caught an exception for 16K page size.
(Great thanks to Su Yue providing access to a VM running on M1).

The problem is, if we use nodesize 64K (which is completely fine) and 4K 
sectorsize, the superblock will cross page boudnary, even an sb is only 
4K sized.

The problem is, we're abusing the extent_buffer for superblock, causing 
it to cross the unnessary page boundary.

Will add a patch to the series to address this first.

Thanks,
Qu

> +	return 0;
> +}
> +
>   struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   					  u64 start, u64 owner_root, int level)
>   {
> @@ -6149,10 +6166,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   	int uptodate = 1;
>   	int ret;
>   
> -	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
> -		btrfs_err(fs_info, "bad tree block start %llu", start);
> +	if (check_eb_alignment(fs_info, start))
>   		return ERR_PTR(-EINVAL);
> -	}
>   
>   #if BITS_PER_LONG == 32
>   	if (start >= MAX_LFS_FILESIZE) {
> @@ -6165,14 +6180,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   		btrfs_warn_32bit_limit(fs_info);
>   #endif
>   
> -	if (fs_info->sectorsize < PAGE_SIZE &&
> -	    offset_in_page(start) + len > PAGE_SIZE) {
> -		btrfs_err(fs_info,
> -		"tree block crosses page boundary, start %llu nodesize %lu",
> -			  start, len);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
>   	eb = find_extent_buffer(fs_info, start);
>   	if (eb)
>   		return eb;
> @@ -6202,7 +6209,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   		 * page, but it may change in the future for 16K page size
>   		 * support, so we still preallocate the memory in the loop.
>   		 */
> -		if (fs_info->sectorsize < PAGE_SIZE) {
> +		if (fs_info->nodesize < PAGE_SIZE) {
>   			prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
>   			if (IS_ERR(prealloc)) {
>   				ret = PTR_ERR(prealloc);
> @@ -6421,7 +6428,7 @@ void clear_extent_buffer_dirty(const struct extent_buffer *eb)
>   	int num_pages;
>   	struct page *page;
>   
> -	if (eb->fs_info->sectorsize < PAGE_SIZE)
> +	if (eb->fs_info->nodesize < PAGE_SIZE)
>   		return clear_subpage_extent_buffer_dirty(eb);
>   
>   	num_pages = num_extent_pages(eb);
> @@ -6453,7 +6460,7 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
>   	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
>   
>   	if (!was_dirty) {
> -		bool subpage = eb->fs_info->sectorsize < PAGE_SIZE;
> +		bool subpage = eb->fs_info->nodesize < PAGE_SIZE;
>   
>   		/*
>   		 * For subpage case, we can have other extent buffers in the
> @@ -6510,7 +6517,16 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
>   	num_pages = num_extent_pages(eb);
>   	for (i = 0; i < num_pages; i++) {
>   		page = eb->pages[i];
> -		btrfs_page_set_uptodate(fs_info, page, eb->start, eb->len);
> +
> +		/*
> +		 * This is special handling for metadata subpage, as regular
> +		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
> +		 */
> +		if (fs_info->nodesize >= PAGE_SIZE)
> +			SetPageUptodate(page);
> +		else
> +			btrfs_subpage_set_uptodate(fs_info, page, eb->start,
> +						   eb->len);
>   	}
>   }
>   
> @@ -6605,7 +6621,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>   	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
>   		return -EIO;
>   
> -	if (eb->fs_info->sectorsize < PAGE_SIZE)
> +	if (eb->fs_info->nodesize < PAGE_SIZE)
>   		return read_extent_buffer_subpage(eb, wait, mirror_num);
>   
>   	num_pages = num_extent_pages(eb);
> @@ -6851,7 +6867,7 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
>   {
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
>   
> -	if (fs_info->sectorsize < PAGE_SIZE) {
> +	if (fs_info->nodesize < PAGE_SIZE) {
>   		bool uptodate;
>   
>   		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
> @@ -6952,7 +6968,7 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
>   
>   	ASSERT(dst->len == src->len);
>   
> -	if (dst->fs_info->sectorsize == PAGE_SIZE) {
> +	if (dst->fs_info->nodesize >= PAGE_SIZE) {
>   		num_pages = num_extent_pages(dst);
>   		for (i = 0; i < num_pages; i++)
>   			copy_page(page_address(dst->pages[i]),
> @@ -6961,7 +6977,7 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
>   		size_t src_offset = get_eb_offset_in_page(src, 0);
>   		size_t dst_offset = get_eb_offset_in_page(dst, 0);
>   
> -		ASSERT(src->fs_info->sectorsize < PAGE_SIZE);
> +		ASSERT(src->fs_info->nodesize < PAGE_SIZE);
>   		memcpy(page_address(dst->pages[0]) + dst_offset,
>   		       page_address(src->pages[0]) + src_offset,
>   		       src->len);
> @@ -7354,7 +7370,7 @@ int try_release_extent_buffer(struct page *page)
>   {
>   	struct extent_buffer *eb;
>   
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
>   		return try_release_subpage_extent_buffer(page);
>   
>   	/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3b2403b6127f..89e888409609 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8129,7 +8129,7 @@ static void wait_subpage_spinlock(struct page *page)
>   	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
>   	struct btrfs_subpage *subpage;
>   
> -	if (fs_info->sectorsize == PAGE_SIZE)
> +	if (!btrfs_is_subpage(fs_info, page))
>   		return;
>   
>   	ASSERT(PagePrivate(page) && page->private);
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 29bd8c7a7706..c7dea689da90 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -107,7 +107,7 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>   		ASSERT(PageLocked(page));
>   
>   	/* Either not subpage, or the page already has private attached */
> -	if (fs_info->sectorsize == PAGE_SIZE || PagePrivate(page))
> +	if (!btrfs_is_subpage(fs_info, page) || PagePrivate(page))
>   		return 0;
>   
>   	subpage = btrfs_alloc_subpage(fs_info, type);
> @@ -124,7 +124,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
>   	struct btrfs_subpage *subpage;
>   
>   	/* Either not subpage, or already detached */
> -	if (fs_info->sectorsize == PAGE_SIZE || !PagePrivate(page))
> +	if (!btrfs_is_subpage(fs_info, page) || !PagePrivate(page))
>   		return;
>   
>   	subpage = (struct btrfs_subpage *)detach_page_private(page);
> @@ -175,7 +175,7 @@ void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
>   {
>   	struct btrfs_subpage *subpage;
>   
> -	if (fs_info->sectorsize == PAGE_SIZE)
> +	if (!btrfs_is_subpage(fs_info, page))
>   		return;
>   
>   	ASSERT(PagePrivate(page) && page->mapping);
> @@ -190,7 +190,7 @@ void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
>   {
>   	struct btrfs_subpage *subpage;
>   
> -	if (fs_info->sectorsize == PAGE_SIZE)
> +	if (!btrfs_is_subpage(fs_info, page))
>   		return;
>   
>   	ASSERT(PagePrivate(page) && page->mapping);
> @@ -319,7 +319,7 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
>   int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
>   		struct page *page, u64 start, u32 len)
>   {
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {
>   		lock_page(page);
>   		return 0;
>   	}
> @@ -336,7 +336,7 @@ int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
>   void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
>   		struct page *page, u64 start, u32 len)
>   {
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))
>   		return unlock_page(page);
>   	btrfs_subpage_clamp_range(page, &start, &len);
>   	if (btrfs_subpage_end_and_test_writer(fs_info, page, start, len))
> @@ -620,7 +620,7 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(checked);
>   void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
>   		struct page *page, u64 start, u32 len)			\
>   {									\
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
>   		set_page_func(page);					\
>   		return;							\
>   	}								\
> @@ -629,7 +629,7 @@ void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
>   void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
>   		struct page *page, u64 start, u32 len)			\
>   {									\
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
>   		clear_page_func(page);					\
>   		return;							\
>   	}								\
> @@ -638,14 +638,14 @@ void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
>   bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
>   		struct page *page, u64 start, u32 len)			\
>   {									\
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))	\
>   		return test_page_func(page);				\
>   	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
>   }									\
>   void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
>   		struct page *page, u64 start, u32 len)			\
>   {									\
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
>   		set_page_func(page);					\
>   		return;							\
>   	}								\
> @@ -655,7 +655,7 @@ void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
>   void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
>   		struct page *page, u64 start, u32 len)			\
>   {									\
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
>   		clear_page_func(page);					\
>   		return;							\
>   	}								\
> @@ -665,7 +665,7 @@ void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
>   bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
>   		struct page *page, u64 start, u32 len)			\
>   {									\
> -	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))	\
>   		return test_page_func(page);				\
>   	btrfs_subpage_clamp_range(page, &start, &len);			\
>   	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
> @@ -694,7 +694,7 @@ void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
>   		return;
>   
>   	ASSERT(!PageDirty(page));
> -	if (fs_info->sectorsize == PAGE_SIZE)
> +	if (!btrfs_is_subpage(fs_info, page))
>   		return;
>   
>   	ASSERT(PagePrivate(page) && page->private);
> @@ -722,8 +722,8 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
>   	struct btrfs_subpage *subpage;
>   
>   	ASSERT(PageLocked(page));
> -	/* For regular page size case, we just unlock the page */
> -	if (fs_info->sectorsize == PAGE_SIZE)
> +	/* For non-subpage case, we just unlock the page */
> +	if (!btrfs_is_subpage(fs_info, page))
>   		return unlock_page(page);
>   
>   	ASSERT(PagePrivate(page) && page->private);
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 7accb5c40d33..a87e53e8c24c 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -4,6 +4,7 @@
>   #define BTRFS_SUBPAGE_H
>   
>   #include <linux/spinlock.h>
> +#include "btrfs_inode.h"
>   
>   /*
>    * Extra info for subpapge bitmap.
> @@ -74,6 +75,30 @@ enum btrfs_subpage_type {
>   	BTRFS_SUBPAGE_DATA,
>   };
>   
> +static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
> +				    struct page *page)
> +{
> +	if (fs_info->sectorsize >= PAGE_SIZE)
> +		return false;
> +
> +	/*
> +	 * Only data pages (either through DIO or compression) can have no
> +	 * mapping. And if page->mapping->host is data inode, it's subpage.
> +	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
> +	 */
> +	if (!page->mapping || !page->mapping->host ||
> +	    is_data_inode(page->mapping->host))
> +		return true;
> +
> +	/*
> +	 * Now the only remaining case is metadata, which we only go subpage
> +	 * routine if nodesize < PAGE_SIZE.
> +	 */
> +	if (fs_info->nodesize < PAGE_SIZE)
> +		return true;
> +	return false;
> +}
> +
>   void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize);
>   int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>   			 struct page *page, enum btrfs_subpage_type type);

