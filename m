Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB63FDEBF
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbhIAPfs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbhIAPfr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 11:35:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF4C061575
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 08:34:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s10so7185499lfr.11
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vrg8aqHkw1KISY9lPYCUpjyiMtgkqHx6nEqcxYGDCUw=;
        b=nQDUTx+J6thberegnbAQDX6AzVJstCsV2A+JmPmqa3039XuCHgQ2GG88eh0DyyBgnl
         nrroegCQgKC3TvOK1t4t/G1MB17JSD++/3hGFHdlwPnWfck6/rmfYkLEFl/pH5avZbm/
         7IKPh11Y2U2uO/bgarf3FaiAFgvDbVYYaA8S1HzVY0JSBDU2REU1XP5f5RzO44uajujF
         XkaR7AIzU8AbLfcIXnNL1fPuInr3oSAS2ugJ4He6zcjEv3lkkjGgrjsIdszghWZvNp+m
         97KgYv8UP7X4bsTDGVV8gfmBsNR5vjpJvYRszRitrHh16ZMndieioktn6Gdn2e3efIhY
         v5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vrg8aqHkw1KISY9lPYCUpjyiMtgkqHx6nEqcxYGDCUw=;
        b=dwORIiBhoduerFRUcD34MCA8EfhIAUqR4xZyaysuxQZHQ4Pk3CrpAomfb4vByPohlH
         5XbCAHTeIoX/PieFfuK0ziHrfeGANixS3ag6AXd/Jm+kbP4jbKSqAuTBruHRWrN6XJ5q
         gJAqQy8KWp0CkCAZnvw4IN1eCrxpH4Z05O66W5EaupqIkp4X4QZvNQpqe/DB2YF5y6Sc
         HDctpJ16HiPNQYeJOkY5Ku/D6VpuC7K8zx2zfyC6ypt08xGyOEeq7cRQe/aJrt79VAo9
         i9/e3PdCUdvaIT/VdKSvkOvnjSl1tzmt1SwHsJwevIMFzOaRuos8p8vfBFyDtuOwDiJW
         vUCw==
X-Gm-Message-State: AOAM530JDDp0iGQpKk0GeDYa7wo0pPHeQ+hi8hPHunis0yx5u7ri+DFn
        ys3IM9Xc1JKYJHAzsKFa4GVJcZOrZzQ=
X-Google-Smtp-Source: ABdhPJxKIk3LqGon+kLMXVKf20RsCsuUjsMxLhGdxsu1MfVVHQt3Tbd59IL42SJ+LSVvdwVZ/fCaBA==
X-Received: by 2002:ac2:530d:: with SMTP id c13mr26260145lfh.445.1630510488531;
        Wed, 01 Sep 2021 08:34:48 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:8deb:5c9c:cef9:590c:9452? ([2a00:1370:812d:8deb:5c9c:cef9:590c:9452])
        by smtp.gmail.com with ESMTPSA id v14sm3315lji.32.2021.09.01.08.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 08:34:48 -0700 (PDT)
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com, Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
 <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
 <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com>
 <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
 <CAL3q7H7vTFggDHDq=j+es_O3GWX2nvq3kqp3TsmX=8jd7JhM1A@mail.gmail.com>
 <CAOaVUnW6nb-c-5c56rX4wON-f+JvZGzJmc5FMPx-fZGwUp6T1g@mail.gmail.com>
 <CAL3q7H6h+_7P7BG11V1VXaLe+6M+Nt=mT3n51nZ2iqXSZFUmOA@mail.gmail.com>
 <CAL3q7H5p9WBravwa6un5jsQUb24a+Xw1PvKpt=iBdHp4wirm8g@mail.gmail.com>
 <CAOaVUnXDzd-+jvq95DGpYcV7mApomrViDhiyjm-BdPz5MvFqZg@mail.gmail.com>
 <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <7a858635-2491-cccd-0a29-d1a1d0c9d313@gmail.com>
Date:   Wed, 1 Sep 2021 18:34:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01.09.2021 17:50, Filipe Manana wrote:
> On Tue, Aug 31, 2021 at 5:48 PM Darrell Enns <darrell@darrellenns.com> wrote:
>>
>> It's btrfs-progs v5.13.1. Debug logs are attached.
> 
> Ok, now I see what's going on.
> 
> Somehow you have at least two snapshots (with IDs 881 and 977 on the
> send filesystem), that have the same 'received_uuid' -
> e346e5a1-536c-8d42-ba33-c5452dec7888.
> So these snapshots were received from some other filesystem in the past.
> 

Is there any reason "btrfs receive" does not show actual id of subvolume
used as clone source in its log messages?
