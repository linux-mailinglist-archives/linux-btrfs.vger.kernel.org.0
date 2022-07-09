Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6657B56C5F5
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 04:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiGICQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiGICQs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 22:16:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E726C11A
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 19:16:47 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x22so253509qkf.13
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 19:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=+T+wDedVSadvIb7N678UYw5W1EpDXefMluXIKXRiQhw=;
        b=mRoLr4lbiMzwPSg4HuTqEMkQpXnN18RGf891RldvrNyWmPRYZmx5wH4rXjpMGtmiJ0
         fLVJPanImBQ2zlMujjpYL8jPl9ywVqDP+W55sIWinGZxzV3f6Ald4J0AoOTPF9m2+wRO
         bgy6LegXmH6I2+tf2MdyfqER+CTUUfjzDMxrKIwZuv5O8dmQXv1STJsdD+EbOpS7Qbte
         QXBjfE+wIfAlqpDyNwvqVTich4VWiUCiLErLVrpcYm3WHwGb+q8EDgcrErO8WRws6CKC
         4D5IneiB1JO1z8j4J0qnxFHc2pRx+HNa/zTWcUyBxncSEFNxHE62WJaL2+mbjkKRJco5
         BKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+T+wDedVSadvIb7N678UYw5W1EpDXefMluXIKXRiQhw=;
        b=SFVMcaJ1InpHNX0hiNeKAXn0+n16dAiZ3L2AFwIwVmLYTUyw6OBJoJG8IP9V7+pvLW
         elnPesAydXXAF9FWVwKJVm2QPy70Uk47KVJwpNzC7H9inA3Ahd/NiMZSC07TqOwTOXTq
         JvsoDIu55wFCDwvKFDHqj3WYCXUEnSneZ+f0bxldNyHA/vtFGY7de3kK5qUAvd1PcIal
         ixNQ8kChY58raNFYyoSO4ZSAn41YzhodULYjp28wQYgyipIxtD7LGy3zX5a9Uzf81G68
         eHLWcaXbJOd7igYH5cLVSJOboSxTtFiA3oFOxa3aCmxusH5B4LKdQAtKFNWVyd0+Ek+A
         2nmw==
X-Gm-Message-State: AJIora8BVnZpVv1EVgZrHRCtUvzrePjiyPxH70f4X1ja5ajOEaiejkA+
        jFU30evXLgY9SDb8o23pTlrIDQ2aovM=
X-Google-Smtp-Source: AGRyM1vHR7W5w1rNpc/ruhP5Nb+mQk5P6kAysxg0BjkJJFn/2aCtxNjFGktEuXo6PsfgSJH+ctfHAg==
X-Received: by 2002:a05:620a:490a:b0:6b2:5f8f:cf65 with SMTP id ed10-20020a05620a490a00b006b25f8fcf65mr4555335qkb.567.1657333006864;
        Fri, 08 Jul 2022 19:16:46 -0700 (PDT)
Received: from [10.5.100.6] (modemcable117.130-83-70.mc.videotron.ca. [70.83.130.117])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a288b00b006a6bb044740sm328316qkp.66.2022.07.08.19.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 19:16:46 -0700 (PDT)
Message-ID: <3b281d71-ad13-2145-fe77-e70051e0faca@gmail.com>
Date:   Fri, 8 Jul 2022 22:16:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
Content-Language: en-CA
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
 <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
From:   Denis Roy <denisjroy@gmail.com>
In-Reply-To: <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

so, what option should I use?


  btrfs check [options] /dev/md126??



On 2022-07-06 10:19 p.m., Qu Wenruo wrote:

