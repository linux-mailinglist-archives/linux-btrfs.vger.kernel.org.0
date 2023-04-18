Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEA6E5744
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDRCFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDRCFK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:05:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1EDE6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:05:08 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof9F-1q7uyb2hjt-00p6kI; Tue, 18
 Apr 2023 04:05:01 +0200
Message-ID: <ef27f8e9-df8f-316a-eb90-e2227572c910@gmx.com>
Date:   Tue, 18 Apr 2023 10:04:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH U-BOOT 3/3] btrfs: btfs_file_read: zero trailing data if
 no extent was found
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-3-47ba9839f0cc@codewreck.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230418-btrfs-extent-reads-v1-3-47ba9839f0cc@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gP7G0xLf0lVREVIBRYsg80pnopWcnMiDS7OxxSHdKG+3RmxbxQa
 2iMAYQe/hytkAUuWzF+LVzTMXnZULkM1o8Pz84xVl2ql8+nOtmuWBPr5q6faBN7fZKXv6gK
 AgFPYlppLUaQ0bP+7xYBdNrsQJ2LdD9iGYdr9QCopJaIXoAnDvjAnjKyxqqq65STMEPWtFd
 7pxXRLoPArntO/nT/Hl0A==
UI-OutboundReport: notjunk:1;M01:P0:amhZMirF9ks=;CdZPiL3TFqFNTksEj8xplm5RzFs
 r4+OUe//hRTCG4UynaKXyYcrduU5uFSzYKJPj6aQES2GhDoGZkxpg00lYAuMOdiwnDVkRtv05
 WAvMM7EddapvY/g8ErfZ8BBHJP4IO2bvKH/dyE5iTmkd5p7HzKEtJwnXiUtb9bqS0oiVOSVt0
 9JxN1vh3bTiNU/wwYqXmMqrpcScWYsVqoR+SKahEt7JOoOrCo1TDEIvqg2JwyZnYHljh0bris
 xuRk/BdsX5kT5Dyw+pmUGb2i/KdqG1dD8J7ZOPZjOAlb4rVrF/bzznfNdl9y1TK2jXHEKfzDm
 qVgqFQ5a299bXmOKmMwJdTgfeL6DAvW6l50S/jvWmhAPl7ooJf0/dehnhhqsYTC2NT2stP1z8
 haaul34RsBQjmwp4VPI6THByB9u8b7vFEEyuxc3P8xbpdXG5bZ3embzTUwXoCqb5c0vplc6ls
 yo0AEMF7c/G3wR0eXT+7H5oF3H1FAtbMNp9vds9TWr1FcrhzFpvkHL0XRj34jqPtdLNmOaC65
 J++hnbKo8EEZAEOUviKOw7mTNmfjaTgMd+UcdWXnfkGYov4HG1wBDV3krhbMCKEX5G4Bnjt2/
 ZF8l8UFCZzQs5Smho/X2sh73/cfkTED+7DwJVIgQpE7ZGZ+LavCzeKhgGcV83nWx3aLGs8D8L
 k0a7V3cjmSghZs/CSOxhYDTpHDPmdEqo/vnXjIkdUTYGX9YD67F0BdyzuBmr/a9Hr/9oKF7X3
 F/lG2V8lrs2AtmX6F6BC7Cnr3E8CUwFthMnBS41HPfVD6jCAY3iHOB5cKrojIQwxLLJiM95A0
 FerdArIZ84NSC6U92vDJqCIGRLnNce+2b8BHGnR4Gq76mXLuemz29obItGPUbwSgwLVcMWZXC
 5HqDUioDgRxvo5fq1agPBVw9sHScFw2cfynLLix8cl5KymjDU5S+vqjxOBhGDWMxJblKN8KBA
 K28ukD7NB5dLRMtwY5Acbm8wnXw=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 09:17, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> btfs_file_read's truncate path has a comment noting '>0 means no extent'
> and bailing out immediately, but the buffer has not been written so
> probably needs zeroing out.
> 
> This is a theorical fix only and hasn't been tested on a file that
> actually runs this code path.

IIRC there is a memset() at the very beginning of btrfs_file_read() to 
set the whole dest memory to zero.

This is to handle cases like NO_HOLE cases, which we can skip hole extents.

Thanks,
Qu
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
>   fs/btrfs/inode.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index efffec0f2e68..23c006c98c3b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -756,9 +756,12 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
>   		btrfs_release_path(&path);
>   		ret = lookup_data_extent(root, &path, ino, cur,
>   					 &next_offset);
> -		/* <0 is error, >0 means no extent */
> -		if (ret)
> +		/* <0 is error, >0 means no extent: zero end of buffer */
> +		if (ret) {
> +			if (ret > 0)
> +				memset(dest + cur, 0, end - cur);
>   			goto out;
> +		}
>   		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
>   				    struct btrfs_file_extent_item);
>   		ret = read_and_truncate_page(&path, fi, cur,
> 
