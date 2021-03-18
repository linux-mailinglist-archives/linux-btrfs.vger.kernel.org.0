Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3A340F5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 21:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhCRUpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 16:45:03 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFDC06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 13:45:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v70so674939qkb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zt6FXE2GUaSt25ghGaLjXOkSk6250xWlf4px6lxFTjs=;
        b=BEt2TMMtFX2zfoHXZuY9o5x8paN9YiLOqRpeuS5vG7WFXhIHSeHfv3TCdt0r9D7rVX
         aHpwgWsb41qpU2YKOQ+g87zO/pk0hRn7SeretKyNOsMtWPmPAJ1mRGLKW9GpfSF0xH2l
         qX0AdEEIIXrqIPLH+SN9iCOATCQrhRzVflXwt1CiJ6qbspifK6tItBNznKgrwSD2sfB4
         FKDuJvedogzr8kqvKXS5c0XMvFhtJviOeTZB3bXvFYy2PJ2mlOdIvIqqUHs8egMy5iHv
         /CL3aFDYj6a+ZdKkc6fOxSXALv7+HjP8rzuS0a3R2QBqX8daK8EhG85ofQdyyziBYQGu
         tjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zt6FXE2GUaSt25ghGaLjXOkSk6250xWlf4px6lxFTjs=;
        b=La2XUg90snDhJCDmb/dweSu6ToWmSWWPh0UBZ/2vTLDXFfYGwN8f0QknEUPK8617Af
         Ns21dB+VIaodl49fy47RiIQOXUc8Y2S13ubjQEun98kwS6cb6qxbWRjPmGaPxmiD9P7d
         oTD5kv22Zfp3awVFiqKanqR/ATgNevDgK6T5x3Io2rabeUG1SywO1stLfuGeHtEu7Azc
         KJTbSMW+XLVA+1HbQmxv88nsGD4Q4WyWlJJQ7Gc3xiE89ZTmbYtB0xdenrwerWipYSik
         1jlolcRhVaxQjeiEvWrkUktNVL+Tzjy/uRjzqY+gOdElJzBDLRseg0jPrS3Wb6yN16dC
         1D6Q==
X-Gm-Message-State: AOAM530tMjZs7MFWkg1DFMmoUe6MLjcpv0d+16DfgShvmQya91Z8BxWH
        E1sDFl/sW8gI7c6lud1sGLyydQ==
X-Google-Smtp-Source: ABdhPJyS6vbHGfvi/YUfHc0Z1GvINpLYLAfrkYQw9ehKZu8JeL7EUXZijuDdVSgPdDXChlUVTpzAfw==
X-Received: by 2002:a37:6887:: with SMTP id d129mr6310565qkc.252.1616100302819;
        Thu, 18 Mar 2021 13:45:02 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x36sm2314272qte.1.2021.03.18.13.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 13:45:02 -0700 (PDT)
Subject: Re: [PATCH 0/3] Handle bad dev_root properly with rescue=all
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1615479658.git.josef@toxicpanda.com>
 <20210318154351.GX7604@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <80e729e7-8fc5-d083-0640-7eedc7b96b6b@toxicpanda.com>
Date:   Thu, 18 Mar 2021 16:45:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318154351.GX7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/18/21 11:43 AM, David Sterba wrote:
> On Thu, Mar 11, 2021 at 11:23:13AM -0500, Josef Bacik wrote:
> [...]
> 
>> rescue=all working without panicing the machine,
>> and I verified everything by
>> using btrfs-corrupt-block to corrupt a dev root of a file system.  Thanks,
> 
> We need to have such testing part of some suite but it depends on the
> utilities that we don't want to ship by default. Last time we discussed
> how to make btrfs-corrupt-block or similar available in source form in
> fstests it was not pretty, like having half of the btrfs-progs sources
> providing code to read and modify the data structures.
> 
> So, what if: we have such tests in the btrfs-progs testsuite. As they're
> potentially dangerous, not run by default, but available for easy setup
> and test in a VM. The testsuite can be exported into a tarball, with the
> binaries included. Or simply run it built from git, that works too just
> needs more dependencies installed.
> 
> I was thinking about collecting all the stress tests into one place,
> fstests already has some but my idea is to provide stress testing of
> btrfs-specific features, more at once. Or require some 3rd party tools
> and data sources to provide the load.
> 
> It would be some infrastructure duplication with fstests, but lots of
> that is already done in btrfs-progs and I'd rather go with some
> duplication instead of development-time-only testing.
> 

I actually had Boris working on this, basically allow us to set 
BTRFS_CORRUPT_PROG inside our fstests config, and then allow us to write these 
tests for fstests.  I'd prefer to keep this inside xfstests for mostly selfish 
reasons, it's easier for me to adapt the existing continual testing to take 
advantage of this and automatically run the xfstests stuff and post the results. 
  If we keep it in btrfs-progs I have to write a bunch of code to run those to 
post the results to our continual testing stuff.  Thanks,

Josef
