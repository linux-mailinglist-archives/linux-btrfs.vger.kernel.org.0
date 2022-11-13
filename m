Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795EF62731C
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 23:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiKMW60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 17:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKMW60 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 17:58:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BDB1DE
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 14:58:23 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnaof-1pLfwG0SDF-00jWeK; Sun, 13
 Nov 2022 23:58:21 +0100
Message-ID: <f5cceda5-e887-0807-7331-12382b45ea29@gmx.com>
Date:   Mon, 14 Nov 2022 06:58:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: scrub: expand scrub block size for data range
 scrub
In-Reply-To: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GO1TdsvbEhWwBy8KrBj1zhtpEFT5rC5Bwh39dkjl6RSpxB76wOq
 X17ntjWKmYTMR9axIPOGxY2Eq4R2T3um1p4tUIELYAH1e/SIITMj98EhPev6gdQsrBFYSni
 kf/WgFC7Po0hfIeu2NtPzGca6pKw3J5Zte6QY5kFIHurDpRQrtrQOGnNg4QRPSFm5NdyNzg
 KuUPCqRmBqM8FZvF1AoYA==
UI-OutboundReport: notjunk:1;M01:P0:fUIYteWfMU4=;z8opRK2GJaXOnU4ApmZ3ae1B43n
 YV7ToA1vvvoZ0Z1DzieM+IYIgGeY9viiFkr6/kORouDva8B4Cjy6PdQQe2kipA8PnwGsefgg7
 k14+w4wTNbeZQePyS18LGtgI17PISxR9wieReSVc85pn/lDuuF9ax4C6KXPpkNVbHTiGXmeG/
 1j5LKYL+bw2oq694Z7kaCtu9q8QUZayPagFSdmDqvBlHm6IUePUHvRXdpoTMQrl4YDvP2sCDz
 XWuEfF8ud6ARTg1mRH6qzHTYtQOZTJQ+UjS4/B+oOtde/QpAiq6JmmTa91h2t3D0zz6XJWCw0
 s9djfl3O1trU/1WPJ/BlkYCXYtnGHfzdqtgtDHTTz+MTVDaAXkn9lIZzEN90jwFPilxmmNmy+
 38bNk10489KVUx55+szjE54LrdXEcuGcE6OIzzXs72gg7OFJEtom8N1wi/cH8FTdffR7jWSsJ
 +/WTATPCwuW3xd0inW3kDL+2FGIYFIU4nRLdMEoi9eDQ/HnAStmA4sv2iezJ9Sn4zWlY8kC2f
 paezLkDvXa/Lm5pWZ8PuBeM7vGjWj6a7NvktYbX9CiV1irqnfKmzTPB+osbGbsRpj+f273XPa
 MWY3mLPsyW1StQfWxt3ZD1BwLPHm91fgl2zzmGMQvDdnxxUW93Sgu+plEKaCxjX9ImIefSye0
 FZQ8pbFJaBbQXTmGonICANLHu1qEBJdU5O0fpZtNqIf9ErJy9bYJ+Wx7x7zhfDtXusaFhDiix
 nkGcqsP8aHfCAga6j2q6OclSORwo0n+pf87Iuq38TsSELsGoPY/EQot8lGIdP4ZmAaa/IhN4a
 TdBMy6yGYbK9IDPcE+kQIpfGDpok53gEF/iaQeL7pVAlnURi7SBC3mAThGGJ9lxUXR0sozdVC
 uJj1JmTG4fbaXpF2leTKJXkzjJ4DptBXvaLgpjTWMpgB7FiGBEOHgY+0uuWlc386q98ARB9qa
 tb7GZSIZRgtbM/DHyaNd4glO+Ws=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/13 23:35, Li Zhang wrote:

A small description here on the problem would help on the context.

> [implement]
> 1. Add the member checksum_error to the scrub_sector,
> which indicates the checksum error of the sector
> 
> 2. Use scrub_find_btrfs_ordered_sum to find the desired

Please don't put "_btrfs_" in the middle.

Just "scrub_find_ordered_sum()" is good enough.

> btrfs_ordered_sum containing address logic, in
> scrub_sectors_for_parity and scrub_sectors, call
> Scrub_find_btrfs_ordered_sum finds the
> btrfs_ordered_sum containing the current logical address, and
> Calculate the exact checksum later.
> 
> 3. In the scrub_checksum_data function,
> we should check all sectors in the scrub_block.
> 
> 4. The job of the scrub_handle_errored_block
> function is to count the number of error and
> repair sectors if they can be repaired.

The idea is good.

And I hope it can also unify the error accounting of data and metadata.

Currently for metadata csum mismatch, we only report one csum error even 
if the metadata is 4 sectors.
While for data, we always report the number of corrupted sectors.

> 
> The function enters the wrong scrub_block, and
> the overall process is as follows
> 
> 1) Check the scrub_block again, check again if the error is gone.
> 
> 2) Check the corresponding mirror scrub_block, if there is no error,
> Fix bad sblocks with mirror scrub_block.
> 
> 3) If no error-free scrub_block is found, repair it sector by sector.
> 
> One difficulty with this function is rechecking the scrub_block.
> 
> Imagine this situation, if a sector is checked the first time
> without errors, butthe recheck returns an error.

If you mean the interleaved corrupted sectors like the following:
             0 1 2 3
  Mirror 1: |X| |X| |
  Mirror 2: | |X| |X|

Then it's pretty simple, when doing re-check, we should only bother the 
one with errors.
You do not always treat the scrub_block all together.

Thus if you're handling mirror 1, then you should only need to fix 
sector 0 and sector 2, not bothering fixing the good sectors (1 and 3).


> What should
> we do, this patch only fixes the bug that the sector first
> appeared (As in the case where the scrub_block
> contains only one scrub_sector).
> 
> Another reason to only handle the first error is,
> If the device goes bad, the recheck function will report more and
> more errors,if we want to deal with the errors in the recheck,
> you need to recheck again and again, which may lead to
> Stuck in scrub_handle_errored_block for a long time.

Taking longer time is not a problem, compared to corrupted data.

Although I totally understand that the existing scrub is complex in its 
design, that's exactly why I'm trying to implement a better scrub_fs 
interface:

https://lwn.net/Articles/907058/

RAID56 has a similiar problem until recent big refactor, changing it to 
a more streamlined flow.

But the per-sector repair is still there, you can not avoid that, no 
matter if scrub_block contains single or multiple sectors.
(Although single sector scrub_block make is much easier)

[...]
> @@ -1054,7 +1056,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>   		if (ret == -ENOMEM)
>   			sctx->stat.malloc_errors++;
>   		sctx->stat.read_errors++;
> -		sctx->stat.uncorrectable_errors++;
> +		sctx->stat.uncorrectable_errors += scrub_get_sblock_checksum_error(sblock_to_check);
> +		sctx->stat.uncorrectable_errors += sblock_to_check->header_error;

Do we double accout the header_error for metadata?

Thanks,
Qu
