Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7348C7A35AD
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Sep 2023 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjIQN0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Sep 2023 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjIQN0n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Sep 2023 09:26:43 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD7130;
        Sun, 17 Sep 2023 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i55GacjFfvpi2lY8tq/Ou7khIcsRJODO7Ak5KpqGSaE=; b=Qki9ozp7J1O5tvLNps9Aus1s/6
        TVHvLxAIJFFoaJo0YSePw5AaMBTM/gMjU4FiKvkxV/uQdFoAFX4tl0y6DJuTXmBnnJ9TSlxQlkVM2
        9oMefmmFXax2EIPLl/LG57EDl3e7ND17M/p6uU5VSc+J2EO/wU2lkoyBgqFf7lXZ1FkXHYukLRatM
        3LKxMtV+lWYdJdxV5dZVkLRpCWKk0lMPX8or5kUgH9Y8UvAJYCeo7NgYpk4HgdYLS3tSddnIiZQpe
        OI72S6DYCLv9G01b1VMw9yFwogrLa2r0HiAb0J0u8xfVLab14Q+41Md7EsXTn02PYEGJl3eGHcUb/
        r/CDJGnQ==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qhrnE-005OUw-1n; Sun, 17 Sep 2023 15:26:32 +0200
Message-ID: <9bf6e41f-9e33-77e0-4708-2896f38a51b9@igalia.com>
Date:   Sun, 17 Sep 2023 10:26:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] btrfs: Add test for the temp-fsid feature
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, dsterba@suse.cz,
        kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20230913224545.3940971-1-gpiccoli@igalia.com>
 <0ab7fabb-a59e-df61-7a16-44457df2992a@oracle.com>
 <10911f40-b4df-43c2-4843-c97dbc7af583@igalia.com>
 <f8a610fd-b9b0-699f-6611-edd610728c0c@oracle.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <f8a610fd-b9b0-699f-6611-edd610728c0c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/09/2023 05:38, Anand Jain wrote:
> [...]
> +_require_btrfs_mkfs_feature temp-fsid
> +_require_btrfs_fs_feature temp_fsid
> 
> This will suffice for backward compatibility. My bad. I missed it.

Thanks for clarifying =)


>>>> +_scratch_dev_pool_put 1
>>>
>>> _scratch_dev_pool_put
>>>
>>> takes no argument.
>>
>> Thanks for noticing that! Will fix in next version =)
> 
> No worries. If this is the only change required, it can be fixed during 
> the merge.

Great then!
Cheers,


Guilherme
