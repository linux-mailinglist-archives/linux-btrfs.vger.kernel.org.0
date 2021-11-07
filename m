Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52D44724F
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Nov 2021 10:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhKGJO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Nov 2021 04:14:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50160 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhKGJO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Nov 2021 04:14:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DE8D212C4;
        Sun,  7 Nov 2021 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636276305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ov5Q2dptB258GtOSsMBLlu0gIshz3sHRLgjz2pjzCgg=;
        b=Hjcz10I1kpNF5DAbmwi4XDQGSVdnbDvb3XNiOSvbeW9GU+CRGsOjYdOw+6DXb60hdfkeuG
        2aH4bXtHKMCVjhmYsM62dlnqZgUt/tvvavofZr91PcDf2W0F33dXxbSZj3JXLP1yZ+7U4U
        TAXg5vHCtaYxLfPTWn4Cq1GD6HMN4W0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D1441345F;
        Sun,  7 Nov 2021 09:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JlbjD1GYh2HlaAAAMHmgww
        (envelope-from <nborisov@suse.com>); Sun, 07 Nov 2021 09:11:45 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <l@damenly.su>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
 <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com>
 <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com>
 <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
 <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
 <CAJCQCtQ0_iAyC8Tc8OZyf2JGGnboXm8zk9itZaOLAoK=w1qdrg@mail.gmail.com>
 <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com>
 <CAJCQCtQT22cdBPZ+d03m8c_sCtdVaM_Oz705T37v2XPx26SWFg@mail.gmail.com>
 <420a1889-6a35-c7d2-b4f7-735a922fe469@suse.com>
 <CAJCQCtTwGvk4zCAQ16L5Pq5+Us4JprKw1LQse_3Nodt_nn3CXQ@mail.gmail.com>
 <a1087c57-06a8-65e9-a4e0-b9f81a58b2f5@suse.com>
 <CAJCQCtSVEortM-UT-=kfFuJsKX5xsSYKS+g-NAwwYXZjo=_iDw@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1156817e-45fc-78bd-a837-26db03deed5e@suse.com>
Date:   Sun, 7 Nov 2021 11:11:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSVEortM-UT-=kfFuJsKX5xsSYKS+g-NAwwYXZjo=_iDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.21 г. 18:12, Chris Murphy wrote:
> On Tue, Nov 2, 2021 at 10:25 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>>
>>
>> On 2.11.21 г. 16:23, Chris Murphy wrote:
>>> On Thu, Oct 28, 2021 at 1:36 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> <snip>
>>
>>>>>
>>>>> So far this appears to be working well - thanks!
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c54
>>>>
>>>> Great, but due to the nature of the bug I'd rather wait at least until
>>>> the beginning of next week before sending an official patch so that this
>>>> can be tested more. In your comment you state 3/3 kernel debug info
>>>> installs and 6/6 libreoffice installs, how do those numbers compare
>>>> without the fix?
>>>
>>> More than 1/2 of the time there'd be an indefinite hang. Perhaps 1/3
>>> of those would result in a call trace.
>>
>> As you might have seen I did send a proper patch, if you've continued
>> testing it over the weekend and still haven't encountered an issue you
>> can reply with a Tested-by to the patch .
> 
> Did that.
> 
> Also, I just noticed the downstream bug comment that another tester
> has run the original patch for several days and can't reproduce the
> problem.
> 
> But the side note is that without the patch, they were experiencing
> file system corruption, i.e. it would not mount following the crash.
> Let me know if it's worth asking the tester for mount time failure
> kernel messages; or a btrfs check of the corrupted system. I guess

Sure, let's see if there's anything else stemming from this.

> this race is expected to never manifest on x86?

Yes, x86 is strongly ordered so it won't need the barriers hence the
issue doesn't exist there.

> https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c55
> 
> 
> 
