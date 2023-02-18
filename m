Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF069B8D1
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 09:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBRIyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 03:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBRIyP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 03:54:15 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404383C792
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 00:54:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b22so672055lfv.5
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 00:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676710452;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oO+n8j5X7ef+4wU7dpQ4nxEh8gpxfqKi9kA1UUsyPg=;
        b=aeaeLV0yKl2101wiAzEvCTkc3HbJM4tn1ucRKvwpawbml/QZnLXxQfuJoXCeZHBFKM
         Hgs0TNE8p1SpO76p+ps70PLxfdLHvW8HO62sTTF1C2yEnOeN529Swx2cl8QAepv7vpFW
         CER8LyTOWy/ocGhkn5QNRLkoOQebmbi5Kjhb+6SEMc9yaHQVbTZOMv5GEoKs4wxYr23X
         ftf/n9M5WI2LmsotTSQrrq/PXIsrEyDnaSgrfbrB+1q28GduL9L2I3mKdefzP2YlH7Zp
         PoCLIEpc1URO7PtnlNXBPJYu5EwiwBWGsvVwpZez6b9ZqFEDJSaa0rOu7sRG5hVpLoS/
         BW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676710452;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oO+n8j5X7ef+4wU7dpQ4nxEh8gpxfqKi9kA1UUsyPg=;
        b=8GvV8GntMHzgs4aFO2ag5c73A3YsuTkFu+7YHBJ1OryWZObuRNzSwI3dp92kT0XU7t
         Xdto2WSi8w3rXcak1g9ZQk8WqyY2d5M+qa64oSRA0OD9A41VbuvWUjebugDlOPp6oC9L
         5Ap2Vm0Z9+kc9DSCc+/Uk4IE55nlBQvsqhJUQzTW/6n+hQSBfNNW9Dt7o7Ugn3i+lSNa
         iu0vWbgE1q47GQ60oHiX0i127p6bz1kV3lzachq1qYohrvhDsPJRGfhngu1l9wEIvNGi
         rI44QKHSYZDjRb+j3z9UsG5NndiKnsSu2ZNwR3hrgTxqPNuYVWS7ne6qSDL+kIl28sSn
         SMeQ==
X-Gm-Message-State: AO0yUKXzrXWRV+5dz7s+/WCk5BLxWnBppahqqJM+kSuiy2BB05cl//7W
        OPJNQfTvU4e5bVnmQFb7xJdd1wmg1Ig=
X-Google-Smtp-Source: AK7set/qaMFz8apDBlAkOPimqFy6iXe/ktXlRvpFtVJBGJxHjVZy1NHIDLJoL2NEXnLTk7iVJdac3w==
X-Received: by 2002:ac2:5330:0:b0:4db:3467:f2ff with SMTP id f16-20020ac25330000000b004db3467f2ffmr1149668lfh.5.1676710452304;
        Sat, 18 Feb 2023 00:54:12 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:1876:4f6:b0ee:d8e5:5c8a? ([2a00:1370:8182:1876:4f6:b0ee:d8e5:5c8a])
        by smtp.gmail.com with ESMTPSA id h18-20020ac250d2000000b004d865c781eesm930385lfm.24.2023.02.18.00.54.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 00:54:11 -0800 (PST)
Message-ID: <752fc1e0-74d3-3a80-916f-de5df9ff4e1f@gmail.com>
Date:   Sat, 18 Feb 2023 11:54:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive
 operation?
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <87wn4fiec8.fsf@physik.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.02.2023 11:10, Torsten Bronger wrote:
> Hallöchen!
> 
> I want to replace a device in a RAID1 and converted it temporarily
> to “single”:
> 
> btrfs balance start -f -mconvert=single,soft -dconvert=single,soft /
> 
> This takes very long. I don’t see why, and wonder whether this is
> the right approach in the first place. After all, no (significant)
> amount of data should be needed to be transferred in the process,
> should it?
> 

Converting between RAID profiles copies data from chunks with the old 
profile to the chunks with the new profile. Old chunk is not modified in 
place, they are removed after all data is moved to the new chunk.

> A side question: Is -sconvert also necessary?
> 
> Regards,
> Torsten.
> 

