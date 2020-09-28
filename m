Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED58127B466
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1SXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1SXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:23:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE5CC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:23:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so1883678qke.12
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PGSRqY7WmaGPROLvxotsgfJ58npBfiOFTiAoqTdjB20=;
        b=CnLv37fAEcXs6Q3eQ8mUrb2DMS3ucL+BTEvlTBGeQmMazWR9udQweo6Js9fLJ2hQ9v
         3kNyV/8BGFT+lr7MYkyKUcZUQprgW4rGvrBeD9DrB9mtykp7+kaWoP+syVWra/JCHnRc
         YEJFBYMZztFK7RF3brQCZosXCheTmFI9oQCQc33uIqTFp6K8Dp6DZzNTQHeq6jeh3JpI
         MPLIIk9vRZCD2vgTMSlomumlQJeeQBMrtaW971XaDY4lLNfRR9wE05DOXFTlNavK2i8y
         +T5+o4IfxaOPFcbtExgm9ULK+SSJF/I866GJxwSGj+3+ARLeATfKjJ16Z43ec6oY/kBU
         EDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGSRqY7WmaGPROLvxotsgfJ58npBfiOFTiAoqTdjB20=;
        b=byvLx8Nw3YSgSc+FxrcPoaFgiLYROhL7Dtw9qU/sdNg5kzsTbZWAjnRRBKR/NEzfU1
         J4pioo6boZFMfMuz2FGeAAz9hIYSVwNu6ORd+i2q3abuee3ErGhLE9zUSlBq3kx+ksUm
         miyHk1TCqxxcSRqvi1HNBrYa6DKRZrxPctDU30CuHlt/bLJEzBYpgsOijIOqwCVSQjKh
         5B9IcuQZDkSTHyJ6xoqCe0rIiE3dj+fSjfgvkSkbW8igRTI5UqQLwSfBm3IJTbTTa2mE
         UrtbwZuqRcIDZa5qzEXgdYhU69wPfpufB++GFMjtqx+RtA6ke960myYdtkd7S3bnuSc/
         0QBQ==
X-Gm-Message-State: AOAM531L6P8rODLW7cYLJrNEaY7Olx/uFzbuskpXc4s+ocTn/CrlUTrJ
        iEmDbhFMzvG00iPLG6w2BuBfvldUroM40qKt
X-Google-Smtp-Source: ABdhPJw3Stfb+rgw7XDf7Sgl2Ss5uEC0it46UhPry+OWgTUl/mb21vF2+JwOZ1xSPbOCRHs0SFWTcA==
X-Received: by 2002:ae9:c015:: with SMTP id u21mr794163qkk.268.1601317397376;
        Mon, 28 Sep 2020 11:23:17 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p28sm2201226qta.88.2020.09.28.11.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 11:23:16 -0700 (PDT)
Subject: Re: [PATCH 1/5] btrfs: unify the ro checking for mount options
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <cover.1600961206.git.josef@toxicpanda.com>
 <d307f1d95415232dabfb700e79cda73618aa7d50.1600961206.git.josef@toxicpanda.com>
 <DM5PR0401MB3591BBA587DD3D36F47FAA549B350@DM5PR0401MB3591.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <be964e53-0adb-a829-8057-fe5c9115fe70@toxicpanda.com>
Date:   Mon, 28 Sep 2020 14:23:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <DM5PR0401MB3591BBA587DD3D36F47FAA549B350@DM5PR0401MB3591.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/28/20 8:37 AM, Johannes Thumshirn wrote:
> On 24/09/2020 17:33, Josef Bacik wrote:
>> We're going to be adding more options that require RDONLY, so add a
>> helper to do the check and error out if we don't have RDONLY set.
>>
>> +	/* We're read-only, don't have to check. */
>> +	if (new_flags & SB_RDONLY)
>> +		goto out;
>> +
> 
> Why aren't you moving the SB_RDONLY check into the new check_ro_option() as well?
> This is what I would have thought this patch does after just reading the commit message.
> 

To avoid the multiple calls if we're not read only, otherwise it'll be multiple 
function calls to check that that SB_RDONLY is set.  The compiler will probably 
optimize that away, but I just went with this instead.  I'm good either way if 
people have strong opinions one way or the other.  Thanks,

Josef
