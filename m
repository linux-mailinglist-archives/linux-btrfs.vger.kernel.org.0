Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA0443057
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKBO1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 10:27:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46028 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKBO1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 10:27:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D18B1FD4C;
        Tue,  2 Nov 2021 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635863111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ONcNa0+xLuMBiV+mJ8CY0WweUqQDpvE1Y8PTxdkXgk=;
        b=rXY2QdPO4WJIBe8flYUckBuMUfCGjZNG3WUV56lIE4282YCrYz+4SPj6O7JlWrR01Zj7Gg
        b2PEsOHoV0/8RVY8bqTORUBTUyVbNT287JEXPbbk0DBynAtWE+v3Pm+t86Eff5tmAUnI8a
        Kt21ljGlrS5WdYwMYC6Cgn5c4eftvUo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2052713BF7;
        Tue,  2 Nov 2021 14:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bQ9cBUdKgWE2KwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 02 Nov 2021 14:25:11 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <l@damenly.su>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su>
 <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
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
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a1087c57-06a8-65e9-a4e0-b9f81a58b2f5@suse.com>
Date:   Tue, 2 Nov 2021 16:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTwGvk4zCAQ16L5Pq5+Us4JprKw1LQse_3Nodt_nn3CXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.11.21 г. 16:23, Chris Murphy wrote:
> On Thu, Oct 28, 2021 at 1:36 AM Nikolay Borisov <nborisov@suse.com> wrote:

<snip>

>>>
>>> So far this appears to be working well - thanks!
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c54
>>
>> Great, but due to the nature of the bug I'd rather wait at least until
>> the beginning of next week before sending an official patch so that this
>> can be tested more. In your comment you state 3/3 kernel debug info
>> installs and 6/6 libreoffice installs, how do those numbers compare
>> without the fix?
> 
> More than 1/2 of the time there'd be an indefinite hang. Perhaps 1/3
> of those would result in a call trace.

As you might have seen I did send a proper patch, if you've continued
testing it over the weekend and still haven't encountered an issue you
can reply with a Tested-by to the patch .

> 
> 
> 
> --
> Chris Murphy
> 
