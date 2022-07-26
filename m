Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E45819D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiGZSir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGZSir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 14:38:47 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF032ED7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 11:38:46 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 12BCA812C8;
        Tue, 26 Jul 2022 14:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658860725; bh=e7CwSIo8ACjGt0L6XQUrJPYctV1uKRRufECAgH0d0Sw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=D3MDW2Qg1NIqfwz+O8z8ttj8u7qnf8Saa/D/zLvIWXmT6InKH9ApkH1SCvX2YFrfy
         oIf+kH1XSbFygZTtPPfZNmtoZ1lXxQ08PMxsNcgO1xpAkcT3X+DIEkr2Md4/IozUOB
         H4MP7n3Z7ZprQSyiaHjLX6HvpClDE/BZneRuxfo2m8OGWD71GEF/OhznPs2oEpnVGj
         nd+2MT8w/+MMWuxJH5ki9XLamDxqzhAX335YeGB8nLBlvq6rCF+xef5oApSdAxOaJ0
         /OXnCksp8ZKgVTLy/MfvAlisV1pLWPkK6ik3y6QBBjQiwFeWJ+HhumOZOvWk+rZkDU
         iTks4VfvjdyfA==
Message-ID: <df4a3d08-cc63-6b15-9e14-d8228f1bf873@dorminy.me>
Date:   Tue, 26 Jul 2022 14:38:43 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <621654191a02dc3cbc5c3b03f6c00963b7e6f382.1658207325.git.wqu@suse.com>
 <4b4b9f52-9c40-2f91-d8a3-a6ed29c379ee@dorminy.me>
 <8d2c653a-eddf-e9b4-7912-d46993705680@gmx.com>
 <20220726182050.GK13489@twin.jikos.cz>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220726182050.GK13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/26/22 14:20, David Sterba wrote:
> On Wed, Jul 20, 2022 at 09:03:33AM +0800, Qu Wenruo wrote:
>>>> @@ -346,12 +346,14 @@ void __cold btrfs_err_32bit_limit(struct
>>>> btrfs_fs_info *fs_info)
>>>>    __cold
>>>>    void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
>>>>                       const char *function,
>>>> -                   unsigned int line, int errno)
>>>> +                   unsigned int line, int errno, bool first_hit)
>>>>    {
>>>>        struct btrfs_fs_info *fs_info = trans->fs_info;
>>>>        WRITE_ONCE(trans->aborted, errno);
>>>>        WRITE_ONCE(trans->transaction->aborted, errno);
>>>> +    if (first_hit && errno == -ENOSPC)
>>>> +        btrfs_dump_fs_space_info(fs_info);
>>>>        /* Wake up anybody who may be waiting on this transaction */
>>>>        wake_up(&fs_info->transaction_wait);
>>>>        wake_up(&fs_info->transaction_blocked_wait);
>>> DO_ONCE_LITE(btrfs_dump_fs_space_info, fs_info) from <linux/once_lite.h>
>>> seems like a more lightweight way to dump the space infos once upon
>>> first transaction abort. Then you don't have to plumb through the
>>> 'first_hit' parameter from btrfs_abort_transaction(), and this change
>>> becomes even more minimal than it already is.
>>
>> Sounds pretty awesome!
> 
> But DO_ONCE_LITE stores the status in one static variable, this cant' be
> used because we want to track the status per filesystem, and also per
> mount. Ie. repeated ENOSPC after umount/mount cycle won't be reported,
> also another filesystem hitting abort due to ENOSPC.

That's a great point, I agree it would be better to print the first 
abort per filesystem/mount instead of only once per reboot now that it's 
noted.
