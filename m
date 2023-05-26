Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9A7122FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbjEZJGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbjEZJF6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 05:05:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900DCE56
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685091933; i=quwenruo.btrfs@gmx.com;
        bh=9sAZtbu2LdCpNo+RXDh9PWcNw31o++i9v7usn9wFnDM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OPxkbBaolbyia0Ewo+MXHXp0qYm4zwaMPEHVoV20N6rFLnrmNE5C9XHzfVyXQFqSW
         lEZr2453ntmM1T4/iEfyklfDQh6NpJJI7Q60Kt6it5JfTnYpdJWOfWRr53LyCe+Ma+
         OBWDBBbNFsOwkwZdyakLZMnpAMV2TzXKBhi5oLR4VnCWZiD99cRh94/e92pIFRrS9W
         QVHoWkkM/RSvgRiTIJ5KPH+nYhi5CRTxikA2rn0zIN8GcvpfEs+7tguY01es52Od/c
         WhnF5YsOItVk6mFmCnDsbPWbU6htRm+07BOImwtIUgN36NfqKvggJifPbLzYo0Bxhn
         igDY7Hb2f3NQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmKX-1pnI173iFF-00K4tm; Fri, 26
 May 2023 11:05:33 +0200
Message-ID: <a8a442d5-dfc3-a4d9-ce0a-8fcd5d36a3f6@gmx.com>
Date:   Fri, 26 May 2023 17:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs: fix the uptodate assert in btree_csum_one_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com
Cc:     linux-btrfs@vger.kernel.org
References: <20230526090109.1982022-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230526090109.1982022-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8w6cYe8QUOM4hB6bbVQ3nLuCQZOKn9BrV79kub2dOlmv4UR8wWC
 BqSQtFd0CGNpeZe8eZ1prFG9tBLmKdPm8Le5572oI6dZ66FvnJfwIxK4qL3jyINe6vQ0lke
 8hUBCBwomSu7hg12L00PLwGulFgrbGp+Fq9fcgemu5FpdRfW4SkTAv0KQLDawY/X8fg6Gwp
 SON/xJmK13vFdSQ9nXfeA==
UI-OutboundReport: notjunk:1;M01:P0:UtdDt2EwDnU=;FV7aG+vUA6qCzyrwlwMyHBf/xZn
 jigo8PqCiEvn2omJSvIov14Ej2OsW+4TDzBxlwRQOX3wpWvCLysxh5nzUqZao1Pu4NuMAllts
 +BKlJaTdBdo3lO0oPy8r4+daMZZFgkO2344eFyfu6n8rOrxcdRrDrWmcN9IakBjkvR/zvOEPF
 SHFhNUHeGK/7S9UJ01ew8n8g+HKLBMrB79S8IgaMg2OedYy48xAnmBkgFklBje5Z+pATpI4gS
 fc/J3/K8dwNHGycLllJUfd0gWhF1v2aDF4+wHMAoGrSUViRBS5841t4njhhNaZ0DuupxbmgLK
 doi3Mp4B+60vvwsuoZtXiKIqb9cu+UUy4yyJNEFVgSVOcIPLUHUaFtPtm+H7sM+2XhmjAbFvI
 ofK5DJsJzAnFgJJ0qn0BRNXtbWbLcr36bGUnzPirzhqxxXIml8lus3myL0DEctpywBvHXbNwa
 XUmKnjABQgLAsP46eKCqyFTm+xJy3UpeIjDvXYGk7dI6kClC9YSdhpKhshLIo7rSDpvES30j5
 dKc9vyvnzIyga+0JX59zQwgox41XAWr0fKjsdG01rUyk+EaP+Jp0T+jd8aWiB9E5dQcdoT/SC
 nQnqERX/FpaObRJaU6ftRpxNNNULibYigTO/ktcbaSEeAvAcCg3a8/K8WUTVwejxL6RO+L+Rf
 dH00im/zo7S9oySL3wZNVQBWkKRtVfE/lTN/O218N+qmyiKNrQbj0kr2YPHn2U9+sh+PDryHB
 cI2PTpSBFhxqJNd5KDZ1Ri7QkylwI9t9eYTFcAzxafDZ3wVFjJTI0JierAVUTWWosRINY+Oiz
 oQ9gwSq+IYevHz+7kKJ7HGiroo22dmIoURvngFPRBhVO9PB6AOYXziBtY2oEstYrfL5Lmesdm
 PIYNX+7E7450Tw2MosQaZYSYMbXmftOLeowSVWB2jVpjEkyH0aMFmPtDoNRj4l2F3twiR6koI
 5gZ4NXozj2dB1YEhZbHwxe5Pvn0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/26 17:01, Christoph Hellwig wrote:
> btree_csum_one_bio needs to use the btrfs_page_test_uptodate helper
> to check for uptodate status as the page might not be marked uptodate
> for a sub-page size buffer.
>
> Fixes: 5067444c99c3 ("btrfs: remove the extent_buffer lookup in btree bl=
ock checksumming")
> Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c461a46ac6f207..36d6b8d4b2c1fa 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -269,7 +269,8 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bb=
io)
>
>   	if (WARN_ON_ONCE(found_start !=3D eb->start))
>   		return BLK_STS_IOERR;
> -	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
> +	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, eb->pages[0],
> +					      eb->start, eb->len)))
>   		return BLK_STS_IOERR;
>
>   	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
