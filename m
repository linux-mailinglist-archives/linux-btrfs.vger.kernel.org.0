Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCBD7D8A19
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjJZVN5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 26 Oct 2023 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVN4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Oct 2023 17:13:56 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF011B2;
        Thu, 26 Oct 2023 14:13:53 -0700 (PDT)
References: <87fs1x1p93.fsf@gentoo.org>
 <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
 <740c38b1-60eb-41da-93e0-7d7671f0b3fc@suse.com>
User-agent: mu4e 1.10.7; emacs 30.0.50
From:   Sam James <sam@gentoo.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>, Sam James <sam@gentoo.org>,
        gregkh@linuxfoundation.org, dsterba@suse.com,
        patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
Date:   Thu, 26 Oct 2023 22:12:27 +0100
Organization: Gentoo
In-reply-to: <740c38b1-60eb-41da-93e0-7d7671f0b3fc@suse.com>
Message-ID: <878r7paxys.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Qu Wenruo <wqu@suse.com> writes:

> On 2023/10/27 00:30, Holger Hoffstätte wrote:
>> On 2023-10-26 15:31, Sam James wrote:
>>> 'btrfs: scrub: fix grouping of read IO' seems to intorduce a
>>> -Wmaybe-uninitialized warning (which becomes fatal with the kernel's
>>> passed -Werror=...) with 6.5.9:
>>>
>>> ```
>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2075:29:
>>> error: ‘found_logical’ may be used uninitialized
>>> [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>>>   2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>>>   2040 |                 u64 found_logical;
>>>        |                     ^~~~~~~~~~~~~
>>> ```
>> Good find! found_logical is passed by reference to
>> queue_scrub_stripe(..) (inlined)
>> where it is used without ever being set:
>> ...
>>      /* Either >0 as no more extents or <0 for error. */
>>      if (ret)
>>          return ret;
>>      if (found_logical_ret)
>>          *found_logical_ret = stripe->logical;
>>      sctx->cur_stripe++;
>> ...
>> Something is missing here, and somehow I don't think it's just the
>> top-level
>> initialisation of found_logical.
>
> This looks like a false alert for me.
>
> @found_logical is intentionally uninitialized to catch any
> uninitialized usage by compiler.
>

I feel like this sort of thing is going to be inevitable with -Wmaybe-uninitialized.

> It would be set by queue_scrub_stripe() when there is any stripe found.
>
> If there is no stripe found, queue_scrub_stripe() would return >0,
> then we know there is no more extent and break the loop.
> If there is any error, we error out too, thus no problem with that.
>
> So to me this looks like a false alert.
>
> Mind to share the compiler and its version?
>

Sure, GCC 14.0.0 20231022 (experimental). Sorry, I'd meant to include
that in the original post..

> Thanks,
> Qu
>> -h

