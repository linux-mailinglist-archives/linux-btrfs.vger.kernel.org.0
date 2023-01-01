Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870C65A86E
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 01:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjAAAAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 19:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjAAAAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 19:00:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA6F4A
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 16:00:23 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1oecsR1Y08-00bdhQ; Sun, 01
 Jan 2023 01:00:16 +0100
Message-ID: <a4f17a96-5441-b894-96ef-ae05816dfebe@gmx.com>
Date:   Sun, 1 Jan 2023 08:00:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] Check return value of unpin_exten_cache
To:     Siddhartha Menon <siddharthamenon@outlook.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
References: <20221231184749.28896-1-siddharthamenon@outlook.com>
 <PAXP193MB2089D68F6B6E11464FB202FFA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PAXP193MB2089D68F6B6E11464FB202FFA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5WGCp3Q1w8Tz40NmF0VXc/oYCoYVcCKl7wCAtAXFAvCumAnkYpi
 wxhgZJ1YeVb9MyIMQW/cGWuAdyChZ3ep4g+1HiqvCG4G2POwocKE6eai9VMgLN7DTi1ptOx
 2PMRbooU+ct0bDaoPLypUjEnq1YImlkqou25P+UaKSOVSS80GloP5n7qnegwFzOOvZjqUSm
 JbthCNHVq4AxWAfMLolOw==
UI-OutboundReport: notjunk:1;M01:P0:6PVkGsvTuhY=;xLRH05FUFXhYa58xsGn51Bu8khU
 LBx5xvmSE/jvFI0NrInMk5NqhLD1aotyIlD3w0qUkik/TOTzxh9Wby8CrOGDljF7b5cjDWP+D
 TdLF/yhmUjxrtHQ/5tPEcb3+4BCDR15HRryEVqGOv8zo+EyjOUYyrtcuEjMN7WUw/1WpHB+uh
 cZzIepDxemNdR9qFDxDtE/KJWRjMC5VoFEhVg0jMhc8sxFiaGC3by2Xh+kgRLlI97cFVr+p9W
 T6ZXQ5QzRFRPrfG7zL61JiXL7w9NUl8dBgH9e6x+Rqxv/n6efYsjA4o0caeWRyF9rgNXNynAe
 u6BhXVqwcRzUO0BS68MCwqV7pup6za8lfNoCKFFWq2Hl8src9dD1SvCWLqF4YQF1XJ+UDpXEO
 zZVCwnFHjgL7a8tK0sIuX0HCv88TVHH2lKqtAlKZZh1RmyEn3SveX/LXjzNh/Qs9s8QEgSexb
 x0DS08UuBhv3yTTb24bNOoUi7YsU8SBPqxTbl62FM0jtXru1Qz4hyQtCrsfs9l5nk862NoBk+
 59dVovuBztdy7+jYRcQOY+alR4wJPsaWe98IgW2VcSYrwwky2hqYJhr0M2EP3xKQO6XL0ZnRH
 NeKwQxe7KYJKofpTR2WjjEsdh1Ea7eJ2JqM5gduIBO0mYUg4jt/wT6vBAKkkqR9d2Nanbu1zX
 Wb5Hv9fGqKqFMIuJtRvRwCF8z59sIECOdXpC9KhfVJcAEXdk/Z/7v4nVxdcotw5i2rGzxmHQt
 /7+gQlIyle4edhsyP1fejzDxa9SY2L+seTGz67mE0GUjbt6t3vKSsUyovkS37LDi8eQwn2UZA
 wlh2sdnafW2nFj7qcPsx2ouWI6pSvk/KTOa43eSXlbNL5ye3wg07NEZDmMFVld963vkBqm+Kp
 ZmjdmY/uGMgeiYWR0+RxkyiUsItNuEYqOH3fGNKivk/tBy8p+hewgxOJmaEYaoqp6na420+A7
 rKsuiHDkXxB0ducg6bUKsRGSZEY=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/1 02:47, Siddhartha Menon wrote:
> Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8bcad9940154..cb95d47e4d02 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3331,7 +3331,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>   						ordered_extent->disk_num_bytes);
>   		}
>   	}
> -	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
> +	ret = unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
>   			   ordered_extent->num_bytes, trans->transid);

Unfortunately this makes no difference, and in fact it's making the code 
much worse.

That function unpin_extent_cache() won't return anything other than 0.

Furthermore, by this we completely overwrite @ret, which is initially 
for insert_ordered_extent_file_extent() or btrfs_mark_extent_written().

This makes us to completely skip the error handling for write back.

So NOACK.

Thanks,
Qu
>   	if (ret < 0) {
>   		btrfs_abort_transaction(trans, ret);
