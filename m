Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE54755228F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiFTRDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFTRDD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 13:03:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB6339
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 10:03:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a13so8374193lfr.10
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jdC+LhX2FhO4c/wbTC3LFRoilNoTS+1PjGYbgIyPPdc=;
        b=ASS+k+BF7wf4ci30umMQqxJkku67y5wrtA0h9T3HumQIrm6OriMX+3CtP66jVg5p5B
         jZpXc7GCMgxDImQ4QX7WAhQwWx4nSeK+uWnI9MUo3QD6s1bxL5zbIV1mmFpVYubonXka
         t4GkuQbbSijMUThYwk0YbnHOjq0PMqKLKeo8zMuRBnjbxDgCburbNeSeqN/Edo0ebEBh
         WY0MV+7taGe26veCl7+H3plN+5b11SzqS1ViOXC0aothBlhaKadUt87KyvuwjnYRsCmT
         lwwcWhsm1NLOBEUcMyQsAsmkLAvz5o+JOnI5WIHBsrgyVMH507WiseTPNE6mMpi7n/KZ
         hTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jdC+LhX2FhO4c/wbTC3LFRoilNoTS+1PjGYbgIyPPdc=;
        b=GtewIIRzh9HBaEK/ndRa4PU4aGv2/GLtzsnq3hOqb4jPrBRzgsF6k4sywdA2raDgvi
         UNrs9fzDaIJqiX1d0Z/O3IMEbaT4Rhz0c8LXNX3yHDUnpjrlOxkiF9y30hAjdN3uqvHr
         yvDPsmyVucXRHW/75x5wxV/1+3O56AbEMYHNxsLkOS464xWlzgih8o0DQFvtyim50yaO
         pDur/lU7jJ6O6Xm+5qQo2JBQRjIntjFf9Lu0rqvtID2Zokr+urnD8EUhsghreY/4BQjP
         s4tLdhfzx49TBPYKGGsK23nuVbStCFMzVDUeXZYkR3ta/NMrd4Mzz/7WIEnUTvfgxph+
         Ql1A==
X-Gm-Message-State: AJIora9GyXaiamDG5A6lx0f/adw9WFPZ4s/bN9i7WaAKaHGnWf+Hvu3O
        5Oh/npYj3RUCuG5wDhpFoVDIYCjSxHStK8zu
X-Google-Smtp-Source: AGRyM1sdyRWiZ9Gn5RorHGBXQSt6MaOrz5iGTPLZPzQSuB8SUC93KSgf6ERfKozHnaJmgnjjEG07Mg==
X-Received: by 2002:a05:6512:258a:b0:47d:bb62:910f with SMTP id bf10-20020a056512258a00b0047dbb62910fmr13736296lfb.447.1655744580708;
        Mon, 20 Jun 2022 10:03:00 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:2007:7781:ccea:c492:8405? ([2a00:1370:8182:2007:7781:ccea:c492:8405])
        by smtp.gmail.com with ESMTPSA id f12-20020a19dc4c000000b004786332a849sm1830030lfj.41.2022.06.20.10.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 10:03:00 -0700 (PDT)
Message-ID: <bef3cb0a-6128-8d4e-80e4-dc49770f4bf7@gmail.com>
Date:   Mon, 20 Jun 2022 20:02:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Suggestions for building new 44TB Raid5 array
Content-Language: en-US
To:     Marc MERLIN <marc@merlins.org>, Ghislain Adnet <gadnet@aqueos.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220611045120.GN22722@merlins.org>
 <5e1733e6-471e-e7cb-9588-3280e659bfc2@aqueos.com>
 <20220620150132.GM1664812@merlins.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20220620150132.GM1664812@merlins.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20.06.2022 18:01, Marc MERLIN wrote:
>>  I have a stupid question to ask : Why use btrfs here ? Is not mdamd+xfs good enough ?
>  
> I use btrfs for historical snapshots and btrfs send/receive remote
> backups.
> 
>>  If you want snapshot why not use ZFS then ? i try to use btrfs myself and meet a lot of issues with it that i did not had with mdadm+ext4. Perhaps btrfs is not suited to that use (here raid5) ?
> 
> ZFS is not GPL compatible and out of tree.
> 
>>  ZFS has crypt, raid5 like array and snapshot and LARC cache allready so no need to add 4 layer on it. It seems a solution for you.
> 
> It has a few of its own issues, but yes, if it were actually GPL
> compatible and in the linux kernel source tree, I'd consider it.
> 
> It's also owned by a company (Oracle)

ZFS on Linux is not owned by Oracle to my best knowledge.

https://openzfs.github.io/openzfs-docs/License.html

 that has tried to sue others for
> billions of dollars over software patents, or even an algorithm, i.e.
> not a company I'm willing to trust by any means.
> 
> Marc

