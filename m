Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9169A6B3746
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 08:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCJH03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 02:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCJH01 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 02:26:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C4103EDC
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 23:26:25 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNct-1qCaqW2n7v-00hxrg; Fri, 10
 Mar 2023 08:26:16 +0100
Message-ID: <a1e3c0d3-9f06-7712-3ed5-f4c43d3d8ba4@gmx.com>
Date:   Fri, 10 Mar 2023 15:26:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 01/20] btrfs: mark extent_buffer_under_io static
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-2-hch@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309090526.332550-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LyIenIdttsx6n82GBhvfyfH7ZwluzkgsN3q/Gzsa6S+9FbwWler
 X1PH6Pfzvoz+4hH6eNr1bAOeyHosKDDJqErAQy6pZQa2swdqwX4/B9nEgsoQYFI8gf0a8GI
 ezoDjLUpj3xN5f4V5f8AnGITIDlbFQG4FdI3KfVyyV6wM+SrGmz/1LkirIUmTuOEHnMEfmn
 urdDoPiHlBaUnis2IUwDQ==
UI-OutboundReport: notjunk:1;M01:P0:nVMIK1e1v2g=;IsTiylmcaYoygI0vuRXmg+lAG0e
 UV75vKgmEkce/SrHYN+HE+s4tCZcVk87gsyRyz1VGIcKxLUVC+yTjfydNiYdAzqjzF7lhY174
 sJQbapLvdjwDcXndVqjWc5Zkpdg6cLT5pGVvb4kbkRRXDeKQCAxOnKfe3vUoVx+U1I1GGTHT+
 HZXui1wQq5xTlUfM9lTpa7w55DXlZJV+i2FGzO6Eu6ktCB/JOjWolAlQINXUCDzQbQ7i7mz1s
 pXiqk2tE25LhWd6nZKqYjzSLd+l9MVYRbwAuxoeWz6q8SAvgudJjZP8WvuJLJke15ozvcN7Jy
 iZkKTq3F0T90pVz7LBlZT9QNZF5nwEZaRMPpLP4sGya5O9rn1Rm9g/BsoKSpZMZQqzqpGfX6C
 6BeRppBnpbF3phZ6XkvUu0mp0EOLzkO1Yq7ECeNdu3CmrBFaak/kMhVx3LbA/uK7gz48IF19I
 Xl3Y39DnmoPzs/2MXbam2JoMiZ+9ArGW0wHrjwFoWALgWtOz8NRLRBkFE7+yq96jyWwZxdpUT
 pG3MwtuZ5Rz5cO2r4vC+IzEIQ2yibw7J89Msyt/9vSZsSbA612WenN4mkGRDgooeKB7C6T+Pc
 ee7Hwg6v3fTaw5Uw+cPwz8I4+nW3twdIPrSX5DDVuWvyM21KKaMQHCCbnWkTrWtZMFUL2KGcj
 bNwxRS4DTAtJaXD0Kz1+Bf0wIzzbek/JNPiOycQR/O9pTzrNFd4GK55Z3d/R7FjSZ9LjD0Cpl
 WVfV9vNSwUErhUYaKw1scVDZuFXXybpzy+/QYMZt+7Ua5hDtBHx/k+MRdXTRbTmf7DcVtbHeT
 xVLnKtcnfzuPvOhAtfATgKNh6bhZAHGm8X2PbW5KQ+Pj2dImB7s8ddw0R9ikP/Ha3bufcb8Y1
 +zT/1OH17kRqCIW22dEhXge8P1LljP7rof8YUB9Vj07V0Q+lPeF1Va/JNU9TU+XKP10QEg7X/
 Ib51cCfpUnA2y5L+ziQet5okObk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> extent_buffer_under_io is only used in extent_io.c, so mark it static.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 2 +-
>   fs/btrfs/extent_io.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1221f699ffc596..302af9b01bda2a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3420,7 +3420,7 @@ static void __free_extent_buffer(struct extent_buffer *eb)
>   	kmem_cache_free(extent_buffer_cache, eb);
>   }
>   
> -int extent_buffer_under_io(const struct extent_buffer *eb)
> +static int extent_buffer_under_io(const struct extent_buffer *eb)
>   {
>   	return (atomic_read(&eb->io_pages) ||
>   		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 4341ad978fb8e4..342412d37a7b4b 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -265,7 +265,6 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
>   bool set_extent_buffer_dirty(struct extent_buffer *eb);
>   void set_extent_buffer_uptodate(struct extent_buffer *eb);
>   void clear_extent_buffer_uptodate(struct extent_buffer *eb);
> -int extent_buffer_under_io(const struct extent_buffer *eb);
>   void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
>   void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
>   void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
