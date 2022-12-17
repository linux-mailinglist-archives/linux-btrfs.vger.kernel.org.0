Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC9364F601
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLQAWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 19:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiLQAV5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 19:21:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE47A61D4F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 16:15:51 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsIv-1oo7cr1GR5-00ssMB; Sat, 17
 Dec 2022 01:15:47 +0100
Message-ID: <f4b009e8-0c73-0415-2794-8af034450e04@gmx.com>
Date:   Sat, 17 Dec 2022 08:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/8] btrfs: fix uninit warning in run_one_async_start
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <5501d33f6ac5af3f371c8734793baeddcde75b4d.1671221596.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5501d33f6ac5af3f371c8734793baeddcde75b4d.1671221596.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rd87XDmMClHtRCIm57cOvdhypvyhglqjvXoPcxkpWNvpzYiMX73
 LYqIv0b03JMEvcsghdi1HnWj238X6cZja2kLJTFwU7pvX2O9/l2JO8qDF2twjgWJLVYlsc6
 52EDCpqPCTYuQyO8ohV4dsvSis2bNxRR53ZftvpSD982P2rj6t88bB9E429OaDDiqjahSah
 gcl6N5RE+cfkGP3HtUDBQ==
UI-OutboundReport: notjunk:1;M01:P0:IOhd4Liiv1s=;B8SuS1w7sZB9Kwt++lff0TRK7ez
 K3Mp8pHZN5VAsJSfzMaCodwLF2dNZMPg/usclm+QhiylEsOVQw6+2+jhjr/QyEc3G9eYOY3EO
 Yb24ZX3uNJ3K1Wb8s9aAeTMnqslWcQC9mdVI/XACYymHOR294j7RH48s6jJCFwjnS1PBtfPBX
 ujS2JiHTLxuD6eXMXftpSK0H/SLg+OllMMoRo3Cp/4jhdspAv+oeUuBFtra8zrklHRyF7Hx3K
 LP56EsRLRI2A2dDW09c9QLyzSLrCwBT7WELqNqdXHVlV+cJWp6AuZt/p2aL4paz216JJc/pIX
 st/sMIV11osAoEAVMgm6/28E+MgXil6uSfeLCpqO/pZi9y0Iozuk3Sb8WxzGOFrFRGQyxxoK8
 9YU5gtvJy1vF6O+7EapCFCH+u40jD1mbVitl2HgceFalWtDt+S25sBvxb1A6hGlK7OY+4Gqpo
 m8viRSQenneUXqv8Y/W1FAhWvN2Yp99xvgi9f4X5kqWVPR/Q73/tjSo9x5zQjcAJGZHMLX1OI
 xowc24uqzlXz91ShL7f9rkeScIXWtESSv0IjEKtyMiS7844EyTZQcNoH6QFuxmiNpwwWxaAp3
 YHISHelVKdKN0y9v8VZUT5jFxaVTRvipMkoOF66zT0PN4egJtLEwZur7WacbJGvx+RrwZvabU
 zeafvEZUXwsiImwWqbuqCV1Gx8AUCVw4G2Yxon+6bQ/K+7sczt1P/zqfpn55jBcZBjDzgxHGG
 Cb3aYuHPQlQqU5cdrCjL1ZWPZgr1D7bvz67WwZx415urqYtucAATaseP52V14QSUGUv0aFhnO
 52WppmfR/EGz2/2ZPR8zCRZUl+vWPdZjcvWDD7+3n1jqZ4BRy1pCvDk0RPwsW07fKrGJNmbN0
 1kcyv6qvJp1ItiV8wLETyB8rZ/Vn37Kt47FjkVJ8j8sEzxwHn+Mvh3BnaMwAC64unsSrlRicY
 EniZEhuUxeF8miZBWEeIvjqkxtU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 04:15, Josef Bacik wrote:
> With -Wmaybe-uninitialized complains about ret being possibly
> uninitialized, which isn't possible, however we can init the value to
> get rid of the warning.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0888d484df80..c25b444027d6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -693,7 +693,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
>   static void run_one_async_start(struct btrfs_work *work)
>   {
>   	struct async_submit_bio *async;
> -	blk_status_t ret;
> +	blk_status_t ret = BLK_STS_OK;
>   
>   	async = container_of(work, struct  async_submit_bio, work);
>   	switch (async->submit_cmd) {
