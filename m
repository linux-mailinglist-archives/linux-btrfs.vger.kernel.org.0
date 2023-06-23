Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4C73AF9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 06:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFWEzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 00:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjFWEzV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 00:55:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0D5269E
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 21:55:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f14e14dc00so21697e87.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 21:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687496109; x=1690088109;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQE8yJ7qevdfobWtoE+lnp+/+XSVZLy+SnlJkn3bI9Q=;
        b=Hq3SKhd2jV3oX34xEyWbQDCE86vg6lW0VXU11k3p4+oxBEcoApmrjsVv/UCItshsqA
         f2NC5Rfs9jisi+Z4laIY/ldhNvAs7p2+5kEP1WzYeX/gXXlbsMLzn/zQYpMF6Pc+dMD8
         VnfGENfflp5kMOkoIhbiu25lPVaYoh60ynhrtmxVygLaC/D9jlBR8I2cjoNSOTiQocc9
         U5HUJsZ94ET7mFrJsCFdRQDxr1AolQIImp/OSgbMi6bEDlHW12IemsZCJjET38sf0YHd
         6TAsZ4ooHR3C462KtQVQsACrZzhTkAw1fqo6ng4GnNko45+4j1s79E29rRYmbMoyf7+R
         Vm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687496109; x=1690088109;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQE8yJ7qevdfobWtoE+lnp+/+XSVZLy+SnlJkn3bI9Q=;
        b=WHjPFTJGlFlN2f2YHMP9HqaseJ4CISY2JsAufMj0u6BET3ZQfin8oz7aw7ueV8zv62
         5DLgadiFfJkoE6VxCSNgwVkyHbvGR/sMgRYU/fAQHAUyiKuV0MsasabT37VUZH4RhvJz
         2NNerGZM0cZJQJAxwEq6hOKMY7BvH0BBjvWMdc4fLJN87Rcct1bQCSwLFmc4xThSdlOM
         T1H/9gfXr7rKH1FjIgptpe6g5RAFVDD6WNHBCcD7Trw0UyhbA8viiwKDaYS5YOytzQlp
         d6UI2EclzjMmU9HiewhHzvfXfPzHVOcoyA7uwwwHjte3JB41UlSOkgmVsMT0ScK2NJ9C
         Yd9Q==
X-Gm-Message-State: AC+VfDz246dVEh9j0O1GdRIpE7VtCWxLeZ4pdteewuhOlBSjemGa25W9
        7mscudMcwgIKv7ieE/te8pv8k0bjEjY=
X-Google-Smtp-Source: ACHHUZ6XJJG6JJZw2YCo091P5DvHK1L5nq4xpn+hxozJR/nCopIlJGdinWei0L1KKqvUI979qpcViA==
X-Received: by 2002:ac2:4304:0:b0:4f3:a878:2c02 with SMTP id l4-20020ac24304000000b004f3a8782c02mr9156654lfh.4.1687496108376;
        Thu, 22 Jun 2023 21:55:08 -0700 (PDT)
Received: from [192.168.1.109] ([176.124.146.132])
        by smtp.gmail.com with ESMTPSA id d8-20020ac244c8000000b004f85a24d2basm1323278lfm.105.2023.06.22.21.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 21:55:07 -0700 (PDT)
Message-ID: <d7905c54-e8bb-882c-8e7c-048dfe865ee2@gmail.com>
Date:   Fri, 23 Jun 2023 07:55:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: empty directory from previous subvolume in a snapshot is not
 sent|received
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <ea6099a3cff73c20da032afaaeb446c0b12ec1da.camel@scientia.org>
 <9fd09e52-e77e-415b-bd95-9c58dde263d0@gmail.com>
 <bbccd0204d2951f54f4303aca3af1b6dab2c3108.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <bbccd0204d2951f54f4303aca3af1b6dab2c3108.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22.06.2023 19:09, Christoph Anton Mitterer wrote:
> On Thu, 2023-06-22 at 18:22 +0300, Andrei Borzenkov wrote:
>> I think it is expected. btrfs does not support either recursive
>> snapshots or recursive send so "btrfs send" skips directory entry
>> that
>> points to subvolume root.
> 
> Well it's clear that the sub-volume is not contained in the snapshot or
> sent.
> 
> But in the snapshot (on the original fs) I have the empty directory
> from the subvolume that was not recursively snapshotted.

It is not directory. It is "orphan subvolume graft point" for the lack 
of better term.

tw:/mnt # btrfs subvolume create ./data/pictures
Create subvolume './data/pictures'
tw:/mnt # btrfs subvolume snapshot data/ snap1
Create a snapshot of 'data/' in './snap1'
tw:/mnt # ll snap1
total 0
drwxr-xr-x 1 root root 0 Jun 23 07:53 pictures
tw:/mnt # touch snap1/pictures/foo
touch: cannot touch 'snap1/pictures/foo': Permission denied
tw:/mnt #


> Shouldn't that be just a plain empty directory... and thus be
> sent|received (as empty directory) when I send|receive the snapshot?
> 
> 
> Cheers,
> Chris.

