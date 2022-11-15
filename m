Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B862A0BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 18:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiKORwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 12:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiKORws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 12:52:48 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA612F64A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 09:52:45 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a15so18522338ljb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 09:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BroElPEgqhIeL32eN/AuknLrGvHqFIUY4GXecg3wRmA=;
        b=BI3/FHAsNt9UzmjJZ+rpXC3p2jChWVV/D6lZb7rw98Rkcj3jzFvrNZ8r3Vd6TxwFJC
         hsuxQi/D+XcPX2REgBgOe/3fHlW96PPCDF3sz4DzS511OztZGUQbiCcmWY+O8k+Eyxwu
         Lj2RxmMxGzjhd3KeEx3y9tKiUDQyJuMFQYoCPPoQizsnuJ0hNXHKqk6bjf8ZfGHrvhau
         Z2DACqFdI3qPqW7NBd1a8/Othq4qz2bQ8RWpc8r2KvdIBfzxNWHkikOum8BzPAnpS0jm
         mok19BkOpSPmFWdAqsWtiyeX8Ihtnm40d7Xtm/TMw65tmo4aR4Y2b6iwHc1IRV8QnrCR
         oDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BroElPEgqhIeL32eN/AuknLrGvHqFIUY4GXecg3wRmA=;
        b=AcBnVGRnMp/RmbMsjy9GPxF06efSQ91XYzOyAqNZKti9AVszlOZ2pwyxt/RHclWBG5
         lHeOWxqq8zFAzTjdUfxn0JU2HHzL2CY3jLnD7yLDayr8uqaLP8QRRiMIhK1dEgGMsRjG
         SxVGiX5YUX0Z6qSayWqX5xDey1wW8JY8ogJKc3KThqs3uJaNWcTpJtHwhNlwYeOyiA6f
         vbVH1QjZC7oLFS5quq5R9LXNsuRMoclCWmvDV6i6T5Eat+aLuFBOZc+nPATh6AY4+oLD
         uGxz0H4mw9KBWNPjBYuUL/Gbj7Mm1pknjRcFAPimdU7O+4WvVxAu2NOW3VeA5Oj4OnIm
         xWaQ==
X-Gm-Message-State: ANoB5pmJKeJne3nDd6VEjsyXeCCe4SV5rs7DZ7YCSJPhdNEJGBGf1B4a
        uh86mUIjqTsvP33x5bpZkgN/pNJEqTc=
X-Google-Smtp-Source: AA0mqf7WX70N7g9UP1nMGxUjW2udVmrD+YMOLR6UrUC2+phsqjR2k6HWslNo/uFInwif6oFMB7jDvA==
X-Received: by 2002:a05:651c:194d:b0:276:b154:9bd8 with SMTP id bs13-20020a05651c194d00b00276b1549bd8mr6364828ljb.76.1668534652242;
        Tue, 15 Nov 2022 09:50:52 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:683d:8b26:3d02:5d84:b09a? ([2a00:1370:8182:683d:8b26:3d02:5d84:b09a])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b00497a879e552sm2270017lfz.291.2022.11.15.09.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:50:51 -0800 (PST)
Message-ID: <6e932071-ef89-0d69-550f-755abea004ba@gmail.com>
Date:   Tue, 15 Nov 2022 20:50:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: property designating root subvolumes
To:     Eric Levy <contact@ericlevy.name>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
Content-Language: en-US
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.11.2022 02:23, Eric Levy wrote:
> The file system allows one subvolume per partition to be designated as
> the default, and no more than one would be sensible. Generally, for

It is not partition, it is filesystem.

> partitions organized with a base file hierarchy constituted of multiple
> subvolumes, the one representing the root mount would be designated as
> the default. Although this association is not required, it is a
> reasonable assumption, enough so that some tools depend on it for
> certain features. For example, the rEFInd bootloader scans a BTRFS file
> system for a Linux-based OS by attempting to identify a root file
> hierarchy on the default subvolume. However, in such usage, the
> constraint of one subvolume designated per partition is limiting. In

So far the only usage proposed by you is to scan btrfs subvolumes to 
apparently present user multiple choices during boot. Any bootloader 
that understands btrfs enough to read subvolume properties can also read 
information inside subvolume to achieve the same effect. You need to 
prepare subvolume anyway.

If you suggest some other usage I am afraid I failed to understand it.

> principle, a bootloader might support multiple operating systems
> installed on the same partition, as long as each root partition may be
> separately indicated. To support such usage, it might be helpful if a
> property, separate from the designation of a default subvolume, was
> supported. As a property, it would be allowed to be assigned
> arbitrarily to any number of subvolumes.
> 
> Presently, rEFInd supports multiple operating systems on different
> subvolumes of the same partition only by static configuration. Such a
> constraint is particularly cumbersome because any operation for
> installing the bootloader utilizes configuration only on the active
> operating system.
> 
> In principle, the broader concept might be extended further, adding
> even more properties, for supporting yet further use cases. As one
> example, a subvolume might be selected as containing configuration
> information applicable to the bootloader, regardless of the active
> operating system. Such a feature would facilitate synchronization of
> bootloader settings for installation tools across all operating systems
> on a partition. Yet, even the single new property would support cleaner
> semantics for greater flexibility of usage.
> 
> Note that for such a feature to work properly, the file system would
> need to enforce that the property not be inherited by child volumes,
> that is, snapshots derived from a subvolume with the property enabled.
> Furthermore, some thought must be given to the case of the user
> enabling the property for a subvolume having an ancestor with the
> property already enabled. In such a case, it most likely is desired
> that the property would be disabled for the ancestor.
> 
> 

