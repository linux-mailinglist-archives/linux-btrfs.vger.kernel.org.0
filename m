Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACF743DACB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 07:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhJ1FjA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 01:39:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42260 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhJ1Fi7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 01:38:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D49321965;
        Thu, 28 Oct 2021 05:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635399392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFvkeVJF8zJkAPbqaRlXUR14BMdykkpODDOM2etgnQ0=;
        b=WunUPghBKO3IuNhP+QYNE3TXSLRkccAavDs46TWPiLySHuwv1dmfPFFkHCCzTf5WZJZzIr
        b30e+8NPLWI58XsKB4BUCzjwe7942dtsPALXEuzzS6eOhEsSrv2bs9Ewqavf19zdi6xkyQ
        cM1F9v8XEmuwTcIR+gmpCmiJLiDAgcA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CA2313EC9;
        Thu, 28 Oct 2021 05:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MGiDBOA2emH2cQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 28 Oct 2021 05:36:32 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <l@damenly.su>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
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
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <420a1889-6a35-c7d2-b4f7-735a922fe469@suse.com>
Date:   Thu, 28 Oct 2021 08:36:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQT22cdBPZ+d03m8c_sCtdVaM_Oz705T37v2XPx26SWFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.10.21 г. 21:22, Chris Murphy wrote:
> On Tue, Oct 26, 2021 at 3:14 AM Nikolay Borisov <nborisov@suse.com> wrote:
> 
>> I think I identified a race that could cause the crash, can you apply the
>> following diff and re-run the tests and leave them for a couple of days.
>> Preferably apply it on 5.4.10 so that there is the highest chance to reproduce:
>>
>> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
>> index 309516e6a968..a3d788dcbd34 100644
>> --- a/fs/btrfs/async-thread.c
>> +++ b/fs/btrfs/async-thread.c
>> @@ -234,6 +234,11 @@ static void run_ordered_work(struct __btrfs_workqueue *wq,
>>                                   ordered_list);
>>                 if (!test_bit(WORK_DONE_BIT, &work->flags))
>>                         break;
>> +               /*
>> +                * Orders all subsequent loads after WORK_DONE_BIT, paired with
>> +                * the smp_mb__before_atomic in btrfs_work_helper
>> +                */
>> +               smp_rmb();
>>
>>                 /*
>>                  * we are going to call the ordered done function, but
>> @@ -317,6 +322,12 @@ static void btrfs_work_helper(struct work_struct *normal_work)
>>         thresh_exec_hook(wq);
>>         work->func(work);
>>         if (need_order) {
>> +               /*
>> +                * Ensures all вритес done in ->func are ordered before
>> +                * setting the WORK_DONE_BIT making them visible to ordered
>> +                * func
>> +                */
>> +               smp_mb__before_atomic();
>>                 set_bit(WORK_DONE_BIT, &work->flags);
>>                 run_ordered_work(wq, work);
>>         } else {
>>
> 
> So far this appears to be working well - thanks!
> https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c54

Great, but due to the nature of the bug I'd rather wait at least until
the beginning of next week before sending an official patch so that this
can be tested more. In your comment you state 3/3 kernel debug info
installs and 6/6 libreoffice installs, how do those numbers compare
without the fix?

> 
> 
> --
> Chris Murphy
> 
