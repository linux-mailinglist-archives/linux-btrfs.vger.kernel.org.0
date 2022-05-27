Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856B55363AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352867AbiE0OAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiE0OAk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 10:00:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACC1839B
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:00:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 7so1556159wmz.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VPTVX7ksAjs3x68Nlg3Rw0T065iGYFmHA9HCErUvcAk=;
        b=a9R9lErYbOJknpycTw2CelSL0avVdfBtdaAo3H+vMgEwvDddQtrKCzEYYfHaZhIydv
         nYgnlf/nViSCVCTu3+dSjtVbPle7FVqHGMqPJJq8JgW9aew/OvylX5JfE7U429VD8OFY
         r5ksm7ifZ7p+xpH7NFtaEL8uRSMbwuXU0dPFyO37LofTWCgX+Pd3nOKpKP8KYcL9pe9R
         eFR8e/dxNdxpxEo6klU7G2hpFvy+MpMw9EP7lOFRdkvM7mGsd8sJWlrqQBcv8KaP60Ms
         lRr73v2zSgWs44H0CcBdYTz2EC4xOpFDjG5oW1e3Ai3RDnq5n/Cd6Co9xvJ1UyILOcW8
         mntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VPTVX7ksAjs3x68Nlg3Rw0T065iGYFmHA9HCErUvcAk=;
        b=IO90Xj7KEvX46sIOlkwPchwVfmEWggZnLHqNNI5YJCmPP/IxOIwvAX61Qq5ILHSRR3
         ZYDoOOvwRJ21hW7430Y0zoe/vrBQ6tB/NfqwETu6kpQm/+TVvDG/i3xMNA6xnYCfeX2j
         e5rZVZo1xh26cEDLSjTGXgnZqxMXaXq4H3ttweEH+Yh+cKkjDj9qtIk12u2K3Ii0DaHk
         O1nrsbjTKnGscCMahVYX9dC7grkYSHBtGD+lGWsgFq946M+Y/eKHVsmjBSKBiOE/Y2yp
         EMNfTnF5XvYbpYzCjeO4GadwQfnwh7ojdtQjKzrrKPIsPWfzcCFF65FQB1vH3XKiuNYJ
         n8mg==
X-Gm-Message-State: AOAM533W7SAYWYcYF4BiP5FK6g4y5eNGhksk6bnucQhS5emul0jvCuYK
        QhfksqtoQltS5larmG5njO8=
X-Google-Smtp-Source: ABdhPJzetUSDddwGv5wVFNrAuoDQyNrG8Uzop3xVOkMdNlLVk3NzCRNEpBYXE2TY7J0sDbGpTLVGpg==
X-Received: by 2002:a7b:c241:0:b0:397:4925:6d62 with SMTP id b1-20020a7bc241000000b0039749256d62mr7245143wmj.192.1653660037813;
        Fri, 27 May 2022 07:00:37 -0700 (PDT)
Received: from [192.168.1.9] (95-44-90-175-dynamic.agg2.lod.rsl-rtd.eircom.net. [95.44.90.175])
        by smtp.googlemail.com with ESMTPSA id o1-20020a5d47c1000000b0020fff0ea0a3sm1801486wrc.116.2022.05.27.07.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 07:00:37 -0700 (PDT)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <1b6a6413-963c-f612-7b1f-960190c3a323@draigBrady.com>
Date:   Fri, 27 May 2022 15:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:98.0) Gecko/20100101
 Thunderbird/98.0
Subject: Re: [RFC][PATCH][cp] btrfs, nocow and cp --reflink
Content-Language: en-US
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, coreutils@gnu.org
Cc:     Forza <forza@tnonline.net>,
        Matthew Warren <matthewwarren101010@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>
References: <d1ccc0de-90b0-30ab-6798-42913933dbb2@libero.it>
From:   =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
In-Reply-To: <d1ccc0de-90b0-30ab-6798-42913933dbb2@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/05/2022 18:05, Goffredo Baroncelli wrote:
> Hi All,
> 
> recently I discovered that BTRFS allow to reflink a file only if the flag FS_NOCOW_FL is the same on both source and destination.
> In the end of this email I added a patch to "cp" to set the FS_NOCOW_FL flag according to the source.
> 
> Even tough this works, I am wondering if this is the expected/the least surprise behavior by/for any user. This is the reason why this email is tagged as RFC.
> 
> Without reflink, the default behavior is that the new file has the FS_NOCOW_FL flag set according to the parent directory; with this patch the flag would be the same as the source.
> 
> I am not sure that this is the correct behviour without warning the user of this change.
> 
> Another possibility, is to flip the NOCOW flag only if --reflink=always is passed.
> 
> Thoughts ?

This flag corresponds to the 'C' chattr attribute,
to allow users to explicitly disable CoW on certain files
or files within certain dirs.

I don't think cp should be overriding that explicit config.  I.e.:
   cp --reflink=auto => try reflink but fall back to normal copy
   cp --reflink=always => try reflink and fail if not possible

We would need another option to bypass system config
(like --reflink=force), however I don't think that's
appropriate functionality for cp.

thanks,
Pádraig
