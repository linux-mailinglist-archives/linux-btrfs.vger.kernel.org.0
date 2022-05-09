Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5353551F4FF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 09:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiEIHJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 03:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiEIGyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 02:54:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C12657
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 23:50:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p26so8844834lfh.10
        for <linux-btrfs@vger.kernel.org>; Sun, 08 May 2022 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TrT++FqWFhe+IHfwCDR/FgBi0nT+IZsDpyvsIAMj1p0=;
        b=pTAaor193Cb/cucaAyD0xVxNosKsPMj3r0FL7XgnOEfMfz5i8YTQhM2L9A3NUkZF6e
         RTrFA36vowf5Usik/SJVdw0PCEQv22pAYZTHQOXYCsV7lRaAHNfQWEcuKl9an6g4oDGt
         2jf9mTh5fv4qocZjTMXBA15Tzorv/SkNaGRa23Yse636dcopc/8/ianvXg8XkEG6HoQX
         +kUEoUhnObsfZpeQxaUjTdOVy4G8aQnveucPyWSD0Xc3OHMvoRiA35QhF7y8cMoWyyXU
         rI/xEW1fULaf8WzOQ3NvdcrA8+gvjayAOBZgLeMhIAs1WlKFz5VOXYjAyrBsqrWKvUbl
         SZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TrT++FqWFhe+IHfwCDR/FgBi0nT+IZsDpyvsIAMj1p0=;
        b=JZObIc+G2/12Hwh4NxSmRmq8QXc43TwHq7aCE7L/BGAX/GsNRzvY1kN9aNupzC5pRp
         EQmQ2mO8WjgaiWPjBvTql5J/v6WvTbTHax4n1BVkptMELtAufIXAXayfg39YdtqJaU28
         mGbm/Dr7dANBgHLT5MUK2Dt2INkKdv6Y3k8FDPQqC6kKH10uGOaiPYEtZvDK1KYo6C+0
         AfCQGUY8vy7D9OFw4jYYZhVf6OlERoXc0bQ11C5JpAMmB4GVj9kR3AF5+2iJ7p6nR+cR
         qL5SHoSvjVtHHPLrk7g+nk2I66ktKOX/Rbwy02kaGdv+rS66frrupWRgLFp6OHOyplX0
         eiRQ==
X-Gm-Message-State: AOAM5335wBZq4flxSF1Mx34urA9+wvDPtPvZJoumpviVb0cE3nAWfs9r
        XKCczcEoJ9qL3Kv4xifJhJ6QWZnfIGs=
X-Google-Smtp-Source: ABdhPJx4qYzOLTOw0Pai5qglBX5a80osq1HXfxzLAQEHklM++MKEMSLWw5XPeYmNG7lBaqwH47/gaQ==
X-Received: by 2002:a05:6512:1510:b0:445:cbc3:a51f with SMTP id bq16-20020a056512151000b00445cbc3a51fmr11756968lfb.116.1652079020875;
        Sun, 08 May 2022 23:50:20 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3365:df52:ce71:56d4:e7e6? ([2a00:1370:8182:3365:df52:ce71:56d4:e7e6])
        by smtp.gmail.com with ESMTPSA id p7-20020a19f107000000b0047255d211cfsm1833555lfh.254.2022.05.08.23.50.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 23:50:20 -0700 (PDT)
Message-ID: <7ba060b5-5860-f150-be64-cf3a1b266085@gmail.com>
Date:   Mon, 9 May 2022 09:50:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Debian Bullseye install btrfs raid1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
 <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
 <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
 <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
 <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
 <42d841fc-d4ee-37e1-470f-4ac5c821afc7@gmail.com>
 <20220504213349.b49135a060ec1d8111794db1@lucassen.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20220504213349.b49135a060ec1d8111794db1@lucassen.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.05.2022 22:33, richard lucassen wrote:
> On Wed, 4 May 2022 21:15:50 +0300
> Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> 
>> No, it will not. Some script(s), as part of startup sequence, will
>> decide that array can be started even though it is degraded and force
>> it to be started. Nothing in principle prevents your distribution from
>> adding scripts to mount btrfs in degraded mode in this case. Those
>> scripts are not part of btrfs, so you should report it to your
>> distribution.
> 
> Ok thnx! Would it damage btrfs if I add a permanent "rootflags=degraded"
> to the kernel?
> 

It will not damage anything under normal conditions, but btrfs was known
to start creating single chunks when mounted in degraded mode and not
mirror them automatically after you restored redundancy. In this case
failure to access single chunks will lead to data unavailability (and if
single chunk was metadata, it could lead to complete loss of access to
filesystem). I do not know if this was ever fixed.
