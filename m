Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE46E5A50
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDRHUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 03:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjDRHUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 03:20:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B171700
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 00:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm8Y7Bf+IVGmWNhRNFl7MOcAGAluVsfqYGoPcCGIGkWhzl0dobBAYCs9Ia6dFtBm+apd9PKcdlCskRlbUgt7ZLqi55+mXJ14DCrgEjl3SR6z6HqD/OHYgxIz5EACUsf4wTtzgkolZT3ZYIMLBBSJW4UyNAyt9zjIIMniHNTEqDR8EWNh+/AxnRuRB/RVXGzpR9u5nsv17gQaySLP8BKzvnlW2vIYRMXaxMtQrTAoEZarcGKzHc7DOesf0/1EaUVcw4bz5c0Y7aIiOPEcUADeDwJ3W24kx5htsqs89kHZpCLUZ5yQr22NKiTCOzlJKEh5ferzHtkDME2UYOqC1Vf65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQWiwlWrJ7y8FFGxmjYHMJJqZhfOPy4yOjJBbZ13SVk=;
 b=jYSjLGOL5t81PhrHUZK+ZQVcbSW8yA44GsUIaKKCB+FxukN2u907qUsLJ2Im0Yhj4Lv+v8/7MJnsxJl3c2Z95nsrpIOIndpmLKiNZMlfkkseXLn/zSPudTgMVSyOr/0po9rNaZrnkZGcdkFkEnKnHEjLDAjckw+kWAnzc4eevQ3+qZZ2Dgre8Fow9XQm/l+olHUjKUe/SmYR9PPZ6NYLsJ65IlNttYeoDIynsT3yPStAp0h08TdpomVekBaA6Pdg4pec5cvUw9xpzCrJoA2xhCuelKkbnIRnp11OL885mFRbohktvi4A5GLRa25GJjMxGVHjGNcXn1LaJd8QiNrAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQWiwlWrJ7y8FFGxmjYHMJJqZhfOPy4yOjJBbZ13SVk=;
 b=ao861qeigPUqWxMqWS30oRk8xNdtbCMUD3VQA54e1LM3ZRzBU60nZcAEtFEcKkMDBs3l3ChrD0/9CT4jonzr4aBQqZqY3zhzhf8LZ5/vprebyWqwdjvb/2viSUgeagcm1QJXMPS0Htug7ZAIUaSbRNuhmR+iqwxbXzNrDe3NeTkyQlDV8PYJ+N/H8eqk627rx4R4/n5pWK5LT+BnSUzz9vORy2nQpUVv2IuLpbzaEITVBVfIlZXDthwzMraPP4vGVcx0dKYW1SClqOWExiKjF/FBeyin2mYMkGVIcwHNmqepRHbwPRxIWG3qaraH1t8h4Ya1l4H0tBMbb2iINjjLzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB7009.eurprd04.prod.outlook.com (2603:10a6:208:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 07:20:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%3]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 07:20:25 +0000
Message-ID: <12ce9b7c-ba21-6321-5b2a-67905282c20b@suse.com>
Date:   Tue, 18 Apr 2023 15:20:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH U-BOOT v2] btrfs: fix offset when reading compressed
 extents
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
References: <20230418-btrfs-extent-reads-v2-1-772a6be2ea9a@codewreck.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230418-btrfs-extent-reads-v2-1-772a6be2ea9a@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::30) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM0PR04MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d60a23f-8a9b-40a6-ad84-08db3fdd6146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cApyylsOA9Sm5Bg9W9PBi7LdwdXCyX2DJfAT6l0nHJpzo8RaBc+aXQpnKi3N9Td6FJiUoBVekEc8u++NpRQ6LQ8OpAJMtQ4o6Zx9i+f/6k1mvMkXvy8591ZWg7DqKAZBr07sl3BcavV5+V5AFh53qFRQYobet416Vre3tpvUGYYuOEML6NxMUOA7hzqyUtx1Lp3VX2xiff7RlxMUQsV8TgfrbVue0WuTU75gofeJvetGiqy58zBNgw/W85kZsVCEVCMveCy0V4nVH4WaJ658lRxO094Vf/MzjPTSpvdjhZmfcAYc3Hb6fcya8pF6BXpQsqDowRImVyrR1b/WLO11AAORckmyFqNbQ8cB9jZXZwfeZ1hYoIkFj5kJRM80eSlyXk+1T6Q5fUH8U/jL0ova0Lzry9BV2U/0t2pd/u0wdiG+xr2NbpA5sVYMWuHQzsUDnAWdNWXaKm+kO7sGCNXMP2nrl5BXK1yF3W7tuE3b6qJgE2QHBPMkDKz8DO0DeiqwSsqgFKMvZ9yD2CoyvTgVph5WpUzd/ZCJ4WYziyewSbExfKkL473t47/nsJvjWHtsxRE6KGRzppQX5ZWdYE7a0gLHmZ/ITVUESrMhP1ZALcEG0dQ/IoaI6/bD+R0DmG7qyTaGLywEAWCIRSXh+V296A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(5660300002)(8936002)(8676002)(41300700001)(31686004)(4326008)(66946007)(66556008)(66476007)(2906002)(316002)(36756003)(31696002)(110136005)(478600001)(86362001)(6486002)(6666004)(966005)(38100700002)(186003)(53546011)(6506007)(6512007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDlkNUpaWnpBeTZtc1ducUVWUFNXaEJWR0FjQjhxOWF6SzlIMWVaYUNwbHR0?=
 =?utf-8?B?dk9mSTJ2N1VHeUdtWUZsUlBsbnRXTkxJbytSWkhGRk9HbENWb2dHazdGUUxy?=
 =?utf-8?B?ZzUxWC81dVFaaUo0a3pDTktYV0diVldjZzlBYlE4RlpwMkJzM3lEbVlNNFRE?=
 =?utf-8?B?OTk2cnhHZmRtb3V5LzB0ZW1pYnlMcmlWcDJ0cTEwOVcvd0U0MTRldzJMWnFo?=
 =?utf-8?B?QWFiZUI4bDFxd2xTajNoV3dxUnA1andaWFlSaVA4VDZRVER6eGV1aEtNS2Np?=
 =?utf-8?B?VmxybCs2ZFZtNm4rQ041WFEvMm92czZIRzVRVDJibG0vYlpyTGZnWEwrZUVO?=
 =?utf-8?B?ZkVTK0VFUENpeDVYb2FUd0JFbDUvRlViVFV3Y0d3b0NncjFmc09MUmUwRy9I?=
 =?utf-8?B?WkdyRGhJUjRLdDR4MHhkZ09NVTk0cVYrMWx2bWlKVm9GZEZvc0w5VFZzSFdN?=
 =?utf-8?B?ZFhneXZQSVVHMnFwQ0h4bXkxTzFGcnljSjErdTU2bXc2STMwaW5uMXFLQ3Z2?=
 =?utf-8?B?Y010bEl0V09YaG1YN0E4NmlvbDdtR2pKUFg1RkJETzlqVVRlaFNsTm4xQTdx?=
 =?utf-8?B?M1lqQlBJU1g5RDNoaGtOK0ZCTE04OGoyMnR3MTNuK0doZDMrVkNQVG5ISWlW?=
 =?utf-8?B?bDAybGVNTXBjL1p0VzZJV2pZZWpFM0g4Yi9ZMzNGUTlRNGpnd25yeUZyL0p3?=
 =?utf-8?B?UXF1OU5QaHJlaHd5VWtpQzJrZkdGU3ZiQ0pPVGdOM0cyVkhvVmpOUW5SQWt3?=
 =?utf-8?B?ejdzUlFEaDB5M3QrR3F4R29xeEU1NVRlcE5VeWkwcmxja2V4YlBrdkord3Fy?=
 =?utf-8?B?bmV5cGp6T3hKeFIzZ2lEang1ZEE4UTdJZnUzczZBOTQrcnNzZFArQ0FrSFJ1?=
 =?utf-8?B?UzhEMTVuRmdYZGV3bWpESWRONG5KbDZMSGx1cWNORFIzTUZhckR4ZkhrKzRV?=
 =?utf-8?B?eGlYY2V1MkJQQXEwMm9VTjk0L3prNUszKzdtYmZ0WDI2cE1GOUYyd0VCakFK?=
 =?utf-8?B?b0hyazlPY3lIS2wyS0NJZ0s5NTZKTHZvZWRiK1p2MUhsMitWYkJDNkNSNkY1?=
 =?utf-8?B?VUVMeForRmRMK09WdkR2SExxU0ZmMzZEOVRmc2kxR0kyNVBxbXkybGV1akxN?=
 =?utf-8?B?TklKZ0MrQ2U4bTFGNHRSZHpzbmZ3WTlhZG9qOWNESXBGc01JbjhldVZWNU56?=
 =?utf-8?B?SmFFc1VXeFBtZ1JObkxjYXRyZVBkaEx3UEovWG8yV0NTOFcwT20xa1ZjZ0xP?=
 =?utf-8?B?cWZTU1hoS0E0enhSTEZvNk1BV3NkbURiM1NubjRxVnVKMFB3d21rbUo0Mk1R?=
 =?utf-8?B?cXJvTU1ZenZHYUJtOThhWU1MTUxvc0FxYVdrOXdEYWpnemNRVGZpbXlGcmpx?=
 =?utf-8?B?M3dGZXpYaGNZcG5QT3ErUyt5b3VDTWtRaG55WTNKNnQxbmxjWFRUdkl2Q3NW?=
 =?utf-8?B?TW9EOGUwWFQxNUoxdmlFWWpFWjdSWFMzZlBNd0RILzF4aHUxZjViNTlqYjNL?=
 =?utf-8?B?OTF3Y3RQUm1PTlMxODdvQk9kWUw2aTFaZUtqM2JiSFZnekhNZzFWb3JxVjRy?=
 =?utf-8?B?UkEydklxaEtuUjQ4eWpISnhQSjhHQUoyRHc0OU4yQnlqNmRDcThaQjYyaW5V?=
 =?utf-8?B?cTJFT2ZkN2xHbEhpYVZqOExkQ1VJdG56ampJN3gzK3BJZnViOTMzQnRkS2Ix?=
 =?utf-8?B?cXM2bzhRVnZxd2NWejZ5cjFSa2ZROEFNRW0vdm5tY2xaN2hOVzdpL01tdmdy?=
 =?utf-8?B?OUk5RUlMRDhVVWdZRmNGWFJLVXJiQWYyRzMrVmZySGk0aG9DMVM1WHlvWDI5?=
 =?utf-8?B?MGp6dGNyNzlQTXhuWjIvekFDWnBWamc3R2dqSy9FMnVlaERsU1ZIWGM3dUpQ?=
 =?utf-8?B?TWQzQ3h4bHNTckJEQm1vZ2RpcC8rUGg4VUx1ZHZnZjVqN2Z0YXpLTDVhTmlo?=
 =?utf-8?B?TitrOHZBbHVIZ2F6dkFTcXJlaWkvSWJlM0ZTcHIySWJLY2NGcDJQK1RIaFhC?=
 =?utf-8?B?Y2VYSjJWUUhLRUE4UXo1cnZ1STNaTFBsejNKbm03TStQYUd3TFppMnhJdDhT?=
 =?utf-8?B?UVArYlNSQmN1M1h2ckJ6c3U1S3k3bmV2MXUvaDdXeGR5QzE5TmFjaVBRQVZq?=
 =?utf-8?B?UE5PWlUvOTFraWdPU3U3ZDZJb20ybXZNYzJwbEhWcXJHRzB0Nk1GQjVob2V4?=
 =?utf-8?Q?uq5cdP2ypy3IQEgdX2ksF60=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d60a23f-8a9b-40a6-ad84-08db3fdd6146
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 07:20:25.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofXXbXcHNb9Tn/c0nLBnjms2pM+twPTPMtTOQd/NYkWFJlWb1HcHZ4q2QN7mMYwt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7009
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 14:41, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> btrfs_read_extent_reg correctly computed the extent offset in the
> BTRFS_COMPRESS_NONE case, but did not account for the 'offset - key.offset'
> part correctly in the compressed case, making the function read
> incorrect data.
> 
> In the case I examined, the last 4k of a file was corrupted and
> contained data from a few blocks prior, e.g. reading a 10k file with a
> single extent:
> btrfs_file_read()
>   -> btrfs_read_extent_reg
>      (aligned part loop, until 8k)
>   -> read_and_truncate_page
>     -> btrfs_read_extent_reg
>        (re-reads the last extent from 8k to the end,
>        incorrectly reading the first 2k of data)
> 
> This can be reproduced as follow:
> $ truncate -s 200M btr
> $ mount btr -o compress /mnt
> $ pat() { dd if=/dev/zero bs=1M count=$1 iflag=count_bytes status=none | tr '\0' "\\$2"; }
> $ { pat 4K 1; pat 4K 2; pat 2K 3; }  > /mnt/file
> $ sync
> $ filefrag -v /mnt/file
> File size of /mnt/file is 10240 (3 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..       2:       3328..      3330:      3:             last,encoded,eof
> $ umount /mnt
> 
> Then in u-boot:
> => load scsi 0 2000000 file
> 10240 bytes read in 3 ms (3.3 MiB/s)
> => md 2001ff0
> 02001ff0: 02020202 02020202 02020202 02020202  ................
> 02002000: 01010101 01010101 01010101 01010101  ................
> 02002010: 01010101 01010101 01010101 01010101  ................
> 
> (02002000 onwards should contain '03' pattern but went back to 01,
> start of the extent)
> 
> After patch, data is read properly:
> => md 2001ff0
> 02001ff0: 02020202 02020202 02020202 02020202  ................
> 02002000: 03030303 03030303 03030303 03030303  ................
> 02002010: 03030303 03030303 03030303 03030303  ................
> 
> Note that the code previously (before commit e3427184f38a ("fs: btrfs:
> Implement btrfs_file_read()")) did not split that read in two, so
> this is a regression even if the previous code might not have been
> handling offsets correctly either (something that booted now fails to
> boot)
> 
> Fixes: a26a6bedafcf ("fs: btrfs: Introduce btrfs_read_extent_inline() and btrfs_read_extent_reg()")
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> Changes in v2:
> - Keep offset decomposition explicit where it is used
> - Add reproducer/clarify explanation in commit message
> - Drop other patches temporarily
> - Link to v1: https://lore.kernel.org/r/20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org
> ---
>   fs/btrfs/inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 40025662f250..38e285bf94b0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -511,7 +511,9 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
>   	if (ret < dsize)
>   		memset(dbuf + ret, 0, dsize - ret);
>   	/* Then copy the needed part */
> -	memcpy(dest, dbuf + btrfs_file_extent_offset(leaf, fi), len);
> +	memcpy(dest,
> +	       dbuf + btrfs_file_extent_offset(leaf, fi) + offset - key.offset,
> +	       len);
>   	ret = len;
>   out:
>   	free(cbuf);
> 
> ---
> base-commit: 5db4972a5bbdbf9e3af48ffc9bc4fec73b7b6a79
> change-id: 20230418-btrfs-extent-reads-e2df6e329ad4
> 
> Best regards,
