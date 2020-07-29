Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046CB2321C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 17:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG2Pno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgG2Pnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 11:43:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B146C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:43:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j187so22578564qke.11
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mw2IQljI47xPAi+mmN99UY+4Pbjp829/rRJhkdKk9tg=;
        b=NZF/nRXxShDKCUPzk9NfNgJEAV4GoZBitup7gy5JqsrHGDgPzIEyHVQBo8JB6mtbDR
         ZneaCqH3eY7o7/tlZ5tYD/6T+pBvmGTSCpPLpU8c3l4/pWRW4ElYYRCLbilNux+fKSda
         rNs93qjSoxY52x3vu2orR64FKnqPTILnHyg5GfUWcDXtVc03elNCKV2xLBapY5rDlMfG
         yBBFviCeLul7odQ7jVndb1t+9FlJ4zMT792/Vz3IxCRy7mKzSxZtkhZX27XnWjsFBwi4
         u6n5NyfmdaJRXSEo66BJQLJaXN23N7HIDtGYV7XFYx0G0tGcK6nzvyvG1syK4T/30QP3
         nDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mw2IQljI47xPAi+mmN99UY+4Pbjp829/rRJhkdKk9tg=;
        b=lYWrRmTXFVgXkx+Az57mTr6v6rrVOiT22KtUyCxFe23LZerAvL56+gdaNlEy0yDdjT
         /Mx5VbvlKFLkBCT1o3CCPt/BSLY2ZEYYMG5PgcboA3kT/xnQ+Y2y/xB8qsX9IDFy25/E
         FV1uxsTsjc9gr66fAu+K/VKQ7qlXVW/WrfeN21AnT62FettOwzXxtJ5wRS78Ec8EZkql
         o3wMjHQkj5S4xp7i7Ysv76tPjUfjdkcc7CFl+z1xCKr3rhoQoSKQySPCvKeKf7qdxosb
         2/bCSFYaTtnY9OpubdFipHR/bYhxROAaXnOekcrOwpbQS03eS4gxcMVBiuE8aeJYtz4J
         s22w==
X-Gm-Message-State: AOAM530QBIM1ES8JjW2Pwx0CkH6ZwSPThIPw2oLqOHjf8j6UYqUm2sog
        1NGHTTCSJ2ZtB47C4h4Vsd+PIg==
X-Google-Smtp-Source: ABdhPJxFHd9YOkurXyyMNOn6EMBxGLwjOWV5LAGtiC2YzGXsRF1X0ClYj2YJUGR1TspdjyzAje+gcg==
X-Received: by 2002:a05:620a:22f4:: with SMTP id p20mr34654772qki.349.1596037422630;
        Wed, 29 Jul 2020 08:43:42 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10a7? ([2620:10d:c091:480::1:5750])
        by smtp.gmail.com with ESMTPSA id x5sm1925527qtp.76.2020.07.29.08.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 08:43:41 -0700 (PDT)
Subject: Re: [PATCH][v3] btrfs: only search for left_info if there is no
 right_info
To:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200727142805.4896-1-josef@toxicpanda.com>
 <20200728144346.GW3703@twin.jikos.cz>
 <CADkZQam9aJgNYy6bUXREYtS_fv1TLqyHbmkvs+aX9087AM62+g@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e7370ce1-a799-3307-cfa3-f1a660d308c2@toxicpanda.com>
Date:   Wed, 29 Jul 2020 11:43:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADkZQam9aJgNYy6bUXREYtS_fv1TLqyHbmkvs+aX9087AM62+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/29/20 11:42 AM, Sebastian Döring wrote:
> For reasons unrelated to btrfs I've been trying linux-next-20200728 today.
> 
> This patch causes Kernel Oops and call trace (with
> try_merge_free_space on top of stack) on my system. Because of
> immediate system lock-up I can't provide a dmesg log and there's
> nothing in /var/log (probably because it immediately goes read-only),
> but removing this patch and rebuilding the kernel fixed my issues. I'm
> happy to help if you need more info in order to reproduce.
> 

Lol I literally just hit this and sent the fixup to Dave when you posted this. 
My bad, somehow it didn't hit either of us until just now.  Thanks,

Josef
