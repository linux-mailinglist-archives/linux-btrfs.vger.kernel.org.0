Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD24F726616
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjFGQfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFGQfx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 12:35:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5956196
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 09:35:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f628cc4a35so745011e87.0
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686155750; x=1688747750;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZICx2bMlIlyVtz9Wc+rm13wjcZNVARO1UN8vfx8RBY=;
        b=drfN3RQDq0mvOdDrjuzyiQACOyx7zwjkrZHq0gdSyJ4SIfx9f6l8EIbp9nVVUuizvQ
         OYKGknycQNjq3e5ifsmxiP9uE627k5YHmhJnJSri6+ERVPkdm91mGzfEGr76KDj8Jek1
         Yu5VRm96Zyii3emLDC894cq2n4eyYfT3yaqyBzXfSXooSmn8Kw6yt0xy6Te7Vhr3qRPg
         I1ap2dX5AGrBhiT3kQQojZwRinUlqWudmhakBBwdMtniQNmP7jf3CTJzccA6/C+X/ris
         GJVO5LUnT1PKO5rGDdpudq2fMa4SWRagC8+AFchi6bw1n+lv79TQX5sPngv5NDT+1exu
         5npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686155750; x=1688747750;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZICx2bMlIlyVtz9Wc+rm13wjcZNVARO1UN8vfx8RBY=;
        b=NDGEKusT7STUbxeM8B0IcK7b3kwv8CMqAJH/A+UB1LyTkmNIdafuhSkzi8f+IVC5Se
         rWLTkVq8tcC60k6+yqxmL9e/T822FPK99cNDkb29Ocuva1TScGFnQ61Y6br1AM/+UXuH
         WcUM4csKkyqUNED/DYZDMkxdk+1zYa8/XY+/ohfDhUfZQ3GpZ4cCocYPoHXJ08Mdy3x3
         srSfi10V+PQnIddKRPYhqWeSrjpSA1/uYTq0M0PHLKQtQSdiYCtrgWNtlITjzTY9XsQr
         7gFNytUHyr4oFcosxzY+KSHawq9pdVjOJPhVlFiU192fG0G+0762fF0kKvGGAU4fx0OX
         yD8w==
X-Gm-Message-State: AC+VfDxrTPofAEJZuwNAd/ItyxrsTEvyU80XB5wX9qb5OV45yI+EW8/y
        hN46HwLFX13v0VhFw55oUVY=
X-Google-Smtp-Source: ACHHUZ6Mak3QjeLU/d27zJbdzp9cQnNEeWGINtC09hlElNxzQd4Y95jb35YZPCG7189H+9dp8ZqBUQ==
X-Received: by 2002:a2e:aa1c:0:b0:2b1:a667:dbca with SMTP id bf28-20020a2eaa1c000000b002b1a667dbcamr2472369ljb.2.1686155749836;
        Wed, 07 Jun 2023 09:35:49 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:1d8:9c28:f6bd:1013:1401? ([2a00:1370:8180:1d8:9c28:f6bd:1013:1401])
        by smtp.gmail.com with ESMTPSA id s12-20020a2e9c0c000000b002a774fb7923sm2298777lji.45.2023.06.07.09.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 09:35:49 -0700 (PDT)
Message-ID: <8c9b136c-c992-8c0e-a1e6-0e8aec1e89cd@gmail.com>
Date:   Wed, 7 Jun 2023 19:35:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: rollback to a snapshot
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
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

On 07.06.2023 13:45, Bernd Lentes wrote:
> I have some virtual machines for which i create a snapshot each night with BTRFS.
> The snapshots reside in another directory. How do i revert to a snapshot? Switch the virtual machine off and just copy
> the snapshot over the original ?
> 

It is rather unclear what you mean. VM disk images are on host btrfs and 
you create snapshot on host that contains those images? Or you have VM 
which use btrfs in their guest system?
