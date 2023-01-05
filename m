Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1860D65F0B5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjAEQCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 11:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjAEQB5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 11:01:57 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7729117424
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 08:01:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so55613186lfb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jan 2023 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tII1W7fFwxTUY1zX0ifvDkIIIaT8izjSLsfwA5/PpFY=;
        b=jRIYpjsEJxc6HAfkF8fRzQbvNXn1P/V/oX0GarQX5UwUxTFSPNKfZt2wK2nlG7XG0/
         EYRT1pGfRZI1c2Ja9gJkMJ/0ZFC0YAopNckgfNOXk8flVAuBYXhYSih5I5tEB0fZ6pfn
         U0Sre1hSXoJjs1l+gi/XJyWu11rexXL5p+tkr1Ka2l0J0kTEfZ+fh8CmOh3TKRX3XCS0
         N1kGLliBq3nsvjwZ/wpAz03qASnMpOHSFkxQuxpzBQ0ArXSNXPyQsoTCzup5clujn3Og
         WqQkv7dtO5ZZ5+D/G1niv8Db81ZbZSW0JZ/HeNbf5or+VSCmLvENNXR4PAYHQXHuKqxE
         fHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tII1W7fFwxTUY1zX0ifvDkIIIaT8izjSLsfwA5/PpFY=;
        b=4QuDl2YqKA1pwfM+JChb4d1DT+r3/VDfu4ZewyLJLrFZ+/bcO7IXmvpTiWFyPr69nk
         eniTA+bu4+QiEuMt1qvTO5FymG3Kz6mXUC84qsTPt2BypzIkDVAwVvb09MkM4SLa6DL8
         S7klwRUvxStTjBKGmmdiWrn81F+TMczVTQYBfint1cDO2YRLc3MsCh1kKrXEUWkgqMyX
         unZRYKnxFnAIGv0/oAQON3P1+Bh9fLh20cUstqr+pU7YI2UcXjSnmNaX6xhaCTaSXpAw
         XtkHkIwaONJjvv3yu3w24XQSVZpnq4SnHt5n1cloUG0znf/wW4CrmrvUjcm6QGyPDntR
         ttaA==
X-Gm-Message-State: AFqh2koDgaQIoBf3ZenlZdCCAGfbH5W9b7P/ojEXVDwdhTRmTGrzWhFP
        1D53nE/y7GSGZ9/7cE66Ayg=
X-Google-Smtp-Source: AMrXdXswCvDdcZulECjoa7CxW7A8e4OhFaJG/8SnY90dYYVClFJOTgwH9evowv6rLQVoez/m+x776A==
X-Received: by 2002:a05:6512:22d0:b0:4c0:5798:38df with SMTP id g16-20020a05651222d000b004c0579838dfmr18212869lfu.27.1672934514762;
        Thu, 05 Jan 2023 08:01:54 -0800 (PST)
Received: from [192.168.1.109] ([176.124.146.236])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b004b551cdfe13sm5512729lfo.279.2023.01.05.08.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 08:01:53 -0800 (PST)
Message-ID: <76b72107-71c0-bbe7-c20e-2b26dba24abe@gmail.com>
Date:   Thu, 5 Jan 2023 19:01:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: btrfs send and receive showing errors
Content-Language: en-US
To:     =?UTF-8?Q?Randy_N=c3=bcrnberger?= <ranuberger@posteo.de>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <b732e1e7-7b3a-cfa7-1345-d39feaa6a7a8@posteo.de>
 <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com>
 <0ee56d23-9a3d-08ea-a303-e995c99d3f43@posteo.de>
 <CAL3q7H4+A1mW5+hrVj-OZT8bGnaOQWCzwWJESquS0-aEu7teKg@mail.gmail.com>
 <58eef5ef-b066-b2cd-e465-6bab43c1c748@posteo.de>
 <82ee24b6-fa58-b03e-7765-b157556a2b37@gmail.com>
 <cba9edbc-bde4-00e4-0f73-5063f5aef11d@posteo.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <cba9edbc-bde4-00e4-0f73-5063f5aef11d@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05.01.2023 18:55, Randy Nürnberger wrote:
> 
> I’ve attached the output of ‘btrfs subvolume list’ for the source and
> the target filesystem.
> 

You have a lot of source subvolumes with the same received_uuid and you 
have at least two destination subvolumes with the same received_uuid. 
This is wrong, received_uuid is supposed to be unique identification 
which explains your errors (incorrect subvolume is selected).
