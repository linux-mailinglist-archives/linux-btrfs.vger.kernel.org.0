Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988A43B4CF2
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 08:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFZGQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFZGQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 02:16:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F8C061574;
        Fri, 25 Jun 2021 23:14:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x20so8965330ljc.5;
        Fri, 25 Jun 2021 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=swrb0R0KYvrRixLiGr9Pp1BV3nCvg4OOcehd6uuLTQE=;
        b=iwXlHgYitQz/bDt3HhNdWrwZzg6C7vMVEulGzAN9uKp6jch8ngYyCxsGoio83AoUpv
         BEb5ppw6PZQ1vlOvlPTgf2nSS+yhm4f0t+Ntd8+BFu/vE/yLPHU6Lofk6phUfkpG/tOu
         VnOcoSX7ESTergt8nffNbeqP6GQE4HekrIPzkoptt0rjtbCkBEd6c8ViDOMyQd5hDou2
         kxkEyfx6wlRIsO+2Anr1lS/nxnFDOluA/k69TmzV4LLWmm8DbLbabb53Z1u8iDvuijlM
         64QLST6TyPKEWfjyp8rUmD2jpTqiIwsOzxPvJw3XspJ3+lLyHSxGmwLpnh8b6GKrlGjm
         gjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=swrb0R0KYvrRixLiGr9Pp1BV3nCvg4OOcehd6uuLTQE=;
        b=R4J8lo59i9puQwBobr4Hr3s8prNYkz21v3Ey99lXy7aPY2UeKOW/FoV4H2gsgqVEL9
         /geYPEZ09vJgKCbzhQGy3tHJZvdK4QEoMwBMylt1QCv11W7lXsXefaLNpm0Ljda8mB9/
         dLCLGUoPG88koAndwOWtiRa/kgE8q4mLrh9NhBk6xz2kKyk/5ZxVhBLa9DBk/AJ9mTLc
         NF5/4xmvU5cNv2YZtz+1TzSPB74YqjHO66bTrjdFkkRSPIgpRY3aeGZEYJJj5Xqu2wIY
         kj2ERff3tLZffvcI4lDNYnzz5wdsrMd9F23+qNUJirA/lE1iHQO7wb2DLucg0e9go5IR
         lXFw==
X-Gm-Message-State: AOAM530Pn/fxe4nTSb1V8YeFv1gShwNOsbBE2Kk/ZA0NOdT6Ob4xE/8S
        IIUJA0ptmyL2YeUJawZndW0JCFAI30q9CQ==
X-Google-Smtp-Source: ABdhPJxSn9n/dKyLvpf0+N7tpHRAN/74R49xhR9EqOXmjZPomc9pZIKjr0JMPuZHXzqth8ncP5+W8g==
X-Received: by 2002:a2e:95c9:: with SMTP id y9mr10931494ljh.401.1624688051306;
        Fri, 25 Jun 2021 23:14:11 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:b06a:db33:1924:b4f8:1d53? ([2a00:1370:812d:b06a:db33:1924:b4f8:1d53])
        by smtp.gmail.com with ESMTPSA id z13sm686470lfb.40.2021.06.25.23.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 23:14:10 -0700 (PDT)
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search
 Baloo
To:     NeilBrown <neilb@suse.de>, Bart Van Assche <bvanassche@acm.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <41661070.mPYKQbcTYQ@ananda>
 <162466884942.28671.6997551060359774034@noble.neil.brown.name>
 <ec60fd7f-7020-5168-81f1-809da73763f3@acm.org>
 <162468466604.26869.10474422208964999454@noble.neil.brown.name>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <7d12d49d-1dbf-566e-cb92-84e68ab67e23@gmail.com>
Date:   Sat, 26 Jun 2021 09:14:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162468466604.26869.10474422208964999454@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26.06.2021 08:17, NeilBrown wrote:
> On Sat, 26 Jun 2021, Bart Van Assche wrote:
>> On 6/25/21 5:54 PM, NeilBrown wrote:
>>> On Sat, 26 Jun 2021, Martin Steigerwald wrote:
>>>>                                  And that Baloo needs an "invariant" for 
>>>> a file. See comment #11 of that bug report:
>>>
>>> That is really hard to provide in general.  Possibly the best approach
>>> is to use the statfs() systemcall to get the "f_fsid" field.  This is
>>> 64bits.  It is not supported uniformly well by all filesystems, but I
>>> think it is at least not worse than using the device number.  For a lot
>>> of older filesystems it is just an encoding of the device number.
>>>
>>> For btrfs, xfs, ext4 it is much much better.
>>
>> How about combining the UUID of the partition with the file path? An
>> example from one of the VMs on my workstation:
> 
> A btrfs filesystem can span multiple partitions, and those partitions
> can be added and removed dynamically.  So you could migrated from one to
> another.
> 

I suspect it was intended to be "filesytemm UUID". At least that is the
field in lsblk output that was referenced.

> f_fsid really is best for any modern filesystem.
> 
> NeilBrown
> 

