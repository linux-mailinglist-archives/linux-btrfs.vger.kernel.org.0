Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC87F2333BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 16:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgG3OCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 10:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgG3OCp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 10:02:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56AFC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 07:02:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so20345080qtm.10
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LBnryPIOKowPsSeEWGc3rPMrqu/rbRGoANoLbmM4I4M=;
        b=cUW+Ja0Z5StFQ6X2SBozCZ6baUC8JYh4GYY2UhfSaWh1GCYy6sfnZuiPcWYK8hy3Mq
         WwJ2XJpTEl88ShOF8OpBdnB0zvijlMwK0SjJSMqx13c432A6fVvuppzsjRLtn+8LDPyC
         2AcyG36XRE/an0sdimrafimi3MDRV0O7HNFkbiqqTJq42O64NXAMR9Dxp7yF9F9bDzi/
         iXw6tJG+RH4TXHtdy/fx5x11RbLZ+wakfxjMIWGE1pNJOt01UrZKTHNTQKv+3PzRfJva
         DxldCy6zcw7HHvB4wdwLyvJPprYBfIzlUXBu/f91kvnFs9fo8kvxYjzcT5GZ/UMOvFlr
         aY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LBnryPIOKowPsSeEWGc3rPMrqu/rbRGoANoLbmM4I4M=;
        b=K0R/TEcMHDw1cN3uxUjZO18RYnLlx1SkS+RGjO0NmYvBK+ZJe/2U7AprRyBi+Euo3p
         YJ6whqrl6elzjKjOIx6weRKtPB5c5sQu0xGvju5lF+bZC9XguKFanCiIknoAe0i72wmF
         02bJNSo4yOwr/pmM05T7LqCTHBwaV0hcNxy1A8b4H+4pBGB7GC0eC6m6KtZCXIby2vjg
         WaRSnEgsLpvc4djnAhPHaeUw2yEBH2THkeL3m9DhdF0G06rIt8CUU3YafnTxbbeNJlI/
         GhneyDnjILIZsOy8RJKMkDJGEtKyddDmWntfQPu5vpLLAaBGAOH31+tSVNnmMFv16iXt
         J/rw==
X-Gm-Message-State: AOAM5320glsbj7OIDD32hUBGXxDx9dsfnGe3i8oLzHHBYPHS2YB+rK+g
        WwPvfAiZrC063tXcuKyo0WPV7w==
X-Google-Smtp-Source: ABdhPJxvouxIcR8KC/PR7eRc9mju24Ha5ZaGQvkP+z/uCCsEm+ssJd2+OYcYIAIysOoMDTBofM+1rg==
X-Received: by 2002:ac8:4b78:: with SMTP id g24mr3106972qts.248.1596117763851;
        Thu, 30 Jul 2020 07:02:43 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w32sm2868158qtw.66.2020.07.30.07.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 07:02:42 -0700 (PDT)
Subject: Re: [PATCH][v3] btrfs: only search for left_info if there is no
 right_info
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200727142805.4896-1-josef@toxicpanda.com>
 <20200728144346.GW3703@twin.jikos.cz>
 <CADkZQam9aJgNYy6bUXREYtS_fv1TLqyHbmkvs+aX9087AM62+g@mail.gmail.com>
 <e7370ce1-a799-3307-cfa3-f1a660d308c2@toxicpanda.com>
 <20200729161344.GB3703@twin.jikos.cz>
 <0c64dfd6-7846-babe-b7d2-12decddce4cc@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <154a35f8-9a21-371c-1afa-ccf2e90ef316@toxicpanda.com>
Date:   Thu, 30 Jul 2020 10:02:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0c64dfd6-7846-babe-b7d2-12decddce4cc@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/30/20 7:42 AM, Qu Wenruo wrote:
> 
> 
> On 2020/7/30 上午12:13, David Sterba wrote:
>> On Wed, Jul 29, 2020 at 11:43:40AM -0400, Josef Bacik wrote:
>>> On 7/29/20 11:42 AM, Sebastian Döring wrote:
>>>> For reasons unrelated to btrfs I've been trying linux-next-20200728 today.
>>>>
>>>> This patch causes Kernel Oops and call trace (with
>>>> try_merge_free_space on top of stack) on my system. Because of
>>>> immediate system lock-up I can't provide a dmesg log and there's
>>>> nothing in /var/log (probably because it immediately goes read-only),
>>>> but removing this patch and rebuilding the kernel fixed my issues. I'm
>>>> happy to help if you need more info in order to reproduce.
>>>>
>>>
>>> Lol I literally just hit this and sent the fixup to Dave when you posted this.
>>> My bad, somehow it didn't hit either of us until just now.  Thanks,
>>
>> Updated misc-next pushed, for-next will follow.
>>
> I guess it's still not working...
> 
> The latest commit 2f0cb6b46a28 ("btrfs: only search for left_info if
> there is no right_info in try_merge_free_space"), shows it's now the
> updated one.
> 
> But still fails at selftest:
> https://paste.opensuse.org/41470779
> 
> Have to revert that commit to do my test...
> 

I'm looking at misc-next and the commit is

c5f239232fbe749042e05cae508e1c514ed5bd3c

Do you have a

struct btrfs_free_space *left_info = NULL;

in your tree?  Thanks,

Josef
