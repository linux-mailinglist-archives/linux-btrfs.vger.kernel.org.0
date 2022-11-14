Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B462849B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 17:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiKNQGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 11:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKNQGO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 11:06:14 -0500
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8301EED5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 08:06:05 -0800 (PST)
Received: from [192.168.1.27] ([84.220.130.49])
        by smtp-17.iol.local with ESMTPA
        id ubyFo0u1LEcXqubyFomVVp; Mon, 14 Nov 2022 17:06:03 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1668441963; bh=cpIo5HU8hw328y8VTrapYnGJeaDo0yX7P+0Fs/r89Dw=;
        h=From;
        b=B0oew7VpG2Xo/705RXTXvG23fm9oaDZeoeq6az3hsvK84VqB8fPsMYLBgkN4ulNy6
         MFj2r/ebCGB6sSWoofUnUXyhiJpqah0SYNd5Fe5FkOa1qMtjDiqXS8w+NdB2sGjMgt
         IdDiGE/Pnw1nlbQNDMSrrfV2y6UcdDAqE0pbqPDaHsU2LVEpIxZ/Oj+VY4gXOqceOs
         01GYvE0BFyieJ2/x2mJNN+5xxq8Is00v0/gXKbSBxd5K32qT9PtVmfvaBqjNP0FPDW
         fyVNqCMf1BkXX7DuBigREC+op6lIEQ3bF6nd4yg6MqIQbZQYz7+TsN7xEdDkCv7mjm
         /D5KibDNbQjzw==
X-CNFS-Analysis: v=2.4 cv=TpEjOBbh c=1 sm=1 tr=0 ts=6372676b cx=a_exe
 a=SdbLdwgxGF07xCE66nLfvA==:117 a=SdbLdwgxGF07xCE66nLfvA==:17
 a=IkcTkHD0fZMA:10 a=u6YyhnjlyNqXpZw8EIMA:9 a=QEXdDO2ut3YA:10
Message-ID: <516619f0-2111-a259-6685-823ea48c959b@libero.it>
Date:   Mon, 14 Nov 2022 17:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/5] btrfs: use btrfs_dev_name() helper to handle missing
 devices better
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1668384746.git.wqu@suse.com>
 <3382bb8f7ab90e52ffa86cb39253ab5bdb78026e.1668384746.git.wqu@suse.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <3382bb8f7ab90e52ffa86cb39253ab5bdb78026e.1668384746.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOWjMq80IUadR3O0oLbNi/azNGut4eaCrBOjK2yVqE0Jibezx0xJ73Iw3/Sty5yGjL/loYgSJuqw1TS5ZsUXQoBeRQ6ZzCMPin03dISGafQ7tm31FvAg
 Zxs2Qd5QBJKsogLc3+78LUWl69YBxCR902WRLtTup9iox7kE6EWxrZioA4W8KkDmlWVA02ThysppA3Mn9d+peZj5r4B3KbQPFvkPMVw15rRRO2CIqN+RCXmU
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/11/2022 01.26, Qu Wenruo wrote:
[...]
> @@ -770,6 +771,14 @@ static inline void btrfs_dev_stat_set(struct btrfs_device *dev,
>   	atomic_inc(&dev->dev_stats_ccnt);
>   }
>   
> +static inline char* btrfs_dev_name(struct btrfs_device *device)

Because we are returning a static char*, should we mark the return
values as "const char*" ?

static inline const char* btrfs_dev_name(struct btrfs_device *device)

> +{
> +	if (!device || test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
> +		return "<missing disk>";
> +	else
> +		return rcu_str_deref(device->name);
> +}
> +
>   void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
>   
>   struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

