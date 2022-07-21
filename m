Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3357CC15
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiGUNhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 09:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGUNhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 09:37:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9856A7E800;
        Thu, 21 Jul 2022 06:37:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C5BA1F381;
        Thu, 21 Jul 2022 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658410664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sLxPDxaM3pGA+SPBUqfQiTnWfVBidgjd2tCWjISh03w=;
        b=sZ4dIBZTG+0nINDK/hL8I6fk2f9mRAwN6Q098UHGyA4HFW2E9sM0CDaQyPk1M9u2JVCs3Y
        2GDiHtU6bwpiMgWcTzhJZeoJEq8GB56SVDJdrdxFq0ZjANrYbYqipYTJbYrw8teNJdI81k
        15n1p8tc/5JqmeD5LXYJ2UwhOz3u8Bw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF49313A1B;
        Thu, 21 Jul 2022 13:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C1zrL6dW2WKUKwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Jul 2022 13:37:43 +0000
Message-ID: <0c2337c3-2b39-c54c-27e9-dd4f0a99cf71@suse.com>
Date:   Thu, 21 Jul 2022 16:37:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH]btrfs: Fix fstest case btrfs/219
Content-Language: en-US
To:     "Flint.Wang" <hmsjwzb@zoho.com>, anand.jain@oracle.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721083609.5695-1-hmsjwzb@zoho.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220721083609.5695-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.07.22 г. 11:36 ч., Flint.Wang wrote:
> Hi,
> fstest btrfs/291 failed.
> 
> [How to reproduce]
> mkdir -p /mnt/test/219.mnt
> xfs_io -f -c "truncate 256m" /mnt/test/219.img1
> mkfs.btrfs /mnt/test/219.img1
> cp /mnt/test/219.img1 /mnt/test/219.img2
> mount -o loop /mnt/test/219.img1 /mnt/test/219.mnt
> umount /mnt/test/219.mnt
> losetup -f --show /mnt/test/219.img1 dev
> mount /dev/loop0 /mnt/test/219.mnt
> umount /mnt/test/219.mnt
> mount -o loop /mnt/test/219.img2 /mnt/test/219.mnt
> 
> [Root cause]
> if (fs_devices->opened && found_transid < device->generation) {
> 	/*
> 	 * That is if the FS is _not_ mounted and if you
> 	 * are here, that means there is more than one
> 	 * disk with same uuid and devid.We keep the one
> 	 * with larger generation number or the last-in if
> 	 * generation are equal.
> 	 */
> 	mutex_unlock(&fs_devices->device_list_mutex);
> 	return ERR_PTR(-EEXIST);
> }
> 
> [Personal opinion]
> User might back up a block device to another. I think it is improper
> to forbid user from mounting it.
> 
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>


This lacks any explanation whatsoever so it's not possible to judge 
whether the fix is correct or not.

> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6aa6bc769569a..76af32032ac85 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -900,7 +900,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		 * tracking a problem where systems fail mount by subvolume id
>   		 * when we reject replacement on a mounted FS.
>   		 */
> -		if (!fs_devices->opened && found_transid < device->generation) {
> +		if (fs_devices->opened && found_transid < device->generation) {
>   			/*
>   			 * That is if the FS is _not_ mounted and if you
>   			 * are here, that means there is more than one
