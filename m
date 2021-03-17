Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2533F4F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhCQQET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhCQQEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 12:04:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8AC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 09:04:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d20so39381340qkc.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sZMaolW3N8vfGdPDR/goE9fP64bz5cqunISySiyX9As=;
        b=WatY0QHxgqYpHo9WdOl97S8GfmVvt1hYyS4ZJ8vrWCsoYj0j54gI5CP+E+Ve6dPonR
         2snwogFoeMLrZH2QJG1LH76/MNu5I8tmRKdIkDCPaJIUFXWwX8ORZUGZegMZuvVSwiFo
         QfMh1cH1tSoRBRHm6a9QKnvnKvw22P8tKWzDSEwf9eTg7yNHLFPsnFffyCzn6rAxBhZd
         8leuXKRmvrQ2u8usFbDPju0M4F1X3x3Fr+HehaZ5eEps1gkBF/XYkoRM+JiLCY9PIbtc
         EI7CZSozmjK1oD0NHtYOBn++v2DyoZpXl5rdu9qwkyHD7gsNgPFuvVu+x1n5hrEUxQvD
         by1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZMaolW3N8vfGdPDR/goE9fP64bz5cqunISySiyX9As=;
        b=OFDMG+pOAuJv0sQxgFiOD79U64jCfji0AMPzu8bCdmtExXa2LX03hu2riNSLSxmZQJ
         DO3oFlNyIUJH36+oAb/U9ixwIs3pFSG9a8c/w87445gSCNfSzpO1NZGuqZFFR/+Gq8zF
         jomNUnDZfCPSP/YriZn+fy7a3G/3Jz2AB1znBK4YxNwVvlq8qwRzr4F/D3MWTfnnKXKd
         srdP0IaO1j/s2dH1J63Gc3oqivRY1HA1rOUbk1H/pz/vcFYxkm8GdmRmcxyCDffDB27q
         5iExogu8SJQDo6bwRj7laNnuUDsWSfIfql1QNgTQXEUB1PxxQScFhdO5LwTJTFGpw7Ks
         l6qQ==
X-Gm-Message-State: AOAM530qf+z9vQopnNLUBHPjLtDwL2pqPpEK/NKXDPxf3pH/2HEuR//c
        vbXMOxfi/2MwJ9JFYGagLlWAmDn69pxSru/1
X-Google-Smtp-Source: ABdhPJwoCVQX8meiqyfLSzQzJTivd2J2/WCu+mnw2f3HAHN5u4p9NSF2dUbKWel04tvDJ9mPyicT/A==
X-Received: by 2002:a05:622a:1394:: with SMTP id o20mr4706419qtk.92.1615995009394;
        Wed, 17 Mar 2021 08:30:09 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e15sm16198071qtp.58.2021.03.17.08.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:30:08 -0700 (PDT)
Subject: Re: [PATCH 0/3] Handle bad dev_root properly with rescue=all
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1615479658.git.josef@toxicpanda.com>
 <20210317122731.GQ7604@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a83c78b9-2fd0-7592-f098-6ebcf495ddfa@toxicpanda.com>
Date:   Wed, 17 Mar 2021 11:30:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317122731.GQ7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/21 8:27 AM, David Sterba wrote:
> On Thu, Mar 11, 2021 at 11:23:13AM -0500, Josef Bacik wrote:
>> Hello,
>>
>> My recent debugging session with Neal's broken filesystem uncovered a glaring
>> hole in my rescue=all patches, they don't deal with a NULL dev_root properly.
>> In testing I only ever tested corrupting the extent tree or the csum tree, since
>> those are the most problematic.  The following 3 fixes allowed Neal to get
>> rescue=all working without panicing the machine, and I verified everything by
>> using btrfs-corrupt-block to corrupt a dev root of a file system.  Thanks,
> 
> When rescue= is set lots of things can't work, I was wondering if we
> should add messages once the "if (!dev_root)" cases are hit but I don't
> think we need it, it should be clear enough from the other rescue=
> related messages.
> 

Yeah I went back and forth on this, and I came to the same conclusion as you. 
If we're doing rescue=all we know things are bad, and we just want our data 
back.  Thanks,

Josef
