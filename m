Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D291F7172D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 03:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjEaBCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 21:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjEaBCT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 21:02:19 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97876C9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685493661; h=In-Reply-To:From:References:Cc:To:Subject:From:Subject:To:
        Cc:Reply-To; bh=4sjSKkNo66x7lpjtLFGsxClKBHV5zoN2Az1Pf/sL5xQ=; b=cldtQYn2Pq3LD
        CF2rkSOwKcvhOefUztDezy3e9gHNutXYNor+DcD+UPJm6O/vUF5YWHgb0AJOKRxJC6AqEHUGNNdEC
        8Kkx65Tkm4qswlCIrWAOBAIAmraiBN1Zdh/v9JihUoId7Sof4Nua6ROVG7LWKHydl3F3FKJ33UqbF
        rkAcRZmfLE6eL1Wf3VpHCgvAwNkeD86dXgLoBQX5eynyVhkQfPhKlEPEXa2b9YFgMbsxuk5ce/+J3
        lQuqvo9MX96S6QF179Ex+Nzx1eArqWFg8HqChKQk7UwegETLaKkURQR9UpVlfAibKfH6BVu5oTcVo
        9/uqlPUxUIB505CyQh1nQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685493663; h=In-Reply-To:From:References:Cc:
        To:Subject:From:Subject:To:Cc:Reply-To;
        bh=4sjSKkNo66x7lpjtLFGsxClKBHV5zoN2Az1Pf/sL5xQ=; b=l/VCLOjaoQ7qGBVsUU3UK1fmF/
        J1n+P5VkhcTCSc6cRz1IYlM++9FshCvmLwI554K8yBnXKncUDuvElNLj2zvpwqTP+bEWaB7JKGfMt
        H8zoxq7TKYZc1uzp3ul1icpwzJvsof3MeHLsdiezMYcXYLPszU6akRGbkaOk96Ris98N0GIJrbI6T
        5PFxRWTpyhKwJLtYp6zxWygchGV3oGB2WKYogM+uNscu2ZxkGkvX/LqH5JcXHgNfectTqfe3wBWVY
        Rtzc9Tc+s8hazxz+rk7ced25bg1sB00EflLbhAK4lwEgN7y8dVuiSykvyBLNTmOtqKQjX8b1bQh+g
        DKYEf5tw==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q4AED-003CvK-27;
        Wed, 31 May 2023 01:02:17 +0000
Message-ID: <c3c174e6-f294-b35d-0924-cc12c173eba3@bluematt.me>
Date:   Tue, 30 May 2023 18:02:17 -0700
MIME-Version: 1.0
Subject: Re: [6.1] Transaction Aborted cancelling a metadata balance
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <bc26e2b2-dcb1-d4a2-771e-82c1dbf4f197@bluematt.me>
 <20230529141933.GH575@twin.jikos.cz>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <20230529141933.GH575@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/29/23 7:19 AM, David Sterba wrote:
> On Sun, May 28, 2023 at 08:17:30PM -0700, Matt Corallo wrote:
>> On a subpage, ppc64el 6.1.20 spinning-rust filesystem (which was (mostly) btrfs check'ed not too
>> long ago and passed scrub):
>>
>>
>> ....
>> [1158664.424471] BTRFS info (device dm-2): relocating block group 52117042626560 flags metadata|raid1c3
>> [1158744.142005] BTRFS info (device dm-2): found 7188 extents, stage: move data extents
>> [1158769.675743] BTRFS info (device dm-2): relocating block group 52115968884736 flags metadata|raid1c3
>> [1158770.648131] BTRFS info (device dm-2): balance: canceled
>> [1158770.648155] ------------[ cut here ]------------
>> [1158770.648157] BTRFS: Transaction aborted (error -22)
>> [1158770.648205] WARNING: CPU: 43 PID: 1159593 at fs/btrfs/extent-tree.c:4122
> 
> it's 6.1.20 on powerpc64le/power9
> 
> 4115                         ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
> 4116                                                 CHUNK_ALLOC_FORCE_FOR_EXTENT);
> 4117
> 4118                         /* Do not bail out on ENOSPC since we can do more. */
> 4119                         if (ret == -ENOSPC)
> 4120                                 ret = chunk_allocation_failed(ffe_ctl);
> 4121                         else if (ret < 0)
> 4122                                 btrfs_abort_transaction(trans, ret);
> 
> where -22 is EINVAL, returned from btrfs_chunk_alloc but I don't see it
> returned directly, only ENOSPC which is handled.
> 
> A probable call chain:
> 
> btrfs_chunk_alloc
>    do_chunk_alloc
>      btrfs_create_chunk
>        alloc_profile_is_valid
>           return -EINVAL on invalid profile combinations
> 	 or if !(type & BTRFS_BLOCK_GROUP_TYPE_MASK)
> 
> Which would mean that either invalid combination of flags/block groups
> has made it down to the allocation helpers or there was some other cause
> where the flags got changed since the first time.

Indeed, it fails here on the has_single_bit_set check with a flags value of 1536 (0b11000000000).
