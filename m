Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004875DE38
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGVTLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGVTLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 15:11:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E45E66
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jul 2023 12:11:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b83c673ab5so8665711fa.1
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jul 2023 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690053100; x=1690657900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YnlDT3KVo6KyQKWcZQoBBOv0q+w/sOYzw34AhsAvsDE=;
        b=Fn3dCIH5vpxweVuRjgtZKHh8hm2SGLN4SnINwmDVgniK4tL3o1R1Yvfo+F+cpMWUws
         xkRmlXA+Vs/UQs6+crdFf5eUoa9bdbqRnqsxL/BvWz7BRJcHWDbmY9nZoR921aSDXIC9
         o32RAniMxKm9+o0P5eycBhtngsH7zf/MwoSlIojOo5b883JwPEbMUMFv/FbCxpwWKKsz
         Oyx2B1dyWKQh//+dWKaFhnjTHGHFY30NY0jCR3qJom5qZK8HYxJ03we4PT7rviph25FU
         VzN7D0Siix47JSSuIqJtT5ZLdS03Z/K2axsDUiaUZwc7JStAUw7F6tYaSLzI2xszTP5r
         K89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690053100; x=1690657900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnlDT3KVo6KyQKWcZQoBBOv0q+w/sOYzw34AhsAvsDE=;
        b=DNpHVvZfdbgQWodwyQAZa1rf1TZiiY4aGZxinbdRiaLkiCip5/5aimpUj2Goh5BxGy
         QSsAseJconJJi9Xeo0e4PSe5T4+x/uP7zZs++J6m0fGiGOOvKYRGR+VlciYf7lGm41tG
         vdMPVo0EyjmWiIh22x5e5fDT2ZwmbcMl9HnxIIPf4v/qeBp7/h7Dj6jhmKfgVvHtnzHJ
         hu18uz/ykpOuzcyG8ASHSQCvr0HSSNUrl79qp811FK1uFRYrjNTgaRFxayPGiFoakDId
         uV2jchEUj0qu7NjN4qBMn5qyTbGmNDYVRxnMqlNfQzp7IhkzdieAsjcFy/4jQTY8GFRI
         x18w==
X-Gm-Message-State: ABy/qLY+/JNo61cL4hwVK23HFxoo26BA9T8ZwgaW3Gg7i+sXUvO90w58
        N8REZ1VVaxWDHpBL+NAs9qE=
X-Google-Smtp-Source: APBJJlGuJYzOozozj0J4CZ+fVhmLN7X2UzdVV2nWqPyWdQ1sf7vjM7lR16w9vxIK6tDRZ/mZQMde0Q==
X-Received: by 2002:a2e:a98b:0:b0:2b6:99a7:2fb4 with SMTP id x11-20020a2ea98b000000b002b699a72fb4mr3205978ljq.0.1690053099809;
        Sat, 22 Jul 2023 12:11:39 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:2474:2a7e:740:5ff2:c783? ([2a00:1370:8180:2474:2a7e:740:5ff2:c783])
        by smtp.gmail.com with ESMTPSA id l12-20020a05651c10cc00b002b6b60c14besm1712231ljn.29.2023.07.22.12.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 12:11:39 -0700 (PDT)
Message-ID: <86568e50-7dac-2c1f-c678-4b63ffa5b1e0@gmail.com>
Date:   Sat, 22 Jul 2023 22:11:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>,
        Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
 <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com>
 <54P7YR.LGLFEH7DB1TH2@ericlevy.name>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <54P7YR.LGLFEH7DB1TH2@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22.07.2023 22:07, Eric Levy wrote:
> Mounting should not be
> attempted until all devices are attached.
> 

btrfs does not attempt any mounting on its own. You need to raise this 
up with whatever software component does it.

