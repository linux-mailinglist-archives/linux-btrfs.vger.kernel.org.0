Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B258031F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiGYQuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiGYQuO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 12:50:14 -0400
Received: from mail.tol.fr (mail.tol.fr [82.66.50.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CEC10DF
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 09:50:12 -0700 (PDT)
Message-ID: <849cf4c4-a9cb-c53a-e26b-7cf9349a2699@couderc.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1658767808; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxKvVsutwX5ueoLqpFg6Gy5l3cBLr4Om9WMVJ7dsf1w=;
        b=Dy/VLBvfGESEdqIxSk4rju70mYb1z7ux80v3dx9YkRxYJmIsHEFtoZj16dEBGCgj3hp8SV
        x5Nf8E+TmwK+DelqMX9aHSWFVDMWkozx/dBSg0VO2rfloyr8yEjZkPxAVsVO+pD9IRbcU+
        WXxPQLePyBVeuFBM85dYhobNfJsDJYQG1ajKNesaZ73ESoI/FP3kaFT/2BGFRQOga8rnJc
        30+elRyoknkHC9CCcNAvyO1nTBbo3leX82GpVXmaHbCL4EIE53+SEikhFx5PhA41vNKJWX
        uH7kC6S5MqbPnJmZoRjNZoNbsjTjjyc+JSnJXbWkya693YoLnuBcweN7sdaZ3Q==
Date:   Mon, 25 Jul 2022 18:50:08 +0200
MIME-Version: 1.0
Subject: Re: Best way to programmatically send/receive ?
Content-Language: fr
To:     linux-btrfs@vger.kernel.org
References: <4ade214c-db16-dd74-7118-8d0fa128ea52@couderc.eu>
 <20220725162343.GB13489@twin.jikos.cz>
From:   Pierre Couderc <pierre@couderc.eu>
In-Reply-To: <20220725162343.GB13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1658767808; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxKvVsutwX5ueoLqpFg6Gy5l3cBLr4Om9WMVJ7dsf1w=;
        b=Kpk91JQpOtZCTpAqp9CGhqeyitUKRsILMRRhEJx6cdOPFpDW3gBVzgFYaFPhriXb6e5P+p
        Wj5Bkw8i1kLYXvZBUJwBc1lRQ/mfwEmUZ3BxlSm8gs+WKmgIUEpQHxAUukFMALal0sCBx1
        jYAYCCfG5UDzlhsH7lo4lpLp1d/cXCZp6bVFrqnqVVcXxmtlQfP5ZjE6N+sTltWVxPIGLQ
        cS/Rt5lFu2KTYDi69q4drY8GWsecxhr3sIOT5eumog5AlIF/zHALV4CEyaJ1A2WW0y4Yud
        bO0WlEpRcU5yJIJlKxafXaersrGSnLFGBNB4zOJ8gWYg4et+TvOl+TdNvOB3vw==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1658767808; a=rsa-sha256; cv=none;
        b=AZoHEUR6BzYIeGnpnOEfgg7KaoNCnXmtyuPZoWfqxICoe87VX+k+5ZvDXtiLkcD4WcyJZswhgp2439aPoinlLNHTFDbDAau8Y2WOH2yDjCBwtICDtlBXiA/3kctW41zMahS2mdFv+i9UVy4zyoYTUPTBLajI3sxAgNayGCOU0F3zBbxBKxmy0EtgczpIugypplxF5VjDQZ6MZe8rVuvtaczg9DhZhJox3SJjjcSYTa9LVkKM2EKfM+i4jrBGh3mpA38JzIAG5EfLQQA5ZHufnXWrDA1sEngDDn2SBgPnXbJNAvKIyhYtDX/Mfo5cblCErPs6b5mDxVNGVj1G91acHA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tol smtp.mailfrom=pierre@couderc.eu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 7/25/22 18:23, David Sterba wrote:
> On Sat, Jul 23, 2022 at 08:22:48AM +0200, Pierre Couderc wrote:
>> I am doing a utility to manage backup of btrfs subvolumes.
>>
>> I need to save a subvolume using btrfs send/receive
>>
>>
>> I use libbtrfsutils, which is very fine, but I have found no entry about
>> send/receive in it.
> The send/receive support is lacking in libbtrfsutil.
>
>> What is the best  way to do that in C/C++...?
> Right now it's available in libbtrfs and an example implementation in
> C/C++ is snapper. However, the libbtrfs library has several issues so
> I'd rather not encourage new use. The interface is frozen and can be
> considered stable, which also means that the v2 stream won't be ported
> there.
>
> The libbtrfs is a library done the wrong way, no clean namespace,
> naming, GPL so libbtrfsutil is supposed to provide the proper interface.
> But right now that's the plan.
Thank you, libbtrfs seems to be the best solution even if not 
satisfactory...
