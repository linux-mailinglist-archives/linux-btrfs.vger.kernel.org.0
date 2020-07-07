Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9F216ECC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGGObg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgGGObf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 10:31:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52ADC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 07:31:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w34so11815004qte.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nte7Nvng/9dmXa3SYocfD7frGbO9vhAiCZXPeLioQ2M=;
        b=09/Lpw9vJx2UPbg1hImGpdnKTbfbutKb+CBXF3BHjkNOEgpVHJqLHroCXtHF87qFDN
         dANZJx6zlKPOzI4YrnulnpqaD4MKJN6vuMmkYxZAFIG1NngsN/pMifvgr/CR3MbwzRg6
         x/Q/HuJApT/zFq8TBG1D/syw4/qG29JVSFcb5hoa6Dl7MLHZ7dgY9MwexvL3jB8Af4Hc
         GhfgW9L/23Ih5Pp1jDyVe+3EwoIezpeJ3HcKkqUXqBLB9b6e+FmX3QsjkUvruOjXXO8u
         IbECIP3i/y/KfcFv7jCd/OsPuAGUErAT7TPWMLj0/+EV/bec7NwWeh9PTv21i3Z9r66h
         YY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nte7Nvng/9dmXa3SYocfD7frGbO9vhAiCZXPeLioQ2M=;
        b=iPFuArIyaVEejfZuJYJmQoWGZ91QNWs4WJVb5s0YUjA5HP9EQl46r/yGWC+KucdwYs
         xJI2IcdlwzVdtwII4E2SqKs4lxPihodDXQ9gnl+art+AGeijVYqBBErmn3hBN5YsS3cr
         qn1ZNCR3B7KDQr0GUowGApiHnb80qCjMbCc2oAu9bzQbwhI5VIo1WXycjTudMX3qxB49
         pW1F6U6qc9sS2JRo5ZhJQimNifHPwjlRMVs1O4JxY1eHEcnpTHWxXGcim/H4XhOSfJ1d
         SDF2LlDFTpjpNwRMAAK5d0UpxAtd8JOikVwCFFNKukxVn7RA78EMbA30/LpU0fNVDsPj
         6YZg==
X-Gm-Message-State: AOAM533BX2vWM7j/Xr8lF2GsVarAcTijj2lJPOJ1Y9obK7Nb3VjBFlJu
        mqKX1wcimVlYUTsAojUlp8ADSZd/0zc1Dw==
X-Google-Smtp-Source: ABdhPJwtJd3TQgBmXEdTu61GUicu8u8gTlmwVszugw1Lmsza3xEdJp9MXQajD5uvzOzngp6BdvQLKA==
X-Received: by 2002:ac8:197b:: with SMTP id g56mr33914459qtk.105.1594132294605;
        Tue, 07 Jul 2020 07:31:34 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b53sm27478377qtc.65.2020.07.07.07.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:31:33 -0700 (PDT)
Subject: Re: 5.6 pretty massive unexplained btrfs corruption: parent transid
 verify failed + open_ctree failed
To:     Marc MERLIN <marc@merlins.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200707035530.GP30660@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <01af6816-b0ee-20fa-5e00-0bfeef60cd88@toxicpanda.com>
Date:   Tue, 7 Jul 2020 10:31:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707035530.GP30660@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/6/20 11:55 PM, Marc MERLIN wrote:
> I'd love to know what went wrong so that it doesn't happen again, but let me know if you'd like data off this
> before I wipe it (which I assume is the only way out at this point)
> myth:~# btrfs check --mode=lowmem /dev/mapper/crypt_bcache0
> Opening filesystem to check...
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> Ignoring transid failure
> leaf parent key incorrect 7325633544192
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> 
> 
> I did run bees on that filesystem, but I also just did a full btrfs check on it, and it came back clean:
> 
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/crypt_bcache4
> UUID: 36f5079e-ca6c-4855-8639-ccb82695c18d
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> No device size related problem found
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 18089211043840 bytes used, no error found
> total csum bytes: 17580412652
> total tree bytes: 82326192128
> total fs tree bytes: 56795086848
> total extent tree bytes: 5154258944
> btree space waste bytes: 13682108904
> file data blocks allocated: 24050542804992
> 
> 
> I then moved it to the target machine, started a btrfs send to it, and it failed quickly (due to a mistake
> I had an old btrfs binary on that server, but I'm hoping most of the work is done in kernel space and that the user space
> btrfs should not corrupt the disk if it's a bit old)
> 
> myth:/mnt# uname -r
> 5.6.5-amd64-preempt-sysrq-20190817
> 
> Soon after, the copy failed:
> [ 2575.931316] BTRFS info (device dm-0): use zlib compression, level 3
> [ 2575.931329] BTRFS info (device dm-0): disk space caching is enabled
> [ 2575.931343] BTRFS info (device dm-0): has skinny extents
> [ 2577.286749] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0

You have a corrupt counter here at mount time, does your logs go back far enough 
to see where those came in?  Thanks,

Josef
