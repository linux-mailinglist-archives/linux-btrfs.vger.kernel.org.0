Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC41E571B44
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiGLNa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiGLNaU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 09:30:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E190AE54D
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 06:30:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43F2120025;
        Tue, 12 Jul 2022 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657632617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0KAUuq5xtlthgaH12tbWOcdHjfDWdIQC2MnJUEKWMs=;
        b=LYVBC5tb6v/vXn9IpH5zAgUgyM/WtglOj9XofSCR0sBOcht+gtI2Zkl1N6db5f8qmit/Ca
        sHLD5Gb/oONQ8VP0Qzfl77wTe/eWQTc6Pz7XOi0IY/Mh1rhMDU46q7idx0wPamDI4JJMZ5
        XDK8V2Kz6arNVfQntWXE7YbfBhTgvJE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1175813A94;
        Tue, 12 Jul 2022 13:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1gWvAWl3zWImRQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Jul 2022 13:30:17 +0000
Message-ID: <44836a39-9e27-6418-02f5-8e120f2ad642@suse.com>
Date:   Tue, 12 Jul 2022 16:30:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: BIG_METADATA - dont understand fix or implications
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Peter Allebone <allebone@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
 <2ba98b68-f22b-5013-8c4b-47b5c62ed437@suse.com>
 <fbd58f24-02ba-3c84-0c05-4de5f44d779c@gmx.com>
 <097bd15e-9afb-7170-06d3-2fc365092ff1@suse.com>
 <eec791a1-f7f4-b897-3f76-b08418c148a4@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <eec791a1-f7f4-b897-3f76-b08418c148a4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.07.22 г. 16:22 ч., Qu Wenruo wrote:
> 
> 
> On 2022/7/12 21:18, Nikolay Borisov wrote:
>>
>>
>> On 12.07.22 г. 16:13 ч., Qu Wenruo wrote:
>>>
>>>
>>> On 2022/7/12 21:05, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 12.07.22 г. 15:24 ч., Peter Allebone wrote:
>>>>> Hi there,
>>>>>
>>>>> Apologies in advance, I dont understand how I am affected by this
>>>>> issue here:
>>>>>
>>>>> https://lore.kernel.org/linux-btrfs/20220623142641.GQ20633@twin.jikos.cz/ 
>>>>>
>>>>>
>>>>>
>>>>> I have a problem where if I run "sudo btrfs inspect-internal
>>>>> dump-super /dev/sdbx" on some disks it  shows the BIG_METADATA flag
>>>>> and some disks it does not. I posted about it here on reddit:
>>>>>
>>>>> https://www.reddit.com/r/btrfs/comments/vo8run/why_does_the_inspectinternal_command_not_show_big/ 
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> My concern is what effect does this have and how do I fix it, once the
>>>>> patch makes its way down to me. Is there any concern with data on that
>>>>> disk changing in an unexpected way?
>>>>>
>>>>> Many thanks for any insight you can shed. I did read the thread but
>>>>> was not able to easily follow or understand what was implied or what
>>>>> would happen to someone affected by the issue.
>>>>>
>>>>> Thank you again in advance. Sorry for emailing in. Hope that is ok. I
>>>>> was just concerned.
>>>>
>>>> If you are using recent kernels i.e stable ones then there are no
>>>> practical implications, because as soon as you mount the filesystem 
>>>> with
>>>> a kernel which has the patch this flag would be correctly set. As said
>>>> in the changelog of the patch this can be a potential problem for
>>>> pre-3.10 kernels (very old) so the conclusion is you have nothing too
>>>> worry about.
>>>
>>> I just went checking v3.9 and v3.5, if there is no such flag, kernel
>>> will still mount the fs and setting the flag.
>>>
>>> So it doesn't seem to cause any compatibility problems at all.
>>
>> But that's the point, fs created post 3.10 should not be mountable by
>> pre 3.10 because they'd see an unknown flag.
> 
> Oh, got it now.
> 
> Although the introduction of that flag is a little older, in v3.4. (v3.3
> doesn't have it).

Yes you are right, commit 727011e07cbd ("Btrfs: allow metadata blocks 
larger than the page size") landed in 3.4 not 3.10, so the changelog of 
the patch needs to be changed.


> 
> Thanks,
> Qu
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>>
>>>>> Kind regards
>>>>> Peter
