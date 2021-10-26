Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C243B9AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 20:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhJZSh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 14:37:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJZSh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 14:37:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07E5C218B5;
        Tue, 26 Oct 2021 18:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635273301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCzRCi7wq/BDIbf6EPvF1xocGnHS2gUFK27fxzbzX1U=;
        b=GLFQ0mo9XiKqoRmXWG77EyyPaLQYKTqK3TfhcK0TdoeMUyMEqIAVqADft/YjzmfyoWLVky
        EtCzqOyKAKfcb1Lea0MJfp8UorcDNMsE1pUhXe26yMURpIoHDp0kk4jnkIF856eZJ/EiNP
        jsL8ZhrPWgAeGtM8gjB80I8TUeypQA4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0D5D13F99;
        Tue, 26 Oct 2021 18:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ohR+KFRKeGG2ewAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 26 Oct 2021 18:35:00 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <l@damenly.su>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com>
 <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com>
 <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
 <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
 <CAJCQCtQ0_iAyC8Tc8OZyf2JGGnboXm8zk9itZaOLAoK=w1qdrg@mail.gmail.com>
 <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com>
 <CAJCQCtSrSHrNKV-HKRS0vy0T0ZrL5GR_BqpbG4iMNZZ66PJN5g@mail.gmail.com>
 <435c0ba3-dab9-3d01-7d43-0d370ffa36aa@suse.com>
 <CAJCQCtT02w+62mpRCxYNH07YatToQYFyaxuU=+8G_B5+QNgK8w@mail.gmail.com>
 <fa16bbdf-be5b-6970-8b28-9cb217d4b722@suse.com>
 <CAJCQCtRkGL1hWgpcPntz=vejOyaiawKL4=ofY2=wna=q=EgQtg@mail.gmail.com>
 <CAJCQCtQaj-SJPpnZyXGUKq7Z-qnMLYbVt2JirXVv7KVhW3LO4g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <0478fe2a-eaef-db2e-2a20-4ea1dd91f67f@suse.com>
Date:   Tue, 26 Oct 2021 21:35:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQaj-SJPpnZyXGUKq7Z-qnMLYbVt2JirXVv7KVhW3LO4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.10.21 г. 21:31, Chris Murphy wrote:
> On Tue, Oct 26, 2021 at 2:26 PM Chris Murphy <lists@colorremedies.com> wrote:
>>
>> On Tue, Oct 26, 2021 at 2:14 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>>
>>>
>>>
>>> On 26.10.21 г. 21:08, Chris Murphy wrote:
>>>> I don't know whether the hang and crash are related at all. I've been
>>>> unable to get a sysrq+t that shows anything when "dnf install
>>>> libreoffice" hangs, which I suspect could be dbus related where a
>>>> bunch of services get clobbered and restarted during the metric ton of
>>>> dependencies that libreoffice brings into a cloud base image. But
>>>
>>>
>>> Since this is a qemy virtual machine it's possible to acquire a direct
>>> memory dump from qemu's management console. There's a dump-guest-memory
>>> via qemu's management console alternatively via virsh one can do the
>>> procedure described here:
>>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-domain_commands-creating_a_dump_file_of_a_domains_core
>>>
>>>
>>> if you can provide a memory dump + kernel vmlinux then I will be happy
>>> to look into this. In the meantime the barriers fixes should remedy crash.
>>
>> OK thanks. I'll start testing a kernel built with this patch, and then
>> move on to capturing a memory dump of the VM if we're still seeing
>> hangs.
> 
> With or without the --memory-only option?


Yes (though I have never used the virsh method, but straight the hmp one).
> 
> 
