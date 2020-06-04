Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0941EE51A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 15:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFDNP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgFDNP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Jun 2020 09:15:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C7C08C5C0
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jun 2020 06:15:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q14so5104266qtr.9
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jun 2020 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PsD9h/V6jGXoZUfanBTk9ilms99vPY910w/2i0L9ryw=;
        b=tYMt3jWqk6l8mzIRY76PWBnHVPTKXxhFW6rpr/4Dbn3d+u1TgWy/CE7n97nHAb9MLF
         Uffy7SwGdAzj08N7KXfdZGg1tBxe5frVwT2VQgNAvNu3cVo/nJ5u8EBiuu9tR+RvQzfM
         FRQ2IbOjMnAaAnHxXPXfnV0J8Wd+WNPIQPxS5Nf4iU3nVz+Do5pIk7BhrNQ3zOxXgOkx
         XuuNLXXAbcZm750aEim4zfwthJtnonDqu4/Ff72ermtymIdwcwMYfjZjowb14xUUfSzW
         iXeGgMQzDnYSmueCiMVnF3m4SgSgmitMxTcPVlJ7XTE8QCCwPYuvMnxE++60YRFDIPg4
         Ey2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PsD9h/V6jGXoZUfanBTk9ilms99vPY910w/2i0L9ryw=;
        b=f+tafZcDuB7ozii1t2bN5MaPNcnYsnFl5FEtMfyAF5i+ib6b1qOn7KoKaCsH1eRHqb
         nUt9gUeWB3SWTYlAujnvxiJBAVxm18g24oHUsGaq0dqAhVChgRkmrGP162AHIBq33ltw
         bTFLqNHF2b84aCYBkHdSvZdOU6F0hAgPuD6B8wwUB80oBJJTxlJmB5R5CE/lY6YwxsgD
         rLv0/QQD5JD9tDFqP0xQ3GHmMmzP+tuN015VzR3EhWFMKzaoavyB/nWirbn6mUHDfsA8
         nvCm5y75T9N+vkDR39frN0Yp2OOf91nna5YywovJhFRexWBp4awh1Z0KPMNb5K8kMGtQ
         +YUA==
X-Gm-Message-State: AOAM533iCWGnzOQQuF71QJ27tz956gvu2BAehbbMXsnwx9TdtIQUp1mm
        dI2M5vMihBrwOZMTU+VqIV/JXhfzp9dgWw==
X-Google-Smtp-Source: ABdhPJw7iOJSAttjhkToxWXWEgUFF27yOY45/+lfDfdTHwerRzOLeaLIZHi09sloAMsoXaARn0G+Hg==
X-Received: by 2002:ac8:35fd:: with SMTP id l58mr4476902qtb.324.1591276557413;
        Thu, 04 Jun 2020 06:15:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1051? ([2620:10d:c091:480::1:c550])
        by smtp.gmail.com with ESMTPSA id z60sm4852153qtc.30.2020.06.04.06.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 06:15:56 -0700 (PDT)
Subject: Re: [PATCH v7 1/2] btrfs: Introduce "rescue=" mount option
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4d18c631-6bb0-066b-c0d1-4b2e8524e2ef@toxicpanda.com>
Date:   Thu, 4 Jun 2020 09:15:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200604071807.61345-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/4/20 3:18 AM, Qu Wenruo wrote:
> This patch introduces a new "rescue=" mount option group for all those
> mount options for data recovery.
> 
> Different rescue sub options are seperated by ':'. E.g
> "ro,rescue=nologreplay:usebackuproot".
> (The original plan is to use ';', but ';' needs to be escaped/quoted,
> or it will be interpreted by bash)
> 
> And obviously, user can specify rescue options one by one like:
> "ro,rescue=nologreplay,rescue=usebackuproot"
> 
> The following mount options are converted to "rescue=", old mount
> options are deprecated but still available for compatibility purpose:
> 
> - usebackuproot
>    Now it's "rescue=usebackuproot"
> 
> - nologreplay
>    Now it's "rescue=nologreplay"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
