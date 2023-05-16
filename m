Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B50704706
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 May 2023 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjEPHxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 May 2023 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjEPHxJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 May 2023 03:53:09 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488814C24
        for <linux-btrfs@vger.kernel.org>; Tue, 16 May 2023 00:52:45 -0700 (PDT)
Received: from [IPV6:2001:a61:6143:6401:c632:360a:f748:3552] (unknown [IPv6:2001:a61:6143:6401:c632:360a:f748:3552])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sbabic@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4B0B581FA8;
        Tue, 16 May 2023 09:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684223563;
        bh=i6+oPt3l1B1CIvZooB+HXLGJ8pFuMVsbnWacHJI82uU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GkpgyiSRPUQzEUzmvKnt1/NLJDCSaIKC36y8fGfOUkiNbeu/+onuIbtqzviOLT7Dt
         H/uJc7K2rhiVgufKYbjO9lOc8r/0vv6s5m81R87R+qWtOfoWjdYNKUecGOJ7KQU7Mx
         3oAx0H7fXShTqzyP1+zVYW+2Ge0yJF/S4H83ZDl/O+IvczEZye4jaPFRYtfri5Qj02
         jQH8DgnvHb1CkWCOoAV/RpjYy3A2a50B6mWACB65qW137U5Y68Ppmvu6ivvKYuNxov
         ufW+78Bng8os6LBz2wSlXPZS1ojeOXpzpHgc1VkXiyahxbW3AUC7xw/HKdHMCebIYC
         nRo9RlpbgEbNQ==
Message-ID: <29fc7e94-6628-5af7-5e54-3985ce1474a7@denx.de>
Date:   Tue, 16 May 2023 09:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] Makefile: add library for mkfs.btrfs
Content-Language: de-DE
To:     Neal Gompa <ngompa13@gmail.com>, kreijack@inwind.it
Cc:     Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org
References: <20230514114930.285147-1-sbabic@denx.de>
 <69df9067-3986-b818-bba2-868946a039e7@libero.it>
 <CAEg-Je8of_psB==V+PH0rpDi6FCpvuKHFBz18qprx4m-y0yZ4w@mail.gmail.com>
From:   Stefano Babic <sbabic@denx.de>
In-Reply-To: <CAEg-Je8of_psB==V+PH0rpDi6FCpvuKHFBz18qprx4m-y0yZ4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.05.23 21:53, Neal Gompa wrote:
> On Mon, May 15, 2023 at 2:05 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> On 14/05/2023 13.49, Stefano Babic wrote:
>>> Even if mkfs.btrfs can be executed from a shell, there are conditions
>>> (see the reasons for the creation of libbtrfsutil) to call a function
>>> inside own applicatiuon code (security, better control, etc.).
>>>
>>> Create a libmkfsbtrfs library with min_mkfs as entry point and the same
>>
>> Really a minor thing; instead of libmkfsbtrfs, I think that it is better call it
>> libbtrfsmkfs or something like it; so all the btrfs libs are with the same prefix:
>>
>> - libbtrfs
>> - libbtrfsutils
>> - libbtrfsmkfs
>>
> 
> I think the idea is that we're *not* going to do that and instead look
> to expose filesystem creation features in libbtrfsutil.

Yes, my patch was just to expose the problem, asking which is the best 
way to do.

Stefano

> 
> 

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

