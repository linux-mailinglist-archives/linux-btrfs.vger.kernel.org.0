Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44E972F3F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 07:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbjFNFJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFNFJD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 01:09:03 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F95F199
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 22:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1686717661; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=1wZepGKw7/+d6FN/CQB1NeYx1jhwYWNbwX71I5lVz7w=; b=YdRTWaoeEKk0C
        N1DB7KbZhRlknq6iCLuVWnFee4rYi9hShokrd5uhgPqXkoqy3LrQpUqp0yI24JW9lusUf6CmQk+Nv
        OoHp6GlBeLZ7mvrJ8DLZHA4evDwUwFt0UlBfYHVZ5OU1Fah2D2J+5IixirsIps25EP3hX1mIS9TXQ
        jDuWek1SKZnTTIa+q7qbzj7ndOvzIuy5/yISY1Fllnr5uhXRYqA/GKJ8VGtzC/HdQ/qbM8ubI6mlT
        RYDhLqahRjjEwn++xhLx4OzmY5WyyWYeKomPvvlz6Al2YcD7CYpWzaOTVmSu+ZNdz1pvCKeTto9yq
        ymJpxkrKpk6HtL/QC9VZQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1686717662; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=1wZepGKw7/+d6FN/CQB1NeYx1jhwYWNbwX71I5lVz7w=; b=B8ZbFTQyU0av4xAgNoolx12UJC
        SMcz5FZNc5urOJWlJzmBGqitIMVp9lQ7zNgUTd/7XgO+wAPJEb7Bnsep1Nc6B228WNM0SxW484Mqm
        z31oPoFQKIerw4L970HtZEbEoCZo40+VQWP2HhWpZlPgjOLe7HhBRlGZxZ7FsxUx7EGsF64029eMA
        9PTHE1UUZcbl4Jm90RaqwgFPClEVvp4mCwLh0O92Zf54PNKJJk6H6ACOxGLNyoC/TFrvqV1jBDM/2
        UACCociBr2eVgQFc9MBc0hlmEUBmvOEPEbdXKg8/TlyjoNsvw0FALHt1KwMXifGRFwZTG4d9rdXAs
        49iZ6OdA==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q9Ikf-006WyP-0x;
        Wed, 14 Jun 2023 05:09:01 +0000
Message-ID: <e651ac29-0d07-994e-b9d9-d7d0c975723f@bluematt.me>
Date:   Tue, 13 Jun 2023 22:09:01 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
Content-Language: en-US
To:     kreijack@inwind.it, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <276ea9bf-13f3-1349-a5b6-4dfcaaab7ef2@bluematt.me>
 <ed8c45b9-1b83-d706-add9-fa2d5f41576d@libero.it>
 <e3636d48-92c7-27e3-b63e-b3605fcc1dbf@bluematt.me>
 <a7851ed8-8b1f-3ec0-56a4-fe059bdf6183@inwind.it>
 <8f857c05-446e-dab1-5863-e6fdf737acff@bluematt.me>
 <11552d49-cbd0-fc15-07b7-77f73b8cb955@inwind.it>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <11552d49-cbd0-fc15-07b7-77f73b8cb955@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/6/23 10:38 PM, Goffredo Baroncelli wrote:
> 
> Hi Matt
> On 07/06/2023 00.31, Matt Corallo wrote:
>>
>>
>> On 6/6/23 11:27 AM, Goffredo Baroncelli wrote:
>>> On 06/06/2023 01.45, Matt Corallo wrote:
>>>>
>>>>
>>>> On 6/5/23 2:10 PM, Goffredo Baroncelli wrote:
>>>>> Hi Matt,
>>>>> On 05/06/2023 21.31, Matt Corallo wrote:
> [...]
> 
>>
>> Having a fallback here which wipes all the bits but single and forces us to single still feels 
>> like very much the wrong fallback, if we want a fallback, we should pick a bit that exists on the 
>> fs, not make one up, and we should definitely not make one up that has a lower redundancy level 
>> than what the user is expecting.
> 
> See below
> 
> [...]
> 
>>>>
>>>> No, having a case where we randomly go from a RAID system to falling back to SINGLE is really 
>>>> not an okay fallback. We should just remount-ro.
>>>
>>> Even thought I don't like the logic too, this logic is used from several years (if
>>> not from ever); and nobody complained.
>>
>> Not sure what you're referring to here, 
> 
> Basically, the original code try to find a valid combination between the available disks and the 
> existing profile.
> If there is no combination, the function return 0, which means SINGLE.
> 
> This is the logic that I don't like (I am not referring to your patch).
> 
> 
>> I'm just a user trying to fix a transaction-abort I saw on my system and needed this patch to get 
>> my fs to mount RW :). At least the specific code in get_alloc_profile has no such fallback.
> 
>>
>>> Anyway for me it is enough to have a WARN_ON; but without that the patch losses most of
>>> its interest.
>>
>> I don't really get this - the current code isn't just kinda messy, its also very broken, a patch 
>> that fixes the brokeness, which I ran into as a user, should be "interesting" irrespective of if 
>> it also cleans up the code, which is messy but certainly far from the worst code in kernel 
>> anywhere :).
>>
> 
> You find a bug, you did an deep analysis and you wrote a patch to solve this issue.
> This is a valuable work and I my intention was not to dismiss it in any way.
> Sorry if I was not clear about that.
> 
> What I meant is that the patch will get a lot of *more* value if you try to address the risk of the 
> reoccurring of the problem when someone will add a further profile.
> 
> Told that, I agree on the "complexity" of the code;

Totally agree, and I'd love to address it in some meaningful way, but I don't really see a way of 
doing that without ripping it up and rewriting it which I'm certainly not qualified to do. The naive 
solutions of just having a more explicit fallback seem worse than remount-ro to me, but of course 
you're welcome to redo it better :).

Matt
