Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3F3DCAAD
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Aug 2021 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhHAH5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhHAH5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 03:57:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71141C06175F
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Aug 2021 00:57:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z2so27812337lft.1
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Aug 2021 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=W+WnyGY0GNK79w6omHBYlaJrxMIidMH/+5hwiltXL7M=;
        b=KMBzzrkphHeCRJGuJ6+TkJV5/nVxZcYBd5RQS4wtnynxnaFYPYPT5JoHjUoArPZkJm
         8bLz1/SB318mI064ESKZF1IntI7NfoaW9Z/PNSyFefqDTriCRxPcr2pbB/DeDXpldv8f
         wYBg4kVdzJfnYqGeia9uB9yptG/vlLDwqn5biz3cgoGWbFB02qil1ca/4v+nHma1KFmK
         jRGQUOVuPf+4kI+FgA5IZcqpJHYs24SexBf0DUBMb5Qvsw2XCpTPQaKeeO0q59ezMCmQ
         iHWcc+MF/lO3v+MUmiT4INCUpwdgPBs617gyaS65aRKxo7TDbBme204HI8FubVqFSmZW
         qqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+WnyGY0GNK79w6omHBYlaJrxMIidMH/+5hwiltXL7M=;
        b=MUORb2Q8n31AMtsyz9Syc4I8YOvxYAbst3nNuOTWW3ds570F0uTDnT6wiSS7gOnMbG
         Bcto1VeVwykKo447QghjR3CBTYyIUXtbpLBigsEBb3hY4whnrIqHKvkgwRL048WDdiGO
         T1oykzYDbsaflV2TBKA4imYxLabzZAS/fKFBSt3uCQhtoO8Xyoyod5OABnKVdiykEoN/
         8IgBmVeafe55CIttbPLGYdP7/ZN+7Qiw5KYf9k4EBuHAFrFK/Bg44UfE8DcwCRiM0yJw
         nsNpl7N/ypEXWG0jMGASuH7JT0eiJVFiUWui/MYUN4iJ5axJL06WrOKxeo0Zx2OVzEF7
         VXlg==
X-Gm-Message-State: AOAM5312cOugV+sFvqaSD1YbO85hOTilVqIY49AbwU8GrL7WspK/y7iP
        OWqKXWu62+urzixBgW0RR3rORF5WoVo=
X-Google-Smtp-Source: ABdhPJx2SC/noyHmNCV3GjYAxM+UUgH7hGOL63bThoPApsewQRUsC7tCmqRHOZnjKV/8zCDtUSLDYQ==
X-Received: by 2002:a05:6512:e95:: with SMTP id bi21mr8305832lfb.219.1627804661408;
        Sun, 01 Aug 2021 00:57:41 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:8c8a:31bb:abfc:e015:a7fa? ([2a00:1370:812d:8c8a:31bb:abfc:e015:a7fa])
        by smtp.gmail.com with ESMTPSA id b13sm551462ljq.53.2021.08.01.00.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 00:57:40 -0700 (PDT)
Subject: Re: inconsistent send/receive behavior
To:     john terragon <jterragon@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CANg_oxz7cDq4J4EPWb58A9Kz_Rb9W279pRW=j3OTRvps-aLvzw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <928b6090-b495-95fe-8b8c-a33293550e45@gmail.com>
Date:   Sun, 1 Aug 2021 10:57:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANg_oxz7cDq4J4EPWb58A9Kz_Rb9W279pRW=j3OTRvps-aLvzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01.08.2021 10:19, john terragon wrote:
> Hi.
> Let's consider the following send/receive example
> 
> -two btrfs FS /btrfsA /btrfsB
> -one subvol vol in /btrfsA
> -btrfs sub snap -r vol vol1_RO
> -btrfs send /btrfsA/vol1_RO | btrfs receive /btrfsB
> -then, in /btrfsB:
>       btrfs sub snap vol1_RO vol
> -do some work on /btrfsB/vol
> -then in /btrfsB:
>       btrfs sub snap -r vol vol2_RO
> -then from /btrfsB:
> -btrfs send -p vol1_RO vol2_RO | btrfs receive /btrfsA
> 
> So, the initial seeding is from btrfsA to btrfsB and then there is an
> incremental send "in reverse" from btrfsB ro btrfsA.
> 
> Is something like this supposed to work?
> 

No. /btrfsB/vol does not exist on /btrfsA, so any reference to
/btrfsB/vol cannot be resolved on /btrfsA.

> Because I've got cases in which it seems to work (no error or data
> loss that I can see) and cases in which the "reverse incremental send"
> does send stuff back for a while and it creates the vol2_RO subvolume
> but then it ends up throwing an
> 
> ERROR: clone: did not find source subvol
> 
> So, it does not say that immediately at the start. It seemingly does
> all the work before complaining.
> And the resulting vol2_RO in btrfsA seems to be OK.
> du /brtfsA/vol2_RO reports a size that's close to the one of /brtfsB/vol2_RO.
> And df reports that /brtfsA/vol2_RO seems to be using a fraction of
> its reported size by du.
> 
> So, at the very least, even if this "reverse incremental send" is not
> supposed to work in btrfs, there is inconsistent behavior of the FS
> and/or the btrfs tool.
> 

btrfs send builds stream incrementally. It does not really know that it
will need reference to /btrfsB/vol until it actually sees this part. So
btrfs receive cannot verify whether it will fail. It processes input
stream as far as it can - this will be data unchanged between
/btrfsB/vol1_RO and /btrfsB/vol.
