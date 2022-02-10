Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7364B17F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbiBJWKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:10:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbiBJWKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:10:38 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82343E7B
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:10:38 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 4EEA69BC8E; Thu, 10 Feb 2022 22:10:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644531037;
        bh=kS+RYdB1/3NqdQFZ0araP/Sckt/G1/ebiyGT3H5suYo=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=qzco8kgMqSdVo7q5MNHFtTvvTRqjywH1P8QiBn2zQ4YhXbLGnfytLe+jtMBMul+Xk
         cD3eDO00yziL7I0iouwGq77cjOLFkB5iAa615exdMJBNa0VDwBgzV6tU+yqV+abeDd
         7K2obt6Q4j2ZcvNrXvSotUdXwpq7mQvxyoq4VJZfsFRFq4z4R4g1gu+0eqam+SoTfN
         eF/cxiTcWVCJn0TMmN/FcVCgQuRwWvmhjVXo85BS7eW3C847IsI1KBIjE4F6MuvHkS
         hHKbix3Wu9u+3zn+AlF5ra+pQ5fiah3gbh6Rsfp8fZCqtF3x9uZXdv/R1tihf6A9/Q
         I01pJ/Mj6Exkw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 53A0C9B7DE;
        Thu, 10 Feb 2022 22:09:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644530977;
        bh=kS+RYdB1/3NqdQFZ0araP/Sckt/G1/ebiyGT3H5suYo=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=x63Zbjx9QRDGq5xpZAxA29wYVqGda8rhzOzxNHE/sii+h/u0MC/pwxe/eMDI+aKzy
         PB2RMJ3hcw/Dxm+iEqK+e/qLjFl/1j4I/8A3asza+knJ07KQMX4hETW6NLuceOM1ai
         JvfPOmOx+niQCCHmyOutiKHa4objXxOEiUnFht80QW5bHeJfaqbK/U7TBbzrFiDfM8
         98s7XDhXpUD3WDi5mBJzAIYEsNpVa1aBTGzqkhLD9tO9vQO/2KKLw5hYBLEHWHGszX
         84SET1m5/hOXCDmEbKrIARSOJQ2erQPzuG0ky9Lf/uUpHaA/ENIrFIix1ibc6OX50u
         pYc0tfnVHnsnQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 1B92A11EFDF;
        Thu, 10 Feb 2022 22:09:37 +0000 (GMT)
Message-ID: <e0ffd0ce-d86e-1d30-dbdc-5b0f0b7cc131@cobb.uk.net>
Date:   Thu, 10 Feb 2022 22:09:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH] Fix read-only superblock in case of subvol RO remount
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, fvogt@suse.com
References: <20220210165142.7zfgotun5qdtx4rq@fiona>
 <2db10c6d-513a-3b73-c694-0ef112baa389@cobb.uk.net>
 <20220210213058.m7kukfryrk4cgsye@fiona>
 <938de929-d63f-2f04-ec0a-9005ba013a2f@cobb.uk.net>
In-Reply-To: <938de929-d63f-2f04-ec0a-9005ba013a2f@cobb.uk.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2022 22:03, Graham Cobb wrote:
> On 10/02/2022 21:30, Goldwyn Rodrigues wrote:
>> On 19:54 10/02, Graham Cobb wrote:
>>> On 10/02/2022 16:51, Goldwyn Rodrigues wrote:
>>>> If a read-write root mount is remounted as read-only, the subvolume
>>>> is also set to read-only.
>>>
>>> Errrr... Isn't that exactly what I want?
>>>
>>> If I have a btrfs filesystem with hundreds of subvols, some of which may
>>> be mounted into various places in my filesystem, I would expect that if
>>> I remount the main mountpoint as RO, that all the subvols become RO as
>>> well. I actually don't mind if the behaviour went further and remounting
>>> ANY of the mount points as RO would make them all RO.
>>>
>>> My mental model is that mounting a subvol somewhere is rather like a
>>> bind mount. And a bind mount goes RO if the underlying fs goes RO -
>>> doesn't it?
>>>
>>
>> If we want bind mount, we would use bind mount. subvolume mounts and bind
>> mounts are different and should be treated as different features.
> 
> Yes that's a good point. However, I am still not convinced that this is
> a change in behaviour that is obvious enough to justify the risk of
> disruption to existing systems, admin scripts or system managers.
> 
>>
>>> Or am I just confused about what this patch is discussing?
>>
>> Root can also be considered as a unique subvolume with a unique
>> subvolume id and a unique name=/
> 
> But with an important special property that is different from all other
> subvolumes: all other subvolumes are reachable from it.

I should be a bit clearer. Imagine you create a filesystem and then
create two subvolumes within it: a and a/b. You are suggesting that the
result of remounting the top level of the filesystem as RO causes
different effect on whether subvolume b goes RO depending on whether
subvolume a has also been mounted somewhere?

