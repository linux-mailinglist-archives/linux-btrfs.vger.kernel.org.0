Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4046BA63C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 05:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCOEdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 00:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOEdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 00:33:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8276A4F
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 21:33:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bp27so12460179lfb.6
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 21:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678854779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWbFaHQmEj1zLCDPFzlV3fKyNrxJlXrg91LKykugTL8=;
        b=H6ivwnTatCx7FCck5AIFfY/C9UZ5+N2woB3ny55jiyOeQEjAhfvs+qEgGu3uCGExM8
         rrLPFOtbwS/CA1py8LNjucWp5i7y1Nmexu6STNxNRs7quGPigPPOlRe3FYnk5a742kzS
         h3Mu5zJJ3WcYhaMl+lYpUyHnsKxzNbDHAxdSFv/bizfd+/DPzH1xhyfxn1GWYp6SHsGf
         IlGjUDnqkqT6nhwxkITrbShDYgX7DMewOfdNg0bH2UTS7j6obUbdl27qBPs38az2n7ZW
         ZQ/oM3kkRnSCicdDukEQgIXPoQHi0/iitWSn5pPZ+X2F0VkLbteF5cz+2v0aoSOTwTIy
         7OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678854779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWbFaHQmEj1zLCDPFzlV3fKyNrxJlXrg91LKykugTL8=;
        b=ltAufojWbS2qq8q6CSdlrjI7opc09e+tLfcTK++7rygBiZJ88xwng1BHhEqw2hfPhV
         p+DZrZMpecyPj+5JpGueT9X8BtynTqzhVgQ/Ge2NnJcm/3vhmtm9W0mYniLbEZJPt+ux
         se9NC6OxOEzegfjXXf4Z8ZA6pZZsL/vqEWt8mQzK+/qEsb5j4572dMqZUo6iMzBf0RhY
         Iw27YZMvqZBHjP/GweDecL7yQW0uSzR1y3tuzzQoBYwN0ozM9IpLjKzwqYfjkOVTOQKo
         hz7CJTtdkgNx5+pWy+BeLYf2stQrEtvGVAy58ZN3lmSQcA1LCxOInMatk50CFaocA3Fo
         kXjQ==
X-Gm-Message-State: AO0yUKW81binN/XpNiFfDzgvRcZ3nkXPdMb1wyIF11EY54SDpRJUIh0Q
        wqPvT8pmIy0Br2tZAPP8biViKmIAs34=
X-Google-Smtp-Source: AK7set/gCWAk3ZqpAJ7LQ54ZvSCZO5VoyWXOb0KgR9VyOEo3sxfJpBSA/mFGmOR7ttPA6v5VABijzA==
X-Received: by 2002:a19:5215:0:b0:4e7:ed3c:68ea with SMTP id m21-20020a195215000000b004e7ed3c68eamr4579776lfb.5.1678854778560;
        Tue, 14 Mar 2023 21:32:58 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:38db:798b:e8a3:6661:6ba? ([2a00:1370:8182:38db:798b:e8a3:6661:6ba])
        by smtp.gmail.com with ESMTPSA id q24-20020ac246f8000000b004db3bee9a32sm660085lfo.283.2023.03.14.21.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 21:32:58 -0700 (PDT)
Message-ID: <22489ca9-37e0-f4a3-d7ec-b61357e8b535@gmail.com>
Date:   Wed, 15 Mar 2023 07:32:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Corruption with hibernation and other file system access.
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Phillip Susi <phill@thesusis.net>
Cc:     4censord <mail@4censord.de>, linux-btrfs@vger.kernel.org
References: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
 <87mt4f9qrn.fsf@vps.thesusis.net> <ZBCzZH7Lq2K1jS/M@infradead.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <ZBCzZH7Lq2K1jS/M@infradead.org>
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

On 14.03.2023 20:48, Christoph Hellwig wrote:
> On Tue, Mar 14, 2023 at 01:36:32PM -0400, Phillip Susi wrote:
>> You must never boot into a different kernel while one is hibernated, at
>> least if there is any possibility that the other one will try to mount a
>> filesystem that is mounted by the one in hibernation.  If you do, you
>> MUST NOT attempt to resume the hibernated system or there will be fire,
>> exposions, and death.
> 
> I'm not a hibernation user because it's generally been rather
> flakey, but last time I checked hibernation was doing a file system
> freeze, which implies the file system should always be consistent.

The problem is not on-disk inconsistency, but inconsistency between 
cached in-memory metadata and modified on-disk metadata.

