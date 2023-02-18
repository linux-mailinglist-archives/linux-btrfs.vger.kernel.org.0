Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2576969B80F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 05:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBRElT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 23:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRElR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 23:41:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA7A2CFD1;
        Fri, 17 Feb 2023 20:41:15 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCK6-1p8Fhx2he8-00NDPp; Sat, 18
 Feb 2023 05:41:10 +0100
Message-ID: <a9afdba6-0175-abdc-6445-62bd0704346c@gmx.com>
Date:   Sat, 18 Feb 2023 12:41:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] btrfs: handle btrfs_del_item errors in
 __btrfs_update_delayed_inode
Content-Language: en-US
To:     void0red <void0red@gmail.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230218043649.86-1-void0red@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230218043649.86-1-void0red@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OezVmRDCIJV/ih4wvar2tMobYhqoFTqambXjN4zNx78S7xipyEN
 ZEKE4Hxdan6m/O2q1k0pQ6sVbxrke7aff9KGHpwkrGL3hPCU7H18RDPL3zealVYfSgeCm0T
 6KJLG4zRDyvt8b9zmlTKxfan5vhDl81Vzu54mg5Dkayon/vnJYXNfpP/B3nGKel01JLH3N4
 1ry4gVdfxE/5mwR9EF/oQ==
UI-OutboundReport: notjunk:1;M01:P0:6ttWvXqDHFQ=;jlyB2qqOZbS7QwFpFNK7t59VxZ7
 xZ5DDLHYfkwXdoBdgJaWBMBp7eAIRK6HCNNsL9DyK78AmiTaoPvAan597oE0D3YeuRprFCHMQ
 U/AD8GUH+vtqoOa8D4gihoIxXUQiU3c2barUTgGxhE+781X1YrlkjaCE08cWmzct2/+wQbVjo
 VMOe0vLY2c6CtCwDyUeDLfHXrPGC9ICOOB9o4H9B12WRATby+TUSTu2DqPURgSwpVEeK9ExLy
 kL1pGn/1fiG0QJWiiWyyb8dsBhYEM51N2kSMZymlvPFD88rtVlrnVtKP+All78+u+MVtrQ4lt
 +u7fTkLD2j4vCciXsJNPDCyujpFrYD61wy0Ve+9bzBrxXGqz99kOtwNzQOEUwY16jyJo4hF2A
 5tUdVDwwqvDK2QmX/Bp84Wdl5h7TzU1LBfFOwDw7A1lWt9WRbZwoNCHRUzMHQwWhFyfSoFczq
 7KSsnbagjmFg+2yRiNPdOCkPSoJyBSPNAxBUG7TP+3bs6f7jDWVRu1BwTZVW6HhywZMFZ/ioH
 hWYR5tUkJrR5AYG+3rsJ4jzHRAXHAgq5GpaorgLEiIb52zV7cwUxDdaTzfsJBRQT1R2fKHOxS
 PXFtb34Wzn7yNZQbMizlLENxNL/pnUVbvgAU3EMtQrNcefuARBfiISJKvOGVq4cs+6f8UuixT
 LHCaT4+pr4pWMygyNpPPv5uWsn0cRVBvSAxaEOrwRCEUw6N4fn8MA8YPalRKMbwDAKKDtg9vR
 06evwD77jp72YShWnGgOvuPdqTWxWZQdDIoauQl4akaBAIzL+lr2l1950SXO23bjnGBklg8W8
 C409Kgh26zXTzsllU20CEt0pIL3ZZZtQnJUZC+Iykkd4udmt8Fq2G6LsIcRiaYr7k8WftJ+h6
 88xFcpX3QAOMIbELnA5hKME8WB+9Z+0DMtQ9AzqOYvLL1ReZBHBYB6MpEtgWpQulnc0i78XZz
 jyz7ZpHd6RWbO5mE9+VgoP4D6gM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/18 12:36, void0red wrote:
> Even if the slot is already read out, we may still need to re-balance
> the tree, thus it can cause error in that btrfs_del_item() call.
> 
> Link: https://lore.kernel.org/linux-btrfs/9b45f60f-c849-e072-64ef-298937e6a8a3@suse.com/T/#t
> 
> Signed-off-by: void0red <void0red@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/delayed-inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index cac5169eaf8d..88a5d893972d 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1043,7 +1043,7 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
>   	 * so there is only one iref. The case that several irefs are
>   	 * in the same item doesn't exist.
>   	 */
> -	btrfs_del_item(trans, root, path);
> +	ret = btrfs_del_item(trans, root, path);
>   out:
>   	btrfs_release_delayed_iref(node);
>   	btrfs_release_path(path);
