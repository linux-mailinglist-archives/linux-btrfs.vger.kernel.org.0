Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C14EBFA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 13:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbiC3LOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbiC3LOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 07:14:49 -0400
X-Greylist: delayed 506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 04:13:03 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895B0A0BC0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 04:13:03 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id EA4059B7D2; Wed, 30 Mar 2022 12:04:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1648638274;
        bh=bgRn/LfCAdXOoPql87SJiA49F9CR3KGR52wndoMRsXI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=gDlAq2Ruwbx7W6PtOmxFcjv8go/8FC1eUebQmTjYJVnPqbzKXW8S7C0cont115eOG
         yB/j90Y9uN9U6XJm2cXF9ldtAmPJRz6BrVlHI0z+bN5K85Wk3CWx2hjRWU3CRpOZLS
         letqgCmUKJwWoMMLARUKaYs71TFg6tFv/7ZQ/RLR+ejGG/jLAZk5Y520ImJ/K0NGsw
         CksLcrAg5mItWi6C0tR3O78DP8eUhxJII/YFp7m551Ls+M103vL0nsCb+kGfcJtKFx
         AXPtQ0t9ESbe8Wwk0SZbe+S92UYbYlbm4PDp/e28lZFyD+K17KHerwK1frLdFciq3m
         AW+msPr7JaWSQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id A2E4B9B6AB;
        Wed, 30 Mar 2022 12:03:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1648638216;
        bh=bgRn/LfCAdXOoPql87SJiA49F9CR3KGR52wndoMRsXI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=nL8+taU9aXyUD+AFpKi4HHrmDMC3oEnBpQep3ScNfgfe1TftQWwxUJchCe9OFa47M
         +CFhaM8UnJQFY2I1OTJdLADfUfN64pFNE38fDzDGBH7KDfFCuxJ57uKpoNkBeB7ewf
         FXGt6YTQmJS6ZY7rrWYTjazCT0hlVZl5rs5faddU3ggXE59VR8tUHKXOzY5C5uUCY4
         tuPsfU6xJVxtE3nmPJuiQnfPRhHyrSDSUFF0bhWZrC5/LWxQfqbHFTS98k4pwMGkxf
         YQ12TiqXGRCwl8c/0ud7QgMJUERNsh/rqixX67k8MnN3mbtUsO3fS5wqRwI0TEOu4B
         5jGpG9iw9/x9w==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 5BBA8146044;
        Wed, 30 Mar 2022 12:03:36 +0100 (BST)
Message-ID: <bc1c01bd-7f98-a2a3-8a2e-2a1c1d31e853@cobb.uk.net>
Date:   Wed, 30 Mar 2022 12:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz> <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
 <YkLwAf7SK95iOreD@debian9.Home>
 <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
 <YkQimcdT5KwU5i/P@debian9.Home> <YkQyLfTjAjbPZR9y@debian9.Home>
 <6e5e4112-8b9f-fcb4-1a04-c68db2fa9880@gmx.com>
In-Reply-To: <6e5e4112-8b9f-fcb4-1a04-c68db2fa9880@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 30/03/2022 11:42, Qu Wenruo wrote:
> 
> 
> On 2022/3/30 18:34, Filipe Manana wrote:
>> On Wed, Mar 30, 2022 at 10:27:53AM +0100, Filipe Manana wrote:
>>> On Wed, Mar 30, 2022 at 07:52:04AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/3/29 19:39, Filipe Manana wrote:
>>>>> On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/3/29 17:57, Filipe Manana wrote:
>>>>>>> On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
>>>>>>>> On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
>>>>>>>>> The original code is not really setting the memory to 0x00 but
>>>>>>>>> 0x01.
>>>>>>>>>
>>>>>>>>> To prevent such problem from happening, use memzero_page()
>>>>>>>>> instead.
>>>>>>>>
>>>>>>>> This should at least mention we think that setting it to 0 is
>>>>>>>> right, as
>>>>>>>> you call it wrong but give no hint why it's thought to be wrong.
>>>>>>>
>>>>>>> My guess is that something different from zero makes it easier to
>>>>>>> spot
>>>>>>> the problem in user space, as 0 is not uncommon (holes,
>>>>>>> prealloced extents)
>>>>>>> and may get unnoticed by applications/users.
>>>>>>
>>>>>> OK, that makes some sense.
>>>>>>
>>>>>> But shouldn't user space tool get an -EIO directly?
>>>>>
>>>>> It should.
>>>>>
>>>>> But even if applications get -EIO, they may often ignore return
>>>>> values.
>>>>> It's their fault, but if we can make it less likely that errors are
>>>>> not noticed,
>>>>> the better. I think we all did often, ignore all or just some
>>>>> return values
>>>>> from read(), write(), open(), etc.
>>>>>
>>>>> One recent example is the MariaDB case with io-uring. They were
>>>>> reporting
>>>>> corruption to the users, but the problem is that didn't properly check
>>>>> return values, ignoring partial reads and treating them as success:
>>>>>
>>>>> https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=216582&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-216582
>>>>>
>>>>>
>>>>> The data was fine, not corrupted, they just didn't deal with
>>>>> partial reads
>>>>> and then read the remaining data when a read returns less data than
>>>>> expected.
>>>>
>>>> Then can we slightly improve the filling pattern?
>>>>
>>>> Instead of 0x01, introduce some poison value?
>>>
>>> Why isn't 0x01 a good enough value?
>>>
>>> A long range of 0x01 values is certainly unexpected in text files,
>>> and very likely
>>> on binary formats as well. Or do you think there's some case where
>>> long sequences
>>> of 0x01 are common and not unexpected?
>>>
>>>>
>>>> And of course, change the lable "zeroit" to something like "poise_it"?
>>>
>>> "poison_it", poise has a very different and unrelated meaning in
>>> English.
>>
>> It's also worth considering if we should change the page content at all.
>>
>> Adding a poison value makes it easier to detect the corruption, both for
>> developers and for sloppy applications that don't check error values.
>>
>> However people often want to still have access to the corrupted data,
>> they
>> can tolerate a few corrupted bytes and find the remaining useful. This
>> has
>> been requested a few times in the past.
> 
> This looks more favorable.
> 
> And I didn't think the change would break anything.
> 
> For proper user space programs checking the error, they know it's an
> -EIO and will error out.
> 
> For bad programs not checking the error, it will just read the corrupted
> data, and may even pass its internal sanity checks (if the corrupted
> bytes are not in some critical part).
> 
> Or is there something we haven't taken into consideration?

Well.... If an error occurred something has gone wrong. It could be a
simple bit flip in the storage itself, or it could be something else.
The something else could be a software or firmware bug, or a memory
corruption or memory controller power fluctuation blip, or .... I guess
it might even be possible in some architectures that the problem could
result in page table updates validating a page that actually was never
written to at all and could still contain some previous contents.

In a time when we worry about things like Spectre, Meltdown, Rowhammer,
stale cache leakage, etc it may be a good security principle that data
left over from failed operations should never be made visible to user mode.

Possibly unnecessary worrying, but then who thought that jump prediction
would create a side-channel for exposing data that can actually be
exploited in real life.

Graham
