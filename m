Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21F629599
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 11:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKOKSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 05:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKOKSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 05:18:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06941261C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 02:18:10 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1oymma1owc-014oFo; Tue, 15
 Nov 2022 11:17:59 +0100
Message-ID: <f54a904d-cbf0-2e46-523f-9be87bf82d2e@gmx.com>
Date:   Tue, 15 Nov 2022 18:17:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] btrfs: fix missing endianess conversion in
 sb_write_pointer
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
References: <20221115093944.1625659-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221115093944.1625659-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2vjqSce/IzY5FYgjtyxqXls0dQw5EF25/2GI4Gs+dhmJDbQasRe
 iYjBUjJzfW0/omvBd/q0NujffByOeMZu5pHkBSpI3QPMd5jmEALUz14UE8uGDb/ev9nR/uK
 NbCKZZ/RmgF5gqbBBozYQw4ZCndepFOALnL14CWOtwa8GOCk19tnunVFdFflgJVxkh4sWhp
 Yn4Ide8aUwsE+51M32RiQ==
UI-OutboundReport: notjunk:1;M01:P0:D67QTZgHjog=;Iz6Cwdhbvy/gV1pdLgZdc6TedgS
 ULKeXsM54gHcholm/Yp8G7Tebjn1eeFdfjkDV+AFKZOKqorEXX2HGGSe3cUPw5Gz0sgtzw223
 k4UxcrPQ6Ur5xj+PBbm7MQCjAF5zz3nyzQa/t2btL+eBm69oBb7wLuOZ2JU1MHSeWzJensDVA
 sZ9cDnu3Y8ER6/RDGgQKae26TsMdtNB0UuPElth0cDJIitH7HqvWN+976wvLKA33AFOmubv2J
 B2K924v8vsY36ewSnxKoxdMazCh55+V+IHkzDa+NYjdjWkq5oEU/CHTB8OCAeurW3hKnGMcE+
 rhdITVSDH8bROCJL2CODpn3b47NzrKHY5Fj+JwdamEJMDCf6BhXtk0tr6LW5+wQfnzDJzZKkp
 wKY/bNkhi76P9d7vB4QmoctPWxyZe9F+xuW6zHjjmmErVmS8xqG9y3snsv4CgaO6delOQ34WG
 ThNYA/9eFOLw4YyxVpxi3pDTyzv3wlYsvBk0oMMcRlM3WkHc9G/W/bHYZsZ/QPyMCAKRfjSPp
 vZrbRCxVjK7w8mgagckpJm47TW1ARxHtta/Fp3XFKnhC0lSPer9doNh8/m32vUy+KjJaxfh/g
 7uxBFxjD1pBDbgkz61IjVXK7Yv73IQkRhjP6Qqby43o1MoJv6M7ata7V1vsSNX4cPjoawCxo9
 16voh6I42z+Xt3BD8fx19J8+KSs7HtY1rT63f0442co5kF7CR/qBCs2os5yMk3rI2v1Pw46IJ
 pHLwudAmnmUBqqlIhCHwIs3Zt+FVi58PpLfDB5lA4kJO0PmOf6rnSKcEFMa0mLyfUF58gpMMd
 Eeh2zj7B3F97ImxCpjm2kwBdal8fSV7X7meBcBmDqyyWSthTRUdOyMFEgTLIZy3cDnTw0XscS
 wIPXblb4//c4pa8TsVzGBA/144gWvhnWPC9yMtj7zcMbVf5B2PcLiB3XdOhCGJ99bx4+twuck
 ETJjeFB0rjMfJ7P+idC7pmu0YPs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/15 17:39, Christoph Hellwig wrote:
> generation is an on-disk __le64 value, so use btrfs_super_generation to
> convert it to host endian before comparing it.
> 
> Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> 
> Changes since v1:
>   - use btrfs_super_generation instead of le64_to_cpu
> 
>   fs/btrfs/zoned.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 6781c141a6b41..4b55a5c68826f 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -137,7 +137,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>   			super[i] = page_address(page[i]);
>   		}
>   
> -		if (super[0]->generation > super[1]->generation)
> +		if (btrfs_super_generation(super[0]) >
> +		    btrfs_super_generation(super[1]))
>   			sector = zones[1].start;
>   		else
>   			sector = zones[0].start;
