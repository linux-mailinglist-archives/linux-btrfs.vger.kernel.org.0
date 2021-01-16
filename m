Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE82F8A90
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 02:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbhAPBsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 20:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPBsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 20:48:32 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47CC061757
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 17:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Uhk8dZUDQqVQpyjo3Q28N41GSZDIGSc1q0c8khsQLcg=; b=uCwjaEAKMqY5Ga6sOzYWuHWSqD
        qzt3jER7c4tYGhlAfhF36VY+lcuDm6OVqiPLH1ufzybvquLeopEhfHFbG1/hrNm/TXxDEmDYNQHmO
        xJOyQnrZtcc4biUpCpLHee+ByteX84KgzwrOZ/Q9B8c1KmIDD9Br0ehmaGYVJc8l83UDYt/IC4JOU
        PWb+jDMYMsIKjgkPF8y38N7vm59Ke+cWLOdKASV25qM6hxELgH6TjVlFKa1l5JAXzKdCbf67IN6xZ
        /orxhwAsZML54H2OKsEe6D2MLO/nsHvwau5l2PrSHm6risacmOC1Bl4I4b7Pg1ZM1ZrM4O2o2Y2lU
        xKAuyZqA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:5078 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1l0agb-0001VV-5u; Sat, 16 Jan 2021 02:47:29 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Why do we need these mount options?
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
 <e9257bae-b744-42a7-1fc3-39b3ea676898@dirtcellar.net>
 <20210115152954.GH6430@twin.jikos.cz>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <703ce4f0-304b-b877-0902-cb454361dbed@dirtcellar.net>
Date:   Sat, 16 Jan 2021 02:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20210115152954.GH6430@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



David Sterba wrote:
> On Fri, Jan 15, 2021 at 01:02:12AM +0100, waxhead wrote:
>>> I don't think the per-subvolume storage options were ever tracked on
>>> wiki, the closest match is per-subvolume mount options that's still
>>> there
>>>
>>> https://btrfs.wiki.kernel.org/index.php/Project_ideas#Per-subvolume_mount_options
>>>
>> Well how about this from our friends archive.org ?
>> http://web.archive.org/web/20200117205248/https://btrfs.wiki.kernel.org/index.php/Main_Page
>>
>> Here it clearly states that object level mirroring and striping is
>> planned. Maybe I misinterpret this , but I understand this as (amongst
>> other things) configurable storage profiles per subvolume.
> 
> I see. The list on the main page is supposed to list features that we could
> promise to be implemented "soon". For all the ideas there's the specific
> project page wher it does not matter too much when it will implemented, it's
> kind of a pool.
> 
> In the wiki edit that removed the object-level storage I also removed
> (https://btrfs.wiki.kernel.org/index.php?title=Main_Page&diff=prev&oldid=33190)
> 
> * Online filesystem check
> * Object-level mirroring and striping
> * In-band deduplication (happens during writes)
> * Hot data tracking and moving to faster devices (or provided on the generic VFS layer)
> 
> For each of the task there's nobody working on that, to my knowledge,
> though there was some interest and maybe RFC patches in the past.
> 
> The object-level storage idea/task can be added to the Project_ideas
> page, so it's not lost.
> 
Okeydok... good to know! :)
